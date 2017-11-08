% Exercice 12

% Schéma R
schema([a,b,c,d,e]).

% Ensemble de dépendances fonctionnelles F
fds(
[
[[a,b],[c]],
[[c,d],[e]],
[[d,e],[b]]
]
).

% Déterminer les clés candidates, les formes 3NF et BCNF de R
answerCandKeys(K) :- schema(R), fds(F), candkey(R,F,K).
answer3NF(R3NF)   :- schema(R), fds(F), threenf(R,F,R3NF).
answerBCNF(Rbcnf) :- schema(R), fds(F), bcnf(R,F,Rbcnf).

% Résultats pour answerCandKeys(K).
% ?- answerCandKeys(K).
% K = [a, d, e] ;
% K = [a, c, d] ;
% K = [a, b, d] ;

% Résultats pour answer3NF(R3NF).
% ?- answer3NF(R3NF).
% R3NF = [[a, b, c], [c, d, e], [d, e, b], [a, d, e]] ;
% R3NF = [[a, b, c], [c, d, e], [d, e, b], [a, c, d]] ;
% R3NF = [[a, b, c], [c, d, e], [d, e, b], [a, b, d]] ;
% ...

% Résultats pour answerBCNF(Rbcnf).
% ?- answerBCNF(Rbcnf).
% Rbcnf = [[a, d, e], [a, b, c], [d, e, b]] ;
% Rbcnf = [[a, d, e], [a, b, e, c], [d, e, b]] ;
% Rbcnf = [[a, b, d], [b, c, d, e], [a, b, c]] ;
% Rbcnf = [[a, c, d], [b, c, d, e], [c, d, b]] ;
% Rbcnf = [[a, c, d], [c, d, b, e]] ;
% Rbcnf = [[a, c, d], [c, d, e, b], [c, d, e]] ;
% Rbcnf = [[a, c, d], [d, e, b], [c, d, e]] ;

% Remarques/Observations
% En utilisant ; on peut observer qu'il y a de nombreuses décompositions
% BCNF et 3NF pour R.

% Conclusion
% Il n'y a pas unicité des décompositions BCNF et 3NF.
