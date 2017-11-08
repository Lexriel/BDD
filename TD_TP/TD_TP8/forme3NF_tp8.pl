% Exercice 14

% Schéma R
schema([id_machine, nom_machine, prix_machine, description, id_piece, qte_piece, nom_piece, en_stock, id_fournisseur, fournisseur, adresse, ville, telephone, fax, date_livraison, qte_livraison, client, id_commande]).

% Ensemble de dépendances fonctionnelles F
fds(
[
[[id_machine], [nom_machine, prix_machine, description]],
[[id_fournisseur], [fournisseur, adresse, ville, telephone, fax]],
[[id_commande], [date_livraison, qte_livraison, client, id_machine]],
[[id_piece], [nom_piece, en_stock, id_fournisseur]],
[[id_machine,id_piece], [qte_piece]]
]
).

decomp([
[id_commande, client, date_livraison, id_machine, qte_livraison],
[id_fournisseur, adresse, fax, fournisseur, telephone, ville],
[id_machine, description, nom_machine, prix_machine],
[id_machine, id_piece, qte_piece],
[id_piece, en_stock, id_fournisseur, nom_piece],
[id_piece, id_commande]
]
]).

% Déterminer si les ensembles d'attribus dans l'énoncé forment des
% clés candidates, si R est une forme 3NF et une forme BCNF, et si D
% est une décomposition à jointures sans pertes
answer3NF(R3NF)   :- schema(R), fds(F), threenf(R,F,R3NF).
