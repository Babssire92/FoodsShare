DROP DATABASE IF EXISTS bddfoodsh;

CREATE DATABASE IF NOT EXISTS bddfoodsh;
USE bddfoodsh;
# -----------------------------------------------------------------------------
#       TABLE : USER
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS USER
 (
   ID_USER INTEGER(2) NOT NULL  ,
   NOM VARCHAR(255) NULL  ,
   PRENOM VARCHAR(255) NULL  ,
   EMAIL VARCHAR(255) NOT NULL  ,
   MDP VARCHAR(255) NOT NULL  ,
   ROLE VARCHAR(255) NULL  
   , PRIMARY KEY (ID_USER) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : ASSOCIATION
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ASSOCIATION
 (
   ID_ASSOCIATION INTEGER(2) NOT NULL  ,
   ID_DON INTEGER(2) NOT NULL  ,
   ID_USER INTEGER(2) NOT NULL  ,
   NOM VARCHAR(255) NULL  ,
   CONTACT VARCHAR(255) NULL  
   , PRIMARY KEY (ID_ASSOCIATION) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE ASSOCIATION
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_ASSOCIATION_DON
     ON ASSOCIATION (ID_DON ASC);

CREATE  INDEX I_FK_ASSOCIATION_USER
     ON ASSOCIATION (ID_USER ASC);

# -----------------------------------------------------------------------------
#       TABLE : RESTAURANT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS RESTAURANT
 (
   ID_RESTAURANT INTEGER(2) NOT NULL  ,
   ID_PLAT INTEGER(2) NOT NULL  ,
   ID_USER INTEGER(2) NOT NULL  ,
   NOM VARCHAR(255) NULL  ,
   ADRESSE VARCHAR(255) NULL  ,
   TELEPHONE BIGINT(4) NULL  
   , PRIMARY KEY (ID_RESTAURANT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE RESTAURANT
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_RESTAURANT_PLATS
     ON RESTAURANT (ID_PLAT ASC);

CREATE  INDEX I_FK_RESTAURANT_USER
     ON RESTAURANT (ID_USER ASC);

# -----------------------------------------------------------------------------
#       TABLE : DON
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS DON
 (
   ID_DON INTEGER(2) NOT NULL  ,
   MONTANT VARCHAR(255) NULL  ,
   DATE DATE NULL  
   , PRIMARY KEY (ID_DON) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : PLATS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PLATS
 (
   ID_PLAT INTEGER(2) NOT NULL  ,
   NOM VARCHAR(255) NULL  ,
   DESCRIPTION VARCHAR(255) NULL  ,
   PRIX VARCHAR(255) NULL  
   , PRIMARY KEY (ID_PLAT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : COMPOSER
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS COMPOSER
 (
   ID_DON INTEGER(2) NOT NULL  ,
   ID_PLAT INTEGER(2) NOT NULL  
   , PRIMARY KEY (ID_DON,ID_PLAT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE COMPOSER
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_COMPOSER_DON
     ON COMPOSER (ID_DON ASC);

CREATE  INDEX I_FK_COMPOSER_PLATS
     ON COMPOSER (ID_PLAT ASC);


# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------


ALTER TABLE ASSOCIATION 
  ADD FOREIGN KEY FK_ASSOCIATION_DON (ID_DON)
      REFERENCES DON (ID_DON) ;


ALTER TABLE ASSOCIATION 
  ADD FOREIGN KEY FK_ASSOCIATION_USER (ID_USER)
      REFERENCES USER (ID_USER) ;


ALTER TABLE RESTAURANT 
  ADD FOREIGN KEY FK_RESTAURANT_PLATS (ID_PLAT)
      REFERENCES PLATS (ID_PLAT) ;


ALTER TABLE RESTAURANT 
  ADD FOREIGN KEY FK_RESTAURANT_USER (ID_USER)
      REFERENCES USER (ID_USER) ;


ALTER TABLE COMPOSER 
  ADD FOREIGN KEY FK_COMPOSER_DON (ID_DON)
      REFERENCES DON (ID_DON) ;


ALTER TABLE COMPOSER 
  ADD FOREIGN KEY FK_COMPOSER_PLATS (ID_PLAT)
      REFERENCES PLATS (ID_PLAT) ;



#les procedures seront creer a partir de cette ligne