% Exercice 12 bis

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

% Déterminer les clés candidates, les formes 3NF et BCNF de R
answerCandKeys(K) :- schema(R), fds(F), candkey(R,F,K).
answer3NF(R3NF)   :- schema(R), fds(F), threenf(R,F,R3NF).
answerBCNF(Rbcnf) :- schema(R), fds(F), bcnf(R,F,Rbcnf).

% Résultats pour answerCandKeys(K).
% ?- answerCandKeys(K).
% K = [semester, year, daysHour, roomNo] ;
% K = [courseNo, secNo, semester, year] ;

% Résultats pour answer3NF(R3NF).
% ?- answer3NF(R3NF).
% R3NF = [[courseNo, courseLevel, creditHours, offeringDept],
%         [courseNo, secNo, semester, year, daysHour, noOfStudents, roomNo],
%         [roomNo, daysHour, semester, year, courseNo, instructorSsn|...]] ;
% ...

% Résultats pour answerBCNF(Rbcnf).
% ?- answerBCNF(Rbcnf).
% Rbcnf = [[courseNo, secNo, instructorSsn, semester, year, daysHour,
%           roomNo, noOfStudents],
%          [courseNo, courseLevel, creditHours, offeringDept]] ;
% Rbcnf = [[courseNo, secNo, instructorSsn, semester, year, daysHour,
%           roomNo, noOfStudents],
%          [courseNo, secNo, courseLevel, creditHours, offeringDept]] 
% ...

% Remarques/Observations
% En utilisant ; on peut observer qu'il y a de nombreuses décompositions
% BCNF et 3NF pour R.

% Conclusion
% Il n'y a pas unicité des décompositions BCNF et 3NF.
