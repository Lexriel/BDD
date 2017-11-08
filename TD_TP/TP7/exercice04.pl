% Exercice 4

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

% Calculer la clé K et une décomposition de R en 3NF
answer(K,R3NF) :- schema(R), fds(F), candkey(R,F,K), threenf(R,F,R3NF).

% Résultat
% ?- answer(K,R3NF).
% K = [a, b],
% R3NF = [[a, d, e], [a, b, c], [b, f], [d, i, j], [f, g, h]] ;

% Remarques/observations
% Comme K est l'unique clé candidate, c'est la clé de R.
% Affichage infini du même résultat.

