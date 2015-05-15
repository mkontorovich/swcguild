-- phpMyAdmin SQL Dump
-- version 4.0.6deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 19, 2014 at 03:03 AM
-- Server version: 5.5.35-0ubuntu0.13.10.2
-- PHP Version: 5.5.3-1ubuntu2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `Capstone`
--

-- --------------------------------------------------------

--
-- Table structure for table `access`
--

CREATE TABLE IF NOT EXISTS `access` (
  `user_ID` int(11) NOT NULL,
  `manage` varchar(10) NOT NULL,
  PRIMARY KEY (`user_ID`,`manage`),
  KEY `user_ID` (`user_ID`),
  KEY `manage` (`manage`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
-- Table structure for table `contacts`
--

CREATE TABLE IF NOT EXISTS `contacts` (
  `contact_ID` int(11) NOT NULL AUTO_INCREMENT,
  `employer_ID` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `phone` int(10) NOT NULL,
  `email` varchar(25) NOT NULL,
  `address` varchar(50) NOT NULL,
  `note` varchar(160) NOT NULL,
  PRIMARY KEY (`contact_ID`),
  KEY `employer_ID` (`employer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `employers`
--

CREATE TABLE IF NOT EXISTS `employers` (
  `employer_ID` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(40) NOT NULL,
  `tier` varchar(10) NOT NULL,
  `status` varchar(20) NOT NULL,
  `company_phone` int(10) NOT NULL,
  `company_email` varchar(25) NOT NULL,
  `company_address` varchar(50) NOT NULL,
  PRIMARY KEY (`employer_ID`),
  KEY `employer_ID` (`employer_ID`),
  KEY `status` (`status`),
  KEY `tier` (`tier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `employer_statuses`
--

CREATE TABLE IF NOT EXISTS `employer_statuses` (
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `followups`
--

CREATE TABLE IF NOT EXISTS `followups` (
  `followup_ID` int(11) NOT NULL AUTO_INCREMENT,
  `user_ID` int(11) NOT NULL,
  `employer_ID` int(11) DEFAULT NULL,
  `cohort_ID` int(11) DEFAULT NULL,
  `student_ID` int(11) DEFAULT NULL,
  `due_date` date NOT NULL,
  `note` varchar(160) NOT NULL,
  PRIMARY KEY (`followup_ID`),
  UNIQUE KEY `cohort_ID` (`cohort_ID`,`student_ID`),
  UNIQUE KEY `student_ID` (`student_ID`),
  KEY `employer_ID` (`employer_ID`,`cohort_ID`,`student_ID`),
  KEY `user_ID` (`user_ID`)
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
  PRIMARY KEY (`payments_id`),
  UNIQUE KEY `student_id` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `role` varchar(10) NOT NULL,
  PRIMARY KEY (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role`) VALUES
('cohorts'),
('employers'),
('students'),
('users');

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
  PRIMARY KEY (`student_ID`),
  KEY `cohort_ID` (`cohort_ID`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `student_statuses`
--

CREATE TABLE IF NOT EXISTS `student_statuses` (
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student_statuses`
--

INSERT INTO `student_statuses` (`status`) VALUES
('Accepted'),
('Applied'),
('Declined'),
('Dropped_out'),
('Employed'),
('Enrolled'),
('Graduated'),
('Rejected'),
('Unemployed');

-- --------------------------------------------------------

--
-- Table structure for table `tiers`
--

CREATE TABLE IF NOT EXISTS `tiers` (
  `name` varchar(10) NOT NULL,
  PRIMARY KEY (`name`)
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
  `email` varchar(30) NOT NULL,
  PRIMARY KEY (`user_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `work`
--

CREATE TABLE IF NOT EXISTS `work` (
  `work_ID` int(11) NOT NULL AUTO_INCREMENT,
  `employee_ID` int(11) NOT NULL,
  `student_ID` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `note` varchar(160) NOT NULL,
  PRIMARY KEY (`work_ID`),
  KEY `employee_ID` (`employee_ID`),
  KEY `student_ID` (`student_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `access`
--
ALTER TABLE `access`
  ADD CONSTRAINT `access_ibfk_2` FOREIGN KEY (`manage`) REFERENCES `roles` (`role`) ON DELETE NO ACTION,
  ADD CONSTRAINT `access_ibfk_1` FOREIGN KEY (`user_ID`) REFERENCES `users` (`user_ID`) ON DELETE NO ACTION;

--
-- Constraints for table `contacts`
--
ALTER TABLE `contacts`
  ADD CONSTRAINT `contacts_ibfk_1` FOREIGN KEY (`employer_ID`) REFERENCES `employers` (`employer_ID`) ON DELETE NO ACTION;

--
-- Constraints for table `employers`
--
ALTER TABLE `employers`
  ADD CONSTRAINT `employers_ibfk_2` FOREIGN KEY (`tier`) REFERENCES `tiers` (`name`) ON DELETE NO ACTION,
  ADD CONSTRAINT `employers_ibfk_1` FOREIGN KEY (`status`) REFERENCES `employer_statuses` (`status`) ON DELETE NO ACTION;

--
-- Constraints for table `followups`
--
ALTER TABLE `followups`
  ADD CONSTRAINT `followups_ibfk_1` FOREIGN KEY (`employer_ID`) REFERENCES `employers` (`employer_ID`) ON DELETE NO ACTION,
  ADD CONSTRAINT `followups_ibfk_2` FOREIGN KEY (`cohort_ID`) REFERENCES `cohorts` (`cohort_ID`) ON DELETE NO ACTION,
  ADD CONSTRAINT `followups_ibfk_3` FOREIGN KEY (`student_ID`) REFERENCES `students` (`student_ID`) ON DELETE NO ACTION,
  ADD CONSTRAINT `followups_ibfk_4` FOREIGN KEY (`user_ID`) REFERENCES `users` (`user_ID`) ON DELETE NO ACTION;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_ID`) ON DELETE NO ACTION;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`cohort_ID`) REFERENCES `cohorts` (`cohort_ID`) ON DELETE NO ACTION,
  ADD CONSTRAINT `students_ibfk_4` FOREIGN KEY (`status`) REFERENCES `student_statuses` (`status`) ON DELETE NO ACTION;

--
-- Constraints for table `work`
--
ALTER TABLE `work`
  ADD CONSTRAINT `work_ibfk_1` FOREIGN KEY (`employee_ID`) REFERENCES `employers` (`employer_ID`) ON DELETE NO ACTION,
  ADD CONSTRAINT `work_ibfk_2` FOREIGN KEY (`student_ID`) REFERENCES `students` (`student_ID`) ON DELETE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
