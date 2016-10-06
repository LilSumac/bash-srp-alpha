-- phpMyAdmin SQL Dump
-- version 4.0.10.7
-- http://www.phpmyadmin.net

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
set wait_timeout = 28800;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

-- --------------------------------------------------------

--
-- Table structure for table `BASH_players`
--

CREATE TABLE IF NOT EXISTS `BASH_players` (
  `PlyNum` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` text COLLATE utf8_bin NOT NULL,
  `SteamID` text COLLATE utf8_bin NOT NULL,
  `BASHID` text COLLATE utf8_bin NOT NULL,
  `PassedQuiz` tinyint(1) NOT NULL,
  `PlayerFlags` text COLLATE utf8_bin NOT NULL,
  `Whitelists` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`PlyNum`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `BASH_characters`
--

CREATE TABLE IF NOT EXISTS `BASH_characters` (
  `CharNum` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `BASHID` text COLLATE utf8_bin NOT NULL,
  `CharID` text COLLATE utf8_bin NOT NULL,
  `Name` text COLLATE utf8_bin NOT NULL,
  `Model` text COLLATE utf8_bin NOT NULL,
  `Description` text COLLATE utf8_bin NOT NULL,
  `Faction` text COLLATE utf8_bin NOT NULL,
  `Gender` text COLLATE utf8_bin NOT NULL,
  `Quirks` text COLLATE utf8_bin NOT NULL,
  `PKTime` int(12) NOT NULL,
  `CharFlags` text COLLATE utf8_bin NOT NULL,
  `Rubles` int(12) NOT NULL,
  `InvMain` text COLLATE utf8_bin NOT NULL,
  `InvSec` text COLLATE utf8_bin NOT NULL,
  `InvAcc` text COLLATE utf8_bin NOT NULL,
  `Suit` text COLLATE utf8_bin NOT NULL,
  `Acc` text COLLATE utf8_bin NOT NULL,
  `Clothing` text COLLATE utf8_bin NOT NULL,
  `Weapons` text COLLATE utf8_bin NOT NULL,
  `Artifacts` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`CharNum`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `BASH_bans`
--

CREATE TABLE IF NOT EXISTS `BASH_bans` (
  `Banned_Name` text NOT NULL,
  `Banned_SteamID` text NOT NULL,
  `Banned_BASHID` text NOT NULL,
  `Banned_Reason` text NOT NULL,
  `Banner_Name` text NOT NULL,
  `Banner_SteamID` text NOT NULL,
  `Ban_Length` text NOT NULL,
  `Ban_Time` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `BASH_econ`
--

CREATE TABLE IF NOT EXISTS `BASH_econ` (
  `ValueIn` int(12) NOT NULL DEFAULT '0',
  `ValueOut` int(12) NOT NULL DEFAULT '0',
  `FloatingCash` int(12) NOT NULL DEFAULT '0',
  `CashMoved` int(12) NOT NULL DEFAULT '0',
  `CashFired` int(12) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
