% === Right‑of‑access compliance rules ===
% If no access request was made, we consider the system compliant.
writeNoAccessAsked() :-
    writeln('ACCESS REQUEST OK – system compliant on right‑of‑access as no access was asked').

% -----------------------------------------------------------------------------
%  Utility predicates
% -----------------------------------------------------------------------------

%  Has the legal time‑limit for sending a copy not yet expired?
accessTimeLimitNotOver(_Process, RequestTime) :-
    tCurrent(Current),
    tLimit('access', Limit),
    Current - RequestTime < Limit.

%  Was a valid answer sent in time **after** the request?
rightAccessOk(RequestProcess, Artifact, RequestTime) :-
    % 1. Deadline not yet over → still ok
    accessTimeLimitNotOver(RequestProcess, RequestTime),
    !.
rightAccessOk(_RequestProcess, Artifact, RequestTime) :-
    % 2. A "sendData" process used the same request artifact,
    %    started *after* the request and within the legal window
    wasControlledBy(SendProc, _Subject, 'owner', _TB2, SendTime),
    used(SendProc, Artifact, _Role, _TU),
    action(SendProc, 'sendData'),
    SendTime  >  RequestTime,
    tLimit('access', Limit),
    SendTime - RequestTime < Limit,
    !.

% -----------------------------------------------------------------------------
%  Main rule signalling a violation of the right of access
% -----------------------------------------------------------------------------

rightAccess(Subject, RequestTime) :-
    % A request has been made…
    wasControlledBy(ReqProc, Subject, 'owner', _TB, RequestTime),
    wasGeneratedBy(Artifact, ReqProc, _Role, RequestTime),
    action(ReqProc, 'askDataAccess'),
    % …and no valid answer was found.
    \+ rightAccessOk(ReqProc, Artifact, RequestTime).
rightAccess(_Subject, _RequestTime) :-
    % No request at all → compliant (emit message once, then fail so rule doesn’t succeed)
    \+ ( wasControlledBy(_P, _S, 'owner', _TB, _T),
         wasGeneratedBy(_A, _P, _R, _T),
         action(_P, 'askDataAccess') ),
    writeNoAccessAsked(),
    false.
