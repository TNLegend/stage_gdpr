# GDPR Compliance checking tool

Outil d’analyse RGPD qui :

* **charge** des graphes d’événements écrits en **Prolog**,
* **importe** ces faits dans **Neo4j 5.21.0** (schéma *Artifact/Process/Agent*),
* **exécute** des contrôles de conformité par **règles Prolog** *ou* par **requêtes Cypher**,
* **exporte** les consentements par finalités vers **Prolog**.

Interface graphique : **JavaFX** (`Interface.ter.AppLauncher`).
Pile : **JDK 19+**, **Maven**, **Neo4j 5.21.0**, **SWI-Prolog + JPL**.

---

## Table des matières

* [Prérequis](#prérequis)

  * [Java & Maven](#java--maven)
  * [Neo4j 5210 — obligatoire](#neo4j-5210--obligatoire)
  * [SWI-Prolog + JPL](#swi-prolog--jpl)
* [Installation & build](#installation--build)

  * [Cloner le projet](#cloner-le-projet)
  * [Construire](#construire)
  * [Lancer l’IHM](#lancer-lihm)
* [Connexion à Neo4j](#connexion-à-neo4j)
* [Structure du projet](#structure-du-projet)
* [Format des données Prolog](#format-des-données-prolog)
* [Ce que fait l’appli côté Neo4j](#ce-que-fait-lappli-côté-neo4j)
* [Contrôles RGPD disponibles](#contrôles-rgpd-disponibles)
* [Benchmarks & CSV](#benchmarks--csv)
* [Dépannage (FAQ)](#dépannage-faq)
* [Commandes utiles](#commandes-utiles)
* [Résumé rapide](#résumé-rapide)

---

## Prérequis

### Java & Maven

* **JDK** : 19 ou supérieur (testé avec Corretto 22).
* **Maven** : 3.9+

```bash
java -version
mvn -v
```

### Neo4j **5.21.0** — obligatoire

* Utilisez **exactement** Neo4j **5.21.0** (aligné avec le driver utilisé par l’app).
* Instance locale (Desktop ou serveur).
* Base active **`neo4j`** (c’est le nom ciblé dans le code via `QueryConfig.withDatabase("neo4j")`).
* Paramètres par défaut :

  * **URI** : `neo4j://127.0.0.1:7687`
  * **User** : `neo4j`
  * **Password** : votre mot de passe

> **Astuce** : si votre base ne s’appelle pas `neo4j`, créez-en une avec ce nom ou adaptez le code.

### SWI-Prolog + JPL

* **SWI-Prolog** 9.x (64-bit).
* **Windows**

  * Installez SWI-Prolog (ex. `C:\Program Files\swipl`).
  * Ajoutez au **PATH** : `C:\Program Files\swipl\bin`
  * (Optionnel) **SWI\_HOME\_DIR** : `C:\Program Files\swipl`
* **macOS/Linux**

  * Installez via package manager/dmg.
  * Assurez-vous que `swipl` est dans le **PATH**.

> Le projet Maven embarque **JPL** (Java) ; la partie native vient de votre installation SWI-Prolog.

---

## Installation & build

### Cloner le projet

```bash
git clone <URL-DU-REPO> gdpr-provenance
cd gdpr-provenance
```

### Construire

```bash
mvn clean install
```

Le `pom.xml` fournit JavaFX 19, le driver Neo4j **5.21.0**, JPL, etc.

### Lancer l’IHM

```bash
mvn javafx:run
# Lance la classe Interface.ter.AppLauncher
```

> **IDE** : ouvrez le projet Maven dans IntelliJ, puis exécutez `Interface.ter.AppLauncher`.

---

## Connexion à Neo4j

1. Démarrez Neo4j **5.21.0**.
2. Dans l’IHM :

   * **URI** : `neo4j://127.0.0.1:7687`
   * **User** : `neo4j`
   * **Password** : votre mot de passe
3. Cliquez **Connect**.
   L’appli crée/valide les index utiles.

---

## Structure du projet

```
src/
├─ main/java/
│  ├─ GraphDB/
│  │   ├─ Neo4jInterface.java        # Connexion, index, exécution Cypher
│  │   ├─ PrologToGraphDB.java       # Import Prolog → Neo4j (parsing robuste + fixes)
│  │   └─ GraphDBToProlog.java       # Export consentements vers Prolog
│  ├─ Solver/
│  │   ├─ PrologSolver.java          # Solveur Prolog via JPL (+ logs propres)
│  │   ├─ SolverCypher.java          # Solveur Cypher (aligné Prolog)
│  │   ├─ Measurements.java          # Bench global + bench par principe + CSVs
│  │   └─ testfiles/                 # Graphes .pl + time_*.pl
│  ├─ Interface/ter/
│  │   ├─ AppLauncher.java           # Entrée JavaFX
│  │   ├─ App.java, ScreenController.java, SolveController.java
│  │   └─ ...
│  └─ Traducteur/Converter.java      # Helpers Cypher/formatage
└─ main/resources/
   └─ RGPD/                          # Règles Prolog: legal, erase, access, storage...
```

Jeux d’essai : `src/main/java/Solver/testfiles/**`
(ex. `benchmark/allIssues_graph.pl`, `time_sn_noncompliant.pl`, cas consent/access/erase/storage).

---

## Format des données Prolog

Exemple minimal :

```prolog
wasControlledBy('createAccount','Alice','owner',1,2).
wasGeneratedBy('phoneNumber_Alice_1','createAccount','personal data',2).

wasControlledBy('consent','Alice','owner',3,4).
wasGeneratedBy('consent_Alice_1','consent','consent',4).
purposes('consent_Alice_1','phoneNumber_Alice_1',['sendAdSMS']). % commentaire inline OK

wasControlledBy('askDataAccess','Alice','owner',14,15).
wasGeneratedBy('data_request_Alice','askDataAccess','request',15).
```

Le chargeur **gère** :

* `% ...` en fin/ligne,
* `/* ... */` multi-lignes,
* **commentaires inline** après un fait (même ligne).

Faits supportés : `wasControlledBy/5`, `wasGeneratedBy/4`, `used/4`,
`wasTriggeredBy/4`, `wasDerivedFrom/4`, `action/2`, `purposes/3`, `notAvailable/2`.

Cas particuliers :

* `wasGeneratedBy(_,_, 'personal data', TG)` → marque l’artefact **personal\_data** et lui assigne un **`personal_seq`** stable (ordre de lecture) pour émuler `once/1` côté Cypher.
* `purposes(..., [])` → **liste vide** correctement importée (plus de `['']`).
* `purposes('_', ...)` → géré en **consentement par défaut** (`mandatory_consent` en Neo4j).

---

## Ce que fait l’appli côté Neo4j

**Schéma**

* **Nodes**

  * `(:Artifact {name, type?, category?, personal_seq?, ...})`
  * `(:Process  {name, action?})`
  * `(:Agent    {name})`
* **Relations**

  * `(:Process)-[:used {ctx, TU}]->(:Artifact)`
  * `(:Artifact)-[:wasGeneratedBy {ctx, TG}]->(:Process)`
  * `(:Process)-[:wasControlledBy {ctx, TB, TE}]->(:Agent)`
  * `(:Artifact)-[:wasDerivedFrom {ctx, T?}]->(:Artifact)` (+ fermetures)
  * `(:Artifact)-[:hasPersonalRoot]->(:Artifact)`

**Index conseillés (créés/validés au démarrage)**

```cypher
CREATE INDEX IF NOT EXISTS idx_artifact_name         FOR (a:Artifact) ON (a.name);
CREATE INDEX IF NOT EXISTS idx_artifact_type         FOR (a:Artifact) ON (a.type);
CREATE INDEX IF NOT EXISTS idx_artifact_personalseq  FOR (a:Artifact) ON (a.personal_seq);
CREATE INDEX IF NOT EXISTS idx_process_action        FOR (p:Process)  ON (p.action);
CREATE INDEX IF NOT EXISTS idx_used_tu FOR ()-[u:used]-() ON (u.TU);
```

**Export Neo4j → Prolog (consentements)**

* On **ignore** `name`, `type`, `category`, `consent_type`, …
* On **ne garde** que `*_purposes`, on retire le suffixe et on écrit :

  ```prolog
  purposes('consent_x','phone_bob',['x','y']).
  ```

  (au lieu de `phone_bob_purposes`).

---

## Contrôles RGPD disponibles

Deux moteurs, **même sémantique** (alignée) :

* **LEGAL** (`legal`)
* **RIGHT\_TO\_ERASURE** (`eraseCompliant`)
* **RIGHT\_TO\_ACCESS** (`rightAccess`)
* **STORAGE\_LIMITATION** (`storageLimitation`)

Paramètres temporels via fichiers `time_*.pl` :

```prolog
tCurrent(5000000).
tLimit('storage',3000000).
tLimit('access',43200).
tLimit('erase',57600).
```

---

## Benchmarks & CSV

* Bench **global** et **par principe**.
* Génère :

  * `results.csv` (global),
  * `results_legal.csv`,
  * `results_eraseCompliant.csv`,
  * `results_rightAccess.csv`,
  * `results_storageLimitation.csv`.
* Les identifiants d’issues sont **réinitialisés** à chaque run.

---

## Dépannage (FAQ)

* **SLF4J “NOP logger”**
  Informatif, sans impact.

* **Erreur Cypher “Importing WITH…”**
  Corrigé dans nos requêtes via `CALL { WITH d … }`.

* **Commentaires inline Prolog**
  Supportés (même ligne que le fait).

* **Listes de finalités vides**
  `[]` reste `[]` (plus de `['']`).

* **IDs d’issues qui montent**
  Compteur **reset** à chaque exécution.

* **Prolog/JPL “module not found”**
  Ajoutez le dossier natif `libswipl` au **PATH** (Windows) / `LD_LIBRARY_PATH` (Linux) / `DYLD_FALLBACK_LIBRARY_PATH` (macOS).

* **Auth Neo4j**
  Vérifiez `URI/user/password` : `neo4j://127.0.0.1:7687`, `neo4j`, votre mot de passe.

---

## Commandes utiles

```bash
# Lancer l’IHM
mvn clean javafx:run

# Builder le jar (sans tests)
mvn clean package -DskipTests
```

Nettoyage DB (si besoin) :

```cypher
MATCH (n) DETACH DELETE n;
```

---

## Résumé rapide

1. Installez **Neo4j 5.21.0**, **JDK 19+**, **Maven**, **SWI-Prolog**.
2. Démarrez Neo4j (`neo4j://127.0.0.1:7687`, base **neo4j**).
3. `mvn javafx:run` → se connecter → charger `graph.pl` + `time.pl`.
4. Choisir **Prolog** ou **Cypher** → **Solve**.
5. Résultats identiques Prolog⇄Cypher, CSV par principe, export Prolog corrigé.

---
