'''
Created on Apr 12, 2016

@author: nicolas
'''
#
#

import random
from math import pow

from sqlalchemy import create_engine, MetaData, Table

def generate_card():
    credit=0
    for i in range(1,10):
        credit+=random.randint(1, 9)*pow(10, i)
    return int(credit)

def get_email(nom, prenom):
    return nom+"."+prenom+"@univ-lorraine.fr"

def get_prenom():
    tab=["Adrien", "Isabelle", "Remi", "Helene", "Ievgen", "Ali", "Irina", "Mehdi", "Jean-Marc", "Yann", "Karadoc", "Perceval", "Omar", "Jimmy", "Avon", "Marlo"]
    return tab[random.randint(0, len(tab) -1)]

def get_nom():
    tab=["Stanfield", "Barksdale", "DuLac", "Adeba", "Kubrick", "Ionesco", "Tarantino", "Cobain", "Taha", "Davis", "Havoc", "Prodigy"]
    return tab[random.randint(0, len(tab) - 1)]

def get_tel():
    tel="02"
    for i in range(8):
        tel+=str(random.randint(1, 9))
    return tel

def get_adresse():
    prefixe=["Rue", "Avenue", "Boulevard", "Place"]
    num=random.randint(1,300)
    rue=["Sellier", "Lobau", "Charles3", "Stanislas", "Claudot", "Henri Deglin", "Grande", "des jardiniers", "jeanne d'arc", "saint-epvre"]
    ville=["Nancy", "Vandoeuvre", "Metz", "Laxou"]
    return str(num)+ " " + prefixe[random.randint(0,len(prefixe)-1)]+" "+rue[random.randint(0,len(rue)-1)]+", "+ ville[random.randint(0,len(ville)-1)]
    


import sys

db = create_engine('mysql://root:password@localhost/'+sys.argv[1])

db.echo = True  

metadata = MetaData(db)

clients = Table('CLIENT', metadata, autoload=True)

for i in range(50):
    card=generate_card()
    prenom=get_prenom()
    nom=get_nom()
    tel=get_tel()
    adresse=get_adresse()
    mail=get_email(nom, prenom)
    i = clients.insert()
    i.execute(NO_CARTE=card, CREDIT_CARTE=random.randint(1, 10), NOM=nom, PRENOM=prenom, ADRESSE=adresse, E_MAIL=mail, TELEPHONE=tel)
    

