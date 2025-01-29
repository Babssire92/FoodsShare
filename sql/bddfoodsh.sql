DROP DATABASE IF EXISTS bddfoodshare;
CREATE DATABASE bddfoodshare;
USE bddfoodshare;

-- Table : ASSOCIATION
CREATE TABLE association (
    id_association INT(5) NOT NULL AUTO_INCREMENT,
    nom VARCHAR(50),
    contact VARCHAR(50),
    PRIMARY KEY (id_association)
);

-- Table : RESTAURANT
CREATE TABLE restaurant (
    id_restaurant INT(5) NOT NULL AUTO_INCREMENT,
    nom VARCHAR(50),
    adresse VARCHAR(100),
    telephone BIGINT(10),
    PRIMARY KEY (id_restaurant)
);

-- Table : USER
CREATE TABLE user (
    id_user INT(5) NOT NULL AUTO_INCREMENT,
    id_restaurant INT(5),
    id_association INT(5),
    nom VARCHAR(50),
    prenom VARCHAR(50),
    email VARCHAR(50) NOT NULL,
    mdp VARCHAR(50) NOT NULL,
    role VARCHAR(50),
    PRIMARY KEY (id_user),
    FOREIGN KEY (id_restaurant) REFERENCES restaurant (id_restaurant),
    FOREIGN KEY (id_association) REFERENCES association (id_association)
);

-- Table : DON
CREATE TABLE don (
    id_don INT(5) NOT NULL AUTO_INCREMENT,
    id_association INT(5),
    montant FLOAT,
    date DATE,
    PRIMARY KEY (id_don),
    FOREIGN KEY (id_association) REFERENCES association (id_association)
);

-- Table : PLATS
CREATE TABLE plats (
    id_plat INT(5) NOT NULL AUTO_INCREMENT,
    id_restaurant INT(5),
    id_don INT(5),
    nom VARCHAR(60),
    description VARCHAR(100),
    prix FLOAT,
    PRIMARY KEY (id_plat),
    FOREIGN KEY (id_restaurant) REFERENCES restaurant (id_restaurant),
    FOREIGN KEY (id_don) REFERENCES don (id_don)
);
