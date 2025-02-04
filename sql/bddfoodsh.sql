DROP DATABASE IF EXISTS bddfoodshare;

CREATE DATABASE IF NOT EXISTS bddfoodshare;
USE bddfoodshare;
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
   ID_USER INTEGER(2) NOT NULL  ,
   NOM VARCHAR(255) NULL  ,
   CONTACT VARCHAR(255) NULL  
   , PRIMARY KEY (ID_ASSOCIATION) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE ASSOCIATION
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_ASSOCIATION_USER
     ON ASSOCIATION (ID_USER ASC);

# -----------------------------------------------------------------------------
#       TABLE : RESTAURANT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS RESTAURANT
 (
   ID_RESTAURANT INTEGER(2) NOT NULL  ,
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


CREATE  INDEX I_FK_RESTAURANT_USER
     ON RESTAURANT (ID_USER ASC);

# -----------------------------------------------------------------------------
#       TABLE : DON
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS DON
 (
   ID_DON INTEGER(2) NOT NULL  ,
   ID_ASSOCIATION INTEGER(2) NOT NULL  ,
   MONTANT VARCHAR(255) NULL  ,
   DATE DATE NULL  
   , PRIMARY KEY (ID_DON) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE DON
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_DON_ASSOCIATION
     ON DON (ID_ASSOCIATION ASC);

# -----------------------------------------------------------------------------
#       TABLE : PLATS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PLATS
 (
   ID_PLAT INTEGER(2) NOT NULL  ,
   ID_RESTAURANT INTEGER(2) NOT NULL  ,
   NOM VARCHAR(255) NULL  ,
   DESCRIPTION VARCHAR(255) NULL  ,
   PRIX VARCHAR(255) NULL  
   , PRIMARY KEY (ID_PLAT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE PLATS
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_PLATS_RESTAURANT
     ON PLATS (ID_RESTAURANT ASC);

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
  ADD FOREIGN KEY FK_ASSOCIATION_USER (ID_USER)
      REFERENCES USER (ID_USER) ;


ALTER TABLE RESTAURANT 
  ADD FOREIGN KEY FK_RESTAURANT_USER (ID_USER)
      REFERENCES USER (ID_USER) ;


ALTER TABLE DON 
  ADD FOREIGN KEY FK_DON_ASSOCIATION (ID_ASSOCIATION)
      REFERENCES ASSOCIATION (ID_ASSOCIATION) ;


ALTER TABLE PLATS 
  ADD FOREIGN KEY FK_PLATS_RESTAURANT (ID_RESTAURANT)
      REFERENCES RESTAURANT (ID_RESTAURANT) ;


ALTER TABLE COMPOSER 
  ADD FOREIGN KEY FK_COMPOSER_DON (ID_DON)
      REFERENCES DON (ID_DON) ;


ALTER TABLE COMPOSER 
  ADD FOREIGN KEY FK_COMPOSER_PLATS (ID_PLAT)
      REFERENCES PLATS (ID_PLAT) ;




DELIMITER $$
CREATE PROCEDURE insertUser (
    IN p_nom VARCHAR(255),
    IN p_prenom VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_mdp VARCHAR(255),
    IN p_role VARCHAR(255)
)
BEGIN
    INSERT INTO USER (NOM, PRENOM, EMAIL, MDP, ROLE)
    VALUES (p_nom, p_prenom, p_email, p_mdp, p_role);
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE insertAssociation (
    IN p_email_user VARCHAR(255),
    IN p_nom VARCHAR(255),
    IN p_contact VARCHAR(255)
)
BEGIN
    DECLARE p_id_user INT;

    -- Récupération de l'ID utilisateur
    SELECT ID_USER INTO p_id_user FROM USER WHERE EMAIL = p_email_user;

    IF p_id_user IS NOT NULL THEN
        INSERT INTO ASSOCIATION (ID_USER, NOM, CONTACT)
        VALUES (p_id_user, p_nom, p_contact);
    END IF;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE insertRestaurant (
    IN p_email_user VARCHAR(255),
    IN p_nom VARCHAR(255),
    IN p_adresse VARCHAR(255),
    IN p_telephone BIGINT
)
BEGIN
    DECLARE p_id_user INT;

    -- Récupération de l'ID utilisateur
    SELECT ID_USER INTO p_id_user FROM USER WHERE EMAIL = p_email_user;

    IF p_id_user IS NOT NULL THEN
        INSERT INTO RESTAURANT (ID_USER, NOM, ADRESSE, TELEPHONE)
        VALUES (p_id_user, p_nom, p_adresse, p_telephone);
    END IF;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE insertPlat (
    IN p_nom_restaurant VARCHAR(255),
    IN p_nom VARCHAR(255),
    IN p_description VARCHAR(255),
    IN p_prix VARCHAR(255)
)
BEGIN
    DECLARE p_id_restaurant INT;

    -- Récupération de l'ID du restaurant
    SELECT ID_RESTAURANT INTO p_id_restaurant FROM RESTAURANT WHERE NOM = p_nom_restaurant;

    IF p_id_restaurant IS NOT NULL THEN
        INSERT INTO PLATS (ID_RESTAURANT, NOM, DESCRIPTION, PRIX)
        VALUES (p_id_restaurant, p_nom, p_description, p_prix);
    END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE insertDon (
    IN p_nom_association VARCHAR(255),
    IN p_montant VARCHAR(255),
    IN p_date DATE
)
BEGIN
    DECLARE p_id_association INT;

    -- Récupération de l'ID de l'association
    SELECT ID_ASSOCIATION INTO p_id_association FROM ASSOCIATION WHERE NOM = p_nom_association;

    IF p_id_association IS NOT NULL THEN
        INSERT INTO DON (ID_ASSOCIATION, MONTANT, DATE)
        VALUES (p_id_association, p_montant, p_date);
    END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE selectUserById (
    IN p_id_user INT
)
BEGIN
    SELECT * FROM USER WHERE ID_USER = p_id_user;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE selectAllUsers ()
BEGIN
    SELECT * FROM USER;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE updateUser (
    IN p_id_user INT,
    IN p_nom VARCHAR(255),
    IN p_prenom VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_mdp VARCHAR(255),
    IN p_role VARCHAR(255)
)
BEGIN
    UPDATE USER
    SET NOM = p_nom, PRENOM = p_prenom, EMAIL = p_email, MDP = p_mdp, ROLE = p_role
    WHERE ID_USER = p_id_user;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE deleteUser (
    IN p_id_user INT
)
BEGIN
    DELETE FROM USER WHERE ID_USER = p_id_user;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE getAssociationById (IN p_id_association INT)
BEGIN
    SELECT * FROM ASSOCIATION WHERE ID_ASSOCIATION = p_id_association;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE getAllAssociations ()
BEGIN
    SELECT * FROM ASSOCIATION;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE updateAssociation (
    IN p_id_association INT,
    IN p_nom VARCHAR(255),
    IN p_contact VARCHAR(255)
)
BEGIN
    UPDATE ASSOCIATION 
    SET NOM = p_nom, CONTACT = p_contact
    WHERE ID_ASSOCIATION = p_id_association;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE deleteAssociation (IN p_id_association INT)
BEGIN
    DELETE FROM ASSOCIATION WHERE ID_ASSOCIATION = p_id_association;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE getRestaurantById (IN p_id_restaurant INT)
BEGIN
    SELECT * FROM RESTAURANT WHERE ID_RESTAURANT = p_id_restaurant;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE getAllRestaurants ()
BEGIN
    SELECT * FROM RESTAURANT;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE updateRestaurant (
    IN p_id_restaurant INT,
    IN p_nom VARCHAR(255),
    IN p_adresse VARCHAR(255),
    IN p_telephone BIGINT
)
BEGIN
    UPDATE RESTAURANT 
    SET NOM = p_nom, ADRESSE = p_adresse, TELEPHONE = p_telephone
    WHERE ID_RESTAURANT = p_id_restaurant;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE deleteRestaurant (IN p_id_restaurant INT)
BEGIN
    DELETE FROM RESTAURANT WHERE ID_RESTAURANT = p_id_restaurant;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE getPlatById (IN p_id_plat INT)
BEGIN
    SELECT * FROM PLATS WHERE ID_PLAT = p_id_plat;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE getAllPlats ()
BEGIN
    SELECT * FROM PLATS;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE updatePlat (
    IN p_id_plat INT,
    IN p_nom VARCHAR(255),
    IN p_description VARCHAR(255),
    IN p_prix VARCHAR(255)
)
BEGIN
    UPDATE PLATS 
    SET NOM = p_nom, DESCRIPTION = p_description, PRIX = p_prix
    WHERE ID_PLAT = p_id_plat;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE deletePlat (IN p_id_plat INT)
BEGIN
    DELETE FROM PLATS WHERE ID_PLAT = p_id_plat;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE getDonById (IN p_id_don INT)
BEGIN
    SELECT * FROM DON WHERE ID_DON = p_id_don;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE getAllDons ()
BEGIN
    SELECT * FROM DON;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE updateDon (
    IN p_id_don INT,
    IN p_montant VARCHAR(255),
    IN p_date DATE
)
BEGIN
    UPDATE DON 
    SET MONTANT = p_montant, DATE = p_date
    WHERE ID_DON = p_id_don;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE deleteDon (IN p_id_don INT)
BEGIN
    DELETE FROM DON WHERE ID_DON = p_id_don;
END$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE getPlatsByDonId (IN p_id_don INT)
BEGIN
    SELECT P.* 
    FROM PLATS P
    INNER JOIN COMPOSER C ON P.ID_PLAT = C.ID_PLAT
    WHERE C.ID_DON = p_id_don;
END$$
DELIMITER ;

