% right access compliance (patched)

writeNoAccessAsked() :-
    writeln('ACCESS REQUEST OK - system compliant on right access as no access was asked').

% Window still open?
accessTimeLimitNotOver(T) :-
    tCurrent(TC), tLimit('access', L), TC - T < L.

% Request time = TE of askDataAccess (owner)
request_time(S, P, TE) :-
    action(P, 'askDataAccess'),
    wasControlledBy(P, S, 'owner', TB, TE).

% Request artifact generated during [TB,TE] (relaxed)
request_artifact(P, A) :-
    wasControlledBy(P, _S, 'owner', TB, TE),
    wasGeneratedBy(A, P, _R, TG),
    TG >= TB, TG =< TE.

% OK if window still open...
rightAccessOk(_P, _A, TE) :-
    accessTimeLimitNotOver(TE), !.

% ...or there exists a sendData by the SAME subject that used the request artifact,
% after the request, and within the legal time window.
rightAccessOk(_P, A, TE) :-
    % bind the subject that asked at TE
    request_time(S, _PAsk, TE),
    wasControlledBy(P2, S, 'owner', _TB2, TE2),
    action(P2, 'sendData'),
    used(P2, A, _R, _TU),
    TE2 > TE,
    tLimit('access', L),
    TE2 - TE < L, !.

% Violation: a request exists (TE), there is a request artifact for it,
% and no valid on-time reply was found
rightAccess(S, TE) :-
    request_time(S, P, TE),
    request_artifact(P, A),
    \+ rightAccessOk(P, A, TE).

% No request at all (do NOT require wasGeneratedBy equality)
rightAccess(_S, _TE) :-
    \+ ( action(P, 'askDataAccess'),
         wasControlledBy(P, _S2, 'owner', _TB, _TE2) ),
    writeNoAccessAsked(),
    false.
