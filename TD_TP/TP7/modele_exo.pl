% Exercice No

schema([a,b,c,d,e]).

fds(
[
[[],[]],
[[],[]],
[[],[]]
]
).

% Prédicat answer pour chacune des questions
answer(K) :- schema(R), fds(F), candkey(R,F,K).

% Résultat (en commentaires, capture de la requête et réponse du système)

% Eventuelles remarques/conclusions/observations
