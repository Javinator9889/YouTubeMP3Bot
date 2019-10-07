-- MySQL Script generated by MySQL Workbench
-- jue 25 jul 2019 13:50:06 CEST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema youtubemd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema youtubemd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtubemd` DEFAULT CHARACTER SET utf8mb4 ;
SHOW WARNINGS;
USE `youtubemd` ;

-- -----------------------------------------------------
-- Table `youtubemd`.`DownloadInformation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtubemd`.`DownloadInformation` (
  `file_id` VARCHAR(50) NOT NULL,
  `audioQuality` ENUM('320k', '256k', '128k') NOT NULL,
  `audioSampling` ENUM('44000', '48000') NULL,
  `Metadata_idMetadata` INT NOT NULL,
  `VideoInformation_id` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`file_id`, `Metadata_idMetadata`, `VideoInformation_id`),
  CONSTRAINT `fk_DownloadInformation_Metadata1`
    FOREIGN KEY (`Metadata_idMetadata`)
    REFERENCES `youtubemd`.`Metadata` (`idMetadata`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DownloadInformation_VideoInformation1`
    FOREIGN KEY (`VideoInformation_id`)
    REFERENCES `youtubemd`.`VideoInformation` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
CHECKSUM = 1;

SHOW WARNINGS;
CREATE UNIQUE INDEX `file_id_UNIQUE` ON `youtubemd`.`DownloadInformation` (`file_id` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `fk_DownloadInformation_Metadata1_idx` ON `youtubemd`.`DownloadInformation` (`Metadata_idMetadata` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `fk_DownloadInformation_VideoInformation1_idx` ON `youtubemd`.`DownloadInformation` (`VideoInformation_id` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `youtubemd`.`DownloadStatistics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtubemd`.`DownloadStatistics` (
  `timesRequested` INT NOT NULL DEFAULT 0,
  `DownloadInformation_file_id` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`DownloadInformation_file_id`),
  CONSTRAINT `fk_DownloadStatistics_DownloadInformation1`
    FOREIGN KEY (`DownloadInformation_file_id`)
    REFERENCES `youtubemd`.`DownloadInformation` (`file_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
CHECKSUM = 1;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `youtubemd`.`History`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtubemd`.`History` (
  `User_id` INT(64) NOT NULL,
  `DownloadInformation_file_id` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`User_id`, `DownloadInformation_file_id`),
  CONSTRAINT `fk_History_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `youtubemd`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_History_DownloadInformation1`
    FOREIGN KEY (`DownloadInformation_file_id`)
    REFERENCES `youtubemd`.`DownloadInformation` (`file_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
CHECKSUM = 1;

SHOW WARNINGS;
CREATE INDEX `fk_History_DownloadInformation1_idx` ON `youtubemd`.`History` (`DownloadInformation_file_id` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `youtubemd`.`Metadata`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtubemd`.`Metadata` (
  `idMetadata` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `artist` VARCHAR(60) NOT NULL,
  `cover` BLOB NOT NULL,
  `duration` INT NULL,
  `customMetadata` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idMetadata`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
CHECKSUM = 1;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `youtubemd`.`Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtubemd`.`Playlist` (
  `id` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
CHECKSUM = 1;

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `youtubemd`.`Playlist` (`id` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `youtubemd`.`Playlist_has_VideoInformation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtubemd`.`Playlist_has_VideoInformation` (
  `Playlist_id` VARCHAR(60) NOT NULL,
  `VideoInformation_id` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`Playlist_id`, `VideoInformation_id`),
  CONSTRAINT `fk_Playlist_has_VideoInformation_Playlist1`
    FOREIGN KEY (`Playlist_id`)
    REFERENCES `youtubemd`.`Playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Playlist_has_VideoInformation_VideoInformation1`
    FOREIGN KEY (`VideoInformation_id`)
    REFERENCES `youtubemd`.`VideoInformation` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
CHECKSUM = 1;

SHOW WARNINGS;
CREATE INDEX `fk_Playlist_has_VideoInformation_VideoInformation1_idx` ON `youtubemd`.`Playlist_has_VideoInformation` (`VideoInformation_id` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `fk_Playlist_has_VideoInformation_Playlist1_idx` ON `youtubemd`.`Playlist_has_VideoInformation` (`Playlist_id` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `youtubemd`.`PlaylistStatistics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtubemd`.`PlaylistStatistics` (
  `timesRequested` INT NOT NULL,
  `Playlist_id` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`Playlist_id`),
  CONSTRAINT `fk_PlaylistStatistics_Playlist1`
    FOREIGN KEY (`Playlist_id`)
    REFERENCES `youtubemd`.`Playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
CHECKSUM = 1;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `youtubemd`.`Preferences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtubemd`.`Preferences` (
  `language` VARCHAR(3) NOT NULL DEFAULT 'en',
  `audioQuality` ENUM('320k', '256k', '128k') NOT NULL DEFAULT '128k',
  `audioSampling` ENUM('44000', '48000') NOT NULL DEFAULT '44000',
  `sendSongLinks` TINYINT NOT NULL DEFAULT 0,
  `askForMetadata` TINYINT NOT NULL DEFAULT 1,
  `User_id` INT(64) NOT NULL,
  PRIMARY KEY (`User_id`),
  CONSTRAINT `fk_Preferences_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `youtubemd`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
CHECKSUM = 1;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `youtubemd`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtubemd`.`User` (
  `id` INT(64) NOT NULL DEFAULT 0,
  `name` VARCHAR(45) NULL DEFAULT 'User',
  `surname` VARCHAR(45) NULL,
  `username` VARCHAR(45) NULL,
  `lastSeen` DATETIME NOT NULL,
  `firstUsage` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
CHECKSUM = 1
PACK_KEYS = 1;

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `youtubemd`.`User` (`id` ASC) VISIBLE;

SHOW WARNINGS;
CREATE UNIQUE INDEX `username_UNIQUE` ON `youtubemd`.`User` (`username` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `youtubemd`.`VideoInformation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtubemd`.`VideoInformation` (
  `id` VARCHAR(11) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `channel` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
CHECKSUM = 1;

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `youtubemd`.`VideoInformation` (`id` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `youtubemd`.`VideoStatistics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtubemd`.`VideoStatistics` (
  `timesRequested` INT NOT NULL DEFAULT 0,
  `VideoInformation_id` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`VideoInformation_id`),
  CONSTRAINT `fk_VideoStatistics_VideoInformation1`
    FOREIGN KEY (`VideoInformation_id`)
    REFERENCES `youtubemd`.`VideoInformation` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
CHECKSUM = 1;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
