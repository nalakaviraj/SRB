-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 28, 2026 at 05:32 AM
-- Server version: 11.8.6-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u907354579_sbr`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `account_number` varchar(191) NOT NULL,
  `account_details` text DEFAULT NULL,
  `account_type_id` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `is_closed` tinyint(1) NOT NULL DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `account_transactions`
--

CREATE TABLE `account_transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_id` int(11) NOT NULL,
  `type` enum('debit','credit') NOT NULL,
  `sub_type` enum('opening_balance','fund_transfer','deposit') DEFAULT NULL,
  `amount` decimal(22,4) NOT NULL,
  `reff_no` varchar(191) DEFAULT NULL,
  `operation_date` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `transaction_payment_id` int(11) DEFAULT NULL,
  `transfer_transaction_id` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `account_types`
--

CREATE TABLE `account_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `parent_account_type_id` int(11) DEFAULT NULL,
  `business_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `activity_log`
--

CREATE TABLE `activity_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `log_name` varchar(191) DEFAULT NULL,
  `description` text NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `subject_type` varchar(191) DEFAULT NULL,
  `event` varchar(191) DEFAULT NULL,
  `business_id` int(11) DEFAULT NULL,
  `causer_id` int(11) DEFAULT NULL,
  `causer_type` varchar(191) DEFAULT NULL,
  `properties` text DEFAULT NULL,
  `batch_uuid` char(36) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_log`
--

INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_id`, `subject_type`, `event`, `business_id`, `causer_id`, `causer_type`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
(1, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-02-19 17:43:26', '2026-02-19 17:43:26'),
(2, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-02-20 10:56:03', '2026-02-20 10:56:03'),
(3, 'default', 'edited', 1, 'App\\User', NULL, 1, 1, 'App\\User', '{\"name\":\" Admin User\"}', NULL, '2026-02-20 10:56:34', '2026-02-20 10:56:34'),
(4, 'default', 'logout', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-02-20 11:10:27', '2026-02-20 11:10:27'),
(5, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-02-20 11:10:57', '2026-02-20 11:10:57'),
(6, 'default', 'logout', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-02-20 11:13:12', '2026-02-20 11:13:12'),
(7, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-02-20 11:28:58', '2026-02-20 11:28:58'),
(8, 'default', 'logout', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-02-20 11:29:32', '2026-02-20 11:29:32'),
(9, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-02-20 11:43:43', '2026-02-20 11:43:43'),
(10, 'default', 'added', 2, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":1850}}', NULL, '2026-02-20 12:01:12', '2026-02-20 12:01:12'),
(11, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-02-20 12:06:10', '2026-02-20 12:06:10'),
(12, 'default', 'added', 4, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":550}}', NULL, '2026-02-20 12:25:48', '2026-02-20 12:25:48'),
(13, 'default', 'added', 5, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":550}}', NULL, '2026-02-20 12:25:48', '2026-02-20 12:25:48'),
(14, 'default', 'added', 6, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":2400}}', NULL, '2026-02-20 12:27:54', '2026-02-20 12:27:54'),
(15, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-02-20 13:36:15', '2026-02-20 13:36:15'),
(16, 'default', 'added', 8, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":30}}', NULL, '2026-02-20 13:37:39', '2026-02-20 13:37:39'),
(17, 'default', 'added', 9, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":30}}', NULL, '2026-02-20 14:16:28', '2026-02-20 14:16:28'),
(18, 'default', 'added', 10, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":1880}}', NULL, '2026-02-20 15:17:03', '2026-02-20 15:17:03'),
(19, 'default', 'added', 11, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":1880}}', NULL, '2026-02-20 15:19:32', '2026-02-20 15:19:32'),
(20, 'default', 'added', 12, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":1880}}', NULL, '2026-02-20 15:20:34', '2026-02-20 15:20:34'),
(21, 'default', 'added', 13, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":1880}}', NULL, '2026-02-20 15:27:47', '2026-02-20 15:27:47'),
(22, 'default', 'added', 14, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":1880}}', NULL, '2026-02-20 15:29:10', '2026-02-20 15:29:10'),
(23, 'default', 'added', 15, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"draft\",\"final_total\":1850}}', NULL, '2026-02-20 15:30:52', '2026-02-20 15:30:52'),
(24, 'default', 'added', 24, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":1300}}', NULL, '2026-02-20 16:43:30', '2026-02-20 16:43:30'),
(25, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-02-20 23:42:20', '2026-02-20 23:42:20'),
(26, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-02-21 08:14:47', '2026-02-21 08:14:47'),
(27, 'default', 'added', 31, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":580}}', NULL, '2026-02-21 11:35:55', '2026-02-21 11:35:55'),
(28, 'default', 'added', 32, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":580}}', NULL, '2026-02-21 11:36:43', '2026-02-21 11:36:43'),
(29, 'default', 'added', 33, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":140}}', NULL, '2026-02-21 11:37:38', '2026-02-21 11:37:38'),
(30, 'default', 'added', 34, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":580}}', NULL, '2026-02-21 11:43:57', '2026-02-21 11:43:57'),
(31, 'default', 'added', 35, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":195}}', NULL, '2026-02-21 12:02:30', '2026-02-21 12:02:30'),
(32, 'default', 'added', 36, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":195}}', NULL, '2026-02-21 12:02:38', '2026-02-21 12:02:38'),
(33, 'default', 'added', 37, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":195}}', NULL, '2026-02-21 12:02:49', '2026-02-21 12:02:49'),
(34, 'default', 'added', 38, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":140}}', NULL, '2026-02-21 12:04:13', '2026-02-21 12:04:13'),
(35, 'default', 'sell_deleted', 38, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"id\":38,\"invoice_no\":\"0019\",\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":\"140.0000\"}}', NULL, '2026-02-21 12:04:32', '2026-02-21 12:04:32'),
(36, 'default', 'sell_deleted', 37, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"id\":37,\"invoice_no\":\"0018\",\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":\"195.0000\"}}', NULL, '2026-02-21 12:04:41', '2026-02-21 12:04:41'),
(37, 'default', 'sell_deleted', 36, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"id\":36,\"invoice_no\":\"0017\",\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":\"195.0000\"}}', NULL, '2026-02-21 12:04:44', '2026-02-21 12:04:44'),
(38, 'default', 'sell_deleted', 35, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"id\":35,\"invoice_no\":\"0016\",\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":\"195.0000\"}}', NULL, '2026-02-21 12:04:47', '2026-02-21 12:04:47'),
(39, 'default', 'sell_deleted', 34, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"id\":34,\"invoice_no\":\"0015\",\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":\"580.0000\"}}', NULL, '2026-02-21 12:04:50', '2026-02-21 12:04:50'),
(40, 'default', 'sell_deleted', 33, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"id\":33,\"invoice_no\":\"0014\",\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":\"140.0000\"}}', NULL, '2026-02-21 12:04:53', '2026-02-21 12:04:53'),
(41, 'default', 'sell_deleted', 32, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"id\":32,\"invoice_no\":\"0013\",\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":\"580.0000\"}}', NULL, '2026-02-21 12:04:57', '2026-02-21 12:04:57'),
(42, 'default', 'sell_deleted', 31, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"id\":31,\"invoice_no\":\"0012\",\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":\"580.0000\"}}', NULL, '2026-02-21 12:05:00', '2026-02-21 12:05:00'),
(43, 'default', 'added', 40, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":4000}}', NULL, '2026-02-21 12:07:50', '2026-02-21 12:07:50'),
(44, 'default', 'sell_deleted', 40, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"id\":40,\"invoice_no\":\"0020\",\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":\"4000.0000\"}}', NULL, '2026-02-21 12:08:06', '2026-02-21 12:08:06'),
(45, 'default', 'added', 41, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":1380}}', NULL, '2026-02-21 12:33:23', '2026-02-21 12:33:23'),
(46, 'default', 'sell_deleted', 41, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"id\":41,\"invoice_no\":\"0021\",\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":\"1380.0000\"}}', NULL, '2026-02-21 12:33:54', '2026-02-21 12:33:54'),
(47, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-02-21 21:29:03', '2026-02-21 21:29:03'),
(48, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-02-21 21:40:19', '2026-02-21 21:40:19'),
(49, 'default', 'added', 42, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":4000}}', NULL, '2026-02-21 21:42:44', '2026-02-21 21:42:44'),
(50, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-02-23 13:10:19', '2026-02-23 13:10:19'),
(51, 'default', 'added', 43, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":3175}}', NULL, '2026-02-23 13:10:56', '2026-02-23 13:10:56'),
(52, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-02-23 13:47:49', '2026-02-23 13:47:49'),
(53, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-02-24 10:23:46', '2026-02-24 10:23:46'),
(54, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-02-26 09:23:56', '2026-02-26 09:23:56'),
(55, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-01 17:21:12', '2026-03-01 17:21:12'),
(56, 'default', 'added', 44, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":550}}', NULL, '2026-03-01 17:24:14', '2026-03-01 17:24:14'),
(57, 'default', 'added', 45, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":550}}', NULL, '2026-03-01 17:25:05', '2026-03-01 17:25:05'),
(58, 'default', 'added', 46, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":550}}', NULL, '2026-03-01 17:29:31', '2026-03-01 17:29:31'),
(59, 'default', 'sell_deleted', 46, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"id\":46,\"invoice_no\":\"0026\",\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":\"550.0000\"}}', NULL, '2026-03-01 17:31:21', '2026-03-01 17:31:21'),
(60, 'default', 'sell_deleted', 45, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"id\":45,\"invoice_no\":\"0025\",\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":\"550.0000\"}}', NULL, '2026-03-01 17:31:34', '2026-03-01 17:31:34'),
(61, 'default', 'sell_deleted', 44, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"id\":44,\"invoice_no\":\"0024\",\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":\"550.0000\"}}', NULL, '2026-03-01 17:31:43', '2026-03-01 17:31:43'),
(62, 'default', 'added', 47, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":1100}}', NULL, '2026-03-01 17:33:05', '2026-03-01 17:33:05'),
(63, 'default', 'added', 49, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":1100}}', NULL, '2026-03-01 17:59:29', '2026-03-01 17:59:29'),
(64, 'default', 'added', 50, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":1650}}', NULL, '2026-03-01 17:59:57', '2026-03-01 17:59:57'),
(65, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-01 18:05:28', '2026-03-01 18:05:28'),
(66, 'default', 'added', 51, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":360}}', NULL, '2026-03-01 18:06:33', '2026-03-01 18:06:33'),
(67, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-02 11:49:00', '2026-03-02 11:49:00'),
(68, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-02 11:49:11', '2026-03-02 11:49:11'),
(69, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-02 16:53:20', '2026-03-02 16:53:20'),
(70, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-03 09:24:59', '2026-03-03 09:24:59'),
(71, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-03 19:08:38', '2026-03-03 19:08:38'),
(72, 'default', 'added', 52, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":550}}', NULL, '2026-03-03 19:09:31', '2026-03-03 19:09:31'),
(73, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-04 14:48:24', '2026-03-04 14:48:24'),
(74, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-04 15:06:07', '2026-03-04 15:06:07'),
(75, 'default', 'added', 97, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":1160}}', NULL, '2026-03-04 16:14:41', '2026-03-04 16:14:41'),
(76, 'default', 'added', 98, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":580}}', NULL, '2026-03-04 16:23:43', '2026-03-04 16:23:43'),
(77, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-05 12:15:38', '2026-03-05 12:15:38'),
(78, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-05 13:30:33', '2026-03-05 13:30:33'),
(79, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-05 15:41:46', '2026-03-05 15:41:46'),
(80, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-06 15:15:44', '2026-03-06 15:15:44'),
(81, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-10 11:45:29', '2026-03-10 11:45:29'),
(82, 'default', 'added', 99, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":3080}}', NULL, '2026-03-10 11:48:04', '2026-03-10 11:48:04'),
(83, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-10 16:47:30', '2026-03-10 16:47:30'),
(84, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-14 15:13:43', '2026-03-14 15:13:43'),
(85, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-14 15:14:55', '2026-03-14 15:14:55'),
(86, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-14 15:29:01', '2026-03-14 15:29:01'),
(87, 'default', 'added', 100, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":800}}', NULL, '2026-03-14 16:26:43', '2026-03-14 16:26:43'),
(88, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-15 18:21:46', '2026-03-15 18:21:46'),
(89, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-21 13:26:04', '2026-03-21 13:26:04'),
(90, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-21 16:28:30', '2026-03-21 16:28:30'),
(91, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-22 14:02:56', '2026-03-22 14:02:56'),
(92, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-23 16:28:53', '2026-03-23 16:28:53'),
(93, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-25 20:37:45', '2026-03-25 20:37:45'),
(94, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-27 12:34:14', '2026-03-27 12:34:14'),
(95, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-27 12:44:09', '2026-03-27 12:44:09'),
(96, 'default', 'added', 128, 'App\\Transaction', NULL, 1, 1, 'App\\User', '{\"attributes\":{\"type\":\"sell\",\"status\":\"final\",\"payment_status\":\"paid\",\"final_total\":450}}', NULL, '2026-03-27 17:27:34', '2026-03-27 17:27:34'),
(97, 'default', 'login', 1, 'App\\User', NULL, 1, 1, 'App\\User', '[]', NULL, '2026-03-28 08:39:27', '2026-03-28 08:39:27');

-- --------------------------------------------------------

--
-- Table structure for table `barcodes`
--

CREATE TABLE `barcodes` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `measurement_unit` varchar(4) NOT NULL DEFAULT 'in',
  `rotate_labels` tinyint(1) NOT NULL DEFAULT 0,
  `width` double(22,4) DEFAULT NULL,
  `height` double(22,4) DEFAULT NULL,
  `paper_width` double(22,4) DEFAULT NULL,
  `paper_height` double(22,4) DEFAULT NULL,
  `top_margin` double(22,4) DEFAULT NULL,
  `left_margin` double(22,4) DEFAULT NULL,
  `row_distance` double(22,4) DEFAULT NULL,
  `col_distance` double(22,4) DEFAULT NULL,
  `stickers_in_one_row` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_continuous` tinyint(1) NOT NULL DEFAULT 0,
  `stickers_in_one_sheet` int(11) DEFAULT NULL,
  `business_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barcodes`
--

INSERT INTO `barcodes` (`id`, `name`, `description`, `measurement_unit`, `rotate_labels`, `width`, `height`, `paper_width`, `paper_height`, `top_margin`, `left_margin`, `row_distance`, `col_distance`, `stickers_in_one_row`, `is_default`, `is_continuous`, `stickers_in_one_sheet`, `business_id`, `created_at`, `updated_at`) VALUES
(1, '20 Labels per Sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 4\" x 1\", Labels per sheet: 20', 'in', 0, 4.0000, 1.0000, 8.5000, 11.0000, 0.5000, 0.1250, 0.0000, 0.1875, 2, 0, 0, 20, NULL, '2017-12-18 06:13:44', '2017-12-18 06:13:44'),
(2, '30 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2.625\" x 1\", Labels per sheet: 30', 'in', 0, 2.6250, 1.0000, 8.5000, 11.0000, 0.5000, 0.1880, 0.0000, 0.1250, 3, 0, 0, 30, NULL, '2017-12-18 06:04:39', '2017-12-18 06:10:40'),
(3, '32 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1.25\", Labels per sheet: 32', 'in', 0, 2.0000, 1.2500, 8.5000, 11.0000, 0.5000, 0.2500, 0.0000, 0.0000, 4, 0, 0, 32, NULL, '2017-12-18 05:55:40', '2017-12-18 05:55:40'),
(4, '40 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1\", Labels per sheet: 40', 'in', 0, 2.0000, 1.0000, 8.5000, 11.0000, 0.5000, 0.2500, 0.0000, 0.0000, 4, 0, 0, 40, NULL, '2017-12-18 05:58:40', '2017-12-18 05:58:40'),
(5, '50 Labels per Sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 1.5\" x 1\", Labels per sheet: 50', 'in', 0, 1.5000, 1.0000, 8.5000, 11.0000, 0.5000, 0.5000, 0.0000, 0.0000, 5, 0, 0, 50, NULL, '2017-12-18 05:51:10', '2017-12-18 05:51:10'),
(6, 'Continuous Rolls - 31.75mm x 25.4mm', 'Label Size: 31.75mm x 25.4mm, Gap: 3.18mm', 'in', 0, 1.2500, 1.0000, 1.2500, 0.0000, 0.1250, 0.0000, 0.1250, 0.0000, 1, 0, 1, NULL, NULL, '2017-12-18 05:51:10', '2017-12-18 05:51:10'),
(7, 'Samarawickrama printer', NULL, 'mm', 0, 30.0000, 20.0000, 30.0000, 0.0000, 0.0000, 0.0000, 3.0000, 0.0000, 1, 1, 1, 28, 1, '2026-02-20 13:51:09', '2026-03-02 19:52:09');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(10) UNSIGNED NOT NULL,
  `contact_id` int(10) UNSIGNED NOT NULL,
  `waiter_id` int(10) UNSIGNED DEFAULT NULL,
  `table_id` int(10) UNSIGNED DEFAULT NULL,
  `correspondent_id` int(11) DEFAULT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `booking_start` datetime NOT NULL,
  `booking_end` datetime NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `booking_status` varchar(191) NOT NULL,
  `booking_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `business_id`, `name`, `description`, `created_by`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'SRBC', NULL, 1, NULL, '2026-02-20 11:53:49', '2026-02-20 11:53:49'),
(2, 1, 'SR & BC', 'SAMARAWICKRAMA', 1, NULL, '2026-02-20 16:46:53', '2026-02-20 16:46:53');

-- --------------------------------------------------------

--
-- Table structure for table `business`
--

CREATE TABLE `business` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `currency_id` int(10) UNSIGNED NOT NULL,
  `start_date` date DEFAULT NULL,
  `tax_number_1` varchar(100) DEFAULT NULL,
  `tax_label_1` varchar(10) DEFAULT NULL,
  `tax_number_2` varchar(100) DEFAULT NULL,
  `tax_label_2` varchar(10) DEFAULT NULL,
  `code_label_1` varchar(191) DEFAULT NULL,
  `code_1` varchar(191) DEFAULT NULL,
  `code_label_2` varchar(191) DEFAULT NULL,
  `code_2` varchar(191) DEFAULT NULL,
  `default_sales_tax` int(10) UNSIGNED DEFAULT NULL,
  `default_profit_percent` double(5,2) NOT NULL DEFAULT 0.00,
  `owner_id` int(10) UNSIGNED NOT NULL,
  `time_zone` varchar(191) NOT NULL DEFAULT 'Asia/Kolkata',
  `fy_start_month` tinyint(4) NOT NULL DEFAULT 1,
  `accounting_method` enum('fifo','lifo','avco') NOT NULL DEFAULT 'fifo',
  `default_sales_discount` decimal(5,2) DEFAULT NULL,
  `sell_price_tax` enum('includes','excludes') NOT NULL DEFAULT 'includes',
  `logo` varchar(191) DEFAULT NULL,
  `sku_prefix` varchar(191) DEFAULT NULL,
  `enable_product_expiry` tinyint(1) NOT NULL DEFAULT 0,
  `expiry_type` enum('add_expiry','add_manufacturing') NOT NULL DEFAULT 'add_expiry',
  `on_product_expiry` enum('keep_selling','stop_selling','auto_delete') NOT NULL DEFAULT 'keep_selling',
  `stop_selling_before` int(11) NOT NULL COMMENT 'Stop selling expied item n days before expiry',
  `enable_tooltip` tinyint(1) NOT NULL DEFAULT 1,
  `purchase_in_diff_currency` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Allow purchase to be in different currency then the business currency',
  `purchase_currency_id` int(10) UNSIGNED DEFAULT NULL,
  `p_exchange_rate` decimal(20,3) NOT NULL DEFAULT 1.000,
  `transaction_edit_days` int(10) UNSIGNED NOT NULL DEFAULT 30,
  `stock_expiry_alert_days` int(10) UNSIGNED NOT NULL DEFAULT 30,
  `keyboard_shortcuts` text DEFAULT NULL,
  `pos_settings` text DEFAULT NULL,
  `weighing_scale_setting` text NOT NULL COMMENT 'used to store the configuration of weighing scale',
  `enable_brand` tinyint(1) NOT NULL DEFAULT 1,
  `enable_category` tinyint(1) NOT NULL DEFAULT 1,
  `enable_sub_category` tinyint(1) NOT NULL DEFAULT 1,
  `enable_price_tax` tinyint(1) NOT NULL DEFAULT 1,
  `enable_purchase_status` tinyint(1) DEFAULT 1,
  `enable_lot_number` tinyint(1) NOT NULL DEFAULT 0,
  `default_unit` int(11) DEFAULT NULL,
  `enable_sub_units` tinyint(1) NOT NULL DEFAULT 0,
  `enable_racks` tinyint(1) NOT NULL DEFAULT 0,
  `enable_row` tinyint(1) NOT NULL DEFAULT 0,
  `enable_position` tinyint(1) NOT NULL DEFAULT 0,
  `enable_editing_product_from_purchase` tinyint(1) NOT NULL DEFAULT 1,
  `sales_cmsn_agnt` enum('logged_in_user','user','cmsn_agnt') DEFAULT NULL,
  `item_addition_method` tinyint(1) NOT NULL DEFAULT 1,
  `enable_inline_tax` tinyint(1) NOT NULL DEFAULT 1,
  `currency_symbol_placement` enum('before','after') NOT NULL DEFAULT 'before',
  `enabled_modules` text DEFAULT NULL,
  `date_format` varchar(191) NOT NULL DEFAULT 'm/d/Y',
  `time_format` enum('12','24') NOT NULL DEFAULT '24',
  `currency_precision` tinyint(4) NOT NULL DEFAULT 2,
  `quantity_precision` tinyint(4) NOT NULL DEFAULT 2,
  `ref_no_prefixes` text DEFAULT NULL,
  `theme_color` char(20) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `enable_rp` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `rp_name` varchar(191) DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `amount_for_unit_rp` decimal(22,4) NOT NULL DEFAULT 1.0000 COMMENT 'rp is the short form of reward points',
  `min_order_total_for_rp` decimal(22,4) NOT NULL DEFAULT 1.0000 COMMENT 'rp is the short form of reward points',
  `max_rp_per_order` int(11) DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `redeem_amount_per_unit_rp` decimal(22,4) NOT NULL DEFAULT 1.0000 COMMENT 'rp is the short form of reward points',
  `min_order_total_for_redeem` decimal(22,4) NOT NULL DEFAULT 1.0000 COMMENT 'rp is the short form of reward points',
  `min_redeem_point` int(11) DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `max_redeem_point` int(11) DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `rp_expiry_period` int(11) DEFAULT NULL COMMENT 'rp is the short form of reward points',
  `rp_expiry_type` enum('month','year') NOT NULL DEFAULT 'year' COMMENT 'rp is the short form of reward points',
  `email_settings` text DEFAULT NULL,
  `sms_settings` text DEFAULT NULL,
  `custom_labels` text DEFAULT NULL,
  `common_settings` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `business`
--

INSERT INTO `business` (`id`, `name`, `currency_id`, `start_date`, `tax_number_1`, `tax_label_1`, `tax_number_2`, `tax_label_2`, `code_label_1`, `code_1`, `code_label_2`, `code_2`, `default_sales_tax`, `default_profit_percent`, `owner_id`, `time_zone`, `fy_start_month`, `accounting_method`, `default_sales_discount`, `sell_price_tax`, `logo`, `sku_prefix`, `enable_product_expiry`, `expiry_type`, `on_product_expiry`, `stop_selling_before`, `enable_tooltip`, `purchase_in_diff_currency`, `purchase_currency_id`, `p_exchange_rate`, `transaction_edit_days`, `stock_expiry_alert_days`, `keyboard_shortcuts`, `pos_settings`, `weighing_scale_setting`, `enable_brand`, `enable_category`, `enable_sub_category`, `enable_price_tax`, `enable_purchase_status`, `enable_lot_number`, `default_unit`, `enable_sub_units`, `enable_racks`, `enable_row`, `enable_position`, `enable_editing_product_from_purchase`, `sales_cmsn_agnt`, `item_addition_method`, `enable_inline_tax`, `currency_symbol_placement`, `enabled_modules`, `date_format`, `time_format`, `currency_precision`, `quantity_precision`, `ref_no_prefixes`, `theme_color`, `created_by`, `enable_rp`, `rp_name`, `amount_for_unit_rp`, `min_order_total_for_rp`, `max_rp_per_order`, `redeem_amount_per_unit_rp`, `min_order_total_for_redeem`, `min_redeem_point`, `max_redeem_point`, `rp_expiry_period`, `rp_expiry_type`, `email_settings`, `sms_settings`, `custom_labels`, `common_settings`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'SR&B', 111, '2026-02-19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 25.00, 1, 'Asia/Kolkata', 1, 'fifo', 0.00, 'includes', NULL, NULL, 0, 'add_expiry', 'keep_selling', 0, 1, 0, NULL, 1.000, 30, 30, '{\"pos\":{\"express_checkout\":\"shift+e\",\"pay_n_ckeckout\":\"shift+p\",\"draft\":\"shift+d\",\"cancel\":\"shift+c\",\"recent_product_quantity\":\"f2\",\"weighing_scale\":null,\"edit_discount\":\"shift+i\",\"edit_order_tax\":\"shift+t\",\"add_payment_row\":\"shift+r\",\"finalize_payment\":\"shift+f\",\"add_new_product\":\"f4\"}}', '{\"amount_rounding_method\":null,\"cmmsn_calculation_type\":\"invoice_value\",\"razor_pay_key_id\":null,\"razor_pay_key_secret\":null,\"stripe_public_key\":null,\"stripe_secret_key\":null,\"disable_draft\":\"1\",\"disable_express_checkout\":\"1\",\"disable_order_tax\":\"1\",\"enable_weighing_scale\":\"1\",\"display_screen_heading\":null,\"cash_denominations\":null,\"enable_cash_denomination_on\":\"pos_screen\",\"disable_pay_checkout\":0,\"hide_product_suggestion\":0,\"hide_recent_trans\":0,\"disable_discount\":0,\"is_pos_subtotal_editable\":0}', '{\"label_prefix\":null,\"product_sku_length\":\"4\",\"qty_length\":\"3\",\"qty_length_decimal\":\"2\"}', 1, 1, 0, 1, 1, 0, NULL, 0, 0, 0, 0, 1, NULL, 1, 0, 'before', '[\"purchases\",\"add_sale\",\"pos_sale\",\"expenses\"]', 'm/d/Y', '24', 2, 2, '{\"purchase\":\"PO\",\"purchase_return\":null,\"purchase_requisition\":null,\"purchase_order\":null,\"stock_transfer\":\"ST\",\"stock_adjustment\":\"SA\",\"sell_return\":\"CN\",\"expense\":\"EP\",\"contacts\":\"CO\",\"purchase_payment\":\"PP\",\"sell_payment\":\"SP\",\"expense_payment\":null,\"business_location\":\"BL\",\"username\":null,\"subscription\":null,\"draft\":null,\"sales_order\":null}', 'green', 1, 0, NULL, 1.0000, 1.0000, NULL, 1.0000, 1.0000, NULL, NULL, NULL, 'year', '{\"mail_driver\":\"smtp\",\"mail_host\":null,\"mail_port\":null,\"mail_username\":null,\"mail_password\":null,\"mail_encryption\":null,\"mail_from_address\":null,\"mail_from_name\":null}', '{\"sms_service\":\"other\",\"nexmo_key\":null,\"nexmo_secret\":null,\"nexmo_from\":null,\"twilio_sid\":null,\"twilio_token\":null,\"twilio_from\":null,\"url\":null,\"send_to_param_name\":\"to\",\"send_to_param_type\":\"string\",\"msg_param_name\":\"text\",\"request_method\":\"post\",\"data_parameter_type\":\"form-data\",\"header_1\":null,\"header_val_1\":null,\"header_2\":null,\"header_val_2\":null,\"header_3\":null,\"header_val_3\":null,\"param_1\":null,\"param_val_1\":null,\"param_2\":null,\"param_val_2\":null,\"param_3\":null,\"param_val_3\":null,\"param_4\":null,\"param_val_4\":null,\"param_5\":null,\"param_val_5\":null,\"param_6\":null,\"param_val_6\":null,\"param_7\":null,\"param_val_7\":null,\"param_8\":null,\"param_val_8\":null,\"param_9\":null,\"param_val_9\":null,\"param_10\":null,\"param_val_10\":null}', '{\"payments\":{\"custom_pay_1\":null,\"custom_pay_2\":null,\"custom_pay_3\":null,\"custom_pay_4\":null,\"custom_pay_5\":null,\"custom_pay_6\":null,\"custom_pay_7\":null},\"contact\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null,\"custom_field_5\":null,\"custom_field_6\":null,\"custom_field_7\":null,\"custom_field_8\":null,\"custom_field_9\":null,\"custom_field_10\":null},\"product\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null,\"custom_field_5\":null,\"custom_field_6\":null,\"custom_field_7\":null,\"custom_field_8\":null,\"custom_field_9\":null,\"custom_field_10\":null,\"custom_field_11\":null,\"custom_field_12\":null,\"custom_field_13\":null,\"custom_field_14\":null,\"custom_field_15\":null,\"custom_field_16\":null,\"custom_field_17\":null,\"custom_field_18\":null,\"custom_field_19\":null,\"custom_field_20\":null},\"product_cf_details\":{\"1\":{\"type\":null,\"dropdown_options\":null},\"2\":{\"type\":null,\"dropdown_options\":null},\"3\":{\"type\":null,\"dropdown_options\":null},\"4\":{\"type\":null,\"dropdown_options\":null},\"5\":{\"type\":null,\"dropdown_options\":null},\"6\":{\"type\":null,\"dropdown_options\":null},\"7\":{\"type\":null,\"dropdown_options\":null},\"8\":{\"type\":null,\"dropdown_options\":null},\"9\":{\"type\":null,\"dropdown_options\":null},\"10\":{\"type\":null,\"dropdown_options\":null},\"11\":{\"type\":null,\"dropdown_options\":null},\"12\":{\"type\":null,\"dropdown_options\":null},\"13\":{\"type\":null,\"dropdown_options\":null},\"14\":{\"type\":null,\"dropdown_options\":null},\"15\":{\"type\":null,\"dropdown_options\":null},\"16\":{\"type\":null,\"dropdown_options\":null},\"17\":{\"type\":null,\"dropdown_options\":null},\"18\":{\"type\":null,\"dropdown_options\":null},\"19\":{\"type\":null,\"dropdown_options\":null},\"20\":{\"type\":null,\"dropdown_options\":null}},\"location\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null},\"user\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null},\"purchase\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null},\"purchase_shipping\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null,\"custom_field_5\":null},\"sell\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null},\"shipping\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null,\"custom_field_5\":null},\"types_of_service\":{\"custom_field_1\":null,\"custom_field_2\":null,\"custom_field_3\":null,\"custom_field_4\":null,\"custom_field_5\":null,\"custom_field_6\":null}}', '{\"default_credit_limit\":null,\"default_datatable_page_entries\":\"25\"}', 1, '2026-02-19 17:29:18', '2026-03-27 15:52:23');

-- --------------------------------------------------------

--
-- Table structure for table `business_locations`
--

CREATE TABLE `business_locations` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` varchar(191) DEFAULT NULL,
  `name` varchar(256) NOT NULL,
  `landmark` text DEFAULT NULL,
  `country` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `zip_code` char(7) NOT NULL,
  `invoice_scheme_id` int(10) UNSIGNED NOT NULL,
  `sale_invoice_scheme_id` int(11) DEFAULT NULL,
  `invoice_layout_id` int(10) UNSIGNED NOT NULL,
  `sale_invoice_layout_id` int(11) DEFAULT NULL,
  `selling_price_group_id` int(11) DEFAULT NULL,
  `print_receipt_on_invoice` tinyint(1) DEFAULT 1,
  `receipt_printer_type` enum('browser','printer') NOT NULL DEFAULT 'browser',
  `printer_id` int(11) DEFAULT NULL,
  `mobile` varchar(191) DEFAULT NULL,
  `alternate_number` varchar(191) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `website` varchar(191) DEFAULT NULL,
  `featured_products` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `default_payment_accounts` text DEFAULT NULL,
  `custom_field1` varchar(191) DEFAULT NULL,
  `custom_field2` varchar(191) DEFAULT NULL,
  `custom_field3` varchar(191) DEFAULT NULL,
  `custom_field4` varchar(191) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `business_locations`
--

INSERT INTO `business_locations` (`id`, `business_id`, `location_id`, `name`, `landmark`, `country`, `state`, `city`, `zip_code`, `invoice_scheme_id`, `sale_invoice_scheme_id`, `invoice_layout_id`, `sale_invoice_layout_id`, `selling_price_group_id`, `print_receipt_on_invoice`, `receipt_printer_type`, `printer_id`, `mobile`, `alternate_number`, `email`, `website`, `featured_products`, `is_active`, `default_payment_accounts`, `custom_field1`, `custom_field2`, `custom_field3`, `custom_field4`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'BL0001', 'Main Business', '', 'US', 'CA', 'San Francisco', '00000', 1, NULL, 1, 1, NULL, 1, 'browser', NULL, '', '', '', '', NULL, 1, '{\"cash\":{\"is_enabled\":1,\"account\":null},\"card\":{\"is_enabled\":1,\"account\":null},\"cheque\":{\"is_enabled\":1,\"account\":null},\"bank_transfer\":{\"is_enabled\":1,\"account\":null},\"other\":{\"is_enabled\":1,\"account\":null},\"custom_pay_1\":{\"is_enabled\":1,\"account\":null},\"custom_pay_2\":{\"is_enabled\":1,\"account\":null},\"custom_pay_3\":{\"is_enabled\":1,\"account\":null},\"custom_pay_4\":{\"is_enabled\":1,\"account\":null},\"custom_pay_5\":{\"is_enabled\":1,\"account\":null},\"custom_pay_6\":{\"is_enabled\":1,\"account\":null},\"custom_pay_7\":{\"is_enabled\":1,\"account\":null}}', NULL, NULL, NULL, NULL, NULL, '2026-02-19 17:29:18', '2026-02-19 17:29:18');

-- --------------------------------------------------------

--
-- Table structure for table `cash_denominations`
--

CREATE TABLE `cash_denominations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `amount` decimal(22,4) NOT NULL,
  `total_count` int(11) NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cash_registers`
--

CREATE TABLE `cash_registers` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `status` enum('close','open') NOT NULL DEFAULT 'open',
  `closed_at` datetime DEFAULT NULL,
  `closing_amount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `total_card_slips` int(11) NOT NULL DEFAULT 0,
  `total_cheques` int(11) NOT NULL DEFAULT 0,
  `denominations` text DEFAULT NULL,
  `closing_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cash_registers`
--

INSERT INTO `cash_registers` (`id`, `business_id`, `location_id`, `user_id`, `status`, `closed_at`, `closing_amount`, `total_card_slips`, `total_cheques`, `denominations`, `closing_note`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 'open', NULL, 0.0000, 0, 0, NULL, NULL, '2026-02-19 17:43:00', '2026-02-19 17:43:37');

-- --------------------------------------------------------

--
-- Table structure for table `cash_register_transactions`
--

CREATE TABLE `cash_register_transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `cash_register_id` int(10) UNSIGNED NOT NULL,
  `amount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `pay_method` varchar(191) DEFAULT NULL,
  `type` enum('debit','credit') NOT NULL,
  `transaction_type` varchar(191) DEFAULT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cash_register_transactions`
--

INSERT INTO `cash_register_transactions` (`id`, `cash_register_id`, `amount`, `pay_method`, `type`, `transaction_type`, `transaction_id`, `created_at`, `updated_at`) VALUES
(1, 1, 50000.0000, 'cash', 'credit', 'initial', NULL, '2026-02-19 17:43:37', '2026-02-19 17:43:37'),
(2, 1, 1850.0000, 'cash', 'credit', 'sell', 2, '2026-02-20 12:01:12', '2026-02-20 12:01:12'),
(3, 1, 550.0000, 'cash', 'credit', 'sell', 4, '2026-02-20 12:25:48', '2026-02-20 12:25:48'),
(4, 1, 550.0000, 'cash', 'credit', 'sell', 5, '2026-02-20 12:25:48', '2026-02-20 12:25:48'),
(5, 1, 5000.0000, 'cash', 'credit', 'sell', 6, '2026-02-20 12:27:54', '2026-02-20 12:27:54'),
(6, 1, -2600.0000, 'cash', 'credit', 'sell', 6, '2026-02-20 12:27:54', '2026-02-20 12:27:54'),
(7, 1, 100.0000, 'cash', 'credit', 'sell', 8, '2026-02-20 13:37:39', '2026-02-20 13:37:39'),
(8, 1, -70.0000, 'cash', 'credit', 'sell', 8, '2026-02-20 13:37:39', '2026-02-20 13:37:39'),
(9, 1, 30.0000, 'cash', 'credit', 'sell', 9, '2026-02-20 14:16:28', '2026-02-20 14:16:28'),
(10, 1, 1880.0000, 'cash', 'credit', 'sell', 10, '2026-02-20 15:17:03', '2026-02-20 15:17:03'),
(11, 1, 1880.0000, 'cash', 'credit', 'sell', 11, '2026-02-20 15:19:32', '2026-02-20 15:19:32'),
(12, 1, 1880.0000, 'cash', 'credit', 'sell', 12, '2026-02-20 15:20:34', '2026-02-20 15:20:34'),
(13, 1, 1880.0000, 'cash', 'credit', 'sell', 13, '2026-02-20 15:27:47', '2026-02-20 15:27:47'),
(14, 1, 1880.0000, 'cash', 'credit', 'sell', 14, '2026-02-20 15:29:10', '2026-02-20 15:29:10'),
(15, 1, 1300.0000, 'cash', 'credit', 'sell', 24, '2026-02-20 16:43:30', '2026-02-20 16:43:30'),
(30, 1, 5000.0000, 'cash', 'credit', 'sell', 42, '2026-02-21 21:42:44', '2026-02-21 21:42:44'),
(31, 1, -1000.0000, 'cash', 'credit', 'sell', 42, '2026-02-21 21:42:44', '2026-02-21 21:42:44'),
(32, 1, 4500.0000, 'cash', 'credit', 'sell', 43, '2026-02-23 13:10:56', '2026-02-23 13:10:56'),
(33, 1, -1325.0000, 'cash', 'credit', 'sell', 43, '2026-02-23 13:10:56', '2026-02-23 13:10:56'),
(40, 1, 5000.0000, 'cash', 'credit', 'sell', 47, '2026-03-01 17:33:05', '2026-03-01 17:33:05'),
(41, 1, -3900.0000, 'cash', 'credit', 'sell', 47, '2026-03-01 17:33:05', '2026-03-01 17:33:05'),
(42, 1, 5000.0000, 'cash', 'credit', 'sell', 49, '2026-03-01 17:59:29', '2026-03-01 17:59:29'),
(43, 1, -3900.0000, 'cash', 'credit', 'sell', 49, '2026-03-01 17:59:29', '2026-03-01 17:59:29'),
(44, 1, 5000.0000, 'cash', 'credit', 'sell', 50, '2026-03-01 17:59:57', '2026-03-01 17:59:57'),
(45, 1, -3350.0000, 'cash', 'credit', 'sell', 50, '2026-03-01 17:59:57', '2026-03-01 17:59:57'),
(46, 1, 360.0000, 'cash', 'credit', 'sell', 51, '2026-03-01 18:06:33', '2026-03-01 18:06:33'),
(47, 1, 1000.0000, 'cash', 'credit', 'sell', 52, '2026-03-03 19:09:31', '2026-03-03 19:09:31'),
(48, 1, -450.0000, 'cash', 'credit', 'sell', 52, '2026-03-03 19:09:31', '2026-03-03 19:09:31'),
(49, 1, 1160.0000, 'cash', 'credit', 'sell', 97, '2026-03-04 16:14:41', '2026-03-04 16:14:41'),
(50, 1, 1000.0000, 'cash', 'credit', 'sell', 98, '2026-03-04 16:23:43', '2026-03-04 16:23:43'),
(51, 1, -420.0000, 'cash', 'credit', 'sell', 98, '2026-03-04 16:23:43', '2026-03-04 16:23:43'),
(52, 1, 5000.0000, 'cash', 'credit', 'sell', 99, '2026-03-10 11:48:04', '2026-03-10 11:48:04'),
(53, 1, -1920.0000, 'cash', 'credit', 'sell', 99, '2026-03-10 11:48:04', '2026-03-10 11:48:04'),
(54, 1, 800.0000, 'cash', 'credit', 'sell', 100, '2026-03-14 16:26:43', '2026-03-14 16:26:43'),
(55, 1, 450.0000, 'cash', 'credit', 'sell', 128, '2026-03-27 17:27:34', '2026-03-27 17:27:34');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `short_code` varchar(191) DEFAULT NULL,
  `parent_id` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `category_type` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `business_id`, `short_code`, `parent_id`, `created_by`, `category_type`, `description`, `slug`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'class bag', 1, NULL, 0, 1, 'product', NULL, NULL, NULL, '2026-02-20 11:52:59', '2026-02-20 11:52:59');

-- --------------------------------------------------------

--
-- Table structure for table `categorizables`
--

CREATE TABLE `categorizables` (
  `category_id` int(11) NOT NULL,
  `categorizable_type` varchar(191) NOT NULL,
  `categorizable_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `type` varchar(191) NOT NULL,
  `contact_type` varchar(191) DEFAULT NULL,
  `land_mark` varchar(191) DEFAULT NULL,
  `street_name` varchar(191) DEFAULT NULL,
  `building_number` varchar(191) DEFAULT NULL,
  `additional_number` varchar(191) DEFAULT NULL,
  `supplier_business_name` varchar(191) DEFAULT NULL,
  `name` varchar(191) DEFAULT NULL,
  `prefix` varchar(191) DEFAULT NULL,
  `first_name` varchar(191) DEFAULT NULL,
  `middle_name` varchar(191) DEFAULT NULL,
  `last_name` varchar(191) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `contact_id` varchar(191) DEFAULT NULL,
  `contact_status` varchar(191) NOT NULL DEFAULT 'active',
  `tax_number` varchar(191) DEFAULT NULL,
  `city` varchar(191) DEFAULT NULL,
  `state` varchar(191) DEFAULT NULL,
  `country` varchar(191) DEFAULT NULL,
  `address_line_1` text DEFAULT NULL,
  `address_line_2` text DEFAULT NULL,
  `zip_code` varchar(191) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `mobile` varchar(191) NOT NULL,
  `landline` varchar(191) DEFAULT NULL,
  `alternate_number` varchar(191) DEFAULT NULL,
  `pay_term_number` int(11) DEFAULT NULL,
  `pay_term_type` enum('days','months') DEFAULT NULL,
  `credit_limit` decimal(22,4) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `balance` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `total_rp` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `total_rp_used` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `total_rp_expired` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `shipping_address` text DEFAULT NULL,
  `shipping_custom_field_details` longtext DEFAULT NULL,
  `is_export` tinyint(1) NOT NULL DEFAULT 0,
  `export_custom_field_1` varchar(191) DEFAULT NULL,
  `export_custom_field_2` varchar(191) DEFAULT NULL,
  `export_custom_field_3` varchar(191) DEFAULT NULL,
  `export_custom_field_4` varchar(191) DEFAULT NULL,
  `export_custom_field_5` varchar(191) DEFAULT NULL,
  `export_custom_field_6` varchar(191) DEFAULT NULL,
  `position` varchar(191) DEFAULT NULL,
  `customer_group_id` int(11) DEFAULT NULL,
  `custom_field1` varchar(191) DEFAULT NULL,
  `custom_field2` varchar(191) DEFAULT NULL,
  `custom_field3` varchar(191) DEFAULT NULL,
  `custom_field4` varchar(191) DEFAULT NULL,
  `custom_field5` varchar(191) DEFAULT NULL,
  `custom_field6` varchar(191) DEFAULT NULL,
  `custom_field7` varchar(191) DEFAULT NULL,
  `custom_field8` varchar(191) DEFAULT NULL,
  `custom_field9` varchar(191) DEFAULT NULL,
  `custom_field10` varchar(191) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `business_id`, `type`, `contact_type`, `land_mark`, `street_name`, `building_number`, `additional_number`, `supplier_business_name`, `name`, `prefix`, `first_name`, `middle_name`, `last_name`, `email`, `contact_id`, `contact_status`, `tax_number`, `city`, `state`, `country`, `address_line_1`, `address_line_2`, `zip_code`, `dob`, `mobile`, `landline`, `alternate_number`, `pay_term_number`, `pay_term_type`, `credit_limit`, `created_by`, `balance`, `total_rp`, `total_rp_used`, `total_rp_expired`, `is_default`, `shipping_address`, `shipping_custom_field_details`, `is_export`, `export_custom_field_1`, `export_custom_field_2`, `export_custom_field_3`, `export_custom_field_4`, `export_custom_field_5`, `export_custom_field_6`, `position`, `customer_group_id`, `custom_field1`, `custom_field2`, `custom_field3`, `custom_field4`, `custom_field5`, `custom_field6`, `custom_field7`, `custom_field8`, `custom_field9`, `custom_field10`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'customer', NULL, NULL, NULL, NULL, NULL, NULL, 'Walk-In Customer', NULL, NULL, NULL, NULL, NULL, 'CO0001', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 0.0000, 1, 0.0000, 0, 0, 0, 1, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-19 17:29:18', '2026-02-19 17:29:18');

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` int(10) UNSIGNED NOT NULL,
  `country` varchar(100) NOT NULL,
  `currency` varchar(100) NOT NULL,
  `code` varchar(25) NOT NULL,
  `symbol` varchar(25) NOT NULL,
  `thousand_separator` varchar(10) NOT NULL,
  `decimal_separator` varchar(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `country`, `currency`, `code`, `symbol`, `thousand_separator`, `decimal_separator`, `created_at`, `updated_at`) VALUES
(1, 'Albania', 'Leke', 'ALL', 'Lek', ',', '.', NULL, NULL),
(2, 'America', 'Dollars', 'USD', '$', ',', '.', NULL, NULL),
(3, 'Afghanistan', 'Afghanis', 'AF', '؋', ',', '.', NULL, NULL),
(4, 'Argentina', 'Pesos', 'ARS', '$', ',', '.', NULL, NULL),
(5, 'Aruba', 'Guilders', 'AWG', 'ƒ', ',', '.', NULL, NULL),
(6, 'Australia', 'Dollars', 'AUD', '$', ',', '.', NULL, NULL),
(7, 'Azerbaijan', 'New Manats', 'AZ', 'ман', ',', '.', NULL, NULL),
(8, 'Bahamas', 'Dollars', 'BSD', '$', ',', '.', NULL, NULL),
(9, 'Barbados', 'Dollars', 'BBD', '$', ',', '.', NULL, NULL),
(10, 'Belarus', 'Rubles', 'BYR', 'p.', ',', '.', NULL, NULL),
(11, 'Belgium', 'Euro', 'EUR', '€', ',', '.', NULL, NULL),
(12, 'Beliz', 'Dollars', 'BZD', 'BZ$', ',', '.', NULL, NULL),
(13, 'Bermuda', 'Dollars', 'BMD', '$', ',', '.', NULL, NULL),
(14, 'Bolivia', 'Bolivianos', 'BOB', '$b', ',', '.', NULL, NULL),
(15, 'Bosnia and Herzegovina', 'Convertible Marka', 'BAM', 'KM', ',', '.', NULL, NULL),
(16, 'Botswana', 'Pula\'s', 'BWP', 'P', ',', '.', NULL, NULL),
(17, 'Bulgaria', 'Leva', 'BG', 'лв', ',', '.', NULL, NULL),
(18, 'Brazil', 'Reais', 'BRL', 'R$', ',', '.', NULL, NULL),
(19, 'Britain [United Kingdom]', 'Pounds', 'GBP', '£', ',', '.', NULL, NULL),
(20, 'Brunei Darussalam', 'Dollars', 'BND', '$', ',', '.', NULL, NULL),
(21, 'Cambodia', 'Riels', 'KHR', '៛', ',', '.', NULL, NULL),
(22, 'Canada', 'Dollars', 'CAD', '$', ',', '.', NULL, NULL),
(23, 'Cayman Islands', 'Dollars', 'KYD', '$', ',', '.', NULL, NULL),
(24, 'Chile', 'Pesos', 'CLP', '$', ',', '.', NULL, NULL),
(25, 'China', 'Yuan Renminbi', 'CNY', '¥', ',', '.', NULL, NULL),
(26, 'Colombia', 'Pesos', 'COP', '$', ',', '.', NULL, NULL),
(27, 'Costa Rica', 'Colón', 'CRC', '₡', ',', '.', NULL, NULL),
(28, 'Croatia', 'Kuna', 'HRK', 'kn', ',', '.', NULL, NULL),
(29, 'Cuba', 'Pesos', 'CUP', '₱', ',', '.', NULL, NULL),
(30, 'Cyprus', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(31, 'Czech Republic', 'Koruny', 'CZK', 'Kč', ',', '.', NULL, NULL),
(32, 'Denmark', 'Kroner', 'DKK', 'kr', ',', '.', NULL, NULL),
(33, 'Dominican Republic', 'Pesos', 'DOP ', 'RD$', ',', '.', NULL, NULL),
(34, 'East Caribbean', 'Dollars', 'XCD', '$', ',', '.', NULL, NULL),
(35, 'Egypt', 'Pounds', 'EGP', '£', ',', '.', NULL, NULL),
(36, 'El Salvador', 'Colones', 'SVC', '$', ',', '.', NULL, NULL),
(37, 'England [United Kingdom]', 'Pounds', 'GBP', '£', ',', '.', NULL, NULL),
(38, 'Euro', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(39, 'Falkland Islands', 'Pounds', 'FKP', '£', ',', '.', NULL, NULL),
(40, 'Fiji', 'Dollars', 'FJD', '$', ',', '.', NULL, NULL),
(41, 'France', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(42, 'Ghana', 'Cedis', 'GHS', '¢', ',', '.', NULL, NULL),
(43, 'Gibraltar', 'Pounds', 'GIP', '£', ',', '.', NULL, NULL),
(44, 'Greece', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(45, 'Guatemala', 'Quetzales', 'GTQ', 'Q', ',', '.', NULL, NULL),
(46, 'Guernsey', 'Pounds', 'GGP', '£', ',', '.', NULL, NULL),
(47, 'Guyana', 'Dollars', 'GYD', '$', ',', '.', NULL, NULL),
(48, 'Holland [Netherlands]', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(49, 'Honduras', 'Lempiras', 'HNL', 'L', ',', '.', NULL, NULL),
(50, 'Hong Kong', 'Dollars', 'HKD', '$', ',', '.', NULL, NULL),
(51, 'Hungary', 'Forint', 'HUF', 'Ft', ',', '.', NULL, NULL),
(52, 'Iceland', 'Kronur', 'ISK', 'kr', ',', '.', NULL, NULL),
(53, 'India', 'Rupees', 'INR', '₹', ',', '.', NULL, NULL),
(54, 'Indonesia', 'Rupiahs', 'IDR', 'Rp', ',', '.', NULL, NULL),
(55, 'Iran', 'Rials', 'IRR', '﷼', ',', '.', NULL, NULL),
(56, 'Ireland', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(57, 'Isle of Man', 'Pounds', 'IMP', '£', ',', '.', NULL, NULL),
(58, 'Israel', 'New Shekels', 'ILS', '₪', ',', '.', NULL, NULL),
(59, 'Italy', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(60, 'Jamaica', 'Dollars', 'JMD', 'J$', ',', '.', NULL, NULL),
(61, 'Japan', 'Yen', 'JPY', '¥', ',', '.', NULL, NULL),
(62, 'Jersey', 'Pounds', 'JEP', '£', ',', '.', NULL, NULL),
(63, 'Kazakhstan', 'Tenge', 'KZT', 'лв', ',', '.', NULL, NULL),
(64, 'Korea [North]', 'Won', 'KPW', '₩', ',', '.', NULL, NULL),
(65, 'Korea [South]', 'Won', 'KRW', '₩', ',', '.', NULL, NULL),
(66, 'Kyrgyzstan', 'Soms', 'KGS', 'лв', ',', '.', NULL, NULL),
(67, 'Laos', 'Kips', 'LAK', '₭', ',', '.', NULL, NULL),
(68, 'Latvia', 'Lati', 'LVL', 'Ls', ',', '.', NULL, NULL),
(69, 'Lebanon', 'Pounds', 'LBP', '£', ',', '.', NULL, NULL),
(70, 'Liberia', 'Dollars', 'LRD', '$', ',', '.', NULL, NULL),
(71, 'Liechtenstein', 'Switzerland Francs', 'CHF', 'CHF', ',', '.', NULL, NULL),
(72, 'Lithuania', 'Litai', 'LTL', 'Lt', ',', '.', NULL, NULL),
(73, 'Luxembourg', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(74, 'Macedonia', 'Denars', 'MKD', 'ден', ',', '.', NULL, NULL),
(75, 'Malaysia', 'Ringgits', 'MYR', 'RM', ',', '.', NULL, NULL),
(76, 'Malta', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(77, 'Mauritius', 'Rupees', 'MUR', '₨', ',', '.', NULL, NULL),
(78, 'Mexico', 'Pesos', 'MXN', '$', ',', '.', NULL, NULL),
(79, 'Mongolia', 'Tugriks', 'MNT', '₮', ',', '.', NULL, NULL),
(80, 'Mozambique', 'Meticais', 'MZ', 'MT', ',', '.', NULL, NULL),
(81, 'Namibia', 'Dollars', 'NAD', '$', ',', '.', NULL, NULL),
(82, 'Nepal', 'Rupees', 'NPR', '₨', ',', '.', NULL, NULL),
(83, 'Netherlands Antilles', 'Guilders', 'ANG', 'ƒ', ',', '.', NULL, NULL),
(84, 'Netherlands', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(85, 'New Zealand', 'Dollars', 'NZD', '$', ',', '.', NULL, NULL),
(86, 'Nicaragua', 'Cordobas', 'NIO', 'C$', ',', '.', NULL, NULL),
(87, 'Nigeria', 'Nairas', 'NGN', '₦', ',', '.', NULL, NULL),
(88, 'North Korea', 'Won', 'KPW', '₩', ',', '.', NULL, NULL),
(89, 'Norway', 'Krone', 'NOK', 'kr', ',', '.', NULL, NULL),
(90, 'Oman', 'Rials', 'OMR', '﷼', ',', '.', NULL, NULL),
(91, 'Pakistan', 'Rupees', 'PKR', '₨', ',', '.', NULL, NULL),
(92, 'Panama', 'Balboa', 'PAB', 'B/.', ',', '.', NULL, NULL),
(93, 'Paraguay', 'Guarani', 'PYG', 'Gs', ',', '.', NULL, NULL),
(94, 'Peru', 'Nuevos Soles', 'PE', 'S/.', ',', '.', NULL, NULL),
(95, 'Philippines', 'Pesos', 'PHP', 'Php', ',', '.', NULL, NULL),
(96, 'Poland', 'Zlotych', 'PL', 'zł', ',', '.', NULL, NULL),
(97, 'Qatar', 'Rials', 'QAR', '﷼', ',', '.', NULL, NULL),
(98, 'Romania', 'New Lei', 'RO', 'lei', ',', '.', NULL, NULL),
(99, 'Russia', 'Rubles', 'RUB', 'руб', ',', '.', NULL, NULL),
(100, 'Saint Helena', 'Pounds', 'SHP', '£', ',', '.', NULL, NULL),
(101, 'Saudi Arabia', 'Riyals', 'SAR', '﷼', ',', '.', NULL, NULL),
(102, 'Serbia', 'Dinars', 'RSD', 'Дин.', ',', '.', NULL, NULL),
(103, 'Seychelles', 'Rupees', 'SCR', '₨', ',', '.', NULL, NULL),
(104, 'Singapore', 'Dollars', 'SGD', '$', ',', '.', NULL, NULL),
(105, 'Slovenia', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(106, 'Solomon Islands', 'Dollars', 'SBD', '$', ',', '.', NULL, NULL),
(107, 'Somalia', 'Shillings', 'SOS', 'S', ',', '.', NULL, NULL),
(108, 'South Africa', 'Rand', 'ZAR', 'R', ',', '.', NULL, NULL),
(109, 'South Korea', 'Won', 'KRW', '₩', ',', '.', NULL, NULL),
(110, 'Spain', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(111, 'Sri Lanka', 'Rupees', 'LKR', '₨', ',', '.', NULL, NULL),
(112, 'Sweden', 'Kronor', 'SEK', 'kr', ',', '.', NULL, NULL),
(113, 'Switzerland', 'Francs', 'CHF', 'CHF', ',', '.', NULL, NULL),
(114, 'Suriname', 'Dollars', 'SRD', '$', ',', '.', NULL, NULL),
(115, 'Syria', 'Pounds', 'SYP', '£', ',', '.', NULL, NULL),
(116, 'Taiwan', 'New Dollars', 'TWD', 'NT$', ',', '.', NULL, NULL),
(117, 'Thailand', 'Baht', 'THB', '฿', ',', '.', NULL, NULL),
(118, 'Trinidad and Tobago', 'Dollars', 'TTD', 'TT$', ',', '.', NULL, NULL),
(119, 'Turkey', 'Lira', 'TRY', 'TL', ',', '.', NULL, NULL),
(120, 'Turkey', 'Liras', 'TRL', '£', ',', '.', NULL, NULL),
(121, 'Tuvalu', 'Dollars', 'TVD', '$', ',', '.', NULL, NULL),
(122, 'Ukraine', 'Hryvnia', 'UAH', '₴', ',', '.', NULL, NULL),
(123, 'United Kingdom', 'Pounds', 'GBP', '£', ',', '.', NULL, NULL),
(124, 'United States of America', 'Dollars', 'USD', '$', ',', '.', NULL, NULL),
(125, 'Uruguay', 'Pesos', 'UYU', '$U', ',', '.', NULL, NULL),
(126, 'Uzbekistan', 'Sums', 'UZS', 'лв', ',', '.', NULL, NULL),
(127, 'Vatican City', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
(128, 'Venezuela', 'Bolivares Fuertes', 'VEF', 'Bs', ',', '.', NULL, NULL),
(129, 'Vietnam', 'Dong', 'VND', '₫', ',', '.', NULL, NULL),
(130, 'Yemen', 'Rials', 'YER', '﷼', ',', '.', NULL, NULL),
(131, 'Zimbabwe', 'Zimbabwe Dollars', 'ZWD', 'Z$', ',', '.', NULL, NULL),
(132, 'Iraq', 'Iraqi dinar', 'IQD', 'د.ع', ',', '.', NULL, NULL),
(133, 'Kenya', 'Kenyan shilling', 'KES', 'KSh', ',', '.', NULL, NULL),
(134, 'Bangladesh', 'Taka', 'BDT', '৳', ',', '.', NULL, NULL),
(135, 'Algerie', 'Algerian dinar', 'DZD', 'د.ج', ' ', '.', NULL, NULL),
(136, 'United Arab Emirates', 'United Arab Emirates dirham', 'AED', 'د.إ', ',', '.', NULL, NULL),
(137, 'Uganda', 'Uganda shillings', 'UGX', 'USh', ',', '.', NULL, NULL),
(138, 'Tanzania', 'Tanzanian shilling', 'TZS', 'TSh', ',', '.', NULL, NULL),
(139, 'Angola', 'Kwanza', 'AOA', 'Kz', ',', '.', NULL, NULL),
(140, 'Kuwait', 'Kuwaiti dinar', 'KWD', 'KD', ',', '.', NULL, NULL),
(141, 'Bahrain', 'Bahraini dinar', 'BHD', 'BD', ',', '.', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer_groups`
--

CREATE TABLE `customer_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `amount` double(5,2) NOT NULL,
  `price_calculation_type` varchar(191) DEFAULT 'percentage',
  `selling_price_group_id` int(11) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dashboard_configurations`
--

CREATE TABLE `dashboard_configurations` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `color` varchar(191) NOT NULL,
  `configuration` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `business_id` int(11) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `discount_type` varchar(191) DEFAULT NULL,
  `discount_amount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `starts_at` datetime DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `spg` varchar(100) DEFAULT NULL COMMENT 'Applicable in specified selling price group only. Use of applicable_in_spg column is discontinued',
  `applicable_in_cg` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_variations`
--

CREATE TABLE `discount_variations` (
  `discount_id` int(11) NOT NULL,
  `variation_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_and_notes`
--

CREATE TABLE `document_and_notes` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `notable_id` int(11) NOT NULL,
  `notable_type` varchar(191) NOT NULL,
  `heading` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(191) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `group_sub_taxes`
--

CREATE TABLE `group_sub_taxes` (
  `group_tax_id` int(10) UNSIGNED NOT NULL,
  `tax_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_layouts`
--

CREATE TABLE `invoice_layouts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `header_text` text DEFAULT NULL,
  `invoice_no_prefix` varchar(191) DEFAULT NULL,
  `quotation_no_prefix` varchar(191) DEFAULT NULL,
  `invoice_heading` varchar(191) DEFAULT NULL,
  `sub_heading_line1` varchar(191) DEFAULT NULL,
  `sub_heading_line2` varchar(191) DEFAULT NULL,
  `sub_heading_line3` varchar(191) DEFAULT NULL,
  `sub_heading_line4` varchar(191) DEFAULT NULL,
  `sub_heading_line5` varchar(191) DEFAULT NULL,
  `invoice_heading_not_paid` varchar(191) DEFAULT NULL,
  `invoice_heading_paid` varchar(191) DEFAULT NULL,
  `quotation_heading` varchar(191) DEFAULT NULL,
  `sub_total_label` varchar(191) DEFAULT NULL,
  `discount_label` varchar(191) DEFAULT NULL,
  `tax_label` varchar(191) DEFAULT NULL,
  `total_label` varchar(191) DEFAULT NULL,
  `round_off_label` varchar(191) DEFAULT NULL,
  `total_due_label` varchar(191) DEFAULT NULL,
  `paid_label` varchar(191) DEFAULT NULL,
  `show_client_id` tinyint(1) NOT NULL DEFAULT 0,
  `client_id_label` varchar(191) DEFAULT NULL,
  `client_tax_label` varchar(191) DEFAULT NULL,
  `date_label` varchar(191) DEFAULT NULL,
  `date_time_format` varchar(191) DEFAULT NULL,
  `show_time` tinyint(1) NOT NULL DEFAULT 1,
  `show_brand` tinyint(1) NOT NULL DEFAULT 0,
  `show_sku` tinyint(1) NOT NULL DEFAULT 1,
  `show_cat_code` tinyint(1) NOT NULL DEFAULT 1,
  `show_expiry` tinyint(1) NOT NULL DEFAULT 0,
  `show_lot` tinyint(1) NOT NULL DEFAULT 0,
  `show_image` tinyint(1) NOT NULL DEFAULT 0,
  `show_sale_description` tinyint(1) NOT NULL DEFAULT 0,
  `sales_person_label` varchar(191) DEFAULT NULL,
  `show_sales_person` tinyint(1) NOT NULL DEFAULT 0,
  `table_product_label` varchar(191) DEFAULT NULL,
  `table_qty_label` varchar(191) DEFAULT NULL,
  `table_unit_price_label` varchar(191) DEFAULT NULL,
  `table_subtotal_label` varchar(191) DEFAULT NULL,
  `cat_code_label` varchar(191) DEFAULT NULL,
  `logo` varchar(191) DEFAULT NULL,
  `show_logo` tinyint(1) NOT NULL DEFAULT 0,
  `show_business_name` tinyint(1) NOT NULL DEFAULT 0,
  `show_location_name` tinyint(1) NOT NULL DEFAULT 1,
  `show_landmark` tinyint(1) NOT NULL DEFAULT 1,
  `show_city` tinyint(1) NOT NULL DEFAULT 1,
  `show_state` tinyint(1) NOT NULL DEFAULT 1,
  `show_zip_code` tinyint(1) NOT NULL DEFAULT 1,
  `show_country` tinyint(1) NOT NULL DEFAULT 1,
  `show_mobile_number` tinyint(1) NOT NULL DEFAULT 1,
  `show_alternate_number` tinyint(1) NOT NULL DEFAULT 0,
  `show_email` tinyint(1) NOT NULL DEFAULT 0,
  `show_tax_1` tinyint(1) NOT NULL DEFAULT 1,
  `show_tax_2` tinyint(1) NOT NULL DEFAULT 0,
  `show_barcode` tinyint(1) NOT NULL DEFAULT 0,
  `show_payments` tinyint(1) NOT NULL DEFAULT 0,
  `show_customer` tinyint(1) NOT NULL DEFAULT 0,
  `customer_label` varchar(191) DEFAULT NULL,
  `commission_agent_label` varchar(191) DEFAULT NULL,
  `show_commission_agent` tinyint(1) NOT NULL DEFAULT 0,
  `show_reward_point` tinyint(1) NOT NULL DEFAULT 0,
  `highlight_color` varchar(10) DEFAULT NULL,
  `footer_text` text DEFAULT NULL,
  `module_info` text DEFAULT NULL,
  `common_settings` text DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `business_id` int(10) UNSIGNED NOT NULL,
  `show_letter_head` tinyint(1) NOT NULL DEFAULT 0,
  `letter_head` varchar(191) DEFAULT NULL,
  `show_qr_code` tinyint(1) NOT NULL DEFAULT 0,
  `qr_code_fields` text DEFAULT NULL,
  `design` varchar(190) DEFAULT 'classic',
  `cn_heading` varchar(191) DEFAULT NULL COMMENT 'cn = credit note',
  `cn_no_label` varchar(191) DEFAULT NULL,
  `cn_amount_label` varchar(191) DEFAULT NULL,
  `table_tax_headings` text DEFAULT NULL,
  `show_previous_bal` tinyint(1) NOT NULL DEFAULT 0,
  `prev_bal_label` varchar(191) DEFAULT NULL,
  `show_previous_balance_due` tinyint(1) NOT NULL DEFAULT 0,
  `previous_balance_due_label` varchar(191) DEFAULT NULL,
  `change_return_label` varchar(191) DEFAULT NULL,
  `product_custom_fields` text DEFAULT NULL,
  `contact_custom_fields` text DEFAULT NULL,
  `location_custom_fields` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoice_layouts`
--

INSERT INTO `invoice_layouts` (`id`, `name`, `header_text`, `invoice_no_prefix`, `quotation_no_prefix`, `invoice_heading`, `sub_heading_line1`, `sub_heading_line2`, `sub_heading_line3`, `sub_heading_line4`, `sub_heading_line5`, `invoice_heading_not_paid`, `invoice_heading_paid`, `quotation_heading`, `sub_total_label`, `discount_label`, `tax_label`, `total_label`, `round_off_label`, `total_due_label`, `paid_label`, `show_client_id`, `client_id_label`, `client_tax_label`, `date_label`, `date_time_format`, `show_time`, `show_brand`, `show_sku`, `show_cat_code`, `show_expiry`, `show_lot`, `show_image`, `show_sale_description`, `sales_person_label`, `show_sales_person`, `table_product_label`, `table_qty_label`, `table_unit_price_label`, `table_subtotal_label`, `cat_code_label`, `logo`, `show_logo`, `show_business_name`, `show_location_name`, `show_landmark`, `show_city`, `show_state`, `show_zip_code`, `show_country`, `show_mobile_number`, `show_alternate_number`, `show_email`, `show_tax_1`, `show_tax_2`, `show_barcode`, `show_payments`, `show_customer`, `customer_label`, `commission_agent_label`, `show_commission_agent`, `show_reward_point`, `highlight_color`, `footer_text`, `module_info`, `common_settings`, `is_default`, `business_id`, `show_letter_head`, `letter_head`, `show_qr_code`, `qr_code_fields`, `design`, `cn_heading`, `cn_no_label`, `cn_amount_label`, `table_tax_headings`, `show_previous_bal`, `prev_bal_label`, `show_previous_balance_due`, `previous_balance_due_label`, `change_return_label`, `product_custom_fields`, `contact_custom_fields`, `location_custom_fields`, `created_at`, `updated_at`) VALUES
(1, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Subtotal', 'Discount', 'Tax', 'Total', NULL, 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', NULL, 1, 0, 1, 0, 0, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, '1774259602_chatgpt-image-mar-23-2026-03-22-57-pm.png', 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', NULL, 0, 0, '#000000', '<p>Thank you.....</p>', NULL, '{\"proforma_heading\":null,\"sales_order_heading\":null,\"due_date_label\":null,\"total_quantity_label\":null,\"item_discount_label\":null,\"discounted_unit_price_label\":null,\"total_items_label\":null,\"num_to_word_format\":\"international\",\"tax_summary_label\":null,\"zatca_phase\":\"phase_1\"}', 1, 1, 1, '1774260123_chatgpt-image-mar-23-2026-03-31-35-pm.png', 0, NULL, 'slim2', NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, '2026-02-19 17:29:18', '2026-03-23 15:32:03');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_schemes`
--

CREATE TABLE `invoice_schemes` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `scheme_type` enum('blank','year') NOT NULL,
  `number_type` varchar(100) NOT NULL DEFAULT 'sequential',
  `prefix` varchar(191) DEFAULT NULL,
  `start_number` int(11) DEFAULT NULL,
  `invoice_count` int(11) NOT NULL DEFAULT 0,
  `total_digits` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoice_schemes`
--

INSERT INTO `invoice_schemes` (`id`, `business_id`, `name`, `scheme_type`, `number_type`, `prefix`, `start_number`, `invoice_count`, `total_digits`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 1, 'Default', 'blank', 'sequential', '', 1, 36, 4, 1, '2026-02-19 17:29:18', '2026-03-27 17:27:34');

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `file_name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `uploaded_by` int(11) DEFAULT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_media_type` varchar(191) DEFAULT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(4, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(6, '2016_06_01_000004_create_oauth_clients_table', 1),
(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(8, '2017_07_05_071953_create_currencies_table', 1),
(9, '2017_07_05_073658_create_business_table', 1),
(10, '2017_07_22_075923_add_business_id_users_table', 1),
(11, '2017_07_23_113209_create_brands_table', 1),
(12, '2017_07_26_083429_create_permission_tables', 1),
(13, '2017_07_26_110000_create_tax_rates_table', 1),
(14, '2017_07_26_122313_create_units_table', 1),
(15, '2017_07_27_075706_create_contacts_table', 1),
(16, '2017_08_04_071038_create_categories_table', 1),
(17, '2017_08_08_115903_create_products_table', 1),
(18, '2017_08_09_061616_create_variation_templates_table', 1),
(19, '2017_08_09_061638_create_variation_value_templates_table', 1),
(20, '2017_08_10_061146_create_product_variations_table', 1),
(21, '2017_08_10_061216_create_variations_table', 1),
(22, '2017_08_19_054827_create_transactions_table', 1),
(23, '2017_08_31_073533_create_purchase_lines_table', 1),
(24, '2017_10_15_064638_create_transaction_payments_table', 1),
(25, '2017_10_31_065621_add_default_sales_tax_to_business_table', 1),
(26, '2017_11_20_051930_create_table_group_sub_taxes', 1),
(27, '2017_11_20_063603_create_transaction_sell_lines', 1),
(28, '2017_11_21_064540_create_barcodes_table', 1),
(29, '2017_11_23_181237_create_invoice_schemes_table', 1),
(30, '2017_12_25_122822_create_business_locations_table', 1),
(31, '2017_12_25_160253_add_location_id_to_transactions_table', 1),
(32, '2017_12_25_163227_create_variation_location_details_table', 1),
(33, '2018_01_04_115627_create_sessions_table', 1),
(34, '2018_01_05_112817_create_invoice_layouts_table', 1),
(35, '2018_01_06_112303_add_invoice_scheme_id_and_invoice_layout_id_to_business_locations', 1),
(36, '2018_01_08_104124_create_expense_categories_table', 1),
(37, '2018_01_08_123327_modify_transactions_table_for_expenses', 1),
(38, '2018_01_09_111005_modify_payment_status_in_transactions_table', 1),
(39, '2018_01_09_111109_add_paid_on_column_to_transaction_payments_table', 1),
(40, '2018_01_25_172439_add_printer_related_fields_to_business_locations_table', 1),
(41, '2018_01_27_184322_create_printers_table', 1),
(42, '2018_01_30_181442_create_cash_registers_table', 1),
(43, '2018_01_31_125836_create_cash_register_transactions_table', 1),
(44, '2018_02_07_173326_modify_business_table', 1),
(45, '2018_02_08_105425_add_enable_product_expiry_column_to_business_table', 1),
(46, '2018_02_08_111027_add_expiry_period_and_expiry_period_type_columns_to_products_table', 1),
(47, '2018_02_08_131118_add_mfg_date_and_exp_date_purchase_lines_table', 1),
(48, '2018_02_08_155348_add_exchange_rate_to_transactions_table', 1),
(49, '2018_02_09_124945_modify_transaction_payments_table_for_contact_payments', 1),
(50, '2018_02_12_113640_create_transaction_sell_lines_purchase_lines_table', 1),
(51, '2018_02_12_114605_add_quantity_sold_in_purchase_lines_table', 1),
(52, '2018_02_13_183323_alter_decimal_fields_size', 1),
(53, '2018_02_14_161928_add_transaction_edit_days_to_business_table', 1),
(54, '2018_02_15_161032_add_document_column_to_transactions_table', 1),
(55, '2018_02_17_124709_add_more_options_to_invoice_layouts', 1),
(56, '2018_02_19_111517_add_keyboard_shortcut_column_to_business_table', 1),
(57, '2018_02_19_121537_stock_adjustment_move_to_transaction_table', 1),
(58, '2018_02_20_165505_add_is_direct_sale_column_to_transactions_table', 1),
(59, '2018_02_21_105329_create_system_table', 1),
(60, '2018_02_23_100549_version_1_2', 1),
(61, '2018_02_23_125648_add_enable_editing_sp_from_purchase_column_to_business_table', 1),
(62, '2018_02_26_103612_add_sales_commission_agent_column_to_business_table', 1),
(63, '2018_02_26_130519_modify_users_table_for_sales_cmmsn_agnt', 1),
(64, '2018_02_26_134500_add_commission_agent_to_transactions_table', 1),
(65, '2018_02_27_121422_add_item_addition_method_to_business_table', 1),
(66, '2018_02_27_170232_modify_transactions_table_for_stock_transfer', 1),
(67, '2018_03_05_153510_add_enable_inline_tax_column_to_business_table', 1),
(68, '2018_03_06_210206_modify_product_barcode_types', 1),
(69, '2018_03_13_181541_add_expiry_type_to_business_table', 1),
(70, '2018_03_16_113446_product_expiry_setting_for_business', 1),
(71, '2018_03_19_113601_add_business_settings_options', 1),
(72, '2018_03_26_125334_add_pos_settings_to_business_table', 1),
(73, '2018_03_26_165350_create_customer_groups_table', 1),
(74, '2018_03_27_122720_customer_group_related_changes_in_tables', 1),
(75, '2018_03_29_110138_change_tax_field_to_nullable_in_business_table', 1),
(76, '2018_03_29_115502_add_changes_for_sr_number_in_products_and_sale_lines_table', 1),
(77, '2018_03_29_134340_add_inline_discount_fields_in_purchase_lines', 1),
(78, '2018_03_31_140921_update_transactions_table_exchange_rate', 1),
(79, '2018_04_03_103037_add_contact_id_to_contacts_table', 1),
(80, '2018_04_03_122709_add_changes_to_invoice_layouts_table', 1),
(81, '2018_04_09_135320_change_exchage_rate_size_in_business_table', 1),
(82, '2018_04_17_123122_add_lot_number_to_business', 1),
(83, '2018_04_17_160845_add_product_racks_table', 1),
(84, '2018_04_20_182015_create_res_tables_table', 1),
(85, '2018_04_24_105246_restaurant_fields_in_transaction_table', 1),
(86, '2018_04_24_114149_add_enabled_modules_business_table', 1),
(87, '2018_04_24_133704_add_modules_fields_in_invoice_layout_table', 1),
(88, '2018_04_27_132653_quotation_related_change', 1),
(89, '2018_05_02_104439_add_date_format_and_time_format_to_business', 1),
(90, '2018_05_02_111939_add_sell_return_to_transaction_payments', 1),
(91, '2018_05_14_114027_add_rows_positions_for_products', 1),
(92, '2018_05_14_125223_add_weight_to_products_table', 1),
(93, '2018_05_14_164754_add_opening_stock_permission', 1),
(94, '2018_05_15_134729_add_design_to_invoice_layouts', 1),
(95, '2018_05_16_183307_add_tax_fields_invoice_layout', 1),
(96, '2018_05_18_191956_add_sell_return_to_transaction_table', 1),
(97, '2018_05_21_131349_add_custom_fileds_to_contacts_table', 1),
(98, '2018_05_21_131607_invoice_layout_fields_for_sell_return', 1),
(99, '2018_05_21_131949_add_custom_fileds_and_website_to_business_locations_table', 1),
(100, '2018_05_22_123527_create_reference_counts_table', 1),
(101, '2018_05_22_154540_add_ref_no_prefixes_column_to_business_table', 1),
(102, '2018_05_24_132620_add_ref_no_column_to_transaction_payments_table', 1),
(103, '2018_05_24_161026_add_location_id_column_to_business_location_table', 1),
(104, '2018_05_25_180603_create_modifiers_related_table', 1),
(105, '2018_05_29_121714_add_purchase_line_id_to_stock_adjustment_line_table', 1),
(106, '2018_05_31_114645_add_res_order_status_column_to_transactions_table', 1),
(107, '2018_06_05_103530_rename_purchase_line_id_in_stock_adjustment_lines_table', 1),
(108, '2018_06_05_111905_modify_products_table_for_modifiers', 1),
(109, '2018_06_06_110524_add_parent_sell_line_id_column_to_transaction_sell_lines_table', 1),
(110, '2018_06_07_152443_add_is_service_staff_to_roles_table', 1),
(111, '2018_06_07_182258_add_image_field_to_products_table', 1),
(112, '2018_06_13_133705_create_bookings_table', 1),
(113, '2018_06_15_173636_add_email_column_to_contacts_table', 1),
(114, '2018_06_27_182835_add_superadmin_related_fields_business', 1),
(115, '2018_07_10_101913_add_custom_fields_to_products_table', 1),
(116, '2018_07_17_103434_add_sales_person_name_label_to_invoice_layouts_table', 1),
(117, '2018_07_17_163920_add_theme_skin_color_column_to_business_table', 1),
(118, '2018_07_24_160319_add_lot_no_line_id_to_transaction_sell_lines_table', 1),
(119, '2018_07_25_110004_add_show_expiry_and_show_lot_colums_to_invoice_layouts_table', 1),
(120, '2018_07_25_172004_add_discount_columns_to_transaction_sell_lines_table', 1),
(121, '2018_07_26_124720_change_design_column_type_in_invoice_layouts_table', 1),
(122, '2018_07_26_170424_add_unit_price_before_discount_column_to_transaction_sell_line_table', 1),
(123, '2018_07_28_103614_add_credit_limit_column_to_contacts_table', 1),
(124, '2018_08_08_110755_add_new_payment_methods_to_transaction_payments_table', 1),
(125, '2018_08_08_122225_modify_cash_register_transactions_table_for_new_payment_methods', 1),
(126, '2018_08_14_104036_add_opening_balance_type_to_transactions_table', 1),
(127, '2018_09_04_155900_create_accounts_table', 1),
(128, '2018_09_06_114438_create_selling_price_groups_table', 1),
(129, '2018_09_06_154057_create_variation_group_prices_table', 1),
(130, '2018_09_07_102413_add_permission_to_access_default_selling_price', 1),
(131, '2018_09_07_134858_add_selling_price_group_id_to_transactions_table', 1),
(132, '2018_09_10_112448_update_product_type_to_single_if_null_in_products_table', 1),
(133, '2018_09_10_152703_create_account_transactions_table', 1),
(134, '2018_09_10_173656_add_account_id_column_to_transaction_payments_table', 1),
(135, '2018_09_19_123914_create_notification_templates_table', 1),
(136, '2018_09_22_110504_add_sms_and_email_settings_columns_to_business_table', 1),
(137, '2018_09_24_134942_add_lot_no_line_id_to_stock_adjustment_lines_table', 1),
(138, '2018_09_26_105557_add_transaction_payments_for_existing_expenses', 1),
(139, '2018_09_27_111609_modify_transactions_table_for_purchase_return', 1),
(140, '2018_09_27_131154_add_quantity_returned_column_to_purchase_lines_table', 1),
(141, '2018_10_02_131401_add_return_quantity_column_to_transaction_sell_lines_table', 1),
(142, '2018_10_03_104918_add_qty_returned_column_to_transaction_sell_lines_purchase_lines_table', 1),
(143, '2018_10_03_185947_add_default_notification_templates_to_database', 1),
(144, '2018_10_09_153105_add_business_id_to_transaction_payments_table', 1),
(145, '2018_10_16_135229_create_permission_for_sells_and_purchase', 1),
(146, '2018_10_22_114441_add_columns_for_variable_product_modifications', 1),
(147, '2018_10_22_134428_modify_variable_product_data', 1),
(148, '2018_10_30_181558_add_table_tax_headings_to_invoice_layout', 1),
(149, '2018_10_31_122619_add_pay_terms_field_transactions_table', 1),
(150, '2018_10_31_161328_add_new_permissions_for_pos_screen', 1),
(151, '2018_10_31_174752_add_access_selected_contacts_only_to_users_table', 1),
(152, '2018_10_31_175627_add_user_contact_access', 1),
(153, '2018_10_31_180559_add_auto_send_sms_column_to_notification_templates_table', 1),
(154, '2018_11_02_171949_change_card_type_column_to_varchar_in_transaction_payments_table', 1),
(155, '2018_11_08_105621_add_role_permissions', 1),
(156, '2018_11_26_114135_add_is_suspend_column_to_transactions_table', 1),
(157, '2018_11_28_104410_modify_units_table_for_multi_unit', 1),
(158, '2018_11_28_170952_add_sub_unit_id_to_purchase_lines_and_sell_lines', 1),
(159, '2018_11_29_115918_add_primary_key_in_system_table', 1),
(160, '2018_12_03_185546_add_product_description_column_to_products_table', 1),
(161, '2018_12_06_114937_modify_system_table_and_users_table', 1),
(162, '2018_12_13_160007_add_custom_fields_display_options_to_invoice_layouts_table', 1),
(163, '2018_12_14_103307_modify_system_table', 1),
(164, '2018_12_18_133837_add_prev_balance_due_columns_to_invoice_layouts_table', 1),
(165, '2018_12_18_170656_add_invoice_token_column_to_transaction_table', 1),
(166, '2018_12_20_133639_add_date_time_format_column_to_invoice_layouts_table', 1),
(167, '2018_12_21_120659_add_recurring_invoice_fields_to_transactions_table', 1),
(168, '2018_12_24_154933_create_notifications_table', 1),
(169, '2019_01_08_112015_add_document_column_to_transaction_payments_table', 1),
(170, '2019_01_10_124645_add_account_permission', 1),
(171, '2019_01_16_125825_add_subscription_no_column_to_transactions_table', 1),
(172, '2019_01_28_111647_add_order_addresses_column_to_transactions_table', 1),
(173, '2019_02_13_173821_add_is_inactive_column_to_products_table', 1),
(174, '2019_02_19_103118_create_discounts_table', 1),
(175, '2019_02_21_120324_add_discount_id_column_to_transaction_sell_lines_table', 1),
(176, '2019_02_21_134324_add_permission_for_discount', 1),
(177, '2019_03_04_170832_add_service_staff_columns_to_transaction_sell_lines_table', 1),
(178, '2019_03_09_102425_add_sub_type_column_to_transactions_table', 1),
(179, '2019_03_09_124457_add_indexing_transaction_sell_lines_purchase_lines_table', 1),
(180, '2019_03_12_120336_create_activity_log_table', 1),
(181, '2019_03_15_132925_create_media_table', 1),
(182, '2019_05_08_130339_add_indexing_to_parent_id_in_transaction_payments_table', 1),
(183, '2019_05_10_132311_add_missing_column_indexing', 1),
(184, '2019_05_14_091812_add_show_image_column_to_invoice_layouts_table', 1),
(185, '2019_05_25_104922_add_view_purchase_price_permission', 1),
(186, '2019_06_17_103515_add_profile_informations_columns_to_users_table', 1),
(187, '2019_06_18_135524_add_permission_to_view_own_sales_only', 1),
(188, '2019_06_19_112058_add_database_changes_for_reward_points', 1),
(189, '2019_06_28_133732_change_type_column_to_string_in_transactions_table', 1),
(190, '2019_07_13_111420_add_is_created_from_api_column_to_transactions_table', 1),
(191, '2019_07_15_165136_add_fields_for_combo_product', 1),
(192, '2019_07_19_103446_add_mfg_quantity_used_column_to_purchase_lines_table', 1),
(193, '2019_07_22_152649_add_not_for_selling_in_product_table', 1),
(194, '2019_07_29_185351_add_show_reward_point_column_to_invoice_layouts_table', 1),
(195, '2019_08_08_162302_add_sub_units_related_fields', 1),
(196, '2019_08_26_133419_update_price_fields_decimal_point', 1),
(197, '2019_09_02_160054_remove_location_permissions_from_roles', 1),
(198, '2019_09_03_185259_add_permission_for_pos_screen', 1),
(199, '2019_09_04_163141_add_location_id_to_cash_registers_table', 1),
(200, '2019_09_04_184008_create_types_of_services_table', 1),
(201, '2019_09_06_131445_add_types_of_service_fields_to_transactions_table', 1),
(202, '2019_09_09_134810_add_default_selling_price_group_id_column_to_business_locations_table', 1),
(203, '2019_09_12_105616_create_product_locations_table', 1),
(204, '2019_09_17_122522_add_custom_labels_column_to_business_table', 1),
(205, '2019_09_18_164319_add_shipping_fields_to_transactions_table', 1),
(206, '2019_09_19_170927_close_all_active_registers', 1),
(207, '2019_09_23_161906_add_media_description_cloumn_to_media_table', 1),
(208, '2019_10_18_155633_create_account_types_table', 1),
(209, '2019_10_22_163335_add_common_settings_column_to_business_table', 1),
(210, '2019_10_29_132521_add_update_purchase_status_permission', 1),
(211, '2019_11_09_110522_add_indexing_to_lot_number', 1),
(212, '2019_11_19_170824_add_is_active_column_to_business_locations_table', 1),
(213, '2019_11_21_162913_change_quantity_field_types_to_decimal', 1),
(214, '2019_11_25_160340_modify_categories_table_for_polymerphic_relationship', 1),
(215, '2019_12_02_105025_create_warranties_table', 1),
(216, '2019_12_03_180342_add_common_settings_field_to_invoice_layouts_table', 1),
(217, '2019_12_05_183955_add_more_fields_to_users_table', 1),
(218, '2019_12_06_174904_add_change_return_label_column_to_invoice_layouts_table', 1),
(219, '2019_12_11_121307_add_draft_and_quotation_list_permissions', 1),
(220, '2019_12_12_180126_copy_expense_total_to_total_before_tax', 1),
(221, '2019_12_19_181412_make_alert_quantity_field_nullable_on_products_table', 1),
(222, '2019_12_25_173413_create_dashboard_configurations_table', 1),
(223, '2020_01_08_133506_create_document_and_notes_table', 1),
(224, '2020_01_09_113252_add_cc_bcc_column_to_notification_templates_table', 1),
(225, '2020_01_16_174818_add_round_off_amount_field_to_transactions_table', 1),
(226, '2020_01_28_162345_add_weighing_scale_settings_in_business_settings_table', 1),
(227, '2020_02_18_172447_add_import_fields_to_transactions_table', 1),
(228, '2020_03_13_135844_add_is_active_column_to_selling_price_groups_table', 1),
(229, '2020_03_16_115449_add_contact_status_field_to_contacts_table', 1),
(230, '2020_03_26_124736_add_allow_login_column_in_users_table', 1),
(231, '2020_04_13_154150_add_feature_products_column_to_business_loactions', 1),
(232, '2020_04_15_151802_add_user_type_to_users_table', 1),
(233, '2020_04_22_153905_add_subscription_repeat_on_column_to_transactions_table', 1),
(234, '2020_04_28_111436_add_shipping_address_to_contacts_table', 1),
(235, '2020_06_01_094654_add_max_sale_discount_column_to_users_table', 1),
(236, '2020_06_12_162245_modify_contacts_table', 1),
(237, '2020_06_22_103104_change_recur_interval_default_to_one', 1),
(238, '2020_07_09_174621_add_balance_field_to_contacts_table', 1),
(239, '2020_07_23_104933_change_status_column_to_varchar_in_transaction_table', 1),
(240, '2020_09_07_171059_change_completed_stock_transfer_status_to_final', 1),
(241, '2020_09_21_123224_modify_booking_status_column_in_bookings_table', 1),
(242, '2020_09_22_121639_create_discount_variations_table', 1),
(243, '2020_10_05_121550_modify_business_location_table_for_invoice_layout', 1),
(244, '2020_10_16_175726_set_status_as_received_for_opening_stock', 1),
(245, '2020_10_23_170823_add_for_group_tax_column_to_tax_rates_table', 1),
(246, '2020_11_04_130940_add_more_custom_fields_to_contacts_table', 1),
(247, '2020_11_10_152841_add_cash_register_permissions', 1),
(248, '2020_11_17_164041_modify_type_column_to_varchar_in_contacts_table', 1),
(249, '2020_12_18_181447_add_shipping_custom_fields_to_transactions_table', 1),
(250, '2020_12_22_164303_add_sub_status_column_to_transactions_table', 1),
(251, '2020_12_24_153050_add_custom_fields_to_transactions_table', 1),
(252, '2020_12_28_105403_add_whatsapp_text_column_to_notification_templates_table', 1),
(253, '2020_12_29_165925_add_model_document_type_to_media_table', 1),
(254, '2021_02_08_175632_add_contact_number_fields_to_users_table', 1),
(255, '2021_02_11_172217_add_indexing_for_multiple_columns', 1),
(256, '2021_02_23_122043_add_more_columns_to_customer_groups_table', 1),
(257, '2021_02_24_175551_add_print_invoice_permission_to_all_roles', 1),
(258, '2021_03_03_162021_add_purchase_order_columns_to_purchase_lines_and_transactions_table', 1),
(259, '2021_03_11_120229_add_sales_order_columns', 1),
(260, '2021_03_16_120705_add_business_id_to_activity_log_table', 1),
(261, '2021_03_16_153427_add_code_columns_to_business_table', 1),
(262, '2021_03_18_173308_add_account_details_column_to_accounts_table', 1),
(263, '2021_03_18_183119_add_prefer_payment_account_columns_to_transactions_table', 1),
(264, '2021_03_22_120810_add_more_types_of_service_custom_fields', 1),
(265, '2021_03_24_183132_add_shipping_export_custom_field_details_to_contacts_table', 1),
(266, '2021_03_25_170715_add_export_custom_fields_info_to_transactions_table', 1),
(267, '2021_04_15_063449_add_denominations_column_to_cash_registers_table', 1),
(268, '2021_05_22_083426_add_indexing_to_account_transactions_table', 1),
(269, '2021_07_08_065808_add_additional_expense_columns_to_transaction_table', 1),
(270, '2021_07_13_082918_add_qr_code_columns_to_invoice_layouts_table', 1),
(271, '2021_07_21_061615_add_fields_to_show_commission_agent_in_invoice_layout', 1),
(272, '2021_08_13_105549_add_crm_contact_id_to_users_table', 1),
(273, '2021_08_25_114932_add_payment_link_fields_to_transaction_payments_table', 1),
(274, '2021_09_01_063110_add_spg_column_to_discounts_table', 1),
(275, '2021_09_03_061528_modify_cash_register_transactions_table', 1),
(276, '2021_10_05_061658_add_source_column_to_transactions_table', 1),
(277, '2021_12_16_121851_add_parent_id_column_to_expense_categories_table', 1),
(278, '2022_04_14_075120_add_payment_type_column_to_transaction_payments_table', 1),
(279, '2022_04_21_083327_create_cash_denominations_table', 1),
(280, '2022_05_10_055307_add_delivery_date_column_to_transactions_table', 1),
(281, '2022_06_13_123135_add_currency_precision_and_quantity_precision_fields_to_business_table', 1),
(282, '2022_06_28_133342_add_secondary_unit_columns_to_products_sell_line_purchase_lines_tables', 1),
(283, '2022_07_13_114307_create_purchase_requisition_related_columns', 1),
(284, '2022_08_25_132707_add_service_staff_timer_fields_to_products_and_users_table', 1),
(285, '2023_01_28_114255_add_letter_head_column_to_invoice_layouts_table', 1),
(286, '2023_02_11_161510_add_event_column_to_activity_log_table', 1),
(287, '2023_02_11_161511_add_batch_uuid_column_to_activity_log_table', 1),
(288, '2023_03_02_170312_add_provider_to_oauth_clients_table', 1),
(289, '2023_03_21_122731_add_sale_invoice_scheme_id_business_table', 1),
(290, '2023_03_21_170446_add_number_type_to_invoice_scheme', 1),
(291, '2023_04_17_155216_add_custom_fields_to_products', 1),
(292, '2023_04_28_130247_add_price_type_to_group_price_table', 1),
(293, '2023_06_21_033923_add_delivery_person_in_transactions', 1),
(294, '2023_09_13_153555_add_service_staff_pin_columns_in_users', 1),
(295, '2023_09_15_154404_add_is_kitchen_order_in_transactions', 1),
(296, '2023_12_06_152840_add_contact_type_in_contacts', 1),
(297, '2024_10_03_151459_modify_transaction_sell_lines_purchase_lines_table', 1),
(298, '2025_03_07_114637_add_more_addresh_column_in_contact', 1),
(299, '2025_09_19_120000_add_previous_balance_due_fields_to_invoice_layouts_table', 1),
(300, '2026_02_21_090000_add_index_to_products_sku', 2),
(301, '2026_03_02_000000_add_measurement_unit_to_barcodes_table', 3),
(302, '2026_03_02_000100_add_rotate_labels_to_barcodes_table', 4),
(303, '2026_03_04_000000_create_print_jobs_table', 5);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_permissions`
--

INSERT INTO `model_has_permissions` (`permission_id`, `model_type`, `model_id`) VALUES
(80, 'App\\User', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\User', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(191) NOT NULL,
  `notifiable_type` varchar(191) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_templates`
--

CREATE TABLE `notification_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `template_for` varchar(191) NOT NULL,
  `email_body` text DEFAULT NULL,
  `sms_body` text DEFAULT NULL,
  `whatsapp_text` text DEFAULT NULL,
  `subject` varchar(191) DEFAULT NULL,
  `cc` varchar(191) DEFAULT NULL,
  `bcc` varchar(191) DEFAULT NULL,
  `auto_send` tinyint(1) NOT NULL DEFAULT 0,
  `auto_send_sms` tinyint(1) NOT NULL DEFAULT 0,
  `auto_send_wa_notif` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notification_templates`
--

INSERT INTO `notification_templates` (`id`, `business_id`, `template_for`, `email_body`, `sms_body`, `whatsapp_text`, `subject`, `cc`, `bcc`, `auto_send`, `auto_send_sms`, `auto_send_wa_notif`, `created_at`, `updated_at`) VALUES
(1, 1, 'new_sale', '<p>Dear {contact_name},</p>\n\n                    <p>Your invoice number is {invoice_number}<br />\n                    Total amount: {total_amount}<br />\n                    Paid amount: {received_amount}</p>\n\n                    <p>Thank you for shopping with us.</p>\n\n                    <p>{business_logo}</p>\n\n                    <p>&nbsp;</p>', 'Dear {contact_name}, Thank you for shopping with us. {business_name}', NULL, 'Thank you from {business_name}', NULL, NULL, 0, 0, 0, '2026-02-19 17:29:18', '2026-02-19 17:29:18'),
(2, 1, 'payment_received', '<p>Dear {contact_name},</p>\n\n                <p>We have received a payment of {received_amount}</p>\n\n                <p>{business_logo}</p>', 'Dear {contact_name}, We have received a payment of {received_amount}. {business_name}', NULL, 'Payment Received, from {business_name}', NULL, NULL, 0, 0, 0, '2026-02-19 17:29:18', '2026-02-19 17:29:18'),
(3, 1, 'payment_reminder', '<p>Dear {contact_name},</p>\n\n                    <p>This is to remind you that you have pending payment of {due_amount}. Kindly pay it as soon as possible.</p>\n\n                    <p>{business_logo}</p>', 'Dear {contact_name}, You have pending payment of {due_amount}. Kindly pay it as soon as possible. {business_name}', NULL, 'Payment Reminder, from {business_name}', NULL, NULL, 0, 0, 0, '2026-02-19 17:29:18', '2026-02-19 17:29:18'),
(4, 1, 'new_booking', '<p>Dear {contact_name},</p>\n\n                    <p>Your booking is confirmed</p>\n\n                    <p>Date: {start_time} to {end_time}</p>\n\n                    <p>Table: {table}</p>\n\n                    <p>Location: {location}</p>\n\n                    <p>{business_logo}</p>', 'Dear {contact_name}, Your booking is confirmed. Date: {start_time} to {end_time}, Table: {table}, Location: {location}', NULL, 'Booking Confirmed - {business_name}', NULL, NULL, 0, 0, 0, '2026-02-19 17:29:18', '2026-02-19 17:29:18'),
(5, 1, 'new_order', '<p>Dear {contact_name},</p>\n\n                    <p>We have a new order with reference number {order_ref_number}. Kindly process the products as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'Dear {contact_name}, We have a new order with reference number {order_ref_number}. Kindly process the products as soon as possible. {business_name}', NULL, 'New Order, from {business_name}', NULL, NULL, 0, 0, 0, '2026-02-19 17:29:18', '2026-02-19 17:29:18'),
(6, 1, 'payment_paid', '<p>Dear {contact_name},</p>\n\n                    <p>We have paid amount {paid_amount} again invoice number {order_ref_number}.<br />\n                    Kindly note it down.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'We have paid amount {paid_amount} again invoice number {order_ref_number}.\n                    Kindly note it down. {business_name}', NULL, 'Payment Paid, from {business_name}', NULL, NULL, 0, 0, 0, '2026-02-19 17:29:18', '2026-02-19 17:29:18'),
(7, 1, 'items_received', '<p>Dear {contact_name},</p>\n\n                    <p>We have received all items from invoice reference number {order_ref_number}. Thank you for processing it.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'We have received all items from invoice reference number {order_ref_number}. Thank you for processing it. {business_name}', NULL, 'Items received, from {business_name}', NULL, NULL, 0, 0, 0, '2026-02-19 17:29:18', '2026-02-19 17:29:18'),
(8, 1, 'items_pending', '<p>Dear {contact_name},<br />\n                    This is to remind you that we have not yet received some items from invoice reference number {order_ref_number}. Please process it as soon as possible.</p>\n\n                    <p>{business_name}<br />\n                    {business_logo}</p>', 'This is to remind you that we have not yet received some items from invoice reference number {order_ref_number} . Please process it as soon as possible.{business_name}', NULL, 'Items Pending, from {business_name}', NULL, NULL, 0, 0, 0, '2026-02-19 17:29:18', '2026-02-19 17:29:18'),
(9, 1, 'new_quotation', '<p>Dear {contact_name},</p>\n\n                    <p>Your quotation number is {invoice_number}<br />\n                    Total amount: {total_amount}</p>\n\n                    <p>Thank you for shopping with us.</p>\n\n                    <p>{business_logo}</p>\n\n                    <p>&nbsp;</p>', 'Dear {contact_name}, Thank you for shopping with us. {business_name}', NULL, 'Thank you from {business_name}', NULL, NULL, 0, 0, 0, '2026-02-19 17:29:18', '2026-02-19 17:29:18'),
(10, 1, 'purchase_order', '<p>Dear {contact_name},</p>\n\n                    <p>We have a new purchase order with reference number {order_ref_number}. The respective invoice is attached here with.</p>\n\n                    <p>{business_logo}</p>', 'We have a new purchase order with reference number {order_ref_number}. {business_name}', NULL, 'New Purchase Order, from {business_name}', NULL, NULL, 0, 0, 0, '2026-02-19 17:29:18', '2026-02-19 17:29:18');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `secret` varchar(100) NOT NULL,
  `provider` varchar(191) DEFAULT NULL,
  `redirect` text NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) NOT NULL,
  `access_token_id` varchar(100) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `guard_name` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'profit_loss_report.view', 'web', '2026-02-19 17:14:30', NULL),
(2, 'direct_sell.access', 'web', '2026-02-19 17:14:30', NULL),
(3, 'product.opening_stock', 'web', '2026-02-19 17:14:30', '2026-02-19 17:14:30'),
(4, 'crud_all_bookings', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(5, 'crud_own_bookings', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(6, 'access_default_selling_price', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(7, 'purchase.payments', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(8, 'sell.payments', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(9, 'edit_product_price_from_sale_screen', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(10, 'edit_product_discount_from_sale_screen', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(11, 'roles.view', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(12, 'roles.create', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(13, 'roles.update', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(14, 'roles.delete', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(15, 'account.access', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(16, 'discount.access', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(17, 'view_purchase_price', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(18, 'view_own_sell_only', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(19, 'edit_product_discount_from_pos_screen', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(20, 'edit_product_price_from_pos_screen', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(21, 'access_shipping', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(22, 'purchase.update_status', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(23, 'list_drafts', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(24, 'list_quotations', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(25, 'view_cash_register', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(26, 'close_cash_register', 'web', '2026-02-19 17:14:31', '2026-02-19 17:14:31'),
(27, 'print_invoice', 'web', '2026-02-19 17:14:32', '2026-02-19 17:14:32'),
(28, 'user.view', 'web', '2026-02-19 17:23:09', NULL),
(29, 'user.create', 'web', '2026-02-19 17:23:09', NULL),
(30, 'user.update', 'web', '2026-02-19 17:23:09', NULL),
(31, 'user.delete', 'web', '2026-02-19 17:23:09', NULL),
(32, 'supplier.view', 'web', '2026-02-19 17:23:09', NULL),
(33, 'supplier.create', 'web', '2026-02-19 17:23:09', NULL),
(34, 'supplier.update', 'web', '2026-02-19 17:23:09', NULL),
(35, 'supplier.delete', 'web', '2026-02-19 17:23:09', NULL),
(36, 'customer.view', 'web', '2026-02-19 17:23:09', NULL),
(37, 'customer.create', 'web', '2026-02-19 17:23:09', NULL),
(38, 'customer.update', 'web', '2026-02-19 17:23:09', NULL),
(39, 'customer.delete', 'web', '2026-02-19 17:23:09', NULL),
(40, 'product.view', 'web', '2026-02-19 17:23:09', NULL),
(41, 'product.create', 'web', '2026-02-19 17:23:09', NULL),
(42, 'product.update', 'web', '2026-02-19 17:23:09', NULL),
(43, 'product.delete', 'web', '2026-02-19 17:23:09', NULL),
(44, 'purchase.view', 'web', '2026-02-19 17:23:09', NULL),
(45, 'purchase.create', 'web', '2026-02-19 17:23:09', NULL),
(46, 'purchase.update', 'web', '2026-02-19 17:23:09', NULL),
(47, 'purchase.delete', 'web', '2026-02-19 17:23:09', NULL),
(48, 'sell.view', 'web', '2026-02-19 17:23:09', NULL),
(49, 'sell.create', 'web', '2026-02-19 17:23:09', NULL),
(50, 'sell.update', 'web', '2026-02-19 17:23:09', NULL),
(51, 'sell.delete', 'web', '2026-02-19 17:23:09', NULL),
(52, 'purchase_n_sell_report.view', 'web', '2026-02-19 17:23:09', NULL),
(53, 'contacts_report.view', 'web', '2026-02-19 17:23:09', NULL),
(54, 'stock_report.view', 'web', '2026-02-19 17:23:09', NULL),
(55, 'tax_report.view', 'web', '2026-02-19 17:23:09', NULL),
(56, 'trending_product_report.view', 'web', '2026-02-19 17:23:09', NULL),
(57, 'register_report.view', 'web', '2026-02-19 17:23:09', NULL),
(58, 'sales_representative.view', 'web', '2026-02-19 17:23:09', NULL),
(59, 'expense_report.view', 'web', '2026-02-19 17:23:09', NULL),
(60, 'business_settings.access', 'web', '2026-02-19 17:23:09', NULL),
(61, 'barcode_settings.access', 'web', '2026-02-19 17:23:09', NULL),
(62, 'invoice_settings.access', 'web', '2026-02-19 17:23:09', NULL),
(63, 'brand.view', 'web', '2026-02-19 17:23:09', NULL),
(64, 'brand.create', 'web', '2026-02-19 17:23:09', NULL),
(65, 'brand.update', 'web', '2026-02-19 17:23:09', NULL),
(66, 'brand.delete', 'web', '2026-02-19 17:23:09', NULL),
(67, 'tax_rate.view', 'web', '2026-02-19 17:23:09', NULL),
(68, 'tax_rate.create', 'web', '2026-02-19 17:23:09', NULL),
(69, 'tax_rate.update', 'web', '2026-02-19 17:23:09', NULL),
(70, 'tax_rate.delete', 'web', '2026-02-19 17:23:09', NULL),
(71, 'unit.view', 'web', '2026-02-19 17:23:09', NULL),
(72, 'unit.create', 'web', '2026-02-19 17:23:09', NULL),
(73, 'unit.update', 'web', '2026-02-19 17:23:09', NULL),
(74, 'unit.delete', 'web', '2026-02-19 17:23:09', NULL),
(75, 'category.view', 'web', '2026-02-19 17:23:09', NULL),
(76, 'category.create', 'web', '2026-02-19 17:23:09', NULL),
(77, 'category.update', 'web', '2026-02-19 17:23:09', NULL),
(78, 'category.delete', 'web', '2026-02-19 17:23:09', NULL),
(79, 'expense.access', 'web', '2026-02-19 17:23:09', NULL),
(80, 'access_all_locations', 'web', '2026-02-19 17:23:09', NULL),
(81, 'dashboard.data', 'web', '2026-02-19 17:23:09', NULL),
(82, 'location.1', 'web', '2026-02-19 17:29:18', '2026-02-19 17:29:18');

-- --------------------------------------------------------

--
-- Table structure for table `printers`
--

CREATE TABLE `printers` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `connection_type` enum('network','windows','linux') NOT NULL,
  `capability_profile` enum('default','simple','SP2000','TEP-200M','P822D') NOT NULL DEFAULT 'default',
  `char_per_line` varchar(191) DEFAULT NULL,
  `ip_address` varchar(191) DEFAULT NULL,
  `port` varchar(191) DEFAULT NULL,
  `path` varchar(191) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `printers`
--

INSERT INTO `printers` (`id`, `business_id`, `name`, `connection_type`, `capability_profile`, `char_per_line`, `ip_address`, `port`, `path`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 'Xprinter', 'windows', 'default', '42', '', '', 'usb://Xprinter/XP-365B?serial=0020406D82AB', 1, '2026-02-20 12:13:52', '2026-03-02 15:13:31');

-- --------------------------------------------------------

--
-- Table structure for table `print_jobs`
--

CREATE TABLE `print_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `status` varchar(20) NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payload`)),
  `station_id` varchar(64) DEFAULT NULL,
  `started_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `error` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `print_jobs`
--

INSERT INTO `print_jobs` (`id`, `business_id`, `created_by`, `type`, `status`, `payload`, `station_id`, `started_at`, `completed_at`, `error`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'label', 'failed', '{\"form\":\"_token=lmGFpMOI7lSBfpbaKXOuFJqP460vWK3TzskRrDE6&search_product=&products%5B0%5D%5Bproduct_id%5D=5&products%5B0%5D%5Bvariation_id%5D=5&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', 'station_sl50o1gq7mmbtjo5e', '2026-03-04 14:42:58', '2026-03-04 14:43:05', 'Unable to establish connection with QZ', '2026-03-04 11:37:11', '2026-03-04 14:43:05'),
(2, 1, 1, 'label', 'failed', '{\"form\":\"_token=lmGFpMOI7lSBfpbaKXOuFJqP460vWK3TzskRrDE6&search_product=&products%5B0%5D%5Bproduct_id%5D=5&products%5B0%5D%5Bvariation_id%5D=5&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', 'station_sl50o1gq7mmbtjo5e', '2026-03-04 14:43:05', '2026-03-04 14:43:49', 'Unable to establish connection with QZ', '2026-03-04 11:37:11', '2026-03-04 14:43:49'),
(3, 1, 1, 'label', 'failed', '{\"form\":\"_token=lmGFpMOI7lSBfpbaKXOuFJqP460vWK3TzskRrDE6&search_product=&products%5B0%5D%5Bproduct_id%5D=5&products%5B0%5D%5Bvariation_id%5D=5&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', 'station_sl50o1gq7mmbtjo5e', '2026-03-04 14:43:49', '2026-03-04 14:44:41', 'Unable to establish connection with QZ', '2026-03-04 11:37:11', '2026-03-04 14:44:41'),
(4, 1, 1, 'label', 'failed', '{\"form\":\"_token=lmGFpMOI7lSBfpbaKXOuFJqP460vWK3TzskRrDE6&search_product=&products%5B0%5D%5Bproduct_id%5D=5&products%5B0%5D%5Bvariation_id%5D=5&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', 'station_sl50o1gq7mmbtjo5e', '2026-03-04 14:44:41', '2026-03-04 14:45:34', 'Unable to establish connection with QZ', '2026-03-04 11:37:11', '2026-03-04 14:45:34'),
(5, 1, 1, 'label', 'failed', '{\"form\":\"_token=lmGFpMOI7lSBfpbaKXOuFJqP460vWK3TzskRrDE6&search_product=&products%5B0%5D%5Bproduct_id%5D=5&products%5B0%5D%5Bvariation_id%5D=5&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', 'station_sl50o1gq7mmbtjo5e', '2026-03-04 14:45:34', '2026-03-04 14:46:23', 'Unable to establish connection with QZ', '2026-03-04 11:37:11', '2026-03-04 14:46:23'),
(6, 1, 1, 'label', 'failed', '{\"form\":\"_token=lmGFpMOI7lSBfpbaKXOuFJqP460vWK3TzskRrDE6&search_product=&products%5B0%5D%5Bproduct_id%5D=5&products%5B0%5D%5Bvariation_id%5D=5&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', 'station_sl50o1gq7mmbtjo5e', '2026-03-04 14:46:24', '2026-03-04 14:47:22', 'Unable to establish connection with QZ', '2026-03-04 11:37:11', '2026-03-04 14:47:22'),
(7, 1, 1, 'label', 'failed', '{\"form\":\"_token=lmGFpMOI7lSBfpbaKXOuFJqP460vWK3TzskRrDE6&search_product=&products%5B0%5D%5Bproduct_id%5D=5&products%5B0%5D%5Bvariation_id%5D=5&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', 'station_sl50o1gq7mmbtjo5e', '2026-03-04 14:47:23', '2026-03-04 14:48:12', 'Unable to establish connection with QZ', '2026-03-04 11:37:11', '2026-03-04 14:48:12'),
(8, 1, 1, 'label', 'failed', '{\"form\":\"_token=lmGFpMOI7lSBfpbaKXOuFJqP460vWK3TzskRrDE6&search_product=&products%5B0%5D%5Bproduct_id%5D=5&products%5B0%5D%5Bvariation_id%5D=5&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', 'station_sl50o1gq7mmbtjo5e', '2026-03-04 14:48:13', '2026-03-04 14:49:06', 'Unable to establish connection with QZ', '2026-03-04 11:37:11', '2026-03-04 14:49:06'),
(9, 1, 1, 'label', 'failed', '{\"form\":\"_token=lmGFpMOI7lSBfpbaKXOuFJqP460vWK3TzskRrDE6&search_product=&products%5B0%5D%5Bproduct_id%5D=5&products%5B0%5D%5Bvariation_id%5D=5&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', 'station_sl50o1gq7mmbtjo5e', '2026-03-04 14:49:07', '2026-03-04 14:49:59', 'Unable to establish connection with QZ', '2026-03-04 11:37:11', '2026-03-04 14:49:59'),
(10, 1, 1, 'label', 'printing', '{\"form\":\"_token=lmGFpMOI7lSBfpbaKXOuFJqP460vWK3TzskRrDE6&search_product=&products%5B0%5D%5Bproduct_id%5D=5&products%5B0%5D%5Bvariation_id%5D=5&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', 'station_sl50o1gq7mmbtjo5e', '2026-03-04 14:50:00', NULL, NULL, '2026-03-04 11:37:11', '2026-03-04 14:50:00'),
(11, 1, 1, 'label', 'printing', '{\"form\":\"_token=lmGFpMOI7lSBfpbaKXOuFJqP460vWK3TzskRrDE6&search_product=&products%5B0%5D%5Bproduct_id%5D=5&products%5B0%5D%5Bvariation_id%5D=5&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', 'station_sl50o1gq7mmbtjo5e', '2026-03-04 14:50:25', NULL, NULL, '2026-03-04 11:37:11', '2026-03-04 14:50:25'),
(12, 1, 1, 'label', 'cancelled', '{\"form\":\"_token=lmGFpMOI7lSBfpbaKXOuFJqP460vWK3TzskRrDE6&search_product=&products%5B0%5D%5Bproduct_id%5D=5&products%5B0%5D%5Bvariation_id%5D=5&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, '2026-03-04 14:50:27', NULL, '2026-03-04 12:54:31', '2026-03-04 14:50:27'),
(13, 1, 1, 'label', 'cancelled', '{\"form\":\"_token=hDuvSLTs0djmm5M3NOwSEupkzvaLDCPxl9W62A5Y&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, '2026-03-04 14:50:27', NULL, '2026-03-04 14:48:45', '2026-03-04 14:50:27'),
(14, 1, 1, 'label', 'cancelled', '{\"form\":\"_token=lmGFpMOI7lSBfpbaKXOuFJqP460vWK3TzskRrDE6&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, '2026-03-04 14:50:27', NULL, '2026-03-04 14:49:23', '2026-03-04 14:50:27'),
(15, 1, 1, 'label', 'printing', '{\"form\":\"_token=hDuvSLTs0djmm5M3NOwSEupkzvaLDCPxl9W62A5Y&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', 'station_sl50o1gq7mmbtjo5e', '2026-03-04 14:51:21', NULL, NULL, '2026-03-04 14:51:20', '2026-03-04 14:51:21'),
(16, 1, 1, 'label', 'cancelled', '{\"form\":\"_token=hDuvSLTs0djmm5M3NOwSEupkzvaLDCPxl9W62A5Y&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, '2026-03-04 14:51:25', NULL, '2026-03-04 14:51:20', '2026-03-04 14:51:25'),
(17, 1, 1, 'label', 'cancelled', '{\"form\":\"_token=hDuvSLTs0djmm5M3NOwSEupkzvaLDCPxl9W62A5Y&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, '2026-03-04 14:51:25', NULL, '2026-03-04 14:51:20', '2026-03-04 14:51:25'),
(18, 1, 1, 'label', 'cancelled', '{\"form\":\"_token=hDuvSLTs0djmm5M3NOwSEupkzvaLDCPxl9W62A5Y&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, '2026-03-04 14:51:25', NULL, '2026-03-04 14:51:20', '2026-03-04 14:51:25'),
(19, 1, 1, 'label', 'failed', '{\"form\":\"_token=hDuvSLTs0djmm5M3NOwSEupkzvaLDCPxl9W62A5Y&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', 'station_sl50o1gq7mmbtjo5e', '2026-03-04 14:52:24', '2026-03-04 14:53:13', 'Unable to establish connection with QZ', '2026-03-04 14:52:23', '2026-03-04 14:53:13'),
(20, 1, 1, 'label', 'failed', '{\"form\":\"_token=hDuvSLTs0djmm5M3NOwSEupkzvaLDCPxl9W62A5Y&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', 'station_sl50o1gq7mmbtjo5e', '2026-03-04 15:14:49', '2026-03-04 15:14:55', 'Unable to establish connection with QZ', '2026-03-04 15:14:49', '2026-03-04 15:14:55'),
(21, 1, 1, 'label', 'failed', '{\"form\":\"_token=hDuvSLTs0djmm5M3NOwSEupkzvaLDCPxl9W62A5Y&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', 'station_sl50o1gq7mmbtjo5e', '2026-03-04 15:16:28', '2026-03-04 15:17:15', 'Unable to establish connection with QZ', '2026-03-04 15:16:27', '2026-03-04 15:17:15'),
(22, 1, 1, 'label', 'printing', '{\"form\":\"_token=hDuvSLTs0djmm5M3NOwSEupkzvaLDCPxl9W62A5Y&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', 'station_3jj0n5ntcmmbuke2j', '2026-03-04 15:16:29', NULL, NULL, '2026-03-04 15:16:27', '2026-03-04 15:16:29'),
(23, 1, 1, 'label', 'failed', '{\"form\":\"_token=hDuvSLTs0djmm5M3NOwSEupkzvaLDCPxl9W62A5Y&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', 'station_sl50o1gq7mmbtjo5e', '2026-03-04 15:17:15', '2026-03-04 15:17:58', 'Unable to establish connection with QZ', '2026-03-04 15:16:30', '2026-03-04 15:17:58'),
(24, 1, 1, 'label', 'failed', '{\"form\":\"_token=hDuvSLTs0djmm5M3NOwSEupkzvaLDCPxl9W62A5Y&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', 'station_sl50o1gq7mmbtjo5e', '2026-03-04 15:17:59', '2026-03-04 15:18:46', 'Unable to establish connection with QZ', '2026-03-04 15:16:31', '2026-03-04 15:18:46'),
(25, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:16:47', '2026-03-14 15:16:47'),
(26, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:16:48', '2026-03-14 15:16:48'),
(27, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:19:24', '2026-03-14 15:19:24'),
(28, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:22:51', '2026-03-14 15:22:51'),
(29, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:22:51', '2026-03-14 15:22:51'),
(30, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:24:43', '2026-03-14 15:24:43'),
(31, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:24:43', '2026-03-14 15:24:43'),
(32, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:24:43', '2026-03-14 15:24:43'),
(33, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:24:43', '2026-03-14 15:24:43'),
(34, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:24:43', '2026-03-14 15:24:43'),
(35, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:24:43', '2026-03-14 15:24:43'),
(36, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:24:43', '2026-03-14 15:24:43'),
(37, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:24:43', '2026-03-14 15:24:43'),
(38, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:24:43', '2026-03-14 15:24:43'),
(39, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:24:43', '2026-03-14 15:24:43'),
(40, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:24:43', '2026-03-14 15:24:43'),
(41, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:24:43', '2026-03-14 15:24:43'),
(42, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:24:43', '2026-03-14 15:24:43'),
(43, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:24:43', '2026-03-14 15:24:43'),
(44, 1, 1, 'label', 'pending', '{\"form\":\"_token=lYb29m456kop6XYIIjLVFhMbZYprcbUIFGMYdEtk&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-14 15:24:43', '2026-03-14 15:24:43'),
(45, 1, 1, 'label', 'pending', '{\"form\":\"_token=pigpnuMapMUsG3oaZdvbowljUeW5bi3hgWui2XzE&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=5&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-21 13:35:25', '2026-03-21 13:35:25'),
(46, 1, 1, 'label', 'pending', '{\"form\":\"_token=pigpnuMapMUsG3oaZdvbowljUeW5bi3hgWui2XzE&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=5&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-21 13:36:19', '2026-03-21 13:36:19'),
(47, 1, 1, 'label', 'pending', '{\"form\":\"_token=pigpnuMapMUsG3oaZdvbowljUeW5bi3hgWui2XzE&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=5&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-21 13:36:26', '2026-03-21 13:36:26'),
(48, 1, 1, 'label', 'pending', '{\"form\":\"_token=pigpnuMapMUsG3oaZdvbowljUeW5bi3hgWui2XzE&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-21 14:01:23', '2026-03-21 14:01:23'),
(49, 1, 1, 'label', 'pending', '{\"form\":\"_token=pigpnuMapMUsG3oaZdvbowljUeW5bi3hgWui2XzE&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-21 14:01:53', '2026-03-21 14:01:53'),
(50, 1, 1, 'label', 'pending', '{\"form\":\"_token=pigpnuMapMUsG3oaZdvbowljUeW5bi3hgWui2XzE&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-21 14:02:09', '2026-03-21 14:02:09'),
(51, 1, 1, 'label', 'pending', '{\"form\":\"_token=iu4wTblvxf1AUaMRXFhnZYTsiQTEeOKmWG1Zt6zA&search_product=y&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-21 16:35:20', '2026-03-21 16:35:20'),
(52, 1, 1, 'label', 'pending', '{\"form\":\"_token=iu4wTblvxf1AUaMRXFhnZYTsiQTEeOKmWG1Zt6zA&search_product=y&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-21 16:36:18', '2026-03-21 16:36:18'),
(53, 1, 1, 'label', 'pending', '{\"form\":\"_token=iu4wTblvxf1AUaMRXFhnZYTsiQTEeOKmWG1Zt6zA&search_product=y&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-21 16:37:45', '2026-03-21 16:37:45'),
(54, 1, 1, 'label', 'pending', '{\"form\":\"_token=iu4wTblvxf1AUaMRXFhnZYTsiQTEeOKmWG1Zt6zA&search_product=&products%5B0%5D%5Bproduct_id%5D=11&products%5B0%5D%5Bvariation_id%5D=11&products%5B0%5D%5Bquantity%5D=4&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-21 16:40:39', '2026-03-21 16:40:39'),
(55, 1, 1, 'label', 'pending', '{\"form\":\"_token=iu4wTblvxf1AUaMRXFhnZYTsiQTEeOKmWG1Zt6zA&search_product=&products%5B0%5D%5Bproduct_id%5D=68&products%5B0%5D%5Bvariation_id%5D=68&products%5B0%5D%5Bquantity%5D=5&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-21 17:07:11', '2026-03-21 17:07:11'),
(56, 1, 1, 'label', 'pending', '{\"form\":\"_token=yaTC6fgXqSqETIJTPbfju4zwJ4BC3DW6uOfXofVb&search_product=&products%5B0%5D%5Bproduct_id%5D=73&products%5B0%5D%5Bvariation_id%5D=73&products%5B0%5D%5Bquantity%5D=12&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-27 12:53:17', '2026-03-27 12:53:17'),
(57, 1, 1, 'label', 'pending', '{\"form\":\"_token=ta709kkYFy4erwUVbhc71oSY1AlgSyLvKNhn2wc9&search_product=&products%5B0%5D%5Bproduct_id%5D=66&products%5B0%5D%5Bvariation_id%5D=66&products%5B0%5D%5Bquantity%5D=1&products%5B0%5D%5Bpacking_date%5D=&products%5B0%5D%5Bprice_group_id%5D=&print%5Bname%5D=1&print%5Bname_size%5D=15&print%5Bvariations%5D=1&print%5Bvariations_size%5D=17&print%5Bprice%5D=1&print%5Bprice_size%5D=17&print%5Bprice_type%5D=inclusive&print%5Bbusiness_name%5D=1&print%5Bbusiness_name_size%5D=20&print%5Bpacking_date%5D=1&print%5Bpacking_date_size%5D=12&barcode_setting=7\"}', NULL, NULL, NULL, NULL, '2026-03-27 13:05:18', '2026-03-27 13:05:18');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `type` enum('single','variable','modifier','combo') DEFAULT NULL,
  `unit_id` int(11) UNSIGNED DEFAULT NULL,
  `secondary_unit_id` int(11) DEFAULT NULL,
  `sub_unit_ids` text DEFAULT NULL,
  `brand_id` int(10) UNSIGNED DEFAULT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `sub_category_id` int(10) UNSIGNED DEFAULT NULL,
  `tax` int(10) UNSIGNED DEFAULT NULL,
  `tax_type` enum('inclusive','exclusive') NOT NULL,
  `enable_stock` tinyint(1) NOT NULL DEFAULT 0,
  `alert_quantity` decimal(22,4) DEFAULT NULL,
  `sku` varchar(191) NOT NULL,
  `barcode_type` enum('C39','C128','EAN13','EAN8','UPCA','UPCE') DEFAULT 'C128',
  `expiry_period` decimal(4,2) DEFAULT NULL,
  `expiry_period_type` enum('days','months') DEFAULT NULL,
  `enable_sr_no` tinyint(1) NOT NULL DEFAULT 0,
  `weight` varchar(191) DEFAULT NULL,
  `product_custom_field1` varchar(191) DEFAULT NULL,
  `product_custom_field2` varchar(191) DEFAULT NULL,
  `product_custom_field3` varchar(191) DEFAULT NULL,
  `product_custom_field4` varchar(191) DEFAULT NULL,
  `product_custom_field5` varchar(191) DEFAULT NULL,
  `product_custom_field6` varchar(191) DEFAULT NULL,
  `product_custom_field7` varchar(191) DEFAULT NULL,
  `product_custom_field8` varchar(191) DEFAULT NULL,
  `product_custom_field9` varchar(191) DEFAULT NULL,
  `product_custom_field10` varchar(191) DEFAULT NULL,
  `product_custom_field11` varchar(191) DEFAULT NULL,
  `product_custom_field12` varchar(191) DEFAULT NULL,
  `product_custom_field13` varchar(191) DEFAULT NULL,
  `product_custom_field14` varchar(191) DEFAULT NULL,
  `product_custom_field15` varchar(191) DEFAULT NULL,
  `product_custom_field16` varchar(191) DEFAULT NULL,
  `product_custom_field17` varchar(191) DEFAULT NULL,
  `product_custom_field18` varchar(191) DEFAULT NULL,
  `product_custom_field19` varchar(191) DEFAULT NULL,
  `product_custom_field20` varchar(191) DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `product_description` text DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `preparation_time_in_minutes` int(11) DEFAULT NULL,
  `warranty_id` int(11) DEFAULT NULL,
  `is_inactive` tinyint(1) NOT NULL DEFAULT 0,
  `not_for_selling` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `business_id`, `type`, `unit_id`, `secondary_unit_id`, `sub_unit_ids`, `brand_id`, `category_id`, `sub_category_id`, `tax`, `tax_type`, `enable_stock`, `alert_quantity`, `sku`, `barcode_type`, `expiry_period`, `expiry_period_type`, `enable_sr_no`, `weight`, `product_custom_field1`, `product_custom_field2`, `product_custom_field3`, `product_custom_field4`, `product_custom_field5`, `product_custom_field6`, `product_custom_field7`, `product_custom_field8`, `product_custom_field9`, `product_custom_field10`, `product_custom_field11`, `product_custom_field12`, `product_custom_field13`, `product_custom_field14`, `product_custom_field15`, `product_custom_field16`, `product_custom_field17`, `product_custom_field18`, `product_custom_field19`, `product_custom_field20`, `image`, `product_description`, `created_by`, `preparation_time_in_minutes`, `warranty_id`, `is_inactive`, `not_for_selling`, `created_at`, `updated_at`) VALUES
(1, 'New North Face', 1, 'single', 1, NULL, NULL, 1, 1, NULL, NULL, 'exclusive', 1, NULL, '0001', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-20 11:55:42', '2026-02-20 11:55:42'),
(2, 'super glue 50g', 1, 'single', 2, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 3.0000, '0002', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-20 12:22:54', '2026-02-20 12:22:54'),
(3, 'Eraser', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4792210100781', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-20 13:28:14', '2026-02-20 13:28:14'),
(4, 'eraser 2', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '12345678', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-20 13:59:23', '2026-02-20 13:59:23'),
(5, 'abacus', 1, 'single', 1, NULL, NULL, 1, NULL, NULL, NULL, 'exclusive', 1, 1.0000, '4796023969122', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-20 15:38:03', '2026-02-20 15:38:03'),
(6, 'sticky notes', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 5.0000, '6942310500112', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-20 15:42:31', '2026-02-20 15:42:31'),
(7, 'highlight bag', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 3.0000, '0007', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-20 15:53:26', '2026-02-20 15:53:26'),
(8, 'stunt truck', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0008', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-20 16:09:58', '2026-02-20 16:09:58'),
(9, 'sand toys[full kit]', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0009', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-20 16:16:34', '2026-02-20 16:16:34'),
(10, 'pencil case', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0010', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-20 16:22:47', '2026-02-20 16:22:47'),
(11, 'baby sling', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0011', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-20 16:31:41', '2026-02-20 16:31:41'),
(12, 'cup[ plastic]', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0012', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-20 16:39:48', '2026-02-20 16:39:48'),
(13, 'cup plastic[purple]', 1, 'single', 1, NULL, NULL, 2, NULL, NULL, NULL, 'exclusive', 1, NULL, '0013', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-20 16:47:04', '2026-02-20 16:47:04'),
(15, 'cup plastic [w]', 1, 'single', 1, NULL, NULL, 2, NULL, NULL, NULL, 'exclusive', 1, NULL, '0015', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-20 17:03:04', '2026-02-20 17:03:04'),
(16, 'pencil cutter', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '6971679249202', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-20 17:13:26', '2026-02-20 17:13:26'),
(17, 'litter', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '6739225235822', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-20 17:19:49', '2026-02-20 17:19:49'),
(18, 'bubble bar [b]', 1, 'single', 1, NULL, NULL, 2, NULL, NULL, NULL, 'exclusive', 1, NULL, '0018', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-20 17:27:50', '2026-02-20 17:27:50'),
(19, 'bubble bar [s]', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0019', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-20 17:36:40', '2026-02-20 17:36:40'),
(20, 'test product', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0020', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-02-21 12:05:21', '2026-02-21 12:05:21'),
(21, 'pen holder', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0021', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-01 17:37:28', '2026-03-01 17:37:28'),
(22, 'high light [ H- point]', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '6978113200027', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:17:13', '2026-03-03 19:17:13'),
(23, 'high light', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4796002051954', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:21:56', '2026-03-03 19:21:56'),
(24, 'high light single', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '6923369601036', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:23:25', '2026-03-03 19:23:25'),
(25, 'high light pen', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4796009862249', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:24:47', '2026-03-03 19:24:47'),
(26, 'tipex pen', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4792210130979', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:26:34', '2026-03-03 19:26:34'),
(27, 'tipex [L]', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '6938534001153', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:28:34', '2026-03-03 19:28:34'),
(28, 'platignum 12 pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4796009862829', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:30:10', '2026-03-03 19:30:10'),
(29, 'platignum 6pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4796009862812', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:31:05', '2026-03-03 19:31:05'),
(30, 'platignum 1pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4796027900305', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:32:46', '2026-03-03 19:32:46'),
(31, 'clay atlas 100g', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4792210106714', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:35:12', '2026-03-03 19:35:12'),
(32, 'clay mango 100g', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4796009863772', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:36:43', '2026-03-03 19:36:43'),
(33, 'glue atlas 200g', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4792210103454', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:37:42', '2026-03-03 19:37:42'),
(34, 'glue mango 200g', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4796009863123', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:38:28', '2026-03-03 19:38:28'),
(35, 'glue mango 100g', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4796009863116', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:39:14', '2026-03-03 19:39:14'),
(36, 'glue mango 25g', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '8026624581031', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:40:20', '2026-03-03 19:40:20'),
(37, 'glue atlas 20ml', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4792210112715', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:41:22', '2026-03-03 19:41:22'),
(38, 'mariss binder glue 50ml', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0038', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:43:05', '2026-03-03 19:43:05'),
(39, 'super clay', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '6939788779775', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:45:21', '2026-03-03 19:45:21'),
(40, 'natural clay mango', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4796009868661', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:46:12', '2026-03-03 19:46:12'),
(41, 'aralya natural clay', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, 'CL70059', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:47:06', '2026-03-03 19:47:06'),
(42, 'acrylic paint', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '8901860510185', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:49:49', '2026-03-03 19:49:49'),
(43, 'banner paint', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4793000954003', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:50:42', '2026-03-03 19:50:42'),
(44, 'homerun pas 24pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4792210137589', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:51:53', '2026-03-03 19:51:53'),
(45, 'homerun pas 12pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4792210137572', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:52:56', '2026-03-03 19:52:56'),
(46, 'mango pas 24pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4796009860917', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:54:10', '2026-03-03 19:54:10'),
(47, 'atlas pas 24pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4792210103492', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:55:01', '2026-03-03 19:55:01'),
(48, 'atlas pas 12pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4792210103485', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:56:02', '2026-03-03 19:56:02'),
(49, 'pentium pas 12pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4796001620038', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:57:21', '2026-03-03 19:57:21'),
(50, 'mazari colour pencil 6pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4640020963365', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:58:23', '2026-03-03 19:58:23'),
(51, 'mapeed colour pencil 6pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '3154141832123', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 19:59:37', '2026-03-03 19:59:37'),
(52, 'vneeds colour pencil 6pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '6970928006870', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 20:00:29', '2026-03-03 20:00:29'),
(53, 'atlas colour pencil 6pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4792210102815', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 20:01:15', '2026-03-03 20:01:15'),
(54, 'schoolmate colour pencil 12pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '6935468184877', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 20:02:20', '2026-03-03 20:02:20'),
(55, 'weibo colour pencil 12 pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '6971082890183', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 20:03:24', '2026-03-03 20:03:24'),
(56, 'weibo colour pencil 24pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '6976693306535', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 20:04:25', '2026-03-03 20:04:25'),
(57, 'atlas colour pencil 12pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4792210102808', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 20:07:49', '2026-03-03 20:07:49'),
(58, 'acron water colours 12pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '8901860410072', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 20:09:03', '2026-03-03 20:09:03'),
(59, 'pencil, cutter set', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '6900010090043', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 20:10:18', '2026-03-03 20:10:18'),
(60, 'atlas ruler 0.5ft', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4792210109265', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 20:11:20', '2026-03-03 20:11:20'),
(61, 'white board marker pen mango', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4796009862935', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 20:14:13', '2026-03-03 20:14:13'),
(62, 'white board marker  speed', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '8906050366900', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 20:15:37', '2026-03-03 20:15:37'),
(63, 'permenent marker mango', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4796027900008', 'C128', NULL, NULL, 0, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 20:16:46', '2026-03-03 20:17:39'),
(64, 'note book  mango', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4796009867565', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 20:18:59', '2026-03-03 20:18:59'),
(65, 'note book mango A6', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4796009867084', 'C128', NULL, NULL, 0, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-03 20:20:18', '2026-03-03 20:21:36'),
(66, 'test product 2', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0066', 'C128', NULL, NULL, 0, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-05 15:14:25', '2026-03-05 15:40:04'),
(67, 'Broom type 1', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0067', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-14 16:36:57', '2026-03-14 16:36:57'),
(68, 'Plastic pot', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0068', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-21 16:44:34', '2026-03-21 16:44:34'),
(69, 'Plastic Ball Large', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0069', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-22 14:05:43', '2026-03-22 14:05:43'),
(70, 'remote controll', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0070', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-23 16:00:29', '2026-03-23 16:00:29'),
(71, '50 l black bucket', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 3.0000, '0071', 'C128', NULL, NULL, 0, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 12:44:12', '2026-03-27 14:31:16'),
(72, '50 l bucket nippon', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0072', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 12:49:51', '2026-03-27 12:49:51'),
(73, 'polymerteck fruit bucket', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0073', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 12:52:15', '2026-03-27 12:52:15'),
(83, '14 basin', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0083', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 14:40:19', '2026-03-27 14:40:19'),
(84, '11 basin small', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0084', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 14:43:58', '2026-03-27 14:43:58'),
(90, 'polimertec basin 13', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0090', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 15:06:44', '2026-03-27 15:06:44'),
(92, '500g pvc bottle', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0092', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 15:09:26', '2026-03-27 15:09:26'),
(93, '1kg pvc bottle', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0093', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 15:13:33', '2026-03-27 15:13:33'),
(94, 'JAK loku 8', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 10.0000, '0094', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 15:22:36', '2026-03-27 15:22:36'),
(95, '12 cm black vass', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0095', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 15:27:52', '2026-03-27 15:27:52'),
(96, 'coconut scrapers', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 4.0000, '0096', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 15:40:56', '2026-03-27 15:40:56'),
(97, '10 fruit balls', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 5.0000, '0097', 'C128', NULL, NULL, 0, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 15:44:18', '2026-03-27 15:45:29'),
(98, 'polimertec basin 14 q', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0098', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 15:49:03', '2026-03-27 15:49:03'),
(99, 'poly tec 15 new', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0099', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 15:55:19', '2026-03-27 15:55:19'),
(100, 'poly tec 16 basin', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0100', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 16:44:57', '2026-03-27 16:44:57'),
(101, 'alum M kiri gotu', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0101', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 16:48:22', '2026-03-27 16:48:22'),
(102, 'kiri gotu alum S', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0102', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 16:49:43', '2026-03-27 16:49:43'),
(103, 'kiri gotu alum L', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0103', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 16:50:43', '2026-03-27 16:50:43'),
(104, 'kiri gotu alum xxxl', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0104', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 16:52:16', '2026-03-27 16:52:16'),
(105, 'poly tec basin Q S', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0105', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 16:59:16', '2026-03-27 16:59:16'),
(106, 'poly tec p basin new', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0106', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 17:02:20', '2026-03-27 17:02:20'),
(107, 'watti 24-32', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 5.0000, '0107', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 17:06:27', '2026-03-27 17:06:27'),
(108, 'jumbo pack building box', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0108', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 17:08:00', '2026-03-27 17:08:00'),
(109, 'B box 20 pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0109', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 17:31:05', '2026-03-27 17:31:05'),
(110, 'B box 54 pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0110', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 17:32:40', '2026-03-27 17:32:40'),
(111, 'B box 72 pc', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0111', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 17:33:50', '2026-03-27 17:33:50'),
(112, 'soap box plastic', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0112', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 17:38:03', '2026-03-27 17:38:03'),
(113, 'scraper gaurd', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0113', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-27 17:40:24', '2026-03-27 17:40:24'),
(114, 'polytec', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0114', 'C128', NULL, NULL, 0, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 08:40:36', '2026-03-28 08:41:52'),
(115, 'poly tec basin S', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0115', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 08:43:16', '2026-03-28 08:43:16'),
(116, 'dum kabal thahadu', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 5.0000, '0116', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 08:45:16', '2026-03-28 08:45:16'),
(117, 'book rack L', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0117', 'C128', NULL, NULL, 0, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 08:48:33', '2026-03-28 10:10:24'),
(118, 'book rack S', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0118', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 08:50:03', '2026-03-28 08:50:03'),
(119, 'book rack XL', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0119', 'C128', NULL, NULL, 0, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 08:51:45', '2026-03-28 10:08:21'),
(120, 'national cutting board m', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0120', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 09:18:29', '2026-03-28 09:18:29'),
(121, 'spice rack', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '0121', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 09:20:38', '2026-03-28 09:20:38'),
(122, 'plastic jug', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 3.0000, '0122', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 09:23:11', '2026-03-28 09:23:11'),
(123, 'plastic jug L', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0123', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 09:25:02', '2026-03-28 09:25:02'),
(124, 'shoe rack L', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0124', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 09:29:12', '2026-03-28 09:29:12'),
(125, 'freezer box', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0125', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 09:34:02', '2026-03-28 09:34:02'),
(126, 'oru watti L', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 5.0000, '0126', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 09:36:47', '2026-03-28 09:36:47'),
(127, 'baby plate', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 5.0000, '0127', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 09:39:31', '2026-03-28 09:39:31'),
(128, 'bottle L', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 3.0000, '0128', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 09:48:22', '2026-03-28 09:48:22'),
(129, 'plastic ball M', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 10.0000, '0129', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 09:51:44', '2026-03-28 09:51:44'),
(130, 'brush houlder', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 5.0000, '0130', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 10:04:56', '2026-03-28 10:04:56'),
(131, 'freezer box L', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 5.0000, '0131', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 10:07:18', '2026-03-28 10:07:18'),
(132, 'spice bottle nippon', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0132', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 10:09:11', '2026-03-28 10:09:11'),
(133, 'cake plate', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0133', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 10:12:16', '2026-03-28 10:12:16'),
(134, 'freezer box xl', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0134', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 10:13:41', '2026-03-28 10:13:41'),
(135, 'sponge leyer', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 5.0000, '0135', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 10:17:51', '2026-03-28 10:17:51'),
(136, 'sponge', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 10.0000, '0136', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 10:22:14', '2026-03-28 10:22:14'),
(137, 'sponge 1', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, NULL, '4797001116606', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 10:26:15', '2026-03-28 10:26:15'),
(138, 'vegi rack', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0138', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 10:38:52', '2026-03-28 10:38:52'),
(139, 'cake plate M', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0139', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 10:43:01', '2026-03-28 10:43:01'),
(140, 'cake plate mm', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0140', 'C128', NULL, NULL, 0, NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 10:46:33', '2026-03-28 10:55:11'),
(141, 'cake plate xxxl', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 2.0000, '0201020305', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 10:51:27', '2026-03-28 10:51:27'),
(142, 'disc S', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 10.0000, '0142', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 10:57:46', '2026-03-28 10:57:46'),
(143, 'plate m', 1, 'single', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'exclusive', 1, 10.0000, '0143', 'C128', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, 0, '2026-03-28 11:00:17', '2026-03-28 11:00:17');

-- --------------------------------------------------------

--
-- Table structure for table `product_locations`
--

CREATE TABLE `product_locations` (
  `product_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_locations`
--

INSERT INTO `product_locations` (`product_id`, `location_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1),
(71, 1),
(72, 1),
(73, 1),
(74, 1),
(75, 1),
(76, 1),
(77, 1),
(78, 1),
(79, 1),
(80, 1),
(81, 1),
(82, 1),
(83, 1),
(84, 1),
(85, 1),
(86, 1),
(87, 1),
(88, 1),
(89, 1),
(90, 1),
(91, 1),
(92, 1),
(93, 1),
(94, 1),
(95, 1),
(96, 1),
(97, 1),
(98, 1),
(99, 1),
(100, 1),
(101, 1),
(102, 1),
(103, 1),
(104, 1),
(105, 1),
(106, 1),
(107, 1),
(108, 1),
(109, 1),
(110, 1),
(111, 1),
(112, 1),
(113, 1),
(114, 1),
(115, 1),
(116, 1),
(117, 1),
(118, 1),
(119, 1),
(120, 1),
(121, 1),
(122, 1),
(123, 1),
(124, 1),
(125, 1),
(126, 1),
(127, 1),
(128, 1),
(129, 1),
(130, 1),
(131, 1),
(132, 1),
(133, 1),
(134, 1),
(135, 1),
(136, 1),
(137, 1),
(138, 1),
(139, 1),
(140, 1),
(141, 1),
(142, 1),
(143, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product_racks`
--

CREATE TABLE `product_racks` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `rack` varchar(191) DEFAULT NULL,
  `row` varchar(191) DEFAULT NULL,
  `position` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_variations`
--

CREATE TABLE `product_variations` (
  `id` int(10) UNSIGNED NOT NULL,
  `variation_template_id` int(11) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `is_dummy` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_variations`
--

INSERT INTO `product_variations` (`id`, `variation_template_id`, `name`, `product_id`, `is_dummy`, `created_at`, `updated_at`) VALUES
(1, NULL, 'DUMMY', 1, 1, '2026-02-20 11:55:42', '2026-02-20 11:55:42'),
(2, NULL, 'DUMMY', 2, 1, '2026-02-20 12:22:54', '2026-02-20 12:22:54'),
(3, NULL, 'DUMMY', 3, 1, '2026-02-20 13:28:14', '2026-02-20 13:28:14'),
(4, NULL, 'DUMMY', 4, 1, '2026-02-20 13:59:23', '2026-02-20 13:59:23'),
(5, NULL, 'DUMMY', 5, 1, '2026-02-20 15:38:03', '2026-02-20 15:38:03'),
(6, NULL, 'DUMMY', 6, 1, '2026-02-20 15:42:31', '2026-02-20 15:42:31'),
(7, NULL, 'DUMMY', 7, 1, '2026-02-20 15:53:26', '2026-02-20 15:53:26'),
(8, NULL, 'DUMMY', 8, 1, '2026-02-20 16:09:58', '2026-02-20 16:09:58'),
(9, NULL, 'DUMMY', 9, 1, '2026-02-20 16:16:34', '2026-02-20 16:16:34'),
(10, NULL, 'DUMMY', 10, 1, '2026-02-20 16:22:47', '2026-02-20 16:22:47'),
(11, NULL, 'DUMMY', 11, 1, '2026-02-20 16:31:41', '2026-02-20 16:31:41'),
(12, NULL, 'DUMMY', 12, 1, '2026-02-20 16:39:48', '2026-02-20 16:39:48'),
(13, NULL, 'DUMMY', 13, 1, '2026-02-20 16:47:04', '2026-02-20 16:47:04'),
(15, NULL, 'DUMMY', 15, 1, '2026-02-20 17:03:04', '2026-02-20 17:03:04'),
(16, NULL, 'DUMMY', 16, 1, '2026-02-20 17:13:26', '2026-02-20 17:13:26'),
(17, NULL, 'DUMMY', 17, 1, '2026-02-20 17:19:49', '2026-02-20 17:19:49'),
(18, NULL, 'DUMMY', 18, 1, '2026-02-20 17:27:50', '2026-02-20 17:27:50'),
(19, NULL, 'DUMMY', 19, 1, '2026-02-20 17:36:40', '2026-02-20 17:36:40'),
(20, NULL, 'DUMMY', 20, 1, '2026-02-21 12:05:21', '2026-02-21 12:05:21'),
(21, NULL, 'DUMMY', 21, 1, '2026-03-01 17:37:28', '2026-03-01 17:37:28'),
(22, NULL, 'DUMMY', 22, 1, '2026-03-03 19:17:13', '2026-03-03 19:17:13'),
(23, NULL, 'DUMMY', 23, 1, '2026-03-03 19:21:56', '2026-03-03 19:21:56'),
(24, NULL, 'DUMMY', 24, 1, '2026-03-03 19:23:25', '2026-03-03 19:23:25'),
(25, NULL, 'DUMMY', 25, 1, '2026-03-03 19:24:47', '2026-03-03 19:24:47'),
(26, NULL, 'DUMMY', 26, 1, '2026-03-03 19:26:34', '2026-03-03 19:26:34'),
(27, NULL, 'DUMMY', 27, 1, '2026-03-03 19:28:34', '2026-03-03 19:28:34'),
(28, NULL, 'DUMMY', 28, 1, '2026-03-03 19:30:10', '2026-03-03 19:30:10'),
(29, NULL, 'DUMMY', 29, 1, '2026-03-03 19:31:05', '2026-03-03 19:31:05'),
(30, NULL, 'DUMMY', 30, 1, '2026-03-03 19:32:46', '2026-03-03 19:32:46'),
(31, NULL, 'DUMMY', 31, 1, '2026-03-03 19:35:12', '2026-03-03 19:35:12'),
(32, NULL, 'DUMMY', 32, 1, '2026-03-03 19:36:43', '2026-03-03 19:36:43'),
(33, NULL, 'DUMMY', 33, 1, '2026-03-03 19:37:42', '2026-03-03 19:37:42'),
(34, NULL, 'DUMMY', 34, 1, '2026-03-03 19:38:28', '2026-03-03 19:38:28'),
(35, NULL, 'DUMMY', 35, 1, '2026-03-03 19:39:14', '2026-03-03 19:39:14'),
(36, NULL, 'DUMMY', 36, 1, '2026-03-03 19:40:20', '2026-03-03 19:40:20'),
(37, NULL, 'DUMMY', 37, 1, '2026-03-03 19:41:22', '2026-03-03 19:41:22'),
(38, NULL, 'DUMMY', 38, 1, '2026-03-03 19:43:05', '2026-03-03 19:43:05'),
(39, NULL, 'DUMMY', 39, 1, '2026-03-03 19:45:21', '2026-03-03 19:45:21'),
(40, NULL, 'DUMMY', 40, 1, '2026-03-03 19:46:12', '2026-03-03 19:46:12'),
(41, NULL, 'DUMMY', 41, 1, '2026-03-03 19:47:06', '2026-03-03 19:47:06'),
(42, NULL, 'DUMMY', 42, 1, '2026-03-03 19:49:49', '2026-03-03 19:49:49'),
(43, NULL, 'DUMMY', 43, 1, '2026-03-03 19:50:42', '2026-03-03 19:50:42'),
(44, NULL, 'DUMMY', 44, 1, '2026-03-03 19:51:53', '2026-03-03 19:51:53'),
(45, NULL, 'DUMMY', 45, 1, '2026-03-03 19:52:56', '2026-03-03 19:52:56'),
(46, NULL, 'DUMMY', 46, 1, '2026-03-03 19:54:10', '2026-03-03 19:54:10'),
(47, NULL, 'DUMMY', 47, 1, '2026-03-03 19:55:01', '2026-03-03 19:55:01'),
(48, NULL, 'DUMMY', 48, 1, '2026-03-03 19:56:02', '2026-03-03 19:56:02'),
(49, NULL, 'DUMMY', 49, 1, '2026-03-03 19:57:21', '2026-03-03 19:57:21'),
(50, NULL, 'DUMMY', 50, 1, '2026-03-03 19:58:23', '2026-03-03 19:58:23'),
(51, NULL, 'DUMMY', 51, 1, '2026-03-03 19:59:37', '2026-03-03 19:59:37'),
(52, NULL, 'DUMMY', 52, 1, '2026-03-03 20:00:29', '2026-03-03 20:00:29'),
(53, NULL, 'DUMMY', 53, 1, '2026-03-03 20:01:15', '2026-03-03 20:01:15'),
(54, NULL, 'DUMMY', 54, 1, '2026-03-03 20:02:20', '2026-03-03 20:02:20'),
(55, NULL, 'DUMMY', 55, 1, '2026-03-03 20:03:24', '2026-03-03 20:03:24'),
(56, NULL, 'DUMMY', 56, 1, '2026-03-03 20:04:25', '2026-03-03 20:04:25'),
(57, NULL, 'DUMMY', 57, 1, '2026-03-03 20:07:49', '2026-03-03 20:07:49'),
(58, NULL, 'DUMMY', 58, 1, '2026-03-03 20:09:03', '2026-03-03 20:09:03'),
(59, NULL, 'DUMMY', 59, 1, '2026-03-03 20:10:18', '2026-03-03 20:10:18'),
(60, NULL, 'DUMMY', 60, 1, '2026-03-03 20:11:20', '2026-03-03 20:11:20'),
(61, NULL, 'DUMMY', 61, 1, '2026-03-03 20:14:13', '2026-03-03 20:14:13'),
(62, NULL, 'DUMMY', 62, 1, '2026-03-03 20:15:37', '2026-03-03 20:15:37'),
(63, NULL, 'DUMMY', 63, 1, '2026-03-03 20:16:46', '2026-03-03 20:16:46'),
(64, NULL, 'DUMMY', 64, 1, '2026-03-03 20:18:59', '2026-03-03 20:18:59'),
(65, NULL, 'DUMMY', 65, 1, '2026-03-03 20:20:18', '2026-03-03 20:20:18'),
(66, NULL, 'DUMMY', 66, 1, '2026-03-05 15:14:25', '2026-03-05 15:14:25'),
(67, NULL, 'DUMMY', 67, 1, '2026-03-14 16:36:57', '2026-03-14 16:36:57'),
(68, NULL, 'DUMMY', 68, 1, '2026-03-21 16:44:34', '2026-03-21 16:44:34'),
(69, NULL, 'DUMMY', 69, 1, '2026-03-22 14:05:43', '2026-03-22 14:05:43'),
(70, NULL, 'DUMMY', 70, 1, '2026-03-23 16:00:29', '2026-03-23 16:00:29'),
(71, NULL, 'DUMMY', 71, 1, '2026-03-27 12:44:12', '2026-03-27 12:44:12'),
(72, NULL, 'DUMMY', 72, 1, '2026-03-27 12:49:51', '2026-03-27 12:49:51'),
(73, NULL, 'DUMMY', 73, 1, '2026-03-27 12:52:15', '2026-03-27 12:52:15'),
(83, NULL, 'DUMMY', 83, 1, '2026-03-27 14:40:19', '2026-03-27 14:40:19'),
(84, NULL, 'DUMMY', 84, 1, '2026-03-27 14:43:58', '2026-03-27 14:43:58'),
(90, NULL, 'DUMMY', 90, 1, '2026-03-27 15:06:44', '2026-03-27 15:06:44'),
(92, NULL, 'DUMMY', 92, 1, '2026-03-27 15:09:26', '2026-03-27 15:09:26'),
(93, NULL, 'DUMMY', 93, 1, '2026-03-27 15:13:33', '2026-03-27 15:13:33'),
(94, NULL, 'DUMMY', 94, 1, '2026-03-27 15:22:36', '2026-03-27 15:22:36'),
(95, NULL, 'DUMMY', 95, 1, '2026-03-27 15:27:52', '2026-03-27 15:27:52'),
(96, NULL, 'DUMMY', 96, 1, '2026-03-27 15:40:56', '2026-03-27 15:40:56'),
(97, NULL, 'DUMMY', 97, 1, '2026-03-27 15:44:18', '2026-03-27 15:44:18'),
(98, NULL, 'DUMMY', 98, 1, '2026-03-27 15:49:03', '2026-03-27 15:49:03'),
(99, NULL, 'DUMMY', 99, 1, '2026-03-27 15:55:19', '2026-03-27 15:55:19'),
(100, NULL, 'DUMMY', 100, 1, '2026-03-27 16:44:57', '2026-03-27 16:44:57'),
(101, NULL, 'DUMMY', 101, 1, '2026-03-27 16:48:22', '2026-03-27 16:48:22'),
(102, NULL, 'DUMMY', 102, 1, '2026-03-27 16:49:43', '2026-03-27 16:49:43'),
(103, NULL, 'DUMMY', 103, 1, '2026-03-27 16:50:43', '2026-03-27 16:50:43'),
(104, NULL, 'DUMMY', 104, 1, '2026-03-27 16:52:16', '2026-03-27 16:52:16'),
(105, NULL, 'DUMMY', 105, 1, '2026-03-27 16:59:16', '2026-03-27 16:59:16'),
(106, NULL, 'DUMMY', 106, 1, '2026-03-27 17:02:20', '2026-03-27 17:02:20'),
(107, NULL, 'DUMMY', 107, 1, '2026-03-27 17:06:27', '2026-03-27 17:06:27'),
(108, NULL, 'DUMMY', 108, 1, '2026-03-27 17:08:00', '2026-03-27 17:08:00'),
(109, NULL, 'DUMMY', 109, 1, '2026-03-27 17:31:05', '2026-03-27 17:31:05'),
(110, NULL, 'DUMMY', 110, 1, '2026-03-27 17:32:40', '2026-03-27 17:32:40'),
(111, NULL, 'DUMMY', 111, 1, '2026-03-27 17:33:50', '2026-03-27 17:33:50'),
(112, NULL, 'DUMMY', 112, 1, '2026-03-27 17:38:03', '2026-03-27 17:38:03'),
(113, NULL, 'DUMMY', 113, 1, '2026-03-27 17:40:24', '2026-03-27 17:40:24'),
(114, NULL, 'DUMMY', 114, 1, '2026-03-28 08:40:36', '2026-03-28 08:40:36'),
(115, NULL, 'DUMMY', 115, 1, '2026-03-28 08:43:16', '2026-03-28 08:43:16'),
(116, NULL, 'DUMMY', 116, 1, '2026-03-28 08:45:16', '2026-03-28 08:45:16'),
(117, NULL, 'DUMMY', 117, 1, '2026-03-28 08:48:33', '2026-03-28 08:48:33'),
(118, NULL, 'DUMMY', 118, 1, '2026-03-28 08:50:03', '2026-03-28 08:50:03'),
(119, NULL, 'DUMMY', 119, 1, '2026-03-28 08:51:45', '2026-03-28 08:51:45'),
(120, NULL, 'DUMMY', 120, 1, '2026-03-28 09:18:29', '2026-03-28 09:18:29'),
(121, NULL, 'DUMMY', 121, 1, '2026-03-28 09:20:38', '2026-03-28 09:20:38'),
(122, NULL, 'DUMMY', 122, 1, '2026-03-28 09:23:11', '2026-03-28 09:23:11'),
(123, NULL, 'DUMMY', 123, 1, '2026-03-28 09:25:02', '2026-03-28 09:25:02'),
(124, NULL, 'DUMMY', 124, 1, '2026-03-28 09:29:12', '2026-03-28 09:29:12'),
(125, NULL, 'DUMMY', 125, 1, '2026-03-28 09:34:02', '2026-03-28 09:34:02'),
(126, NULL, 'DUMMY', 126, 1, '2026-03-28 09:36:47', '2026-03-28 09:36:47'),
(127, NULL, 'DUMMY', 127, 1, '2026-03-28 09:39:31', '2026-03-28 09:39:31'),
(128, NULL, 'DUMMY', 128, 1, '2026-03-28 09:48:22', '2026-03-28 09:48:22'),
(129, NULL, 'DUMMY', 129, 1, '2026-03-28 09:51:44', '2026-03-28 09:51:44'),
(130, NULL, 'DUMMY', 130, 1, '2026-03-28 10:04:56', '2026-03-28 10:04:56'),
(131, NULL, 'DUMMY', 131, 1, '2026-03-28 10:07:18', '2026-03-28 10:07:18'),
(132, NULL, 'DUMMY', 132, 1, '2026-03-28 10:09:11', '2026-03-28 10:09:11'),
(133, NULL, 'DUMMY', 133, 1, '2026-03-28 10:12:16', '2026-03-28 10:12:16'),
(134, NULL, 'DUMMY', 134, 1, '2026-03-28 10:13:41', '2026-03-28 10:13:41'),
(135, NULL, 'DUMMY', 135, 1, '2026-03-28 10:17:51', '2026-03-28 10:17:51'),
(136, NULL, 'DUMMY', 136, 1, '2026-03-28 10:22:14', '2026-03-28 10:22:14'),
(137, NULL, 'DUMMY', 137, 1, '2026-03-28 10:26:15', '2026-03-28 10:26:15'),
(138, NULL, 'DUMMY', 138, 1, '2026-03-28 10:38:52', '2026-03-28 10:38:52'),
(139, NULL, 'DUMMY', 139, 1, '2026-03-28 10:43:01', '2026-03-28 10:43:01'),
(140, NULL, 'DUMMY', 140, 1, '2026-03-28 10:46:33', '2026-03-28 10:46:33'),
(141, NULL, 'DUMMY', 141, 1, '2026-03-28 10:51:27', '2026-03-28 10:51:27'),
(142, NULL, 'DUMMY', 142, 1, '2026-03-28 10:57:46', '2026-03-28 10:57:46'),
(143, NULL, 'DUMMY', 143, 1, '2026-03-28 11:00:17', '2026-03-28 11:00:17');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_lines`
--

CREATE TABLE `purchase_lines` (
  `id` int(10) UNSIGNED NOT NULL,
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `variation_id` int(10) UNSIGNED NOT NULL,
  `quantity` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `secondary_unit_quantity` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `pp_without_discount` decimal(22,4) NOT NULL DEFAULT 0.0000 COMMENT 'Purchase price before inline discounts',
  `discount_percent` decimal(5,2) NOT NULL DEFAULT 0.00 COMMENT 'Inline discount percentage',
  `purchase_price` decimal(22,4) NOT NULL,
  `purchase_price_inc_tax` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `item_tax` decimal(22,4) NOT NULL COMMENT 'Tax for one quantity',
  `tax_id` int(10) UNSIGNED DEFAULT NULL,
  `purchase_requisition_line_id` int(11) DEFAULT NULL,
  `purchase_order_line_id` int(11) DEFAULT NULL,
  `quantity_sold` decimal(22,4) NOT NULL DEFAULT 0.0000 COMMENT 'Quanity sold from this purchase line',
  `quantity_adjusted` decimal(22,4) NOT NULL DEFAULT 0.0000 COMMENT 'Quanity adjusted in stock adjustment from this purchase line',
  `quantity_returned` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `po_quantity_purchased` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `mfg_quantity_used` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `mfg_date` date DEFAULT NULL,
  `exp_date` date DEFAULT NULL,
  `lot_number` varchar(191) DEFAULT NULL,
  `sub_unit_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_lines`
--

INSERT INTO `purchase_lines` (`id`, `transaction_id`, `product_id`, `variation_id`, `quantity`, `secondary_unit_quantity`, `pp_without_discount`, `discount_percent`, `purchase_price`, `purchase_price_inc_tax`, `item_tax`, `tax_id`, `purchase_requisition_line_id`, `purchase_order_line_id`, `quantity_sold`, `quantity_adjusted`, `quantity_returned`, `po_quantity_purchased`, `mfg_quantity_used`, `mfg_date`, `exp_date`, `lot_number`, `sub_unit_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 9.0000, 0.0000, 1450.0000, 0.00, 1450.0000, 1450.0000, 0.0000, NULL, NULL, NULL, 7.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-02-20 12:00:10', '2026-02-20 15:29:10'),
(2, 3, 2, 2, 11.0000, 0.0000, 440.0000, 0.00, 440.0000, 440.0000, 0.0000, NULL, NULL, NULL, 11.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-02-20 12:24:07', '2026-03-03 19:09:31'),
(3, 7, 3, 3, 50.0000, 0.0000, 15.0000, 0.00, 15.0000, 15.0000, 0.0000, NULL, NULL, NULL, 7.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-02-20 13:28:51', '2026-02-20 15:29:10'),
(4, 16, 5, 5, 3.0000, 0.0000, 445.0000, 0.00, 445.0000, 445.0000, 0.0000, NULL, NULL, NULL, 3.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-02-20 15:39:13', '2026-03-04 16:23:43'),
(5, 17, 6, 6, 21.0000, 0.0000, 125.0000, 0.00, 125.0000, 125.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-02-20 15:42:51', '2026-02-20 15:42:51'),
(6, 18, 7, 7, 23.0000, 0.0000, 750.0000, 0.00, 750.0000, 750.0000, 0.0000, NULL, NULL, NULL, 1.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-02-20 15:53:36', '2026-02-20 16:43:30'),
(7, 19, 8, 8, 10.0000, 0.0000, 325.0000, 0.00, 325.0000, 325.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-02-20 16:10:30', '2026-02-20 16:10:30'),
(8, 20, 9, 9, 4.0000, 0.0000, 805.0000, 0.00, 805.0000, 805.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-02-20 16:16:48', '2026-02-20 16:16:48'),
(9, 21, 10, 10, 11.0000, 0.0000, 590.0000, 0.00, 590.0000, 590.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-02-20 16:23:06', '2026-02-20 16:23:06'),
(10, 22, 11, 11, 2.0000, 0.0000, 2500.0000, 0.00, 2500.0000, 2500.0000, 0.0000, NULL, NULL, NULL, 2.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-02-20 16:32:44', '2026-03-10 11:48:04'),
(11, 23, 12, 12, 5.0000, 0.0000, 90.0000, 0.00, 90.0000, 90.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-02-20 16:40:04', '2026-02-20 16:40:04'),
(12, 25, 13, 13, 10.0000, 0.0000, 140.0000, 0.00, 140.0000, 140.0000, 0.0000, NULL, NULL, NULL, 1.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-02-20 16:47:09', '2026-02-23 13:10:56'),
(13, 26, 15, 15, 5.0000, 0.0000, 90.0000, 0.00, 90.0000, 90.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-02-20 17:03:14', '2026-02-20 17:03:14'),
(14, 27, 16, 16, 37.0000, 0.0000, 40.0000, 0.00, 40.0000, 40.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-02-20 17:14:14', '2026-02-20 17:14:14'),
(15, 28, 17, 17, 41.0000, 0.0000, 40.0000, 0.00, 40.0000, 40.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-02-20 17:20:22', '2026-02-20 17:20:22'),
(16, 29, 18, 18, 22.0000, 0.0000, 95.0000, 0.00, 95.0000, 95.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-02-20 17:28:26', '2026-02-21 12:04:53'),
(17, 30, 19, 19, 23.0000, 0.0000, 45.0000, 0.00, 45.0000, 45.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-02-20 17:37:39', '2026-02-20 17:37:39'),
(18, 39, 20, 20, 100.0000, 0.0000, 150.0000, 0.00, 150.0000, 150.0000, 0.0000, NULL, NULL, NULL, 6.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-02-21 12:07:01', '2026-03-14 16:26:43'),
(19, 48, 21, 21, 4.0000, 0.0000, 120.0000, 0.00, 120.0000, 120.0000, 0.0000, NULL, NULL, NULL, 2.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-01 17:37:43', '2026-03-01 18:06:33'),
(20, 53, 22, 22, 9.0000, 0.0000, 300.0000, 0.00, 300.0000, 300.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:17:28', '2026-03-03 19:19:38'),
(21, 54, 23, 23, 4.0000, 0.0000, 90.0000, 0.00, 90.0000, 90.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:22:07', '2026-03-03 19:22:07'),
(22, 55, 24, 24, 7.0000, 0.0000, 90.0000, 0.00, 90.0000, 90.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:23:34', '2026-03-03 19:23:34'),
(23, 56, 25, 25, 4.0000, 0.0000, 60.0000, 0.00, 60.0000, 60.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:24:53', '2026-03-03 19:24:53'),
(24, 57, 26, 26, 10.0000, 0.0000, 142.0000, 0.00, 142.0000, 142.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:26:54', '2026-03-03 19:26:54'),
(25, 58, 27, 27, 9.0000, 0.0000, 140.0000, 0.00, 140.0000, 140.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:28:41', '2026-03-03 19:28:41'),
(26, 59, 28, 28, 9.0000, 0.0000, 420.0000, 0.00, 420.0000, 420.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:30:18', '2026-03-03 19:30:18'),
(27, 60, 29, 29, 4.0000, 0.0000, 200.0000, 0.00, 200.0000, 200.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:31:13', '2026-03-03 19:31:13'),
(28, 61, 30, 30, 27.0000, 0.0000, 35.0000, 0.00, 35.0000, 35.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:32:56', '2026-03-03 19:32:56'),
(29, 62, 31, 31, 14.0000, 0.0000, 190.0000, 0.00, 190.0000, 190.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:35:20', '2026-03-03 19:35:20'),
(30, 63, 32, 32, 5.0000, 0.0000, 200.0000, 0.00, 200.0000, 200.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:36:52', '2026-03-03 19:36:52'),
(31, 64, 33, 33, 18.0000, 0.0000, 260.0000, 0.00, 260.0000, 260.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:37:51', '2026-03-03 19:37:51'),
(32, 65, 34, 34, 3.0000, 0.0000, 290.0000, 0.00, 290.0000, 290.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:38:33', '2026-03-03 19:38:33'),
(33, 66, 35, 35, 2.0000, 0.0000, 150.0000, 0.00, 150.0000, 150.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:39:19', '2026-03-03 19:39:19'),
(34, 67, 36, 36, 9.0000, 0.0000, 65.0000, 0.00, 65.0000, 65.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:40:25', '2026-03-03 19:40:25'),
(35, 68, 37, 37, 8.0000, 0.0000, 35.0000, 0.00, 35.0000, 35.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:41:32', '2026-03-03 19:41:32'),
(36, 69, 38, 38, 4.0000, 0.0000, 75.0000, 0.00, 75.0000, 75.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:43:11', '2026-03-03 19:43:11'),
(37, 70, 39, 39, 7.0000, 0.0000, 200.0000, 0.00, 200.0000, 200.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:45:26', '2026-03-03 19:45:26'),
(38, 71, 40, 40, 4.0000, 0.0000, 100.0000, 0.00, 100.0000, 100.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:46:16', '2026-03-03 19:46:16'),
(39, 72, 41, 41, 21.0000, 0.0000, 80.0000, 0.00, 80.0000, 80.0000, 0.0000, NULL, NULL, NULL, 1.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:47:11', '2026-03-10 11:48:04'),
(40, 73, 42, 42, 35.0000, 0.0000, 180.0000, 0.00, 180.0000, 180.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:49:57', '2026-03-03 19:49:57'),
(41, 74, 43, 43, 22.0000, 0.0000, 210.0000, 0.00, 210.0000, 210.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:50:47', '2026-03-03 19:50:47'),
(42, 75, 44, 44, 14.0000, 0.0000, 310.0000, 0.00, 310.0000, 310.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:51:59', '2026-03-03 19:51:59'),
(43, 76, 45, 45, 16.0000, 0.0000, 150.0000, 0.00, 150.0000, 150.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:53:04', '2026-03-03 19:53:04'),
(44, 77, 46, 46, 5.0000, 0.0000, 340.0000, 0.00, 340.0000, 340.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:54:15', '2026-03-03 19:54:15'),
(45, 78, 47, 47, 12.0000, 0.0000, 350.0000, 0.00, 350.0000, 350.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:55:07', '2026-03-03 19:55:07'),
(46, 79, 48, 48, 16.0000, 0.0000, 180.0000, 0.00, 180.0000, 180.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:56:21', '2026-03-03 19:56:21'),
(47, 80, 49, 49, 6.0000, 0.0000, 180.0000, 0.00, 180.0000, 180.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:57:26', '2026-03-03 19:57:26'),
(48, 81, 50, 50, 12.0000, 0.0000, 200.0000, 0.00, 200.0000, 200.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:58:29', '2026-03-03 19:58:29'),
(49, 82, 51, 51, 4.0000, 0.0000, 200.0000, 0.00, 200.0000, 200.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 19:59:41', '2026-03-03 19:59:41'),
(50, 83, 52, 52, 3.0000, 0.0000, 200.0000, 0.00, 200.0000, 200.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 20:00:36', '2026-03-03 20:00:36'),
(51, 84, 53, 53, 6.0000, 0.0000, 210.0000, 0.00, 210.0000, 210.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 20:01:20', '2026-03-03 20:01:20'),
(52, 85, 54, 54, 18.0000, 0.0000, 420.0000, 0.00, 420.0000, 420.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 20:02:26', '2026-03-03 20:02:26'),
(53, 86, 55, 55, 5.0000, 0.0000, 450.0000, 0.00, 450.0000, 450.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 20:03:29', '2026-03-03 20:03:29'),
(54, 87, 56, 56, 4.0000, 0.0000, 500.0000, 0.00, 500.0000, 500.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 20:04:29', '2026-03-03 20:04:29'),
(55, 88, 57, 57, 7.0000, 0.0000, 390.0000, 0.00, 390.0000, 390.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 20:08:01', '2026-03-03 20:08:01'),
(56, 89, 58, 58, 5.0000, 0.0000, 900.0000, 0.00, 900.0000, 900.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 20:09:08', '2026-03-03 20:09:08'),
(57, 90, 59, 59, 6.0000, 0.0000, 150.0000, 0.00, 150.0000, 150.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 20:10:22', '2026-03-03 20:10:22'),
(58, 91, 60, 60, 17.0000, 0.0000, 35.0000, 0.00, 35.0000, 35.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 20:11:25', '2026-03-03 20:11:25'),
(59, 92, 61, 61, 21.0000, 0.0000, 110.0000, 0.00, 110.0000, 110.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 20:14:18', '2026-03-03 20:14:18'),
(60, 93, 62, 62, 12.0000, 0.0000, 90.0000, 0.00, 90.0000, 90.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 20:15:41', '2026-03-03 20:15:41'),
(61, 94, 63, 63, 35.0000, 0.0000, 28.0000, 0.00, 28.0000, 28.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 20:17:03', '2026-03-03 20:17:42'),
(62, 95, 64, 64, 15.0000, 0.0000, 25.0000, 0.00, 25.0000, 25.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 20:19:04', '2026-03-03 20:19:04'),
(63, 96, 65, 65, 13.0000, 0.0000, 35.0000, 0.00, 35.0000, 35.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-03 20:20:38', '2026-03-03 20:20:38'),
(64, 101, 68, 68, 36.0000, 0.0000, 40.0000, 0.00, 40.0000, 40.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-21 16:45:07', '2026-03-21 16:45:07'),
(65, 102, 83, 83, 50.0000, 0.0000, 90.0000, 0.00, 90.0000, 90.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 14:40:19', '2026-03-27 14:40:19'),
(66, 103, 84, 84, 50.0000, 0.0000, 70.0000, 0.00, 70.0000, 70.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 14:43:58', '2026-03-27 14:43:58'),
(72, 109, 90, 90, 10.0000, 0.0000, 195.0000, 0.00, 195.0000, 195.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 15:06:44', '2026-03-27 15:06:44'),
(74, 111, 92, 92, 12.0000, 0.0000, 90.0000, 0.00, 90.0000, 90.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 15:09:26', '2026-03-27 15:09:26'),
(75, 112, 93, 93, 12.0000, 0.0000, 135.0000, 0.00, 135.0000, 135.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 15:13:33', '2026-03-27 15:13:33'),
(76, 113, 94, 94, 48.0000, 0.0000, 34.5000, 0.00, 34.5000, 34.5000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 15:22:36', '2026-03-27 15:22:36'),
(77, 114, 95, 95, 100.0000, 0.0000, 21.0000, 0.00, 21.0000, 21.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 15:27:52', '2026-03-27 15:27:52'),
(78, 115, 96, 96, 12.0000, 0.0000, 300.0000, 0.00, 300.0000, 300.0000, 0.0000, NULL, NULL, NULL, 1.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 15:40:56', '2026-03-27 17:27:34'),
(79, 116, 97, 97, 25.0000, 0.0000, 32.5000, 0.00, 32.5000, 32.5000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 15:44:18', '2026-03-27 15:44:18'),
(80, 117, 98, 98, 10.0000, 0.0000, 230.0000, 0.00, 230.0000, 230.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 15:49:03', '2026-03-27 15:49:03'),
(81, 118, 99, 99, 10.0000, 0.0000, 380.0000, 0.00, 380.0000, 380.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 15:55:19', '2026-03-27 15:55:19'),
(82, 119, 100, 100, 10.0000, 0.0000, 425.0000, 0.00, 425.0000, 425.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 16:44:57', '2026-03-27 16:44:57'),
(83, 120, 101, 101, 10.0000, 0.0000, 185.0000, 0.00, 185.0000, 185.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 16:48:22', '2026-03-27 16:48:22'),
(84, 121, 102, 102, 6.0000, 0.0000, 170.0000, 0.00, 170.0000, 170.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 16:49:43', '2026-03-27 16:49:43'),
(85, 122, 103, 103, 10.0000, 0.0000, 220.0000, 0.00, 220.0000, 220.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 16:50:43', '2026-03-27 16:50:43'),
(86, 123, 104, 104, 6.0000, 0.0000, 660.0000, 0.00, 660.0000, 660.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 16:52:16', '2026-03-27 16:52:16'),
(87, 124, 105, 105, 10.0000, 0.0000, 195.0000, 0.00, 195.0000, 195.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 16:59:16', '2026-03-27 16:59:16'),
(88, 125, 106, 106, 10.0000, 0.0000, 285.0000, 0.00, 285.0000, 285.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 17:02:20', '2026-03-27 17:02:20'),
(89, 126, 107, 107, 20.0000, 0.0000, 75.0000, 0.00, 75.0000, 75.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 17:06:27', '2026-03-27 17:06:27'),
(90, 127, 108, 108, 6.0000, 0.0000, 980.0000, 0.00, 980.0000, 980.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 17:08:00', '2026-03-27 17:08:00'),
(91, 129, 109, 109, 6.0000, 0.0000, 190.0000, 0.00, 190.0000, 190.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 17:31:05', '2026-03-27 17:31:05'),
(92, 130, 110, 110, 6.0000, 0.0000, 435.0000, 0.00, 435.0000, 435.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 17:32:40', '2026-03-27 17:32:40'),
(93, 131, 111, 111, 6.0000, 0.0000, 540.0000, 0.00, 540.0000, 540.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 17:33:50', '2026-03-27 17:33:50'),
(94, 132, 112, 112, 12.0000, 0.0000, 40.0000, 0.00, 40.0000, 40.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 17:38:03', '2026-03-27 17:38:03'),
(95, 133, 113, 113, 24.0000, 0.0000, 120.0000, 0.00, 120.0000, 120.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-27 17:40:24', '2026-03-27 17:40:24'),
(96, 134, 114, 114, 10.0000, 0.0000, 900.0000, 0.00, 900.0000, 900.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 08:40:36', '2026-03-28 08:40:36'),
(97, 135, 115, 115, 10.0000, 0.0000, 740.0000, 0.00, 740.0000, 740.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 08:43:16', '2026-03-28 08:43:16'),
(98, 136, 116, 116, 24.0000, 0.0000, 80.0000, 0.00, 80.0000, 80.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 08:45:16', '2026-03-28 08:45:16'),
(99, 137, 117, 117, 5.0000, 0.0000, 2420.0000, 0.00, 2420.0000, 2420.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 08:48:33', '2026-03-28 08:48:33'),
(100, 138, 118, 118, 5.0000, 0.0000, 1930.0000, 0.00, 1930.0000, 1930.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 08:50:03', '2026-03-28 08:50:03'),
(101, 139, 119, 119, 5.0000, 0.0000, 2690.0000, 0.00, 2690.0000, 2690.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 08:51:45', '2026-03-28 08:51:45'),
(102, 140, 120, 120, 10.0000, 0.0000, 300.0000, 0.00, 300.0000, 300.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 09:18:29', '2026-03-28 09:18:29'),
(103, 141, 121, 121, 2.0000, 0.0000, 1100.0000, 0.00, 1100.0000, 1100.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 09:20:38', '2026-03-28 09:20:38'),
(104, 142, 122, 122, 12.0000, 0.0000, 165.0000, 0.00, 165.0000, 165.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 09:23:11', '2026-03-28 09:23:11'),
(105, 143, 123, 123, 4.0000, 0.0000, 180.0000, 0.00, 180.0000, 180.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 09:25:02', '2026-03-28 09:25:02'),
(106, 144, 124, 124, 8.0000, 0.0000, 710.0000, 0.00, 710.0000, 710.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 09:29:12', '2026-03-28 09:29:12'),
(107, 145, 125, 125, 12.0000, 0.0000, 115.0000, 0.00, 115.0000, 115.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 09:34:02', '2026-03-28 09:34:02'),
(108, 146, 126, 126, 60.0000, 0.0000, 65.0000, 0.00, 65.0000, 65.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 09:36:47', '2026-03-28 09:36:47'),
(109, 147, 127, 127, 50.0000, 0.0000, 20.0000, 0.00, 20.0000, 20.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 09:39:31', '2026-03-28 09:39:31'),
(110, 148, 128, 128, 12.0000, 0.0000, 185.0000, 0.00, 185.0000, 185.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 09:48:22', '2026-03-28 09:48:22'),
(111, 149, 129, 129, 24.0000, 0.0000, 50.0000, 0.00, 50.0000, 50.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 09:51:44', '2026-03-28 09:51:44'),
(112, 150, 130, 130, 24.0000, 0.0000, 105.0000, 0.00, 105.0000, 105.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 10:04:56', '2026-03-28 10:04:56'),
(113, 151, 131, 131, 12.0000, 0.0000, 270.0000, 0.00, 270.0000, 270.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 10:07:18', '2026-03-28 10:07:18'),
(114, 152, 132, 132, 6.0000, 0.0000, 970.0000, 0.00, 970.0000, 970.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 10:09:11', '2026-03-28 10:09:11'),
(115, 153, 133, 133, 15.0000, 0.0000, 430.0000, 0.00, 430.0000, 430.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 10:12:16', '2026-03-28 10:12:16'),
(116, 154, 134, 134, 12.0000, 0.0000, 275.0000, 0.00, 275.0000, 275.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 10:13:41', '2026-03-28 10:13:41'),
(117, 155, 135, 135, 40.0000, 0.0000, 75.0000, 0.00, 75.0000, 75.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 10:17:51', '2026-03-28 10:17:51'),
(118, 156, 136, 136, 36.0000, 0.0000, 140.0000, 0.00, 140.0000, 140.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 10:22:14', '2026-03-28 10:22:14'),
(119, 157, 137, 137, 6.0000, 0.0000, 80.0000, 0.00, 80.0000, 80.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 10:26:15', '2026-03-28 10:26:15'),
(120, 158, 138, 138, 10.0000, 0.0000, 660.0000, 0.00, 660.0000, 660.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 10:38:52', '2026-03-28 10:38:52'),
(121, 159, 139, 139, 10.0000, 0.0000, 600.0000, 0.00, 600.0000, 600.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 10:43:01', '2026-03-28 10:43:01'),
(122, 160, 140, 140, 10.0000, 0.0000, 540.0000, 0.00, 540.0000, 540.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 10:46:33', '2026-03-28 10:46:33'),
(123, 161, 141, 141, 10.0000, 0.0000, 740.0000, 0.00, 740.0000, 740.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 10:51:27', '2026-03-28 10:51:27'),
(124, 162, 142, 142, 100.0000, 0.0000, 21.0000, 0.00, 21.0000, 21.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 10:57:46', '2026-03-28 10:57:46'),
(125, 163, 143, 143, 50.0000, 0.0000, 40.0000, 0.00, 40.0000, 40.0000, 0.0000, NULL, NULL, NULL, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, NULL, '2026-03-28 11:00:17', '2026-03-28 11:00:17');

-- --------------------------------------------------------

--
-- Table structure for table `reference_counts`
--

CREATE TABLE `reference_counts` (
  `id` int(10) UNSIGNED NOT NULL,
  `ref_type` varchar(191) NOT NULL,
  `ref_count` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reference_counts`
--

INSERT INTO `reference_counts` (`id`, `ref_type`, `ref_count`, `business_id`, `created_at`, `updated_at`) VALUES
(1, 'contacts', 1, 1, '2026-02-19 17:29:18', '2026-02-19 17:29:18'),
(2, 'business_location', 1, 1, '2026-02-19 17:29:18', '2026-02-19 17:29:18'),
(3, 'sell_payment', 54, 1, '2026-02-20 12:01:12', '2026-03-27 17:27:34'),
(4, 'draft', 1, 1, '2026-02-20 15:30:52', '2026-02-20 15:30:52');

-- --------------------------------------------------------

--
-- Table structure for table `res_product_modifier_sets`
--

CREATE TABLE `res_product_modifier_sets` (
  `modifier_set_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL COMMENT 'Table use to store the modifier sets applicable for a product'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `res_tables`
--

CREATE TABLE `res_tables` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `guard_name` varchar(191) NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_service_staff` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `business_id`, `is_default`, `is_service_staff`, `created_at`, `updated_at`) VALUES
(1, 'Admin#1', 'web', 1, 1, 0, '2026-02-19 17:29:18', '2026-02-19 17:29:18'),
(2, 'Cashier#1', 'web', 1, 0, 0, '2026-02-19 17:29:18', '2026-02-19 17:29:18');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(25, 2),
(26, 2),
(48, 2),
(49, 2),
(50, 2),
(51, 2),
(80, 2);

-- --------------------------------------------------------

--
-- Table structure for table `selling_price_groups`
--

CREATE TABLE `selling_price_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sell_line_warranties`
--

CREATE TABLE `sell_line_warranties` (
  `sell_line_id` int(11) NOT NULL,
  `warranty_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(191) NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` text NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_adjustments_temp`
--

CREATE TABLE `stock_adjustments_temp` (
  `id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_adjustment_lines`
--

CREATE TABLE `stock_adjustment_lines` (
  `id` int(10) UNSIGNED NOT NULL,
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `variation_id` int(10) UNSIGNED NOT NULL,
  `quantity` decimal(22,4) NOT NULL,
  `secondary_unit_quantity` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `unit_price` decimal(22,4) DEFAULT NULL COMMENT 'Last purchase unit price',
  `removed_purchase_line` int(11) DEFAULT NULL,
  `lot_no_line_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `system`
--

CREATE TABLE `system` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(191) NOT NULL,
  `value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system`
--

INSERT INTO `system` (`id`, `key`, `value`) VALUES
(1, 'db_version', '6.9'),
(2, 'default_business_active_status', '1');

-- --------------------------------------------------------

--
-- Table structure for table `tax_rates`
--

CREATE TABLE `tax_rates` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `amount` double(22,4) NOT NULL,
  `is_tax_group` tinyint(1) NOT NULL DEFAULT 0,
  `for_tax_group` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED DEFAULT NULL,
  `is_kitchen_order` tinyint(1) NOT NULL DEFAULT 0,
  `res_table_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'fields to restaurant module',
  `res_waiter_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'fields to restaurant module',
  `res_order_status` enum('received','cooked','served') DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `sub_type` varchar(20) DEFAULT NULL,
  `status` varchar(191) NOT NULL,
  `sub_status` varchar(191) DEFAULT NULL,
  `is_quotation` tinyint(1) NOT NULL DEFAULT 0,
  `payment_status` enum('paid','due','partial') DEFAULT NULL,
  `adjustment_type` enum('normal','abnormal') DEFAULT NULL,
  `contact_id` int(11) UNSIGNED DEFAULT NULL,
  `customer_group_id` int(11) DEFAULT NULL COMMENT 'used to add customer group while selling',
  `invoice_no` varchar(191) DEFAULT NULL,
  `ref_no` varchar(191) DEFAULT NULL,
  `source` varchar(191) DEFAULT NULL,
  `subscription_no` varchar(191) DEFAULT NULL,
  `subscription_repeat_on` varchar(191) DEFAULT NULL,
  `transaction_date` datetime NOT NULL,
  `total_before_tax` decimal(22,4) NOT NULL DEFAULT 0.0000 COMMENT 'Total before the purchase/invoice tax, this includeds the indivisual product tax',
  `tax_id` int(10) UNSIGNED DEFAULT NULL,
  `tax_amount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `discount_type` enum('fixed','percentage') DEFAULT NULL,
  `discount_amount` decimal(22,4) DEFAULT 0.0000,
  `rp_redeemed` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `rp_redeemed_amount` decimal(22,4) NOT NULL DEFAULT 0.0000 COMMENT 'rp is the short form of reward points',
  `shipping_details` varchar(191) DEFAULT NULL,
  `shipping_address` text DEFAULT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `shipping_status` varchar(191) DEFAULT NULL,
  `delivered_to` varchar(191) DEFAULT NULL,
  `delivery_person` bigint(20) DEFAULT NULL,
  `shipping_charges` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `shipping_custom_field_1` varchar(191) DEFAULT NULL,
  `shipping_custom_field_2` varchar(191) DEFAULT NULL,
  `shipping_custom_field_3` varchar(191) DEFAULT NULL,
  `shipping_custom_field_4` varchar(191) DEFAULT NULL,
  `shipping_custom_field_5` varchar(191) DEFAULT NULL,
  `additional_notes` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `is_export` tinyint(1) NOT NULL DEFAULT 0,
  `export_custom_fields_info` longtext DEFAULT NULL,
  `round_off_amount` decimal(22,4) NOT NULL DEFAULT 0.0000 COMMENT 'Difference of rounded total and actual total',
  `additional_expense_key_1` varchar(191) DEFAULT NULL,
  `additional_expense_value_1` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `additional_expense_key_2` varchar(191) DEFAULT NULL,
  `additional_expense_value_2` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `additional_expense_key_3` varchar(191) DEFAULT NULL,
  `additional_expense_value_3` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `additional_expense_key_4` varchar(191) DEFAULT NULL,
  `additional_expense_value_4` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `final_total` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `expense_category_id` int(10) UNSIGNED DEFAULT NULL,
  `expense_sub_category_id` int(11) DEFAULT NULL,
  `expense_for` int(10) UNSIGNED DEFAULT NULL,
  `commission_agent` int(11) DEFAULT NULL,
  `document` varchar(191) DEFAULT NULL,
  `is_direct_sale` tinyint(1) NOT NULL DEFAULT 0,
  `is_suspend` tinyint(1) NOT NULL DEFAULT 0,
  `exchange_rate` decimal(20,3) NOT NULL DEFAULT 1.000,
  `total_amount_recovered` decimal(22,4) DEFAULT NULL COMMENT 'Used for stock adjustment.',
  `transfer_parent_id` int(11) DEFAULT NULL,
  `return_parent_id` int(11) DEFAULT NULL,
  `opening_stock_product_id` int(11) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `purchase_requisition_ids` text DEFAULT NULL,
  `prefer_payment_method` varchar(191) DEFAULT NULL,
  `prefer_payment_account` int(11) DEFAULT NULL,
  `sales_order_ids` text DEFAULT NULL,
  `purchase_order_ids` text DEFAULT NULL,
  `custom_field_1` varchar(191) DEFAULT NULL,
  `custom_field_2` varchar(191) DEFAULT NULL,
  `custom_field_3` varchar(191) DEFAULT NULL,
  `custom_field_4` varchar(191) DEFAULT NULL,
  `import_batch` int(11) DEFAULT NULL,
  `import_time` datetime DEFAULT NULL,
  `types_of_service_id` int(11) DEFAULT NULL,
  `packing_charge` decimal(22,4) DEFAULT NULL,
  `packing_charge_type` enum('fixed','percent') DEFAULT NULL,
  `service_custom_field_1` text DEFAULT NULL,
  `service_custom_field_2` text DEFAULT NULL,
  `service_custom_field_3` text DEFAULT NULL,
  `service_custom_field_4` text DEFAULT NULL,
  `service_custom_field_5` text DEFAULT NULL,
  `service_custom_field_6` text DEFAULT NULL,
  `is_created_from_api` tinyint(1) NOT NULL DEFAULT 0,
  `rp_earned` int(11) NOT NULL DEFAULT 0 COMMENT 'rp is the short form of reward points',
  `order_addresses` text DEFAULT NULL,
  `is_recurring` tinyint(1) NOT NULL DEFAULT 0,
  `recur_interval` double(22,4) DEFAULT NULL,
  `recur_interval_type` enum('days','months','years') DEFAULT NULL,
  `recur_repetitions` int(11) DEFAULT NULL,
  `recur_stopped_on` datetime DEFAULT NULL,
  `recur_parent_id` int(11) DEFAULT NULL,
  `invoice_token` varchar(191) DEFAULT NULL,
  `pay_term_number` int(11) DEFAULT NULL,
  `pay_term_type` enum('days','months') DEFAULT NULL,
  `selling_price_group_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `business_id`, `location_id`, `is_kitchen_order`, `res_table_id`, `res_waiter_id`, `res_order_status`, `type`, `sub_type`, `status`, `sub_status`, `is_quotation`, `payment_status`, `adjustment_type`, `contact_id`, `customer_group_id`, `invoice_no`, `ref_no`, `source`, `subscription_no`, `subscription_repeat_on`, `transaction_date`, `total_before_tax`, `tax_id`, `tax_amount`, `discount_type`, `discount_amount`, `rp_redeemed`, `rp_redeemed_amount`, `shipping_details`, `shipping_address`, `delivery_date`, `shipping_status`, `delivered_to`, `delivery_person`, `shipping_charges`, `shipping_custom_field_1`, `shipping_custom_field_2`, `shipping_custom_field_3`, `shipping_custom_field_4`, `shipping_custom_field_5`, `additional_notes`, `staff_note`, `is_export`, `export_custom_fields_info`, `round_off_amount`, `additional_expense_key_1`, `additional_expense_value_1`, `additional_expense_key_2`, `additional_expense_value_2`, `additional_expense_key_3`, `additional_expense_value_3`, `additional_expense_key_4`, `additional_expense_value_4`, `final_total`, `expense_category_id`, `expense_sub_category_id`, `expense_for`, `commission_agent`, `document`, `is_direct_sale`, `is_suspend`, `exchange_rate`, `total_amount_recovered`, `transfer_parent_id`, `return_parent_id`, `opening_stock_product_id`, `created_by`, `purchase_requisition_ids`, `prefer_payment_method`, `prefer_payment_account`, `sales_order_ids`, `purchase_order_ids`, `custom_field_1`, `custom_field_2`, `custom_field_3`, `custom_field_4`, `import_batch`, `import_time`, `types_of_service_id`, `packing_charge`, `packing_charge_type`, `service_custom_field_1`, `service_custom_field_2`, `service_custom_field_3`, `service_custom_field_4`, `service_custom_field_5`, `service_custom_field_6`, `is_created_from_api`, `rp_earned`, `order_addresses`, `is_recurring`, `recur_interval`, `recur_interval_type`, `recur_repetitions`, `recur_stopped_on`, `recur_parent_id`, `invoice_token`, `pay_term_number`, `pay_term_type`, `selling_price_group_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 12:00:10', 1450.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 13050.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 12:00:10', '2026-02-20 12:00:10'),
(2, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0001', '', NULL, NULL, NULL, '2026-02-20 12:01:12', 1850.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1850.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 12:01:12', '2026-02-20 12:01:12'),
(3, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 12:24:00', 4840.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 4840.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 12:24:07', '2026-03-01 17:58:50'),
(4, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0002', '', NULL, NULL, NULL, '2026-02-20 12:25:48', 550.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 550.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 12:25:48', '2026-02-20 12:25:48'),
(5, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0002', '', NULL, NULL, NULL, '2026-02-20 12:25:48', 550.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 550.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 12:25:48', '2026-02-20 12:25:48'),
(6, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0003', '', NULL, NULL, NULL, '2026-02-20 12:27:54', 2400.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2400.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 12:27:54', '2026-02-20 12:27:54'),
(7, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 13:28:51', 15.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 750.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 13:28:51', '2026-02-20 13:28:51'),
(8, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0004', '', NULL, NULL, NULL, '2026-02-20 13:37:39', 30.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 30.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 13:37:39', '2026-02-20 13:37:39'),
(9, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0005', '', NULL, NULL, NULL, '2026-02-20 14:16:28', 30.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 30.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 14:16:28', '2026-02-20 14:16:28'),
(10, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0006', '', NULL, NULL, NULL, '2026-02-20 15:17:03', 1880.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1880.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 15:17:03', '2026-02-20 15:17:03'),
(11, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0007', '', NULL, NULL, NULL, '2026-02-20 15:19:32', 1880.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1880.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 15:19:32', '2026-02-20 15:19:32'),
(12, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0008', '', NULL, NULL, NULL, '2026-02-20 15:20:34', 1880.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1880.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 15:20:34', '2026-02-20 15:20:34'),
(13, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0009', '', NULL, NULL, NULL, '2026-02-20 15:27:47', 1880.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1880.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 15:27:47', '2026-02-20 15:27:47'),
(14, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0010', '', NULL, NULL, NULL, '2026-02-20 15:29:10', 1880.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1880.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 15:29:10', '2026-02-20 15:29:10'),
(15, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'draft', NULL, 0, NULL, NULL, 1, NULL, '2026/0001', '', NULL, NULL, NULL, '2026-02-20 15:30:52', 1850.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1850.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 15:30:52', '2026-02-20 15:30:52'),
(16, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 15:39:13', 445.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1335.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 5, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 15:39:13', '2026-02-20 15:39:13'),
(17, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 15:42:51', 125.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2625.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 6, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 15:42:51', '2026-02-20 15:42:51'),
(18, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 15:53:36', 750.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 17250.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 7, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 15:53:36', '2026-02-20 15:53:36'),
(19, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 16:10:30', 325.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3250.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 8, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 16:10:30', '2026-02-20 16:10:30'),
(20, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 16:16:48', 805.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3220.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 9, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 16:16:48', '2026-02-20 16:16:48'),
(21, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 16:23:06', 590.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 6490.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 10, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 16:23:06', '2026-02-20 16:23:06'),
(22, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 16:32:44', 2500.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 5000.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 11, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 16:32:44', '2026-02-20 16:32:44'),
(23, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 16:40:04', 90.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 450.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 12, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 16:40:04', '2026-02-20 16:40:04'),
(24, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0011', '', NULL, NULL, NULL, '2026-02-20 16:43:30', 1300.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, '2000', NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1300.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-20 16:43:30', '2026-02-20 16:43:30'),
(25, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 16:47:09', 140.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1400.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 13, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 16:47:09', '2026-02-20 16:47:09'),
(26, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 17:03:14', 90.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 450.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 15, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 17:03:14', '2026-02-20 17:03:14'),
(27, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 17:14:14', 40.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1480.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 16, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 17:14:14', '2026-02-20 17:14:14'),
(28, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 17:20:22', 40.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1640.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 17, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 17:20:22', '2026-02-20 17:20:22'),
(29, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 17:28:26', 95.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2090.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 18, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 17:28:26', '2026-02-20 17:28:26'),
(30, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 17:37:39', 45.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1035.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 19, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 17:37:39', '2026-02-20 17:37:39'),
(39, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 12:07:01', 150.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 15000.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 20, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-21 12:07:01', '2026-02-21 12:07:01'),
(42, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0022', '', NULL, NULL, NULL, '2026-02-21 21:42:44', 4000.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 4000.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-21 21:42:44', '2026-02-21 21:42:44'),
(43, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0023', '', NULL, NULL, NULL, '2026-02-23 13:10:56', 3175.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3175.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-02-23 13:10:56', '2026-02-23 13:10:56'),
(47, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0027', '', NULL, NULL, NULL, '2026-03-01 17:33:05', 1100.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1100.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-03-01 17:33:05', '2026-03-01 17:33:05'),
(48, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 17:37:43', 120.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 480.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 21, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-01 17:37:43', '2026-03-01 17:37:43'),
(49, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0028', '', NULL, NULL, NULL, '2026-03-01 17:59:29', 1100.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1100.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-03-01 17:59:29', '2026-03-01 17:59:29'),
(50, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0029', '', NULL, NULL, NULL, '2026-03-01 17:59:57', 1650.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1650.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-03-01 17:59:57', '2026-03-01 17:59:57'),
(51, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0030', '', NULL, NULL, NULL, '2026-03-01 18:06:33', 360.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 360.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-03-01 18:06:33', '2026-03-01 18:06:33'),
(52, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0031', '', NULL, NULL, NULL, '2026-03-03 19:09:31', 550.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 550.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-03-03 19:09:31', '2026-03-03 19:09:31'),
(53, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:17:00', 2700.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2700.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 22, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:17:28', '2026-03-03 19:19:38'),
(54, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:22:00', 90.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 360.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 23, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:22:07', '2026-03-03 19:22:07'),
(55, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:23:34', 90.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 630.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 24, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:23:34', '2026-03-03 19:23:34'),
(56, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:24:53', 60.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 240.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 25, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:24:53', '2026-03-03 19:24:53'),
(57, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:26:54', 142.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1420.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 26, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:26:54', '2026-03-03 19:26:54'),
(58, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:28:41', 140.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1260.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 27, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:28:41', '2026-03-03 19:28:41'),
(59, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:30:18', 420.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3780.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 28, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:30:18', '2026-03-03 19:30:18'),
(60, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:31:13', 200.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 800.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 29, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:31:13', '2026-03-03 19:31:13'),
(61, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:32:56', 35.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 945.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 30, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:32:56', '2026-03-03 19:32:56'),
(62, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:35:19', 190.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2660.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 31, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:35:20', '2026-03-03 19:35:20'),
(63, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:36:52', 200.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1000.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 32, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:36:52', '2026-03-03 19:36:52'),
(64, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:37:51', 260.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 4680.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 33, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:37:51', '2026-03-03 19:37:51'),
(65, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:38:33', 290.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 870.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 34, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:38:33', '2026-03-03 19:38:33'),
(66, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:39:19', 150.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 300.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 35, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:39:19', '2026-03-03 19:39:19'),
(67, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:40:25', 65.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 585.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 36, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:40:25', '2026-03-03 19:40:25'),
(68, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:41:32', 35.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 280.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 37, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:41:32', '2026-03-03 19:41:32'),
(69, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:43:11', 75.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 300.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 38, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:43:11', '2026-03-03 19:43:11'),
(70, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:45:26', 200.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1400.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 39, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:45:26', '2026-03-03 19:45:26'),
(71, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:46:16', 100.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 400.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 40, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:46:16', '2026-03-03 19:46:16'),
(72, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:47:11', 80.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1680.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 41, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:47:11', '2026-03-03 19:47:11'),
(73, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:49:57', 180.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 6300.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 42, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:49:57', '2026-03-03 19:49:57'),
(74, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:50:47', 210.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 4620.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 43, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:50:47', '2026-03-03 19:50:47'),
(75, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:51:59', 310.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 4340.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 44, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:51:59', '2026-03-03 19:51:59'),
(76, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:53:04', 150.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2400.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 45, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:53:04', '2026-03-03 19:53:04'),
(77, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:54:15', 340.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1700.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 46, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:54:15', '2026-03-03 19:54:15'),
(78, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:55:07', 350.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 4200.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 47, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:55:07', '2026-03-03 19:55:07'),
(79, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:56:21', 180.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2880.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 48, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:56:21', '2026-03-03 19:56:21'),
(80, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:57:26', 180.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1080.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 49, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:57:26', '2026-03-03 19:57:26'),
(81, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:58:29', 200.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2400.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 50, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:58:29', '2026-03-03 19:58:29'),
(82, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 19:59:41', 200.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 800.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 51, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:59:41', '2026-03-03 19:59:41'),
(83, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 20:00:36', 200.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 600.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 52, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 20:00:36', '2026-03-03 20:00:36'),
(84, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 20:01:20', 210.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1260.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 53, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 20:01:20', '2026-03-03 20:01:20');
INSERT INTO `transactions` (`id`, `business_id`, `location_id`, `is_kitchen_order`, `res_table_id`, `res_waiter_id`, `res_order_status`, `type`, `sub_type`, `status`, `sub_status`, `is_quotation`, `payment_status`, `adjustment_type`, `contact_id`, `customer_group_id`, `invoice_no`, `ref_no`, `source`, `subscription_no`, `subscription_repeat_on`, `transaction_date`, `total_before_tax`, `tax_id`, `tax_amount`, `discount_type`, `discount_amount`, `rp_redeemed`, `rp_redeemed_amount`, `shipping_details`, `shipping_address`, `delivery_date`, `shipping_status`, `delivered_to`, `delivery_person`, `shipping_charges`, `shipping_custom_field_1`, `shipping_custom_field_2`, `shipping_custom_field_3`, `shipping_custom_field_4`, `shipping_custom_field_5`, `additional_notes`, `staff_note`, `is_export`, `export_custom_fields_info`, `round_off_amount`, `additional_expense_key_1`, `additional_expense_value_1`, `additional_expense_key_2`, `additional_expense_value_2`, `additional_expense_key_3`, `additional_expense_value_3`, `additional_expense_key_4`, `additional_expense_value_4`, `final_total`, `expense_category_id`, `expense_sub_category_id`, `expense_for`, `commission_agent`, `document`, `is_direct_sale`, `is_suspend`, `exchange_rate`, `total_amount_recovered`, `transfer_parent_id`, `return_parent_id`, `opening_stock_product_id`, `created_by`, `purchase_requisition_ids`, `prefer_payment_method`, `prefer_payment_account`, `sales_order_ids`, `purchase_order_ids`, `custom_field_1`, `custom_field_2`, `custom_field_3`, `custom_field_4`, `import_batch`, `import_time`, `types_of_service_id`, `packing_charge`, `packing_charge_type`, `service_custom_field_1`, `service_custom_field_2`, `service_custom_field_3`, `service_custom_field_4`, `service_custom_field_5`, `service_custom_field_6`, `is_created_from_api`, `rp_earned`, `order_addresses`, `is_recurring`, `recur_interval`, `recur_interval_type`, `recur_repetitions`, `recur_stopped_on`, `recur_parent_id`, `invoice_token`, `pay_term_number`, `pay_term_type`, `selling_price_group_id`, `created_at`, `updated_at`) VALUES
(85, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 20:02:26', 420.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 7560.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 54, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 20:02:26', '2026-03-03 20:02:26'),
(86, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 20:03:29', 450.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2250.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 55, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 20:03:29', '2026-03-03 20:03:29'),
(87, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 20:04:29', 500.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2000.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 56, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 20:04:29', '2026-03-03 20:04:29'),
(88, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 20:08:01', 390.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2730.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 57, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 20:08:01', '2026-03-03 20:08:01'),
(89, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 20:09:08', 900.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 4500.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 58, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 20:09:08', '2026-03-03 20:09:08'),
(90, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 20:10:22', 150.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 900.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 59, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 20:10:22', '2026-03-03 20:10:22'),
(91, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 20:11:25', 35.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 595.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 60, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 20:11:25', '2026-03-03 20:11:25'),
(92, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 20:14:18', 110.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2310.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 61, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 20:14:18', '2026-03-03 20:14:18'),
(93, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 20:15:41', 90.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1080.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 62, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 20:15:41', '2026-03-03 20:15:41'),
(94, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 20:17:00', 980.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 980.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 63, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 20:17:03', '2026-03-03 20:17:42'),
(95, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 20:19:04', 25.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 375.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 64, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 20:19:04', '2026-03-03 20:19:04'),
(96, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 20:20:38', 35.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 455.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 65, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 20:20:38', '2026-03-03 20:20:38'),
(97, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0032', '', NULL, NULL, NULL, '2026-03-04 16:14:41', 1160.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1160.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-03-04 16:14:41', '2026-03-04 16:14:41'),
(98, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0033', '', NULL, NULL, NULL, '2026-03-04 16:23:43', 580.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 580.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-03-04 16:23:43', '2026-03-04 16:23:43'),
(99, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0034', '', NULL, NULL, NULL, '2026-03-10 11:48:04', 3080.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3080.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-03-10 11:48:04', '2026-03-10 11:48:04'),
(100, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0035', '', NULL, NULL, NULL, '2026-03-14 16:26:43', 800.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 800.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-03-14 16:26:43', '2026-03-14 16:26:43'),
(101, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 16:45:07', 40.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1440.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 68, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-21 16:45:07', '2026-03-21 16:45:07'),
(102, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 14:40:19', 4500.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 4500.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 83, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 14:40:19', '2026-03-27 14:40:19'),
(103, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 14:43:58', 3500.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3500.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 84, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 14:43:58', '2026-03-27 14:43:58'),
(104, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 14:45:47', 5000.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 5000.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 85, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 14:45:47', '2026-03-27 14:45:47'),
(105, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 14:52:37', 2000.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2000.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 86, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 14:52:37', '2026-03-27 14:52:37'),
(106, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 14:53:36', 2000.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2000.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 87, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 14:53:36', '2026-03-27 14:53:36'),
(107, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 14:54:19', 2250.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2250.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 88, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 14:54:19', '2026-03-27 14:54:19'),
(108, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 14:59:12', 2750.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2750.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 89, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 14:59:12', '2026-03-27 14:59:12'),
(109, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 15:06:44', 1950.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1950.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 90, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 15:06:44', '2026-03-27 15:06:44'),
(110, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 15:08:01', 2500.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2500.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 91, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 15:08:01', '2026-03-27 15:08:01'),
(111, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 15:09:26', 1080.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1080.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 92, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 15:09:26', '2026-03-27 15:09:26'),
(112, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 15:13:33', 1620.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1620.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 93, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 15:13:33', '2026-03-27 15:13:33'),
(113, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 15:22:36', 1656.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1656.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 94, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 15:22:36', '2026-03-27 15:22:36'),
(114, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 15:27:52', 2100.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2100.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 95, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 15:27:52', '2026-03-27 15:27:52'),
(115, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 15:40:56', 3600.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3600.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 96, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 15:40:56', '2026-03-27 15:40:56'),
(116, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 15:44:18', 812.5000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 812.5000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 97, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 15:44:18', '2026-03-27 15:44:18'),
(117, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 15:49:03', 2300.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2300.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 98, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 15:49:03', '2026-03-27 15:49:03'),
(118, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 15:55:19', 3800.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3800.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 99, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 15:55:19', '2026-03-27 15:55:19'),
(119, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 16:44:57', 4250.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 4250.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 100, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 16:44:57', '2026-03-27 16:44:57'),
(120, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 16:48:22', 1850.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1850.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 101, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 16:48:22', '2026-03-27 16:48:22'),
(121, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 16:49:43', 1020.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1020.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 102, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 16:49:43', '2026-03-27 16:49:43'),
(122, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 16:50:43', 2200.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2200.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 103, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 16:50:43', '2026-03-27 16:50:43'),
(123, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 16:52:16', 3960.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3960.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 104, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 16:52:16', '2026-03-27 16:52:16'),
(124, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 16:59:16', 1950.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1950.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 105, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 16:59:16', '2026-03-27 16:59:16'),
(125, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 17:02:20', 2850.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2850.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 106, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 17:02:20', '2026-03-27 17:02:20'),
(126, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 17:06:27', 1500.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1500.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 107, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 17:06:27', '2026-03-27 17:06:27'),
(127, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 17:08:00', 5880.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 5880.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 108, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 17:08:00', '2026-03-27 17:08:00'),
(128, 1, 1, 0, NULL, NULL, NULL, 'sell', NULL, 'final', NULL, 0, 'paid', NULL, 1, NULL, '0036', '', NULL, NULL, NULL, '2026-03-27 17:27:34', 450.0000, NULL, 0.0000, 'percentage', 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 450.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, 1.0000, 'days', 0, NULL, NULL, NULL, NULL, NULL, 0, '2026-03-27 17:27:34', '2026-03-27 17:27:34'),
(129, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 17:31:05', 1140.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1140.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 109, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 17:31:05', '2026-03-27 17:31:05'),
(130, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 17:32:40', 2610.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2610.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 110, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 17:32:40', '2026-03-27 17:32:40'),
(131, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 17:33:50', 3240.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3240.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 111, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 17:33:50', '2026-03-27 17:33:50'),
(132, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 17:38:03', 480.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 480.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 112, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 17:38:03', '2026-03-27 17:38:03'),
(133, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 17:40:24', 2880.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2880.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 113, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 17:40:24', '2026-03-27 17:40:24'),
(134, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 08:40:36', 9000.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 9000.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 114, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 08:40:36', '2026-03-28 08:40:36'),
(135, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 08:43:16', 7400.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 7400.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 115, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 08:43:16', '2026-03-28 08:43:16'),
(136, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 08:45:16', 1920.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1920.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 116, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 08:45:16', '2026-03-28 08:45:16'),
(137, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 08:48:33', 12100.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 12100.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 117, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 08:48:33', '2026-03-28 08:48:33'),
(138, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 08:50:03', 9650.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 9650.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 118, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 08:50:03', '2026-03-28 08:50:03'),
(139, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 08:51:45', 13450.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 13450.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 119, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 08:51:45', '2026-03-28 08:51:45'),
(140, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 09:18:29', 3000.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3000.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 120, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 09:18:29', '2026-03-28 09:18:29'),
(141, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 09:20:38', 2200.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2200.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 121, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 09:20:38', '2026-03-28 09:20:38'),
(142, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 09:23:11', 1980.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1980.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 122, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 09:23:11', '2026-03-28 09:23:11'),
(143, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 09:25:02', 720.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 720.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 123, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 09:25:02', '2026-03-28 09:25:02'),
(144, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 09:29:12', 5680.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 5680.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 124, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 09:29:12', '2026-03-28 09:29:12'),
(145, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 09:34:02', 1380.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1380.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 125, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 09:34:02', '2026-03-28 09:34:02'),
(146, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 09:36:47', 3900.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3900.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 126, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 09:36:47', '2026-03-28 09:36:47'),
(147, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 09:39:31', 1000.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1000.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 127, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 09:39:31', '2026-03-28 09:39:31'),
(148, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 09:48:22', 2220.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2220.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 128, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 09:48:22', '2026-03-28 09:48:22'),
(149, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 09:51:44', 1200.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 1200.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 129, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 09:51:44', '2026-03-28 09:51:44'),
(150, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 10:04:56', 2520.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2520.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 130, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 10:04:56', '2026-03-28 10:04:56'),
(151, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 10:07:18', 3240.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3240.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 131, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 10:07:18', '2026-03-28 10:07:18'),
(152, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 10:09:11', 5820.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 5820.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 132, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 10:09:11', '2026-03-28 10:09:11'),
(153, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 10:12:16', 6450.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 6450.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 133, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 10:12:16', '2026-03-28 10:12:16'),
(154, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 10:13:41', 3300.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3300.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 134, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 10:13:41', '2026-03-28 10:13:41');
INSERT INTO `transactions` (`id`, `business_id`, `location_id`, `is_kitchen_order`, `res_table_id`, `res_waiter_id`, `res_order_status`, `type`, `sub_type`, `status`, `sub_status`, `is_quotation`, `payment_status`, `adjustment_type`, `contact_id`, `customer_group_id`, `invoice_no`, `ref_no`, `source`, `subscription_no`, `subscription_repeat_on`, `transaction_date`, `total_before_tax`, `tax_id`, `tax_amount`, `discount_type`, `discount_amount`, `rp_redeemed`, `rp_redeemed_amount`, `shipping_details`, `shipping_address`, `delivery_date`, `shipping_status`, `delivered_to`, `delivery_person`, `shipping_charges`, `shipping_custom_field_1`, `shipping_custom_field_2`, `shipping_custom_field_3`, `shipping_custom_field_4`, `shipping_custom_field_5`, `additional_notes`, `staff_note`, `is_export`, `export_custom_fields_info`, `round_off_amount`, `additional_expense_key_1`, `additional_expense_value_1`, `additional_expense_key_2`, `additional_expense_value_2`, `additional_expense_key_3`, `additional_expense_value_3`, `additional_expense_key_4`, `additional_expense_value_4`, `final_total`, `expense_category_id`, `expense_sub_category_id`, `expense_for`, `commission_agent`, `document`, `is_direct_sale`, `is_suspend`, `exchange_rate`, `total_amount_recovered`, `transfer_parent_id`, `return_parent_id`, `opening_stock_product_id`, `created_by`, `purchase_requisition_ids`, `prefer_payment_method`, `prefer_payment_account`, `sales_order_ids`, `purchase_order_ids`, `custom_field_1`, `custom_field_2`, `custom_field_3`, `custom_field_4`, `import_batch`, `import_time`, `types_of_service_id`, `packing_charge`, `packing_charge_type`, `service_custom_field_1`, `service_custom_field_2`, `service_custom_field_3`, `service_custom_field_4`, `service_custom_field_5`, `service_custom_field_6`, `is_created_from_api`, `rp_earned`, `order_addresses`, `is_recurring`, `recur_interval`, `recur_interval_type`, `recur_repetitions`, `recur_stopped_on`, `recur_parent_id`, `invoice_token`, `pay_term_number`, `pay_term_type`, `selling_price_group_id`, `created_at`, `updated_at`) VALUES
(155, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 10:17:51', 3000.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 3000.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 135, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 10:17:51', '2026-03-28 10:17:51'),
(156, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 10:22:14', 5040.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 5040.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 136, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 10:22:14', '2026-03-28 10:22:14'),
(157, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 10:26:15', 480.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 480.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 137, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 10:26:15', '2026-03-28 10:26:15'),
(158, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 10:38:52', 6600.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 6600.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 138, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 10:38:52', '2026-03-28 10:38:52'),
(159, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 10:43:01', 6000.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 6000.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 139, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 10:43:01', '2026-03-28 10:43:01'),
(160, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 10:46:33', 5400.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 5400.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 140, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 10:46:33', '2026-03-28 10:46:33'),
(161, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 10:51:27', 7400.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 7400.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 141, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 10:51:27', '2026-03-28 10:51:27'),
(162, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 10:57:46', 2100.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2100.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 142, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 10:57:46', '2026-03-28 10:57:46'),
(163, 1, 1, 0, NULL, NULL, NULL, 'opening_stock', NULL, 'received', NULL, 0, 'paid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-01 11:00:17', 2000.0000, NULL, 0.0000, NULL, 0.0000, 0, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, NULL, 0.0000, 2000.0000, NULL, NULL, NULL, NULL, NULL, 0, 0, 1.000, NULL, NULL, NULL, 143, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-28 11:00:17', '2026-03-28 11:00:17');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_payments`
--

CREATE TABLE `transaction_payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `transaction_id` int(11) UNSIGNED DEFAULT NULL,
  `business_id` int(11) DEFAULT NULL,
  `is_return` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Used during sales to return the change',
  `amount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `method` varchar(191) DEFAULT NULL,
  `payment_type` varchar(191) DEFAULT NULL,
  `transaction_no` varchar(191) DEFAULT NULL,
  `card_transaction_number` varchar(191) DEFAULT NULL,
  `card_number` varchar(191) DEFAULT NULL,
  `card_type` varchar(191) DEFAULT NULL,
  `card_holder_name` varchar(191) DEFAULT NULL,
  `card_month` varchar(191) DEFAULT NULL,
  `card_year` varchar(191) DEFAULT NULL,
  `card_security` varchar(5) DEFAULT NULL,
  `cheque_number` varchar(191) DEFAULT NULL,
  `bank_account_number` varchar(191) DEFAULT NULL,
  `paid_on` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `paid_through_link` tinyint(1) NOT NULL DEFAULT 0,
  `gateway` varchar(191) DEFAULT NULL,
  `is_advance` tinyint(1) NOT NULL DEFAULT 0,
  `payment_for` int(11) DEFAULT NULL COMMENT 'stores the contact id',
  `parent_id` int(11) DEFAULT NULL,
  `note` varchar(191) DEFAULT NULL,
  `document` varchar(191) DEFAULT NULL,
  `payment_ref_no` varchar(191) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaction_payments`
--

INSERT INTO `transaction_payments` (`id`, `transaction_id`, `business_id`, `is_return`, `amount`, `method`, `payment_type`, `transaction_no`, `card_transaction_number`, `card_number`, `card_type`, `card_holder_name`, `card_month`, `card_year`, `card_security`, `cheque_number`, `bank_account_number`, `paid_on`, `created_by`, `paid_through_link`, `gateway`, `is_advance`, `payment_for`, `parent_id`, `note`, `document`, `payment_ref_no`, `account_id`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 0, 1850.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 12:01:12', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0001', NULL, '2026-02-20 12:01:12', '2026-02-20 12:01:12'),
(2, 4, 1, 0, 550.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 12:25:48', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0002', NULL, '2026-02-20 12:25:48', '2026-02-20 12:25:48'),
(3, 5, 1, 0, 550.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 12:25:48', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0003', NULL, '2026-02-20 12:25:48', '2026-02-20 12:25:48'),
(4, 6, 1, 0, 5000.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 12:27:54', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0004', NULL, '2026-02-20 12:27:54', '2026-02-20 12:27:54'),
(5, 6, 1, 1, 2600.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 12:27:54', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0005', NULL, '2026-02-20 12:27:54', '2026-02-20 12:27:54'),
(6, 8, 1, 0, 100.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 13:37:39', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0006', NULL, '2026-02-20 13:37:39', '2026-02-20 13:37:39'),
(7, 8, 1, 1, 70.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 13:37:39', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0007', NULL, '2026-02-20 13:37:39', '2026-02-20 13:37:39'),
(8, 9, 1, 0, 30.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 14:16:28', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0008', NULL, '2026-02-20 14:16:28', '2026-02-20 14:16:28'),
(9, 10, 1, 0, 1880.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 15:17:03', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0009', NULL, '2026-02-20 15:17:03', '2026-02-20 15:17:03'),
(10, 11, 1, 0, 1880.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 15:19:32', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0010', NULL, '2026-02-20 15:19:32', '2026-02-20 15:19:32'),
(11, 12, 1, 0, 1880.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 15:20:34', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0011', NULL, '2026-02-20 15:20:34', '2026-02-20 15:20:34'),
(12, 13, 1, 0, 1880.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 15:27:47', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0012', NULL, '2026-02-20 15:27:47', '2026-02-20 15:27:47'),
(13, 14, 1, 0, 1880.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 15:29:10', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0013', NULL, '2026-02-20 15:29:10', '2026-02-20 15:29:10'),
(14, 24, 1, 0, 1300.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-20 16:43:30', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0014', NULL, '2026-02-20 16:43:30', '2026-02-20 16:43:30'),
(29, 42, 1, 0, 5000.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-21 21:42:44', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0029', NULL, '2026-02-21 21:42:44', '2026-02-21 21:42:44'),
(30, 42, 1, 1, 1000.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-21 21:42:44', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0030', NULL, '2026-02-21 21:42:44', '2026-02-21 21:42:44'),
(31, 43, 1, 0, 4500.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-23 13:10:56', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0031', NULL, '2026-02-23 13:10:56', '2026-02-23 13:10:56'),
(32, 43, 1, 1, 1325.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-02-23 13:10:56', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0032', NULL, '2026-02-23 13:10:56', '2026-02-23 13:10:56'),
(39, 47, 1, 0, 5000.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-01 17:33:05', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0039', NULL, '2026-03-01 17:33:05', '2026-03-01 17:33:05'),
(40, 47, 1, 1, 3900.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-01 17:33:05', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0040', NULL, '2026-03-01 17:33:05', '2026-03-01 17:33:05'),
(41, 49, 1, 0, 5000.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-01 17:59:29', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0041', NULL, '2026-03-01 17:59:29', '2026-03-01 17:59:29'),
(42, 49, 1, 1, 3900.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-01 17:59:29', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0042', NULL, '2026-03-01 17:59:29', '2026-03-01 17:59:29'),
(43, 50, 1, 0, 5000.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-01 17:59:57', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0043', NULL, '2026-03-01 17:59:57', '2026-03-01 17:59:57'),
(44, 50, 1, 1, 3350.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-01 17:59:57', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0044', NULL, '2026-03-01 17:59:57', '2026-03-01 17:59:57'),
(45, 51, 1, 0, 360.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-01 18:06:33', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0045', NULL, '2026-03-01 18:06:33', '2026-03-01 18:06:33'),
(46, 52, 1, 0, 1000.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:09:31', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0046', NULL, '2026-03-03 19:09:31', '2026-03-03 19:09:31'),
(47, 52, 1, 1, 450.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-03 19:09:31', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0047', NULL, '2026-03-03 19:09:31', '2026-03-03 19:09:31'),
(48, 97, 1, 0, 1160.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-04 16:14:41', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0048', NULL, '2026-03-04 16:14:41', '2026-03-04 16:14:41'),
(49, 98, 1, 0, 1000.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-04 16:23:43', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0049', NULL, '2026-03-04 16:23:43', '2026-03-04 16:23:43'),
(50, 98, 1, 1, 420.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-04 16:23:43', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0050', NULL, '2026-03-04 16:23:43', '2026-03-04 16:23:43'),
(51, 99, 1, 0, 5000.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-10 11:48:04', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0051', NULL, '2026-03-10 11:48:04', '2026-03-10 11:48:04'),
(52, 99, 1, 1, 1920.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-10 11:48:04', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0052', NULL, '2026-03-10 11:48:04', '2026-03-10 11:48:04'),
(53, 100, 1, 0, 800.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-14 16:26:43', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0053', NULL, '2026-03-14 16:26:43', '2026-03-14 16:26:43'),
(54, 128, 1, 0, 450.0000, 'cash', NULL, NULL, NULL, NULL, 'credit', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-27 17:27:34', 1, 0, NULL, 0, 1, NULL, NULL, NULL, 'SP2026/0054', NULL, '2026-03-27 17:27:34', '2026-03-27 17:27:34');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_sell_lines`
--

CREATE TABLE `transaction_sell_lines` (
  `id` int(10) UNSIGNED NOT NULL,
  `transaction_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `variation_id` int(10) UNSIGNED NOT NULL,
  `quantity` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `secondary_unit_quantity` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `quantity_returned` decimal(20,4) NOT NULL DEFAULT 0.0000,
  `unit_price_before_discount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `unit_price` decimal(22,4) DEFAULT NULL COMMENT 'Sell price excluding tax',
  `line_discount_type` enum('fixed','percentage') DEFAULT NULL,
  `line_discount_amount` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `unit_price_inc_tax` decimal(22,4) DEFAULT NULL COMMENT 'Sell price including tax',
  `item_tax` decimal(22,4) NOT NULL COMMENT 'Tax for one quantity',
  `tax_id` int(10) UNSIGNED DEFAULT NULL,
  `discount_id` int(11) DEFAULT NULL,
  `lot_no_line_id` int(11) DEFAULT NULL,
  `sell_line_note` text DEFAULT NULL,
  `so_line_id` int(11) DEFAULT NULL,
  `so_quantity_invoiced` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `res_service_staff_id` int(11) DEFAULT NULL,
  `res_line_order_status` varchar(191) DEFAULT NULL,
  `parent_sell_line_id` int(11) DEFAULT NULL,
  `children_type` varchar(191) NOT NULL DEFAULT '' COMMENT 'Type of children for the parent, like modifier or combo',
  `sub_unit_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaction_sell_lines`
--

INSERT INTO `transaction_sell_lines` (`id`, `transaction_id`, `product_id`, `variation_id`, `quantity`, `secondary_unit_quantity`, `quantity_returned`, `unit_price_before_discount`, `unit_price`, `line_discount_type`, `line_discount_amount`, `unit_price_inc_tax`, `item_tax`, `tax_id`, `discount_id`, `lot_no_line_id`, `sell_line_note`, `so_line_id`, `so_quantity_invoiced`, `res_service_staff_id`, `res_line_order_status`, `parent_sell_line_id`, `children_type`, `sub_unit_id`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 1, 1.0000, 0.0000, 0.0000, 1850.0000, 1850.0000, 'fixed', 0.0000, 1850.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 12:01:12', '2026-02-20 12:01:12'),
(2, 4, 2, 2, 1.0000, 0.0000, 0.0000, 550.0000, 550.0000, 'fixed', 0.0000, 550.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 12:25:48', '2026-02-20 12:25:48'),
(3, 5, 2, 2, 1.0000, 0.0000, 0.0000, 550.0000, 550.0000, 'fixed', 0.0000, 550.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 12:25:48', '2026-02-20 12:25:48'),
(4, 6, 1, 1, 1.0000, 0.0000, 0.0000, 1850.0000, 1850.0000, 'fixed', 0.0000, 1850.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 12:27:54', '2026-02-20 12:27:54'),
(5, 6, 2, 2, 1.0000, 0.0000, 0.0000, 550.0000, 550.0000, 'fixed', 0.0000, 550.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 12:27:54', '2026-02-20 12:27:54'),
(6, 8, 3, 3, 1.0000, 0.0000, 0.0000, 30.0000, 30.0000, 'fixed', 0.0000, 30.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 13:37:39', '2026-02-20 13:37:39'),
(7, 9, 3, 3, 1.0000, 0.0000, 0.0000, 30.0000, 30.0000, 'fixed', 0.0000, 30.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 14:16:28', '2026-02-20 14:16:28'),
(8, 10, 1, 1, 1.0000, 0.0000, 0.0000, 1850.0000, 1850.0000, 'fixed', 0.0000, 1850.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 15:17:03', '2026-02-20 15:17:03'),
(9, 10, 3, 3, 1.0000, 0.0000, 0.0000, 30.0000, 30.0000, 'fixed', 0.0000, 30.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 15:17:03', '2026-02-20 15:17:03'),
(10, 11, 1, 1, 1.0000, 0.0000, 0.0000, 1850.0000, 1850.0000, 'fixed', 0.0000, 1850.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 15:19:32', '2026-02-20 15:19:32'),
(11, 11, 3, 3, 1.0000, 0.0000, 0.0000, 30.0000, 30.0000, 'fixed', 0.0000, 30.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 15:19:32', '2026-02-20 15:19:32'),
(12, 12, 1, 1, 1.0000, 0.0000, 0.0000, 1850.0000, 1850.0000, 'fixed', 0.0000, 1850.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 15:20:34', '2026-02-20 15:20:34'),
(13, 12, 3, 3, 1.0000, 0.0000, 0.0000, 30.0000, 30.0000, 'fixed', 0.0000, 30.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 15:20:34', '2026-02-20 15:20:34'),
(14, 13, 3, 3, 1.0000, 0.0000, 0.0000, 30.0000, 30.0000, 'fixed', 0.0000, 30.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 15:27:47', '2026-02-20 15:27:47'),
(15, 13, 1, 1, 1.0000, 0.0000, 0.0000, 1850.0000, 1850.0000, 'fixed', 0.0000, 1850.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 15:27:47', '2026-02-20 15:27:47'),
(16, 14, 1, 1, 1.0000, 0.0000, 0.0000, 1850.0000, 1850.0000, 'fixed', 0.0000, 1850.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 15:29:10', '2026-02-20 15:29:10'),
(17, 14, 3, 3, 1.0000, 0.0000, 0.0000, 30.0000, 30.0000, 'fixed', 0.0000, 30.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 15:29:10', '2026-02-20 15:29:10'),
(18, 15, 1, 1, 1.0000, 0.0000, 0.0000, 1850.0000, 1850.0000, 'fixed', 0.0000, 1850.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 15:30:52', '2026-02-20 15:30:52'),
(19, 24, 7, 7, 1.0000, 0.0000, 0.0000, 1300.0000, 1300.0000, 'fixed', 0.0000, 1300.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-20 16:43:30', '2026-02-20 16:43:30'),
(31, 42, 20, 20, 5.0000, 0.0000, 0.0000, 800.0000, 800.0000, 'fixed', 0.0000, 800.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-21 21:42:44', '2026-02-21 21:42:44'),
(32, 43, 11, 11, 1.0000, 0.0000, 0.0000, 2980.0000, 2980.0000, 'fixed', 0.0000, 2980.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-23 13:10:56', '2026-02-23 13:10:56'),
(33, 43, 13, 13, 1.0000, 0.0000, 0.0000, 195.0000, 195.0000, 'fixed', 0.0000, 195.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-02-23 13:10:56', '2026-02-23 13:10:56'),
(37, 47, 2, 2, 2.0000, 0.0000, 0.0000, 550.0000, 550.0000, 'fixed', 0.0000, 550.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-03-01 17:33:05', '2026-03-01 17:33:05'),
(38, 49, 2, 2, 2.0000, 0.0000, 0.0000, 550.0000, 550.0000, 'fixed', 0.0000, 550.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-03-01 17:59:29', '2026-03-01 17:59:29'),
(39, 50, 2, 2, 3.0000, 0.0000, 0.0000, 550.0000, 550.0000, 'fixed', 0.0000, 550.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-03-01 17:59:57', '2026-03-01 17:59:57'),
(40, 51, 21, 21, 2.0000, 0.0000, 0.0000, 180.0000, 180.0000, 'fixed', 0.0000, 180.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-03-01 18:06:33', '2026-03-01 18:06:33'),
(41, 52, 2, 2, 1.0000, 0.0000, 0.0000, 550.0000, 550.0000, 'fixed', 0.0000, 550.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-03-03 19:09:31', '2026-03-03 19:09:31'),
(42, 97, 5, 5, 2.0000, 0.0000, 0.0000, 580.0000, 580.0000, 'fixed', 0.0000, 580.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-03-04 16:14:41', '2026-03-04 16:14:41'),
(43, 98, 5, 5, 1.0000, 0.0000, 0.0000, 580.0000, 580.0000, 'fixed', 0.0000, 580.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-03-04 16:23:43', '2026-03-04 16:23:43'),
(44, 99, 11, 11, 1.0000, 0.0000, 0.0000, 2980.0000, 2980.0000, 'fixed', 0.0000, 2980.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-03-10 11:48:04', '2026-03-10 11:48:04'),
(45, 99, 41, 41, 1.0000, 0.0000, 0.0000, 100.0000, 100.0000, 'fixed', 0.0000, 100.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-03-10 11:48:04', '2026-03-10 11:48:04'),
(46, 100, 20, 20, 1.0000, 0.0000, 0.0000, 800.0000, 800.0000, 'fixed', 0.0000, 800.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-03-14 16:26:43', '2026-03-14 16:26:43'),
(47, 128, 96, 96, 1.0000, 0.0000, 0.0000, 450.0000, 450.0000, 'fixed', 0.0000, 450.0000, 0.0000, NULL, NULL, NULL, '', NULL, 0.0000, NULL, NULL, NULL, '', NULL, '2026-03-27 17:27:34', '2026-03-27 17:27:34');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_sell_lines_purchase_lines`
--

CREATE TABLE `transaction_sell_lines_purchase_lines` (
  `id` bigint(20) NOT NULL,
  `sell_line_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'id from transaction_sell_lines',
  `stock_adjustment_line_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'id from stock_adjustment_lines',
  `purchase_line_id` int(10) UNSIGNED NOT NULL COMMENT 'id from purchase_lines',
  `quantity` decimal(22,4) NOT NULL,
  `qty_returned` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaction_sell_lines_purchase_lines`
--

INSERT INTO `transaction_sell_lines_purchase_lines` (`id`, `sell_line_id`, `stock_adjustment_line_id`, `purchase_line_id`, `quantity`, `qty_returned`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 1, 1.0000, 0.0000, '2026-02-20 12:01:12', '2026-02-20 12:01:12'),
(2, 2, NULL, 2, 1.0000, 0.0000, '2026-02-20 12:25:48', '2026-02-20 12:25:48'),
(3, 3, NULL, 2, 1.0000, 0.0000, '2026-02-20 12:25:48', '2026-02-20 12:25:48'),
(4, 4, NULL, 1, 1.0000, 0.0000, '2026-02-20 12:27:54', '2026-02-20 12:27:54'),
(5, 5, NULL, 2, 1.0000, 0.0000, '2026-02-20 12:27:54', '2026-02-20 12:27:54'),
(6, 6, NULL, 3, 1.0000, 0.0000, '2026-02-20 13:37:39', '2026-02-20 13:37:39'),
(7, 7, NULL, 3, 1.0000, 0.0000, '2026-02-20 14:16:28', '2026-02-20 14:16:28'),
(8, 8, NULL, 1, 1.0000, 0.0000, '2026-02-20 15:17:03', '2026-02-20 15:17:03'),
(9, 9, NULL, 3, 1.0000, 0.0000, '2026-02-20 15:17:03', '2026-02-20 15:17:03'),
(10, 10, NULL, 1, 1.0000, 0.0000, '2026-02-20 15:19:32', '2026-02-20 15:19:32'),
(11, 11, NULL, 3, 1.0000, 0.0000, '2026-02-20 15:19:32', '2026-02-20 15:19:32'),
(12, 12, NULL, 1, 1.0000, 0.0000, '2026-02-20 15:20:34', '2026-02-20 15:20:34'),
(13, 13, NULL, 3, 1.0000, 0.0000, '2026-02-20 15:20:34', '2026-02-20 15:20:34'),
(14, 14, NULL, 3, 1.0000, 0.0000, '2026-02-20 15:27:47', '2026-02-20 15:27:47'),
(15, 15, NULL, 1, 1.0000, 0.0000, '2026-02-20 15:27:47', '2026-02-20 15:27:47'),
(16, 16, NULL, 1, 1.0000, 0.0000, '2026-02-20 15:29:10', '2026-02-20 15:29:10'),
(17, 17, NULL, 3, 1.0000, 0.0000, '2026-02-20 15:29:10', '2026-02-20 15:29:10'),
(18, 19, NULL, 6, 1.0000, 0.0000, '2026-02-20 16:43:30', '2026-02-20 16:43:30'),
(30, 31, NULL, 18, 5.0000, 0.0000, '2026-02-21 21:42:44', '2026-02-21 21:42:44'),
(31, 32, NULL, 10, 1.0000, 0.0000, '2026-02-23 13:10:56', '2026-02-23 13:10:56'),
(32, 33, NULL, 12, 1.0000, 0.0000, '2026-02-23 13:10:56', '2026-02-23 13:10:56'),
(36, 37, NULL, 2, 2.0000, 0.0000, '2026-03-01 17:33:05', '2026-03-01 17:33:05'),
(37, 38, NULL, 2, 2.0000, 0.0000, '2026-03-01 17:59:29', '2026-03-01 17:59:29'),
(38, 39, NULL, 2, 3.0000, 0.0000, '2026-03-01 17:59:57', '2026-03-01 17:59:57'),
(39, 40, NULL, 19, 2.0000, 0.0000, '2026-03-01 18:06:33', '2026-03-01 18:06:33'),
(40, 41, NULL, 2, 1.0000, 0.0000, '2026-03-03 19:09:31', '2026-03-03 19:09:31'),
(41, 42, NULL, 4, 2.0000, 0.0000, '2026-03-04 16:14:41', '2026-03-04 16:14:41'),
(42, 43, NULL, 4, 1.0000, 0.0000, '2026-03-04 16:23:43', '2026-03-04 16:23:43'),
(43, 44, NULL, 10, 1.0000, 0.0000, '2026-03-10 11:48:04', '2026-03-10 11:48:04'),
(44, 45, NULL, 39, 1.0000, 0.0000, '2026-03-10 11:48:04', '2026-03-10 11:48:04'),
(45, 46, NULL, 18, 1.0000, 0.0000, '2026-03-14 16:26:43', '2026-03-14 16:26:43'),
(46, 47, NULL, 78, 1.0000, 0.0000, '2026-03-27 17:27:34', '2026-03-27 17:27:34');

-- --------------------------------------------------------

--
-- Table structure for table `types_of_services`
--

CREATE TABLE `types_of_services` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `business_id` int(11) NOT NULL,
  `location_price_group` text DEFAULT NULL,
  `packing_charge` decimal(22,4) DEFAULT NULL,
  `packing_charge_type` enum('fixed','percent') DEFAULT NULL,
  `enable_custom_fields` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `actual_name` varchar(191) NOT NULL,
  `short_name` varchar(191) NOT NULL,
  `allow_decimal` tinyint(1) NOT NULL,
  `base_unit_id` int(11) DEFAULT NULL,
  `base_unit_multiplier` decimal(20,4) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `business_id`, `actual_name`, `short_name`, `allow_decimal`, `base_unit_id`, `base_unit_multiplier`, `created_by`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'Pieces', 'Pc(s)', 0, NULL, NULL, 1, NULL, '2026-02-19 17:29:18', '2026-02-19 17:29:18'),
(2, 1, 'bottle', 'bt', 0, NULL, NULL, 1, NULL, '2026-02-20 12:19:07', '2026-02-20 12:19:07'),
(3, 1, 'Meters', 'M', 1, NULL, NULL, 1, NULL, '2026-03-01 18:03:58', '2026-03-01 18:03:58');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_type` varchar(191) NOT NULL DEFAULT 'user',
  `surname` char(10) DEFAULT NULL,
  `first_name` varchar(191) NOT NULL,
  `last_name` varchar(191) DEFAULT NULL,
  `username` varchar(191) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `password` varchar(191) DEFAULT NULL,
  `language` char(7) NOT NULL DEFAULT 'en',
  `contact_no` char(15) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `business_id` int(10) UNSIGNED DEFAULT NULL,
  `available_at` datetime DEFAULT NULL COMMENT 'Service staff avilable at. Calculated from product preparation_time_in_minutes',
  `paused_at` datetime DEFAULT NULL COMMENT 'Service staff available time paused at, Will be nulled on resume.',
  `max_sales_discount_percent` decimal(5,2) DEFAULT NULL,
  `allow_login` tinyint(1) NOT NULL DEFAULT 1,
  `status` enum('active','inactive','terminated') NOT NULL DEFAULT 'active',
  `is_enable_service_staff_pin` tinyint(1) NOT NULL DEFAULT 0,
  `service_staff_pin` text DEFAULT NULL,
  `crm_contact_id` int(10) UNSIGNED DEFAULT NULL,
  `is_cmmsn_agnt` tinyint(1) NOT NULL DEFAULT 0,
  `cmmsn_percent` decimal(4,2) NOT NULL DEFAULT 0.00,
  `selected_contacts` tinyint(1) NOT NULL DEFAULT 0,
  `dob` date DEFAULT NULL,
  `gender` varchar(191) DEFAULT NULL,
  `marital_status` enum('married','unmarried','divorced') DEFAULT NULL,
  `blood_group` char(10) DEFAULT NULL,
  `contact_number` char(20) DEFAULT NULL,
  `alt_number` varchar(191) DEFAULT NULL,
  `family_number` varchar(191) DEFAULT NULL,
  `fb_link` varchar(191) DEFAULT NULL,
  `twitter_link` varchar(191) DEFAULT NULL,
  `social_media_1` varchar(191) DEFAULT NULL,
  `social_media_2` varchar(191) DEFAULT NULL,
  `permanent_address` text DEFAULT NULL,
  `current_address` text DEFAULT NULL,
  `guardian_name` varchar(191) DEFAULT NULL,
  `custom_field_1` varchar(191) DEFAULT NULL,
  `custom_field_2` varchar(191) DEFAULT NULL,
  `custom_field_3` varchar(191) DEFAULT NULL,
  `custom_field_4` varchar(191) DEFAULT NULL,
  `bank_details` longtext DEFAULT NULL,
  `id_proof_name` varchar(191) DEFAULT NULL,
  `id_proof_number` varchar(191) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user_type`, `surname`, `first_name`, `last_name`, `username`, `email`, `password`, `language`, `contact_no`, `address`, `remember_token`, `business_id`, `available_at`, `paused_at`, `max_sales_discount_percent`, `allow_login`, `status`, `is_enable_service_staff_pin`, `service_staff_pin`, `crm_contact_id`, `is_cmmsn_agnt`, `cmmsn_percent`, `selected_contacts`, `dob`, `gender`, `marital_status`, `blood_group`, `contact_number`, `alt_number`, `family_number`, `fb_link`, `twitter_link`, `social_media_1`, `social_media_2`, `permanent_address`, `current_address`, `guardian_name`, `custom_field_1`, `custom_field_2`, `custom_field_3`, `custom_field_4`, `bank_details`, `id_proof_name`, `id_proof_number`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'user', NULL, 'Admin', 'User', 'admin', 'admin@localhost', '$2y$10$7vRDFyvbHhUlTk3TDISA5e.fsWjfn2Wj4DtvNyWj1b.IEqXJ.VO/S', 'en', NULL, NULL, 'EPTfiryIn4ZBe5EJ2jHzg8joTyngQwi4MUSCSREV07CuoxfzfNLlXuYwSXjM', 1, NULL, NULL, NULL, 1, 'active', 0, NULL, NULL, 0, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{\"account_holder_name\":null,\"account_number\":null,\"bank_name\":null,\"bank_code\":null,\"branch\":null,\"tax_payer_id\":null}', NULL, NULL, NULL, '2026-02-19 17:29:18', '2026-02-20 10:56:34');

-- --------------------------------------------------------

--
-- Table structure for table `user_contact_access`
--

CREATE TABLE `user_contact_access` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `variations`
--

CREATE TABLE `variations` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `sub_sku` varchar(191) DEFAULT NULL,
  `product_variation_id` int(10) UNSIGNED NOT NULL,
  `variation_value_id` int(11) DEFAULT NULL,
  `default_purchase_price` decimal(22,4) DEFAULT NULL,
  `dpp_inc_tax` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `profit_percent` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `default_sell_price` decimal(22,4) DEFAULT NULL,
  `sell_price_inc_tax` decimal(22,4) DEFAULT NULL COMMENT 'Sell price including tax',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `combo_variations` text DEFAULT NULL COMMENT 'Contains the combo variation details'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `variations`
--

INSERT INTO `variations` (`id`, `name`, `product_id`, `sub_sku`, `product_variation_id`, `variation_value_id`, `default_purchase_price`, `dpp_inc_tax`, `profit_percent`, `default_sell_price`, `sell_price_inc_tax`, `created_at`, `updated_at`, `deleted_at`, `combo_variations`) VALUES
(1, 'DUMMY', 1, '0001', 1, NULL, 1450.0000, 1450.0000, 27.5900, 1850.0000, 1850.0000, '2026-02-20 11:55:42', '2026-02-20 11:55:42', NULL, '[]'),
(2, 'DUMMY', 2, '0002', 2, NULL, 440.0000, 440.0000, 25.0000, 550.0000, 550.0000, '2026-02-20 12:22:54', '2026-02-20 12:22:54', NULL, '[]'),
(3, 'DUMMY', 3, '4792210100781', 3, NULL, 15.0000, 15.0000, 100.0000, 30.0000, 30.0000, '2026-02-20 13:28:14', '2026-02-20 13:28:14', NULL, '[]'),
(4, 'DUMMY', 4, '12345678', 4, NULL, 25.0000, 25.0000, 0.0000, 25.0000, 25.0000, '2026-02-20 13:59:23', '2026-02-20 13:59:23', NULL, '[]'),
(5, 'DUMMY', 5, '4796023969122', 5, NULL, 445.0000, 445.0000, 30.3400, 580.0000, 580.0000, '2026-02-20 15:38:03', '2026-02-20 15:38:03', NULL, '[]'),
(6, 'DUMMY', 6, '6942310500112', 6, NULL, 125.0000, 125.0000, 40.0000, 175.0000, 175.0000, '2026-02-20 15:42:31', '2026-02-20 15:42:31', NULL, '[]'),
(7, 'DUMMY', 7, '0007', 7, NULL, 750.0000, 750.0000, 73.3300, 1300.0000, 1300.0000, '2026-02-20 15:53:26', '2026-02-20 15:53:26', NULL, '[]'),
(8, 'DUMMY', 8, '0008', 8, NULL, 325.0000, 325.0000, 47.6900, 480.0000, 480.0000, '2026-02-20 16:09:58', '2026-02-20 16:09:58', NULL, '[]'),
(9, 'DUMMY', 9, '0009', 9, NULL, 805.0000, 805.0000, 42.8600, 1150.0000, 1150.0000, '2026-02-20 16:16:34', '2026-02-20 16:16:34', NULL, '[]'),
(10, 'DUMMY', 10, '0010', 10, NULL, 590.0000, 590.0000, 33.9000, 790.0000, 790.0000, '2026-02-20 16:22:47', '2026-02-20 16:22:47', NULL, '[]'),
(11, 'DUMMY', 11, '0011', 11, NULL, 2500.0000, 2500.0000, 19.2000, 2980.0000, 2980.0000, '2026-02-20 16:31:41', '2026-02-20 16:31:41', NULL, '[]'),
(12, 'DUMMY', 12, '0012', 12, NULL, 90.0000, 90.0000, 38.8900, 125.0000, 125.0000, '2026-02-20 16:39:48', '2026-02-20 16:39:48', NULL, '[]'),
(13, 'DUMMY', 13, '0013', 13, NULL, 140.0000, 140.0000, 39.2900, 195.0000, 195.0000, '2026-02-20 16:47:04', '2026-02-20 16:47:04', NULL, '[]'),
(15, 'DUMMY', 15, '0015', 15, NULL, 90.0000, 90.0000, 44.4400, 130.0000, 130.0000, '2026-02-20 17:03:04', '2026-02-20 17:03:04', NULL, '[]'),
(16, 'DUMMY', 16, '6971679249202', 16, NULL, 40.0000, 40.0000, 50.0000, 60.0000, 60.0000, '2026-02-20 17:13:26', '2026-02-20 17:13:26', NULL, '[]'),
(17, 'DUMMY', 17, '6739225235822', 17, NULL, 40.0000, 40.0000, 75.0000, 70.0000, 70.0000, '2026-02-20 17:19:49', '2026-02-20 17:19:49', NULL, '[]'),
(18, 'DUMMY', 18, '0018', 18, NULL, 95.0000, 95.0000, 47.3700, 140.0000, 140.0000, '2026-02-20 17:27:50', '2026-02-20 17:27:50', NULL, '[]'),
(19, 'DUMMY', 19, '0019', 19, NULL, 45.0000, 45.0000, 111.1100, 95.0000, 95.0000, '2026-02-20 17:36:40', '2026-02-20 17:36:40', NULL, '[]'),
(20, 'DUMMY', 20, '0020', 20, NULL, 150.0000, 150.0000, 433.3300, 800.0000, 800.0000, '2026-02-21 12:05:21', '2026-03-05 16:01:30', NULL, '[]'),
(21, 'DUMMY', 21, '0021', 21, NULL, 120.0000, 120.0000, 50.0000, 180.0000, 180.0000, '2026-03-01 17:37:28', '2026-03-01 17:37:28', NULL, '[]'),
(22, 'DUMMY', 22, '6978113200027', 22, NULL, 300.0000, 300.0000, 60.0000, 480.0000, 480.0000, '2026-03-03 19:17:13', '2026-03-03 19:17:13', NULL, '[]'),
(23, 'DUMMY', 23, '4796002051954', 23, NULL, 90.0000, 90.0000, 33.3300, 120.0000, 120.0000, '2026-03-03 19:21:56', '2026-03-03 19:21:56', NULL, '[]'),
(24, 'DUMMY', 24, '6923369601036', 24, NULL, 90.0000, 90.0000, 33.3300, 120.0000, 120.0000, '2026-03-03 19:23:25', '2026-03-03 19:23:25', NULL, '[]'),
(25, 'DUMMY', 25, '4796009862249', 25, NULL, 60.0000, 60.0000, 16.6700, 70.0000, 70.0000, '2026-03-03 19:24:47', '2026-03-03 19:24:47', NULL, '[]'),
(26, 'DUMMY', 26, '4792210130979', 26, NULL, 142.0000, 142.0000, 5.6300, 150.0000, 150.0000, '2026-03-03 19:26:34', '2026-03-03 19:26:34', NULL, '[]'),
(27, 'DUMMY', 27, '6938534001153', 27, NULL, 140.0000, 140.0000, 14.2900, 160.0000, 160.0000, '2026-03-03 19:28:34', '2026-03-03 19:28:34', NULL, '[]'),
(28, 'DUMMY', 28, '4796009862829', 28, NULL, 420.0000, 420.0000, 11.9000, 470.0000, 470.0000, '2026-03-03 19:30:10', '2026-03-03 19:30:10', NULL, '[]'),
(29, 'DUMMY', 29, '4796009862812', 29, NULL, 200.0000, 200.0000, 30.0000, 260.0000, 260.0000, '2026-03-03 19:31:05', '2026-03-03 19:31:05', NULL, '[]'),
(30, 'DUMMY', 30, '4796027900305', 30, NULL, 35.0000, 35.0000, 14.2900, 40.0000, 40.0000, '2026-03-03 19:32:46', '2026-03-03 19:32:46', NULL, '[]'),
(31, 'DUMMY', 31, '4792210106714', 31, NULL, 190.0000, 190.0000, 15.7900, 220.0000, 220.0000, '2026-03-03 19:35:12', '2026-03-03 19:35:12', NULL, '[]'),
(32, 'DUMMY', 32, '4796009863772', 32, NULL, 200.0000, 200.0000, 25.0000, 250.0000, 250.0000, '2026-03-03 19:36:43', '2026-03-03 19:36:43', NULL, '[]'),
(33, 'DUMMY', 33, '4792210103454', 33, NULL, 260.0000, 260.0000, 15.3800, 300.0000, 300.0000, '2026-03-03 19:37:42', '2026-03-03 19:37:42', NULL, '[]'),
(34, 'DUMMY', 34, '4796009863123', 34, NULL, 290.0000, 290.0000, 10.3400, 320.0000, 320.0000, '2026-03-03 19:38:28', '2026-03-03 19:38:28', NULL, '[]'),
(35, 'DUMMY', 35, '4796009863116', 35, NULL, 150.0000, 150.0000, 23.3300, 185.0000, 185.0000, '2026-03-03 19:39:14', '2026-03-03 19:39:14', NULL, '[]'),
(36, 'DUMMY', 36, '8026624581031', 36, NULL, 65.0000, 65.0000, 23.0800, 80.0000, 80.0000, '2026-03-03 19:40:20', '2026-03-03 19:40:20', NULL, '[]'),
(37, 'DUMMY', 37, '4792210112715', 37, NULL, 35.0000, 35.0000, 28.5700, 45.0000, 45.0000, '2026-03-03 19:41:22', '2026-03-03 19:41:22', NULL, '[]'),
(38, 'DUMMY', 38, '0038', 38, NULL, 75.0000, 75.0000, 26.6700, 95.0000, 95.0000, '2026-03-03 19:43:05', '2026-03-03 19:43:05', NULL, '[]'),
(39, 'DUMMY', 39, '6939788779775', 39, NULL, 200.0000, 200.0000, 12.5000, 225.0000, 225.0000, '2026-03-03 19:45:21', '2026-03-03 19:45:21', NULL, '[]'),
(40, 'DUMMY', 40, '4796009868661', 40, NULL, 100.0000, 100.0000, 30.0000, 130.0000, 130.0000, '2026-03-03 19:46:12', '2026-03-03 19:46:12', NULL, '[]'),
(41, 'DUMMY', 41, 'CL70059', 41, NULL, 80.0000, 80.0000, 25.0000, 100.0000, 100.0000, '2026-03-03 19:47:06', '2026-03-03 19:47:06', NULL, '[]'),
(42, 'DUMMY', 42, '8901860510185', 42, NULL, 180.0000, 180.0000, 11.1100, 200.0000, 200.0000, '2026-03-03 19:49:49', '2026-03-03 19:49:49', NULL, '[]'),
(43, 'DUMMY', 43, '4793000954003', 43, NULL, 210.0000, 210.0000, 19.0500, 250.0000, 250.0000, '2026-03-03 19:50:42', '2026-03-03 19:50:42', NULL, '[]'),
(44, 'DUMMY', 44, '4792210137589', 44, NULL, 310.0000, 310.0000, 12.9000, 350.0000, 350.0000, '2026-03-03 19:51:53', '2026-03-03 19:51:53', NULL, '[]'),
(45, 'DUMMY', 45, '4792210137572', 45, NULL, 150.0000, 150.0000, 30.0000, 195.0000, 195.0000, '2026-03-03 19:52:56', '2026-03-03 19:52:56', NULL, '[]'),
(46, 'DUMMY', 46, '4796009860917', 46, NULL, 340.0000, 340.0000, 10.2900, 375.0000, 375.0000, '2026-03-03 19:54:10', '2026-03-03 19:54:10', NULL, '[]'),
(47, 'DUMMY', 47, '4792210103492', 47, NULL, 350.0000, 350.0000, 7.1400, 375.0000, 375.0000, '2026-03-03 19:55:01', '2026-03-03 19:55:01', NULL, '[]'),
(48, 'DUMMY', 48, '4792210103485', 48, NULL, 180.0000, 180.0000, 16.6700, 210.0000, 210.0000, '2026-03-03 19:56:02', '2026-03-03 19:56:02', NULL, '[]'),
(49, 'DUMMY', 49, '4796001620038', 49, NULL, 180.0000, 180.0000, 16.6700, 210.0000, 210.0000, '2026-03-03 19:57:21', '2026-03-03 19:57:21', NULL, '[]'),
(50, 'DUMMY', 50, '4640020963365', 50, NULL, 200.0000, 200.0000, 25.0000, 250.0000, 250.0000, '2026-03-03 19:58:23', '2026-03-03 19:58:23', NULL, '[]'),
(51, 'DUMMY', 51, '3154141832123', 51, NULL, 200.0000, 200.0000, 25.0000, 250.0000, 250.0000, '2026-03-03 19:59:37', '2026-03-03 19:59:37', NULL, '[]'),
(52, 'DUMMY', 52, '6970928006870', 52, NULL, 200.0000, 200.0000, 25.0000, 250.0000, 250.0000, '2026-03-03 20:00:29', '2026-03-03 20:00:29', NULL, '[]'),
(53, 'DUMMY', 53, '4792210102815', 53, NULL, 210.0000, 210.0000, 28.5700, 270.0000, 270.0000, '2026-03-03 20:01:15', '2026-03-03 20:01:15', NULL, '[]'),
(54, 'DUMMY', 54, '6935468184877', 54, NULL, 420.0000, 420.0000, 9.5200, 460.0000, 460.0000, '2026-03-03 20:02:20', '2026-03-03 20:02:20', NULL, '[]'),
(55, 'DUMMY', 55, '6971082890183', 55, NULL, 450.0000, 450.0000, 6.6700, 480.0000, 480.0000, '2026-03-03 20:03:24', '2026-03-03 20:03:24', NULL, '[]'),
(56, 'DUMMY', 56, '6976693306535', 56, NULL, 500.0000, 500.0000, 8.0000, 540.0000, 540.0000, '2026-03-03 20:04:25', '2026-03-03 20:04:25', NULL, '[]'),
(57, 'DUMMY', 57, '4792210102808', 57, NULL, 390.0000, 390.0000, 23.0800, 480.0000, 480.0000, '2026-03-03 20:07:49', '2026-03-03 20:07:49', NULL, '[]'),
(58, 'DUMMY', 58, '8901860410072', 58, NULL, 900.0000, 900.0000, 11.6700, 1005.0000, 1005.0000, '2026-03-03 20:09:03', '2026-03-03 20:09:03', NULL, '[]'),
(59, 'DUMMY', 59, '6900010090043', 59, NULL, 150.0000, 150.0000, 20.0000, 180.0000, 180.0000, '2026-03-03 20:10:18', '2026-03-03 20:10:18', NULL, '[]'),
(60, 'DUMMY', 60, '4792210109265', 60, NULL, 35.0000, 35.0000, 14.2900, 40.0000, 40.0000, '2026-03-03 20:11:20', '2026-03-03 20:11:20', NULL, '[]'),
(61, 'DUMMY', 61, '4796009862935', 61, NULL, 110.0000, 110.0000, 18.1800, 130.0000, 130.0000, '2026-03-03 20:14:13', '2026-03-03 20:14:13', NULL, '[]'),
(62, 'DUMMY', 62, '8906050366900', 62, NULL, 90.0000, 90.0000, 38.8900, 125.0000, 125.0000, '2026-03-03 20:15:37', '2026-03-03 20:15:37', NULL, '[]'),
(63, 'DUMMY', 63, '4796027900008', 63, NULL, 90.0000, 90.0000, 38.8900, 125.0000, 125.0000, '2026-03-03 20:16:46', '2026-03-03 20:17:39', NULL, '[]'),
(64, 'DUMMY', 64, '4796009867565', 64, NULL, 25.0000, 25.0000, 20.0000, 30.0000, 30.0000, '2026-03-03 20:18:59', '2026-03-03 20:18:59', NULL, '[]'),
(65, 'DUMMY', 65, '4796009867084', 65, NULL, 35.0000, 35.0000, 28.5700, 45.0000, 45.0000, '2026-03-03 20:20:18', '2026-03-03 20:21:36', NULL, '[]'),
(66, 'DUMMY', 66, '0066', 66, NULL, 500.0000, 500.0000, 40.0000, 700.0000, 700.0000, '2026-03-05 15:14:25', '2026-03-05 16:08:32', NULL, '[]'),
(67, 'DUMMY', 67, '0067', 67, NULL, 290.0000, 290.0000, 34.4800, 390.0000, 390.0000, '2026-03-14 16:36:57', '2026-03-14 16:36:57', NULL, '[]'),
(68, 'DUMMY', 68, '0068', 68, NULL, 40.0000, 40.0000, 50.0000, 60.0000, 60.0000, '2026-03-21 16:44:34', '2026-03-21 16:44:34', NULL, '[]'),
(69, 'DUMMY', 69, '0069', 69, NULL, 200.0000, 200.0000, 25.0000, 250.0000, 250.0000, '2026-03-22 14:05:43', '2026-03-22 14:05:43', NULL, '[]'),
(70, 'DUMMY', 70, '0070', 70, NULL, 500.0000, 500.0000, 25.0000, 625.0000, 625.0000, '2026-03-23 16:00:29', '2026-03-23 16:00:29', NULL, '[]'),
(71, 'DUMMY', 71, '0071', 71, NULL, 670.0000, 670.0000, 46.2700, 980.0000, 980.0000, '2026-03-27 12:44:12', '2026-03-27 14:31:16', NULL, '[]'),
(72, 'DUMMY', 72, '0072', 72, NULL, 690.0000, 690.0000, 52.1700, 1050.0000, 1050.0000, '2026-03-27 12:49:51', '2026-03-27 12:49:51', NULL, '[]'),
(73, 'DUMMY', 73, '0073', 73, NULL, 150.0000, 150.0000, 66.6700, 250.0000, 250.0000, '2026-03-27 12:52:15', '2026-03-27 12:52:15', NULL, '[]'),
(83, 'DUMMY', 83, '0083', 83, NULL, 90.0000, 90.0000, 100.0000, 180.0000, 180.0000, '2026-03-27 14:40:19', '2026-03-27 14:40:19', NULL, '[]'),
(84, 'DUMMY', 84, '0084', 84, NULL, 70.0000, 70.0000, 114.2900, 150.0000, 150.0000, '2026-03-27 14:43:58', '2026-03-27 14:43:58', NULL, '[]'),
(90, 'DUMMY', 90, '0090', 90, NULL, 195.0000, 195.0000, 51.2800, 295.0000, 295.0000, '2026-03-27 15:06:44', '2026-03-27 15:06:44', NULL, '[]'),
(92, 'DUMMY', 92, '0092', 92, NULL, 90.0000, 90.0000, 77.7800, 160.0000, 160.0000, '2026-03-27 15:09:26', '2026-03-27 15:09:26', NULL, '[]'),
(93, 'DUMMY', 93, '0093', 93, NULL, 135.0000, 135.0000, 44.4400, 195.0000, 195.0000, '2026-03-27 15:13:33', '2026-03-27 15:13:33', NULL, '[]'),
(94, 'DUMMY', 94, '0094', 94, NULL, 34.5000, 34.5000, 73.9100, 60.0000, 60.0000, '2026-03-27 15:22:36', '2026-03-27 15:22:36', NULL, '[]'),
(95, 'DUMMY', 95, '0095', 95, NULL, 21.0000, 21.0000, 66.6700, 35.0000, 35.0000, '2026-03-27 15:27:52', '2026-03-27 15:27:52', NULL, '[]'),
(96, 'DUMMY', 96, '0096', 96, NULL, 300.0000, 300.0000, 50.0000, 450.0000, 450.0000, '2026-03-27 15:40:56', '2026-03-27 15:40:56', NULL, '[]'),
(97, 'DUMMY', 97, '0097', 97, NULL, 32.5000, 32.5000, 115.3800, 70.0000, 70.0000, '2026-03-27 15:44:18', '2026-03-27 15:45:29', NULL, '[]'),
(98, 'DUMMY', 98, '0098', 98, NULL, 230.0000, 230.0000, 52.1700, 350.0000, 350.0000, '2026-03-27 15:49:03', '2026-03-27 15:49:03', NULL, '[]'),
(99, 'DUMMY', 99, '0099', 99, NULL, 380.0000, 380.0000, 52.6300, 580.0000, 580.0000, '2026-03-27 15:55:19', '2026-03-27 15:55:19', NULL, '[]'),
(100, 'DUMMY', 100, '0100', 100, NULL, 425.0000, 425.0000, 47.0600, 625.0000, 625.0000, '2026-03-27 16:44:57', '2026-03-27 16:44:57', NULL, '[]'),
(101, 'DUMMY', 101, '0101', 101, NULL, 185.0000, 185.0000, 54.0500, 285.0000, 285.0000, '2026-03-27 16:48:22', '2026-03-27 16:48:22', NULL, '[]'),
(102, 'DUMMY', 102, '0102', 102, NULL, 170.0000, 170.0000, 58.8200, 270.0000, 270.0000, '2026-03-27 16:49:43', '2026-03-27 16:49:43', NULL, '[]'),
(103, 'DUMMY', 103, '0103', 103, NULL, 220.0000, 220.0000, 45.4500, 320.0000, 320.0000, '2026-03-27 16:50:43', '2026-03-27 16:50:43', NULL, '[]'),
(104, 'DUMMY', 104, '0104', 104, NULL, 660.0000, 660.0000, 45.4500, 960.0000, 960.0000, '2026-03-27 16:52:16', '2026-03-27 16:52:16', NULL, '[]'),
(105, 'DUMMY', 105, '0105', 105, NULL, 195.0000, 195.0000, 58.9700, 310.0000, 310.0000, '2026-03-27 16:59:16', '2026-03-27 16:59:16', NULL, '[]'),
(106, 'DUMMY', 106, '0106', 106, NULL, 285.0000, 285.0000, 38.6000, 395.0000, 395.0000, '2026-03-27 17:02:20', '2026-03-27 17:02:20', NULL, '[]'),
(107, 'DUMMY', 107, '0107', 107, NULL, 75.0000, 75.0000, 100.0000, 150.0000, 150.0000, '2026-03-27 17:06:27', '2026-03-27 17:06:27', NULL, '[]'),
(108, 'DUMMY', 108, '0108', 108, NULL, 980.0000, 980.0000, 40.3100, 1375.0000, 1375.0000, '2026-03-27 17:08:00', '2026-03-27 17:08:00', NULL, '[]'),
(109, 'DUMMY', 109, '0109', 109, NULL, 190.0000, 190.0000, 52.6300, 290.0000, 290.0000, '2026-03-27 17:31:05', '2026-03-27 17:31:05', NULL, '[]'),
(110, 'DUMMY', 110, '0110', 110, NULL, 435.0000, 435.0000, 45.9800, 635.0000, 635.0000, '2026-03-27 17:32:40', '2026-03-27 17:32:40', NULL, '[]'),
(111, 'DUMMY', 111, '0111', 111, NULL, 540.0000, 540.0000, 44.4400, 780.0000, 780.0000, '2026-03-27 17:33:50', '2026-03-27 17:33:50', NULL, '[]'),
(112, 'DUMMY', 112, '0112', 112, NULL, 40.0000, 40.0000, 62.5000, 65.0000, 65.0000, '2026-03-27 17:38:03', '2026-03-27 17:38:03', NULL, '[]'),
(113, 'DUMMY', 113, '0113', 113, NULL, 120.0000, 120.0000, 50.0000, 180.0000, 180.0000, '2026-03-27 17:40:24', '2026-03-27 17:40:24', NULL, '[]'),
(114, 'DUMMY', 114, '0114', 114, NULL, 900.0000, 900.0000, 55.0000, 1395.0000, 1395.0000, '2026-03-28 08:40:36', '2026-03-28 08:41:52', NULL, '[]'),
(115, 'DUMMY', 115, '0115', 115, NULL, 740.0000, 740.0000, 48.6500, 1100.0000, 1100.0000, '2026-03-28 08:43:16', '2026-03-28 08:43:16', NULL, '[]'),
(116, 'DUMMY', 116, '0116', 116, NULL, 80.0000, 80.0000, 100.0000, 160.0000, 160.0000, '2026-03-28 08:45:16', '2026-03-28 08:45:16', NULL, '[]'),
(117, 'DUMMY', 117, '0117', 117, NULL, 2420.0000, 2420.0000, 48.7600, 3600.0000, 3600.0000, '2026-03-28 08:48:33', '2026-03-28 10:10:24', NULL, '[]'),
(118, 'DUMMY', 118, '0118', 118, NULL, 1930.0000, 1930.0000, 50.2600, 2900.0000, 2900.0000, '2026-03-28 08:50:03', '2026-03-28 08:50:03', NULL, '[]'),
(119, 'DUMMY', 119, '0119', 119, NULL, 2690.0000, 2690.0000, 41.2600, 3800.0000, 3800.0000, '2026-03-28 08:51:45', '2026-03-28 10:08:21', NULL, '[]'),
(120, 'DUMMY', 120, '0120', 120, NULL, 300.0000, 300.0000, 53.3300, 460.0000, 460.0000, '2026-03-28 09:18:29', '2026-03-28 09:18:29', NULL, '[]'),
(121, 'DUMMY', 121, '0121', 121, NULL, 1100.0000, 1100.0000, 31.8200, 1450.0000, 1450.0000, '2026-03-28 09:20:38', '2026-03-28 09:20:38', NULL, '[]'),
(122, 'DUMMY', 122, '0122', 122, NULL, 165.0000, 165.0000, 51.5200, 250.0000, 250.0000, '2026-03-28 09:23:11', '2026-03-28 09:23:11', NULL, '[]'),
(123, 'DUMMY', 123, '0123', 123, NULL, 180.0000, 180.0000, 61.1100, 290.0000, 290.0000, '2026-03-28 09:25:02', '2026-03-28 09:25:02', NULL, '[]'),
(124, 'DUMMY', 124, '0124', 124, NULL, 710.0000, 710.0000, 54.9300, 1100.0000, 1100.0000, '2026-03-28 09:29:12', '2026-03-28 09:29:12', NULL, '[]'),
(125, 'DUMMY', 125, '0125', 125, NULL, 115.0000, 115.0000, 43.4800, 165.0000, 165.0000, '2026-03-28 09:34:02', '2026-03-28 09:34:02', NULL, '[]'),
(126, 'DUMMY', 126, '0126', 126, NULL, 65.0000, 65.0000, 46.1500, 95.0000, 95.0000, '2026-03-28 09:36:47', '2026-03-28 09:36:47', NULL, '[]'),
(127, 'DUMMY', 127, '0127', 127, NULL, 20.0000, 20.0000, 100.0000, 40.0000, 40.0000, '2026-03-28 09:39:31', '2026-03-28 09:39:31', NULL, '[]'),
(128, 'DUMMY', 128, '0128', 128, NULL, 185.0000, 185.0000, 40.5400, 260.0000, 260.0000, '2026-03-28 09:48:22', '2026-03-28 09:48:22', NULL, '[]'),
(129, 'DUMMY', 129, '0129', 129, NULL, 50.0000, 50.0000, 60.0000, 80.0000, 80.0000, '2026-03-28 09:51:44', '2026-03-28 09:51:44', NULL, '[]'),
(130, 'DUMMY', 130, '0130', 130, NULL, 105.0000, 105.0000, 57.1400, 165.0000, 165.0000, '2026-03-28 10:04:56', '2026-03-28 10:04:56', NULL, '[]'),
(131, 'DUMMY', 131, '0131', 131, NULL, 270.0000, 270.0000, 42.5900, 385.0000, 385.0000, '2026-03-28 10:07:18', '2026-03-28 10:07:18', NULL, '[]'),
(132, 'DUMMY', 132, '0132', 132, NULL, 970.0000, 970.0000, 49.4800, 1450.0000, 1450.0000, '2026-03-28 10:09:11', '2026-03-28 10:09:11', NULL, '[]'),
(133, 'DUMMY', 133, '0133', 133, NULL, 430.0000, 430.0000, 46.5100, 630.0000, 630.0000, '2026-03-28 10:12:16', '2026-03-28 10:12:16', NULL, '[]'),
(134, 'DUMMY', 134, '0134', 134, NULL, 275.0000, 275.0000, 41.8200, 390.0000, 390.0000, '2026-03-28 10:13:41', '2026-03-28 10:13:41', NULL, '[]'),
(135, 'DUMMY', 135, '0135', 135, NULL, 75.0000, 75.0000, 60.0000, 120.0000, 120.0000, '2026-03-28 10:17:51', '2026-03-28 10:17:51', NULL, '[]'),
(136, 'DUMMY', 136, '0136', 136, NULL, 140.0000, 140.0000, 28.5700, 180.0000, 180.0000, '2026-03-28 10:22:14', '2026-03-28 10:22:14', NULL, '[]'),
(137, 'DUMMY', 137, '4797001116606', 137, NULL, 80.0000, 80.0000, 50.0000, 120.0000, 120.0000, '2026-03-28 10:26:15', '2026-03-28 10:26:15', NULL, '[]'),
(138, 'DUMMY', 138, '0138', 138, NULL, 660.0000, 660.0000, 45.4500, 960.0000, 960.0000, '2026-03-28 10:38:52', '2026-03-28 10:38:52', NULL, '[]'),
(139, 'DUMMY', 139, '0139', 139, NULL, 600.0000, 600.0000, 41.6700, 850.0000, 850.0000, '2026-03-28 10:43:01', '2026-03-28 10:43:01', NULL, '[]'),
(140, 'DUMMY', 140, '0140', 140, NULL, 540.0000, 540.0000, 77.7800, 960.0000, 960.0000, '2026-03-28 10:46:33', '2026-03-28 10:55:11', NULL, '[]'),
(141, 'DUMMY', 141, '0201020305', 141, NULL, 740.0000, 740.0000, 48.6500, 1100.0000, 1100.0000, '2026-03-28 10:51:27', '2026-03-28 10:51:27', NULL, '[]'),
(142, 'DUMMY', 142, '0142', 142, NULL, 21.0000, 21.0000, 66.6700, 35.0000, 35.0000, '2026-03-28 10:57:46', '2026-03-28 10:57:46', NULL, '[]'),
(143, 'DUMMY', 143, '0143', 143, NULL, 40.0000, 40.0000, 100.0000, 80.0000, 80.0000, '2026-03-28 11:00:17', '2026-03-28 11:00:17', NULL, '[]');

-- --------------------------------------------------------

--
-- Table structure for table `variation_group_prices`
--

CREATE TABLE `variation_group_prices` (
  `id` int(10) UNSIGNED NOT NULL,
  `variation_id` int(10) UNSIGNED NOT NULL,
  `price_group_id` int(10) UNSIGNED NOT NULL,
  `price_inc_tax` decimal(22,4) NOT NULL,
  `price_type` varchar(191) NOT NULL DEFAULT 'fixed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `variation_location_details`
--

CREATE TABLE `variation_location_details` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `product_variation_id` int(10) UNSIGNED NOT NULL COMMENT 'id from product_variations table',
  `variation_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  `qty_available` decimal(22,4) NOT NULL DEFAULT 0.0000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `variation_location_details`
--

INSERT INTO `variation_location_details` (`id`, `product_id`, `product_variation_id`, `variation_id`, `location_id`, `qty_available`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, 2.0000, '2026-02-20 12:00:10', '2026-02-20 15:29:10'),
(2, 2, 2, 2, 1, 0.0000, '2026-02-20 12:24:07', '2026-03-03 19:09:31'),
(3, 3, 3, 3, 1, 43.0000, '2026-02-20 13:28:51', '2026-02-20 15:29:10'),
(4, 5, 5, 5, 1, 0.0000, '2026-02-20 15:39:13', '2026-03-04 16:23:43'),
(5, 6, 6, 6, 1, 21.0000, '2026-02-20 15:42:51', '2026-02-20 15:42:51'),
(6, 7, 7, 7, 1, 22.0000, '2026-02-20 15:53:36', '2026-02-20 16:43:30'),
(7, 8, 8, 8, 1, 10.0000, '2026-02-20 16:10:30', '2026-02-20 16:10:30'),
(8, 9, 9, 9, 1, 4.0000, '2026-02-20 16:16:48', '2026-02-20 16:16:48'),
(9, 10, 10, 10, 1, 11.0000, '2026-02-20 16:23:06', '2026-02-20 16:23:06'),
(10, 11, 11, 11, 1, 0.0000, '2026-02-20 16:32:44', '2026-03-10 11:48:04'),
(11, 12, 12, 12, 1, 5.0000, '2026-02-20 16:40:04', '2026-02-20 16:40:04'),
(12, 13, 13, 13, 1, 9.0000, '2026-02-20 16:47:09', '2026-02-23 13:10:56'),
(13, 15, 15, 15, 1, 5.0000, '2026-02-20 17:03:14', '2026-02-20 17:03:14'),
(14, 16, 16, 16, 1, 37.0000, '2026-02-20 17:14:14', '2026-02-20 17:14:14'),
(15, 17, 17, 17, 1, 41.0000, '2026-02-20 17:20:22', '2026-02-20 17:20:22'),
(16, 18, 18, 18, 1, 22.0000, '2026-02-20 17:28:26', '2026-02-21 12:04:53'),
(17, 19, 19, 19, 1, 23.0000, '2026-02-20 17:37:39', '2026-02-20 17:37:39'),
(18, 20, 20, 20, 1, 79.0000, '2026-02-21 12:07:01', '2026-03-14 16:26:43'),
(19, 21, 21, 21, 1, 2.0000, '2026-03-01 17:37:43', '2026-03-01 18:06:33'),
(20, 22, 22, 22, 1, 9.0000, '2026-03-03 19:17:28', '2026-03-03 19:17:28'),
(21, 23, 23, 23, 1, 4.0000, '2026-03-03 19:22:07', '2026-03-03 19:22:07'),
(22, 24, 24, 24, 1, 7.0000, '2026-03-03 19:23:34', '2026-03-03 19:23:34'),
(23, 25, 25, 25, 1, 4.0000, '2026-03-03 19:24:53', '2026-03-03 19:24:53'),
(24, 26, 26, 26, 1, 10.0000, '2026-03-03 19:26:54', '2026-03-03 19:26:54'),
(25, 27, 27, 27, 1, 9.0000, '2026-03-03 19:28:41', '2026-03-03 19:28:41'),
(26, 28, 28, 28, 1, 9.0000, '2026-03-03 19:30:18', '2026-03-03 19:30:18'),
(27, 29, 29, 29, 1, 4.0000, '2026-03-03 19:31:13', '2026-03-03 19:31:13'),
(28, 30, 30, 30, 1, 27.0000, '2026-03-03 19:32:56', '2026-03-03 19:32:56'),
(29, 31, 31, 31, 1, 14.0000, '2026-03-03 19:35:19', '2026-03-03 19:35:19'),
(30, 32, 32, 32, 1, 5.0000, '2026-03-03 19:36:52', '2026-03-03 19:36:52'),
(31, 33, 33, 33, 1, 18.0000, '2026-03-03 19:37:51', '2026-03-03 19:37:51'),
(32, 34, 34, 34, 1, 3.0000, '2026-03-03 19:38:33', '2026-03-03 19:38:33'),
(33, 35, 35, 35, 1, 2.0000, '2026-03-03 19:39:19', '2026-03-03 19:39:19'),
(34, 36, 36, 36, 1, 9.0000, '2026-03-03 19:40:25', '2026-03-03 19:40:25'),
(35, 37, 37, 37, 1, 8.0000, '2026-03-03 19:41:32', '2026-03-03 19:41:32'),
(36, 38, 38, 38, 1, 4.0000, '2026-03-03 19:43:11', '2026-03-03 19:43:11'),
(37, 39, 39, 39, 1, 7.0000, '2026-03-03 19:45:26', '2026-03-03 19:45:26'),
(38, 40, 40, 40, 1, 4.0000, '2026-03-03 19:46:16', '2026-03-03 19:46:16'),
(39, 41, 41, 41, 1, 20.0000, '2026-03-03 19:47:11', '2026-03-10 11:48:04'),
(40, 42, 42, 42, 1, 35.0000, '2026-03-03 19:49:57', '2026-03-03 19:49:57'),
(41, 43, 43, 43, 1, 22.0000, '2026-03-03 19:50:47', '2026-03-03 19:50:47'),
(42, 44, 44, 44, 1, 14.0000, '2026-03-03 19:51:59', '2026-03-03 19:51:59'),
(43, 45, 45, 45, 1, 16.0000, '2026-03-03 19:53:04', '2026-03-03 19:53:04'),
(44, 46, 46, 46, 1, 5.0000, '2026-03-03 19:54:15', '2026-03-03 19:54:15'),
(45, 47, 47, 47, 1, 12.0000, '2026-03-03 19:55:07', '2026-03-03 19:55:07'),
(46, 48, 48, 48, 1, 16.0000, '2026-03-03 19:56:21', '2026-03-03 19:56:21'),
(47, 49, 49, 49, 1, 6.0000, '2026-03-03 19:57:26', '2026-03-03 19:57:26'),
(48, 50, 50, 50, 1, 12.0000, '2026-03-03 19:58:29', '2026-03-03 19:58:29'),
(49, 51, 51, 51, 1, 4.0000, '2026-03-03 19:59:41', '2026-03-03 19:59:41'),
(50, 52, 52, 52, 1, 3.0000, '2026-03-03 20:00:36', '2026-03-03 20:00:36'),
(51, 53, 53, 53, 1, 6.0000, '2026-03-03 20:01:20', '2026-03-03 20:01:20'),
(52, 54, 54, 54, 1, 18.0000, '2026-03-03 20:02:26', '2026-03-03 20:02:26'),
(53, 55, 55, 55, 1, 5.0000, '2026-03-03 20:03:29', '2026-03-03 20:03:29'),
(54, 56, 56, 56, 1, 4.0000, '2026-03-03 20:04:29', '2026-03-03 20:04:29'),
(55, 57, 57, 57, 1, 7.0000, '2026-03-03 20:08:01', '2026-03-03 20:08:01'),
(56, 58, 58, 58, 1, 5.0000, '2026-03-03 20:09:08', '2026-03-03 20:09:08'),
(57, 59, 59, 59, 1, 6.0000, '2026-03-03 20:10:22', '2026-03-03 20:10:22'),
(58, 60, 60, 60, 1, 17.0000, '2026-03-03 20:11:25', '2026-03-03 20:11:25'),
(59, 61, 61, 61, 1, 21.0000, '2026-03-03 20:14:18', '2026-03-03 20:14:18'),
(60, 62, 62, 62, 1, 12.0000, '2026-03-03 20:15:41', '2026-03-03 20:15:41'),
(61, 63, 63, 63, 1, 35.0000, '2026-03-03 20:17:03', '2026-03-03 20:17:03'),
(62, 64, 64, 64, 1, 15.0000, '2026-03-03 20:19:04', '2026-03-03 20:19:04'),
(63, 65, 65, 65, 1, 13.0000, '2026-03-03 20:20:38', '2026-03-03 20:20:38'),
(64, 66, 66, 66, 1, 50.0000, '2026-03-05 15:40:04', '2026-03-05 16:08:32'),
(65, 68, 68, 68, 1, 36.0000, '2026-03-21 16:45:07', '2026-03-21 16:45:07'),
(67, 71, 71, 71, 1, 11.0000, '2026-03-27 14:31:16', '2026-03-27 14:31:16'),
(68, 83, 83, 83, 1, 50.0000, '2026-03-27 14:40:19', '2026-03-27 14:40:19'),
(69, 84, 84, 84, 1, 50.0000, '2026-03-27 14:43:58', '2026-03-27 14:43:58'),
(75, 90, 90, 90, 1, 10.0000, '2026-03-27 15:06:44', '2026-03-27 15:06:44'),
(77, 92, 92, 92, 1, 12.0000, '2026-03-27 15:09:26', '2026-03-27 15:09:26'),
(78, 93, 93, 93, 1, 12.0000, '2026-03-27 15:13:33', '2026-03-27 15:13:33'),
(79, 94, 94, 94, 1, 48.0000, '2026-03-27 15:22:36', '2026-03-27 15:22:36'),
(80, 95, 95, 95, 1, 100.0000, '2026-03-27 15:27:52', '2026-03-27 15:27:52'),
(81, 96, 96, 96, 1, 11.0000, '2026-03-27 15:40:56', '2026-03-27 17:27:34'),
(82, 97, 97, 97, 1, 25.0000, '2026-03-27 15:44:18', '2026-03-27 15:44:18'),
(83, 98, 98, 98, 1, 10.0000, '2026-03-27 15:49:03', '2026-03-27 15:49:03'),
(84, 99, 99, 99, 1, 10.0000, '2026-03-27 15:55:19', '2026-03-27 15:55:19'),
(85, 100, 100, 100, 1, 10.0000, '2026-03-27 16:44:57', '2026-03-27 16:44:57'),
(86, 101, 101, 101, 1, 10.0000, '2026-03-27 16:48:22', '2026-03-27 16:48:22'),
(87, 102, 102, 102, 1, 6.0000, '2026-03-27 16:49:43', '2026-03-27 16:49:43'),
(88, 103, 103, 103, 1, 10.0000, '2026-03-27 16:50:43', '2026-03-27 16:50:43'),
(89, 104, 104, 104, 1, 6.0000, '2026-03-27 16:52:16', '2026-03-27 16:52:16'),
(90, 105, 105, 105, 1, 10.0000, '2026-03-27 16:59:16', '2026-03-27 16:59:16'),
(91, 106, 106, 106, 1, 10.0000, '2026-03-27 17:02:20', '2026-03-27 17:02:20'),
(92, 107, 107, 107, 1, 20.0000, '2026-03-27 17:06:27', '2026-03-27 17:06:27'),
(93, 108, 108, 108, 1, 6.0000, '2026-03-27 17:08:00', '2026-03-27 17:08:00'),
(94, 109, 109, 109, 1, 6.0000, '2026-03-27 17:31:05', '2026-03-27 17:31:05'),
(95, 110, 110, 110, 1, 6.0000, '2026-03-27 17:32:40', '2026-03-27 17:32:40'),
(96, 111, 111, 111, 1, 6.0000, '2026-03-27 17:33:50', '2026-03-27 17:33:50'),
(97, 112, 112, 112, 1, 12.0000, '2026-03-27 17:38:03', '2026-03-27 17:38:03'),
(98, 113, 113, 113, 1, 24.0000, '2026-03-27 17:40:24', '2026-03-27 17:40:24'),
(99, 114, 114, 114, 1, 10.0000, '2026-03-28 08:40:36', '2026-03-28 08:40:36'),
(100, 115, 115, 115, 1, 10.0000, '2026-03-28 08:43:16', '2026-03-28 08:43:16'),
(101, 116, 116, 116, 1, 24.0000, '2026-03-28 08:45:16', '2026-03-28 08:45:16'),
(102, 117, 117, 117, 1, 2.0000, '2026-03-28 08:48:33', '2026-03-28 10:10:24'),
(103, 118, 118, 118, 1, 5.0000, '2026-03-28 08:50:03', '2026-03-28 08:50:03'),
(104, 119, 119, 119, 1, 1.0000, '2026-03-28 08:51:45', '2026-03-28 10:08:21'),
(105, 120, 120, 120, 1, 10.0000, '2026-03-28 09:18:29', '2026-03-28 09:18:29'),
(106, 121, 121, 121, 1, 2.0000, '2026-03-28 09:20:38', '2026-03-28 09:20:38'),
(107, 122, 122, 122, 1, 12.0000, '2026-03-28 09:23:11', '2026-03-28 09:23:11'),
(108, 123, 123, 123, 1, 4.0000, '2026-03-28 09:25:02', '2026-03-28 09:25:02'),
(109, 124, 124, 124, 1, 8.0000, '2026-03-28 09:29:12', '2026-03-28 09:29:12'),
(110, 125, 125, 125, 1, 12.0000, '2026-03-28 09:34:02', '2026-03-28 09:34:02'),
(111, 126, 126, 126, 1, 60.0000, '2026-03-28 09:36:47', '2026-03-28 09:36:47'),
(112, 127, 127, 127, 1, 50.0000, '2026-03-28 09:39:31', '2026-03-28 09:39:31'),
(113, 128, 128, 128, 1, 12.0000, '2026-03-28 09:48:22', '2026-03-28 09:48:22'),
(114, 129, 129, 129, 1, 24.0000, '2026-03-28 09:51:44', '2026-03-28 09:51:44'),
(115, 130, 130, 130, 1, 24.0000, '2026-03-28 10:04:56', '2026-03-28 10:04:56'),
(116, 131, 131, 131, 1, 12.0000, '2026-03-28 10:07:18', '2026-03-28 10:07:18'),
(117, 132, 132, 132, 1, 6.0000, '2026-03-28 10:09:11', '2026-03-28 10:09:11'),
(118, 133, 133, 133, 1, 15.0000, '2026-03-28 10:12:16', '2026-03-28 10:12:16'),
(119, 134, 134, 134, 1, 12.0000, '2026-03-28 10:13:41', '2026-03-28 10:13:41'),
(120, 135, 135, 135, 1, 40.0000, '2026-03-28 10:17:51', '2026-03-28 10:17:51'),
(121, 136, 136, 136, 1, 36.0000, '2026-03-28 10:22:14', '2026-03-28 10:22:14'),
(122, 137, 137, 137, 1, 6.0000, '2026-03-28 10:26:15', '2026-03-28 10:26:15'),
(123, 138, 138, 138, 1, 10.0000, '2026-03-28 10:38:52', '2026-03-28 10:38:52'),
(124, 139, 139, 139, 1, 10.0000, '2026-03-28 10:43:01', '2026-03-28 10:43:01'),
(125, 140, 140, 140, 1, 10.0000, '2026-03-28 10:46:33', '2026-03-28 10:46:33'),
(126, 141, 141, 141, 1, 10.0000, '2026-03-28 10:51:27', '2026-03-28 10:51:27'),
(127, 142, 142, 142, 1, 100.0000, '2026-03-28 10:57:46', '2026-03-28 10:57:46'),
(128, 143, 143, 143, 1, 50.0000, '2026-03-28 11:00:17', '2026-03-28 11:00:17');

-- --------------------------------------------------------

--
-- Table structure for table `variation_templates`
--

CREATE TABLE `variation_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `business_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `variation_value_templates`
--

CREATE TABLE `variation_value_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `variation_template_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `warranties`
--

CREATE TABLE `warranties` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `business_id` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `duration_type` enum('days','months','years') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `accounts_business_id_index` (`business_id`),
  ADD KEY `accounts_account_type_id_index` (`account_type_id`),
  ADD KEY `accounts_created_by_index` (`created_by`);

--
-- Indexes for table `account_transactions`
--
ALTER TABLE `account_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_transactions_account_id_index` (`account_id`),
  ADD KEY `account_transactions_transaction_id_index` (`transaction_id`),
  ADD KEY `account_transactions_transaction_payment_id_index` (`transaction_payment_id`),
  ADD KEY `account_transactions_transfer_transaction_id_index` (`transfer_transaction_id`),
  ADD KEY `account_transactions_created_by_index` (`created_by`),
  ADD KEY `account_transactions_type_index` (`type`),
  ADD KEY `account_transactions_sub_type_index` (`sub_type`),
  ADD KEY `account_transactions_operation_date_index` (`operation_date`);

--
-- Indexes for table `account_types`
--
ALTER TABLE `account_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_types_parent_account_type_id_index` (`parent_account_type_id`),
  ADD KEY `account_types_business_id_index` (`business_id`);

--
-- Indexes for table `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activity_log_log_name_index` (`log_name`);

--
-- Indexes for table `barcodes`
--
ALTER TABLE `barcodes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `barcodes_business_id_foreign` (`business_id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_contact_id_foreign` (`contact_id`),
  ADD KEY `bookings_business_id_foreign` (`business_id`),
  ADD KEY `bookings_created_by_foreign` (`created_by`),
  ADD KEY `bookings_table_id_index` (`table_id`),
  ADD KEY `bookings_waiter_id_index` (`waiter_id`),
  ADD KEY `bookings_location_id_index` (`location_id`),
  ADD KEY `bookings_booking_status_index` (`booking_status`),
  ADD KEY `bookings_correspondent_id_index` (`correspondent_id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`),
  ADD KEY `brands_business_id_foreign` (`business_id`),
  ADD KEY `brands_created_by_foreign` (`created_by`);

--
-- Indexes for table `business`
--
ALTER TABLE `business`
  ADD PRIMARY KEY (`id`),
  ADD KEY `business_owner_id_foreign` (`owner_id`),
  ADD KEY `business_currency_id_foreign` (`currency_id`),
  ADD KEY `business_default_sales_tax_foreign` (`default_sales_tax`);

--
-- Indexes for table `business_locations`
--
ALTER TABLE `business_locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `business_locations_business_id_index` (`business_id`),
  ADD KEY `business_locations_invoice_scheme_id_foreign` (`invoice_scheme_id`),
  ADD KEY `business_locations_invoice_layout_id_foreign` (`invoice_layout_id`),
  ADD KEY `business_locations_sale_invoice_layout_id_index` (`sale_invoice_layout_id`),
  ADD KEY `business_locations_selling_price_group_id_index` (`selling_price_group_id`),
  ADD KEY `business_locations_receipt_printer_type_index` (`receipt_printer_type`),
  ADD KEY `business_locations_printer_id_index` (`printer_id`);

--
-- Indexes for table `cash_denominations`
--
ALTER TABLE `cash_denominations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cash_denominations_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indexes for table `cash_registers`
--
ALTER TABLE `cash_registers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cash_registers_business_id_foreign` (`business_id`),
  ADD KEY `cash_registers_user_id_foreign` (`user_id`),
  ADD KEY `cash_registers_location_id_index` (`location_id`);

--
-- Indexes for table `cash_register_transactions`
--
ALTER TABLE `cash_register_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cash_register_transactions_cash_register_id_foreign` (`cash_register_id`),
  ADD KEY `cash_register_transactions_transaction_id_index` (`transaction_id`),
  ADD KEY `cash_register_transactions_type_index` (`type`),
  ADD KEY `cash_register_transactions_transaction_type_index` (`transaction_type`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_business_id_foreign` (`business_id`),
  ADD KEY `categories_created_by_foreign` (`created_by`),
  ADD KEY `categories_parent_id_index` (`parent_id`);

--
-- Indexes for table `categorizables`
--
ALTER TABLE `categorizables`
  ADD KEY `categorizables_categorizable_type_categorizable_id_index` (`categorizable_type`,`categorizable_id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contacts_business_id_foreign` (`business_id`),
  ADD KEY `contacts_created_by_foreign` (`created_by`),
  ADD KEY `contacts_type_index` (`type`),
  ADD KEY `contacts_contact_status_index` (`contact_status`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_groups`
--
ALTER TABLE `customer_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_groups_business_id_foreign` (`business_id`),
  ADD KEY `customer_groups_created_by_index` (`created_by`),
  ADD KEY `customer_groups_price_calculation_type_index` (`price_calculation_type`),
  ADD KEY `customer_groups_selling_price_group_id_index` (`selling_price_group_id`);

--
-- Indexes for table `dashboard_configurations`
--
ALTER TABLE `dashboard_configurations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dashboard_configurations_business_id_foreign` (`business_id`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `discounts_business_id_index` (`business_id`),
  ADD KEY `discounts_brand_id_index` (`brand_id`),
  ADD KEY `discounts_category_id_index` (`category_id`),
  ADD KEY `discounts_location_id_index` (`location_id`),
  ADD KEY `discounts_priority_index` (`priority`),
  ADD KEY `discounts_spg_index` (`spg`);

--
-- Indexes for table `discount_variations`
--
ALTER TABLE `discount_variations`
  ADD KEY `discount_variations_discount_id_index` (`discount_id`),
  ADD KEY `discount_variations_variation_id_index` (`variation_id`);

--
-- Indexes for table `document_and_notes`
--
ALTER TABLE `document_and_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `document_and_notes_business_id_index` (`business_id`),
  ADD KEY `document_and_notes_notable_id_index` (`notable_id`),
  ADD KEY `document_and_notes_created_by_index` (`created_by`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expense_categories_business_id_foreign` (`business_id`);

--
-- Indexes for table `group_sub_taxes`
--
ALTER TABLE `group_sub_taxes`
  ADD KEY `group_sub_taxes_group_tax_id_foreign` (`group_tax_id`),
  ADD KEY `group_sub_taxes_tax_id_foreign` (`tax_id`);

--
-- Indexes for table `invoice_layouts`
--
ALTER TABLE `invoice_layouts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_layouts_business_id_foreign` (`business_id`);

--
-- Indexes for table `invoice_schemes`
--
ALTER TABLE `invoice_schemes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_schemes_business_id_foreign` (`business_id`),
  ADD KEY `invoice_schemes_scheme_type_index` (`scheme_type`),
  ADD KEY `invoice_schemes_number_type_index` (`number_type`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  ADD KEY `media_business_id_index` (`business_id`),
  ADD KEY `media_uploaded_by_index` (`uploaded_by`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `notification_templates`
--
ALTER TABLE `notification_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `printers`
--
ALTER TABLE `printers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `printers_business_id_foreign` (`business_id`);

--
-- Indexes for table `print_jobs`
--
ALTER TABLE `print_jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `print_jobs_business_id_index` (`business_id`),
  ADD KEY `print_jobs_created_by_index` (`created_by`),
  ADD KEY `print_jobs_type_index` (`type`),
  ADD KEY `print_jobs_status_index` (`status`),
  ADD KEY `print_jobs_station_id_index` (`station_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_brand_id_foreign` (`brand_id`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_sub_category_id_foreign` (`sub_category_id`),
  ADD KEY `products_tax_foreign` (`tax`),
  ADD KEY `products_name_index` (`name`),
  ADD KEY `products_business_id_index` (`business_id`),
  ADD KEY `products_unit_id_index` (`unit_id`),
  ADD KEY `products_created_by_index` (`created_by`),
  ADD KEY `products_warranty_id_index` (`warranty_id`),
  ADD KEY `products_type_index` (`type`),
  ADD KEY `products_tax_type_index` (`tax_type`),
  ADD KEY `products_barcode_type_index` (`barcode_type`),
  ADD KEY `products_secondary_unit_id_index` (`secondary_unit_id`),
  ADD KEY `products_sku_index` (`sku`);

--
-- Indexes for table `product_locations`
--
ALTER TABLE `product_locations`
  ADD KEY `product_locations_product_id_index` (`product_id`),
  ADD KEY `product_locations_location_id_index` (`location_id`);

--
-- Indexes for table `product_racks`
--
ALTER TABLE `product_racks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_racks_business_id_index` (`business_id`),
  ADD KEY `product_racks_location_id_index` (`location_id`),
  ADD KEY `product_racks_product_id_index` (`product_id`);

--
-- Indexes for table `product_variations`
--
ALTER TABLE `product_variations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_variations_name_index` (`name`),
  ADD KEY `product_variations_product_id_index` (`product_id`);

--
-- Indexes for table `purchase_lines`
--
ALTER TABLE `purchase_lines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_lines_transaction_id_foreign` (`transaction_id`),
  ADD KEY `purchase_lines_product_id_foreign` (`product_id`),
  ADD KEY `purchase_lines_variation_id_foreign` (`variation_id`),
  ADD KEY `purchase_lines_tax_id_foreign` (`tax_id`),
  ADD KEY `purchase_lines_sub_unit_id_index` (`sub_unit_id`),
  ADD KEY `purchase_lines_lot_number_index` (`lot_number`);

--
-- Indexes for table `reference_counts`
--
ALTER TABLE `reference_counts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reference_counts_business_id_index` (`business_id`);

--
-- Indexes for table `res_product_modifier_sets`
--
ALTER TABLE `res_product_modifier_sets`
  ADD KEY `res_product_modifier_sets_modifier_set_id_foreign` (`modifier_set_id`);

--
-- Indexes for table `res_tables`
--
ALTER TABLE `res_tables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `res_tables_business_id_foreign` (`business_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `roles_business_id_foreign` (`business_id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `selling_price_groups`
--
ALTER TABLE `selling_price_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `selling_price_groups_business_id_foreign` (`business_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD UNIQUE KEY `sessions_id_unique` (`id`);

--
-- Indexes for table `stock_adjustment_lines`
--
ALTER TABLE `stock_adjustment_lines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stock_adjustment_lines_product_id_foreign` (`product_id`),
  ADD KEY `stock_adjustment_lines_variation_id_foreign` (`variation_id`),
  ADD KEY `stock_adjustment_lines_transaction_id_index` (`transaction_id`),
  ADD KEY `stock_adjustment_lines_lot_no_line_id_index` (`lot_no_line_id`);

--
-- Indexes for table `system`
--
ALTER TABLE `system`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tax_rates`
--
ALTER TABLE `tax_rates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tax_rates_business_id_foreign` (`business_id`),
  ADD KEY `tax_rates_created_by_foreign` (`created_by`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_tax_id_foreign` (`tax_id`),
  ADD KEY `transactions_business_id_index` (`business_id`),
  ADD KEY `transactions_type_index` (`type`),
  ADD KEY `transactions_contact_id_index` (`contact_id`),
  ADD KEY `transactions_transaction_date_index` (`transaction_date`),
  ADD KEY `transactions_created_by_index` (`created_by`),
  ADD KEY `transactions_location_id_index` (`location_id`),
  ADD KEY `transactions_expense_for_foreign` (`expense_for`),
  ADD KEY `transactions_expense_category_id_index` (`expense_category_id`),
  ADD KEY `transactions_sub_type_index` (`sub_type`),
  ADD KEY `transactions_return_parent_id_index` (`return_parent_id`),
  ADD KEY `type` (`type`),
  ADD KEY `transactions_status_index` (`status`),
  ADD KEY `transactions_sub_status_index` (`sub_status`),
  ADD KEY `transactions_res_table_id_index` (`res_table_id`),
  ADD KEY `transactions_res_waiter_id_index` (`res_waiter_id`),
  ADD KEY `transactions_res_order_status_index` (`res_order_status`),
  ADD KEY `transactions_payment_status_index` (`payment_status`),
  ADD KEY `transactions_discount_type_index` (`discount_type`),
  ADD KEY `transactions_commission_agent_index` (`commission_agent`),
  ADD KEY `transactions_transfer_parent_id_index` (`transfer_parent_id`),
  ADD KEY `transactions_types_of_service_id_index` (`types_of_service_id`),
  ADD KEY `transactions_packing_charge_type_index` (`packing_charge_type`),
  ADD KEY `transactions_recur_parent_id_index` (`recur_parent_id`),
  ADD KEY `transactions_selling_price_group_id_index` (`selling_price_group_id`),
  ADD KEY `transactions_delivery_date_index` (`delivery_date`),
  ADD KEY `transactions_delivery_person_index` (`delivery_person`);

--
-- Indexes for table `transaction_payments`
--
ALTER TABLE `transaction_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_payments_transaction_id_foreign` (`transaction_id`),
  ADD KEY `transaction_payments_created_by_index` (`created_by`),
  ADD KEY `transaction_payments_parent_id_index` (`parent_id`),
  ADD KEY `transaction_payments_payment_type_index` (`payment_type`);

--
-- Indexes for table `transaction_sell_lines`
--
ALTER TABLE `transaction_sell_lines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_sell_lines_transaction_id_foreign` (`transaction_id`),
  ADD KEY `transaction_sell_lines_product_id_foreign` (`product_id`),
  ADD KEY `transaction_sell_lines_variation_id_foreign` (`variation_id`),
  ADD KEY `transaction_sell_lines_tax_id_foreign` (`tax_id`),
  ADD KEY `transaction_sell_lines_children_type_index` (`children_type`),
  ADD KEY `transaction_sell_lines_parent_sell_line_id_index` (`parent_sell_line_id`),
  ADD KEY `transaction_sell_lines_line_discount_type_index` (`line_discount_type`),
  ADD KEY `transaction_sell_lines_discount_id_index` (`discount_id`),
  ADD KEY `transaction_sell_lines_lot_no_line_id_index` (`lot_no_line_id`),
  ADD KEY `transaction_sell_lines_sub_unit_id_index` (`sub_unit_id`);

--
-- Indexes for table `transaction_sell_lines_purchase_lines`
--
ALTER TABLE `transaction_sell_lines_purchase_lines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sell_line_id` (`sell_line_id`),
  ADD KEY `stock_adjustment_line_id` (`stock_adjustment_line_id`),
  ADD KEY `purchase_line_id` (`purchase_line_id`);

--
-- Indexes for table `types_of_services`
--
ALTER TABLE `types_of_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `types_of_services_business_id_index` (`business_id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`),
  ADD KEY `units_business_id_foreign` (`business_id`),
  ADD KEY `units_created_by_foreign` (`created_by`),
  ADD KEY `units_base_unit_id_index` (`base_unit_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD KEY `users_business_id_foreign` (`business_id`),
  ADD KEY `users_user_type_index` (`user_type`),
  ADD KEY `users_crm_contact_id_foreign` (`crm_contact_id`);

--
-- Indexes for table `user_contact_access`
--
ALTER TABLE `user_contact_access`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_contact_access_user_id_index` (`user_id`),
  ADD KEY `user_contact_access_contact_id_index` (`contact_id`);

--
-- Indexes for table `variations`
--
ALTER TABLE `variations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variations_product_id_foreign` (`product_id`),
  ADD KEY `variations_product_variation_id_foreign` (`product_variation_id`),
  ADD KEY `variations_name_index` (`name`),
  ADD KEY `variations_sub_sku_index` (`sub_sku`),
  ADD KEY `variations_variation_value_id_index` (`variation_value_id`);

--
-- Indexes for table `variation_group_prices`
--
ALTER TABLE `variation_group_prices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variation_group_prices_variation_id_foreign` (`variation_id`),
  ADD KEY `variation_group_prices_price_group_id_foreign` (`price_group_id`);

--
-- Indexes for table `variation_location_details`
--
ALTER TABLE `variation_location_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variation_location_details_location_id_foreign` (`location_id`),
  ADD KEY `variation_location_details_product_id_index` (`product_id`),
  ADD KEY `variation_location_details_product_variation_id_index` (`product_variation_id`),
  ADD KEY `variation_location_details_variation_id_index` (`variation_id`);

--
-- Indexes for table `variation_templates`
--
ALTER TABLE `variation_templates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variation_templates_business_id_foreign` (`business_id`);

--
-- Indexes for table `variation_value_templates`
--
ALTER TABLE `variation_value_templates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variation_value_templates_name_index` (`name`),
  ADD KEY `variation_value_templates_variation_template_id_index` (`variation_template_id`);

--
-- Indexes for table `warranties`
--
ALTER TABLE `warranties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warranties_business_id_index` (`business_id`),
  ADD KEY `warranties_duration_type_index` (`duration_type`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `account_transactions`
--
ALTER TABLE `account_transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `account_types`
--
ALTER TABLE `account_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT for table `barcodes`
--
ALTER TABLE `barcodes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `business`
--
ALTER TABLE `business`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `business_locations`
--
ALTER TABLE `business_locations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cash_denominations`
--
ALTER TABLE `cash_denominations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cash_registers`
--
ALTER TABLE `cash_registers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cash_register_transactions`
--
ALTER TABLE `cash_register_transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;

--
-- AUTO_INCREMENT for table `customer_groups`
--
ALTER TABLE `customer_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dashboard_configurations`
--
ALTER TABLE `dashboard_configurations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document_and_notes`
--
ALTER TABLE `document_and_notes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_layouts`
--
ALTER TABLE `invoice_layouts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `invoice_schemes`
--
ALTER TABLE `invoice_schemes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=304;

--
-- AUTO_INCREMENT for table `notification_templates`
--
ALTER TABLE `notification_templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `printers`
--
ALTER TABLE `printers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `print_jobs`
--
ALTER TABLE `print_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;

--
-- AUTO_INCREMENT for table `product_racks`
--
ALTER TABLE `product_racks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_variations`
--
ALTER TABLE `product_variations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;

--
-- AUTO_INCREMENT for table `purchase_lines`
--
ALTER TABLE `purchase_lines`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT for table `reference_counts`
--
ALTER TABLE `reference_counts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `res_tables`
--
ALTER TABLE `res_tables`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `selling_price_groups`
--
ALTER TABLE `selling_price_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_adjustment_lines`
--
ALTER TABLE `stock_adjustment_lines`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `system`
--
ALTER TABLE `system`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tax_rates`
--
ALTER TABLE `tax_rates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=164;

--
-- AUTO_INCREMENT for table `transaction_payments`
--
ALTER TABLE `transaction_payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `transaction_sell_lines`
--
ALTER TABLE `transaction_sell_lines`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `transaction_sell_lines_purchase_lines`
--
ALTER TABLE `transaction_sell_lines_purchase_lines`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `types_of_services`
--
ALTER TABLE `types_of_services`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_contact_access`
--
ALTER TABLE `user_contact_access`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `variations`
--
ALTER TABLE `variations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;

--
-- AUTO_INCREMENT for table `variation_group_prices`
--
ALTER TABLE `variation_group_prices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `variation_location_details`
--
ALTER TABLE `variation_location_details`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT for table `variation_templates`
--
ALTER TABLE `variation_templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `variation_value_templates`
--
ALTER TABLE `variation_value_templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `warranties`
--
ALTER TABLE `warranties`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `barcodes`
--
ALTER TABLE `barcodes`
  ADD CONSTRAINT `barcodes_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `brands`
--
ALTER TABLE `brands`
  ADD CONSTRAINT `brands_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `brands_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `business`
--
ALTER TABLE `business`
  ADD CONSTRAINT `business_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  ADD CONSTRAINT `business_default_sales_tax_foreign` FOREIGN KEY (`default_sales_tax`) REFERENCES `tax_rates` (`id`),
  ADD CONSTRAINT `business_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `business_locations`
--
ALTER TABLE `business_locations`
  ADD CONSTRAINT `business_locations_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `business_locations_invoice_layout_id_foreign` FOREIGN KEY (`invoice_layout_id`) REFERENCES `invoice_layouts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `business_locations_invoice_scheme_id_foreign` FOREIGN KEY (`invoice_scheme_id`) REFERENCES `invoice_schemes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cash_registers`
--
ALTER TABLE `cash_registers`
  ADD CONSTRAINT `cash_registers_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cash_registers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cash_register_transactions`
--
ALTER TABLE `cash_register_transactions`
  ADD CONSTRAINT `cash_register_transactions_cash_register_id_foreign` FOREIGN KEY (`cash_register_id`) REFERENCES `cash_registers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `categories_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `contacts`
--
ALTER TABLE `contacts`
  ADD CONSTRAINT `contacts_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `contacts_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `customer_groups`
--
ALTER TABLE `customer_groups`
  ADD CONSTRAINT `customer_groups_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dashboard_configurations`
--
ALTER TABLE `dashboard_configurations`
  ADD CONSTRAINT `dashboard_configurations_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD CONSTRAINT `expense_categories_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `group_sub_taxes`
--
ALTER TABLE `group_sub_taxes`
  ADD CONSTRAINT `group_sub_taxes_group_tax_id_foreign` FOREIGN KEY (`group_tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `group_sub_taxes_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `invoice_layouts`
--
ALTER TABLE `invoice_layouts`
  ADD CONSTRAINT `invoice_layouts_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `invoice_schemes`
--
ALTER TABLE `invoice_schemes`
  ADD CONSTRAINT `invoice_schemes_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `printers`
--
ALTER TABLE `printers`
  ADD CONSTRAINT `printers_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_tax_foreign` FOREIGN KEY (`tax`) REFERENCES `tax_rates` (`id`),
  ADD CONSTRAINT `products_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_variations`
--
ALTER TABLE `product_variations`
  ADD CONSTRAINT `product_variations_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchase_lines`
--
ALTER TABLE `purchase_lines`
  ADD CONSTRAINT `purchase_lines_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_lines_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_lines_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_lines_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `res_product_modifier_sets`
--
ALTER TABLE `res_product_modifier_sets`
  ADD CONSTRAINT `res_product_modifier_sets_modifier_set_id_foreign` FOREIGN KEY (`modifier_set_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `res_tables`
--
ALTER TABLE `res_tables`
  ADD CONSTRAINT `res_tables_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `roles`
--
ALTER TABLE `roles`
  ADD CONSTRAINT `roles_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `selling_price_groups`
--
ALTER TABLE `selling_price_groups`
  ADD CONSTRAINT `selling_price_groups_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `stock_adjustment_lines`
--
ALTER TABLE `stock_adjustment_lines`
  ADD CONSTRAINT `stock_adjustment_lines_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stock_adjustment_lines_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stock_adjustment_lines_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tax_rates`
--
ALTER TABLE `tax_rates`
  ADD CONSTRAINT `tax_rates_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tax_rates_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_expense_category_id_foreign` FOREIGN KEY (`expense_category_id`) REFERENCES `expense_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_expense_for_foreign` FOREIGN KEY (`expense_for`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `business_locations` (`id`),
  ADD CONSTRAINT `transactions_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transaction_payments`
--
ALTER TABLE `transaction_payments`
  ADD CONSTRAINT `transaction_payments_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transaction_sell_lines`
--
ALTER TABLE `transaction_sell_lines`
  ADD CONSTRAINT `transaction_sell_lines_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaction_sell_lines_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaction_sell_lines_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaction_sell_lines_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `units`
--
ALTER TABLE `units`
  ADD CONSTRAINT `units_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `units_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_crm_contact_id_foreign` FOREIGN KEY (`crm_contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `variations`
--
ALTER TABLE `variations`
  ADD CONSTRAINT `variations_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `variations_product_variation_id_foreign` FOREIGN KEY (`product_variation_id`) REFERENCES `product_variations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `variation_group_prices`
--
ALTER TABLE `variation_group_prices`
  ADD CONSTRAINT `variation_group_prices_price_group_id_foreign` FOREIGN KEY (`price_group_id`) REFERENCES `selling_price_groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `variation_group_prices_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `variation_location_details`
--
ALTER TABLE `variation_location_details`
  ADD CONSTRAINT `variation_location_details_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `business_locations` (`id`),
  ADD CONSTRAINT `variation_location_details_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`);

--
-- Constraints for table `variation_templates`
--
ALTER TABLE `variation_templates`
  ADD CONSTRAINT `variation_templates_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `variation_value_templates`
--
ALTER TABLE `variation_value_templates`
  ADD CONSTRAINT `variation_value_templates_variation_template_id_foreign` FOREIGN KEY (`variation_template_id`) REFERENCES `variation_templates` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
