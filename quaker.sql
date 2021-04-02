-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Апр 02 2021 г., 20:30
-- Версия сервера: 10.5.8-MariaDB-log
-- Версия PHP: 7.4.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `quaker`
--

-- --------------------------------------------------------

--
-- Структура таблицы `earthquakes_seismic`
--

CREATE TABLE `earthquakes_seismic` (
  `id` int(11) NOT NULL,
  `eventid` varchar(32) DEFAULT NULL,
  `type` varchar(128) DEFAULT NULL,
  `lastupdate` int(24) DEFAULT 0,
  `magtype` varchar(32) DEFAULT NULL,
  `evtype` varchar(32) DEFAULT NULL,
  `lon` varchar(32) DEFAULT NULL,
  `lat` varchar(32) DEFAULT NULL,
  `depth` float DEFAULT 0,
  `auth` varchar(32) DEFAULT NULL,
  `mag` float NOT NULL DEFAULT 0,
  `time` int(24) NOT NULL DEFAULT 0,
  `source_id` int(11) NOT NULL DEFAULT 0,
  `source_catalog` varchar(254) DEFAULT NULL,
  `flynn_region` varchar(254) DEFAULT NULL,
  `status` varchar(64) DEFAULT NULL,
  `country_iso` varchar(32) DEFAULT NULL,
  `continent` varchar(128) DEFAULT NULL,
  `state` varchar(254) DEFAULT NULL,
  `village` varchar(254) DEFAULT NULL,
  `town` varchar(254) DEFAULT NULL,
  `state_district` varchar(254) DEFAULT NULL,
  `island` varchar(254) DEFAULT NULL,
  `full_location` text DEFAULT NULL,
  `timezone` varchar(254) DEFAULT NULL,
  `seismicportalJson` text DEFAULT NULL,
  `geo_scaned` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `earthquakes_seismic`
--
ALTER TABLE `earthquakes_seismic`
  ADD PRIMARY KEY (`id`),
  ADD KEY `eventid` (`eventid`),
  ADD KEY `status` (`status`),
  ADD KEY `geo_scaned` (`geo_scaned`),
  ADD KEY `mag` (`mag`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `earthquakes_seismic`
--
ALTER TABLE `earthquakes_seismic`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
