-- phpMyAdmin SQL Dump
-- version 4.0.6deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 21, 2014 at 07:09 PM
-- Server version: 5.5.35-0ubuntu0.13.10.2
-- PHP Version: 5.5.3-1ubuntu2.2

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
-- Table structure for table `authorities`
--

CREATE TABLE IF NOT EXISTS `authorities` (
  `authority_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(25) NOT NULL,
  `authority` varchar(20) NOT NULL,
  PRIMARY KEY (`authority_id`),
  KEY `authority` (`authority`),
  KEY `user_name` (`user_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=36 ;

--
-- Dumping data for table `authorities`
--

INSERT INTO `authorities` (`authority_id`, `user_name`, `authority`) VALUES
(7, 'admin', 'ROLE_COHORTS_ADMIN'),
(8, 'admin', 'ROLE_EMPLOYERS_ADMIN'),
(9, 'admin', 'ROLE_STUDENTS_ADMIN'),
(10, 'admin', 'ROLE_USERS_ADMIN'),
(11, 'view', 'ROLE_VIEW'),
(12, 'admin', 'ROLE_VIEW'),
(33, 'dan', 'ROLE_COHORTS_ADMIN'),
(34, 'dan', 'ROLE_EMPLOYERS_ADMIN'),
(35, 'dan', 'ROLE_STUDENTS_ADMIN');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=50 ;

--
-- Dumping data for table `cohorts`
--

INSERT INTO `cohorts` (`cohort_ID`, `track`, `start_date`) VALUES
(48, 'Java', '2013-12-24'),
(49, 'Java', '2013-01-01');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE IF NOT EXISTS `contacts` (
  `contact_ID` int(11) NOT NULL AUTO_INCREMENT,
  `employer_ID` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `phone` varchar(12) NOT NULL,
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
  `company_phone` varchar(12) NOT NULL,
  `company_email` varchar(25) NOT NULL,
  `company_address` varchar(50) NOT NULL,
  PRIMARY KEY (`employer_ID`),
  KEY `employer_ID` (`employer_ID`),
  KEY `status` (`status`),
  KEY `tier` (`tier`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Dumping data for table `employers`
--

INSERT INTO `employers` (`employer_ID`, `company_name`, `tier`, `status`, `company_phone`, `company_email`, `company_address`) VALUES
(19, 'Potbelly', '1', 'Good', '1048483', 'asdf@gmail.com', 'S. Main St.'),
(20, 'Hoaso', '1', 'sl', '2848202', 'lkdfj@yahoo.com', '02093f adf ');

-- --------------------------------------------------------

--
-- Table structure for table `employer_statuses`
--

CREATE TABLE IF NOT EXISTS `employer_statuses` (
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employer_statuses`
--

INSERT INTO `employer_statuses` (`status`) VALUES
('Current'),
('Future'),
('Past');

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
  KEY `student_id` (`student_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=31 ;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payments_id`, `amount`, `note`, `student_id`) VALUES
(22, 100, 'Payment 1', 11),
(23, 200, 'Payment 2', 11),
(24, 100, 'Payment 1', 12),
(25, 200, 'Payment 2', 12),
(26, 100, 'Test 1', 13),
(27, 200, 'Test 1', 14),
(28, 300, 'Test 2', 14),
(29, 354, '', 15),
(30, 235, '', 15);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `role` varchar(20) NOT NULL,
  PRIMARY KEY (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role`) VALUES
('ROLE_COHORTS_ADMIN'),
('ROLE_EMPLOYERS_ADMIN'),
('ROLE_STUDENTS_ADMIN'),
('ROLE_USERS_ADMIN'),
('ROLE_VIEW');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE IF NOT EXISTS `students` (
  `student_ID` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `street` varchar(30) NOT NULL,
  `city` varchar(30) NOT NULL,
  `state` varchar(15) NOT NULL,
  `zip_code` varchar(15) NOT NULL,
  `phone` varchar(12) NOT NULL,
  `email` varchar(30) NOT NULL,
  `date_of_application` date NOT NULL,
  `aptitude_test_score` int(2) NOT NULL,
  `cohort_ID` int(11) NOT NULL,
  `housing` tinyint(1) NOT NULL,
  `status` varchar(20) NOT NULL,
  `student_bio` varchar(30) NOT NULL,
  `student_resume` varchar(30) NOT NULL,
  PRIMARY KEY (`student_ID`),
  KEY `cohort_ID` (`cohort_ID`),
  KEY `status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_ID`, `first_name`, `last_name`, `street`, `city`, `state`, `zip_code`, `phone`, `email`, `date_of_application`, `aptitude_test_score`, `cohort_ID`, `housing`, `status`, `student_bio`, `student_resume`) VALUES
(11, 'John', 'Doe', '123 Test Ave', 'city', 'OH', '48073', '1234567890', 'john@gmail.com', '2013-12-24', 100, 48, 1, 'Accepted', 'biolink', 'resumelink'),
(12, 'Jane', 'Doe', '123 Test Ave', 'city', 'OH', '48073', '1234567890', 'john@gmail.com', '2013-12-24', 100, 48, 1, 'Accepted', 'biolink', 'resumelink'),
(13, 'Mike', 'Jake', '123 Test Ave', 'Columbus', 'OH', '48073', '123456789', 'gmail@gmail.com', '2014-03-20', 100, 48, 1, 'Accepted', 'com.com', 'com.com'),
(14, 'Jen', 'Alex', '102 Test Ave', 'Test City', 'Test State', 'Test Zip', '1234567890', 'jen@gmail.com', '2014-03-05', 100, 48, 1, 'Accepted', 'jen@gmail.com', 'jen@gmail.com'),
(15, 'asdf', 'asdf', 'asdf', 'asdf', 'IL', '32452', '234235', 'asdfasdf333333333333', '2014-03-20', 2345, 48, 1, 'Declined', '', '');

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

--
-- Dumping data for table `tiers`
--

INSERT INTO `tiers` (`name`) VALUES
('1'),
('2'),
('3');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_ID` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(25) NOT NULL,
  `user_password` varchar(100) NOT NULL,
  `enabled` int(11) NOT NULL DEFAULT '1',
  `first_name` varchar(15) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  PRIMARY KEY (`user_ID`),
  KEY `user_name` (`user_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_ID`, `user_name`, `user_password`, `enabled`, `first_name`, `last_name`, `email`) VALUES
(1, 'admin', '$2a$10$At13wPjr/ZvL38TwPrjEIuvTFDjNxBxsBr7Bf6xW7LbGYBzYrE2xS', 1, 'admin', 'admin', 'admin@gmail.com'),
(2, 'view', '$2a$10$At13wPjr/ZvL38TwPrjEIuvTFDjNxBxsBr7Bf6xW7LbGYBzYrE2xS', 1, 'view', 'view', 'view@gmail.com'),
(5, 'dan', '$2a$10$z5tl/hrxcNYxZBUojecReOIfawUOOazlI3X5QOLzzBYkI.dWEwVbe', 1, 'Dan', 'W', 'dan@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `work`
--

CREATE TABLE IF NOT EXISTS `work` (
  `work_ID` int(11) NOT NULL AUTO_INCREMENT,
  `employer_ID` int(11) NOT NULL,
  `student_ID` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `note` varchar(160) NOT NULL,
  PRIMARY KEY (`work_ID`),
  KEY `employee_ID` (`employer_ID`),
  KEY `student_ID` (`student_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

--
-- Dumping data for table `work`
--

INSERT INTO `work` (`work_ID`, `employer_ID`, `student_ID`, `start_date`, `end_date`, `note`) VALUES
(12, 18, 11, '2013-12-24', '2013-12-24', 'Work History 1'),
(13, 18, 12, '2013-12-24', '2013-12-24', 'Work History 1'),
(14, 1, 13, '2014-03-05', '2014-03-28', 'Test'),
(15, 1, 14, '2014-03-26', '2014-03-29', 'Test3'),
(16, 1, 14, '2014-03-26', '2014-03-28', 'Test4'),
(17, 19, 15, '2014-03-12', '2014-03-20', '');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `authorities`
--
ALTER TABLE `authorities`
  ADD CONSTRAINT `authorities_ibfk_2` FOREIGN KEY (`user_name`) REFERENCES `users` (`user_name`) ON DELETE NO ACTION,
  ADD CONSTRAINT `authorities_ibfk_1` FOREIGN KEY (`authority`) REFERENCES `roles` (`role`) ON DELETE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
