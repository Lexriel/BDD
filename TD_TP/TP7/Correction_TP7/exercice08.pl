% Exercice 8

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

% Décomposition de LOTS en relations LOTS1AX, LOTS1AY, LOTS1B, LOTS2
decomp([[propertyId,area,lotNo], [area,countyName], [area,price],
        [countyName,taxRate]]).

% La décomposition de LOTS en les relations précédentes est-elle une
% décomposition à jointures sans perte ?
answer :- schema(R), fds(F), decomp(D), ljd(R,F,D).

% Résultat
% ?- answer.
% [[a,1],[b,1,2],[a,3],[a,4],[a,5],[b,1,6]]
% [[b,2,1],[a,2],[b,2,3],[a,4],[a,5],[a,6]]
% [[b,3,1],[b,3,2],[b,3,3],[a,4],[a,5],[b,3,6]]
% [[b,4,1],[a,2],[b,4,3],[b,4,4],[b,4,5],[a,6]]
% false.

% Explications
% Une décomposition à jointures sans pertes (lossless join decomposition)
% est une décomposition permettant de reconstruire entièrement la relation
% initiale, sans tuples parasites. Or les jointures sur cette décomposition
% en créeront.

% Remarques/observations
% LOTS1AX * LOTS1AY * LOTS1B * LOTS2 ne donne pas R.
% lrj renvoie également une matrice dont j'ignore l'usage.

% Conclusion
% D n'est pas une décomposition à jointures sans pertes.

% Question 1.4
answerPreserveFD :- schema(R), fds(F), decomp(D), fpd(R,F,D).

% Résultat de answerPreserveFD.
% ?- answerPreserveFD.
% Considering [propertyId]-->[countyName,lotNo,area,price,taxRate]
% Xplus=[lotNo,propertyId,area,price]
% false.

% Voir fichier exercice08bis.pl pour une comparaison des résultats.
