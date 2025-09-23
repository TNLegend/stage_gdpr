% =======================
% legal.pl  (optimized, no-cut)
% =======================

% ---- faster membership (avoid nth0/3)
isPurpose(PU, D, C) :-
    purposes(C, D, Q),
    member(PU, Q).

log_default_purposes :-
    setof(PU, default_purpose(PU), L), !,
    format('[Prolog] Default purposes: ~w~n', [L]).
log_default_purposes :-
    writeln('[Prolog] No default purposes found.').

% ---- small "indexes"
:- table owner_proc/1.
owner_proc(P) :- wasControlledBy(P, _S, 'owner', _TB, _TE).

:- table used_consent/2, revoke_event/2.
used_consent(P, C)  :- used(P, C, 'consent', _).
revoke_event(C, T)  :- used(_P, C, 'revokeConsent', T).

:- table used_action/4.
% IMPORTANT: no cut here — we need to enumerate all used/4 matches
used_action(P, D, PU, T) :-
    used(P, D, _, T),
    action(P, PU).

% revoke (public API kept)
revoke(C, T) :- revoke_event(C, T).

% ---- consent path: bind C early (from D,PU)
consent(C, D, PU, T) :-
    isPurpose(PU, D, C),                      % (D,PU) -> C
    wasGeneratedBy(C, P1, 'consent', T),      % C bound
    owner_proc(P1).                            % P1 bound

% ---- cache "next consent"
:- table nextConsent/3.
nextConsent(C, C1, T) :-
    used_consent(P1, C),                      % C -> P1
    wasGeneratedBy(C1, P1, 'consent', T),
    owner_proc(P1).

% also cache lastConsent (called a lot)
:- table lastConsent/1.
lastConsent(C) :-
    consent(C, _D, _PU, _T),
    \+ nextConsent(C, _C1, _TU).

% ---- defaults
writeNoDataUsed() :-
    writeln('CONSENT OK - lawful system as there is no use of any personal data').

default_purpose(PU) :-
    purposes(C, D, L),
    var(C), var(D),
    member(PU, L).

% ---- window check
consentFoundOk(C, D, PU, T) :-
    consent(C, D, PU, TG), TG < T,
    (   nextConsent(C, _C1, TG1), TG1 > T, !
    ;   lastConsent(C),
        (   \+ revoke(C, _), !
        ;   revoke(C, TU), TU > T, !
        )
    ).

% ---- top-level rule
legal(P, D, PU, T, DP, C) :-
    used_action(P, D, PU, T),
    once(isPersonalP(D, DP)),
    \+ default_purpose(PU),
    \+ consentFoundOk(C, DP, PU, T).
