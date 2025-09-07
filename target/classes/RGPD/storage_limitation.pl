
% writeStorageLimitationNotCompliant(D,TU):- write('STORAGE LIMITATION ISSUE - data '), write(D), write(' was used at '), write(TU), writeln(' and not deleted in time').

storageLimitationOk(D,TU):-
	(tCurrent(TCURRENT),tLimit('storage',TLIMITSTORAGE),(TCURRENT-TU)<TLIMITSTORAGE, !);
	(notAvailable(D,T),(tLimit('storage',TLIMITSTORAGE),(T-TU)<TLIMITSTORAGE), !).

storageLimitation(D, TU) :-
    used(P,D,_R,TU),
    \+ action(P,'delete'),
    once(isPersonalP(D,DP)),             % <— same semantics as Cypher’s “head(collect(dp))”
    \+ storageLimitationOk(DP,TU).
