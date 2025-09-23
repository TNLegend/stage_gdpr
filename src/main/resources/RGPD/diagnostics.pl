:- module(diagnostics, [diag_legal/0, pd_stats/0]).

% ---- helpers
mcount(Goal, Count) :- aggregate_all(count, Goal, Count).

mtimed(Label, Goal) :-
    statistics(cputime, T0),
    (catch(Goal, E, (print_message(error,E), fail)) -> true ; true),
    statistics(cputime, T1),
    DT is T1-T0,
    format('~w: ~2f sec~n', [Label, DT]).

:- meta_predicate mc(+, 0).
mc(Label, Goal) :-
    mtimed(Label, (mcount(Goal, N), format('~w = ~w~n', [Label, N]))).

% ---- LEGAL funnel (L0..L3)  — fully qualified into user: module
diag_legal :-
    format('--- LEGAL funnel ---~n', []),
    mc('L0 used/4',            user:used(_P,_D,_R,_T)),
    mc('L1 action⨝used',       (user:action(P,PU), user:used(P,D,_R,T))),
    mc('L2 +personal',         (user:action(P,PU), user:used(P,D,_R,T), once(user:isPersonalP(D,_)))),
    mc('L3 violations',        (user:action(P,PU), user:used(P,D,_R,T), once(user:isPersonalP(D,DP)), \+ user:consentFoundOk(_C,DP,PU,T))),
    format('--- LEGAL profile (top 20 by time) ---~n', []),
    profiler:profile((user:legal(_P,_D,_PU,_T,_DP,_C), fail ; true)),
    profiler:show_profile([top(20), sort(time)]).

% ---- Personal-data shape (to explain L2 costs)
:- table pd_dist/2.
pd_dist(D,0) :- user:isPersonal(D).
pd_dist(D,N) :- user:wasDerivedFrom(D,M,_,_), pd_dist(M,N1), N is N1+1.

pd_stats :-
    mc('PD roots (isPersonal/1)', user:isPersonal(_)),
    mtimed('unique Ds reaching PD',
        (setof(D, DP^(user:isPersonalP(D,DP)), L), length(L,N), format('unique Ds = ~w~n', [N]))),
    mtimed('max derivation depth',
        (aggregate(max(N,D), pd_dist(D,N), max(MaxN,MaxD)),
         format('max depth = ~w at D=~w~n', [MaxN,MaxD]))).
