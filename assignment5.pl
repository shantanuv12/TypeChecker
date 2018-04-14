const(X):-  X==tt.
const(X):-  X==ff.
const(X):-  number(X),!.

const_type(X,boolT):-   X==tt.
const_type(X,boolT):-    X==ff.
const_type(X,intT):-    number(X),!.


lookup(_,[]):- fail.
lookup(X,[X|Xs]):- !.
lookup(X,[Y|Ys]):-lookup(X,Ys).

hastype(Gamma,variable(X),T):-lookup(Gamma,p(variable(X),U)).

hastype(Gamma,pair(E1,E2),cartesianT(T1,T2)):-hastype(Gamma,E1,T1),hastype(Gamma,E2,T2).

hastype(Gamma,abs(variable(x),E1)),cartesianT(T1,T2)):-hastype([p(variable(X),T1)|Gamma],E1,T2).

hastype(Gamma,Ite(E1,E2,E3),T):-hastype(Gamma,E1,boolT),hastype(Gamma,E2,T),hastype(Gamma,E3,T).

hastype(Gamma,Compose(E1,E2),T2):-hastype(Gamma,E1,arrow(T1,T2)),hastype(Gamma,E2,T1).

hastype(Gamma,Plus(E1,E2),intT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).

hastype(Gamma,tt,boolT).

hastype(Gamma,ff,boolT).

hastype(Gamma,Proj(I,Tup(X)),intT):- hastype(Gamma,I,intT),hastype(Gamma,).

hastype(Gamma,Let_D_in_E_end(X,E1,E2),T):- hastype(Gamma,E1,T1),hastype([p(variable(X),T1)|Gamma],T).

hastype(Gamma,Plus(E1,E2),intT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).

hastype(Gamma,Subtract(E1,E2),intT);hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).

hastype(Gamma,Mult(E1,E2),intT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).

hastype(Gamma,Div(E1,E2),intT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).

hastype(Gamma,Mod(E1,E2),intT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).

hastype(Gamma,Abs(E1),intT):-hastype(Gamma,E1,intT).

hastype(Gamma,Succ(E1),intT):-hastype(Gamma,E1,intT).

hastype(Gamma,Pred(E1),intT):-hastype(Gamma,E1,intT).

hastype(Gamma,And(E1,E2),boolT):-hastype(Gamma,E1,boolT),hastype(Gamma,E2,boolT).

hastype(Gamma,Or(E1,E2),boolT):-hastype(Gamma,E1,boolT),hastype(Gamma,E2,boolT).

hastype(Gamma,Imp(E1,E2),boolT):-hastype(Gamma,E1,boolT),hastype(Gamma,E2,boolT).

hastype(Gamma,Equals(E1,E2),boolT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).

hastype(Gamma,Equals(E1,E2),boolT):-hastype(Gamma,E1,boolT),hastype(Gamma,E2,boolT).

hastype(Gamma,Grthan(E1,E2),boolT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).

hastype(Gamma,Lesthan(E1,E2),boolT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).

hastype(Gamma,Greq(E1,E2),boolT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).

hastype(Gamma,Leseq(E1,E2),boolT):-hastype(Gamma,E1,intT),hastype(Gamma,E2,intT).

typeElaborates(Gamma,Let_X_is_E(X,E),Gamma1):-hastype(Gamma,E,Gamma1).

typeElaborates(Gamma,Compose_Def(D1,D2),L):-append(Gamma2,Gamma1):-typeElaborates(Gamma,D1,Gamma1),typeElaborates([Gamma],D2,Gamma2).

lookup(p(variable("dnk"),T),[p(variable("x"),intT),p(variable("dnk"),bT)]).
