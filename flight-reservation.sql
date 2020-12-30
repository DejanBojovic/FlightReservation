-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 30, 2020 at 02:51 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `flight-reservation`
--

-- --------------------------------------------------------

--
-- Table structure for table `flights`
--

CREATE TABLE `flights` (
  `flightID` int(11) NOT NULL,
  `direction` varchar(50) NOT NULL,
  `start` varchar(50) NOT NULL,
  `end` varchar(50) NOT NULL,
  `d` datetime NOT NULL,
  `passengers` int(11) NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `flights`
--

INSERT INTO `flights` (`flightID`, `direction`, `start`, `end`, `d`, `passengers`, `price`) VALUES
(9, 'one way', 'Dublin', 'Belgrade', '2020-12-28 01:00:00', 10, 400),
(10, 'roundtrip', 'Dublin', 'Belgrade', '2020-12-28 00:00:00', 10, 750),
(11, 'roundtrip', 'Belgrade', 'London', '2020-12-31 00:00:00', 10, 1200),
(12, 'one way', 'Belgrade', 'London', '2020-12-31 00:00:00', 10, 1000),
(13, 'roundtrip', 'Belgrade', 'Rome', '2020-12-31 02:00:00', 10, 850),
(14, 'one way', 'Belgrade', 'Rome', '2020-12-31 20:45:00', 10, 600),
(16, 'one way', 'Madrid', 'Belgrade', '2020-12-28 23:00:00', 10, 450),
(17, 'one way', 'Madrid', 'Belgrade', '2020-12-28 00:00:00', 10, 450),
(18, 'roundtrip', 'Madrid', 'Belgrade', '2020-12-28 20:00:00', 10, 800),
(19, 'roundtrip', 'Madrid', 'Belgrade', '2020-12-28 19:00:00', 10, 850),
(20, 'roundtrip', 'Madrid', 'Belgrade', '2020-12-28 07:00:00', 10, 850),
(21, 'one way', 'Oslo', 'Belgrade', '2020-12-28 20:00:00', 10, 400),
(22, 'one way', 'Oslo', 'Belgrade', '2020-12-28 16:00:00', 10, 400),
(23, 'roundtrip', 'Oslo', 'Belgrade', '2020-12-28 02:00:00', 10, 800),
(24, 'roundtrip', 'Oslo', 'Belgrade', '2020-12-28 13:30:00', 10, 850),
(25, 'roundtrip', 'Oslo', 'Belgrade', '2020-12-28 10:00:00', 10, 800),
(26, 'one way', 'Dublin', 'Belgrade', '2020-12-28 22:00:00', 10, 800),
(27, 'roundtrip', 'Dublin', 'Belgrade', '2020-12-28 17:00:00', 10, 1050),
(28, 'roundtrip', 'Dublin', 'Belgrade', '2020-12-28 04:30:00', 10, 1000),
(29, 'one way', 'Dublin', 'Belgrade', '2020-12-28 13:00:00', 10, 750),
(30, 'one way', 'Dublin', 'Belgrade', '2020-12-28 03:00:00', 10, 800),
(31, 'roundtrip', 'Belgrade', 'London', '2020-12-31 15:00:00', 10, 850),
(32, 'roundtrip', 'Belgrade', 'London', '2020-12-31 15:30:00', 10, 800),
(33, 'one way', 'Belgrade', 'London', '2020-12-31 09:00:00', 10, 550),
(34, 'one way', 'Belgrade', 'London', '2020-12-31 19:00:00', 10, 400),
(35, 'one way', 'Belgrade', 'London', '2020-12-31 11:00:00', 10, 450),
(36, 'roundtrip', 'Belgrade', 'Paris', '2020-12-31 01:00:00', 10, 1050),
(37, 'roundtrip', 'Belgrade', 'Paris', '2020-12-31 06:00:00', 10, 1100),
(38, 'roundtrip', 'Belgrade', 'Paris', '2020-12-31 13:30:00', 10, 1000),
(39, 'one way', 'Belgrade', 'Paris', '2020-12-31 02:00:00', 10, 550),
(40, 'one way', 'Belgrade', 'Paris', '2020-12-31 22:00:00', 10, 500),
(41, 'one way', 'Belgrade', 'Paris', '2020-12-31 05:00:00', 10, 500),
(42, 'roundtrip', 'Belgrade', 'Rome', '2020-12-31 12:00:00', 10, 1200),
(43, 'roundtrip', 'Belgrade', 'Rome', '2020-12-31 16:00:00', 10, 1200),
(44, 'one way', 'Belgrade', 'Rome', '2020-12-31 06:00:00', 10, 600),
(45, 'one way', 'Belgrade', 'Rome', '2020-12-31 20:00:00', 10, 650),
(46, 'one way', 'Belgrade', 'Rome', '2020-12-31 09:00:00', 10, 750),
(47, 'one way', 'Kiev', 'Moscow', '2020-12-22 20:30:00', 8, 255),
(48, 'one way', 'Belgrade', 'Rome', '2020-12-31 20:45:00', 10, 850),
(49, 'roundtrip', 'Paris', 'Belgrade', '2020-12-28 09:45:00', 10, 900);

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `reservationID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `flightID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`reservationID`, `userID`, `flightID`) VALUES
(1, 6, 33),
(2, 7, 87),
(3, 4, 30),
(13, 25, 18),
(14, 25, 40),
(15, 25, 22),
(17, 23, 43),
(18, 23, 26),
(19, 28, 20);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userID` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `username`, `password`, `email`) VALUES
(23, 'Dean', 'pbkdf2:sha256:150000$2rC281rj$2a1a3b4875496aa37b8f65a9aeb16d5467f812b21aa984e319eaf402a7e7b34a', 'Bean@gmail.com'),
(24, 'admin', 'pbkdf2:sha256:150000$UmrTkXcX$0a522a28e3c02b5e760e61930531b77d1c05f4b667c84a60e00becddcf06b213', 'admin@gmail.com'),
(25, 'Sim', 'pbkdf2:sha256:150000$9BpOcoCk$e6cef6eb1b3e6d1bf46d1a7d337aa2af7239784054a354b40b994ab5bd133690', 'Sim@gmail.com'),
(26, 'Charlie', 'pbkdf2:sha256:150000$JfaOZGZL$7e95c03d1d9aceb61870d6c57e8f64b07c863bad9ae01bb1d2bc508482f01bba', 'Charlie@gmail.com'),
(27, 'Bling', 'pbkdf2:sha256:150000$ikSWEqRQ$603dcbf84c68257dc90c3ee834b654aaac2d3d7ac3aa1d268083a879e91bdf09', 'Bling@gmail.com'),
(28, 'James', 'pbkdf2:sha256:150000$sO81ExAQ$19c7e254d12bc44cf1bf7118ac148c9f1477cc51d837acf3b0e513e3a44a71b2', 'James@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `flights`
--
ALTER TABLE `flights`
  ADD PRIMARY KEY (`flightID`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`reservationID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `flights`
--
ALTER TABLE `flights`
  MODIFY `flightID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `reservationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
