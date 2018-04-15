lookup([],_,[]).
lookup(X,[X|Gamma],X):-!.
lookup(X,[Y|Gamma])
