%   consent
isPurpose(PU,D,C):- purposes(C,D,Q), nth0(_X,Q,PU).


consent(C,D,PU,T):- wasControlledBy(P1,_S,'owner',_TB,_TE), wasGeneratedBy(C,P1,'consent',T), isPurpose(PU,D,C).
revoke(C,T):- used(_P,C,'revokeConsent',T).
nextConsent(C,C1,T):- wasControlledBy(P1,_S,'owner',_TB,_TE), used(P1,C,'consent',_TU), wasGeneratedBy(C1,P1,'consent',T).
lastConsent(C):- consent(C,_D,_P1,_T),\+ (nextConsent(C,_C1,_TU)).

%	lawfulness
% writeConsentNotFound(P,D,PU,T):- write('CONSENT ISSUE - process '), write(P), write(' used '), write(D), write(' for purpose '), write(PU), write(' at time '), write(T), writeln(' without consent').
writeNoDataUsed():- writeln('CONSENT OK - lawful system as there is no use of any personal data').

consentFoundOk(C,D,PU,T):-
   (nth0(_X,['consent','delete','sendData','askErase','askDataAccess','createCookie'],PU), !);
   (consent(C,D,PU,TG),TG<T,
      ((lastConsent(C),
         ((\+ revoke(C,_TU), !);
         (revoke(C,TU),(TU>T), !)));
      (nextConsent(C,_C1,TG1),(TG1>T), !)
      )
   ).


legal(P,D,PU,T,DP,C):-
   (used(P,D,_R,T),isPersonalP(D,DP),action(P,PU),
      (\+ consentFoundOk(C,DP,PU,T))
   );
   ((\+ (used(P,D,_R,T),isPersonalP(D,_DP))),writeNoDataUsed(),false).

