% Exercice 8 bis

% Schéma R = LOTS
schema([propertyId, countyName, lotNo, area, price, taxRate]).

% Ensemble de dépendances fonctionnelles F
fds(
[
[[propertyId],[countyName,lotNo,area,price,taxRate]],
[[countyName,lotNo],[propertyId,area,price,taxRate]],
[[countyName],[taxRate]],
[[area],[price]]
]
).

% Décomposition de LOTS en relations LOTS1A, LOTS1B, LOTS2
% obtenues avec : schema(R), fds(F), threenf(R,F,R3NF).
decomp([[propertyId,area,lotNo,countyName], [area,price],
        [countyName,taxRate]]).

% La décomposition de LOTS en les relations précédentes est-elle une
% décomposition à jointures sans perte ?
answer :- schema(R), fds(F), decomp(D), ljd(R,F,D).

% Résultat
% ?- answer.
% [[a,1],[a,2],[a,3],[a,4],[a,5],[a,6]]
% [[b,2,1],[b,2,2],[b,2,3],[a,4],[a,5],[b,2,6]]
% [[b,3,1],[a,2],[b,3,3],[b,3,4],[b,3,5],[a,6]]
% true.

% Explications
% Une décomposition à jointures sans pertes (lossless join decomposition)
% est une décomposition permettant de reconstruire entièrement la relation
% initiale, sans tuples parasites. Les jointures sur cette décomposition
% construisent bien entièrement R, en effet, on a bien décomposé R grâce
% à sa forme 3NF.

% Remarques/observations
% LOTS1A * LOTS1B * LOTS2 donne R.
% lrj renvoie également une matrice dont j'ignore l'usage.

% Conclusion
% D est une décomposition à jointures sans pertes.

% Question 1.3
% Une décomposition est préférable si elle est à jointures sans pertes.
% Ici, choisir une décomposition quelconque n'est pas toujours un bon
% choix. Cependant, les relations données par la forme 3NF d'une 
% relation forment une bonne décomposition.

% Question 1.4
answerPreserveFD :- schema(R), fds(F), decomp(D), fpd(R,F,D).

% Résultat de answerPreserveFD.
% ?- answerPreserveFD.
% Considering [propertyId]-->[countyName,lotNo,area,price,taxRate]
% Xplus=[lotNo,propertyId,area,price,countyName,taxRate]
% Considering [countyName,lotNo]-->[propertyId,area,price,taxRate]
% Xplus=[lotNo,propertyId,area,price,countyName,taxRate]
% Considering [countyName]-->[taxRate]
% Xplus=[countyName,taxRate]
% Considering [area]-->[price]
% Xplus=[area,price]
% true ;

% Contrairement à la décomposition du fichier exercice8.pl, la
% décomposition D de ce fichier à partir de la forme 3NF de R
% préserve les dépendances fonctionnelles.
