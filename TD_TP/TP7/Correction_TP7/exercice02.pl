% Exercice 2

% Schéma R = EMP_DEPT
schema([ename, ssn, bdate, address, dnumber, dname, dmgrssn]).

% Ensemble de dépendances fonctionnelles F = G
fds(
[
[[ssn],[ename,bdate,address,dnumber]],
[[dnumber],[dname,dmgrssn]]
]
).

% Calculer {ssn}+ et {dnumber}+
answer(SSNplus,DNUMBERplus) :- schema(R), fds(F), xplus(R,F,[ssn],SSNplus),
             xplus(R,F,[dnumber], DNUMBERplus).

% Résultat
% ?- answer(SSNplus,DNUMBERplus).
% SSNplus = [address, bdate, dmgrssn, dname, dnumber, ename, ssn],
% DNUMBERplus = [dmgrssn, dname, dnumber].

% Remarques/observations
% SSNplus = R donc SSN est une clé pour R.
% DNUMBERplus != R donc dnumber n'est pas une superclé.

% Conclusion
% ssn est une clé pour R.
