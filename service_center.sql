-- phpMyAdmin SQL Dump
-- version 3.3.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 19, 2017 at 04:40 AM
-- Server version: 5.5.8
-- PHP Version: 5.3.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `service_center`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `admin_id` int(10) NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(50) NOT NULL,
  `admin_address` varchar(100) NOT NULL,
  `admin_contact_no` decimal(10,0) NOT NULL,
  `admin_login_id` varchar(30) NOT NULL,
  `admin_login_password` varchar(30) NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `admin_login_id` (`admin_login_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `admin`
--


-- --------------------------------------------------------

--
-- Table structure for table `bank_details`
--

CREATE TABLE IF NOT EXISTS `bank_details` (
  `bank_id` int(3) NOT NULL,
  `bank_name` varchar(50) NOT NULL,
  `account_no` int(16) NOT NULL,
  `ifsc_code` int(30) NOT NULL,
  PRIMARY KEY (`bank_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bank_details`
--


-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` int(10) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(50) NOT NULL,
  `customer_address` varchar(100) NOT NULL,
  `customer_contact_no` decimal(10,0) NOT NULL,
  `customer_login_id` varchar(30) NOT NULL,
  `customer_login_password` varchar(30) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `customer_login_id` (`customer_login_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `customer`
--


-- --------------------------------------------------------

--
-- Table structure for table `customer_service`
--

CREATE TABLE IF NOT EXISTS `customer_service` (
  `customer_id` int(10) NOT NULL,
  `employee_id` int(10) DEFAULT NULL,
  `service_request_date` datetime NOT NULL,
  `service_fulfill_date` date DEFAULT NULL,
  `query_details` varchar(200) NOT NULL,
  `employee_service_request_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer_service`
--


-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE IF NOT EXISTS `employee` (
  `employee_id` int(10) NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(50) NOT NULL,
  `employee_address` varchar(100) NOT NULL,
  `employee_contact_no` decimal(10,0) NOT NULL,
  `employee_status` varchar(10) NOT NULL DEFAULT 'inactive',
  `employee_salary` int(7) DEFAULT NULL,
  `employee_login_id` varchar(30) NOT NULL,
  `employee_login_password` varchar(30) NOT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `employee_login_id` (`employee_login_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `employee`
--


-- --------------------------------------------------------

--
-- Table structure for table `employee_expertise`
--

CREATE TABLE IF NOT EXISTS `employee_expertise` (
  `employee_id` int(10) NOT NULL,
  `employee_expertise_skill` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_expertise`
--


-- --------------------------------------------------------

--
-- Table structure for table `query_report`
--

CREATE TABLE IF NOT EXISTS `query_report` (
  `customer_id` int(10) NOT NULL,
  `employee_id` int(10) NOT NULL,
  `service_request_date` datetime NOT NULL,
  `issue_detail` varchar(100) NOT NULL,
  `issue_status` varchar(10) NOT NULL DEFAULT 'pending',
  `service_estimated_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `query_report`
--

