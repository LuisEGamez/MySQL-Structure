-- MySQL Script generated by MySQL Workbench
-- Mon Feb 28 22:41:59 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spotify` DEFAULT CHARACTER SET utf8 ;
USE `spotify` ;

-- -----------------------------------------------------
-- Table `spotify`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`usuario` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `fecha_nacimento` DATE NULL,
  `sexo` VARCHAR(1) NULL,
  `cp` VARCHAR(10) NULL,
  `premiun` VARCHAR(1) NULL,
  PRIMARY KEY (`id_user`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`tarjeta_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`tarjeta_info` (
  `id_tarjeta_info` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(20) NOT NULL,
  `fecha_caducidad` DATE NOT NULL,
  `cvc` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id_tarjeta_info`),
  UNIQUE INDEX `numero_UNIQUE` (`numero` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`paypal_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`paypal_info` (
  `id_paypal` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(45) NULL,
  PRIMARY KEY (`id_paypal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`subcripcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`subcripcion` (
  `id_subcripciones` INT NOT NULL AUTO_INCREMENT,
  `fecha_inicio` DATE NOT NULL,
  `fecha_renovacion` DATE NOT NULL,
  `forma_pago` ENUM("tarjeta", "paypal") NOT NULL,
  `user_id` INT NOT NULL,
  `tarjeta_info_id` INT NULL,
  `paypal_info_id` INT NULL,
  PRIMARY KEY (`id_subcripciones`),
  INDEX `fk_subcripciones_premiun_user_idx` (`user_id` ASC) ,
  INDEX `fk_subcripciones_tarjeta_info1_idx` (`tarjeta_info_id` ASC) ,
  INDEX `fk_subcripciones_paypal_info1_idx` (`paypal_info_id` ASC) ,
  CONSTRAINT `fk_subcripciones_premiun_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`usuario` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subcripciones_tarjeta_info1`
    FOREIGN KEY (`tarjeta_info_id`)
    REFERENCES `spotify`.`tarjeta_info` (`id_tarjeta_info`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subcripciones_paypal_info1`
    FOREIGN KEY (`paypal_info_id`)
    REFERENCES `spotify`.`paypal_info` (`id_paypal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlist` (
  `id_playlists` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NULL,
  `num_canciones` INT NULL,
  `fecha_creacion` DATE NULL,
  `eliminada` VARCHAR(1) NULL,
  `fecha_eliminacion` DATE NULL,
  `user_id` INT NOT NULL,
  `playlist_compartida` VARCHAR(1) NULL,
  PRIMARY KEY (`id_playlists`),
  INDEX `fk_playlists_premiun_user1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_playlists_premiun_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`usuario` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artista` (
  `id_artista` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `imagen` VARCHAR(45) NULL,
  PRIMARY KEY (`id_artista`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`albun`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`albun` (
  `id_albun` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NULL,
  `ayno_publicacion` DATE NULL,
  `imagen` VARCHAR(45) NULL,
  `artista_id` INT NOT NULL,
  PRIMARY KEY (`id_albun`),
  INDEX `fk_albun_artista1_idx` (`artista_id` ASC) ,
  CONSTRAINT `fk_albun_artista1`
    FOREIGN KEY (`artista_id`)
    REFERENCES `spotify`.`artista` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`cancion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`cancion` (
  `id_cancion` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NULL,
  `duracion` INT NULL,
  `num_reproducciones` INT NULL,
  `albun_id` INT NOT NULL,
  PRIMARY KEY (`id_cancion`),
  INDEX `fk_cancion_albun1_idx` (`albun_id` ASC) ,
  CONSTRAINT `fk_cancion_albun1`
    FOREIGN KEY (`albun_id`)
    REFERENCES `spotify`.`albun` (`id_albun`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`cancion_playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`cancion_playlist` (
  `cancion_id_cancion` INT NOT NULL,
  `playlist_id_playlists` INT NOT NULL,
  PRIMARY KEY (`cancion_id_cancion`, `playlist_id_playlists`),
  INDEX `fk_cancion_playlist_playlist1_idx` (`playlist_id_playlists` ASC) ,
  CONSTRAINT `fk_cancion_playlist_cancion1`
    FOREIGN KEY (`cancion_id_cancion`)
    REFERENCES `spotify`.`cancion` (`id_cancion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cancion_playlist_playlist1`
    FOREIGN KEY (`playlist_id_playlists`)
    REFERENCES `spotify`.`playlist` (`id_playlists`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`playlist_compartida_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlist_compartida_usuario` (
  `playlist_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  INDEX `fk_playlist_usuario_free_playlist1_idx` (`playlist_id` ASC) ,
  INDEX `fk_playlist_compartida_usuario_premiun_user1_idx` (`user_id` ASC) ,
  PRIMARY KEY (`playlist_id`, `user_id`),
  CONSTRAINT `fk_playlist_usuario_free_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `spotify`.`playlist` (`id_playlists`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlist_compartida_usuario_premiun_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`usuario` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`cancion_favorita_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`cancion_favorita_usuario` (
  `usuario_id_user` INT NOT NULL,
  `cancion_id_cancion` INT NOT NULL,
  INDEX `fk_cancion_favorita_usuario_usuario1_idx` (`usuario_id_user` ASC) ,
  INDEX `fk_cancion_favorita_usuario_cancion1_idx` (`cancion_id_cancion` ASC) ,
  PRIMARY KEY (`usuario_id_user`, `cancion_id_cancion`),
  CONSTRAINT `fk_cancion_favorita_usuario_usuario1`
    FOREIGN KEY (`usuario_id_user`)
    REFERENCES `spotify`.`usuario` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cancion_favorita_usuario_cancion1`
    FOREIGN KEY (`cancion_id_cancion`)
    REFERENCES `spotify`.`cancion` (`id_cancion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`artista_favorito_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artista_favorito_usuario` (
  `usuario_id_user` INT NOT NULL,
  `artista_id_artista` INT NOT NULL,
  INDEX `fk_artista_favorito_usuario_usuario1_idx` (`usuario_id_user` ASC) ,
  INDEX `fk_artista_favorito_usuario_artista1_idx` (`artista_id_artista` ASC) ,
  PRIMARY KEY (`usuario_id_user`, `artista_id_artista`),
  CONSTRAINT `fk_artista_favorito_usuario_usuario1`
    FOREIGN KEY (`usuario_id_user`)
    REFERENCES `spotify`.`usuario` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artista_favorito_usuario_artista1`
    FOREIGN KEY (`artista_id_artista`)
    REFERENCES `spotify`.`artista` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`cancion_playlist_compartida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`cancion_playlist_compartida` (
  `usuario_id_user` INT NOT NULL,
  `cancion_id_cancion` INT NOT NULL,
  `fecha_add_cancion` DATE NULL,
  `playlist_compartida_usuario_playlist_id` INT NOT NULL,
  `playlist_compartida_usuario_user_id` INT NOT NULL,
  INDEX `fk_cancion_playlist_compartida_usuario1_idx` (`usuario_id_user` ASC) ,
  INDEX `fk_cancion_playlist_compartida_cancion1_idx` (`cancion_id_cancion` ASC) ,
  PRIMARY KEY (`usuario_id_user`, `cancion_id_cancion`, `playlist_compartida_usuario_playlist_id`, `playlist_compartida_usuario_user_id`),
  INDEX `fk_cancion_playlist_compartida_playlist_compartida_usuario1_idx` (`playlist_compartida_usuario_playlist_id` ASC, `playlist_compartida_usuario_user_id` ASC) ,
  CONSTRAINT `fk_cancion_playlist_compartida_usuario1`
    FOREIGN KEY (`usuario_id_user`)
    REFERENCES `spotify`.`usuario` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cancion_playlist_compartida_cancion1`
    FOREIGN KEY (`cancion_id_cancion`)
    REFERENCES `spotify`.`cancion` (`id_cancion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cancion_playlist_compartida_playlist_compartida_usuario1`
    FOREIGN KEY (`playlist_compartida_usuario_playlist_id` , `playlist_compartida_usuario_user_id`)
    REFERENCES `spotify`.`playlist_compartida_usuario` (`playlist_id` , `user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`pagos` (
  `id_pagos` INT NOT NULL AUTO_INCREMENT,
  `fecha_pago` DATE NULL,
  `total` DOUBLE NULL,
  `subcripcion_id` INT NOT NULL,
  PRIMARY KEY (`id_pagos`),
  INDEX `fk_pagos_subcripcion1_idx` (`subcripcion_id` ASC) ,
  CONSTRAINT `fk_pagos_subcripcion1`
    FOREIGN KEY (`subcripcion_id`)
    REFERENCES `spotify`.`subcripcion` (`id_subcripciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`artista_artista_relacionados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artista_artista_relacionados` (
  `artista_id` INT NOT NULL,
  `artista_id` INT NOT NULL,
  INDEX `fk_artista_artista_artista1_idx` (`artista_id` ASC) ,
  INDEX `fk_artista_artista_artista2_idx` (`artista_id` ASC) ,
  PRIMARY KEY (`artista_id`, `artista_id`),
  CONSTRAINT `fk_artista_artista_artista1`
    FOREIGN KEY (`artista_id`)
    REFERENCES `spotify`.`artista` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artista_artista_artista2`
    FOREIGN KEY (`artista_id`)
    REFERENCES `spotify`.`artista` (`id_artista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
