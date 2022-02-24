-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 24, 2022 at 03:37 PM
-- Server version: 5.6.48
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_sport`
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
  `note` text COLLATE utf8mb4_unicode_ci,
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
(1, '202202241', NULL, NULL, '1', '1', '2022-02-24 07:17:00', '1725627932966299.jpg', '1', 1, 2500.00, 300.00, 2200.00, 'เจ้าหน้าที่การเงิน คุณ สวรรค์ สรรสร้าง', NULL, '2022-02-24 00:17:19', '2022-02-24 00:46:01', 28, NULL),
(2, '202202242', NULL, NULL, '1', '1', '2022-02-24 07:21:00', '1725628204919363.jpg', '1', 1, 1800.00, 350.00, 1450.00, 'เจ้าหน้าที่การเงิน คุณ สวรรค์ สรรสร้าง', NULL, '2022-02-24 00:21:38', '2022-02-24 00:45:31', 31, NULL),
(3, '202202243', NULL, NULL, '1', '1', '2022-02-24 07:29:00', '1725628853040934.jpg', '1', 1, 1800.00, 200.00, 1600.00, 'เจ้าหน้าที่การเงิน คุณ ปอปลา ตากลม', NULL, '2022-02-24 00:31:56', '2022-02-24 00:44:46', 32, NULL),
(4, '202202244', NULL, NULL, '1', '1', '2022-02-24 07:42:00', '1725629492319151.jpg', '1', 1, 900.00, 0.00, 900.00, 'เจ้าหน้าที่การเงิน คุณ ปอปลา ตากลม', NULL, '2022-02-24 00:42:06', '2022-02-24 00:44:03', 32, NULL);

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
(1, 28, 1, 2, 1, '5,8', 900.00, 150.00, 750.00, 5, 'hxii44i', 'วิ่งสู้ฟัด', NULL, '2022-02-24 00:12:30', '2022-02-24 00:16:53', 28, '2', 1, 2),
(2, 29, 1, 2, 1, '3,7', 900.00, 150.00, 750.00, 4, '7557m9', 'วิ่งสู้ฟัด', NULL, '2022-02-24 00:15:09', '2022-02-24 00:16:53', 28, '2', 1, 2),
(3, 30, 1, 1, 11, '5,8', 700.00, 0.00, 700.00, NULL, NULL, 'วิ่งสู้ฟัด', NULL, '2022-02-24 00:16:41', '2022-02-24 00:16:53', 28, '2', 1, 2),
(4, 31, 1, 2, 2, '6,8', 900.00, 150.00, 750.00, 1, '9qswnt', NULL, NULL, NULL, NULL, 31, '1', 2, 2),
(5, 31, 2, 4, 14, '15', 900.00, 200.00, 700.00, 10, '42et5j', NULL, NULL, NULL, NULL, 31, '1', 2, 2),
(6, 32, 2, 4, 17, '12', 900.00, 0.00, 900.00, NULL, NULL, 'ปั่นกู้โลก', NULL, '2022-02-24 00:27:10', '2022-02-24 00:29:44', 32, '2', 3, 2),
(7, 33, 2, 4, 18, '14', 900.00, 200.00, 700.00, 9, 'mso1k5', 'ปั่นกู้โลก', NULL, '2022-02-24 00:29:27', '2022-02-24 00:29:44', 32, '2', 3, 2),
(9, 34, 2, 4, 18, '15', 900.00, 0.00, 900.00, NULL, NULL, 'ปั่นกู้โลก', NULL, '2022-02-24 00:40:13', '2022-02-24 00:41:52', 32, '2', 4, 2);

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
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
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
(1, 1, 1, 2, 'รุ่นชายอายุ 18-29 ปี', 'Male models aged 18-29 years', NULL, NULL, 18, 29, NULL, 'M', NULL, NULL, '2022-02-24 00:10:20'),
(2, 2, 1, 2, 'รุ่นชายอายุ 30-39 ปี', 'Male models aged 30-39 years', NULL, NULL, 30, 39, NULL, 'M', NULL, NULL, '2022-02-24 00:10:20'),
(3, 3, 1, 2, 'รุ่นชายอายุ 40-49 ปี', 'Male models aged 40-49 years', NULL, NULL, 40, 49, NULL, 'M', NULL, NULL, '2022-02-24 00:10:20'),
(4, 4, 1, 2, 'รุ่นชายอายุ 50-59 ปี', 'Male models aged 50-59 years', NULL, NULL, 50, 59, NULL, 'M', NULL, NULL, '2022-02-24 00:10:20'),
(5, 5, 1, 2, 'รุ่นชายอายุ 60 ขึ้นไป', 'Males aged 60 and over', NULL, NULL, 60, 100, NULL, 'M', NULL, NULL, '2022-02-24 00:10:20'),
(6, 6, 1, 2, 'รุ่นหญิงอายุ 18-29 ปี', 'Ladies models aged 18-29 years', NULL, NULL, 18, 29, NULL, 'F', NULL, NULL, '2022-02-24 00:10:20'),
(7, 7, 1, 2, 'รุ่นหญิงอายุ 30-39 ปี', 'Ladies models aged 30-39 years', NULL, NULL, 30, 39, NULL, 'F', NULL, NULL, '2022-02-24 00:10:20'),
(8, 8, 1, 2, 'รุ่นหญิงอายุ 40-49 ปี', 'Ladies models aged 40-49 years', NULL, NULL, 40, 49, NULL, 'F', NULL, NULL, '2022-02-24 00:10:20'),
(9, 9, 1, 2, 'รุ่นหญิงอายุ 50-59 ปี', 'Ladies models aged 50-59 years', NULL, NULL, 50, 59, NULL, 'F', NULL, NULL, '2022-02-24 00:10:20'),
(10, 10, 1, 2, 'รุ่นหญิงอายุ 60 ขึ้นไป', 'Ladies aged 60 and over', NULL, NULL, 60, 100, NULL, 'F', NULL, NULL, '2022-02-24 00:10:20'),
(11, 11, 1, 1, 'รุ่นชาย Open', 'Open version', NULL, NULL, 18, 100, NULL, 'M', NULL, NULL, '2022-02-24 00:10:20'),
(12, 12, 1, 1, 'รุ่นหญิง Open', 'Open version', NULL, NULL, 18, 100, NULL, 'F', NULL, NULL, '2022-02-24 00:10:20'),
(13, 1, 2, 4, 'รุ่นชายอายุ 18-29 ปี', 'Male models aged 18-29 years', NULL, NULL, 18, 29, NULL, 'M', NULL, NULL, '2022-02-24 00:02:30'),
(14, 2, 2, 4, 'รุ่นชายอายุ 30-39 ปี', 'Male models aged 30-39 years', NULL, NULL, 30, 39, NULL, 'M', NULL, NULL, '2022-02-24 00:02:30'),
(15, 3, 2, 4, 'รุ่นชายอายุ 40-49 ปี', 'Male models aged 40-49 years', NULL, NULL, 40, 49, NULL, 'M', NULL, NULL, '2022-02-24 00:02:30'),
(16, 4, 2, 4, 'รุ่นชายอายุ 50-59 ปี', 'Male models aged 50-59 years', NULL, NULL, 50, 59, NULL, 'M', NULL, NULL, '2022-02-24 00:02:30'),
(17, 5, 2, 4, 'รุ่นชายอายุ 60 ขึ้นไป', 'Males aged 60 and over', NULL, NULL, 60, 100, NULL, 'M', NULL, NULL, '2022-02-24 00:02:30'),
(18, 6, 2, 4, 'รุ่นหญิงทั่วไป', 'Ladies open', NULL, NULL, 5, 100, NULL, 'F', NULL, NULL, '2022-02-24 00:02:30'),
(19, 7, 2, 3, 'รุ่นชาย Open', 'Male open', NULL, NULL, 5, 100, NULL, 'M', NULL, NULL, '2022-02-24 00:02:30'),
(20, 8, 2, 3, 'รุ่นหญิง Open', 'Ladies open', NULL, NULL, 5, 100, NULL, 'F', NULL, NULL, '2022-02-24 00:02:30');

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
(1, 1, 'เสื้อแข่งขัน RDF', 'เสื้อแข่งขัน RDF', '1725626313996540.jpg', '1', NULL, '2022-02-23 23:51:35', NULL, NULL),
(2, 1, 'Chokchai Steakburger (Full option) Kurobuta + Sausage + Coke', 'Chokchai Steakburger (Full option) Kurobuta + Sausage + Coke', '1725626349463652.jpg', '1', NULL, '2022-02-23 23:52:09', NULL, NULL),
(3, 1, 'อุปกรณ์เสริม', 'อุปกรณ์เสริม', '1725626426037909.jpg', '2', NULL, '2022-02-23 23:53:22', NULL, NULL),
(4, 2, 'เสื้อแข่งขัน TDF', 'เสื้อแข่งขัน TDF', '1725626961051495.jpg', '1', NULL, '2022-02-24 00:01:52', NULL, NULL),
(5, 2, 'Chokchai Steakburger (Full option) Kurobuta + Sausage + Coke', 'Chokchai Steakburger (Full option) Kurobuta + Sausage + Coke', '1725626994370213.jpg', '2', NULL, '2022-02-24 00:02:24', NULL, NULL);

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
(1, 1, 'size XS', 'chest (inches) 34', NULL, '2022-02-23 23:51:35', NULL),
(2, 1, 'size S', 'chest (inches) 36', NULL, '2022-02-23 23:51:35', NULL),
(3, 1, 'size M', 'chest (inches) 38', NULL, '2022-02-23 23:51:35', NULL),
(4, 1, 'size L', 'chest (inches) 40', NULL, '2022-02-23 23:51:35', NULL),
(5, 1, 'size XL', 'chest (inches) 42', NULL, '2022-02-23 23:51:35', NULL),
(6, 1, 'size 2XL', 'chest (inches) 44', NULL, '2022-02-23 23:51:35', NULL),
(7, 2, 'Steakburger หมู', 'Steakburger หมู', NULL, '2022-02-23 23:52:09', NULL),
(8, 2, 'Steakburger เนื้อ', 'Steakburger เนื้อ', NULL, '2022-02-23 23:52:09', NULL),
(9, 3, 'ไฟฉายไซต์ M', 'ไฟฉายไซต์ M', NULL, '2022-02-23 23:53:22', NULL),
(10, 4, 'size XS', 'chest (inches) 34', NULL, '2022-02-24 00:01:52', NULL),
(11, 4, 'size S', 'chest (inches) 36', NULL, '2022-02-24 00:01:52', NULL),
(12, 4, 'size M', 'chest (inches) 38', NULL, '2022-02-24 00:01:52', NULL),
(13, 4, 'size L', 'chest (inches) 40', NULL, '2022-02-24 00:01:52', NULL),
(14, 4, 'size XL', 'chest (inches) 42', NULL, '2022-02-24 00:01:52', NULL),
(15, 4, 'size 2XL', 'chest (inches) 44', NULL, '2022-02-24 00:01:52', NULL),
(16, 5, 'สเต็คเบอร์เกอร์ หมู', 'สเต็คเบอร์เกอร์ หมู', NULL, '2022-02-24 00:02:24', NULL);

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
  `abilities` text COLLATE utf8mb4_unicode_ci,
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
  `detail` text COLLATE utf8mb4_unicode_ci,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '0=ปิดใช้, 1=เปิดใช้, 2=ถูกใช้แล้ว, 3=ยกเลิก',
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
(1, 1, 'chokchai steakhouse code free 150฿', 'chokchai steakhouse code free 150฿', '9qswnt', '2', '1', 1, 150.00, 31, '2022-02-24 00:19:52', 'ร้าน chokchai steakhouse แจกโค้ดส่วนลด 150฿', '2022-02-24 00:05:01', NULL, 10),
(2, 1, 'chokchai steakhouse code free 150฿', 'chokchai steakhouse code free 150฿', '3762hk', '1', '0', 1, 150.00, NULL, NULL, 'ร้าน chokchai steakhouse แจกโค้ดส่วนลด 150฿', '2022-02-24 00:05:01', NULL, 10),
(3, 1, 'chokchai steakhouse code free 150฿', 'chokchai steakhouse code free 150฿', 'pndrh6', '1', '0', 1, 150.00, NULL, NULL, 'ร้าน chokchai steakhouse แจกโค้ดส่วนลด 150฿', '2022-02-24 00:05:01', NULL, 10),
(4, 1, 'chokchai steakhouse code free 150฿', 'chokchai steakhouse code free 150฿', '7557m9', '2', '1', 1, 150.00, 29, '2022-02-24 00:15:09', 'ร้าน chokchai steakhouse แจกโค้ดส่วนลด 150฿', '2022-02-24 00:05:01', '2022-02-24 00:15:09', 10),
(5, 1, 'chokchai steakhouse code free 150฿', 'chokchai steakhouse code free 150฿', 'hxii44i', '2', '1', 1, 150.00, 28, '2022-02-24 00:12:30', 'ร้าน chokchai steakhouse แจกโค้ดส่วนลด 150฿', '2022-02-24 00:05:01', '2022-02-24 00:12:30', 10),
(6, 2, 'Chang beer park แจกโค้ดส่วนลด 200฿', 'Chang beer park แจกโค้ดส่วนลด 200฿', '883stg', '1', '0', 1, 200.00, NULL, NULL, 'สปอนเซอร์ Chang beer park  5  โค้ด', '2022-02-24 00:06:10', NULL, 10),
(7, 2, 'Chang beer park แจกโค้ดส่วนลด 200฿', 'Chang beer park แจกโค้ดส่วนลด 200฿', '8uxiud', '1', '0', 1, 200.00, NULL, NULL, 'สปอนเซอร์ Chang beer park  5  โค้ด', '2022-02-24 00:06:10', NULL, 10),
(8, 2, 'Chang beer park แจกโค้ดส่วนลด 200฿', 'Chang beer park แจกโค้ดส่วนลด 200฿', 'bqjs26', '1', '0', 1, 200.00, NULL, NULL, 'สปอนเซอร์ Chang beer park  5  โค้ด', '2022-02-24 00:06:10', NULL, 10),
(9, 2, 'Chang beer park แจกโค้ดส่วนลด 200฿', 'Chang beer park แจกโค้ดส่วนลด 200฿', 'mso1k5', '2', '1', 1, 200.00, 33, '2022-02-24 00:29:27', 'สปอนเซอร์ Chang beer park  5  โค้ด', '2022-02-24 00:06:10', '2022-02-24 00:29:27', 10),
(10, 2, 'Chang beer park แจกโค้ดส่วนลด 200฿', 'Chang beer park แจกโค้ดส่วนลด 200฿', '42et5j', '2', '1', 1, 200.00, 31, '2022-02-24 00:21:21', 'สปอนเซอร์ Chang beer park  5  โค้ด', '2022-02-24 00:06:10', NULL, 10);

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
(1, 1, 3, NULL, '2022-02-24 00:05:01', NULL),
(2, 2, 3, NULL, '2022-02-24 00:05:01', NULL),
(3, 3, 3, NULL, '2022-02-24 00:05:01', NULL),
(4, 4, 3, NULL, '2022-02-24 00:05:01', NULL),
(5, 5, 3, NULL, '2022-02-24 00:05:01', NULL),
(6, 6, 2, NULL, '2022-02-24 00:06:10', NULL),
(7, 7, 2, NULL, '2022-02-24 00:06:10', NULL),
(8, 8, 2, NULL, '2022-02-24 00:06:10', NULL),
(9, 9, 2, NULL, '2022-02-24 00:06:10', NULL),
(10, 10, 2, NULL, '2022-02-24 00:06:10', NULL);

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
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
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
(1, 4, 9, 2, 4, '6001', NULL, 34, '07:00:00', '08:25:00', NULL, NULL, '1', '2', 'ณัฐวุฒิ เมืองทะ', '0956586548', NULL, '2022-02-24 00:44:03', '2022-02-24 00:56:00'),
(2, 3, 6, 2, 4, '5001', NULL, 32, '07:00:00', '08:11:00', NULL, NULL, '1', '2', 'นิติพงศ์ ธนาพิสุทธิวงศ์', '0959286548', NULL, '2022-02-24 00:44:46', '2022-02-24 01:18:48'),
(3, 3, 7, 2, 4, '6002', NULL, 33, '07:00:00', '09:05:00', NULL, NULL, '1', '2', 'Ms. saifah phaiwan', '0956896544', NULL, '2022-02-24 00:44:46', '2022-02-24 01:19:21'),
(4, 2, 4, 1, 2, 'M-1001', NULL, 31, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, '2022-02-24 00:45:31', NULL),
(5, 2, 5, 2, 4, '2001', NULL, 31, '07:00:00', '07:39:00', NULL, NULL, '1', '2', 'พงศกร สิงหเสรี', '0865456895', NULL, '2022-02-24 00:45:31', '2022-02-24 01:20:19'),
(6, 1, 1, 1, 2, 'M-1002', NULL, 28, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, '2022-02-24 00:46:01', NULL),
(7, 1, 2, 1, 2, 'M-1003', NULL, 29, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, '2022-02-24 00:46:01', NULL),
(8, 1, 3, 1, 1, 'M-2001', NULL, 30, NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, '2022-02-24 00:46:01', NULL);

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
  `order_number` int(11) DEFAULT '0',
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
(4, 6, 'Umm!..Milk ทอฟฟี่ นมสด อืมม!..มิลค์', 'ขนนมมาไว้ที่ฟาร์มแล้ววว นมแลคโตสฟรีของ #Ummmilk เป็นนมวัวแท้ๆเลยย อร่อยมากอะทุกคน ใครที่กินแล้วท้องเสีย หมดกังวลได้เลย เพราะว่าเขาผลิตด้วยเทคโนโลยีที่', '1725524224845086.jpg', '0', '2022-02-18 01:29:33', '2022-02-22 20:48:55'),
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
  `imgname` text COLLATE utf8mb4_unicode_ci,
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
(1, 'Farm Chokchai Run de Farm ครั้งที่ 99', 'Farm Chokchai Run de Farm No. 99', 'หากไม่อยากพลาดอีกครั้ง กับงานวิ่งฤดูหนาว ตะลุยฟาร์มโชคชัย ทะลุไร่สุวรรณ Cow & Corn  farms cross country runs', 'If you don\'t want to miss it again with the winter run Talui Farm Chokchai Talu Rai Suwan Cow & Corn farms cross country runs', 'ไม่ว่าจะสายพลัง สายชิล สายแชะ มาคนเดียว มาเป็นกลุ่ม หรือยกครอบครัว มาร่วมวิ่งอย่างสนุกสนาน ซึ่งในครั้งนี้มีการจับเวลา เพื่อหานักวิ่ง คิง ออฟ รัน เดอ ฟาร์ม “ King of Run de Farm” อันดับ 1 -3 ของกลุ่มอายุ และรางวัล Gentleman Awards สำหรับนักวิ่งทั้งชายและหญิง', 'Whether it\'s power type, chill type, chat type, come alone, come in a group, or raise a family. Come join the fun run which this time has a timer To find runners King of Run de Farm \"King of Run de Farm\" ranked 1 -3 in the age group and the Gentleman Awards for both male and female runners.', 'วันอาทิตย์ 21 มกราคม 2565 ฟาร์มโชคชัย 1 ก.ม. 159 ถ.มิตรภาพ หนองน้ำแดง ปากช่อง จ.นครราชสีมา', 'วันอาทิตย์ 21 มกราคม 2565 ฟาร์มโชคชัย 1 ก.ม. 159 ถ.มิตรภาพ หนองน้ำแดง ปากช่อง จ.นครราชสีมา', 1, 'RDF', 'https://goo.gl/maps/YNupDd5Gq3Ascm47A', '1725627494210317.png', '1725626207715311.jpg', '1', '1', '1', '2022-03-01', '2022-03-20', '2022-03-21', '2022-03-23', '2022-03-01', '2022-03-20', '<p><span style=\"font-size: 12.8px;\">เงื่อนไขการสมัคร :</span></p><p><span style=\"font-size: 12.8px;\">1. ผู้สมัคร ต้องสมัครเป็นสมาชิกเว็บไซต์ www.farmchokchaisport.com ก่อน โดยเมื่อกรอกข้อมูลครบถ้วน ระบบจะส่งอีเมล์ ให้ผู้สมัคร ยืนยันตัวตน (Activate) และเข้าระบบเพื่อสมัครรายการกีฬาต่อไป</span></p><p><span style=\"font-size: 12.8px;\">2. ระบบรับสมัครแบ่งออกเป็นแบบบุคคล และแบบกลุ่ม (สมัครให้เพื่อน)</span></p><p><span style=\"font-size: 12.8px;\">3. กรอกข้อมูลผ่านระบบลงทะเบียนออนไลน์&nbsp; ผู้สมัครจะได้รับการตอบรับการสมัครรายการ หมายเลขอ้างอิงการสมัคร รูปแบบการชำระเงินให้กับท่านโดยอีเมล์</span></p><p><span style=\"font-size: 12.8px;\">4. หากเลือกรูปแบบการชำระเงินโดยการโอนเงินผ่านธนาคาร ให้ทำตามขั้นตอน และส่งหลักฐานยืนยันการชำระเงินทางเว็บไซต์</span></p><p><span style=\"font-size: 12.8px;\">5. เมื่อชำระค่าสมัครและแจ้งการชำระค่าสมัครแล้ว ท่านจะได้รับอีเมล์ตอบกลับยืนยันการชำระเงินของท่าน พร้อม QR Code</span></p><p><span style=\"font-size: 12.8px;\">หมายเหตุ : ผู้สมัครไม่สามารถเปลี่ยนตัวผู้เข้าร่วมแข่งขันได้</span></p>', '0', '2022-02-21 21:25:45', '2022-02-24 00:10:20'),
(2, 'Farm Chokchai Tour de Farm 10', 'Farm Chokchai Tour de Farm 10', 'Farm Chokchai Tour de Farm 8 เป็นมากกว่างานจักรยานแห่งปี แต่เป็นงานจักรยานของสุภาพบุรุษนักปั่น Peloton of Gentleman', 'Farm Chokchai Tour de Farm 8 เป็นมากกว่างานจักรยานแห่งปี แต่เป็นงานจักรยานของสุภาพบุรุษนักปั่น Peloton of Gentleman', 'ฟาร์มโชคชัย เอ้าท์ดอร์ สปอร์ต ในนามของ กลุ่มบริษัทฟาร์มโชคชัย และบริษัท โชคชัยอินเตอร์เนชั่นแนล จำกัด ขอเชิญผู้ที่รักการปั่นทุกท่านเข้าร่วมในรายการจักรยานทางเรียบแห่งปี “Farm Chokchai Tour de Farm 8” ภายใต้ Concept “Transform Your Fear To Focus” เปลี่ยนความกลัวให้เป็นจุดมุ่งหมาย ในวันอาทิตย์ที่ 12 มกราคม 2563 ณ ฟาร์มโชคชัย 3 อำเภอปากช่อง จังหวัดนครราชสีมา', 'ฟาร์มโชคชัย เอ้าท์ดอร์ สปอร์ต ในนามของ กลุ่มบริษัทฟาร์มโชคชัย และบริษัท โชคชัยอินเตอร์เนชั่นแนล จำกัด ขอเชิญผู้ที่รักการปั่นทุกท่านเข้าร่วมในรายการจักรยานทางเรียบแห่งปี “Farm Chokchai Tour de Farm 8” ภายใต้ Concept “Transform Your Fear To Focus” เปลี่ยนความกลัวให้เป็นจุดมุ่งหมาย ในวันอาทิตย์ที่ 12 มกราคม 2563 ณ ฟาร์มโชคชัย 3 อำเภอปากช่อง จังหวัดนครราชสีมา', 'วันอาทิตย์ 12 มกราคม 2563 ฟาร์มโชคชัย 3 ถนนธนะรัชต์ กม.ที่ 12 หมูสี ปากช่อง จ.นครราชสีมา', 'วันอาทิตย์ 12 มกราคม 2563 ฟาร์มโชคชัย 3 ถนนธนะรัชต์ กม.ที่ 12 หมูสี ปากช่อง จ.นครราชสีมา', 2, 'TDF', 'https://g.page/ChokchaiSteakhouse?share', '1725522843810706.jpg', '1725522843812798.jpg', '1', '1', '1', '2022-03-01', '2022-03-14', '2022-03-15', '2022-03-17', '2022-03-01', '2022-03-14', '<p><span style=\"font-size: 12.8px;\">เงื่อนไขการสมัคร :</span></p><p><span style=\"font-size: 12.8px;\">1. ผู้สมัคร ต้องสมัครเป็นสมาชิกเว็บไซต์ www.farmchokchaisport.com ก่อน โดยเมื่อกรอกข้อมูลครบถ้วน ระบบจะส่งอีเมล์ ให้ผู้สมัคร ยืนยันตัวตน (Activate) และเข้าระบบเพื่อสมัครรายการกีฬาต่อไป</span></p><p><span style=\"font-size: 12.8px;\">2. ระบบรับสมัครแบ่งออกเป็นแบบบุคคล และแบบกลุ่ม (สมัครให้เพื่อน)</span></p><p><span style=\"font-size: 12.8px;\">3. กรอกข้อมูลผ่านระบบลงทะเบียนออนไลน์&nbsp; ผู้สมัครจะได้รับการตอบรับการสมัครรายการ หมายเลขอ้างอิงการสมัคร รูปแบบการชำระเงินให้กับท่านโดยอีเมล์</span></p><p><span style=\"font-size: 12.8px;\">4. หากเลือกรูปแบบการชำระเงินโดยการโอนเงินผ่านธนาคาร ให้ทำตามขั้นตอน และส่งหลักฐานยืนยันการชำระเงินทางเว็บไซต์</span></p><p><span style=\"font-size: 12.8px;\">5. เมื่อชำระค่าสมัครและแจ้งการชำระค่าสมัครแล้ว ท่านจะได้รับอีเมล์ตอบกลับยืนยันการชำระเงินของท่าน พร้อม QR Code</span></p><p><span style=\"font-size: 12.8px;\">หมายเหตุ : ผู้สมัครไม่สามารถเปลี่ยนตัวผู้เข้าร่วมแข่งขันได้</span></p>', '0', '2022-02-22 20:26:58', '2022-02-24 00:02:30');

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
(1, 1, 3, '0', '2022-02-21 21:30:15', NULL),
(2, 1, 6, '0', '2022-02-21 21:30:24', NULL),
(3, 1, 2, '0', '2022-02-21 21:30:30', NULL),
(4, 1, 1, '0', '2022-02-21 21:30:33', NULL),
(5, 2, 3, '0', '2022-02-22 20:28:20', NULL),
(6, 2, 2, '0', '2022-02-22 20:28:24', NULL),
(7, 2, 1, '0', '2022-02-22 20:28:26', NULL);

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
(1, 2, 1, 'ระยะทาง 5 กิโลเมตร', 'distance 5 kilometers', '5 km เป็นระยะที่ได้สัมผัสกับบรรยากาศเส้นทางในฟาร์มโชคชัย เหมาะสมกับนักวิ่งที่ต้องการวิ่งแบบสบายๆ ไม่เร่งรีบมาก ซ้อมมาพอสมควร หรือจะเป็นระยะแรกของการเป็นนักวิ่งก็ได้ และไม่มีการจับเวลา', '5 km is the distance to experience the atmosphere of the path in Farm Chokchai. Suitable for runners who want to run comfortably. not very rush trained enough Or it can be the first phase of being a runner. and no timer', 700.00, 5, 'Km.', '07:00:00', '1', 'O', NULL, '2022-02-21 21:25:45', '2022-02-24 00:10:20'),
(2, 1, 1, 'ระยะทาง 10 กิโลเมตร', 'distance 10 kilometers', '10 km เป็นระยะที่วิ่งในฟาร์มโชคชัยเต็มเส้นทาง และเข้าไปวิ่งในไร่สุวรรณเพียงบางส่วน เหมาะสมกับนักวิ่งที่ผ่านการวิ่งและซ้อมระยะ Mini Marathon มาแล้ว หรือหากจะท้ายทายตัวเองให้เป็น Mini Marathon ของตนเองครั้งแรกก็ได้เลยทีเดียว', '10 km is a distance that runs in Farm Chokchai the full route. and only partially ran in Suwan farm Suitable for runners who have already run and practiced a Mini Marathon, or if they can challenge themselves to be their own Mini Marathon for the first time ever.', 900.00, 10, 'Km.', '07:15:00', '1', 'T', NULL, '2022-02-21 21:25:45', '2022-02-24 00:10:20'),
(3, 2, 2, '‘Going Greener’ ระยะทาง 68  กม.', '‘Going Greener’ ระยะทาง 68  กม.', 'เส้นทาง 93 กม. ของ ทัวร์ เดอ ฟาร์ม 8 ครั้งนี้ แตกต่างจากเส้นทาง ทัวร์ เดอ ฟาร์ม 7 100 กม โดยตัดเข้าถนนผ่านโรงเรียนลำทองหลาง ซึ่งเส้นทางนี้จะมีทางลงเขาที่ชันมาก ทำให้เป็นการปั่นลงเขาด้วยความเร็วสูง นักปั่นทุกท่านควรใช้ความระมัดระวัง', 'เส้นทาง 93 กม. ของ ทัวร์ เดอ ฟาร์ม 8 ครั้งนี้ แตกต่างจากเส้นทาง ทัวร์ เดอ ฟาร์ม 7 100 กม โดยตัดเข้าถนนผ่านโรงเรียนลำทองหลาง ซึ่งเส้นทางนี้จะมีทางลงเขาที่ชันมาก ทำให้เป็นการปั่นลงเขาด้วยความเร็วสูง นักปั่นทุกท่านควรใช้ความระมัดระวัง', 900.00, 68, 'Km.', NULL, '2', 'O', NULL, '2022-02-22 20:26:58', '2022-02-24 00:02:30'),
(4, 1, 2, '‘Fearless Gentlemen’ ระยะทาง 93  กม.', '‘Fearless Gentlemen’ ระยะทาง 93  กม.', 'เส้นทาง 93 กม. ของ ทัวร์ เดอ ฟาร์ม 8 ครั้งนี้ แตกต่างจากเส้นทาง ทัวร์ เดอ ฟาร์ม 7 100 กม โดยตัดเข้าถนนผ่านโรงเรียนลำทองหลาง ซึ่งเส้นทางนี้จะมีทางลงเขาที่ชันมาก ทำให้เป็นการปั่นลงเขาด้วยความเร็วสูง นักปั่นทุกท่านควรใช้ความระมัดระวัง', 'เส้นทาง 93 กม. ของ ทัวร์ เดอ ฟาร์ม 8 ครั้งนี้ แตกต่างจากเส้นทาง ทัวร์ เดอ ฟาร์ม 7 100 กม โดยตัดเข้าถนนผ่านโรงเรียนลำทองหลาง ซึ่งเส้นทางนี้จะมีทางลงเขาที่ชันมาก ทำให้เป็นการปั่นลงเขาด้วยความเร็วสูง นักปั่นทุกท่านควรใช้ความระมัดระวัง', 900.00, 93, 'Km.', '08:00:00', '2', 'T', NULL, '2022-02-22 20:26:58', '2022-02-24 00:02:30');

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
  `address` text COLLATE utf8mb4_unicode_ci,
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
(10, 'Dev.Phaiwan', '', 'farmchokchaisport2016@gmail.com', NULL, '$2y$10$L0BiTGJfMDlfLHNP4fvVNeMCNEpET9jt1ri4rh4WOONZvhQEaOA0.', 'Sti9E0d0aA54Ka1P7UojyS5GDrEItXmDKhLq3qf7Z3r1xesI6DP3ardGqCIm', '2022-01-19 23:22:44', '2022-01-19 23:27:54', 'M', NULL, NULL, '080-056-8953', 28, 10, 1996, '1', '1-1996-00196-24-6', 'ไทย', 'B', '-', '81/ m6', 'ช่องสาริกา', 'พัฒนานิคม', 'ลพบุรี', 'ไทย', '15220', '-', '-', '080-056-8953', NULL, NULL, NULL, NULL, '2', NULL, NULL, 1),
(28, 'สายฟ้า', 'ไพรวรรณ์', 'saifah1928@gmail.com', NULL, NULL, NULL, '2022-02-24 00:12:30', '2022-02-24 00:07:04', 'M', NULL, NULL, '080-056-8953', 28, 10, 1996, '1', '1-1996-00196-24-6', 'ไทย', 'B', '-', '81 หมู่ 6 ถนน. วังม่วง-ลพบุรี', 'ช่องสาริกา', 'พัฒนานิคม', 'ลพบุรี', 'ไทย', '15220', '-', '-', '080-056-8953', NULL, NULL, NULL, NULL, '1', '117668926084185029304', 'https://lh3.googleusercontent.com/a-/AOh14GhBapOENHupqIMcpK_5XcIiZ9PLYJCxHtCThw3N=s96-c', 1),
(29, 'วิญญู', 'เสาสมภพ', 'vinyu007@gmail.com', NULL, NULL, NULL, '2022-02-24 00:15:09', NULL, 'M', NULL, NULL, '086-538-4052', 25, 6, 1996, '1', '1-1037-02067-57-1', 'ไทย', 'B', 'ไม่มีโรคประจำตัว', '48/183', 'รังสิต', 'ธัญบุรี', 'ปทุมธานี', 'ไทย', '12110', '-', '-', '086-538-4052', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(30, 'วุฒธิพงศ์', 'สุเนตร', 'wuttipong002@hotmail.com', NULL, NULL, NULL, '2022-02-24 00:16:41', NULL, 'M', NULL, NULL, '086-538-4052', 21, 3, 1990, '1', '1-2399-00140-50-4', 'ไทย', 'O', '-', '53/154 ม.1', 'รังสิต', 'ธัญบุรี', 'ปทุมธานี', 'ไทย', '12110', '-', '-', '086-538-4052', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(31, 'พงศกร', 'สิงหเสรี', 'vorz7k1@gmail.com', NULL, '$2y$10$2FO4dtRcaE2tJ6.iV2BwLu36HziOA9nNJuBsmxBpuMCQe.W2A1/1K', NULL, '2022-02-24 00:19:20', '2022-02-24 00:17:57', 'M', NULL, NULL, '087-134-7136', 23, 8, 1984, '1', '1-2507-00009-04-0', 'ไทย', 'B', 'ภูมิแพ้อากาศ', '69 - หนองขาม', 'หนองขาม', 'จักราช', 'นครราชสีมา', 'ไทย', '30230', '-', '-', '087-134-7136', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(32, 'นิติพงศ์', 'ธนาพิสุทธิวงศ์', 'nitipong.it@farmchokchai.net', NULL, '$2y$10$K9ZvE3Z4hxXyoQgz5lvIA.DQZ0P.1Jc3.3DTzmRDRXyGrD06XnpFK', NULL, '2022-02-24 00:36:09', '2022-02-24 00:24:01', 'M', NULL, NULL, '089-923-4668', 5, 4, 1949, '1', '3-1012-00157-76-5', 'ไทย', 'AB', '-', '100/187', 'คูคต', 'ลำลูกกา', 'ปทุมธานี', 'ไทย', '12130', '-', '-', '089-923-4668', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(33, 'saifah', 'phaiwan', 'dev.saifah8953@gmail.com', NULL, NULL, NULL, '2022-02-24 00:29:27', NULL, 'F', NULL, NULL, '095-908-6456', 28, 10, 1990, '1', '1-9995-44582-22-5', 'ไทย', 'B', '-', '81/88', 'สงเปลือย', 'นามน', 'กาฬสินธุ์', 'ไทย', '46230', '-', '-', '095-908-6456', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1),
(34, 'ณัฐวุฒิ', 'เมืองทะ', 'maungta@gmail.com', NULL, NULL, NULL, '2022-02-24 00:40:13', NULL, 'F', NULL, NULL, '087-134-7136', 28, 6, 1984, '1', '1-2507-00009-04-0', 'ไทย', 'AB', '-', 'หนองขาม', 'หนองขาม', 'จักราช', 'นครราชสีมา', 'ไทย', '30230', '-', '-', '087-134-7136', NULL, NULL, NULL, NULL, '1', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `website`
--

CREATE TABLE `website` (
  `id` int(11) NOT NULL,
  `background` text,
  `summernote_box1` text,
  `summernote_box2` text,
  `deleted_at` char(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `website`
--

INSERT INTO `website` (`id`, `background`, `summernote_box1`, `summernote_box2`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, '1725524156321066.jpg', '<h1 class=\"text-center\"><span style=\"color: rgb(255, 255, 255);\">\r\n                                FARM CHOK CHAI CHALLENCE YOUR FEAR TOUR DE FARM\r\n                            </span></h1>\r\n                            <p class=\"text-center\"><span style=\"color: rgb(247, 247, 247);\">\r\n                                เป็นมากกว่างานจักรยานแห่งปีแต่เป็นงานของสุภาพบุรุษนักปั่น.\r\n                            </span></p>  \r\n                            <ul class=\"ud-hero-buttons mt-3 mb-3\">\r\n                              <li>\r\n                                <a class=\"ud-main-btn ud-white-btn\" href=\"https://demo.chokchaiinternational.com/event\"> สมัครรายการแข่งขัน</a> \r\n                              </li> \r\n                            </ul>                           \r\n\r\n<iframe frameborder=\"0\" src=\"//www.youtube.com/embed/QrwAKGIjuAo\" width=\"100%\" class=\"note-video-clip\"></iframe>', '1725357196220202.text', '0', '2022-02-21 03:27:53', '2022-02-22 20:47:50');

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cart_sport_tems`
--
ALTER TABLE `cart_sport_tems`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `option_items`
--
ALTER TABLE `option_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `promotion_codes`
--
ALTER TABLE `promotion_codes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `promotion_codes_sponsors`
--
ALTER TABLE `promotion_codes_sponsors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `race_programs`
--
ALTER TABLE `race_programs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `souvenirs`
--
ALTER TABLE `souvenirs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sponsors`
--
ALTER TABLE `sponsors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tournaments`
--
ALTER TABLE `tournaments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tournaments_sponsors`
--
ALTER TABLE `tournaments_sponsors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tournament_types`
--
ALTER TABLE `tournament_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `website`
--
ALTER TABLE `website`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
