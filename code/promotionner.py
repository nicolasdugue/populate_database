'''
Created on Apr 13, 2016

@author: nicolas
'''
from sqlalchemy import create_engine, MetaData, Table
import datetime
import random

def get_code():
    credit=0
    for i in range(1,10):
        credit+=random.randint(1, 9)*pow(10, i)
    return int(credit)

def get_date_debut():
    return datetime.datetime(2016,4,random.randint(1,30),0,0,0)
    
def get_date_fin():
    return datetime.datetime(2016,5,random.randint(1,30),0,0,0)

def get_max_client():
    return random.randint(1,3)

import sys

db = create_engine('mysql://root:password@localhost/'+sys.argv[1])

db.echo = True

metadata = MetaData(db)
promotions = Table('PROMOTION', metadata, autoload=True)
ip = promotions.insert()

lot=Table('P_LOT', metadata, autoload=True)
il=lot.insert()

loti=Table('P_INDIVIDUELLE', metadata, autoload=True)
ili=loti.insert()



for i in range(20):
    code=get_code()
    ip.execute(CODE_PROMO=code, DATE_DEBUT=get_date_debut(), DATE_FIN=get_date_fin(), MAX_PAR_CLIENT=get_max_client())
    r=random.randint(0,2)
    #Promo par lot
    if r != 2:
        il.execute(CODE_PROMO=code, NB_ACHETES=random.randint(2,3), NB_GRATUITS=1)
    else:
        if random.randint(0,1) ==0:
            ili.execute(CODE_PROMO=code,IMMEDIATE_VF=str(random.randint(0,1)), REDUCTION_ABSOLUE=random.randint(1,2))
        else:
            ili.execute(CODE_PROMO=code,IMMEDIATE_VF=str(random.randint(0,1)), REDUCTION_ABSOLUE=random.randint(1,2)*10)
