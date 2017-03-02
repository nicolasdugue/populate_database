'''
Created on Apr 12, 2016

@author: nicolas
'''
import random
def generate_ref():
    credit=0
    for i in range(1,20):
        credit+=random.randint(1, 9)*pow(10, i)
    return int(credit)

def get_marques():
    return ["Pouce", "MarqueAPasReperer", "PastopBudget", "Eco-", "Pierre Chanau"]

def get_prix():
    return random.randint(1,15)+ random.randint(1,99)/100

def get_quantite():
    return random.randint(100,300)

sous_sous_rayons=dict()
sous_sous_rayons["Alsace"]=["Pinot Gris", "Pinot Blanc"]
sous_sous_rayons["Loire"]=["Vouvray", "MontLouis"]
sous_sous_rayons["Berry"]=["Sancerre", "Reuilly"]
sous_sous_rayons["Languedoc"]=["Costieres de Nimes"]
sous_sous_rayons["Provence"]=["Bandol", "Listel"]
sous_sous_rayons["Bordelais"]=["Pessac", "Medoc"]
sous_sous_rayons["Bourgogne"]=["Beaune", "Chablis"]
sous_sous_rayons["Frais"]=["Reveil fruite", "Orange breeakfast"]
sous_sous_rayons["Smoothies"]=["Pomme kiwi", "Litchi Orange"]
sous_sous_rayons["Non frais"]=["Orange", "Pomme"]

sous_rayons=["Boeuf", "Veau", "Agneau", "Porc","Poulet", "Dinde", "Canard", "Nuggets", "Vodka", "Whisky", "Gin"]
s_r=dict()
s_r["Filets"]=['Saumon', 'Truite', 'Daurade']
s_r["Coquillages"]=["Palourdes", "Moules", "Huitres"]
s_r["Crustaces"]=["Crevettes", "Homards", "Gambas"]
s_r["Soupes"]=["Bisque", "Bouillabaisse"]
s_r["Fruits frais"]=["Pommes", "Kiwis", "Poires", "Bananes"]
s_r["Fruits secs"]=["Amandes", "Noix", "Noisettes"]
s_r["Legumes"]=["Chou", "Brocoli", "Radis"]
s_r["Salades Sachet"]=["Mache", "Roquette", "Laitue"]
s_r["Aux fruits"]=["Oasis Pomme cassis", "Oasis tropical"]
s_r["Energisant"]=["Taureau Rouge", "Coka", "Speedup"]
s_r["Cola"]=["Pepsi", "Coca"]
s_r["Minerales"]=["Volvic", "Evian"]
s_r["De Source"]=["Rozana", "Perrier"]
s_r["Magnesienne"]=["Hepar", "Rozana"]
s_r["Vache"]=["Lait de Vache"]
s_r["Amande"]=["Lait d'amande"]
s_r["Soja"]=["Lait de soja"]


from sqlalchemy import create_engine, MetaData, Table


db = create_engine('mysql://root:password@localhost/ProjetBDDL2')

db.echo = True

metadata = MetaData(db)

produits = Table('PRODUIT', metadata, autoload=True)
ip = produits.insert()

sr_p = Table('SR_P', metadata, autoload=True)
isr=sr_p.insert()

ssr_p = Table('SSR_P', metadata, autoload=True)
issr=ssr_p.insert()

for ssr in sous_sous_rayons.keys():
    items=sous_sous_rayons[ssr]
    for it in items:
        marques=get_marques()
        for marque in marques[random.randint(0, 1):random.randint(2, 4)]:
            reference=generate_ref()
            prix_unit=get_prix()
            prix_kilo=get_prix()
            stock=get_quantite()
            liquide="F"
            ip.execute(REFERENCE=reference, LIBELLE=it, MARQUE=marque, PRIX_UNIT_HT=prix_unit, PRIX_KILO_OU_LITRE=prix_kilo, QUANTITE_STOCK=stock, LIQUIDE_VF=liquide)
            issr.execute(REFERENCE=reference, NOM_SSR=ssr)
        
for s in sous_rayons:
    marques=get_marques()
    for marque in marques[random.randint(0, 1):random.randint(2, 4)]:
        reference=generate_ref()
        prix_unit=get_prix()
        prix_kilo=get_prix()
        stock=get_quantite()
        liquide="F"
        ip.execute(REFERENCE=reference, LIBELLE=s, MARQUE=marque, PRIX_UNIT_HT=prix_unit, PRIX_KILO_OU_LITRE=prix_kilo, QUANTITE_STOCK=stock, LIQUIDE_VF=liquide)
        isr.execute(REFERENCE=reference, NOM_SR=s)
        
for s in s_r.keys():
    libelles=s_r[s]
    for libelle in libelles:
        for marque in marques[random.randint(0, 1):random.randint(2, 4)]:
            reference=generate_ref()
            prix_unit=get_prix()
            prix_kilo=get_prix()
            stock=get_quantite()
            liquide="F"
            ip.execute(REFERENCE=reference, LIBELLE=libelle, MARQUE=marque, PRIX_UNIT_HT=prix_unit, PRIX_KILO_OU_LITRE=prix_kilo, QUANTITE_STOCK=stock, LIQUIDE_VF=liquide)
            isr.execute(REFERENCE=reference, NOM_SR=s)
    
    
