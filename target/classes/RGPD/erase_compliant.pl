%	data erasure compliance
writeNoEraseAsked():- writeln('ERASE REQUEST OK - system compliant for data erasure as no erase was asked').
% writeEraseNotCompliant(D,T):- write('ERASE REQUEST ISSUE - erase of data '), write(D), write(' was asked at '), write(T), writeln(' but not done in time').

askErase(D,T,P):- used(P,D,_R,T),action(P,'askErase').
eraseComplete(D,T):- used(P,D,_R,TU),action(P,'delete'),(tLimit('erase',TLIMITERASE),(TU-T)<TLIMITERASE).
eraseNotDoneYet(D,T):- \+ (used(P,D,_R,_TU),action(P,'delete')),(tCurrent(TCURRENT),tLimit('erase',TLIMITERASE),(TCURRENT-T)<TLIMITERASE).

dataErasureOk(D,T):-
	(eraseComplete(D,T),!);
	(eraseNotDoneYet(D,T),!).

eraseCompliant(D,T,P):-
	(askErase(D,T,P),
		(\+ dataErasureOk(D,T)));
	(\+ askErase(D,_T,P), writeNoEraseAsked(), false).