
DROP TABLE IF EXISTS CATEGORIE ;

DROP TABLE IF EXISTS SOUS_SOUS_RAYON ;

DROP TABLE IF EXISTS SOUS_RAYON ;

DROP TABLE IF EXISTS PROMOTION ;

DROP TABLE IF EXISTS P_LOT ;

DROP TABLE IF EXISTS PANIER ;

DROP TABLE IF EXISTS CLIENT ;

DROP TABLE IF EXISTS PRODUIT ;

DROP TABLE IF EXISTS RAYON ;

DROP TABLE IF EXISTS P_INDIVIDUELLE ;

DROP TABLE IF EXISTS PLANNING ;

DROP TABLE IF EXISTS SSR_P ;

DROP TABLE IF EXISTS SR_P ;

DROP TABLE IF EXISTS OBJET_PROMO ;

DROP TABLE IF EXISTS ITEM ;


-- -----------------------------------------------------------------------------
--       TABLE : CATEGORIE
-- -----------------------------------------------------------------------------

CREATE TABLE CATEGORIE
   (
    NOM_CATEGORIE CHAR(32)  NOT NULL
,   CONSTRAINT PK_CATEGORIE PRIMARY KEY (NOM_CATEGORIE)  
   ) ;


-- -----------------------------------------------------------------------------
--       TABLE : RAYON
-- -----------------------------------------------------------------------------

CREATE TABLE RAYON
   (
    NOM_RAYON CHAR(32)  NOT NULL,
    NOM_CATEGORIE CHAR(32)  NOT NULL
,   CONSTRAINT PK_RAYON PRIMARY KEY (NOM_RAYON)  
   ) ;


-- -----------------------------------------------------------------------------
--       TABLE : SOUS_RAYON
-- -----------------------------------------------------------------------------

CREATE TABLE SOUS_RAYON
   (
    NOM_SR CHAR(32)  NOT NULL,
    NOM_RAYON CHAR(32)  NOT NULL
,   CONSTRAINT PK_SOUS_RAYON PRIMARY KEY (NOM_SR)  
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : SOUS_SOUS_RAYON
-- -----------------------------------------------------------------------------

CREATE TABLE SOUS_SOUS_RAYON
   (
    NOM_SSR VARCHAR(128)  NOT NULL,
    NOM_SR CHAR(32)  NOT NULL
,   CONSTRAINT PK_SOUS_SOUS_RAYON PRIMARY KEY (NOM_SSR)  
   ) ;


-- -----------------------------------------------------------------------------
--       TABLE : SSR_P
-- -----------------------------------------------------------------------------

CREATE TABLE SSR_P
   (
    REFERENCE CHAR(32)  NOT NULL,
    NOM_SSR VARCHAR(128)  NOT NULL
,   CONSTRAINT PK_SSR_P PRIMARY KEY (REFERENCE, NOM_SSR)  
   ) ;


-- -----------------------------------------------------------------------------
--       TABLE : SR_P
-- -----------------------------------------------------------------------------

CREATE TABLE SR_P
   (
    REFERENCE CHAR(32)  NOT NULL,
    NOM_SR CHAR(32)  NOT NULL
,   CONSTRAINT PK_SR_P PRIMARY KEY (REFERENCE, NOM_SR)  
   ) ;


-- -----------------------------------------------------------------------------
--       TABLE : PROMOTION
-- -----------------------------------------------------------------------------

CREATE TABLE PROMOTION
   (
    CODE_PROMO VARCHAR(128)  NOT NULL,
    DATE_DEBUT DATE  NOT NULL,
    DATE_FIN DATE  NOT NULL,
    MAX_PAR_CLIENT DECIMAL(1)  NOT NULL
,   CONSTRAINT PK_PROMOTION PRIMARY KEY (CODE_PROMO)  
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : P_LOT
-- -----------------------------------------------------------------------------

CREATE TABLE P_LOT
   (
    CODE_PROMO VARCHAR(128)  NOT NULL,
    NB_ACHETES DECIMAL(1)  NOT NULL,
    NB_GRATUITS DECIMAL(1)  NOT NULL
,   CONSTRAINT PK_P_LOT PRIMARY KEY (CODE_PROMO)  
   ) ;


-- -----------------------------------------------------------------------------
--       TABLE : P_INDIVIDUELLE
-- -----------------------------------------------------------------------------

CREATE TABLE P_INDIVIDUELLE
   (
    CODE_PROMO VARCHAR(128)  NOT NULL,
    REDUCTION_ABSOLUE DECIMAL(13,2)  NULL,
    REDUCTION_RELATIVE DECIMAL(1)  NULL,
    IMMEDIATE_VF CHAR(32)  NULL
,   CONSTRAINT PK_P_INDIVIDUELLE PRIMARY KEY (CODE_PROMO)  
   ) ;

-- -----------------------------------------------------------------------------
--       TABLE : CLIENT
-- -----------------------------------------------------------------------------

CREATE TABLE CLIENT
   (
    NO_CARTE DECIMAL(10)  NOT NULL,
    CREDIT_CARTE DECIMAL(13,2) 
      DEFAULT 0 NOT NULL,
    NOM VARCHAR(128)  NULL,
    PRENOM VARCHAR(128)  NOT NULL,
    ADRESSE VARCHAR(128)  NOT NULL,
    E_MAIL VARCHAR(128)  NOT NULL,
    TELEPHONE CHAR(32)  NOT NULL
,   CONSTRAINT PK_CLIENT PRIMARY KEY (NO_CARTE)  
   ) ;



-- -----------------------------------------------------------------------------
--       TABLE : PANIER
-- -----------------------------------------------------------------------------

CREATE TABLE PANIER
   (
    NO_CARTE DECIMAL(4)  NOT NULL,
    DATE_HEURE DATE  NOT NULL,
    VIDE_VF CHAR(1) 
      DEFAULT 'V' NOT NULL CHECK (VIDE_VF IN ('V','F')),
    DATEVALIDATION DATE  NULL,
    MONTANT DECIMAL(13,2)  NULL,
    CONSTRAINT PK_PANIER PRIMARY KEY (NO_CARTE)  
   ) ;


-- -----------------------------------------------------------------------------
--       TABLE : PRODUIT
-- -----------------------------------------------------------------------------

CREATE TABLE PRODUIT
   (
    REFERENCE CHAR(32)  NOT NULL,
    LIBELLE VARCHAR(128)  NOT NULL,
    MARQUE VARCHAR(128)  NOT NULL,
    FICHIER_IMAGE VARCHAR(128)  NOT NULL,
    PRIX_UNIT_HT DECIMAL(13,2)  NOT NULL,
    LIQUIDE_VF CHAR(1)  NOT NULL CHECK (LIQUIDE_VF IN ('V','F')),
    PRIX_KILO_OU_LITRE DECIMAL(13,2)  NOT NULL,
    QUANTITE_STOCK DECIMAL(10)  NOT NULL CHECK (QUANTITE_STOCK >=0),
    CONSTRAINT PK_PRODUIT PRIMARY KEY (REFERENCE)  
   ) ;






-- -----------------------------------------------------------------------------
--       TABLE : PLANNING
-- -----------------------------------------------------------------------------

CREATE TABLE PLANNING
   (
    DATE_HEURE DATE  NOT NULL,
    NOMBRE_LIVRAISONS_MAX DECIMAL(1)  NOT NULL
,   CONSTRAINT PK_PLANNING PRIMARY KEY (DATE_HEURE)  
   ) ;




-- -----------------------------------------------------------------------------
--       TABLE : OBJET_PROMO
-- -----------------------------------------------------------------------------

CREATE TABLE OBJET_PROMO
   (
    CODE_PROMO VARCHAR(128)  NOT NULL,
    REFERENCE CHAR(32)  NOT NULL
,   CONSTRAINT PK_OBJET_PROMO PRIMARY KEY (CODE_PROMO, REFERENCE)  
   ) ;



-- -----------------------------------------------------------------------------
--       TABLE : ITEM
-- -----------------------------------------------------------------------------

CREATE TABLE ITEM
   (
    NO_CARTE DECIMAL(10)  NOT NULL,
    REFERENCE CHAR(32)  NOT NULL,
    QUANTITE DECIMAL(3) 
      DEFAULT 1 NOT NULL CHECK (QUANTITE >=1)
,   CONSTRAINT PK_ITEM PRIMARY KEY (NO_CARTE, REFERENCE)  
   ) ;


-- -----------------------------------------------------------------------------
--       CREATION DES REFERENCES DE TABLE (CLES ETRANGERES)
-- -----------------------------------------------------------------------------


ALTER TABLE SOUS_SOUS_RAYON ADD (
     CONSTRAINT FK_SOUS_SOUS_RAYON_SOUS_RAYON
          FOREIGN KEY (NOM_SR)
               REFERENCES SOUS_RAYON (NOM_SR))   ;

ALTER TABLE SOUS_RAYON ADD (
     CONSTRAINT FK_SOUS_RAYON_RAYON
          FOREIGN KEY (NOM_RAYON)
               REFERENCES RAYON (NOM_RAYON))   ;

ALTER TABLE P_LOT ADD (
     CONSTRAINT FK_P_LOT_PROMOTION
          FOREIGN KEY (CODE_PROMO)
               REFERENCES PROMOTION (CODE_PROMO))   ;

ALTER TABLE PANIER ADD (
     CONSTRAINT FK_PANIER_CLIENT
          FOREIGN KEY (NO_CARTE)
               REFERENCES CLIENT (NO_CARTE))   ;

ALTER TABLE PANIER ADD (
     CONSTRAINT FK_PANIER_PLANNING
          FOREIGN KEY (DATE_HEURE)
               REFERENCES PLANNING (DATE_HEURE))   ;

ALTER TABLE RAYON ADD (
     CONSTRAINT FK_RAYON_CATEGORIE
          FOREIGN KEY (NOM_CATEGORIE)
               REFERENCES CATEGORIE (NOM_CATEGORIE))   ;

ALTER TABLE P_INDIVIDUELLE ADD (
     CONSTRAINT FK_P_INDIVIDUELLE_PROMOTION
          FOREIGN KEY (CODE_PROMO)
               REFERENCES PROMOTION (CODE_PROMO))   ;

ALTER TABLE SSR_P ADD (
     CONSTRAINT FK_SSR_P_PRODUIT
          FOREIGN KEY (REFERENCE)
               REFERENCES PRODUIT (REFERENCE))   ;

ALTER TABLE SSR_P ADD (
     CONSTRAINT FK_SSR_P_SOUS_SOUS_RAYON
          FOREIGN KEY (NOM_SSR)
               REFERENCES SOUS_SOUS_RAYON (NOM_SSR))   ;

ALTER TABLE SR_P ADD (
     CONSTRAINT FK_SR_P_PRODUIT
          FOREIGN KEY (REFERENCE)
               REFERENCES PRODUIT (REFERENCE))   ;

ALTER TABLE SR_P ADD (
     CONSTRAINT FK_SR_P_SOUS_RAYON
          FOREIGN KEY (NOM_SR)
               REFERENCES SOUS_RAYON (NOM_SR))   ;

ALTER TABLE OBJET_PROMO ADD (
     CONSTRAINT FK_OBJET_PROMO_PROMOTION
          FOREIGN KEY (CODE_PROMO)
               REFERENCES PROMOTION (CODE_PROMO))   ;

ALTER TABLE OBJET_PROMO ADD (
     CONSTRAINT FK_OBJET_PROMO_PRODUIT
          FOREIGN KEY (REFERENCE)
               REFERENCES PRODUIT (REFERENCE))   ;

ALTER TABLE ITEM ADD (
     CONSTRAINT FK_ITEM_PANIER
          FOREIGN KEY (NO_CARTE)
               REFERENCES PANIER (NO_CARTE))   ;

ALTER TABLE ITEM ADD (
     CONSTRAINT FK_ITEM_PRODUIT
          FOREIGN KEY (REFERENCE)
               REFERENCES PRODUIT (REFERENCE))   ;

ALTER TABLE PRODUIT MODIFY COLUMN FICHIER_IMAGE VARCHAR(255) NOT NULL DEFAULT '';


-- -----------------------------------------------------------------------------
--                FIN DE GENERATION
-- -----------------------------------------------------------------------------
