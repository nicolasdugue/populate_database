'''
Created on Apr 12, 2016

@author: nicolas
'''
#
#

import random
from math import pow

from datetime import timedelta
import datetime
from random import randint

from sqlalchemy import create_engine, MetaData, Table, select

def random_date(start, end):
    return start + timedelta(
        seconds=randint(0, int((end - start).total_seconds())))

def random_date_to_use():
	return random_date(datetime.datetime.strptime('01Feb2017', '%d%b%Y'), datetime.datetime.strptime('28Feb2017', '%d%b%Y')).strftime("%Y-%m-%d %H:%M:%S")


def generate_nb_articles():
	return random.randint(4, 70)

def get_qte():
	return random.randint(1,10)

db = create_engine('mysql://root@localhost/ProjetBDDL2')

db.echo = True  

metadata = MetaData(db)

panier = Table('PANIER', metadata, autoload=True)

item = Table('ITEM', metadata, autoload=True)


clients = Table('CLIENT', metadata, autoload=True)
s = select([clients.c.NO_CARTE])

Num_Carte = list(db.execute(s))

produits = Table('PRODUIT', metadata, autoload=True)
s = select([produits.c.REFERENCE])

references = list(db.execute(s))

for c in Num_Carte:
	nb_articles = generate_nb_articles()
	c=int(c[0])
	date=random_date_to_use()
	print(date)
	req = panier.insert()
	req.execute(NO_CARTE=c, DATE_HEURE=date)
	for i in range(nb_articles):
		try:
			qte=get_qte()
			ref=int(references[random.randint(0,len(references) - 1)][0])
			req=item.insert()
			req.execute(NO_CARTE=c, REFERENCE=ref, QUANTITE=qte)
		except:
			pass
		





