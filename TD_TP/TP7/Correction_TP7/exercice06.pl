% Exercice 6

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

% AB et ABD sont-elles des clés candidates ?
answer :- schema(R), fds(F), not(candkey(R,F,[a,b])), candkey(R,F,[a,b,d]),
          write('[a,b,d] is a candidate key, [a,b] is not').

% Résultat
% ?- answer.
% [a,b,d] is a candidate key, [a,b] is not
% true.

% Remarques/observations
% On pouvait créer deux réponses distinctes.

% Conclusion
% ABD est une clé tandis que AB n'en est pas une.
