% Exercice 14

% Schéma R = REFRIG
schema([model_no,year,price,manuf_plant,color]).

% Ensemble de dépendances fonctionnelles F
fds(
[
[[model_no],[manuf_plant]],
[[model_no,year],[price]],
[[manuf_plant],[color]]
]
).

% Décomposition D
decomp([[model_no,year,price], [model_no,manuf_plant,color]]).

% Déterminer si les ensembles d'attribus dans l'énoncé forment des
% clés candidates, si R est une forme 3NF et une forme BCNF, et si D
% est une décomposition à jointures sans pertes
answerCandKey1 :- schema(R), fds(F), candkey(R,F,[model_no]).
answerCandKey2 :- schema(R), fds(F), candkey(R,F,[model_no,year]).
answerCandKey3 :- schema(R), fds(F), candkey(R,F,[model_no,color]).
answerIs3NF   :- schema(R), fds(F), is3NF(R,F).
answerIsBCNF :- schema(R), fds(F), isBCNF(R,F).
answerLJD :- schema(R), fds(F), decomp(D), ljd(R,F,D).

% Résultats
% ?- answerCandKey1.
% false.
% ?- answerCandKey2.
% true .
% ?- answerCandKey3.
% false.
% ?- answerIs3NF.
% false.
% ?- answerIsBCNF.
% false.
% ?- answerLJD.
% [[a,1],[a,2],[a,3],[a,4],[a,5]]
% [[a,1],[b,2,2],[b,2,3],[a,4],[a,5]]
% true .

% Conclusions
% [model_no] et [model_no,color] ne sont pas des clés candidates.
% [model_no,year] est une clé candidate.
% REFRIG n'est ni 3NF ni BCNF.
% D est une décomposition à jointures sans pertes.
