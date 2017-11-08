% Exercice 7

% Schéma R
schema([courseNo, secNo, offeringDept, creditHours, courseLevel,
        instructorSsn, semester, year, daysHour, roomNo, noOfStudents]).

% Ensemble de dépendances fonctionnelles F
fds(
[
[[courseNo],[offeringDept, creditHours, courseLevel]],
[[courseNo, secNo, semester, year],[daysHour, roomNo, noOfStudents, instructorSsn]],
[[roomNo, daysHour, semester, year],[instructorSsn, courseNo, secNo]]
]
).

% Trouver les clés candidates de R et décomposer R en 3NF
answerCandKeys(K) :- schema(R), fds(F), candkey(R,F,K).
answer3NF(R3NF) :- schema(R), fds(F), threenf(R,F,R3NF).

% Résultat pour answerCandKeys(K).
% ?- answerCandKeys(K).
% K = [semester, year, daysHour, roomNo] ;
% K = [courseNo, secNo, semester, year]

% Résultat pour answer3NF(R3NF).
% ?- answer3NF(R3NF).
% R3NF = [[courseNo, courseLevel, creditHours, offeringDept],
%         [courseNo, secNo, semester, year, daysHour, noOfStudents, roomNo],
%         [roomNo, daysHour, semester, year, courseNo, instructorSsn|...]] ;
% ...

% Remarques/observations
% answer(K,R3NF) :- schema(R), fds(F), candkey(R,F,K), threenf(R,F,R3NF).
% Ce fait n'affichait qu'une seule clé candidate alors qu'il y en a deux.
% Il vaut donc mieux séparer l'affichage des réponses pour K et R3NF.

% Conclusion
% On trouve deux clés K et une forme 3NF.
