% Exercice 9

% Schéma R
schema([a,b,c,d,e,f,g,h,i,j]).

% Ensemble de dépendances fonctionnelles F
fds(
[
[[a,b],[c]],
[[a],[d,e]],
[[b],[f]],
[[f],[g,h]],
[[d],[i,j]]
]
).

% Calculer la clé K, l'ensemble minimal de dépendances fonctionnelles Fmin
% et décomposition 3NF de R
answer(K,Fmin,R3NF) :- schema(R), fds(F), candkey(R,F,K),
                       mincover(R,F,Fmin), threenf(R,F,R3NF).

% Résultat
% ?- answer(K,Fmin,R3NF).
% K = [a, b],
% Fmin = [[[a], [d, e]], [[a, b], [c]], [[b], [f]],
%         [[d], [i, j]], [[f], [g, h]]],
% R3NF = [[a, d, e], [a, b, c], [b, f], [d, i, j], [f, g, h]] ;
% ...

% Remarques/observations
% K, Fmin et R3NF sont uniques.
