-- phpMyAdmin SQL Dump
-- version 4.0.6deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 18, 2014 at 03:59 PM
-- Server version: 5.5.35-0ubuntu0.13.10.2
-- PHP Version: 5.5.3-1ubuntu2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `student_managment`
--

-- --------------------------------------------------------

--
-- Table structure for table `cohorts`
--

CREATE TABLE IF NOT EXISTS `cohorts` (
  `cohort_ID` int(11) NOT NULL AUTO_INCREMENT,
  `track` varchar(25) NOT NULL,
  `start_date` date NOT NULL,
  PRIMARY KEY (`cohort_ID`),
  KEY `cohort_ID` (`cohort_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `hiring_partners`
--

CREATE TABLE IF NOT EXISTS `hiring_partners` (
  `employer_ID` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(40) NOT NULL,
  `tier` varchar(10) NOT NULL,
  `status` varchar(20) NOT NULL,
  `contact_name` varchar(25) NOT NULL,
  `contact_phone` int(10) NOT NULL,
  `contact_email` varchar(25) NOT NULL,
  `company_address` varchar(50) NOT NULL,
  PRIMARY KEY (`employer_ID`),
  KEY `employer_ID` (`employer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE IF NOT EXISTS `payments` (
  `payments_id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,0) NOT NULL,
  `note` varchar(250) NOT NULL,
  `student_id` int(11) NOT NULL,
  PRIMARY KEY (`payments_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE IF NOT EXISTS `students` (
  `student_ID` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `street` varchar(30) NOT NULL,
  `city` varchar(30) NOT NULL,
  `state` varchar(15) NOT NULL,
  `zip_code` varchar(15) NOT NULL,
  `phone` int(11) NOT NULL,
  `email` varchar(30) NOT NULL,
  `date_of_application` varchar(15) NOT NULL,
  `aptitude_test_score` int(2) NOT NULL,
  `cohort_ID` int(11) NOT NULL,
  `employer_ID` int(11) NOT NULL,
  `housing` tinyint(1) NOT NULL,
  `status` varchar(20) NOT NULL,
  `student_bio` varchar(30) NOT NULL,
  `student_resume` varchar(30) NOT NULL,
  `payments_id` int(11) NOT NULL,
  PRIMARY KEY (`student_ID`),
  KEY `cohort_ID` (`cohort_ID`),
  KEY `employer_ID` (`employer_ID`),
  KEY `payments_id` (`payments_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_ID` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(25) NOT NULL,
  `user_password` varchar(25) NOT NULL,
  `first_name` varchar(15) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `access_level` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  PRIMARY KEY (`user_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_3` FOREIGN KEY (`payments_id`) REFERENCES `payments` (`payments_id`),
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`cohort_ID`) REFERENCES `cohorts` (`cohort_ID`) ON DELETE NO ACTION,
  ADD CONSTRAINT `students_ibfk_2` FOREIGN KEY (`employer_ID`) REFERENCES `hiring_partners` (`employer_ID`) ON DELETE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
