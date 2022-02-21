-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 21, 2022 at 08:51 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_fsprot`
--

-- --------------------------------------------------------

--
-- Table structure for table `bill_tems`
--

CREATE TABLE `bill_tems` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_number` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `team` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sport_id` int(11) DEFAULT NULL,
  `payment_status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '0=ยังไม่ชำระ, 1=ชำระแล้ว, 2=ยกเลิกการชำระ, 3=เกินกำหนดการชำระ	',
  `payment_type` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1=โอนเงินผ่านธนาคาร, 2=ชำระผ่านบัตรเคดิต',
  `date_transfered` timestamp NULL DEFAULT NULL COMMENT 'วันที่ชำระเงิน',
  `file_transfered` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ไฟล์หลักฐานการชำระเงิน',
  `check_payment` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT 'การตรวจสอบการชำระเงินจากเจ้าหน้าที่',
  `bank_id` int(11) DEFAULT NULL COMMENT 'ธนาคารที่ชำระเงิน',
  `price_total` double(8,2) NOT NULL,
  `price_discount` double(8,2) NOT NULL,
  `net_total` double(8,2) NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `users_id` int(11) NOT NULL,
  `type_register` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bill_tems`
--

INSERT INTO `bill_tems` (`id`, `order_number`, `team`, `sport_id`, `payment_status`, `payment_type`, `date_transfered`, `file_transfered`, `check_payment`, `bank_id`, `price_total`, `price_discount`, `net_total`, `note`, `deleted_at`, `created_at`, `updated_at`, `users_id`, `type_register`) VALUES
(1, '202201171', NULL, NULL, '1', '1', '2022-01-17 03:58:00', '1722172768065240.jpg', '1', 1, 1800.00, 0.00, 1800.00, NULL, NULL, '2022-01-16 20:58:57', '2022-01-20 00:10:17', 1, NULL),
(2, '202201172', NULL, NULL, '1', '1', '2022-01-17 07:01:00', '1722184319756272.jpg', '0', 1, 700.00, 0.00, 700.00, NULL, NULL, '2022-01-17 00:02:33', '2022-01-19 23:51:46', 2, NULL),
(3, '202201173', NULL, NULL, '1', '1', '2022-01-17 07:02:00', '1722184324140512.jpg', '1', 1, 900.00, 0.00, 900.00, NULL, NULL, '2022-01-17 00:02:38', '2022-01-19 23:51:44', 3, NULL),
(4, '202201174', NULL, NULL, '1', '1', '2022-01-17 12:06:00', '1722184382877881.jpg', '1', 1, 900.00, 0.00, 900.00, NULL, NULL, '2022-01-17 00:03:34', '2022-01-19 23:51:35', 5, NULL),
(5, '202201175', NULL, NULL, '1', '1', '2022-01-17 08:20:00', '1722189186808164.jpg', '1', 1, 1800.00, 0.00, 1800.00, NULL, NULL, '2022-01-17 01:19:55', '2022-01-19 23:51:41', 7, NULL),
(6, '202201186', NULL, NULL, '0', NULL, NULL, NULL, '1', NULL, 900.00, 0.00, 900.00, NULL, NULL, '2022-01-18 02:06:22', NULL, 1, NULL),
(19, '2022020319', NULL, NULL, '1', '1', '2022-02-03 06:37:00', '1723722879743657.jpg', '1', 1, 700.00, 0.00, 700.00, NULL, NULL, '2022-02-02 23:37:19', NULL, 14, NULL),
(20, '2022020320', NULL, NULL, '1', '1', '2022-02-03 06:51:00', '1723723747745162.jpg', '1', 1, 700.00, 0.00, 700.00, NULL, NULL, '2022-02-02 23:51:06', NULL, 15, NULL),
(21, '2022021721', NULL, NULL, '1', '1', '2022-02-17 08:49:00', '1724999545131196.png', '0', 1, 1200.00, 200.00, 1000.00, NULL, NULL, '2022-02-17 01:49:22', NULL, 1, NULL),
(22, '2022021822', NULL, NULL, '0', NULL, NULL, NULL, '0', NULL, 1500.00, 0.00, 1500.00, NULL, NULL, '2022-02-17 20:38:08', NULL, 1, NULL),
(23, '2022021823', NULL, NULL, '1', '1', '2022-02-18 04:18:00', '1725073080440454.jpg', '1', 1, 1500.00, 100.00, 1400.00, NULL, NULL, '2022-02-17 21:18:10', '2022-02-17 21:18:40', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cart_sport_tems`
--

CREATE TABLE `cart_sport_tems` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `sport_id` int(11) NOT NULL,
  `sporttype_id` int(11) NOT NULL,
  `generation_id` int(11) NOT NULL,
  `option_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price_total` double(8,2) DEFAULT NULL,
  `price_discount` double(8,2) DEFAULT NULL,
  `net_total` double(8,2) DEFAULT NULL,
  `promotioncode_id` int(11) DEFAULT NULL COMMENT 'รหัส id Promotion ที่ใช้',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Promotion Code ที่กรอกเข้ามา',
  `team` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `candidacy` int(11) DEFAULT NULL COMMENT 'ผู้ทำการสมัคร/ user register',
  `type_register` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ประเภทการสมัคร \r\n1=คนเดียว, 2=หลายคน',
  `bill_id` int(11) DEFAULT NULL,
  `check_is` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cart_sport_tems`
--

INSERT INTO `cart_sport_tems` (`id`, `user_id`, `sport_id`, `sporttype_id`, `generation_id`, `option_id`, `price_total`, `price_discount`, `net_total`, `promotioncode_id`, `code`, `team`, `deleted_at`, `created_at`, `updated_at`, `candidacy`, `type_register`, `bill_id`, `check_is`) VALUES
(1, 1, 2, 4, 17, '10', 900.00, 0.00, 900.00, NULL, NULL, NULL, NULL, NULL, NULL, 1, '1', 1, 2),
(2, 1, 1, 2, 7, '5,8', 900.00, 0.00, 900.00, NULL, NULL, NULL, NULL, NULL, NULL, 1, '1', 1, 2),
(3, 2, 2, 5, 22, '13', 700.00, 0.00, 700.00, NULL, NULL, NULL, NULL, NULL, NULL, 2, '1', 2, 2),
(4, 3, 2, 4, 17, '12', 900.00, 0.00, 900.00, NULL, NULL, NULL, NULL, NULL, NULL, 3, '1', 3, 2),
(5, 6, 1, 1, 5, '5,8', 900.00, 0.00, 900.00, NULL, NULL, NULL, NULL, NULL, '2022-01-17 00:01:43', 5, '2', 4, 2),
(6, 7, 2, 4, 19, '12', 900.00, 0.00, 900.00, NULL, NULL, NULL, NULL, NULL, '2022-01-17 00:52:10', 7, '2', 5, 2),
(7, 8, 2, 4, 34, '10', 900.00, 0.00, 900.00, NULL, NULL, NULL, NULL, NULL, '2022-01-17 00:52:10', 7, '2', 5, 2),
(10, 1, 2, 4, 17, '12', 900.00, 0.00, 900.00, NULL, NULL, NULL, NULL, NULL, NULL, 1, '1', 6, 2),
(23, 14, 2, 5, 22, '13', 700.00, 0.00, 700.00, NULL, NULL, NULL, NULL, '2022-02-02 23:37:18', NULL, 10, '1', 19, 2),
(24, 15, 2, 5, 22, '14', 700.00, 0.00, 700.00, NULL, NULL, NULL, NULL, '2022-02-02 23:51:06', NULL, 10, '1', 20, 2),
(25, 1, 5, 9, 39, '16', 1200.00, 200.00, 1000.00, 1, 'cjctzp', NULL, NULL, NULL, NULL, 1, '1', 21, 2),
(27, 1, 6, 17, 60, '29', 1500.00, 0.00, 1500.00, NULL, NULL, NULL, NULL, NULL, NULL, 1, '1', 22, 2),
(28, 1, 6, 17, 60, '29', 1500.00, 100.00, 1400.00, 28, '9nessd', NULL, NULL, NULL, NULL, 1, '1', 23, 2);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fileimages`
--

CREATE TABLE `fileimages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sport_id` int(11) NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `generations`
--

CREATE TABLE `generations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_num` int(11) DEFAULT NULL,
  `tournament_id` int(11) NOT NULL,
  `tournament_type_id` int(11) NOT NULL,
  `name_th` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail_th` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `detail_en` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `age_min` int(11) NOT NULL,
  `age_max` int(11) NOT NULL,
  `release_start` date DEFAULT NULL,
  `sex` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `generations`
--

INSERT INTO `generations` (`id`, `order_num`, `tournament_id`, `tournament_type_id`, `name_th`, `name_en`, `detail_th`, `detail_en`, `age_min`, `age_max`, `release_start`, `sex`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 'รุ่นชายอายุ 18-29 ปี', 'Male models aged 18-29 years', 'รุ่นชายอายุ 18-29 ปี', 'Male models aged 18-29 years', 18, 29, '2021-12-30', 'M', NULL, '2021-12-02 01:56:45', NULL),
(2, 2, 1, 1, 'รุ่นชายอายุ 30-39 ปี', 'Male models aged 30-39 years', 'รุ่นชายอายุ 30-39 ปี', 'Male models aged 30-39 years', 30, 39, '2021-12-30', 'M', NULL, '2021-12-02 01:56:45', NULL),
(3, 3, 1, 1, 'รุ่นชายอายุ 40-49 ปี', 'Male models aged 40-49 years', 'รุ่นชายอายุ 40-49 ปี', 'Male models aged 40-49 years', 40, 49, '2021-12-30', 'M', NULL, '2021-12-02 01:56:45', NULL),
(4, 4, 1, 1, 'รุ่นชายอายุ 50-59 ปี', 'Male models aged 50-59 years', 'รุ่นชายอายุ 50-59 ปี', 'Male models aged 50-59 years', 50, 59, '2021-12-30', 'M', NULL, '2021-12-02 01:56:45', NULL),
(5, 5, 1, 1, 'รุ่นชายอายุ 60 ขึ้นไป', 'Males aged 60 and over', 'รุ่นชายอายุ 60 ขึ้นไป', 'Males aged 60 and over', 60, 100, '2021-12-30', 'M', NULL, '2021-12-02 01:56:45', NULL),
(6, 6, 1, 1, 'รุ่นหญิงทั่วไป', 'Ladies open', 'รุ่นหญิงทั่วไป', 'Ladies open', 0, 0, '2021-12-30', 'F', NULL, '2021-12-02 01:56:45', NULL),
(7, 7, 1, 2, 'รุ่นชาย Open', 'Open version', 'รุ่นชาย Open', 'Open version', 0, 0, '2021-12-30', 'M', NULL, '2021-12-02 01:56:45', NULL),
(8, 8, 1, 2, 'รุ่นหญิง Open', 'Open version', 'รุ่นหญิง Open', 'Open version', 0, 0, '2021-12-30', 'F', NULL, '2021-12-02 01:56:45', NULL),
(11, 1, 2, 3, 'รุ่นชายอายุ 18-29 ปี', 'Male models aged 18-29 years', 'รุ่นชายอายุ 18-29 ปี', 'Male models aged 18-29 years', 18, 29, '2021-12-30', 'M', NULL, '2021-12-02 01:56:45', NULL),
(12, 2, 2, 3, 'รุ่นชายอายุ 30-39 ปี', 'Male models aged 30-39 years', 'รุ่นชายอายุ 30-39 ปี', 'Male models aged 30-39 years', 30, 39, '2021-12-30', 'M', NULL, '2021-12-02 01:56:45', NULL),
(13, 3, 2, 3, 'รุ่นชายอายุ 40-49 ปี', 'Male models aged 40-49 years', 'รุ่นชายอายุ 40-49 ปี', 'Male models aged 40-49 years', 40, 49, '2021-12-30', 'M', NULL, '2021-12-02 01:56:45', NULL),
(14, 4, 2, 3, 'รุ่นชายอายุ 50-59 ปี', 'Male models aged 50-59 years', 'รุ่นชายอายุ 50-59 ปี', 'Male models aged 50-59 years', 50, 59, '2021-12-30', 'M', NULL, '2021-12-02 01:56:45', NULL),
(15, 5, 2, 3, 'รุ่นชายอายุ 60 ขึ้นไป', 'Males aged 60 and over', 'รุ่นชายอายุ 60 ขึ้นไป', 'Males aged 60 and over', 60, 100, '2021-12-30', 'M', NULL, '2021-12-02 01:56:45', NULL),
(17, 1, 2, 4, 'รุ่นชายอายุ 18-29 ปี', 'Male models aged 18-29 years', 'รุ่นชายอายุ 18-29 ปี', 'Male models aged 18-29 years', 18, 29, '2021-12-30', 'M', NULL, '2021-12-02 01:56:45', NULL),
(18, 2, 2, 4, 'รุ่นชายอายุ 30-39 ปี', 'Male models aged 30-39 years', 'รุ่นชายอายุ 30-39 ปี', 'Male models aged 30-39 years', 30, 39, '2021-12-30', 'M', NULL, '2021-12-02 01:56:45', NULL),
(19, 3, 2, 4, 'รุ่นชายอายุ 40-49 ปี', 'Male models aged 40-49 years', 'รุ่นชายอายุ 40-49 ปี', 'Male models aged 40-49 years', 40, 49, '2021-12-30', 'M', NULL, '2021-12-02 01:56:45', NULL),
(20, 4, 2, 4, 'รุ่นชายอายุ 50-59 ปี', 'Male models aged 50-59 years', 'รุ่นชายอายุ 50-59 ปี', 'Male models aged 50-59 years', 50, 59, '2021-12-30', 'M', NULL, '2021-12-02 01:56:45', NULL),
(21, 5, 2, 4, 'รุ่นชายอายุ 60 ขึ้นไป', 'Males aged 60 and over', 'รุ่นชายอายุ 60 ขึ้นไป', 'Males aged 60 and over', 60, 100, '2021-12-30', 'M', NULL, '2021-12-02 01:56:45', NULL),
(22, 1, 2, 5, 'รุ่นชาย Open', 'Male open', 'รุ่นชาย Open', 'Male open', 18, 29, '2021-12-30', 'M', NULL, '2021-12-02 01:56:45', NULL),
(23, 2, 2, 5, 'รุ่นหญิง Open', 'Ladies open', 'รุ่นหญิง Open', 'Ladies open', 30, 39, '2021-12-30', 'F', NULL, '2021-12-02 01:56:45', NULL),
(27, 1, 2, 3, 'รุ่นหญิงอายุ 18-29 ปี', 'Ladies models aged 18-29 years', 'รุ่นหญิงอายุ 18-29 ปี', 'Ladies models aged 18-29 years', 18, 29, '2021-12-30', 'F', NULL, '2021-12-02 01:56:45', NULL),
(28, 2, 2, 3, 'รุ่นหญิงอายุ 30-39 ปี', 'Ladies models aged 30-39 years', 'รุ่นหญิงอายุ 30-39 ปี', 'Ladies models aged 30-39 years', 30, 39, '2021-12-30', 'F', NULL, '2021-12-02 01:56:45', NULL),
(29, 3, 2, 3, 'รุ่นหญิงอายุ 40-49 ปี', 'Ladies models aged 40-49 years', 'รุ่นหญิงอายุ 40-49 ปี', 'Ladies models aged 40-49 years', 40, 49, '2021-12-30', 'F', NULL, '2021-12-02 01:56:45', NULL),
(30, 4, 2, 3, 'รุ่นหญิงอายุ 50-59 ปี', 'Ladies models aged 50-59 years', 'รุ่นหญิงอายุ 50-59 ปี', 'Ladies models aged 50-59 years', 50, 59, '2021-12-30', 'F', NULL, '2021-12-02 01:56:45', NULL),
(31, 5, 2, 3, 'รุ่นหญิงอายุ 60 ขึ้นไป', 'Ladies aged 60 and over', 'รุ่นหญิงอายุ 60 ขึ้นไป', 'Ladies aged 60 and over', 60, 100, '2021-12-30', 'F', NULL, '2021-12-02 01:56:45', NULL),
(32, 1, 2, 4, 'รุ่นหญิงอายุ 18-29 ปี', 'Ladies models aged 18-29 years', 'รุ่นหญิงอายุ 18-29 ปี', 'Ladies models aged 18-29 years', 18, 29, '2021-12-30', 'F', NULL, '2021-12-02 01:56:45', NULL),
(33, 2, 2, 4, 'รุ่นหญิงอายุ 30-39 ปี', 'Ladies models aged 30-39 years', 'รุ่นหญิงอายุ 30-39 ปี', 'Ladies models aged 30-39 years', 30, 39, '2021-12-30', 'F', NULL, '2021-12-02 01:56:45', NULL),
(34, 3, 2, 4, 'รุ่นหญิงอายุ 40-49 ปี', 'Ladies models aged 40-49 years', 'รุ่นหญิงอายุ 40-49 ปี', 'Ladies models aged 40-49 years', 40, 49, '2021-12-30', 'F', NULL, '2021-12-02 01:56:45', NULL),
(35, 4, 2, 4, 'รุ่นหญิงอายุ 50-59 ปี', 'Ladies models aged 50-59 years', 'รุ่นหญิงอายุ 50-59 ปี', 'Ladies models aged 50-59 years', 50, 59, '2021-12-30', 'F', NULL, '2021-12-02 01:56:45', NULL),
(36, 5, 2, 4, 'รุ่นหญิงอายุ 60 ขึ้นไป', 'Ladies aged 60 and over', 'รุ่นหญิงอายุ 60 ขึ้นไป', 'Ladies aged 60 and over', 60, 100, '2021-12-30', 'F', NULL, '2021-12-02 01:56:45', NULL),
(37, 1, 5, 8, 'รุ่นชายอายุ 18-29 ปี', 'รุ่นชายอายุ 18-29 ปี', NULL, NULL, 18, 29, NULL, 'M', NULL, '2022-02-14 02:56:16', '2022-02-17 19:15:48'),
(38, 2, 5, 8, 'รุ่นชายอายุ 30-39 ปี', 'รุ่นชายอายุ 30-39 ปี', NULL, NULL, 30, 39, NULL, 'M', NULL, '2022-02-14 02:56:16', '2022-02-17 19:15:48'),
(39, 1, 5, 9, 'รุ่นชาย Open', 'รุ่นชาย Open', NULL, NULL, 0, 0, NULL, 'M', NULL, '2022-02-14 02:56:16', '2022-02-17 19:15:47'),
(40, 2, 5, 9, 'รุ่นหญิง Open', 'รุ่นหญิง Open', NULL, NULL, 0, 0, NULL, 'F', NULL, '2022-02-14 02:56:16', '2022-02-17 19:15:47'),
(60, 1, 6, 17, 'รุ่นชายอายุ 18-29 ปี', 'Male models aged 18-29 years', NULL, NULL, 18, 29, NULL, 'M', NULL, NULL, '2022-02-20 19:09:29'),
(61, 2, 6, 17, 'รุ่นหญิงอายุ 18-29 ปี', 'Ladies models aged 18-29 years', NULL, NULL, 18, 29, NULL, 'F', NULL, NULL, '2022-02-20 19:09:29');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2021_11_24_075235_add_sex_to_users', 2),
(6, '2021_11_24_081916_add_is_users_to_users', 3),
(7, '2021_11_25_014917_add_facebook_id_column_in_users_table', 4),
(8, '2021_11_25_015755_add_provider_id_column_in_users_table', 5),
(9, '2021_11_25_024820_add_verify_information_column_in_users_table', 6),
(10, '2021_12_01_014801_create_cart_sport_tems_table', 7),
(11, '2021_12_01_030735_create_promotion_codes_table', 7),
(12, '2021_12_01_032223_create_sponsors_table', 8),
(13, '2021_12_01_034122_create_tournaments_table', 9),
(14, '2021_12_01_040753_create_tournament_types_table', 9),
(15, '2021_12_01_042206_create_generations_table', 10),
(16, '2021_12_01_063405_create_fileimages_table', 11),
(17, '2021_12_01_064755_create_options_table', 11),
(18, '2021_12_01_065040_create_option_items_table', 11),
(19, '2021_12_01_065540_create_souvenirs_table', 12),
(20, '2021_12_02_031412_add_create_user_to_create_user', 12),
(21, '2021_12_02_031745_add_user_create_to_promotion_codes', 13),
(22, '2021_12_02_034401_add_icon_to_options', 14),
(23, '2021_12_02_041040_add_candidacy_to_cart_sport_tems', 15),
(24, '2021_12_02_082018_add_type_register_to_cart_sport_tems', 16),
(25, '2021_12_07_082616_create_bill_tems_table', 17),
(26, '2021_12_07_085037_add_users_id_to_bill_tems', 18),
(27, '2021_12_07_090123_add_bill_id_to_cart_sport_tems', 19),
(28, '2021_12_07_095720_add_type_register_to_bill_tems', 20),
(29, '2022_01_07_031408_create_race_programs_table', 21);

-- --------------------------------------------------------

--
-- Table structure for table `options`
--

CREATE TABLE `options` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sport_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `deleted_at` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `icon` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `options`
--

INSERT INTO `options` (`id`, `sport_id`, `name`, `detail`, `filename`, `status`, `deleted_at`, `created_at`, `updated_at`, `icon`) VALUES
(1, 1, 'เลือกชุดการแข่งขัน', 'การสมัครเข้าร่วมการแข่งขัน ผู้สมัครจะได้รับเสื้อที่ระลึก 1 ตัว และหมายเลขการแข่งขัน พร้อมชิพจับเวลา', 'tdf08.jpg', '1', NULL, '2021-12-02 02:33:49', NULL, ''),
(2, 1, 'เลือกสเต็คเบอร์เกอร์', ' โชคชัยดรายเอจสเต็คเบอร์เกอร์สัมผัสถึงเนื้อคุณภาพคัดพิเศษผ่านการ dry Aged จนมาเป็นSteakburgerที่สัมผัสถึงรสชาตินุ่มชุ่มฉ่ำ ', 'bergur.jpg', '1', NULL, '2021-12-02 02:33:49', NULL, ''),
(3, 1, 'เหรียญรางวัล\r\n', 'เหรียญรางวัล', '002.jpg', '2', NULL, '2021-12-02 02:33:49', NULL, ''),
(4, 1, 'เบอร์ BIB', 'เบอร์ BIB', 'M0.png', '2', NULL, '2021-12-02 02:33:49', NULL, ''),
(5, 2, 'เลือกชุดการแข่งขัน', 'การสมัครเข้าร่วมการแข่งขัน ผู้สมัครจะได้รับเสื้อที่ระลึก 1 ตัว และหมายเลขการแข่งขัน พร้อมชิพจับเวลา', 'rdf.jpg', '1', NULL, '2021-12-02 02:33:49', NULL, ''),
(6, 2, 'เหรียญรางวัล\r\n', 'เหรียญรางวัล', 'rdf-01.jpg', '2', NULL, '2021-12-02 02:33:49', NULL, ''),
(7, 2, 'เบอร์ BIB', 'เบอร์ BIB', 'M0.png', '2', NULL, '2021-12-02 02:33:49', NULL, ''),
(8, 5, 'เสื้อแข่งขัน', 'เสื้อแข่งขัน RDFF', '1724818207658277.jpg', '1', NULL, '2022-02-15 01:47:05', '2022-02-17 19:00:29', NULL),
(9, 5, 'Chokchai Steakburger (Full option) Kurobuta + Sausage + Coke', 'Chokchai Steakburger (Full option) Kurobuta + Sausage + Coke', '1725065355510824.jpg', '1', NULL, '2022-02-15 01:54:46', '2022-02-17 19:17:36', NULL),
(13, 5, 'ไฟฉาย GH-0152', 'ไฟฉาย GH-0152', '1724996005767422.png', '2', NULL, '2022-02-17 00:53:06', NULL, NULL),
(14, 6, 'เสื้อแข่งขัน TTD', 'เสื้อแข่งขัน TTD', '1725070153714627.jpg', '1', NULL, '2022-02-17 20:31:39', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `option_items`
--

CREATE TABLE `option_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `option_id` int(11) NOT NULL,
  `topic` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `option_items`
--

INSERT INTO `option_items` (`id`, `option_id`, `topic`, `detail`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'size XS', 'chest (inches) 34', NULL, '2021-12-02 02:41:03', NULL),
(2, 1, 'size S', 'chest (inches) 36', NULL, '2021-12-02 02:41:03', NULL),
(3, 1, 'size M', 'chest (inches) 38', NULL, '2021-12-02 02:41:03', NULL),
(4, 1, 'size L', 'chest (inches) 40', NULL, '2021-12-02 02:41:03', NULL),
(5, 1, 'size XL', 'chest (inches) 42', NULL, '2021-12-02 02:41:03', NULL),
(6, 1, 'size 2XL', 'chest (inches) 44', NULL, '2021-12-02 02:41:03', NULL),
(7, 2, 'สเต็คเบอร์เกอร์', 'หมู', NULL, '2021-12-02 02:41:03', NULL),
(8, 2, 'สเต็คเบอร์เกอร์', 'เนื้อ', NULL, '2021-12-02 02:41:03', NULL),
(9, 5, 'size XS', 'chest (inches) 34', NULL, '2021-12-02 02:41:03', NULL),
(10, 5, 'size S', 'chest (inches) 36', NULL, '2021-12-02 02:41:03', NULL),
(11, 5, 'size M', 'chest (inches) 38', NULL, '2021-12-02 02:41:03', NULL),
(12, 5, 'size L', 'chest (inches) 40', NULL, '2021-12-02 02:41:03', NULL),
(13, 5, 'size XL', 'chest (inches) 42', NULL, '2021-12-02 02:41:03', NULL),
(14, 5, 'size 2XL', 'chest (inches) 44', NULL, '2021-12-02 02:41:03', NULL),
(15, 8, 'xs 40\'\'', 'xs 40\'\'', NULL, '2022-02-15 01:47:05', '2022-02-17 19:00:29'),
(22, 13, 'ไฟฉายไซต์ M', 'ไฟฉายไซต์ M', NULL, '2022-02-17 00:53:06', NULL),
(24, 8, 'xs 50\'\'', 'xs 50\'\'', NULL, NULL, '2022-02-17 19:00:29'),
(26, 9, 'Steakburger หมู', 'Steakburger หมู', NULL, NULL, '2022-02-17 19:17:36'),
(27, 9, 'Steakburger เนื้อ', 'Steakburger เนื้อ', NULL, NULL, '2022-02-17 19:17:36'),
(28, 14, 'size XS chest (inches) 34', 'size XS chest (inches) 34', NULL, '2022-02-17 20:31:40', NULL),
(29, 14, 'size XS chest (inches) 34', 'size XS chest (inches) 34', NULL, '2022-02-17 20:31:40', NULL),
(30, 14, 'size M chest (inches) 38', 'size M chest (inches) 38', NULL, '2022-02-17 20:31:40', NULL),
(31, 14, 'size M chest (inches) 38', 'size M chest (inches) 38', NULL, '2022-02-17 20:31:40', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('dev.saifah8953@gmail.com', '$2y$10$eLlqijlAG77mIw031buOjOPX6mEnli2CtGTuP0szi2/U7eWR3qrC.', '2021-12-14 01:18:00'),
('saifah192s8@gmail.com', '$2y$10$KhD46M4hsaU4eDRIYPZeSOZTQRpDO9iiiSRlcm5fzSegIY.w8iKR6', '2021-12-15 02:05:46');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `promotion_codes`
--

CREATE TABLE `promotion_codes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sport_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '0=ปิดใช้, 1=เปิดใช้, 2=ถูกใช้แล้ว, 3=ยกเลิก',
  `verify` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '0=ยังไม่ถูกใช้, 1=ถูกใช้แล้ว',
  `promotion_type` int(11) NOT NULL,
  `price_discount` double(8,2) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date_code` timestamp NULL DEFAULT NULL COMMENT 'วันที่ใช้ Code',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_create` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `promotion_codes`
--

INSERT INTO `promotion_codes` (`id`, `sport_id`, `name`, `detail`, `code`, `status`, `verify`, `promotion_type`, `price_discount`, `user_id`, `date_code`, `note`, `created_at`, `updated_at`, `user_create`) VALUES
(1, 5, 'Thai beverage Code Free 200 ฿', 'บริษัท ไทยเบฟเวอเรจ จำกัด รู้จักกันในชื่อ ไทยเบฟ เป็นบริษัทที่ใหญ่ที่สุดในประเทศไทยและหนึ่งในบริษัทเครื่องดื่มที่ใหญ่ที่สุดในเอเชียตะวันออกเฉียงใต้ ที่มีโรงกลั่นสุราในประเทศไทย', 'cjctzp', '2', '1', 1, 200.00, 1, '2022-02-17 01:48:57', 'ผู้ออกโค้ด : Thai beverage', '2022-02-09 00:50:15', NULL, 10),
(2, 5, 'Thai beverage Code Free 200 ฿', 'บริษัท ไทยเบฟเวอเรจ จำกัด รู้จักกันในชื่อ ไทยเบฟ เป็นบริษัทที่ใหญ่ที่สุดในประเทศไทยและหนึ่งในบริษัทเครื่องดื่มที่ใหญ่ที่สุดในเอเชียตะวันออกเฉียงใต้ ที่มีโรงกลั่นสุราในประเทศไทย', '6kijbp', '1', '0', 1, 200.00, NULL, NULL, 'ผู้ออกโค้ด : Thai beverage', '2022-02-09 00:50:15', NULL, 10),
(3, 1, 'Thai beverage Code Free 200 ฿', 'บริษัท ไทยเบฟเวอเรจ จำกัด รู้จักกันในชื่อ ไทยเบฟ เป็นบริษัทที่ใหญ่ที่สุดในประเทศไทยและหนึ่งในบริษัทเครื่องดื่มที่ใหญ่ที่สุดในเอเชียตะวันออกเฉียงใต้ ที่มีโรงกลั่นสุราในประเทศไทย', '221efr', '1', '0', 1, 200.00, NULL, NULL, 'ผู้ออกโค้ด : Thai beverage', '2022-02-09 00:50:15', NULL, 10),
(4, 1, 'Thai beverage Code Free 200 ฿', 'บริษัท ไทยเบฟเวอเรจ จำกัด รู้จักกันในชื่อ ไทยเบฟ เป็นบริษัทที่ใหญ่ที่สุดในประเทศไทยและหนึ่งในบริษัทเครื่องดื่มที่ใหญ่ที่สุดในเอเชียตะวันออกเฉียงใต้ ที่มีโรงกลั่นสุราในประเทศไทย', 'kpz6iz', '1', '0', 1, 200.00, NULL, NULL, 'ผู้ออกโค้ด : Thai beverage', '2022-02-09 00:50:15', NULL, 10),
(5, 1, 'Thai beverage Code Free 200 ฿', 'บริษัท ไทยเบฟเวอเรจ จำกัด รู้จักกันในชื่อ ไทยเบฟ เป็นบริษัทที่ใหญ่ที่สุดในประเทศไทยและหนึ่งในบริษัทเครื่องดื่มที่ใหญ่ที่สุดในเอเชียตะวันออกเฉียงใต้ ที่มีโรงกลั่นสุราในประเทศไทย', '4wd2ylk', '1', '0', 1, 200.00, NULL, NULL, 'ผู้ออกโค้ด : Thai beverage', '2022-02-09 00:50:15', NULL, 10),
(6, 1, 'Thai beverage Code Free 200 ฿', 'บริษัท ไทยเบฟเวอเรจ จำกัด รู้จักกันในชื่อ ไทยเบฟ เป็นบริษัทที่ใหญ่ที่สุดในประเทศไทยและหนึ่งในบริษัทเครื่องดื่มที่ใหญ่ที่สุดในเอเชียตะวันออกเฉียงใต้ ที่มีโรงกลั่นสุราในประเทศไทย', 'fpfcz3f', '1', '0', 1, 200.00, NULL, NULL, 'ผู้ออกโค้ด : Thai beverage', '2022-02-09 00:50:15', NULL, 10),
(7, 1, 'Thai beverage Code Free 200 ฿', 'บริษัท ไทยเบฟเวอเรจ จำกัด รู้จักกันในชื่อ ไทยเบฟ เป็นบริษัทที่ใหญ่ที่สุดในประเทศไทยและหนึ่งในบริษัทเครื่องดื่มที่ใหญ่ที่สุดในเอเชียตะวันออกเฉียงใต้ ที่มีโรงกลั่นสุราในประเทศไทย', 'htln6yg', '1', '0', 1, 200.00, NULL, NULL, 'ผู้ออกโค้ด : Thai beverage', '2022-02-09 00:50:15', NULL, 10),
(8, 1, 'Thai beverage Code Free 200 ฿', 'บริษัท ไทยเบฟเวอเรจ จำกัด รู้จักกันในชื่อ ไทยเบฟ เป็นบริษัทที่ใหญ่ที่สุดในประเทศไทยและหนึ่งในบริษัทเครื่องดื่มที่ใหญ่ที่สุดในเอเชียตะวันออกเฉียงใต้ ที่มีโรงกลั่นสุราในประเทศไทย', 'iarhx1', '1', '0', 1, 200.00, NULL, NULL, 'ผู้ออกโค้ด : Thai beverage', '2022-02-09 00:50:15', NULL, 10),
(9, 1, 'Thai beverage Code Free 200 ฿', 'บริษัท ไทยเบฟเวอเรจ จำกัด รู้จักกันในชื่อ ไทยเบฟ เป็นบริษัทที่ใหญ่ที่สุดในประเทศไทยและหนึ่งในบริษัทเครื่องดื่มที่ใหญ่ที่สุดในเอเชียตะวันออกเฉียงใต้ ที่มีโรงกลั่นสุราในประเทศไทย', 'hktl9b', '1', '0', 1, 200.00, NULL, NULL, 'ผู้ออกโค้ด : Thai beverage', '2022-02-09 00:50:15', NULL, 10),
(10, 1, 'Thai beverage Code Free 200 ฿', 'บริษัท ไทยเบฟเวอเรจ จำกัด รู้จักกันในชื่อ ไทยเบฟ เป็นบริษัทที่ใหญ่ที่สุดในประเทศไทยและหนึ่งในบริษัทเครื่องดื่มที่ใหญ่ที่สุดในเอเชียตะวันออกเฉียงใต้ ที่มีโรงกลั่นสุราในประเทศไทย', 'wry6hp', '1', '0', 1, 200.00, NULL, NULL, 'ผู้ออกโค้ด : Thai beverage', '2022-02-09 00:50:15', NULL, 10),
(11, 2, 'Farm Chokchai Promo Code New !', 'ร้านค้าที่รวบรวมและจำหน่ายสินค้าที่ มาจากการคัดสรรวัตถุดิบ ผลิตผลที่ปลูกและผลิตด้วยความพิถีพิถันภายในฟาร์มด้วยแนวคิด “สดเหมือนอยู่ในฟาร์มโชคชัย” อัน ประกอบด้วย ...', 'btxjtz', '1', '0', 1, 500.00, NULL, NULL, 'Farm Chokchai Code', '2022-02-09 01:04:46', NULL, 10),
(12, 2, 'Farm Chokchai Promo Code New !', 'ร้านค้าที่รวบรวมและจำหน่ายสินค้าที่ มาจากการคัดสรรวัตถุดิบ ผลิตผลที่ปลูกและผลิตด้วยความพิถีพิถันภายในฟาร์มด้วยแนวคิด “สดเหมือนอยู่ในฟาร์มโชคชัย” อัน ประกอบด้วย ...', '61txp5', '1', '0', 1, 500.00, NULL, NULL, 'Farm Chokchai Code', '2022-02-09 01:04:47', NULL, 10),
(13, 2, 'Farm Chokchai Promo Code New !', 'ร้านค้าที่รวบรวมและจำหน่ายสินค้าที่ มาจากการคัดสรรวัตถุดิบ ผลิตผลที่ปลูกและผลิตด้วยความพิถีพิถันภายในฟาร์มด้วยแนวคิด “สดเหมือนอยู่ในฟาร์มโชคชัย” อัน ประกอบด้วย ...', '0fu921', '1', '0', 1, 500.00, NULL, NULL, 'Farm Chokchai Code', '2022-02-09 01:04:48', NULL, 10),
(14, 2, 'Farm Chokchai Promo Code New !', 'ร้านค้าที่รวบรวมและจำหน่ายสินค้าที่ มาจากการคัดสรรวัตถุดิบ ผลิตผลที่ปลูกและผลิตด้วยความพิถีพิถันภายในฟาร์มด้วยแนวคิด “สดเหมือนอยู่ในฟาร์มโชคชัย” อัน ประกอบด้วย ...', 'btxjtz', '1', '0', 1, 500.00, NULL, NULL, 'Farm Chokchai Code', '2022-02-09 01:04:48', NULL, 10),
(15, 2, 'Farm Chokchai Promo Code New !', 'ร้านค้าที่รวบรวมและจำหน่ายสินค้าที่ มาจากการคัดสรรวัตถุดิบ ผลิตผลที่ปลูกและผลิตด้วยความพิถีพิถันภายในฟาร์มด้วยแนวคิด “สดเหมือนอยู่ในฟาร์มโชคชัย” อัน ประกอบด้วย ...', '61txp5', '1', '0', 1, 500.00, NULL, NULL, 'Farm Chokchai Code', '2022-02-09 01:04:49', NULL, 10),
(16, 2, 'Farm Chokchai Promo Code New !', 'ร้านค้าที่รวบรวมและจำหน่ายสินค้าที่ มาจากการคัดสรรวัตถุดิบ ผลิตผลที่ปลูกและผลิตด้วยความพิถีพิถันภายในฟาร์มด้วยแนวคิด “สดเหมือนอยู่ในฟาร์มโชคชัย” อัน ประกอบด้วย ...', '0fu921', '1', '0', 1, 500.00, NULL, NULL, 'Farm Chokchai Code', '2022-02-09 01:04:49', NULL, 10),
(17, 2, 'Code Free สปอนเซอร์ช้าง', 'เมื่อนึกถึงสปอนเซอร์หลัก ที่สนับสนุนวงการลูกหนังไทย มาอย่างต่อเนื่องเป็นเวลากว่า 20 ปี ทุกคนคงคิดถึง แบรนด์เครื่องดื่มตรา \"ช้าง\"', '8nqi8', '1', '0', 1, 100.00, NULL, NULL, 'สปอนเซอร์ช้าง', '2022-02-09 01:07:10', NULL, 10),
(27, 1, '5', '5', 'oeh4mih', '2', '1', 1, 150.00, 1, '2022-02-17 01:37:03', '5', '2022-02-16 18:35:21', NULL, 10),
(28, 6, 'Free Code  100฿', 'Free Code  100฿', '9nessd', '2', '1', 1, 100.00, 1, '2022-02-17 21:17:35', 'Free Code  100฿', '2022-02-17 21:16:57', NULL, 10);

-- --------------------------------------------------------

--
-- Table structure for table `promotion_codes_sponsors`
--

CREATE TABLE `promotion_codes_sponsors` (
  `id` int(11) NOT NULL,
  `code_id` int(11) NOT NULL,
  `sponsors_id` int(11) NOT NULL,
  `deleted_at` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `promotion_codes_sponsors`
--

INSERT INTO `promotion_codes_sponsors` (`id`, `code_id`, `sponsors_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, '2022-02-09 00:50:15', NULL),
(2, 1, 3, NULL, '2022-02-09 00:50:15', NULL),
(3, 2, 1, NULL, '2022-02-09 00:50:15', NULL),
(4, 2, 3, NULL, '2022-02-09 00:50:15', NULL),
(5, 3, 1, NULL, '2022-02-09 00:50:15', NULL),
(6, 3, 3, NULL, '2022-02-09 00:50:15', NULL),
(7, 4, 1, NULL, '2022-02-09 00:50:15', NULL),
(8, 4, 3, NULL, '2022-02-09 00:50:15', NULL),
(9, 5, 1, NULL, '2022-02-09 00:50:15', NULL),
(10, 5, 3, NULL, '2022-02-09 00:50:15', NULL),
(11, 6, 1, NULL, '2022-02-09 00:50:15', NULL),
(12, 6, 3, NULL, '2022-02-09 00:50:15', NULL),
(13, 7, 1, NULL, '2022-02-09 00:50:15', NULL),
(14, 7, 3, NULL, '2022-02-09 00:50:15', NULL),
(15, 8, 1, NULL, '2022-02-09 00:50:15', NULL),
(16, 8, 3, NULL, '2022-02-09 00:50:15', NULL),
(17, 9, 1, NULL, '2022-02-09 00:50:15', NULL),
(18, 9, 3, NULL, '2022-02-09 00:50:15', NULL),
(19, 10, 1, NULL, '2022-02-09 00:50:16', NULL),
(20, 10, 3, NULL, '2022-02-09 00:50:16', NULL),
(21, 11, 3, NULL, '2022-02-09 01:04:47', NULL),
(22, 12, 3, NULL, '2022-02-09 01:04:48', NULL),
(23, 13, 3, NULL, '2022-02-09 01:04:48', NULL),
(24, 14, 3, NULL, '2022-02-09 01:04:48', NULL),
(25, 15, 3, NULL, '2022-02-09 01:04:49', NULL),
(26, 16, 3, NULL, '2022-02-09 01:04:49', NULL),
(27, 17, 2, NULL, '2022-02-09 01:07:10', NULL),
(37, 27, 3, NULL, '2022-02-16 18:35:21', NULL),
(38, 28, 3, NULL, '2022-02-17 21:16:57', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `race_programs`
--

CREATE TABLE `race_programs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bill_id` int(11) NOT NULL,
  `tems_id` int(11) NOT NULL,
  `tournaments_id` int(11) NOT NULL,
  `tournamentTypes_id` int(11) NOT NULL,
  `BIB` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EPC` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `users_id` int(11) NOT NULL,
  `start_time` date DEFAULT NULL,
  `end_time` date DEFAULT NULL,
  `DNF` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NRF` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `finish` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` char(255) COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '1=ยังไม่ลงทะเบียน/ 2=ลงทะเบียนแล้ว',
  `receiver_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ผู้รับอุปกรณ์ ',
  `receiver_tel` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'เบอร์ติดต่อ',
  `deleted_at` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `race_programs`
--

INSERT INTO `race_programs` (`id`, `bill_id`, `tems_id`, `tournaments_id`, `tournamentTypes_id`, `BIB`, `EPC`, `users_id`, `start_time`, `end_time`, `DNF`, `NRF`, `finish`, `status`, `receiver_name`, `receiver_tel`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 1, 2, '7001', NULL, 1, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, '2022-01-16 21:06:34', NULL),
(2, 1, 1, 2, 4, 'M-2001', NULL, 1, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, '2022-01-16 21:06:34', '2022-01-16 21:25:19'),
(3, 2, 3, 2, 5, 'M-3001', NULL, 2, NULL, NULL, NULL, NULL, NULL, '1', 'สายฟ้า ไพรวรรณ์', '0959086456', NULL, '2022-01-17 00:12:31', '2022-01-17 00:44:08'),
(4, 3, 4, 2, 4, 'M-2002', NULL, 3, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, '2022-01-17 00:13:32', NULL),
(5, 4, 5, 1, 1, '5001', NULL, 6, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, '2022-01-17 00:14:54', NULL),
(6, 5, 6, 2, 4, 'M-2003', NULL, 7, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, '2022-01-17 01:20:21', NULL),
(7, 5, 7, 2, 4, 'F-2001', NULL, 8, NULL, NULL, NULL, NULL, NULL, '2', 'saifah', '0959865453', NULL, '2022-01-17 01:20:21', '2022-02-03 02:37:17'),
(20, 19, 23, 2, 5, 'M-3002', NULL, 14, NULL, NULL, NULL, NULL, NULL, '2', 'Admin', '-', NULL, '2022-02-02 23:37:19', NULL),
(21, 20, 24, 2, 5, 'M-3003', NULL, 15, NULL, NULL, NULL, NULL, NULL, '2', 'Admin', '-', NULL, '2022-02-02 23:51:07', NULL),
(22, 23, 28, 6, 17, '1001', NULL, 1, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, '2022-02-17 21:18:41', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `souvenirs`
--

CREATE TABLE `souvenirs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sport_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sponsors`
--

CREATE TABLE `sponsors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_number` int(11) DEFAULT 0,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sponsors`
--

INSERT INTO `sponsors` (`id`, `order_number`, `name`, `detail`, `filename`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 5, 'Thai beverage', 'Thai beverage', 'thaibeverage.png', '0', '2022-02-07 07:46:20', '2022-02-18 02:24:55'),
(2, 2, 'Chang beer park', 'Chang beer park', 'changpark.png', '0', '2022-02-07 07:46:20', NULL),
(3, 3, 'ฟาร์มโชคชัย', 'โชคชัยสเต็กเฮ้าส์สาขาปากช่องขึ้นที่บริเวณหน้าฟาร์มโชคชัยอ. ปากช่องจ. นครราชสีมา', 'farmchokchai.png', '0', '2022-02-07 07:46:20', NULL),
(4, 6, 'Umm!..Milk ทอฟฟี่ นมสด อืมม!..มิลค์', 'ขนนมมาไว้ที่ฟาร์มแล้ววว นมแลคโตสฟรีของ #Ummmilk เป็นนมวัวแท้ๆเลยย อร่อยมากอะทุกคน ใครที่กินแล้วท้องเสีย หมดกังวลได้เลย เพราะว่าเขาผลิตด้วยเทคโนโลยีที่', '1725092497624317.jpg', '0', '2022-02-18 01:29:33', '2022-02-18 02:26:48'),
(5, 4, 'MONO29 TV Official Site - ฟรีทีวีที่มีหนังดีซีรีส์ดังมากที่สุด', 'Mono29 ฟรีทีวีที่มีหนังดีซีรีส์ดังมากที่สุด. ดูทีวีออนไลน์ ช่อง Mono29 รับชมผ่านทีวีดิจิตอล กด ช่อง 29 หรือรับชม Mono29 ออนไลน์รองรับระบบเสียงสองภาษา ...', '1725091189427426.jpg', '0', '2022-02-18 02:06:00', NULL),
(6, 1, 'Farm Chokchai Outdoor Sports', 'ร่วมกับกลุ่มพนักงานที่ร่วมเล่นด้วยใจรัก ชอบความสนุกสนานและการท้าทาย จนถึงการส่งเสริมสนับสนุนให้ทุกคนในองค์กรร่วมเล่นกีฬากันก่อนเลิกงานทุกวันพุธ ในโครงการที่ชื่อว่า “พละพุธ” จนเพิ่มความท้าทายให้กับตัวพวกเราเองด้วยคำว่า “Transform Your Fear to Focus', '1725092462495062.png', '0', '2022-02-18 02:26:14', '2022-02-20 18:26:13');

-- --------------------------------------------------------

--
-- Table structure for table `tournaments`
--

CREATE TABLE `tournaments` (
  `id` bigint(20) NOT NULL,
  `name_th` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_th` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail_th` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail_en` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `address_th` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `address_en` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `race_type` int(11) NOT NULL COMMENT 'วิ่ง=1, ปันจักยาน=2',
  `abbreviation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ตัวย่อ',
  `location` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `imgname` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_event` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '0=ปิด, 1=เปิด ',
  `status_register` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '0=ปิดสมัคร, 1=เปิดสมัคร ',
  `status_pomotion` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '0=ปิดใช้, 1=เปิดใช้ ',
  `register_start` date DEFAULT NULL,
  `register_end` date DEFAULT NULL,
  `event_start` date DEFAULT NULL,
  `event_end` date DEFAULT NULL,
  `promotion_start` date DEFAULT NULL,
  `promotion_end` date DEFAULT NULL,
  `remark` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tournaments`
--

INSERT INTO `tournaments` (`id`, `name_th`, `name_en`, `title_th`, `title_en`, `detail_th`, `detail_en`, `address_th`, `address_en`, `race_type`, `abbreviation`, `location`, `icon`, `imgname`, `status_event`, `status_register`, `status_pomotion`, `register_start`, `register_end`, `event_start`, `event_end`, `promotion_start`, `promotion_end`, `remark`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Farm Chokchai Tour de Farm 8', 'Farm Chokchai Tour de Farm 8', 'Farm Chokchai Tour de Farm 8 เป็นมากกว่างานจักรยานแห่งปี แต่เป็นงานจักรยานของสุภาพบุรุษนักปั่น Peloton of Gentleman', 'Farm Chokchai Tour de Farm 8 เป็นมากกว่างานจักรยานแห่งปี แต่เป็นงานจักรยานของสุภาพบุรุษนักปั่น Peloton of Gentleman', 'ฟาร์มโชคชัย เอ้าท์ดอร์ สปอร์ต ในนามของ กลุ่มบริษัทฟาร์มโชคชัย และบริษัท โชคชัยอินเตอร์เนชั่นแนล จำกัด ขอเชิญผู้ที่รักการปั่นทุกท่านเข้าร่วมในรายการจักรยานทางเรียบแห่งปี “Farm Chokchai Tour de Farm 8” ภายใต้ Concept “Transform Your Fear To Focus” เปลี่ยนความกลัวให้เป็นจุดมุ่งหมาย ในวันอาทิตย์ที่ 12 มกราคม 2563 ณ ฟาร์มโชคชัย 3 อำเภอปากช่อง จังหวัดนครราชสีมา', 'ฟาร์มโชคชัย เอ้าท์ดอร์ สปอร์ต ในนามของ กลุ่มบริษัทฟาร์มโชคชัย และบริษัท โชคชัยอินเตอร์เนชั่นแนล จำกัด ขอเชิญผู้ที่รักการปั่นทุกท่านเข้าร่วมในรายการจักรยานทางเรียบแห่งปี “Farm Chokchai Tour de Farm 8” ภายใต้ Concept “Transform Your Fear To Focus” เปลี่ยนความกลัวให้เป็นจุดมุ่งหมาย ในวันอาทิตย์ที่ 12 มกราคม 2563 ณ ฟาร์มโชคชัย 3 อำเภอปากช่อง จังหวัดนครราชสีมา', 'วันอาทิตย์ 12 มกราคม 2563 ฟาร์มโชคชัย 3 ถนนธนะรัชต์ กม.ที่ 12 หมูสี ปากช่อง จ.นครราชสีมา', 'วันอาทิตย์ 12 มกราคม 2563 ฟาร์มโชคชัย 3 ถนนธนะรัชต์ กม.ที่ 12 หมูสี ปากช่อง จ.นครราชสีมา', 2, 'TDF', 'url', 'tdf.jpg', 'tdf.jpg', '1', '1', '1', '2021-12-14', '2021-12-15', '2021-12-30', '2021-12-31', NULL, NULL, 'เงื่อนไขการสมัคร :\n1. ผู้สมัคร ต้องสมัครเป็นสมาชิกเว็บไซต์ www.farmchokchaisport.com ก่อน โดยเมื่อกรอกข้อมูลครบถ้วน ระบบจะส่งอีเมล์ ให้ผู้สมัคร ยืนยันตัวตน (Activate) และเข้าระบบเพื่อสมัครรายการกีฬาต่อไป\n2. ระบบรับสมัครแบ่งออกเป็นแบบบุคคล และแบบกลุ่ม (สมัครให้เพื่อน)\n3. กรอกข้อมูลผ่านระบบลงทะเบียนออนไลน์  ผู้สมัครจะได้รับการตอบรับการสมัครรายการ หมายเลขอ้างอิงการสมัคร รูปแบบการชำระเงินให้กับท่านโดยอีเมล์\n4. หากเลือกรูปแบบการชำระเงินโดยการโอนเงินผ่านธนาคาร ให้ทำตามขั้นตอน และส่งหลักฐานยืนยันการชำระเงินทางเว็บไซต์\n5. เมื่อชำระค่าสมัครและแจ้งการชำระค่าสมัครแล้ว ท่านจะได้รับอีเมล์ตอบกลับยืนยันการชำระเงินของท่าน พร้อม QR Code\nหมายเหตุ : ผู้สมัครไม่สามารถเปลี่ยนตัวผู้เข้าร่วมแข่งขันได้', '0', '2021-12-02 01:40:26', NULL),
(2, 'Farm Chokchai Run de Farm', 'Farm Chokchai Run de Farm', 'หากไม่อยากพลาดอีกครั้ง กับงานวิ่งฤดูหนาว ตะลุยฟาร์มโชคชัย ทะลุไร่สุวรรณ Cow & Corn  farms cross country runs', 'หากไม่อยากพลาดอีกครั้ง กับงานวิ่งฤดูหนาว ตะลุยฟาร์มโชคชัย ทะลุไร่สุวรรณ Cow & Corn  farms cross country runs', 'ไม่ว่าจะสายพลัง สายชิล สายแชะ มาคนเดียว มาเป็นกลุ่ม หรือยกครอบครัว มาร่วมวิ่งอย่างสนุกสนาน ซึ่งในครั้งนี้มีการจับเวลา เพื่อหานักวิ่ง คิง ออฟ รัน เดอ ฟาร์ม “ King of Run de Farm” อันดับ 1 -3 ของกลุ่มอายุ และรางวัล Gentleman Awards สำหรับนักวิ่งทั้งชายและหญิง ที่มีน้ำใจเป็นนักกีฬา ช่วยเหลือ แบ่งปัน ฯ นอกจากนี้ ผู้เข้าร่วมงานทุกท่าน มีโอกาสได้รับรางวัล #คนรักษ์โลก เมื่อแสดงออกถึงความเป็นมิตรกับสิ่งแวดล้อม\r\n\r\nรัน เดอ ฟาร์ม นักวิ่งจะได้สัมผัสประสบการณ์ และทิวทัศน์ที่สวยงามท่ามกลางบรรยากาศของฟาร์มปศุสัตว์ของฟาร์มโชคชัย ชมวิว วัว ทุ่งหญ้า แปลงเพาะปลูกข้าวโพด เครื่องจักรการเกษตร พร้อมกันนั้นยังได้วิ่งเข้าไปสัมผัสกับไร่สุวรรณ ฟาร์มที่มีชื่อเสียงด้านข้าวโพดหวาน ได้ชมสถานที่สำคัญภายในเช่น พลับพลาที่ประทับของในหลวงรัชกาลที่ 9 แปลงเพาะปลูกข้าวโพด เครื่องจักรเกษตร เป็นต้น ท่ามกลางบรรยากาศความเย็นของฤดูหนาว  ณ ฟาร์มโชคชัย 1  และไร่สุวรรณ', 'ไม่ว่าจะสายพลัง สายชิล สายแชะ มาคนเดียว มาเป็นกลุ่ม หรือยกครอบครัว มาร่วมวิ่งอย่างสนุกสนาน ซึ่งในครั้งนี้มีการจับเวลา เพื่อหานักวิ่ง คิง ออฟ รัน เดอ ฟาร์ม “ King of Run de Farm” อันดับ 1 -3 ของกลุ่มอายุ และรางวัล Gentleman Awards สำหรับนักวิ่งทั้งชายและหญิง ที่มีน้ำใจเป็นนักกีฬา ช่วยเหลือ แบ่งปัน ฯ นอกจากนี้ ผู้เข้าร่วมงานทุกท่าน มีโอกาสได้รับรางวัล #คนรักษ์โลก เมื่อแสดงออกถึงความเป็นมิตรกับสิ่งแวดล้อม\r\n\r\nรัน เดอ ฟาร์ม นักวิ่งจะได้สัมผัสประสบการณ์ และทิวทัศน์ที่สวยงามท่ามกลางบรรยากาศของฟาร์มปศุสัตว์ของฟาร์มโชคชัย ชมวิว วัว ทุ่งหญ้า แปลงเพาะปลูกข้าวโพด เครื่องจักรการเกษตร พร้อมกันนั้นยังได้วิ่งเข้าไปสัมผัสกับไร่สุวรรณ ฟาร์มที่มีชื่อเสียงด้านข้าวโพดหวาน ได้ชมสถานที่สำคัญภายในเช่น พลับพลาที่ประทับของในหลวงรัชกาลที่ 9 แปลงเพาะปลูกข้าวโพด เครื่องจักรเกษตร เป็นต้น ท่ามกลางบรรยากาศความเย็นของฤดูหนาว  ณ ฟาร์มโชคชัย 1  และไร่สุวรรณ', 'วันอาทิตย์ 22 ธันวาคม 2562\r\nฟาร์มโชคชัย 1 ก.ม. 159 ถ.มิตรภาพ หนองน้ำแดง ปากช่อง จ.นครราชสีมา', 'วันอาทิตย์ 22 ธันวาคม 2562\nฟาร์มโชคชัย 1 ก.ม. 159 ถ.มิตรภาพ หนองน้ำแดง ปากช่อง จ.นครราชสีมา', 1, 'RDF', 'url', 'sm.png', 'rdf.jpg', '1', '1', '1', '2021-12-14', '2021-12-15', '2021-12-30', '2021-12-31', NULL, NULL, 'เงื่อนไขการสมัคร :\n1. ผู้สมัคร ต้องสมัครเป็นสมาชิกเว็บไซต์ www.farmchokchaisport.com ก่อน โดยเมื่อกรอกข้อมูลครบถ้วน ระบบจะส่งอีเมล์ ให้ผู้สมัคร ยืนยันตัวตน (Activate) และเข้าระบบเพื่อสมัครรายการกีฬาต่อไป\n2. ระบบรับสมัครแบ่งออกเป็นแบบบุคคล และแบบกลุ่ม (สมัครให้เพื่อน)\n3. กรอกข้อมูลผ่านระบบลงทะเบียนออนไลน์  ผู้สมัครจะได้รับการตอบรับการสมัครรายการ หมายเลขอ้างอิงการสมัคร รูปแบบการชำระเงินให้กับท่านโดยอีเมล์\n4. หากเลือกรูปแบบการชำระเงินโดยการโอนเงินผ่านธนาคาร ให้ทำตามขั้นตอน และส่งหลักฐานยืนยันการชำระเงินทางเว็บไซต์\n5. เมื่อชำระค่าสมัครและแจ้งการชำระค่าสมัครแล้ว ท่านจะได้รับอีเมล์ตอบกลับยืนยันการชำระเงินของท่าน พร้อม QR Code\nหมายเหตุ : ผู้สมัครไม่สามารถเปลี่ยนตัวผู้เข้าร่วมแข่งขันได้', '0', '2021-12-02 01:40:26', NULL),
(5, 'Farm Chokchai วิ่งๆ 1', 'Farm Chokchai วิ่งๆ 2', 'Farm Chokchai วิ่งๆ 3', 'Farm Chokchai วิ่งๆ 4', 'Farm Chokchai วิ่งๆ 5', 'Farm Chokchai วิ่งๆ 6', 'Farm Chokchai วิ่งๆ 7', 'Farm Chokchai วิ่งๆ 8', 1, 'RFF', 'Farm Chokchai วิ่งๆ 9', '1724811374387662.jpg', '1724998192259445.jpg', '1', '1', '1', '2022-03-01', '2022-03-31', '2022-03-01', '2022-03-31', '2022-03-01', '2022-03-25', '<p>เงื่อนไขการสมัคร :</p><p>1. ผู้สมัคร ต้องสมัครเป็นสมาชิกเว็บไซต์ www.farmchokchaisport.com ก่อน โดยเมื่อกรอกข้อมูลครบถ้วน ระบบจะส่งอีเมล์ ให้ผู้สมัคร ยืนยันตัวตน (Activate) และเข้าระบบเพื่อสมัครรายการกีฬาต่อไป</p><p>2. ระบบรับสมัครแบ่งออกเป็นแบบบุคคล และแบบกลุ่ม (สมัครให้เพื่อน)</p><p>3. กรอกข้อมูลผ่านระบบลงทะเบียนออนไลน์&nbsp; ผู้สมัครจะได้รับการตอบรับการสมัครรายการ หมายเลขอ้างอิงการสมัคร รูปแบบการชำระเงินให้กับท่านโดยอีเมล์</p><p>4. หากเลือกรูปแบบการชำระเงินโดยการโอนเงินผ่านธนาคาร ให้ทำตามขั้นตอน และส่งหลักฐานยืนยันการชำระเงินทางเว็บไซต์</p><p>5. เมื่อชำระค่าสมัครและแจ้งการชำระค่าสมัครแล้ว ท่านจะได้รับอีเมล์ตอบกลับยืนยันการชำระเงินของท่าน พร้อม QR Code</p><p>หมายเหตุ : ผู้สมัครไม่สามารถเปลี่ยนตัวผู้เข้าร่วมแข่งขันได้</p>', '0', '2022-02-14 02:56:16', '2022-02-17 19:15:47'),
(6, 'Tour de Farm 20', 'Tour de Farm 20', 'เป็นงานจักรยานของสุภาพบุรุษนักปั่น Peloton of Gentleman', 'เป็นงานจักรยานของสุภาพบุรุษนักปั่น Peloton of Gentleman', 'เป็นงานจักรยานของสุภาพบุรุษนักปั่น Peloton of Gentleman', 'เป็นงานจักรยานของสุภาพบุรุษนักปั่น Peloton of Gentleman', 'วันอาทิตย์ 22 ธันวาคม 2562 ฟาร์มโชคชัย 1 ก.ม. 159 ถ.มิตรภาพ หนองน้ำแดง ปากช่อง จ.นครราชสีมา', 'วันอาทิตย์ 22 ธันวาคม 2562 ฟาร์มโชคชัย 1 ก.ม. 159 ถ.มิตรภาพ หนองน้ำแดง ปากช่อง จ.นครราชสีมา', 2, 'TTD', 'https://g.page/ChokchaiSteakhouse?share', '1725070018472459.jpg', '1725070651769062.jpg', '1', '1', '0', '2022-04-12', '2022-04-15', '2022-04-12', '2022-04-15', '2022-02-18', '2022-02-18', '<p>เงื่อนไขการสมัคร :</p><p>1. ผู้สมัคร ต้องสมัครเป็นสมาชิกเว็บไซต์ www.farmchokchaisport.com ก่อน โดยเมื่อกรอกข้อมูลครบถ้วน ระบบจะส่งอีเมล์ ให้ผู้สมัคร ยืนยันตัวตน (Activate) และเข้าระบบเพื่อสมัครรายการกีฬาต่อไป</p><p>2. ระบบรับสมัครแบ่งออกเป็นแบบบุคคล และแบบกลุ่ม (สมัครให้เพื่อน)</p><p>3. กรอกข้อมูลผ่านระบบลงทะเบียนออนไลน์&nbsp; ผู้สมัครจะได้รับการตอบรับการสมัครรายการ หมายเลขอ้างอิงการสมัคร รูปแบบการชำระเงินให้กับท่านโดยอีเมล์</p><p>4. หากเลือกรูปแบบการชำระเงินโดยการโอนเงินผ่านธนาคาร ให้ทำตามขั้นตอน และส่งหลักฐานยืนยันการชำระเงินทางเว็บไซต์</p><p>5. เมื่อชำระค่าสมัครและแจ้งการชำระค่าสมัครแล้ว ท่านจะได้รับอีเมล์ตอบกลับยืนยันการชำระเงินของท่าน พร้อม QR Code</p><p>หมายเหตุ : ผู้สมัครไม่สามารถเปลี่ยนตัวผู้เข้าร่วมแข่งขันได้</p>', '1', '2022-02-17 20:29:30', '2022-02-20 19:22:09');

-- --------------------------------------------------------

--
-- Table structure for table `tournaments_sponsors`
--

CREATE TABLE `tournaments_sponsors` (
  `id` int(11) NOT NULL,
  `tournament_id` int(11) NOT NULL,
  `sponsors_id` int(11) NOT NULL,
  `deleted_at` char(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tournaments_sponsors`
--

INSERT INTO `tournaments_sponsors` (`id`, `tournament_id`, `sponsors_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(11, 5, 3, '0', '2022-02-17 20:21:26', NULL),
(12, 5, 1, '0', '2022-02-17 20:21:30', NULL),
(13, 5, 2, '0', '2022-02-17 20:21:32', NULL),
(14, 6, 3, '0', '2022-02-17 20:31:52', NULL),
(17, 6, 5, '0', '2022-02-18 02:28:31', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tournament_types`
--

CREATE TABLE `tournament_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_num` int(11) DEFAULT NULL,
  `tournament_id` int(11) NOT NULL,
  `name_th` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail_th` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail_en` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL,
  `distance` int(11) NOT NULL,
  `unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `release_start` time DEFAULT NULL,
  `type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `function` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'T=จับเวลา / O = รุ่นทั่วไป Open',
  `deleted_at` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tournament_types`
--

INSERT INTO `tournament_types` (`id`, `order_num`, `tournament_id`, `name_th`, `name_en`, `detail_th`, `detail_en`, `price`, `distance`, `unit`, `release_start`, `type`, `function`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '‘Fearless Gentlemen’ ระยะทาง 93  กม.', 'Fearless Gentlemen 93 กม.', 'เส้นทาง 93 กม. ของ ทัวร์ เดอ ฟาร์ม 8 ครั้งนี้ แตกต่างจากเส้นทาง ทัวร์ เดอ ฟาร์ม 7 100 กม โดยตัดเข้าถนนผ่านโรงเรียนลำทองหลาง ซึ่งเส้นทางนี้จะมีทางลงเขาที่ชันมาก ทำให้เป็นการปั่นลงเขาด้วยความเร็วสูง นักปั่นทุกท่านควรใช้ความระมัดระวัง ', 'This 93 km route of Tour de Farm 8 is different from the Tour de Farm 7 route 100 km by cycling through the road to Lam Thong Lang School.This path has a very steep downhill path resulting in a high-speed downhill ride. All cyclists should notice as a precaution.', 900.00, 93, 'K', '00:00:00', '2', 'T', NULL, '2021-12-02 01:51:01', NULL),
(2, 2, 1, '‘Going Greener’ ระยะทาง 68  กม.', '‘Going Greener’ 68 km.', 'เส้นทาง 93 กม. ของ ทัวร์ เดอ ฟาร์ม 8 ครั้งนี้ แตกต่างจากเส้นทาง ทัวร์ เดอ ฟาร์ม 7 100 กม โดยตัดเข้าถนนผ่านโรงเรียนลำทองหลาง ซึ่งเส้นทางนี้จะมีทางลงเขาที่ชันมาก ทำให้เป็นการปั่นลงเขาด้วยความเร็วสูง นักปั่นทุกท่านควรใช้ความระมัดระวัง ', 'This 93 km route of Tour de Farm 8 is different from the Tour de Farm 7 route 100 km by cycling through the road to Lam Thong Lang School.This path has a very steep downhill path resulting in a high-speed downhill ride. All cyclists should notice as a precaution.', 900.00, 68, 'K', '00:00:00', '2', 'O', NULL, '2021-12-02 01:51:01', NULL),
(3, 1, 2, 'ระยะทาง 15 กิโลเมตร', 'ระยะทาง 15 กิโลเมตร', '15 km เป็นระยะเต็ม ที่นักวิ่งจะได้สัมผัสกับทุกอย่างของวิถีการเกษตรแบบฟาร์มของฟาร์มโชคชัยและไร่สุวรรณ เหมาะสมกับนักวิ่งที่ความสามารถเคยวิ่งและซ้อมระยะนี้มาก่อน หรือแม้กระทั่งเคยผ่านการวิ่งระยะ Mini Marathon แต่ยังไม่ข้ามไป Half Marathon ก็สามารถท้าทายตัวเองด้วยระยะนี้ได้เหมือนกัน เพื่อจะได้สนุกกับเส้นทางอย่างเต็มที่', '15 km เป็นระยะเต็ม ที่นักวิ่งจะได้สัมผัสกับทุกอย่างของวิถีการเกษตรแบบฟาร์มของฟาร์มโชคชัยและไร่สุวรรณ เหมาะสมกับนักวิ่งที่ความสามารถเคยวิ่งและซ้อมระยะนี้มาก่อน หรือแม้กระทั่งเคยผ่านการวิ่งระยะ Mini Marathon แต่ยังไม่ข้ามไป Half Marathon ก็สามารถท้าทายตัวเองด้วยระยะนี้ได้เหมือนกัน เพื่อจะได้สนุกกับเส้นทางอย่างเต็มที่', 900.00, 15, 'K', '00:00:00', '1', 'T', NULL, '2021-12-02 01:51:01', NULL),
(4, 2, 2, 'ระยะทาง 10 กิโลเมตร', 'ระยะทาง 10 กิโลเมตร', '10 km เป็นระยะที่วิ่งในฟาร์มโชคชัยเต็มเส้นทาง และเข้าไปวิ่งในไร่สุวรรณเพียงบางส่วน เหมาะสมกับนักวิ่งที่ผ่านการวิ่งและซ้อมระยะ Mini Marathon มาแล้ว หรือหากจะท้ายทายตัวเองให้เป็น Mini Marathon ของตนเองครั้งแรกก็ได้เลยทีเดียว', '10 km เป็นระยะที่วิ่งในฟาร์มโชคชัยเต็มเส้นทาง และเข้าไปวิ่งในไร่สุวรรณเพียงบางส่วน เหมาะสมกับนักวิ่งที่ผ่านการวิ่งและซ้อมระยะ Mini Marathon มาแล้ว หรือหากจะท้ายทายตัวเองให้เป็น Mini Marathon ของตนเองครั้งแรกก็ได้เลยทีเดียว', 900.00, 10, 'K', '00:00:00', '1', 'T', NULL, '2021-12-02 01:51:01', NULL),
(5, 3, 2, 'ระยะทาง 5 กิโลเมตร', 'ระยะทาง 5 กิโลเมตร', '5 km เป็นระยะที่ได้สัมผัสกับบรรยากาศเส้นทางในฟาร์มโชคชัย เหมาะสมกับนักวิ่งที่ต้องการวิ่งแบบสบายๆ ไม่เร่งรีบมาก ซ้อมมาพอสมควร หรือจะเป็นระยะแรกของการเป็นนักวิ่งก็ได้ และไม่มีการจับเวลา', '5 km เป็นระยะที่ได้สัมผัสกับบรรยากาศเส้นทางในฟาร์มโชคชัย เหมาะสมกับนักวิ่งที่ต้องการวิ่งแบบสบายๆ ไม่เร่งรีบมาก ซ้อมมาพอสมควร หรือจะเป็นระยะแรกของการเป็นนักวิ่งก็ได้ และไม่มีการจับเวลา', 700.00, 5, 'K', '00:00:00', '1', 'O', NULL, '2021-12-02 01:51:01', NULL),
(8, 2, 5, '‘Fearless Gentlemen’ ระยะทาง 93  กม.', '‘Fearless Gentlemen’ ระยะทาง 93  กม.', '‘Fearless Gentlemen’ ระยะทาง 93  กม.', '‘Fearless Gentlemen’ ระยะทาง 93  กม.', 1300.00, 93, 'Km.', '20:00:00', '1', 'T', NULL, '2022-02-14 02:56:16', '2022-02-17 19:15:48'),
(9, 1, 5, '‘Going Greener’ ระยะทาง 68  กม.', '‘Going Greener’ ระยะทาง 68  กม.', '‘Going Greener’ ระยะทาง 68  กม.', '‘Going Greener’ ระยะทาง 68  กม.', 1200.00, 68, 'Km.', NULL, '1', 'O', NULL, '2022-02-14 02:56:16', '2022-02-17 19:15:47'),
(17, 1, 6, '‘Going Greener’ ระยะทาง 150  กม.', '‘Going Greener’ ระยะทาง 150  กม.', '‘Going Greener’ ระยะทาง 150  กม.', '‘Going Greener’ ระยะทาง 150  กม.', 1500.00, 150, 'Km.', '07:00:00', '2', 'T', NULL, '2022-02-17 20:29:30', '2022-02-20 19:09:29');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `sex` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `line_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telphone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `day` int(11) DEFAULT NULL,
  `months` int(11) DEFAULT NULL,
  `years` year(4) DEFAULT NULL,
  `citizen_type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `citizen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nationality` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blood` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disease` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amphoe` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `province` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zipCode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fEmergencyContact` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lEmergencyContact` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telEmergencyContact` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `club` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verify` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_users` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `provider_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verify_information` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `lname`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `sex`, `age`, `line_id`, `telphone`, `day`, `months`, `years`, `citizen_type`, `citizen`, `nationality`, `blood`, `disease`, `address`, `district`, `amphoe`, `province`, `country`, `zipCode`, `fEmergencyContact`, `lEmergencyContact`, `telEmergencyContact`, `owner`, `club`, `verify`, `deleted_at`, `is_users`, `provider_id`, `avatar`, `verify_information`) VALUES
(1, 'สายฟ้า', 'ไพรวรรณ์', 'dev.saifah8953@gmail.com', NULL, '$2y$10$L0BiTGJfMDlfLHNP4fvVNeMCNEpET9jt1ri4rh4WOONZvhQEaOA0.', NULL, '2022-01-16 20:55:20', '2022-01-16 20:54:13', 'M', NULL, NULL, '080-056-8953', 29, 10, 1996, '1', '1-1996-00196-24-6', 'ไทย', 'B', NULL, '81/6', 'ช่องสาริกา', 'พัฒนานิคม', 'ลพบุรี', 'ไทย', '15220', '-', '-', '080-056-8953', NULL, NULL, NULL, NULL, '1', '105115886037329277589', 'https://lh3.googleusercontent.com/a-/AOh14Gi8JhICUGb32CkGafU0gE3hzzE4KeoUbzfUtsak=s96-c', 1),
(2, 'วุฒธิพงศ์', 'สุเนตร', 'wuttipong002@hotmail.com', NULL, '$2y$10$uZzkFxZnTJkoWhHi.Yu.POwyFsxfjY7t6NiZZcHYzjbZ48mIyYSIe', NULL, '2022-01-16 23:59:29', '2022-01-16 23:55:43', 'M', NULL, NULL, '086-538-4052', 21, 3, 1990, '1', '1-2399-00140-50-4', 'ไทย', 'O', 'ไม่มีโรคประจำตัว', '53/154 ม.1', 'รังสิต', 'ธัญบุรี', 'ปทุมธานี', 'ไทย', '12110', 'วิวัฒน์', 'สุเนตร', '089-808-2836', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(3, 'วิญญู', 'เสาสมภพ', 'vinyu007@gmail.com', NULL, '$2y$10$c2jeq/7HsVnLBTAJ.uKpfO/TRxOim5muPVAMkb2IgGcUgjjgvBI1q', NULL, '2022-01-16 23:58:52', '2022-01-16 23:55:46', 'M', NULL, NULL, '086-528-7065', 25, 6, 1996, '1', '1-1037-02067-57-1', 'ไทย', 'B', 'ไม่มี', '48/183', 'คลองสาม', 'คลองหลวง', 'ปทุมธานี', 'ไทย', '12120', 'วริศรา', 'พานเงิน', '008-631-7428', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(4, 'ณัฐวุฒิ', 'เมืองทะ', 'maungta@gmail.com', NULL, '$2y$10$4Rxaw/8P5EZLlVYlLdBpMuaCus1UCpn0wSeFACYJTjHoEEcv7zPKy', NULL, '2022-01-16 23:58:55', '2022-01-16 23:56:04', 'M', NULL, NULL, '087-134-7136', 11, 1, 1984, '1', '1-2507-00009-04-0', 'ไทย', 'B', 'ภูมิแพ้อากาศ', '69', 'หนองขาม', 'จักราช', 'นครราชสีมา', 'ไทย', '30230', 'เรณู', 'เมืองทะ', '091-996-2449', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(5, 'Keng', 'bkk', 'bkklawyer2012@gmail.com', NULL, NULL, NULL, '2022-01-16 23:58:54', '2022-01-16 23:57:33', 'M', NULL, NULL, '083-700-0011', 1, 1, 1949, '1', '1-1111-11111-11-1', 'ไทย', 'B', NULL, '1', 'ประชาธิปัตย์', 'ธัญบุรี', 'Pathum Thani (ปทุมธานี)', 'ไทย', '12130', '-', '-', '083-700-0011', NULL, NULL, NULL, NULL, '1', 'U6425e259592e7728067602bfc969dca5', 'https://profile.line-scdn.net/0hnhL2EZ2rMUdxSx03DWJOEE0OPyoGZTcPCSx6dF1NPCVcfyVESy18JFVCPXFZfyMWHi8pdgFIb3cI', 1),
(6, 'ded', 'edde', 'nitipong.it@farmchokchai.net', NULL, NULL, NULL, '2022-01-17 00:01:35', NULL, 'M', NULL, NULL, '083-700-0011', 10, 10, 1941, '1', '1-1111-11111-11-1', 'ไทย', 'A', NULL, '2', 'ลำลูกกา', 'ลำลูกกา', 'ปทุมธานี', 'ไทย', '12130', 'ข', 'ข', '999-999-9999', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(7, 'พงศกร', 'สิงหเสรี', 'vorz7k1@gmail.com', NULL, NULL, NULL, '2022-01-17 00:50:41', '2022-01-17 00:43:40', 'M', NULL, NULL, '089-923-4668', 23, 8, 1982, '1', '3-1012-00157-76-5', 'ไทย', 'AB', NULL, '100/187', 'คูคต', 'ลำลูกกา', 'ปทุมธานี', 'ไทย', '12130', 'poommy', 'singhaseree', '089-999-9999', NULL, NULL, NULL, NULL, '1', '108137944294721288725', 'https://lh3.googleusercontent.com/a-/AOh14GgbXS3vDZoPPoULCgMf36UQfSOZ6E6lpiT-WGuBqw=s96-c', 1),
(8, 'poommy', 'singhaseree', 'vorz7k2@gmail.com', NULL, NULL, NULL, '2022-01-17 00:52:08', NULL, 'F', NULL, NULL, '089-999-9999', 13, 11, 1975, '1', '8-9898-98989-89', 'ไทย', 'AB', NULL, '11111', 'คูคต', 'ลำลูกกา', 'ปทุมธานี', 'ไทย', '12130', 'เก่ง', 'เก่ง', '089-923-4668', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(9, 'Saifah', 'Phaiwan', 'puttasa_fa@hotmail.com', NULL, NULL, NULL, '2022-01-17 19:46:02', '2022-01-17 19:43:37', 'M', NULL, NULL, '080-056-8953', 28, 10, 1996, '1', '1-1996-00196-24-6', 'ไทย', 'B', NULL, '81 หมู่ 6 ต.ช่องสาริกา อ.พัฒนานิคม จ.ลพบุรี', 'ช่องสาริกา', 'พัฒนานิคม', 'ลพบุรี', 'ไทย', '15220', '-', '-', '080-056-8953', NULL, NULL, NULL, NULL, '1', '4597129987041422', 'https://graph.facebook.com/v3.3/4597129987041422/picture?type=normal', 1),
(10, 'Dev.Phaiwan', '', 'farmchokchaisport2016@gmail.com', NULL, '$2y$10$L0BiTGJfMDlfLHNP4fvVNeMCNEpET9jt1ri4rh4WOONZvhQEaOA0.', 'bzPAfndyUpcRRHtABslLFFTziOEtC434W1UlN5QIFTWx0MLwQMPDcKsoksmo', '2022-01-19 23:22:44', '2022-01-19 23:27:54', 'M', NULL, NULL, '080-056-8953', 28, 10, 1996, '1', '1-1996-00196-24-6', 'ไทย', 'B', '-', '81/ m6', 'ช่องสาริกา', 'พัฒนานิคม', 'ลพบุรี', 'ไทย', '15220', '-', '-', '080-056-8953', NULL, NULL, NULL, NULL, '2', NULL, NULL, 1),
(14, 'Saifah', 'phaiwan', 'saifah1928@gmail.com', NULL, NULL, NULL, '2022-02-02 23:37:18', NULL, 'M', NULL, NULL, '080-056-8953', 14, 10, 1934, '1', '1-1889-54645-46-5', 'ไทย', 'AB', NULL, '87/45', 'คลองหนึ่ง', 'คลองหลวง', 'ปทุมธานี', 'ไทย', '12120', '-', '-', '080-056-8953', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(15, 'Phaiwan', '001', 'saifah19x28@gmail.com', NULL, NULL, NULL, '2022-02-02 23:51:06', NULL, 'M', NULL, NULL, '080-056-8953', 8, 9, 1937, '1', '1-9498-56566-55-4', 'ไทย', 'B', NULL, '89/99', 'คลองสามประเวศ', 'ลาดกระบัง', 'กรุงเทพมหานคร', 'ไทย', '10520', '-', '-', '080-056-8953', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(20, 'Admin Drive Thru', NULL, 'dev.saifahA@gmail.com', NULL, '$2y$10$UbhXLhr49/jCB7LZ8ftFpOgNkaly69BXwxIb4p.Lp.ljcbYxHfL4S', NULL, '2022-02-03 20:08:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `website`
--

CREATE TABLE `website` (
  `id` int(11) NOT NULL,
  `background` text DEFAULT NULL,
  `summernote_box1` text DEFAULT NULL,
  `summernote_box2` text DEFAULT NULL,
  `deleted_at` char(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `website`
--

INSERT INTO `website` (`id`, `background`, `summernote_box1`, `summernote_box2`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, '1725345724813702.jpg', '<h1 class=\"text-center\"><span style=\"color: rgb(255, 255, 255);\">\r\n                                FARM CHOK CHAI CHALLENCE YOUR FEAR TOUR DE FARM\r\n                            </span></h1>\r\n                            <p class=\"text-center\"><span style=\"color: rgb(247, 247, 247);\">\r\n                                เป็นมากกว่างานจักรยานแห่งปีแต่เป็นงานของสุภาพบุรุษนักปั่น.\r\n                            </span></p>  \r\n                            <ul class=\"ud-hero-buttons mt-3 mb-3\">\r\n                              <li>\r\n                                <a href=\"{{ route(\'event\') }}\" class=\"ud-main-btn ud-white-btn\">\r\n                                สมัครรายการแข่งขัน</a> \r\n                              </li> \r\n                            </ul>                           \r\n\r\n<iframe frameborder=\"0\" src=\"//www.youtube.com/embed/QrwAKGIjuAo\" width=\"100%\" class=\"note-video-clip\"></iframe>', '1725357196220202.text', '0', '2022-02-21 03:27:53', '2022-02-21 00:46:43');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bill_tems`
--
ALTER TABLE `bill_tems`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cart_sport_tems`
--
ALTER TABLE `cart_sport_tems`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fileimages`
--
ALTER TABLE `fileimages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `generations`
--
ALTER TABLE `generations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `option_items`
--
ALTER TABLE `option_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`(191));

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`(191),`tokenable_id`);

--
-- Indexes for table `promotion_codes`
--
ALTER TABLE `promotion_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `promotion_codes_sponsors`
--
ALTER TABLE `promotion_codes_sponsors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `race_programs`
--
ALTER TABLE `race_programs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `souvenirs`
--
ALTER TABLE `souvenirs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sponsors`
--
ALTER TABLE `sponsors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tournaments`
--
ALTER TABLE `tournaments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tournaments_sponsors`
--
ALTER TABLE `tournaments_sponsors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tournament_types`
--
ALTER TABLE `tournament_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `website`
--
ALTER TABLE `website`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bill_tems`
--
ALTER TABLE `bill_tems`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `cart_sport_tems`
--
ALTER TABLE `cart_sport_tems`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fileimages`
--
ALTER TABLE `fileimages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `generations`
--
ALTER TABLE `generations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `option_items`
--
ALTER TABLE `option_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `promotion_codes`
--
ALTER TABLE `promotion_codes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `promotion_codes_sponsors`
--
ALTER TABLE `promotion_codes_sponsors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `race_programs`
--
ALTER TABLE `race_programs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `souvenirs`
--
ALTER TABLE `souvenirs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sponsors`
--
ALTER TABLE `sponsors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tournaments`
--
ALTER TABLE `tournaments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tournaments_sponsors`
--
ALTER TABLE `tournaments_sponsors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `tournament_types`
--
ALTER TABLE `tournament_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `website`
--
ALTER TABLE `website`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
