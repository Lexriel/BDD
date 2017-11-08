% Exercice 5

% Schéma R
schema([a,b,c,d,e,f,g,h,i,j]).

% Ensemble de dépendances fonctionnelles F
fds(
[
[[a,b],[c]],
[[b,d],[e,f]],
[[b],[f]],
[[f],[g,h]],
[[d],[i,j]]
]
).

% Calculer la clé K et une décomposition de R en 3NF
answer(K,R3NF) :- schema(R), fds(F), candkey(R,F,K), threenf(R,F,R3NF).

% Résultat
% ?- answer(K,R3NF).
% K = [a, b, d],
% R3NF = [[a, b, c], [b, f], [b, d, e], [d, i, j], [f, g, h], [a, b, d]] ;

% Remarques/observations
% Comme K est l'unique clé candidate, c'est la clé de R.
