% Exercice 13 i

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

% Décomposition D1
decomp([[a,b,c], [a,d,e], [b,f], [f,g,h], [d,i,j]]).

% On détermine si D1 est une décomposition préservant les dépendances
% fonctionnelles (fonctional dependency preserving decomposition) avec fpd 
answerFPD :- schema(R), fds(F), decomp(D), fpd(R,F,D).
% On détermine si D1 est une décomposition à jointures sans pertes
% (lossless join decomposition) avec ljd
answerLJD :- schema(R), fds(F), decomp(D), ljd(R,F,D).

% Résultat pour answerFPD.
% ?- answerFPD.
% Considering [a,b]-->[c]
% Xplus=[c,a,e,b,f,g,h,d,i,j]
% Considering [a]-->[d,e]
% Xplus=[a,e,d,i,j]
% Considering [b]-->[f]
% Xplus=[b,f,g,h]
% Considering [f]-->[g,h]
% Xplus=[f,g,h]
% Considering [d]-->[i,j]
% Xplus=[d,i,j]
% true .

% Résultat pour answerLJD.
% ?- answerLJD.
% [[a,1],[a,2],[a,3],[a,4],[a,5],[a,6],[a,7],[a,8],[a,9],[a,10]]
% [[a,1],[b,2,2],[b,2,3],[a,4],[a,5],[b,2,6],[b,2,7],[b,2,8],[a,9],[a,10]]
% [[b,3,1],[a,2],[b,3,3],[b,3,4],[b,3,5],[a,6],[a,7],[a,8],[b,3,9],[b,3,10]]
% [[b,4,1],[b,4,2],[b,4,3],[b,4,4],[b,4,5],[a,6],[a,7],[a,8],[b,4,9],[b,4,10]]
% [[b,5,1],[b,5,2],[b,5,3],[a,4],[b,5,5],[b,5,6],[b,5,7],[b,5,8],[a,9],[a,10]]
% true .

% Conclusion
% D1 préserve les dépendances fonctionnelles et est une décomposition à
% jointures sans pertes.
