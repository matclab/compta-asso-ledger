# Comptabilité française pour une association avec ledger

Les fichiers sont :

- `legal.ledger` : qui définit les comptes officiels extraits du règlement n° 2018-06 du 5 décembre 2018,
- `account.ledger` : qui définit les commodités, le taux horaires, inclue
  `legal.ledger` et définit les comptes spécifiques à l'association.
- `.envrc` qui définit les variables d'environnement permettant de configurer
  *ledger* (très pratique avec [direnv](https://github.com/direnv/direnv))
- `periodic.ledger` qui définit les transactions périodique pour le budget
- `prev.ledger` qui inclue `periodic.ledger` et initiailse les comptes pour
  pouvoir calculer le budget
- `asso.ledger` qui inclue `account.ledger` et `periodic.ledger`, qui
  initialise les comptes et déclare les transactions.

Les scripts sont :

- `bilan.sh` qui affiche le bilan actif/passif
- `compte_résultat.sh` qui affiche les comptes de résultat
  (exploitation/financiers/contributions volontaires en nature)
- `cotisations.sh` qui exploite le fichier des utilisateurs `users.yaml` et
  les comptes pour savoir qui est en retard de paiement de cotisation (compte
  7:5:8:1).
- `budget.sh` qui sort le budget prévisionnel pour l'année en cours (ou
  l'année passée en paramètre)


## Dépendances
- j2
- bash
- ledger

## Format du fichier `users.yaml`
Le fichier doit contenir l'entrée `people` qui contient un dictionnaire des
utilisateurs dont la clé et un identifiant unique et le contenu un
dictionnaire avec au moins les champs suivants :
```yaml
people:
  truc07:
    prenom: Jean
    nom: Truc
```

Et *prenom nom* apparaît comme *payee* dans les transactions de cotisation.
