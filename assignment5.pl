lookup(_,[]):- fail.
lookup(X,[X|_]):- !.
lookup(X,[_|Ys]):-lookup(X,Ys).

union([],[],[]).
union(List1,[],List1).
union(List1, [Head2|Tail2], [Head2|Output]):-
    \+(member(Head2,List1)), union(List1,Tail2,Output).
union(List1, [Head2|Tail2], Output):-
    member(Head2,List1), union(List1,Tail2,Output).

hastype(_,tt,boolT).
hastype(_,ff,boolT).
hastype(_,number(_),intT).
hastype(Gamma,variable(X),T):-lookup(p(variable(X),T),Gamma).
hastype(Gamma,pair(E1,E2),cartesianT(T1,T2)):-hastype(Gamma,E1,T1),hastype(Gamma,E2,T2).
hastype(Gamma,abs(variable(X),E1),cartesianT(T1,T2)):-hastype([p(variable(X),T1)|Gamma],E1,T2).
hastype(Gamma,ite(E1,E2,E3),T):-hastype(Gamma,E1,boolT),hastype(Gamma,E2,T),hastype(Gamma,E3,T).
hastype(Gamma,compose(E1,E2),T2):-hastype(Gamma,E1,arrow(T1,T2)),hastype(Gamma,E2,T1).
hastype(Gamma,let_D_in_E_end(X,E1,E2),T):- hastype(Gamma,E1,T1),hastype([p(variable(X),T1)|Gamma],E2,T).
hastype(Gamma,plus(E1,E2),intT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).
hastype(Gamma,subtract(E1,E2),intT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).
hastype(Gamma,mult(E1,E2),intT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).
hastype(Gamma,div(E1,E2),intT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).
hastype(Gamma,mod(E1,E2),intT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).
hastype(Gamma,abs(E1),intT):-hastype(Gamma,E1,intT).
hastype(Gamma,succ(E1),intT):-hastype(Gamma,E1,intT).
hastype(Gamma,pred(E1),intT):-hastype(Gamma,E1,intT).
hastype(Gamma,and(E1,E2),boolT):-hastype(Gamma,E1,boolT),hastype(Gamma,E2,boolT).
hastype(Gamma,or(E1,E2),boolT):-hastype(Gamma,E1,boolT),hastype(Gamma,E2,boolT).
hastype(Gamma,imp(E1,E2),boolT):-hastype(Gamma,E1,boolT),hastype(Gamma,E2,boolT).
hastype(Gamma,equals(E1,E2),boolT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).
hastype(Gamma,equals(E1,E2),boolT):-hastype(Gamma,E1,boolT),hastype(Gamma,E2,boolT).
hastype(Gamma,grthan(E1,E2),boolT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).
hastype(Gamma,lesthan(E1,E2),boolT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).
hastype(Gamma,greq(E1,E2),boolT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).
hastype(Gamma,leseq(E1,E2),boolT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).
hastype(Gamma,tup([X|_]),T):-hastype(Gamma,X,T).
hastype(Gamma,proj(I,Y),T):-hastype(Gamma,I,intT),hastype(Gamma,Y,T).
typeElaborates(Gamma,let_X_in_E(X,E),[p(X,Gamma1)]):-hastype(Gamma,E,Gamma1).
typeElaborates(Gamma,compose_Def(D1,D2),L):-typeElaborates(Gamma,D1,Gamma1),typeElaborates(L1,D2,Gamma2),append(Gamma1,Gamma,L1),append(Gamma2,Gamma1,L).
typeElaborates(Gamma,paralell(D1,D2),L):- typeElaborates(Gamma,D1,Gamma1),typeElaborates(Gamma,D2,Gamma2),union(Gamma1,Gamma2,L).
typeElaborates(Gamma,local_D1_in_D2(D1,D2),Gamma2):-typeElaborates(Gamma,D1,Gamma1),typeElaborates(L1,D2,Gamma2),append(Gamma1,Gamma,L1).
