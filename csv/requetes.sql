Select CLIENT.NO_CARTE, CREDIT_CARTE, NOM, PRENOM, ADRESSE, E_MAIL, TELEPHONE, DATE_HEURE, PRODUIT.REFERENCE, LIBELLE, QUANTITE, MARQUE, PRIX_UNIT_HT, LIQUIDE_VF, PRIX_KILO_OU_LITRE, QUANTITE_STOCK, RAYON.NOM_RAYON, NOM_CATEGORIE FROM CLIENT, PANIER, PRODUIT, SOUS_RAYON, RAYON, ITEM, SR_P WHERE CLIENT.NO_CARTE=PANIER.NO_CARTE AND ITEM.NO_CARTE = PANIER.NO_CARTE AND ITEM.REFERENCE = PRODUIT.REFERENCE AND PRODUIT.REFERENCE = SR_P.REFERENCE AND SR_P.NOM_SR = SOUS_RAYON.NOM_SR AND SOUS_RAYON.NOM_RAYON = RAYON.NOM_RAYON ORDER BY CLIENT.NO_CARTE INTO OUTFILE "/var/lib/mysql-files/DBSousRayon4.csv" FIELDS Terminated BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

Select CLIENT.NO_CARTE, CREDIT_CARTE, NOM, PRENOM, ADRESSE, E_MAIL, TELEPHONE, DATE_HEURE, PRODUIT.REFERENCE, LIBELLE, QUANTITE, MARQUE, PRIX_UNIT_HT, LIQUIDE_VF, PRIX_KILO_OU_LITRE, QUANTITE_STOCK, RAYON.NOM_RAYON, NOM_CATEGORIE FROM CLIENT, PANIER, PRODUIT, SOUS_RAYON, RAYON, ITEM, SOUS_SOUS_RAYON, SSR_P WHERE CLIENT.NO_CARTE=PANIER.NO_CARTE AND ITEM.NO_CARTE = PANIER.NO_CARTE AND ITEM.REFERENCE = PRODUIT.REFERENCE AND PRODUIT.REFERENCE = SSR_P.REFERENCE AND SSR_P.NOM_SSR = SOUS_SOUS_RAYON.NOM_SSR AND SOUS_SOUS_RAYON.NOM_SR = SOUS_RAYON.NOM_SR AND SOUS_RAYON.NOM_RAYON = RAYON.NOM_RAYON ORDER BY CLIENT.NO_CARTE INTO OUTFILE "/var/lib/mysql-files/DBSousSousRayon4.csv" FIELDS Terminated BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
