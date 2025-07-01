/*****************************************************************
 *  CONFIG TEMPORELLE
 *****************************************************************/
tCurrent(5000).
tLimit('access',   1000).
tLimit('erase',    1000).
tLimit('storage',  1000).

/*****************************************************************
 *  (C-1) CONSENT ABSENT — Eve
 *****************************************************************/
wasControlledBy('createAccount','Eve','owner',50,51).
wasGeneratedBy('phoneNumber_Eve_1','createAccount','personal data',51).

wasControlledBy('sendAdSMS','DC','owner',60,62).
used('sendAdSMS','phoneNumber_Eve_1','user phone number',61).
% → aucun consentement pour Eve : violation « no consent »

/*****************************************************************
 *  (C-2) CONSENT MAUVAIS OBJET — David
 *****************************************************************/
wasControlledBy('createAccount','David','owner',1,2).
wasGeneratedBy('phoneNumber_David_1','createAccount','personal data',2).

wasControlledBy('consent','David','owner',3,4).
wasGeneratedBy('consent_David_1','consent','consent',4).
purposes('consent_David_1','phoneNumber_David_1',['buyItem']).   % n’autorise PAS sendAdSMS

wasControlledBy('sendAdSMS','DC','owner',22,24).
used('sendAdSMS','phoneNumber_David_1','user phone number',23).
% → finalité « sendAdSMS » hors consentement : violation

/*****************************************************************
 *  (A-1) ACCESS — Alice (jamais répondu)
 *****************************************************************/
wasControlledBy('createAccount','Alice','owner',1,2).
wasGeneratedBy('phoneNumber_Alice_1','createAccount','personal data',2).

wasControlledBy('consent','Alice','owner',3,4).
wasGeneratedBy('consent_Alice_1','consent','consent',4).
purposes('consent_Alice_1','phoneNumber_Alice_1',['sendAdSMS']). % OK (mais pas utilisé ici)

wasControlledBy('askDataAccess','Alice','owner',14,15).
wasGeneratedBy('data_request_Alice','askDataAccess','request',15).
% → aucun sendData : délai dépassé

/*****************************************************************
 *  (A-2) ACCESS — Bob (trop tard)
 *****************************************************************/
wasControlledBy('createAccount','Bob','owner',1,2).
wasGeneratedBy('phoneNumber_Bob_1','createAccount','personal data',2).

wasControlledBy('consent','Bob','owner',3,4).
wasGeneratedBy('consent_Bob_1','consent','consent',4).

wasControlledBy('askDataAccess','Bob','owner',24,25).
wasGeneratedBy('data_request_Bob','askDataAccess','request',25).

wasControlledBy('sendData','DC','owner',1064,1066).
used('sendData','data_request_Bob','data request received',1065).
wasGeneratedBy('data_report_Bob','sendData','data response',1066).
% → 1066-25 = 1041 ms > 1000 ms

/*****************************************************************
 *  (E-1) ERASE — Alice (jamais exécuté)
 *****************************************************************/
wasControlledBy('askErase','Alice','owner',26,28).
used('askErase','phoneNumber_Alice_1','to erase data',27).
% → pas de delete

/*****************************************************************
 *  (E-2) ERASE — Bob (trop tard)
 *****************************************************************/
wasControlledBy('askErase','Bob','owner',36,37).
used('askErase','phoneNumber_Bob_1','to erase data',37).

wasControlledBy('delete','DC','owner',2060,2062).
used('delete','phoneNumber_Bob_1','erase data',2061).
% → 2062-37 = 2025 ms > 1000 ms

/*****************************************************************
 *  (S) STORAGE — données jamais effacées ni anonymisées
 *      (5000 – lastUse > 1000)
 *****************************************************************/
% Compte David
wasGeneratedBy('bankAccount_David_1',   'createAccount','personal data',2).
wasGeneratedBy('mail_David_1',          'createAccount','personal data',4).
wasGeneratedBy('name_David_1',          'createAccount','personal data',5).
wasGeneratedBy('physicalAddress_David_1','createAccount','personal data',6).
wasGeneratedBy('id_David_1',            'createAccount','personal data',7).

% Dernières utilisations explicites
used('sendAdSMS','phoneNumber_David_1','user phone number',23).  % lastUse 23
used('sendAdSMS','phoneNumber_Eve_1','user phone number',61).    % lastUse 61

/*****************************************************************
 *  DICTIONNAIRE DES ACTIONS
 *****************************************************************/
action('sendData',                 'sendData').
action('updateData',               'updateData').
action('sendAdSMS',                'sendAdSMS').
action('createAccount',            'createAccount').
action('consent',                  'consent').
action('delete',                   'delete').
action('askDataAccess',            'askDataAccess').
action('askErase',                 'askErase').

/*****************************************************************
 *  FINALITÉS PAR DÉFAUT
 *****************************************************************/
purposes(_,_,['consent','delete','askErase','sendData','askDataAccess',
              'updateConsent','accessWebPage','updateData',
              'createAccount','login']).
