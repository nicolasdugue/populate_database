'''
Created on Apr 12, 2016

@author: nicolas
'''
#
#


from sqlalchemy import create_engine, MetaData, Table


db = create_engine('mysql://root:password@localhost/ProjetBDDL2')

db.echo = True

metadata = MetaData(db)

categories = Table('CATEGORIE', metadata, autoload=True)
i = categories.insert()

tab_cat=["Viandes", "Poissons", "Fruits et Legumes", "Boissons"]
# for cat in tab_cat:
#     i.execute(NOM_CATEGORIE=cat)
    
rayon_table=Table('RAYON', metadata, autoload=True)
i = rayon_table.insert()
rayons=dict()
rayons["Viandes"]=["Boucherie", "Volaille"]
rayons["Poissons"]=["Poissonnerie", "Traiteur"]
rayons["Fruits et Legumes"]=["Fruits", "Legumes"]
rayons["Boissons"]=["Sodas", "Eaux", "Lait", "Vin", "Spiritueux"]

# for categorie in rayons.keys():
#     rayon_list=rayons[categorie]
#     for r in rayon_list:
#         i.execute(NOM_RAYON=r, NOM_CATEGORIE=categorie)

rayon_table=Table('SOUS_RAYON', metadata, autoload=True)
i = rayon_table.insert()
sous_rayons=dict()
sous_rayons["Boucherie"]=["Boeuf", "Veau", "Agneau", "Porc"]
sous_rayons["Volaille"]=["Poulet", "Dinde", "Canard", "Nuggets"]
sous_rayons["Poissonnerie"]=["Filets", "Coquillages", "Crustaces"]
sous_rayons["Traiteur"]=["Surimi", "Marinade", "Soupes"]
sous_rayons["Fruits"]=["Fruits frais", "Fruits secs", "Jus"]
sous_rayons["Legumes"]=["Legumes", "Salades Sachet"]
sous_rayons["Sodas"]=["Aux fruits", "Energisant", "Cola"]
sous_rayons["Eaux"]=["Minerales", "De Source", "Magnesienne"]
sous_rayons["Lait"]=["Vache", "Amande", "Soja"]
sous_rayons["Vin"]=["Blanc", "Rouge", "Rose"]
sous_rayons["Spiritueux"]=["Vodka", "Whisky", "Gin"]
# for rayon in sous_rayons.keys():
#     rayon_list=sous_rayons[rayon]
#     for r in rayon_list:
#         i.execute(NOM_SR=r, NOM_RAYON=rayon)

rayon_table=Table('SOUS_SOUS_RAYON', metadata, autoload=True)
i = rayon_table.insert()
sous_sous_rayons=dict()
sous_sous_rayons["Blanc"]=["Alsace", "Loire", "Berry"]
sous_sous_rayons["Rose"]=["Languedoc", "Provence"]
sous_sous_rayons["Rouge"]=["Bordelais", "Bourgogne"]
sous_sous_rayons["Jus"]=["Frais", "Smoothies", "Non frais"]
for rayon in sous_sous_rayons.keys():
    rayon_list=sous_sous_rayons[rayon]
    for r in rayon_list:
        i.execute(NOM_SSR=r, NOM_SR=rayon)


