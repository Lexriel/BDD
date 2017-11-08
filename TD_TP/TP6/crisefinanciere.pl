doit_argent(anne,barbara).
doit_argent(barbara,cecile).
doit_argent(cecile,barbara).

evite(X,Y) :- doit_argent(X,Y).
evite(X,Z) :- doit_argent(X,Y), evite(Y,Z).

% Lancer swi-prolog :
% swipl (ou prolog)

% Charger un fichier :
% consult('crisefinanciere.pl').

% Requête pour afficher les dettes :
% doit_argent(X,Y).
% Utiliser ; sur swi-prolog pour afficher les résultats suivants,
% utiliser ENTREE sur swiprolog pour arrêter l'affichage.

% Requête pour afficher les filles qui évitent les autres filles :
% evite(X,Y).
% On observe une bouche infinie avec swi-prolog et pas sur DES.
% DES mémorise les faits déjà prouvés ou tentés d'être prouver tandis
% que prolog ne le fait pas. Prolog peut donc parcourir des boucles 
% infinies tandis que DES s'arrête.

% Ce fichier répond aux questions 19 à 21.
