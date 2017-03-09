mysql -u root -p ProjetBDDL2_V4 < DepotGit/populate_database/database/modele_physique_DriveInMYSQL.SQL
python3 categorizer.py ProjetBDDL2_V4
python3 populator.py ProjetBDDL2_V4
python3 productioner.py ProjetBDDL2_V4
python3 promotionner.py ProjetBDDL2_V4
python3 panierMaker.py ProjetBDDL2_V4
