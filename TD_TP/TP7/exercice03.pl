% Exercice 3

% Schéma R = EMP_DEPT
schema([ename, ssn, bdate, address, dnumber, dname, dmgrssn]).

% Ensemble de dépendances fonctionnelles F = G
fds(
[
[[ssn],[ename,bdate,address,dnumber]],
[[dnumber],[dname,dmgrssn]]
]
).

% G est-il minimal ? Sinon calculer MinG.
answer(MinG) :- schema(R), fds(F), mincover(R,F,MinG).

% Résultat
% ?- answer(MinG).
% MinG = [[[dnumber], [dmgrssn, dname]],
%         [[ssn], [address, bdate, dnumber, ename]]] ;

% Remarques/observations
% Swi-prolog renvoie indéfiniment le même résultat.

% Conclusion
% MinG correspond à G donc G est minimal.
