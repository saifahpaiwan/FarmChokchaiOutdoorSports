-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 11, 2022 at 11:23 AM
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
(20, '2022020320', NULL, NULL, '1', '1', '2022-02-03 06:51:00', '1723723747745162.jpg', '1', 1, 700.00, 0.00, 700.00, NULL, NULL, '2022-02-02 23:51:06', NULL, 15, NULL);

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
(8, 9, 1, 1, 1, '5,8', 900.00, 0.00, 900.00, NULL, NULL, NULL, NULL, NULL, NULL, 9, '1', NULL, 1),
(9, 9, 2, 4, 17, '13', 900.00, 0.00, 900.00, NULL, NULL, NULL, NULL, NULL, NULL, 9, '1', NULL, 1),
(10, 1, 2, 4, 17, '12', 900.00, 0.00, 900.00, NULL, NULL, NULL, NULL, NULL, NULL, 1, '1', 6, 2),
(23, 14, 2, 5, 22, '13', 700.00, 0.00, 700.00, NULL, NULL, NULL, NULL, '2022-02-02 23:37:18', NULL, 10, '1', 19, 2),
(24, 15, 2, 5, 22, '14', 700.00, 0.00, 700.00, NULL, NULL, NULL, NULL, '2022-02-02 23:51:06', NULL, 10, '1', 20, 2);

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
  `detail_th` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail_en` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age_min` int(11) NOT NULL,
  `age_max` int(11) NOT NULL,
  `release_start` date NOT NULL,
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
(36, 5, 2, 4, 'รุ่นหญิงอายุ 60 ขึ้นไป', 'Ladies aged 60 and over', 'รุ่นหญิงอายุ 60 ขึ้นไป', 'Ladies aged 60 and over', 60, 100, '2021-12-30', 'F', NULL, '2021-12-02 01:56:45', NULL);

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
  `icon` char(255) COLLATE utf8mb4_unicode_ci NOT NULL
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
(7, 2, 'เบอร์ BIB', 'เบอร์ BIB', 'M0.png', '2', NULL, '2021-12-02 02:33:49', NULL, '');

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
(14, 5, 'size 2XL', 'chest (inches) 44', NULL, '2021-12-02 02:41:03', NULL);

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
(1, 1, 'Thai beverage Code Free 200 ฿', 'บริษัท ไทยเบฟเวอเรจ จำกัด รู้จักกันในชื่อ ไทยเบฟ เป็นบริษัทที่ใหญ่ที่สุดในประเทศไทยและหนึ่งในบริษัทเครื่องดื่มที่ใหญ่ที่สุดในเอเชียตะวันออกเฉียงใต้ ที่มีโรงกลั่นสุราในประเทศไทย', 'cjctzp', '1', '0', 1, 200.00, NULL, NULL, 'ผู้ออกโค้ด : Thai beverage', '2022-02-09 00:50:15', NULL, 10),
(2, 1, 'Thai beverage Code Free 200 ฿', 'บริษัท ไทยเบฟเวอเรจ จำกัด รู้จักกันในชื่อ ไทยเบฟ เป็นบริษัทที่ใหญ่ที่สุดในประเทศไทยและหนึ่งในบริษัทเครื่องดื่มที่ใหญ่ที่สุดในเอเชียตะวันออกเฉียงใต้ ที่มีโรงกลั่นสุราในประเทศไทย', '6kijbp', '1', '0', 1, 200.00, NULL, NULL, 'ผู้ออกโค้ด : Thai beverage', '2022-02-09 00:50:15', NULL, 10),
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
(17, 2, 'Code Free สปอนเซอร์ช้าง', 'เมื่อนึกถึงสปอนเซอร์หลัก ที่สนับสนุนวงการลูกหนังไทย มาอย่างต่อเนื่องเป็นเวลากว่า 20 ปี ทุกคนคงคิดถึง แบรนด์เครื่องดื่มตรา \"ช้าง\"', '8nqi8', '1', '0', 1, 100.00, NULL, NULL, 'สปอนเซอร์ช้าง', '2022-02-09 01:07:10', NULL, 10);

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
(27, 17, 2, NULL, '2022-02-09 01:07:10', NULL);

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
(21, 20, 24, 2, 5, 'M-3003', NULL, 15, NULL, NULL, NULL, NULL, NULL, '2', 'Admin', '-', NULL, '2022-02-02 23:51:07', NULL);

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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sponsors`
--

INSERT INTO `sponsors` (`id`, `name`, `detail`, `filename`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Thai beverage', 'Thai beverage', 'thaibeverage.png', NULL, '2022-02-07 07:46:20', NULL),
(2, 'Chang beer park', 'Chang beer park', 'changpark.png', NULL, '2022-02-07 07:46:20', NULL),
(3, 'ฟาร์มโชคชัย', 'โชคชัยสเต็กเฮ้าส์สาขาปากช่องขึ้นที่บริเวณหน้าฟาร์มโชคชัยอ. ปากช่องจ. นครราชสีมา', 'farmchokchai.png', NULL, '2022-02-07 07:46:20', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tournaments`
--

CREATE TABLE `tournaments` (
  `id` bigint(20) UNSIGNED NOT NULL,
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
  `register_start` date NOT NULL,
  `register_end` date NOT NULL,
  `event_start` date NOT NULL,
  `event_end` date NOT NULL,
  `remark` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tournaments`
--

INSERT INTO `tournaments` (`id`, `name_th`, `name_en`, `title_th`, `title_en`, `detail_th`, `detail_en`, `address_th`, `address_en`, `race_type`, `abbreviation`, `location`, `icon`, `imgname`, `status_event`, `status_register`, `status_pomotion`, `register_start`, `register_end`, `event_start`, `event_end`, `remark`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Farm Chokchai Tour de Farm 8', 'Farm Chokchai Tour de Farm 8', 'Farm Chokchai Tour de Farm 8 เป็นมากกว่างานจักรยานแห่งปี แต่เป็นงานจักรยานของสุภาพบุรุษนักปั่น Peloton of Gentleman', 'Farm Chokchai Tour de Farm 8 เป็นมากกว่างานจักรยานแห่งปี แต่เป็นงานจักรยานของสุภาพบุรุษนักปั่น Peloton of Gentleman', 'ฟาร์มโชคชัย เอ้าท์ดอร์ สปอร์ต ในนามของ กลุ่มบริษัทฟาร์มโชคชัย และบริษัท โชคชัยอินเตอร์เนชั่นแนล จำกัด ขอเชิญผู้ที่รักการปั่นทุกท่านเข้าร่วมในรายการจักรยานทางเรียบแห่งปี “Farm Chokchai Tour de Farm 8” ภายใต้ Concept “Transform Your Fear To Focus” เปลี่ยนความกลัวให้เป็นจุดมุ่งหมาย ในวันอาทิตย์ที่ 12 มกราคม 2563 ณ ฟาร์มโชคชัย 3 อำเภอปากช่อง จังหวัดนครราชสีมา', 'ฟาร์มโชคชัย เอ้าท์ดอร์ สปอร์ต ในนามของ กลุ่มบริษัทฟาร์มโชคชัย และบริษัท โชคชัยอินเตอร์เนชั่นแนล จำกัด ขอเชิญผู้ที่รักการปั่นทุกท่านเข้าร่วมในรายการจักรยานทางเรียบแห่งปี “Farm Chokchai Tour de Farm 8” ภายใต้ Concept “Transform Your Fear To Focus” เปลี่ยนความกลัวให้เป็นจุดมุ่งหมาย ในวันอาทิตย์ที่ 12 มกราคม 2563 ณ ฟาร์มโชคชัย 3 อำเภอปากช่อง จังหวัดนครราชสีมา', 'วันอาทิตย์ 12 มกราคม 2563 ฟาร์มโชคชัย 3 ถนนธนะรัชต์ กม.ที่ 12 หมูสี ปากช่อง จ.นครราชสีมา', 'วันอาทิตย์ 12 มกราคม 2563 ฟาร์มโชคชัย 3 ถนนธนะรัชต์ กม.ที่ 12 หมูสี ปากช่อง จ.นครราชสีมา', 2, 'TDF', 'url', 'tdf.jpg', 'tdf.jpg', '1', '1', '1', '2021-12-14', '2021-12-15', '2021-12-30', '2021-12-31', 'เงื่อนไขการสมัคร :\n1. ผู้สมัคร ต้องสมัครเป็นสมาชิกเว็บไซต์ www.farmchokchaisport.com ก่อน โดยเมื่อกรอกข้อมูลครบถ้วน ระบบจะส่งอีเมล์ ให้ผู้สมัคร ยืนยันตัวตน (Activate) และเข้าระบบเพื่อสมัครรายการกีฬาต่อไป\n2. ระบบรับสมัครแบ่งออกเป็นแบบบุคคล และแบบกลุ่ม (สมัครให้เพื่อน)\n3. กรอกข้อมูลผ่านระบบลงทะเบียนออนไลน์  ผู้สมัครจะได้รับการตอบรับการสมัครรายการ หมายเลขอ้างอิงการสมัคร รูปแบบการชำระเงินให้กับท่านโดยอีเมล์\n4. หากเลือกรูปแบบการชำระเงินโดยการโอนเงินผ่านธนาคาร ให้ทำตามขั้นตอน และส่งหลักฐานยืนยันการชำระเงินทางเว็บไซต์\n5. เมื่อชำระค่าสมัครและแจ้งการชำระค่าสมัครแล้ว ท่านจะได้รับอีเมล์ตอบกลับยืนยันการชำระเงินของท่าน พร้อม QR Code\nหมายเหตุ : ผู้สมัครไม่สามารถเปลี่ยนตัวผู้เข้าร่วมแข่งขันได้', NULL, '2021-12-02 01:40:26', NULL),
(2, 'Farm Chokchai Run de Farm', 'Farm Chokchai Run de Farm', 'หากไม่อยากพลาดอีกครั้ง กับงานวิ่งฤดูหนาว ตะลุยฟาร์มโชคชัย ทะลุไร่สุวรรณ Cow & Corn  farms cross country runs', 'หากไม่อยากพลาดอีกครั้ง กับงานวิ่งฤดูหนาว ตะลุยฟาร์มโชคชัย ทะลุไร่สุวรรณ Cow & Corn  farms cross country runs', 'ไม่ว่าจะสายพลัง สายชิล สายแชะ มาคนเดียว มาเป็นกลุ่ม หรือยกครอบครัว มาร่วมวิ่งอย่างสนุกสนาน ซึ่งในครั้งนี้มีการจับเวลา เพื่อหานักวิ่ง คิง ออฟ รัน เดอ ฟาร์ม “ King of Run de Farm” อันดับ 1 -3 ของกลุ่มอายุ และรางวัล Gentleman Awards สำหรับนักวิ่งทั้งชายและหญิง ที่มีน้ำใจเป็นนักกีฬา ช่วยเหลือ แบ่งปัน ฯ นอกจากนี้ ผู้เข้าร่วมงานทุกท่าน มีโอกาสได้รับรางวัล #คนรักษ์โลก เมื่อแสดงออกถึงความเป็นมิตรกับสิ่งแวดล้อม\r\n\r\nรัน เดอ ฟาร์ม นักวิ่งจะได้สัมผัสประสบการณ์ และทิวทัศน์ที่สวยงามท่ามกลางบรรยากาศของฟาร์มปศุสัตว์ของฟาร์มโชคชัย ชมวิว วัว ทุ่งหญ้า แปลงเพาะปลูกข้าวโพด เครื่องจักรการเกษตร พร้อมกันนั้นยังได้วิ่งเข้าไปสัมผัสกับไร่สุวรรณ ฟาร์มที่มีชื่อเสียงด้านข้าวโพดหวาน ได้ชมสถานที่สำคัญภายในเช่น พลับพลาที่ประทับของในหลวงรัชกาลที่ 9 แปลงเพาะปลูกข้าวโพด เครื่องจักรเกษตร เป็นต้น ท่ามกลางบรรยากาศความเย็นของฤดูหนาว  ณ ฟาร์มโชคชัย 1  และไร่สุวรรณ', 'ไม่ว่าจะสายพลัง สายชิล สายแชะ มาคนเดียว มาเป็นกลุ่ม หรือยกครอบครัว มาร่วมวิ่งอย่างสนุกสนาน ซึ่งในครั้งนี้มีการจับเวลา เพื่อหานักวิ่ง คิง ออฟ รัน เดอ ฟาร์ม “ King of Run de Farm” อันดับ 1 -3 ของกลุ่มอายุ และรางวัล Gentleman Awards สำหรับนักวิ่งทั้งชายและหญิง ที่มีน้ำใจเป็นนักกีฬา ช่วยเหลือ แบ่งปัน ฯ นอกจากนี้ ผู้เข้าร่วมงานทุกท่าน มีโอกาสได้รับรางวัล #คนรักษ์โลก เมื่อแสดงออกถึงความเป็นมิตรกับสิ่งแวดล้อม\r\n\r\nรัน เดอ ฟาร์ม นักวิ่งจะได้สัมผัสประสบการณ์ และทิวทัศน์ที่สวยงามท่ามกลางบรรยากาศของฟาร์มปศุสัตว์ของฟาร์มโชคชัย ชมวิว วัว ทุ่งหญ้า แปลงเพาะปลูกข้าวโพด เครื่องจักรการเกษตร พร้อมกันนั้นยังได้วิ่งเข้าไปสัมผัสกับไร่สุวรรณ ฟาร์มที่มีชื่อเสียงด้านข้าวโพดหวาน ได้ชมสถานที่สำคัญภายในเช่น พลับพลาที่ประทับของในหลวงรัชกาลที่ 9 แปลงเพาะปลูกข้าวโพด เครื่องจักรเกษตร เป็นต้น ท่ามกลางบรรยากาศความเย็นของฤดูหนาว  ณ ฟาร์มโชคชัย 1  และไร่สุวรรณ', 'วันอาทิตย์ 22 ธันวาคม 2562\r\nฟาร์มโชคชัย 1 ก.ม. 159 ถ.มิตรภาพ หนองน้ำแดง ปากช่อง จ.นครราชสีมา', 'วันอาทิตย์ 22 ธันวาคม 2562\r\nฟาร์มโชคชัย 1 ก.ม. 159 ถ.มิตรภาพ หนองน้ำแดง ปากช่อง จ.นครราชสีมา', 1, 'RDF', 'url', 'sm.png', 'rdf.jpg', '1', '1', '1', '2021-12-14', '2021-12-15', '2021-12-30', '2021-12-31', 'เงื่อนไขการสมัคร :\n1. ผู้สมัคร ต้องสมัครเป็นสมาชิกเว็บไซต์ www.farmchokchaisport.com ก่อน โดยเมื่อกรอกข้อมูลครบถ้วน ระบบจะส่งอีเมล์ ให้ผู้สมัคร ยืนยันตัวตน (Activate) และเข้าระบบเพื่อสมัครรายการกีฬาต่อไป\n2. ระบบรับสมัครแบ่งออกเป็นแบบบุคคล และแบบกลุ่ม (สมัครให้เพื่อน)\n3. กรอกข้อมูลผ่านระบบลงทะเบียนออนไลน์  ผู้สมัครจะได้รับการตอบรับการสมัครรายการ หมายเลขอ้างอิงการสมัคร รูปแบบการชำระเงินให้กับท่านโดยอีเมล์\n4. หากเลือกรูปแบบการชำระเงินโดยการโอนเงินผ่านธนาคาร ให้ทำตามขั้นตอน และส่งหลักฐานยืนยันการชำระเงินทางเว็บไซต์\n5. เมื่อชำระค่าสมัครและแจ้งการชำระค่าสมัครแล้ว ท่านจะได้รับอีเมล์ตอบกลับยืนยันการชำระเงินของท่าน พร้อม QR Code\nหมายเหตุ : ผู้สมัครไม่สามารถเปลี่ยนตัวผู้เข้าร่วมแข่งขันได้', NULL, '2021-12-02 01:40:26', NULL);

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
  `release_start` date NOT NULL,
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
(1, 1, 1, '‘Fearless Gentlemen’ ระยะทาง 93  กม.', 'Fearless Gentlemen 93 กม.', 'เส้นทาง 93 กม. ของ ทัวร์ เดอ ฟาร์ม 8 ครั้งนี้ แตกต่างจากเส้นทาง ทัวร์ เดอ ฟาร์ม 7 100 กม โดยตัดเข้าถนนผ่านโรงเรียนลำทองหลาง ซึ่งเส้นทางนี้จะมีทางลงเขาที่ชันมาก ทำให้เป็นการปั่นลงเขาด้วยความเร็วสูง นักปั่นทุกท่านควรใช้ความระมัดระวัง ', 'This 93 km route of Tour de Farm 8 is different from the Tour de Farm 7 route 100 km by cycling through the road to Lam Thong Lang School.This path has a very steep downhill path resulting in a high-speed downhill ride. All cyclists should notice as a precaution.', 900.00, 93, 'K', '2021-12-30', '2', 'T', NULL, '2021-12-02 01:51:01', NULL),
(2, 2, 1, '‘Going Greener’ ระยะทาง 68  กม.', '‘Going Greener’ 68 km.', 'เส้นทาง 93 กม. ของ ทัวร์ เดอ ฟาร์ม 8 ครั้งนี้ แตกต่างจากเส้นทาง ทัวร์ เดอ ฟาร์ม 7 100 กม โดยตัดเข้าถนนผ่านโรงเรียนลำทองหลาง ซึ่งเส้นทางนี้จะมีทางลงเขาที่ชันมาก ทำให้เป็นการปั่นลงเขาด้วยความเร็วสูง นักปั่นทุกท่านควรใช้ความระมัดระวัง ', 'This 93 km route of Tour de Farm 8 is different from the Tour de Farm 7 route 100 km by cycling through the road to Lam Thong Lang School.This path has a very steep downhill path resulting in a high-speed downhill ride. All cyclists should notice as a precaution.', 900.00, 68, 'K', '2021-12-30', '2', 'O', NULL, '2021-12-02 01:51:01', NULL),
(3, 1, 2, 'ระยะทาง 15 กิโลเมตร', 'ระยะทาง 15 กิโลเมตร', '15 km เป็นระยะเต็ม ที่นักวิ่งจะได้สัมผัสกับทุกอย่างของวิถีการเกษตรแบบฟาร์มของฟาร์มโชคชัยและไร่สุวรรณ เหมาะสมกับนักวิ่งที่ความสามารถเคยวิ่งและซ้อมระยะนี้มาก่อน หรือแม้กระทั่งเคยผ่านการวิ่งระยะ Mini Marathon แต่ยังไม่ข้ามไป Half Marathon ก็สามารถท้าทายตัวเองด้วยระยะนี้ได้เหมือนกัน เพื่อจะได้สนุกกับเส้นทางอย่างเต็มที่', '15 km เป็นระยะเต็ม ที่นักวิ่งจะได้สัมผัสกับทุกอย่างของวิถีการเกษตรแบบฟาร์มของฟาร์มโชคชัยและไร่สุวรรณ เหมาะสมกับนักวิ่งที่ความสามารถเคยวิ่งและซ้อมระยะนี้มาก่อน หรือแม้กระทั่งเคยผ่านการวิ่งระยะ Mini Marathon แต่ยังไม่ข้ามไป Half Marathon ก็สามารถท้าทายตัวเองด้วยระยะนี้ได้เหมือนกัน เพื่อจะได้สนุกกับเส้นทางอย่างเต็มที่', 900.00, 15, 'K', '2021-12-30', '1', 'T', NULL, '2021-12-02 01:51:01', NULL),
(4, 2, 2, 'ระยะทาง 10 กิโลเมตร', 'ระยะทาง 10 กิโลเมตร', '10 km เป็นระยะที่วิ่งในฟาร์มโชคชัยเต็มเส้นทาง และเข้าไปวิ่งในไร่สุวรรณเพียงบางส่วน เหมาะสมกับนักวิ่งที่ผ่านการวิ่งและซ้อมระยะ Mini Marathon มาแล้ว หรือหากจะท้ายทายตัวเองให้เป็น Mini Marathon ของตนเองครั้งแรกก็ได้เลยทีเดียว', '10 km เป็นระยะที่วิ่งในฟาร์มโชคชัยเต็มเส้นทาง และเข้าไปวิ่งในไร่สุวรรณเพียงบางส่วน เหมาะสมกับนักวิ่งที่ผ่านการวิ่งและซ้อมระยะ Mini Marathon มาแล้ว หรือหากจะท้ายทายตัวเองให้เป็น Mini Marathon ของตนเองครั้งแรกก็ได้เลยทีเดียว', 900.00, 10, 'K', '2021-12-30', '1', 'T', NULL, '2021-12-02 01:51:01', NULL),
(5, 3, 2, 'ระยะทาง 5 กิโลเมตร', 'ระยะทาง 5 กิโลเมตร', '5 km เป็นระยะที่ได้สัมผัสกับบรรยากาศเส้นทางในฟาร์มโชคชัย เหมาะสมกับนักวิ่งที่ต้องการวิ่งแบบสบายๆ ไม่เร่งรีบมาก ซ้อมมาพอสมควร หรือจะเป็นระยะแรกของการเป็นนักวิ่งก็ได้ และไม่มีการจับเวลา', '5 km เป็นระยะที่ได้สัมผัสกับบรรยากาศเส้นทางในฟาร์มโชคชัย เหมาะสมกับนักวิ่งที่ต้องการวิ่งแบบสบายๆ ไม่เร่งรีบมาก ซ้อมมาพอสมควร หรือจะเป็นระยะแรกของการเป็นนักวิ่งก็ได้ และไม่มีการจับเวลา', 700.00, 5, 'K', '2021-12-30', '1', 'O', NULL, '2021-12-02 01:51:01', NULL);

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
(1, 'สายฟ้า', 'ไพรวรรณ์', 'dev.saifah8953@gmail.com', NULL, NULL, NULL, '2022-01-16 20:55:20', '2022-01-16 20:54:13', 'M', NULL, NULL, '080-056-8953', 29, 10, 1996, '1', '1-1996-00196-24-6', 'ไทย', 'B', NULL, '81/6', 'ช่องสาริกา', 'พัฒนานิคม', 'ลพบุรี', 'ไทย', '15220', '-', '-', '080-056-8953', NULL, NULL, NULL, NULL, '1', '105115886037329277589', 'https://lh3.googleusercontent.com/a-/AOh14Gi8JhICUGb32CkGafU0gE3hzzE4KeoUbzfUtsak=s96-c', 1),
(2, 'วุฒธิพงศ์', 'สุเนตร', 'wuttipong002@hotmail.com', NULL, '$2y$10$uZzkFxZnTJkoWhHi.Yu.POwyFsxfjY7t6NiZZcHYzjbZ48mIyYSIe', NULL, '2022-01-16 23:59:29', '2022-01-16 23:55:43', 'M', NULL, NULL, '086-538-4052', 21, 3, 1990, '1', '1-2399-00140-50-4', 'ไทย', 'O', 'ไม่มีโรคประจำตัว', '53/154 ม.1', 'รังสิต', 'ธัญบุรี', 'ปทุมธานี', 'ไทย', '12110', 'วิวัฒน์', 'สุเนตร', '089-808-2836', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(3, 'วิญญู', 'เสาสมภพ', 'vinyu007@gmail.com', NULL, '$2y$10$c2jeq/7HsVnLBTAJ.uKpfO/TRxOim5muPVAMkb2IgGcUgjjgvBI1q', NULL, '2022-01-16 23:58:52', '2022-01-16 23:55:46', 'M', NULL, NULL, '086-528-7065', 25, 6, 1996, '1', '1-1037-02067-57-1', 'ไทย', 'B', 'ไม่มี', '48/183', 'คลองสาม', 'คลองหลวง', 'ปทุมธานี', 'ไทย', '12120', 'วริศรา', 'พานเงิน', '008-631-7428', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(4, 'ณัฐวุฒิ', 'เมืองทะ', 'maungta@gmail.com', NULL, '$2y$10$4Rxaw/8P5EZLlVYlLdBpMuaCus1UCpn0wSeFACYJTjHoEEcv7zPKy', NULL, '2022-01-16 23:58:55', '2022-01-16 23:56:04', 'M', NULL, NULL, '087-134-7136', 11, 1, 1984, '1', '1-2507-00009-04-0', 'ไทย', 'B', 'ภูมิแพ้อากาศ', '69', 'หนองขาม', 'จักราช', 'นครราชสีมา', 'ไทย', '30230', 'เรณู', 'เมืองทะ', '091-996-2449', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(5, 'Keng', 'bkk', 'bkklawyer2012@gmail.com', NULL, NULL, NULL, '2022-01-16 23:58:54', '2022-01-16 23:57:33', 'M', NULL, NULL, '083-700-0011', 1, 1, 1949, '1', '1-1111-11111-11-1', 'ไทย', 'B', NULL, '1', 'ประชาธิปัตย์', 'ธัญบุรี', 'Pathum Thani (ปทุมธานี)', 'ไทย', '12130', '-', '-', '083-700-0011', NULL, NULL, NULL, NULL, '1', 'U6425e259592e7728067602bfc969dca5', 'https://profile.line-scdn.net/0hnhL2EZ2rMUdxSx03DWJOEE0OPyoGZTcPCSx6dF1NPCVcfyVESy18JFVCPXFZfyMWHi8pdgFIb3cI', 1),
(6, 'ded', 'edde', 'nitipong.it@farmchokchai.net', NULL, NULL, NULL, '2022-01-17 00:01:35', NULL, 'M', NULL, NULL, '083-700-0011', 10, 10, 1941, '1', '1-1111-11111-11-1', 'ไทย', 'A', NULL, '2', 'ลำลูกกา', 'ลำลูกกา', 'ปทุมธานี', 'ไทย', '12130', 'ข', 'ข', '999-999-9999', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(7, 'พงศกร', 'สิงหเสรี', 'vorz7k1@gmail.com', NULL, NULL, NULL, '2022-01-17 00:50:41', '2022-01-17 00:43:40', 'M', NULL, NULL, '089-923-4668', 23, 8, 1982, '1', '3-1012-00157-76-5', 'ไทย', 'AB', NULL, '100/187', 'คูคต', 'ลำลูกกา', 'ปทุมธานี', 'ไทย', '12130', 'poommy', 'singhaseree', '089-999-9999', NULL, NULL, NULL, NULL, '1', '108137944294721288725', 'https://lh3.googleusercontent.com/a-/AOh14GgbXS3vDZoPPoULCgMf36UQfSOZ6E6lpiT-WGuBqw=s96-c', 1),
(8, 'poommy', 'singhaseree', 'vorz7k2@gmail.com', NULL, NULL, NULL, '2022-01-17 00:52:08', NULL, 'F', NULL, NULL, '089-999-9999', 13, 11, 1975, '1', '8-9898-98989-89', 'ไทย', 'AB', NULL, '11111', 'คูคต', 'ลำลูกกา', 'ปทุมธานี', 'ไทย', '12130', 'เก่ง', 'เก่ง', '089-923-4668', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(9, 'Saifah', 'Phaiwan', 'puttasa_fa@hotmail.com', NULL, NULL, NULL, '2022-01-17 19:46:02', '2022-01-17 19:43:37', 'M', NULL, NULL, '080-056-8953', 28, 10, 1996, '1', '1-1996-00196-24-6', 'ไทย', 'B', NULL, '81 หมู่ 6 ต.ช่องสาริกา อ.พัฒนานิคม จ.ลพบุรี', 'ช่องสาริกา', 'พัฒนานิคม', 'ลพบุรี', 'ไทย', '15220', '-', '-', '080-056-8953', NULL, NULL, NULL, NULL, '1', '4597129987041422', 'https://graph.facebook.com/v3.3/4597129987041422/picture?type=normal', 1),
(10, 'Dev.Phaiwan', '', 'farmchokchaisport2016@gmail.com', NULL, '$2y$10$L0BiTGJfMDlfLHNP4fvVNeMCNEpET9jt1ri4rh4WOONZvhQEaOA0.', 'TygbnW7OH7QK2vNlllRnW0IxkQlw4E7J3IooMPcURGvsLBKb8O27hPsAMG2m', '2022-01-19 23:22:44', '2022-01-19 23:27:54', 'M', NULL, NULL, '080-056-8953', 28, 10, 1996, '1', '1-1996-00196-24-6', 'ไทย', 'B', '-', '81/ m6', 'ช่องสาริกา', 'พัฒนานิคม', 'ลพบุรี', 'ไทย', '15220', '-', '-', '080-056-8953', NULL, NULL, NULL, NULL, '2', NULL, NULL, 1),
(14, 'Saifah', 'phaiwan', 'saifah1928@gmail.com', NULL, NULL, NULL, '2022-02-02 23:37:18', NULL, 'M', NULL, NULL, '080-056-8953', 14, 10, 1934, '1', '1-1889-54645-46-5', 'ไทย', 'AB', NULL, '87/45', 'คลองหนึ่ง', 'คลองหลวง', 'ปทุมธานี', 'ไทย', '12120', '-', '-', '080-056-8953', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(15, 'Phaiwan', '001', 'saifah19x28@gmail.com', NULL, NULL, NULL, '2022-02-02 23:51:06', NULL, 'M', NULL, NULL, '080-056-8953', 8, 9, 1937, '1', '1-9498-56566-55-4', 'ไทย', 'B', NULL, '89/99', 'คลองสามประเวศ', 'ลาดกระบัง', 'กรุงเทพมหานคร', 'ไทย', '10520', '-', '-', '080-056-8953', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(20, 'Admin Drive Thru', NULL, 'dev.saifahA@gmail.com', NULL, '$2y$10$UbhXLhr49/jCB7LZ8ftFpOgNkaly69BXwxIb4p.Lp.ljcbYxHfL4S', NULL, '2022-02-03 20:08:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL);

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
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bill_tems`
--
ALTER TABLE `bill_tems`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `cart_sport_tems`
--
ALTER TABLE `cart_sport_tems`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `option_items`
--
ALTER TABLE `option_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `promotion_codes`
--
ALTER TABLE `promotion_codes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `promotion_codes_sponsors`
--
ALTER TABLE `promotion_codes_sponsors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `race_programs`
--
ALTER TABLE `race_programs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `souvenirs`
--
ALTER TABLE `souvenirs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sponsors`
--
ALTER TABLE `sponsors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tournament_types`
--
ALTER TABLE `tournament_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
