% Exercice 11

% Schéma R
schema([a,b,c,d,e,f,g,h,i,j]).

% Ensemble de dépendances fonctionnelles F1 = F
fds1(
[
[[a,b],[c]],
[[a],[d,e]],
[[b],[f]],
[[f],[g,h]],
[[d],[i,j]]
]
).

% Ensemble de dépendances fonctionnelles F2 = G
fds2(
[
[[a,b],[c]],
[[b,d],[e,f]],
[[b],[f]],
[[f],[g,h]],
[[d],[i,j]]
]
).

% Calculer la décomposition BCNF de R avec F1 et celle avec F2
answerR1(R1bcnf) :- schema(R), fds1(F1), bcnf(R,F1,R1bcnf).
answerR2(R2bcnf) :- schema(R), fds2(F2), bcnf(R,F2,R2bcnf).

% Résultats pour R1bcnf
% ?- answerR1(R1bcnf).
% Scheme to decompose = [a,b,c,d,e,f,g,h,i,j] Offending FD: [a]-->[d,e,i,j]
% Scheme to decompose = [a,b,c,f,g,h] Offending FD: [a,c,f]-->[g,h]
% Scheme to decompose = [a,b,c,f] Offending FD: [b]-->[f]
% Final Result is: 
% [a,b,c]
% [a,d,e,i,j]
% [a,c,f,g,h]
% [b,f]
% R1bcnf = [[a, b, c], [a, d, e, i, j], [a, c, f, g, h], [b, f]] 
% et de nombreux autres résultats distincts.

% Résultats pour R2bcnf
% ?- answerR2(R2bcnf).
% Scheme to decompose = [a,b,c,d,e,f,g,h,i,j] Offending FD: [a,b]-->[c,f,g,h]
% Scheme to decompose = [a,b,d,e,i,j] Offending FD: [a,d]-->[i,j]
% Scheme to decompose = [a,b,d,e] Offending FD: [b,d]-->[e]
% Final Result is: 
% [a,b,d]
% [a,b,c,f,g,h]
% [a,d,i,j]
% [b,d,e]
% R2bcnf = [[a, b, d], [a, b, c, f, g, h], [a, d, i, j], [b, d, e]] 
% et de nombreux autres résultats distincts.

% Remarques/Observations
% En utilisant ; on peut observer qu'il y a de nombreuses décompositions
% BCNF pour R, que ce soit en utilisant les dépendances fonctionnelles F
% ou G.

% Conclusion
% Il n'y a pas unicité de la décomposition BCNF.
