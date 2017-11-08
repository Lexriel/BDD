% Exercice 1

% Schéma R
schema([a,b,c,d,e,h]).

% Ensemble de dépendances fonctionnelles F1
fds1(
[
[[a],[c]],
[[a,c],[d]],
[[e],[a,d]],
[[e],[h]]
]
).

% Ensemble de dépendances fonctionnelles F2
fds2(
[
[[a],[c,d]],
[[e],[a,h]]
]
).

% F1 et F2 sont-elles équivalentes ?
answer :- schema(R), fds1(F1), fds2(F2), equiv(R,F1,F2).

% résultat
% ?- answer.
% true .

% Remarques/observations
% On ajoute K dans answer car il est impossible de ne pas mettre de
% paramètres à answer.

% Conclusion
% F1 et F2 ne sont pas équivalentes.
