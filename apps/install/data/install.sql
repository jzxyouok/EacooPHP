-- phpMyAdmin SQL Dump
-- version 4.6.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 2017-10-01 13:43:46
-- 服务器版本： 5.7.15
-- PHP Version: 7.0.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `eacoophp`
--

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_action`
--

CREATE TABLE `eacoo_action` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '主键',
  `module` varchar(16) NOT NULL DEFAULT '' COMMENT '所属模块名',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '行为唯一标识（组合控制器名+操作名）',
  `title` varchar(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` varchar(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` text NOT NULL COMMENT '行为规则',
  `log` text NOT NULL COMMENT '日志规则',
  `action_type` tinyint(2) UNSIGNED NOT NULL DEFAULT '1' COMMENT '执行类型。1自定义操作，2记录操作',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '修改时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统行为表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `eacoo_action`
--

INSERT INTO `eacoo_action` (`id`, `module`, `name`, `title`, `remark`, `rule`, `log`, `action_type`, `create_time`, `update_time`, `status`) VALUES
(1, 'user', 'user_login', '用户登录', '积分+10，每天一次', 'table:users|field:integral|condition:uid={$self} AND status>-1|rule:integral+10|cycle:24|max:1;', '[user|get_nickname]在[time|time_format]登录了后台', 1, 1466957785, 1466957785, 1),
(2, 'cms', 'add_article', '发布文章', '积分+5，每天上限5次', 'table:users|field:integral|condition:uid={$self}|rule:integral+5|cycle:24|max:5', '', 1, 1380173180, 1380173180, 0),
(3, '', 'clear_actionlog', '清空行为日志', '后台清空行为日志', '', '', 1, 0, 0, 1),
(5, 'admin', 'user_login_admin', '登录后台', '用户登录后台', '', '[user|get_nickname]在[time|time_format]登录了后台', 1, 1383285551, 1383285551, 1),
(6, '', 'update_config', '更新配置', '新增或修改或删除配置', '', '', 2, 1383294988, 1383294988, 1),
(7, '', 'update_channel', '更新导航', '新增或修改或删除导航', '', '', 2, 1383296301, 1383296301, 1),
(8, '', 'update_menu', '更新菜单', '新增或修改或删除菜单', '', '', 2, 1383296392, 1383296392, 1),
(9, '', 'update_category', '更新分类', '新增或修改或删除分类', '', '', 2, 1383296765, 1383296765, 1),
(10, 'admin', 'dashboard_index', '进入仪表盘', '进入仪表盘', '', '', 1, 0, 0, 0),
(11, '', 'database_export', '数据库备份', '后台进行数据库备份操作', '', '', 1, 0, 0, 1),
(12, '', 'database_optimize', '数据表优化', '数据库管理-》数据表优化', '', '', 1, 0, 0, 1),
(13, '', 'database_repair', '数据表修复', '数据库管理-》数据表修复', '', '', 1, 0, 0, 1),
(14, '', 'database_backup_delete', '备份文件删除', '数据库管理-》备份文件删除', '', '', 1, 0, 0, 1),
(15, '', 'database_import', '数据库完成', '数据库管理-》数据还原', '', '', 1, 0, 0, 1),
(16, '', 'delete_actionlog', '删除行为日志', '后台删除用户行为日志', '', '', 1, 0, 0, 1),
(17, '', 'user_register', '注册', '', '', '', 1, 1506262430, 1506262430, 1);

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_action_log`
--

CREATE TABLE `eacoo_action_log` (
  `id` int(10) UNSIGNED NOT NULL COMMENT '主键',
  `action_id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '行为id',
  `uid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `action_ip` varchar(18) NOT NULL DEFAULT '' COMMENT '执行行为者ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行为日志表' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_attachment`
--

CREATE TABLE `eacoo_attachment` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `uid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'UID',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '文件名',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '文件路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '文件链接（暂时无用）',
  `location` varchar(15) NOT NULL DEFAULT '' COMMENT '文件存储位置(驱动)',
  `path_type` varchar(20) DEFAULT 'picture' COMMENT '路径类型',
  `ext` char(4) NOT NULL DEFAULT '' COMMENT '文件类型',
  `mime_type` varchar(60) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '文件大小',
  `alt` varchar(255) DEFAULT NULL COMMENT '替代文本图像alt',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件sha1编码',
  `download` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '下载次数',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '上传时间',
  `update_time` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '修改时间',
  `sort` mediumint(8) UNSIGNED NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文件上传表';

--
-- 转存表中的数据 `eacoo_attachment`
--

INSERT INTO `eacoo_attachment` (`id`, `uid`, `name`, `path`, `url`, `location`, `path_type`, `ext`, `mime_type`, `size`, `alt`, `md5`, `sha1`, `download`, `create_time`, `update_time`, `sort`, `status`) VALUES
(1, 1, 'preg_match_imgs.jpeg', '/uploads/Editor/Picture/2016-06-12/575d4bd8d0351.jpeg', '', 'local', 'editor', 'jpeg', '', 19513, '', '4cf157e42b44c95d579ee39b0a1a48a4', 'dee76e7b39f1afaad14c1e03cfac5f6031c3c511', 0, 1465732056, 1465732056, 0, 1),
(2, 1, 'gerxiangimg200x200.jpg', '/uploads/Editor/Picture/2016-06-12/575d4bfb09961.jpg', '', 'local', 'editor', 'jpg', '', 5291, 'gerxiangimg200x200', '4db879c357c4ab80c77fce8055a0785f', '480eb2e097397856b99b373214fb28c2f717dacf', 0, 1465732090, 1465732090, 0, 1),
(3, 1, 'oraclmysqlzjfblhere.jpg', '/uploads/Editor/Picture/2016-06-12/575d4c691e976.jpg', '', 'local', 'editor', 'jpg', '', 23866, 'mysql', '5a3a5a781a6d9b5f0089f6058572f850', 'a17bfe395b29ba06ae5784486bcf288b3b0adfdb', 0, 1465732201, 1465732201, 0, 1),
(6, 1, '功能表格', '/uploads/attachment/2016-07-13/5785daaa2f2e6.xlsx', '', 'local', 'file', 'xlsx', '', 11399, NULL, '5fd89f172ca8a95fa13b55ccb24d5971', 'b8706af3fa59ef0fc65675e40131f25e12f94664', 0, 1468390058, 1468390058, 0, 1),
(8, 1, '会员数据2016-06-30 18_44_14', '/uploads/attachment/2016-07-13/5785dce2e15c1.xls', '', 'local', 'file', 'xls', '', 173387, NULL, '9ff55acddd75366d20dcb931eb1d87ea', 'acf5daf769e6ba06854002104bfb8c2886da97af', 0, 1468390626, 1468390626, 0, 1),
(10, 1, '苹果短信-三全音 - 铃声', '/uploads/attachment/2016-07-27/579857b5aca95.mp3', '', 'local', 'file', 'mp3', '', 19916, NULL, 'bab00edb8d6a5cf4de5444a2e5c05009', '73cda0fb4f947dcb496153d8b896478af1247935', 0, 1469601717, 1469601717, 0, 1),
(12, 1, 'music', '/uploads/attachment/2016-07-28/57995fe9bf0da.mp3', '', 'local', 'file', 'mp3', '', 160545, NULL, '935cd1b8950f1fdcd23d47cf791831cf', '73c318221faa081544db321bb555148f04b61f00', 0, 1469669353, 1469669353, 0, 1),
(13, 1, '7751775467283337', '/uploads/picture/2016-09-26/57e8dc9d29b01.jpg', '', 'local', 'picture', 'jpg', '', 70875, NULL, '3e3bfc950aa0b6ebb56654c15fe8e392', 'c75e70753eaf36aaee10efb3682fdbd8f766d32d', 0, 1474878621, 1474878621, 0, 1),
(14, 1, '4366486814073822', '/uploads/picture/2016-09-26/57e8ddebaafff.jpg', '', 'local', 'picture', 'jpg', '', 302678, NULL, 'baf2dc5ea7b80a6d73b20a2c762aec1e', 'd73fe63f5c179135b2c2e7f174d6df36e05ab3d8', 0, 1474878955, 1474878955, 0, 1),
(15, 1, 'wx1image_14751583274385', '/uploads/picture/2016-09-29/wx1image_14751583274385.jpg', '', 'local', 'picture', 'jpg', '', 311261, NULL, '', '', 0, 1475158327, 0, 0, 1),
(16, 1, 'wx1image_14751583284125', '/uploads/picture/2016-09-29/wx1image_14751583284125.jpg', '', 'local', 'picture', 'jpg', '', 192559, NULL, '', '', 0, 1475158328, 0, 0, 1),
(17, 1, 'wx1image_14751583287356', '/uploads/picture/2016-09-29/wx1image_14751583287356.jpg', '', 'local', 'picture', 'jpg', '', 43346, NULL, '', '', 0, 1475158328, 0, 0, 1),
(18, 1, 'wx1image_14751583293547', '/uploads/picture/2016-09-29/wx1image_14751583293547.jpg', '', 'local', 'picture', 'jpg', '', 150688, NULL, '', '', 0, 1475158329, 0, 0, 1),
(19, 1, 'wx1image_14751583298683', '/uploads/picture/2016-09-29/wx1image_14751583298683.jpg', '', 'local', 'picture', 'jpg', '', 79626, NULL, '', '', 0, 1475158329, 0, 0, 1),
(20, 1, 'wx1image_14751583294128', '/uploads/picture/2016-09-29/wx1image_14751583294128.jpg', '', 'local', 'picture', 'jpg', '', 61008, NULL, '', '', 0, 1475158329, 0, 0, 1),
(21, 1, 'wx1image_14751583302886', '/uploads/picture/2016-09-29/wx1image_14751583302886.jpg', '', 'local', 'picture', 'jpg', '', 20849, NULL, '', '', 0, 1475158330, 0, 0, 1),
(22, 1, 'wx1image_1475158330831', '/uploads/picture/2016-09-29/wx1image_1475158330831.jpg', '', 'local', 'picture', 'jpg', '', 56265, NULL, '', '', 0, 1475158330, 0, 0, 1),
(23, 1, 'wx1image_1475158330180', '/uploads/picture/2016-09-29/wx1image_1475158330180.jpg', '', 'local', 'picture', 'jpg', '', 121610, NULL, '', '', 0, 1475158330, 0, 0, 1),
(24, 1, 'wx1image_14751583318180', '/uploads/picture/2016-09-29/wx1image_14751583318180.jpg', '', 'local', 'picture', 'jpg', '', 35555, NULL, '', '', 0, 1475158331, 0, 0, 1),
(25, 1, 'wx1image_1475158332231', '/uploads/picture/2016-09-29/wx1image_1475158332231.jpg', '', 'local', 'picture', 'jpg', '', 32095, NULL, '', '', 0, 1475158332, 0, 0, 1),
(26, 1, 'wx1image_14751583325255', '/uploads/picture/2016-09-29/wx1image_14751583325255.jpg', '', 'local', 'picture', 'jpg', '', 70088, NULL, '', '', 0, 1475158332, 0, 0, 1),
(27, 1, 'wx1image_14751583331037', '/uploads/picture/2016-09-29/wx1image_14751583331037.jpg', '', 'local', 'picture', 'jpg', '', 37085, NULL, '', '', 0, 1475158333, 0, 0, 1),
(28, 1, 'wx1image_14751583343169', '/uploads/picture/2016-09-29/wx1image_14751583343169.jpg', '', 'local', 'picture', 'jpg', '', 65279, NULL, '', '', 0, 1475158334, 0, 0, 1),
(29, 1, 'wx1image_14751583344810', '/uploads/picture/2016-09-29/wx1image_14751583344810.jpg', '', 'local', 'picture', 'jpg', '', 83936, NULL, '', '', 0, 1475158334, 0, 0, 1),
(30, 1, 'wx1image_14751583356369', '/uploads/picture/2016-09-29/wx1image_14751583356369.jpg', '', 'local', 'picture', 'jpg', '', 20032, NULL, '', '', 0, 1475158335, 0, 0, 1),
(31, 1, 'wx1image_14751583359328', '/uploads/picture/2016-09-29/wx1image_14751583359328.jpg', '', 'local', 'picture', 'jpg', '', 53984, NULL, '', '', 0, 1475158335, 0, 0, 1),
(32, 1, 'wx1image_1475158335689', '/uploads/picture/2016-09-29/wx1image_1475158335689.jpg', '', 'local', 'picture', 'jpg', '', 50399, NULL, '', '', 0, 1475158335, 0, 0, 1),
(33, 1, 'wx1image_14751583361694', '/uploads/picture/2016-09-29/wx1image_14751583361694.jpg', '', 'local', 'picture', 'jpg', '', 128125, NULL, '', '', 0, 1475158336, 0, 0, 1),
(34, 1, 'wx1image_14751583371210', '/uploads/picture/2016-09-29/wx1image_14751583371210.jpg', '', 'local', 'picture', 'jpg', '', 35090, NULL, '', '', 0, 1475158337, 0, 0, 1),
(35, 1, 'wx1image_14751583385281', '/uploads/picture/2016-09-29/wx1image_14751583385281.jpg', '', 'local', 'picture', 'jpg', '', 57272, NULL, '', '', 0, 1475158338, 0, 0, 1),
(36, 1, 'wx1image_14751583393940', '/uploads/picture/2016-09-29/wx1image_14751583393940.jpg', '', 'local', 'picture', 'jpg', '', 74827, NULL, '', '', 0, 1475158339, 0, 0, 1),
(38, 1, 'wx1image_14751587991531', '/uploads/picture/2016-09-29/wx1image_14751587991531.jpg', '', 'local', 'picture', 'jpg', '', 154175, NULL, '', '', 0, 1475158799, 0, 0, 1),
(39, 1, 'wx1image_14751587997094.png', '/uploads/picture/2016-09-29/wx1image_14751587997094.png', '', 'local', 'picture', 'jpg', '', 26583, NULL, '', '', 0, 1475158799, 0, 0, 1),
(40, 1, 'wx1image_14751587995130', '/uploads/picture/2016-09-29/wx1image_14751587995130.jpg', '', 'local', 'picture', 'jpg', '', 23625, NULL, '', '', 0, 1475158799, 0, 0, 1),
(41, 1, 'wx1image_14751587995676', '/uploads/picture/2016-09-29/wx1image_14751587995676.jpg', '', 'local', 'picture', 'jpg', '', 67232, NULL, '', '', 0, 1475158799, 0, 0, 1),
(42, 1, 'wx1image_14751587991897', '/uploads/picture/2016-09-29/wx1image_14751587991897.jpg', '', 'local', 'picture', 'jpg', '', 16604, NULL, '', '', 0, 1475158799, 0, 0, 1),
(43, 1, 'wx1image_14751588004786', '/uploads/picture/2016-09-29/wx1image_14751588004786.jpg', '', 'local', 'picture', 'jpg', '', 26779, NULL, '', '', 0, 1475158800, 0, 0, 1),
(44, 1, 'wx1image_14751588009825', '/uploads/picture/2016-09-29/wx1image_14751588009825.jpg', '', 'local', 'picture', 'jpg', '', 7546, NULL, '', '', 0, 1475158800, 0, 0, 1),
(45, 1, 'wx1image_1475158800631', '/uploads/picture/2016-09-29/wx1image_1475158800631.jpg', '', 'local', 'picture', 'jpg', '', 10713, NULL, '', '', 0, 1475158800, 0, 0, 1),
(46, 1, 'wx1image_14751588008193', '/uploads/picture/2016-09-29/wx1image_14751588008193.jpg', '', 'local', 'picture', 'jpg', '', 94825, NULL, '', '', 0, 1475158800, 0, 0, 1),
(47, 1, 'wx1image_14751588004666', '/uploads/picture/2016-09-29/wx1image_14751588004666.jpg', '', 'local', 'picture', 'jpg', '', 39592, NULL, '', '', 0, 1475158800, 0, 0, 1),
(48, 1, 'wx1image_14751588008768.png', '/uploads/picture/2016-09-29/wx1image_14751588008768.png', '', 'local', 'picture', 'jpg', '', 50732, NULL, '', '', 0, 1475158800, 0, 0, 1),
(49, 1, 'wx1image_1475158800354.png', '/uploads/picture/2016-09-29/wx1image_1475158800354.png', '', 'local', 'picture', 'jpg', '', 21937, NULL, '', '', 0, 1475158800, 0, 0, 1),
(50, 1, 'wx1image_1475158801542.png', '/uploads/picture/2016-09-29/wx1image_1475158801542.png', '', 'local', 'picture', 'jpg', '', 19383, NULL, '', '', 0, 1475158801, 0, 0, 1),
(51, 1, 'wx1image_14751588012312.png', '/uploads/picture/2016-09-29/wx1image_14751588012312.png', '', 'local', 'picture', 'jpg', '', 45798, NULL, '', '', 0, 1475158801, 0, 0, 1),
(52, 1, 'wx1image_14751588058806', '/uploads/picture/2016-09-29/wx1image_14751588058806.jpg', '', 'local', 'picture', 'jpg', '', 24855, NULL, '', '', 0, 1475158805, 0, 0, 1),
(53, 1, 'wx1image_14751588067284', '/uploads/picture/2016-09-29/wx1image_14751588067284.jpg', '', 'local', 'picture', 'jpg', '', 14851, NULL, '', '', 0, 1475158806, 0, 0, 1),
(54, 1, 'wx1image_14751588091783.png', '/uploads/picture/2016-09-29/wx1image_14751588091783.png', '', 'local', 'picture', 'jpg', '', 68781, NULL, '', '', 0, 1475158809, 0, 0, 1),
(55, 1, 'wx1image_14751588108673.png', '/uploads/picture/2016-09-29/wx1image_14751588108673.png', '', 'local', 'picture', 'jpg', '', 13649, NULL, '', '', 0, 1475158810, 0, 0, 1),
(56, 1, 'wx1image_14751588114626.png', '/uploads/picture/2016-09-29/wx1image_14751588114626.png', '', 'local', 'picture', 'jpg', '', 10724, NULL, '', '', 0, 1475158811, 0, 0, 1),
(57, 1, 'wx1image_14751588116216.png', '/uploads/picture/2016-09-29/wx1image_14751588116216.png', '', 'local', 'picture', 'jpg', '', 18955, NULL, '', '', 0, 1475158811, 0, 0, 1),
(58, 1, 'wx1image_14751588117971', '/uploads/picture/2016-09-29/wx1image_14751588117971.jpg', '', 'local', 'picture', 'jpg', '', 34171, NULL, '', '', 0, 1475158811, 0, 0, 1),
(59, 1, 'wx1image_14751588113400', '/uploads/picture/2016-09-29/wx1image_14751588113400.jpg', '', 'local', 'picture', 'jpg', '', 16445, NULL, '', '', 0, 1475158811, 0, 0, 1),
(60, 1, 'wx1image_14751588113547', '/uploads/picture/2016-09-29/wx1image_14751588113547.jpg', '', 'local', 'picture', 'jpg', '', 7062, NULL, '', '', 0, 1475158811, 0, 0, 1),
(61, 1, 'wx1image_14751588111003', '/uploads/picture/2016-09-29/wx1image_14751588111003.jpg', '', 'local', 'picture', 'jpg', '', 7982, NULL, '', '', 0, 1475158811, 0, 0, 1),
(62, 1, 'wx1image_14751588185564.png', '/uploads/picture/2016-09-29/wx1image_14751588185564.png', '', 'local', 'picture', 'jpg', '', 163203, NULL, '', '', 0, 1475158818, 0, 0, 1),
(63, 1, 'wx1image_14751588213497.png', '/uploads/picture/2016-09-29/wx1image_14751588213497.png', '', 'local', 'picture', 'jpg', '', 14153, NULL, '', '', 0, 1475158821, 0, 0, 1),
(64, 1, 'wx1image_14751588212612.png', '/uploads/picture/2016-09-29/wx1image_14751588212612.png', '', 'local', 'picture', 'jpg', '', 15962, NULL, '', '', 0, 1475158821, 0, 0, 1),
(65, 1, 'wx1image_14751588215121.png', '/uploads/picture/2016-09-29/wx1image_14751588215121.png', '', 'local', 'picture', 'jpg', '', 22820, NULL, '', '', 0, 1475158821, 0, 0, 1),
(66, 1, 'wx1image_14751588222935.png', '/uploads/picture/2016-09-29/wx1image_14751588222935.png', '', 'local', 'picture', 'jpg', '', 72312, NULL, '', '', 0, 1475158822, 0, 0, 1),
(67, 1, 'wx1image_14751588223870', '/uploads/picture/2016-09-29/wx1image_14751588223870.jpg', '', 'local', 'picture', 'jpg', '', 31690, NULL, '', '', 0, 1475158822, 0, 0, 1),
(68, 1, 'wx1image_14751588235543.png', '/uploads/picture/2016-09-29/wx1image_14751588235543.png', '', 'local', 'picture', 'jpg', '', 32383, NULL, '', '', 0, 1475158823, 0, 0, 1),
(69, 1, 'wx1image_14751588233114.png', '/uploads/picture/2016-09-29/wx1image_14751588233114.png', '', 'local', 'picture', 'jpg', '', 16871, NULL, '', '', 0, 1475158823, 0, 0, 1),
(70, 1, 'wx1image_14751588247501.png', '/uploads/picture/2016-09-29/wx1image_14751588247501.png', '', 'local', 'picture', 'jpg', '', 48306, '', '', '', 0, 1475158824, 1506556705, 0, 1),
(71, 1, 'wx1image_1475158825303.png', '/uploads/picture/2016-09-29/wx1image_1475158825303.png', '', 'local', 'picture', 'jpg', '', 65410, NULL, '', '', 0, 1475158825, 0, 0, 1),
(72, 1, 'wx1image_14751588263856.png', '/uploads/picture/2016-09-29/wx1image_14751588263856.png', '', 'local', 'picture', 'jpg', '', 173478, NULL, '', '', 0, 1475158826, 0, 0, 1),
(73, 1, 'wx1image_1475158835506', '/uploads/picture/2016-09-29/wx1image_1475158835506.jpg', '', 'local', 'picture', 'jpg', '', 12805, NULL, '', '', 0, 1475158835, 0, 0, 1),
(74, 1, 'wx1image_14751588359605.png', '/uploads/picture/2016-09-29/wx1image_14751588359605.png', '', 'local', 'picture', 'jpg', '', 42306, NULL, '', '', 0, 1475158835, 0, 0, 1),
(75, 1, 'wx1image_14751588351768.png', '/uploads/picture/2016-09-29/wx1image_14751588351768.png', '', 'local', 'picture', 'jpg', '', 13828, NULL, '', '', 0, 1475158835, 0, 0, 1),
(76, 1, 'wx1image_14751588383783.png', '/uploads/picture/2016-09-29/wx1image_14751588383783.png', '', 'local', 'picture', 'jpg', '', 39390, NULL, '', '', 0, 1475158838, 0, 0, 1),
(77, 1, 'wx1image_1475158839982.png', '/uploads/picture/2016-09-29/wx1image_1475158839982.png', '', 'local', 'picture', 'jpg', '', 41620, NULL, '', '', 0, 1475158839, 0, 0, 1),
(78, 1, 'wx1image_14751588393130.png', '/uploads/picture/2016-09-29/wx1image_14751588393130.png', '', 'local', 'picture', 'jpg', '', 10686, NULL, '', '', 0, 1475158839, 0, 0, 1),
(79, 1, 'wx1image_1475158843730.png', '/uploads/picture/2016-09-29/wx1image_1475158843730.png', '', 'local', 'picture', 'jpg', '', 77934, NULL, '', '', 0, 1475158843, 0, 0, 1),
(80, 1, 'wx1image_14751588431771.png', '/uploads/picture/2016-09-29/wx1image_14751588431771.png', '', 'local', 'picture', 'jpg', '', 38682, NULL, '', '', 0, 1475158843, 0, 0, 1),
(81, 1, 'wx1image_14751588432055.png', '/uploads/picture/2016-09-29/wx1image_14751588432055.png', '', 'local', 'picture', 'jpg', '', 54928, NULL, '', '', 0, 1475158843, 0, 0, 1),
(82, 1, 'wx1image_14751588441630.png', '/uploads/picture/2016-09-29/wx1image_14751588441630.png', '', 'local', 'picture', 'jpg', '', 22413, NULL, '', '', 0, 1475158844, 0, 0, 1),
(83, 1, 'wx1image_14751588456818.png', '/uploads/picture/2016-09-29/wx1image_14751588456818.png', '', 'local', 'picture', 'jpg', '', 12567, NULL, '', '', 0, 1475158845, 0, 0, 1),
(84, 1, 'wx1image_14751588548752.png', '/uploads/picture/2016-09-29/wx1image_14751588548752.png', '', 'local', 'picture', 'jpg', '', 86619, NULL, '', '', 0, 1475158854, 0, 0, 1),
(85, 1, 'wx1image_14751588549711', '/uploads/picture/2016-09-29/wx1image_14751588549711.jpg', '', 'local', 'picture', 'jpg', '', 11863, NULL, '', '', 0, 1475158854, 0, 0, 1),
(86, 1, 'wx1image_14751588628131', '/uploads/picture/2016-09-29/wx1image_14751588628131.jpg', '', 'local', 'picture', 'jpg', '', 35315, NULL, '', '', 0, 1475158862, 0, 0, 1),
(87, 1, 'wx1image_14751588668519', '/uploads/picture/2016-09-29/wx1image_14751588668519.jpg', '', 'local', 'picture', 'jpg', '', 27712, NULL, '', '', 0, 1475158866, 0, 0, 1),
(88, 1, 'wx1image_14751588684053', '/uploads/picture/2016-09-29/wx1image_14751588684053.jpg', '', 'local', 'picture', 'jpg', '', 101186, NULL, '', '', 0, 1475158868, 0, 0, 1),
(89, 1, 'wx1image_14751588703441', '/uploads/picture/2016-09-29/wx1image_14751588703441.jpg', '', 'local', 'picture', 'jpg', '', 155125, NULL, '', '', 0, 1475158870, 0, 0, 1),
(90, 1, 'wx1image_14751588708117', '/uploads/picture/2016-09-29/wx1image_14751588708117.jpg', '', 'local', 'picture', 'jpg', '', 24226, NULL, '', '', 0, 1475158870, 0, 0, 1),
(91, 1, 'meinv_admin_avatar', '/uploads/picture/2016-09-30/57edd952ba0e0.jpg', '', 'local', 'picture', 'jpg', '', 7006, NULL, '89b678fa35106c7a0f7579cb8426bd7a', '7d10ddb80359255e58c04bd30412b00bba6938a5', 0, 1475205458, 1475205458, 0, 1),
(92, 1, '57e0a9c03a61b', '/uploads/picture/2016-10-03/57f2076c4e997.jpg', '', 'local', 'picture', 'jpg', '', 110032, '', 'e3694c361707487802476e81709c863f', 'd5381f24235ee72d9fd8dfe2bb2e3d128217c8ce', 0, 1475479404, 1506556656, 0, 1),
(93, 1, '9812496129086622', '/uploads/picture/2016-10-06/57f6136b5bd4e.jpg', '', 'local', 'picture', 'jpg', '', 164177, NULL, '983944832c987b160ae409f71acc7933', 'bce6147f4070989fc0349798acf6383938e5563a', 0, 1475744619, 1475744619, 0, 1),
(94, 1, 'eacoophp-watermark-banner-1', 'http://cdn.eacoo123.com/static/demo-eacoophp/eacoophp-watermark-banner-1.jpg', 'http://cdn.eacoo123.com/static/demo-eacoophp/eacoophp-watermark-banner-1.jpg', 'link', 'picture', 'jpg', 'image', 171045, 'eacoophp-watermark-banner-1', '', '', 0, 1506215777, 1506215780, 0, 1),
(95, 1, 'eacoophp-banner-3', 'http://cdn.eacoo123.com/static/demo-eacoophp/eacoophp-banner-3.jpg', 'http://cdn.eacoo123.com/static/demo-eacoophp/eacoophp-banner-3.jpg', 'link', 'picture', 'jpg', 'image', 356040, 'eacoophp-banner-3', '', '', 0, 1506215801, 1506554992, 0, 1),
(96, 1, 'eacoophp-watermark-banner-2', 'http://cdn.eacoo123.com/static/demo-eacoophp/eacoophp-watermark-banner-2.jpg', 'http://cdn.eacoo123.com/static/demo-eacoophp/eacoophp-watermark-banner-2.jpg', 'link', 'picture', 'jpg', 'image', 356040, 'eacoophp-watermark-banner-2', '', '', 0, 1506215801, 1506215803, 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_auth_group`
--

CREATE TABLE `eacoo_auth_group` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `title` char(100) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) DEFAULT NULL COMMENT '描述信息',
  `rules` varchar(160) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `eacoo_auth_group`
--

INSERT INTO `eacoo_auth_group` (`id`, `title`, `description`, `rules`, `status`) VALUES
(1, '超级管理员', '拥有网站的最高权限', '1,2,26,9,27,28,29,15,8,16,3,44,6,4,37,38,39,40,41,42,48,50,10,32,13,33,11,51,54,57,5,24,22', 1),
(2, '管理员', '授权管理员', '1,3,8,13,37,10,22,36,11,50,5,4,14,41,42,44,38,39,40,24,51,35,28', 1),
(3, '普通用户', '这是普通用户的权限', '1,3,8,10,11,94,95,96,97,98,99,41,42,43,44,38,39,40', 1),
(4, '客服', '客服处理订单发货', '1,27,28,29,7,4,52,53,54,55', 1);

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_auth_group_access`
--

CREATE TABLE `eacoo_auth_group_access` (
  `uid` mediumint(8) UNSIGNED NOT NULL,
  `group_id` mediumint(8) UNSIGNED NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否审核  2：未审核，1:启用，0：禁用，-1：删除'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `eacoo_auth_group_access`
--

INSERT INTO `eacoo_auth_group_access` (`uid`, `group_id`, `status`) VALUES
(1, 1, 1),
(2, 3, 1),
(3, 3, 1),
(4, 3, 1),
(5, 3, 1),
(6, 3, 1),
(7, 4, 1);

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_auth_rule`
--

CREATE TABLE `eacoo_auth_rule` (
  `id` smallint(6) NOT NULL,
  `name` char(80) NOT NULL DEFAULT '0' COMMENT '导航链接',
  `title` char(20) NOT NULL DEFAULT '0' COMMENT '导航名字',
  `from_type` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '来源类型。1module，2plugin，3theme',
  `from_flag` varchar(50) NOT NULL DEFAULT '' COMMENT '来源标记',
  `type` tinyint(1) DEFAULT '1' COMMENT '是否支持规则表达式',
  `pid` smallint(6) UNSIGNED DEFAULT '0' COMMENT '上级id',
  `icon` varchar(50) DEFAULT NULL COMMENT '图标',
  `sort` smallint(6) UNSIGNED DEFAULT '0' COMMENT '排序',
  `condition` char(200) DEFAULT NULL,
  `is_menu` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否菜单',
  `developer` tinyint(1) NOT NULL DEFAULT '0' COMMENT '开发者',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `eacoo_auth_rule`
--

INSERT INTO `eacoo_auth_rule` (`id`, `name`, `title`, `from_type`, `from_flag`, `type`, `pid`, `icon`, `sort`, `condition`, `is_menu`, `developer`, `update_time`, `status`) VALUES
(1, 'admin/dashboard/index', '仪表盘', 1, 'admin', 1, 0, 'fa-tachometer', 1, NULL, 1, 0, 1505816276, 1),
(2, 'admin', '系统设置', 1, 'admin', 1, 0, 'fa-cog', 2, NULL, 1, 0, 1505816276, 1),
(3, 'admin/user/', '用户管理', 1, 'user', 1, 0, 'fa-users', 5, NULL, 1, 0, 1505816276, 1),
(4, 'admin/attachment/index', '附件空间', 1, 'admin', 1, 0, 'fa-picture-o', 7, NULL, 1, 0, 1505816276, 1),
(5, 'admin/extend/index', '扩展中心', 1, 'admin', 1, 0, 'fa-cloud', 11, NULL, 1, 0, 1505816276, 1),
(6, 'admin/nav/index', '导航管理', 1, 'admin', 1, 0, 'fa-leaf', 6, NULL, 1, 0, 1505816276, 0),
(7, 'admin/user/index', '用户列表', 1, 'user', 1, 3, '', 1, NULL, 1, 0, 1505816276, 1),
(8, 'admin/auth/role', '角色组', 1, 'user', 1, 15, '', 1, NULL, 1, 0, 1506843587, 1),
(9, 'admin/auth/adminMenu', '后台菜单管理', 1, 'admin', 1, 2, '', 11, NULL, 1, 1, 1505816276, 1),
(10, 'tools', '工具', 1, 'admin', 1, 0, 'fa-gavel', 9, NULL, 1, 1, 1505816276, 1),
(11, 'admin/database', '安全', 1, 'admin', 1, 10, 'fa-database', 12, NULL, 0, 0, 1505816276, 1),
(12, 'admin/attachment/setting', '设置', 1, 'admin', 1, 2, '', 0, NULL, 0, 0, 1505816276, 1),
(13, 'admin/link/index', '友情链接', 1, 'admin', 1, 10, '', 6, NULL, 1, 0, 1505816276, 1),
(14, 'admin/link/edit', '链接编辑', 1, 'admin', 1, 13, '', 1, NULL, 1, 0, 1505816276, 0),
(15, 'user/auth', '权限管理', 1, 'user', 1, 0, 'fa-sun-o', 4, NULL, 1, 0, 1505816276, 1),
(16, 'admin/auth/index', '规则管理', 1, 'admin', 1, 15, '', 2, NULL, 1, 0, 1505816276, 1),
(17, 'admin/mailer', '邮箱配置', 1, 'admin', 1, 10, '', 6, NULL, 1, 0, 1505816276, 0),
(19, 'admin/config/website', '网站设置', 1, 'admin', 1, 2, '', 4, NULL, 1, 0, 1505816276, 1),
(20, 'admin/database/index', '数据库管理', 1, 'admin', 1, 10, 'fa-database', 13, NULL, 1, 0, 1505816276, 1),
(22, 'admin/theme/index', '主题', 1, 'admin', 1, 5, '', 3, NULL, 1, 0, 1505816276, 1),
(23, 'admin/plugins/index', '插件', 1, 'admin', 1, 5, '', 2, NULL, 1, 0, 1505816276, 1),
(24, 'admin/modules/index', '模块', 1, 'admin', 1, 5, '', 0, NULL, 1, 0, 1505816276, 1),
(25, 'admin/config/index', '配置管理', 1, 'admin', 1, 2, '', 15, NULL, 1, 1, 1505816276, 1),
(26, 'admin/config/group', '系统设置', 1, 'admin', 1, 2, '', 1, NULL, 1, 0, 1505816276, 1),
(27, 'user/action', '日志管理', 1, 'user', 1, 0, 'fa-list-alt', 3, NULL, 1, 0, 1505816276, 1),
(28, 'admin/action/index', '用户行为', 1, 'user', 1, 27, NULL, 1, NULL, 1, 0, 1505816276, 1),
(29, 'admin/action/log', '行为日志', 1, 'user', 1, 27, NULL, 2, NULL, 1, 0, 1505816276, 1),
(30, 'admin/plugins/hooks', '钩子管理', 1, 'admin', 1, 23, '', 1, NULL, 0, 1, 1505816276, 1),
(32, 'admin/mailer/mailer_template', '邮件模板', 1, 'admin', 1, 10, NULL, 5, NULL, 1, 0, 1505816276, 1),
(33, 'admin/addons/config?id=2', '通用社交化评论', 1, 'admin', 1, 10, '', 7, NULL, 0, 0, 1505816276, 1),
(37, 'admin/attachment/attachmentCategory', '附件分类', 1, 'admin', 1, 4, NULL, 1, NULL, 0, 0, 1505816276, 1),
(38, 'admin/attachment/upload', '文件上传', 1, 'admin', 1, 4, NULL, 1, NULL, 0, 0, 1505816276, 1),
(39, 'admin/attachment/uploadPicture', '上传图片', 1, 'admin', 1, 4, NULL, 1, NULL, 0, 0, 1505816276, 1),
(40, 'admin/attachment/upload_onlinefile', '添加外链附件', 1, 'admin', 1, 4, NULL, 1, NULL, 0, 0, 1505816276, 1),
(41, 'admin/attachment/attachmentInfo', '附件详情', 1, 'admin', 1, 4, NULL, 1, NULL, 0, 0, 1505816276, 1),
(42, 'admin/attachment/uploadAvatar', '上传头像', 1, 'admin', 1, 4, NULL, 1, NULL, 0, 0, 1505816276, 1),
(43, 'user/tags/index', '标签管理', 1, 'user', 1, 3, '', 2, NULL, 1, 0, 1505816276, 0),
(44, 'user/tongji/analyze', '会员统计', 1, 'user', 1, 3, '', 4, NULL, 1, 0, 1505816276, 1),
(46, 'admin/api/index', '接口配置', 1, 'admin', 1, 10, '', 3, NULL, 1, 0, 1505816276, 1),
(47, 'user/message/', '站内信', 1, 'user', 1, 0, 'fa-envelope-o', 8, NULL, 1, 0, 1505816276, 1),
(48, 'user/message/messages', '收件箱', 1, 'user', 1, 47, NULL, 1, NULL, 1, 0, 1505816276, 1),
(49, 'user/message/message_detail', '信息详情', 1, 'user', 1, 47, NULL, 1, NULL, 1, 0, 1505816276, 0),
(50, 'user/message/messages?box_type=outbox', '发件箱', 1, 'user', 1, 47, '', 1, NULL, 1, 0, 1505816276, 1),
(51, 'cms/posts', '门户CMS', 1, 'cms', 1, 0, 'fa fa-file-text', 10, NULL, 1, 0, 1506823803, 1),
(52, 'cms/posts/index', '文章列表', 1, 'cms', 1, 51, NULL, 99, NULL, 1, 0, 1506823803, 1),
(53, 'cms/posts/edit', '文章编辑', 1, 'cms', 1, 51, NULL, 99, NULL, 0, 0, 1506823803, 1),
(54, 'cms/category/index', '文章分类', 1, 'cms', 1, 51, NULL, 99, NULL, 1, 0, 1506823803, 1),
(55, 'cms/category/index?taxonomy=post_tag', '文章标签', 1, 'cms', 1, 51, NULL, 99, NULL, 1, 0, 1506823803, 1),
(56, 'cms/page/index', '页面列表', 1, 'cms', 1, 51, NULL, 99, NULL, 1, 0, 1506823803, 1),
(57, 'cms/posts/trash', '回收站', 1, 'cms', 1, 51, NULL, 99, NULL, 1, 0, 1506823803, 1),
(58, 'admin/plugins/config?name=ImageGallery', '图片轮播', 2, 'ImageGallery', 1, 10, 'fa fa-file-text', 99, NULL, 1, 0, 1506848328, 1),
(59, 'admin/plugins/config?name=Alidayu', '阿里大于-短信接口', 2, 'Alidayu', 1, 10, '', 99, NULL, 1, 0, 1506848334, 1),
(60, 'admin/plugins/config?name=SocialLogin', '第三方登录', 2, 'SocialLogin', 1, 10, '', 99, NULL, 1, 0, 1506848338, 1);

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_comments`
--

CREATE TABLE `eacoo_comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `from` tinyint(1) UNSIGNED NOT NULL COMMENT '评论来源。',
  `object_id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '评论内容 id',
  `url` varchar(255) DEFAULT NULL COMMENT '原文地址',
  `uid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '发表评论的用户id',
  `author_name` varchar(60) NOT NULL DEFAULT '' COMMENT '评论者昵称',
  `author_ip` varchar(100) NOT NULL DEFAULT '' COMMENT '评论者IP',
  `email` varchar(255) DEFAULT NULL COMMENT '评论者邮箱',
  `content` text NOT NULL COMMENT '评论内容',
  `type` smallint(1) NOT NULL DEFAULT '1' COMMENT '评论类型；1实名评论',
  `pid` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '被回复的评论id',
  `zan` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `path` varchar(500) DEFAULT NULL,
  `create_time` int(11) UNSIGNED NOT NULL COMMENT '评论时间',
  `status` smallint(1) NOT NULL DEFAULT '1' COMMENT '状态，1已审核，0未审核'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论表';

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_comment_zan`
--

CREATE TABLE `eacoo_comment_zan` (
  `id` int(11) UNSIGNED NOT NULL,
  `comment_id` int(11) UNSIGNED NOT NULL COMMENT '评论ID',
  `uid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `create_time` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_config`
--

CREATE TABLE `eacoo_config` (
  `id` int(10) UNSIGNED NOT NULL COMMENT '配置ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '配置名称',
  `title` varchar(50) NOT NULL COMMENT '配置说明',
  `value` text NOT NULL COMMENT '配置值',
  `options` varchar(255) NOT NULL COMMENT '配置额外值',
  `function` varchar(60) NOT NULL COMMENT '关联函数',
  `group` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '配置分组',
  `sub_group` tinyint(3) DEFAULT '0' COMMENT '子分组，子分组需要自己定义',
  `type` varchar(16) NOT NULL DEFAULT '0' COMMENT '配置类型',
  `remark` varchar(500) NOT NULL COMMENT '配置说明',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间',
  `sort` smallint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `eacoo_config`
--

INSERT INTO `eacoo_config` (`id`, `name`, `title`, `value`, `options`, `function`, `group`, `sub_group`, `type`, `remark`, `create_time`, `update_time`, `sort`, `status`) VALUES
(1, 'toggle_web_site', '站点开关', '1', '0:关闭\r\n1:开启', '', 1, 0, 'select', '站点关闭后将提示网站已关闭，不能正常访问', 1378898976, 1406992386, 1, 1),
(2, 'web_site_title', '网站标题', 'EacooPHP', '', '', 6, 0, 'text', '网站标题前台显示标题', 1378898976, 1506258177, 2, 1),
(4, 'web_site_logo', '网站LOGO', '250', '', '', 6, 0, 'picture', '网站LOGO', 1407003397, 1506258177, 4, 1),
(5, 'web_site_description', 'SEO描述', 'EacooPHP框架基于统一核心的通用互联网+信息化服务解决方案，追求简单、高效、卓越。可轻松实现支持多终端的WEB产品快速搭建、部署、上线。系统功能采用模块化、组件化、插件化等开放化低耦合设计，应用商城拥有丰富的功能模块、插件、主题，便于用户灵活扩展和二次开发。', '', '', 6, 1, 'textarea', '网站搜索引擎描述', 1378898976, 1506257875, 6, 1),
(6, 'web_site_keyword', 'SEO关键字', '开源框架 EacooPHP ThinkPHP', '', '', 6, 1, 'textarea', '网站搜索引擎关键字', 1378898976, 1506257874, 4, 1),
(7, 'web_site_copyright', '版权信息', 'Copyright © ******有限公司 All rights reserved.', '', '', 1, 0, 'text', '设置在网站底部显示的版权信息', 1406991855, 1468493911, 7, 1),
(8, 'web_site_icp', '网站备案号', '豫ICP备14003306号', '', '', 6, 0, 'text', '设置在网站底部显示的备案号，如“苏ICP备1502009-2号"', 1378900335, 1506258177, 8, 1),
(9, 'web_site_statistics', '站点统计', '', '', '', 1, 0, 'textarea', '支持百度、Google、cnzz等所有Javascript的统计代码', 1378900335, 1415983236, 9, 1),
(10, 'index_url', '首页地址', 'http://www.eacoo123.com', '', '', 2, 0, 'text', '可以通过配置此项自定义系统首页的地址，比如：http://www.xxx.com', 1471579753, 1506099586, 0, 1),
(11, 'upload_file_size', '文件上传大小', '20', '', '', 9, 0, 'number', '文件上传大小单位：MB', 1428681031, 1428681031, 1, 1),
(12, 'upload_image_size', '图片上传大小', '2', '', '', 9, 0, 'number', '图片上传大小单位：MB', 1428681071, 1428681071, 2, 1),
(13, 'admin_tags', '后台多标签', '0', '0:关闭\r\n1:开启', '', 2, 0, 'radio', '', 1453445526, 1506099586, 3, 1),
(14, 'admin_page_rows', '分页数量', '20', '', '', 2, 0, 'number', '分页时每页的记录数', 1434019462, 1506099586, 4, 1),
(15, 'admin_theme', '后台主题', 'default', 'default:默认主题\r\nblue:蓝色理想\r\ngreen:绿色生活', '', 2, 0, 'select', '后台界面主题', 1436678171, 1506099586, 5, 1),
(16, 'develop_mode', '开发模式', '1', '1:开启\r\n0:关闭', '', 3, 0, 'select', '开发模式下会显示菜单管理、配置管理、数据字典等开发者工具', 1432393583, 1504700766, 1, 1),
(17, 'app_trace', '是否显示页面Trace', '0', '1:开启\r\n0:关闭', '', 3, 0, 'select', '是否显示页面Trace信息', 1387165685, 1504700742, 2, 1),
(18, 'auth_key', '系统加密KEY', 'vzxI=vf[=xV)?a^XihbLKx?pYPw$;Mi^R*<mV;yJh$wy(~~E?<.JA&ANdIZ#QhPq', '', '', 3, 0, 'textarea', '轻易不要修改此项，否则容易造成用户无法登录；如要修改，务必备份原key', 1438647773, 1504700766, 3, 1),
(20, 'static_domain', '静态文件独立域名', '', '', '', 4, 0, 'text', '静态文件独立域名一般用于在用户无感知的情况下平和的将网站图片自动存储到腾讯万象优图、又拍云等第三方服务。', 1438564784, 1438564784, 3, 1),
(21, 'config_group_list', '配置分组', '1:基本\r\n2:系统\r\n3:开发\r\n4:部署\r\n5:授权\r\n6:网站信息\r\n7:用户\r\n8:邮箱\r\n9:多媒体', '', '', 3, 0, 'array', '配置分组的键值对不要轻易改变', 1379228036, 1467557143, 5, 1),
(22, 'eacoo_username', '官网账号', 'eacoo', '', '', 5, 0, 'text', '官网登陆账号（支持用户名、邮箱、手机号）', 1438647815, 1464602856, 1, 1),
(23, 'eacoo_password', '官网密码', 'eacoo', '', '', 5, 0, 'text', '官网密码', 1438647815, 1464602874, 2, 1),
(24, 'eacoo_sn', '密钥', '', '', '', 5, 0, 'textarea', '密钥请通过登陆http://www.eacoomall.com至个人中心获取', 1438647815, 1468493748, 3, 1),
(25, 'form_item_type', '表单项目类型', 'hidden:隐藏\r\nonlyreadly:仅读文本\r\nnumber:数字\r\ntext:单行文本\r\ntextarea:多行文本\r\narray:数组\r\npassword:密码\r\nradio:单选框\r\ncheckbox:复选框\r\nselect:下拉框\r\nicon:字体图标\r\ndate:日期\r\ndatetime:时间\r\npicture:单张图片\r\npictures:多张图片\r\nfile:单个文件\r\nfiles:多个文件\r\nwangeditor:wangEditor编辑器\r\nueditor:百度富文本编辑器\r\neditormd:Markdown编辑器\r\ntags:标签\r\njson:JSON\r\nboard:拖', '', '', 3, 0, 'array', '专为配置管理设定\r\n', 1464533806, 1500174666, 0, 1),
(26, 'term_taxonomy', '分类法', 'post_category:分类目录\r\npost_tag:标签\r\nmedia_cat:多媒体分类', '', '', 3, 0, 'array', '', 1465267993, 1468421717, 0, 1),
(27, 'data_backup_path', '数据库备份根路径', '../data/backup', '', '', 2, 0, 'text', '', 1465478225, 1506099586, 0, 1),
(28, 'data_backup_part_size', '数据库备份卷大小', '20971520', '', '', 2, 0, 'number', '', 1465478348, 1506099586, 0, 1),
(29, 'data_backup_compress_level', '数据库备份文件压缩级别', '4', '1:普通\r\n4:一般\r\n9:最高', '', 2, 0, 'radio', '', 1465478496, 1506099586, 0, 1),
(30, 'data_backup_compress', '数据库备份文件压缩', '1', '0:不压缩\r\n1:启用压缩', '', 2, 0, 'radio', '', 1465478578, 1506099586, 0, 1),
(31, 'hooks_type', '钩子的类型', '1:视图\r\n2:控制器', '', '', 3, 0, 'array', '', 1465478697, 1465478697, 0, 1),
(32, 'addon_path', '插件目录', '../addons/', '', '', 2, 0, 'text', '', 1465657982, 1497887712, 0, 0),
(33, 'action_type', '行为类型', '1:系统\r\n2:用户', '1:系统\r\n2:用户', '', 7, 0, 'array', '配置说明', 1466953086, 1466953086, 0, 1),
(34, 'website_group', '网站信息子分组', '0:基本信息\r\n1:SEO设置\r\n2:URL设置\r\n3:评论设置\r\n4:性能安全\r\n5:广告设置', '', '', 6, 0, 'array', '作为网站信息配置的子分组配置，每个大分组可设置子分组作为tab切换', 1467516762, 1472487030, 20, 1),
(35, 'mail_smtp', 'SMTP配置', '{"smtp_sender":"EacooPHP","smtp_address":"zjf2616@163.com","smtp_host":"smtp.163.com","smtp_secure":"none","smtp_port":"25","smtp_login":"zjf2616@163.com","smtp_password":""}', '', '', 8, 0, 'json', 'JSON格式保存多个配置属性', 1467519186, 1501769507, 0, 1),
(36, 'mail_reg_active_template', '注册激活邮件模板', '{"active":"0","subject":"\\u6ce8\\u518c\\u6fc0\\u6d3b\\u901a\\u77e5"}', '', '', 8, 0, 'json', 'JSON格式保存除了模板内容的属性', 1467519451, 1467519451, 0, 1),
(37, 'mail_captcha_template', '验证码邮件模板', '{"active":"0","subject":"\\u90ae\\u7bb1\\u9a8c\\u8bc1\\u7801\\u901a\\u77e5"}', '', '', 8, 0, 'json', 'JSON格式保存除了模板内容的属性', 1467519582, 1467818456, 0, 1),
(38, 'mail_reg_active_template_content', '注册激活邮件模板内容', '<p><span style="font-family: 微软雅黑; font-size: 14px;"></span><span style="font-family: 微软雅黑; font-size: 14px;">您在{$title}的激活链接为</span><a href="{$url}" target="_blank" style="font-family: 微软雅黑; font-size: 14px; white-space: normal;">激活</a><span style="font-family: 微软雅黑; font-size: 14px;">，或者请复制链接：{$url}到浏览器打开。</span></p>', '', '', 8, 0, 'textarea', '注册激活模板邮件内容部分，模板内容单独存放', 1467818340, 1467818340, 0, 1),
(39, 'mail_captcha_template_content', '验证码邮件模板内容', '<p><span style="font-family: 微软雅黑; font-size: 14px;">您的验证码为{$verify}验证码，账号为{$account}。</span></p>', '', '', 8, 0, 'textarea', '验证码邮件模板内容部分', 1467818435, 1467818435, 0, 1),
(40, 'attachment_options', '附件配置选项', '{"page_number":"30","cut":"1","small_size":{"width":"150","height":"150"},"medium_size":{"width":"320","height":"280"},"large_size":{"width":"560","height":"430"},"watermark_scene":"2","watermark_type":"1","water_position":"9","water_img":"\\/logo.png","water_opacity":"100"}', '', '', 9, 0, 'hidden', '以JSON格式保存', 1467858734, 1499957776, 0, 1),
(41, 'attachment_show_type', '附件选择器显示方式', '0', '0:显示所有\r\n1:只显示作者的上传', '', 9, 1, 'radio', '在附件选择器中显示的附件内容', 1468421212, 1468422705, 0, 1),
(42, 'user_deny_username', '保留用户名和昵称', '管理员,测试,admin,垃圾', '', '', 7, 0, 'textarea', '禁止注册用户名和昵称，包含这些即无法注册,用&quot; , &quot;号隔开，用户只能是英文，下划线_，数字等', 1468493201, 1468493201, 0, 1),
(43, 'verify_open', '验证码配置', 'reg,login,reset', 'reg:注册显示\r\nlogin:登陆显示\r\nreset:密码重置', '', 2, 0, 'checkbox', '验证码开启配置', 1468494419, 1506099586, 0, 1),
(44, 'verify_type', '验证码类型', '2', '1:中文\r\n2:英文\r\n3:数字\r\n4:英文+数字', '', 2, 0, 'select', '验证码类型', 1468494591, 1506099586, 0, 1),
(45, 'web_site_subtitle', '网站副标题', '基于ThinkPHP5的开发框架', '', '', 6, 0, 'textarea', '用简洁的文字描述本站点（网站口号、宣传标语、一句话介绍）', 1468593713, 1506258177, 2, 1),
(46, 'adv_advlimitdate', '点击限制时间', '5', '', '', 6, 5, 'number', '同一个用户规定时间之后点击广告才能再获得一毛钱，单位：分钟', 1470845297, 1470845297, 0, 1),
(49, 'reg_default_roleid', '注册默认角色', '4', '', 'role_type', 7, 0, 'select', '', 1471681620, 1471689765, 0, 1),
(50, 'open_register', '开放注册', '', '1:是\r\n0:否', '', 7, 0, 'radio', '', 1471681674, 1471681674, 0, 1),
(56, 'meanwhile_user_online', '允许同时登录', '1', '1:是\r\n0:否', '', 7, 0, 'radio', '是否允许同一帐号在不同地方同时登录', 1473437355, 1473437355, 0, 1),
(57, 'aliyun_oss', '阿里云oss', '{"enable":"1","bucket":"eacoomall-shop","access_key_id":"","access_key_secret":"","root_path":"images","domain":"http:\\/\\/img.eacoomall.com","endpoint":"http:\\/\\/oss-cn-beijing.aliyuncs.com","style":[{"name":"wap-thumb"},{"name":"small"},{"name":"medium"},{"name":"large"}]}', '', '', 0, 0, 'json', '阿里云OSS配置', 1473437355, 1500182001, 0, 1),
(58, 'api_kdniao', '快递鸟', '', '', '', 0, 0, 'json', '\n快递鸟设置，应用于电子面单中使用，未配置，将导致商家无法使用电子面单\n系统在调取物流信息时将调用快递鸟的“即时查询API”接口获取物流数据\n您可以通过 测试物流查询 链接测试物流信息查询', 1473437355, 1500182001, 0, 1),
(59, 'user_administrator', '超级管理员', '1', '', '', 7, 0, 'text', '填写用户UID，多个用户用英文逗号","分开', 1503412286, 1503412339, 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_hooks`
--

CREATE TABLE `eacoo_hooks` (
  `id` int(10) UNSIGNED NOT NULL COMMENT '钩子ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` varchar(300) NOT NULL DEFAULT '' COMMENT '描述',
  `plugins` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子挂载的插件',
  `type` tinyint(4) UNSIGNED NOT NULL DEFAULT '1' COMMENT '类型。1视图，2控制器',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='钩子表';

--
-- 转存表中的数据 `eacoo_hooks`
--

INSERT INTO `eacoo_hooks` (`id`, `name`, `description`, `plugins`, `type`, `create_time`, `update_time`, `status`) VALUES
(1, 'AdminIndex', '后台首页小工具', '后台首页小工具', 1, 1446522155, 1446522155, 1),
(2, 'FormBuilderExtend', 'FormBuilder类型扩展Builder', '', 1, 1447831268, 1447831268, 1),
(3, 'UploadFile', '上传文件钩子', '', 1, 1407681961, 1407681961, 1),
(4, 'PageHeader', '页面header钩子，一般用于加载插件CSS文件和代码', 'SocialLogin', 1, 1407681961, 1407681961, 1),
(5, 'PageFooter', '页面footer钩子，一般用于加载插件CSS文件和代码', '', 1, 1407681961, 1407681961, 1),
(6, 'SocialLogin', '第三方账号登陆', 'SocialLogin', 1, 1465057122, 1465057122, 1),
(7, 'SendMessage', '发送消息钩子，用于消息发送途径的扩展', '', 2, 1467423450, 1467423450, 1),
(8, 'sms', '短信插件钩子', 'Alidayu', 2, 1467424112, 1467424112, 1),
(9, 'uploadPicture', '上传图片处理', '', 2, 1467424195, 1506825220, 1),
(10, 'ImageGallery', '图片轮播钩子', 'ImageGallery', 1, 1467424242, 1467424242, 1),
(11, 'J_China_City', '每个系统都需要的一个中国省市区三级联动插件。', '', 1, 1467424257, 1467424257, 1),
(12, 'checkIn', '签到', '', 1, 1467424298, 1467424298, 1),
(13, 'app_begin', '应用开始', '', 2, 1467424315, 1467424315, 1),
(14, 'adminEditor', '后台内容编辑页编辑器', '', 1, 1467424354, 1467424354, 1);

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_links`
--

CREATE TABLE `eacoo_links` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `image` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '图标',
  `url` varchar(150) NOT NULL DEFAULT '' COMMENT '链接',
  `target` varchar(25) NOT NULL DEFAULT '_blank' COMMENT '打开方式',
  `type` int(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '类型',
  `rating` int(11) UNSIGNED NOT NULL COMMENT '评级',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '修改时间',
  `sort` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '状态，1显示，0不显示'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='友情链接表';

--
-- 转存表中的数据 `eacoo_links`
--

INSERT INTO `eacoo_links` (`id`, `title`, `image`, `url`, `target`, `type`, `rating`, `create_time`, `update_time`, `sort`, `status`) VALUES
(13, '淘宝', 89, 'http://www.taobao.com', '_blank', 1, 9, 1465053539, 1506825148, 1, 1),
(14, '百度', 96, 'http://www.baidu.com', '_blank', 2, 8, 1467863440, 1506825187, 2, 1);

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_messages`
--

CREATE TABLE `eacoo_messages` (
  `id` int(10) NOT NULL COMMENT '消息ID',
  `pid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '消息父ID',
  `title` varchar(1024) NOT NULL DEFAULT '' COMMENT '消息标题',
  `content` text COMMENT '消息内容',
  `type` tinyint(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0系统消息,1私信消息,2评论消息',
  `to_uid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '接收用户ID',
  `from_uid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '私信消息发信用户ID',
  `is_read` tinyint(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否已读，0未读，1已读',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '发送时间',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间',
  `sort` tinyint(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户消息表';

--
-- 转存表中的数据 `eacoo_messages`
--

INSERT INTO `eacoo_messages` (`id`, `pid`, `title`, `content`, `type`, `to_uid`, `from_uid`, `is_read`, `create_time`, `update_time`, `sort`, `status`) VALUES
(1, 0, '主题', '消息内容文字', 1, 1, 1, 1, 1467337582, 1467337582, 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_modules`
--

CREATE TABLE `eacoo_modules` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `name` varchar(31) NOT NULL DEFAULT '' COMMENT '名称',
  `title` varchar(63) NOT NULL DEFAULT '' COMMENT '标题',
  `logo` varchar(120) NOT NULL DEFAULT '' COMMENT '图片图标',
  `description` varchar(127) NOT NULL DEFAULT '' COMMENT '描述',
  `author` varchar(31) NOT NULL DEFAULT '' COMMENT '开发者',
  `version` varchar(7) NOT NULL DEFAULT '' COMMENT '版本',
  `config` text NOT NULL COMMENT '配置',
  `is_system` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否允许卸载',
  `url` varchar(120) DEFAULT NULL COMMENT '站点',
  `admin_manage_into` varchar(60) DEFAULT '' COMMENT '后台管理入口',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间',
  `sort` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='模块功能表';

--
-- 转存表中的数据 `eacoo_modules`
--

INSERT INTO `eacoo_modules` (`id`, `name`, `title`, `logo`, `description`, `author`, `version`, `config`, `is_system`, `url`, `admin_manage_into`, `create_time`, `update_time`, `sort`, `status`) VALUES
(1, 'user', '用户', '', '用户模块，系统核心模块，不可卸载', '心云间、凝听', '1.0.0', '', 1, 'http://www.eacoo123.com', '', 1470274208, 1505663942, 6, 1),
(2, 'home', '前台Home', '', '一款基础前台Home模块', '心云间、凝听', '1.0.0', '', 1, NULL, '', 1505923537, 1505923556, 0, 1),
(4, 'wechat', '微信公众号', '', '专注微信公众号平台开发', '心云间、凝听', '1.0', '{"need_check":"0","toggle_comment":"1","group_list":"1:\\u9ed8\\u8ba4","cate":"a:1","taglib":["Comment"]}', 0, 'http://www.eacoo123.com', '', 1498061286, 1498061286, 5, 1),
(5, 'cms', '门户CMS', '', '门户网站管理、CMS、内容管理', '心云间、凝听', '1.0.3', '{"need_check":"0","toggle_comment":"1","group_list":"1:\\u9ed8\\u8ba4","cate":"a:1","taglib":["cms"]}', 0, NULL, '', 1506823803, 1506823803, 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_nav`
--

CREATE TABLE `eacoo_nav` (
  `id` int(11) UNSIGNED NOT NULL,
  `title` varchar(60) NOT NULL DEFAULT '' COMMENT '标题',
  `position` varchar(30) NOT NULL DEFAULT '' COMMENT '位置。头部：top，用户中心：usercenter',
  `type` tinyint(2) UNSIGNED NOT NULL COMMENT '类型。1模块',
  `value` varchar(120) NOT NULL DEFAULT '' COMMENT 'url地址',
  `icon` varchar(120) NOT NULL DEFAULT '' COMMENT '图标',
  `create_time` int(10) UNSIGNED NOT NULL COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NOT NULL COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_plugins`
--

CREATE TABLE `eacoo_plugins` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '主键',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '插件名或标识',
  `title` varchar(32) NOT NULL DEFAULT '' COMMENT '中文名',
  `logo` varchar(120) NOT NULL DEFAULT '' COMMENT 'LOGO',
  `description` text NOT NULL COMMENT '插件描述',
  `config` text COMMENT '配置',
  `author` varchar(32) NOT NULL DEFAULT '' COMMENT '作者',
  `version` varchar(8) NOT NULL DEFAULT '' COMMENT '版本号',
  `admin_manage_into` varchar(60) DEFAULT '0' COMMENT '后台管理入口',
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '插件类型',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '安装时间',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '修改时间',
  `sort` tinyint(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='插件表';

--
-- 转存表中的数据 `eacoo_plugins`
--

INSERT INTO `eacoo_plugins` (`id`, `name`, `title`, `logo`, `description`, `config`, `author`, `version`, `admin_manage_into`, `type`, `create_time`, `update_time`, `sort`, `status`) VALUES
(1, 'ImageGallery', '幻灯片', '', '图片轮播滑块器，可用于图片展示', '{"status":1,"type":"flexslider","sliders":[{"img":94,"url":"http:\\/\\/www.eacoo123.com","text":"EacooPHP\\u5feb\\u901f\\u5f00\\u53d1\\u6846\\u67b6"},{"img":95,"url":"http:\\/\\/forum.eacoo123.com","text":"EacooPHP\\u8ba8\\u8bba\\u793e\\u533a"},{"img":94,"url":"http:\\/\\/www.eacoo123.com","text":"EacooPHP\\u5feb\\u901f\\u5f00\\u53d1\\u6846\\u67b6"}],"second":"3000","direction":"horizontal","imgWidth":"","imgHeight":"880"}', '心云间、凝听', '1.0.0', '0', 1, 1506848328, 1506848328, 0, 1),
(2, 'Alidayu', '阿里大于-短信接口', '/static/plugins/Alidayu/logo.jpg', '通过阿里大于短信接口发送短信', '{"status":"1","appkey":"","secret":""}', '心云间、凝听', '1.0.0', '', 1, 1506848334, 1506848334, 0, 1),
(3, 'SocialLogin', '第三方账号登录', '', '集成第三方授权登录，包括微博、QQ、微信', '{"type":"","meta":"","WeixinKey":"","WeixinSecret":"","QqKey":"","QqSecret":"","SinaKey":"","SinaSecret":"","RenrenKey":"","RenrenSecret":""}', '心云间、凝听', '0.0.1', '', 1, 1506848338, 1506848338, 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_plugin_social_login`
--

CREATE TABLE `eacoo_plugin_social_login` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `uid` int(11) UNSIGNED NOT NULL COMMENT '用户ID',
  `type` varchar(15) NOT NULL DEFAULT '' COMMENT '类别',
  `openid` varchar(64) NOT NULL DEFAULT '' COMMENT 'OpenID',
  `access_token` varchar(64) NOT NULL DEFAULT '' COMMENT 'AccessToken',
  `refresh_token` varchar(64) NOT NULL DEFAULT '' COMMENT 'RefreshToken',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间',
  `sort` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='第三方登陆插件表';

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_postmeta`
--

CREATE TABLE `eacoo_postmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_posts`
--

CREATE TABLE `eacoo_posts` (
  `id` int(11) UNSIGNED NOT NULL COMMENT '主键',
  `title` varchar(255) NOT NULL DEFAULT '0' COMMENT '标题',
  `slug` varchar(200) NOT NULL DEFAULT '',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '文章类型,post,page,product',
  `source` varchar(100) DEFAULT NULL COMMENT '来源',
  `excerpt` text COMMENT '摘要',
  `content` longtext NOT NULL COMMENT '内容',
  `author_id` int(11) UNSIGNED NOT NULL COMMENT '作者',
  `seo_keywords` tinytext COMMENT 'seo_keywords',
  `img` int(11) UNSIGNED DEFAULT '0' COMMENT '封面图片',
  `views` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '浏览数',
  `collection` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '收藏量',
  `comment_count` int(11) UNSIGNED DEFAULT '0',
  `parent` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'post的父级post id,表示post层级关系',
  `password` varchar(32) DEFAULT NULL,
  `fields` varchar(300) DEFAULT '' COMMENT 'post的扩展字段，保存相关扩展属性，如缩略图；格式为json',
  `istop` tinyint(1) UNSIGNED DEFAULT '0' COMMENT '置顶 1置顶； 0不置顶',
  `recommended` tinyint(1) DEFAULT '0' COMMENT '推荐 1推荐 0不推荐，大于1的数字可设定为不同推荐区',
  `publish_time` int(10) UNSIGNED DEFAULT '0' COMMENT '发布时间',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间',
  `sort` int(10) UNSIGNED DEFAULT '0' COMMENT '排序号',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 -1 删除 0审核 1为已发布'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章表';

--
-- 转存表中的数据 `eacoo_posts`
--

INSERT INTO `eacoo_posts` (`id`, `title`, `slug`, `type`, `source`, `excerpt`, `content`, `author_id`, `seo_keywords`, `img`, `views`, `collection`, `comment_count`, `parent`, `password`, `fields`, `istop`, `recommended`, `publish_time`, `create_time`, `update_time`, `sort`, `status`) VALUES
(1, '揭秘eBay四大系统 从行为数据中寻找价值', '', 'post', NULL, '', '<p style="box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(102, 102, 102); font-family: \'Microsoft Yahei\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; white-space: normal;">喜欢海淘的朋友应该对eBay并不陌生，如果你还不了解，可以把eBay+PayPal理解为淘宝+支付宝的组合，当然eBay不仅有C2C还有B2C的模式，甚至还有二手卖家。</p><p style="box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(102, 102, 102); font-family: \'Microsoft Yahei\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; white-space: normal;">铺垫了一些背景，我们再来说说电子商务，现在还有没网购过的同学请举手，1、2、3……可能没有几个。虽然大家都在各种电子商务网站上购过物，但是你是否知道你在网上的一切行为都已经被记录并进行分析。</p><p style="box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(102, 102, 102); font-family: \'Microsoft Yahei\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; white-space: normal;">不论国外还是国内的电子商务企业，他们的相同点都是以业务为导向。eBay的做法是用数据驱动商业，其上所有的数据产品都是针对业务而生，数据部门需要对不断变化的用户需求找到解决之法，也就是从客户的行为数据中来寻找价值。</p><h3 style="box-sizing: border-box; font-family: \'Microsoft Yahei\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-weight: normal; line-height: 1.1; color: rgb(68, 68, 68); margin-top: 20px; margin-bottom: 16px; font-size: 16px; border-bottom-color: rgb(238, 238, 238); border-bottom-width: 1px; border-bottom-style: solid; padding-bottom: 0px; white-space: normal;"><strong style="box-sizing: border-box;">行为数据用混合的手段来处理</strong></h3><p style="box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(102, 102, 102); font-family: \'Microsoft Yahei\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; white-space: normal;">数据是eBay发展的基础和价值所在，所以eBay数据服务和解决方案团队从eBay成立的第一天就已经存在，从数据仓库到数据分析再到数据服务，部门的名字一直随着发展在不断变化。但万变不离其宗，数据服务和解决方案团队就是一个针对数据展开想象的部门。</p><p style="box-sizing: border-box; margin-top: 0px; margin-bottom: 16px; color: rgb(102, 102, 102); font-family: \'Microsoft Yahei\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; white-space: normal;">eBay数据服务和解决方案团队分布在美国西雅图、圣何塞以及中国上海，而中国团队全职和外包人员总共将近有100人，其中有不同的职位和分工，包括数据科学家、数据工程师、商业需求分析师、产品经理四大类。两个区域的团队互相协作，共同开发核心数据的同时也支持不同的业务部门。</p><p><br/></p>', 1, '', 68, 0, 0, 0, 0, NULL, '', 0, 0, 0, 1464081408, 1506666740, 0, 1),
(2, '谷歌数据中心安全及设计的最佳实践', '', 'post', NULL, NULL, '<p>在首次云端平台使用者大会(Google Cloud Platform Global User Conference)上，谷歌的两位领导者——数据中心的运营副总裁Joe Kava和安全隐私方面的优秀工程师Niels Provos向与会者分享了谷歌在全球范围内设计、构建、运行和保护数据中心的实践方式，其中包含一些令谷歌的数据中心独一无二的秘诀，及其对于谷歌云端平台用户的意义。\r\n\r\n安全性和数据保护sdf\r\n\r\n谷歌一直以来将重心放在数据的安全和保护上，这也是我们的关键设计准则之一。在物理安全方面，我们以分层安全模型为特色，使用了如定制的电子访问卡、警报器、车辆进出限制、围栏架设、金属探测器及生物识别技术等保障措施。数据中心的地板配备了激光束入侵探测器，并安装了高清晰度的内外监视器，全天候检测追踪入侵行为。此外为以防万一，可随时调用访问日志、活动记录以及监控录像。\r\n\r\n同时数据中心还安排了经验丰富的保安人员每日例行巡逻，他们已接受过背景调查与严格的培训(可以点击查看数据中心的360度视频)。越靠近数据中心，安全措施系数就越高，只有一条安全通道能进入数据中心，通过安全徽章和生物识别技术来实现多重访问控制，只有特定职位的员工才有权进入。在整个谷歌公司，只有不到1%的员工曾踏足此区域。\r\n\r\n我们还采用了非常严格的点对点监管链，用于储存、追踪全过程——从第一次HD输入机器直至证实其已被销毁或清除。同时，我们采用了信息安全和物理安全双管齐下的方式，由于数据通过网络传输的特性，若未经授权可随意访问的话就会非常危险。有鉴于此，谷歌将数据传输过程中的信息保护摆在优先位置上，用户设备与谷歌间的数据传输通常都是利用HTTPS/TLS(安全传输层协议)来进行加密输送。谷歌是第一个默认启用HTTPS/TLS的主要云服务提供商。</p>', 1, NULL, 93, 0, 0, 0, 0, NULL, '', 0, 0, NULL, 1464081797, 1465286960, 0, 1),
(3, '机器学习专家带你实践LSTM语言模型', '', 'post', NULL, '', '<p>测试</p><p><br></p>', 1, '', 77, 0, 0, 0, 0, NULL, '', 0, 0, 0, 1464081899, 1506666713, 0, 1),
(4, '大撒发送大撒发送', '', 'page', NULL, '', '<p style="text-align:center"><br/></p><p>这是编辑的内容就gsadfasdfasfd</p><p></p>', 1, '', 1164, 0, 0, 0, 0, NULL, '', 0, 0, 0, 1464153628, 1506823903, 0, 0),
(5, '贝恩：企业大数据战略指南', '', 'post', NULL, '这是摘要dgs', '<p>企业大数据战略指南</p><p><br></p><p><img class="" src="http://localhost/ZhaoCMF/Uploads/Picture/2016-09-26/57e8ddc3e1455.jpeg" data-id="363"></p><p>fsafsaf</p><p><br></p>', 1, '关键字1', 88, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 1464791552, 1506824032, 0, 1),
(6, '发撒范德萨', '', 'post', NULL, '', '<p>撒发达范德萨发送</p>', 1, '', 27, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 1506666754, 0, 1),
(7, '关于我们', '', 'page', NULL, NULL, '<p>这是关于我们的内容，测试</p>', 1, '发达啊撒旦法撒发撒旦法按时', NULL, 0, 0, 0, 0, NULL, NULL, 0, 0, NULL, 1467857339, 1506824231, 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_rewrite`
--

CREATE TABLE `eacoo_rewrite` (
  `id` int(10) UNSIGNED NOT NULL COMMENT '主键id自增',
  `rule` varchar(255) NOT NULL DEFAULT '' COMMENT '规则',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT 'url',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '状态：0禁用，1启用'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='伪静态表';

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_terms`
--

CREATE TABLE `eacoo_terms` (
  `term_id` int(10) UNSIGNED NOT NULL COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '分类名称',
  `slug` varchar(100) DEFAULT '' COMMENT '分类别名',
  `taxonomy` varchar(32) DEFAULT '' COMMENT '分类类型',
  `pid` int(10) UNSIGNED DEFAULT '0' COMMENT '上级ID',
  `limit` tinyint(4) UNSIGNED DEFAULT '0' COMMENT '分页条数',
  `seo_title` varchar(128) DEFAULT '' COMMENT 'seo标题',
  `seo_keywords` varchar(255) DEFAULT '' COMMENT 'seo 关键词',
  `seo_description` varchar(255) DEFAULT '' COMMENT 'seo描述',
  `list_tpl` varchar(50) DEFAULT NULL COMMENT '分类列表模板',
  `one_tpl` varchar(50) DEFAULT NULL COMMENT '分类详情模板',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间',
  `sort` int(10) UNSIGNED DEFAULT '0' COMMENT '排序号',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态，1发布，0不发布'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='分类';

--
-- 转存表中的数据 `eacoo_terms`
--

INSERT INTO `eacoo_terms` (`term_id`, `name`, `slug`, `taxonomy`, `pid`, `limit`, `seo_title`, `seo_keywords`, `seo_description`, `list_tpl`, `one_tpl`, `create_time`, `update_time`, `sort`, `status`) VALUES
(1, '未分类', 'nocat', 'post_category', 0, 0, '未分类', '', '', NULL, NULL, 0, 1465271123, 0, -1),
(4, '大数据', 'dashuju', 'post_tag', 0, 12, '大数据', '', '这是标签描述', NULL, NULL, 0, 1466612845, 0, 1),
(5, '技术类', 'technology', 'post_category', 0, 0, '技术类', '', '', NULL, NULL, 1465570866, 1465570866, 0, 1),
(6, '大数据', 'dashuju', 'post_category', 0, 11, '大数据', '大数据', '这是描述内容', NULL, NULL, 1465576314, 1466607965, 0, 1),
(7, '运营', 'yunying', 'post_tag', 0, 12, '运营', '', '', NULL, NULL, 1466612937, 1466612937, 0, 1),
(8, '案例展示', 'cases', 'post_category', 0, 12, '案例展示', '', '', NULL, NULL, 1466613025, 1466613025, 0, 1),
(9, '人物', 'renwu', 'media_cat', 0, 13, '人物', '', '聚集多为人物显示的分类', NULL, NULL, 1466613381, 1466613381, 0, 1),
(10, '美食', 'meishi', 'media_cat', 0, 12, '美食', '', '', NULL, NULL, 1466613499, 1466613499, 0, 1),
(11, '图标素材', 'icons', 'media_cat', 0, 12, '图标素材', '', '', NULL, NULL, 1466613803, 1466613803, 0, 1),
(12, '风景', 'fengjin', 'media_cat', 0, 12, '风景', '风景', '', NULL, NULL, 1466614026, 1506557501, 0, 1),
(13, '其它', 'others', 'media_cat', 0, 12, '其它', '', '', NULL, NULL, 1467689719, 1467689719, 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_term_relationships`
--

CREATE TABLE `eacoo_term_relationships` (
  `id` bigint(20) NOT NULL,
  `object_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'posts表里文章id',
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '分类id',
  `table` varchar(60) NOT NULL COMMENT '数据表',
  `uid` int(11) UNSIGNED DEFAULT '0' COMMENT '分类与用户关系',
  `sort` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '排序',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1发布，0不发布'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='对象分类对应表';

--
-- 转存表中的数据 `eacoo_term_relationships`
--

INSERT INTO `eacoo_term_relationships` (`id`, `object_id`, `term_id`, `table`, `uid`, `sort`, `status`) VALUES
(1, 95, 9, 'attachment', 0, 0, 1),
(2, 94, 11, 'attachment', 0, 0, 1),
(3, 116, 12, 'attachment', 0, 0, 1),
(4, 92, 12, 'attachment', 0, 0, 1),
(5, 70, 12, 'attachment', 0, 0, 1),
(12, 3, 5, 'posts', 0, 0, 1),
(13, 5, 6, 'posts', 0, 0, 1),
(14, 2, 6, 'posts', 0, 0, 1),
(15, 1, 6, 'posts', 0, 0, 1),
(16, 4, 1, 'posts', 0, 0, 1),
(17, 6, 1, 'posts', 0, 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_themes`
--

CREATE TABLE `eacoo_themes` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '名称',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT '标题',
  `cover` varchar(80) DEFAULT NULL COMMENT '封面',
  `description` varchar(127) NOT NULL DEFAULT '' COMMENT '描述',
  `author` varchar(32) NOT NULL DEFAULT '' COMMENT '开发者',
  `version` varchar(8) NOT NULL DEFAULT '' COMMENT '版本',
  `config` text COMMENT '主题配置',
  `current` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否当前主题',
  `website` varchar(120) DEFAULT '' COMMENT '站点',
  `sort` tinyint(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='前台主题表';

--
-- 转存表中的数据 `eacoo_themes`
--

INSERT INTO `eacoo_themes` (`id`, `name`, `title`, `cover`, `description`, `author`, `version`, `config`, `current`, `website`, `sort`, `create_time`, `update_time`, `status`) VALUES
(1, 'default', '官方默认主题', '/themes/default/cover.jpeg', '内置于系统中，是其它主题的基础主题', '心云间、凝听', '1.0.0', '', 1, 'http://www.eacoo123.com', 0, 1475899420, 1506010201, 1);

-- --------------------------------------------------------

--
-- 表的结构 `eacoo_users`
--

CREATE TABLE `eacoo_users` (
  `uid` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '登录密码',
  `nickname` varchar(60) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '登录邮箱',
  `mobile` varchar(20) DEFAULT '' COMMENT '手机号',
  `avatar` varchar(150) DEFAULT '' COMMENT '用户头像，相对于Uploads/Avatar目录',
  `sex` smallint(1) UNSIGNED DEFAULT '0' COMMENT '性别；0：保密，1：男；2：女',
  `birthday` date DEFAULT '0000-00-00' COMMENT '生日',
  `description` varchar(200) DEFAULT '' COMMENT '个人描述',
  `register_ip` varchar(16) DEFAULT '' COMMENT '注册IP',
  `last_login_ip` varchar(16) DEFAULT '' COMMENT '最后登录ip',
  `last_login_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `activation_auth_sign` varchar(60) DEFAULT '' COMMENT '激活码',
  `url` varchar(100) DEFAULT '' COMMENT '用户个人网站',
  `integral` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户积分',
  `money` decimal(10,2) UNSIGNED NOT NULL DEFAULT '0.00' COMMENT '金额',
  `freeze_money` decimal(10,2) UNSIGNED NOT NULL DEFAULT '0.00' COMMENT '冻结金额，和金币相同换算',
  `pay_pwd` char(32) DEFAULT '' COMMENT '支付密码',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户类型；1个人，2店长，3平台管理员',
  `reg_from` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '注册来源。1PC端，2WAP端，3微信端，4APP端，5后台添加',
  `level` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '等级',
  `p_uid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '推荐人会员ID',
  `allow_admin` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '允许后台。0不允许，1允许',
  `role_id` smallint(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT '角色',
  `reg_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '注册时间',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常 ；2：待验证'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

--
-- 转存表中的数据 `eacoo_users`
--

INSERT INTO `eacoo_users` (`uid`, `username`, `password`, `nickname`, `email`, `mobile`, `avatar`, `sex`, `birthday`, `description`, `register_ip`, `last_login_ip`, `last_login_time`, `activation_auth_sign`, `url`, `integral`, `money`, `freeze_money`, `pay_pwd`, `type`, `reg_from`, `level`, `p_uid`, `allow_admin`, `role_id`, `reg_time`, `status`) VALUES
(2, 'U1472444313', '0a32eab5fe6068489679aab59c5f8ee1', '心灵旅行', '', NULL, 'http://wx.qlogo.cn/mmopen/mzvibibVqk5CPdWnUU5PBfzGTY6tnj4nXOlWJ3Irpnl8ecAwDZgyMhVR2U8Q12FPleJ8BpEsr1j0wE4c88r0aibZHuG8CBiau3Hd/0', 1, NULL, '这是个人简介', NULL, '1928388295', 1474208324, '44157fe4582f9e433c7add3a0d623c669900cea6', NULL, 0, '1.00', '0.00', '', 1, 0, 0, 0, 0, 0, 1472444313, 1),
(3, 'U1471610993', '1e61aecd6a4a5417f9c2692d57d34efa', '陈婧', '', NULL, 'http://wx.qlogo.cn/mmopen/fWJhv9xMFTvh8TOSlQkjjkuaj4sIhBpHDRO9romGQ3TFTv3LA6wNqq0fCR7AtT7KCLIctaKq7hd2wkbBveCkia57p7D6lqMTe/0', 2, NULL, NULL, NULL, '2937347650', 1473755335, 'a525c9259ff2e51af1b6e629dd47766f99f26c69', NULL, 0, '2.00', '0.00', '', 1, 0, 0, 0, 0, 0, 1471610993, 1),
(4, 'U1472438063', '89dd53a2da06a47fc40394b359a5a80b', '妍冰', '', NULL, 'http://wx.qlogo.cn/mmopen/eCXtiatJG2qA7d9wjNKktQUMjaiajx4SCoL5Phc5NqRKg4bltVHI94hpZl7x1R2E14Xbb5x7wDJkiaMrYgJx0Nb8nGuvicWcEymc/0', 2, NULL, '承接大型商业演出和传统文化学习班', NULL, '2073504306', 1472438634, 'ed587cf103c3f100be20f7b8fdc7b5a8e2fda264', NULL, 0, '0.00', '0.00', '', 1, 0, 0, 0, 0, 0, 1472438063, 1),
(5, 'U1472522409', 'a5eee991430384bd76398c0f0e3852ab', '久柳', '', NULL, 'http://wx.qlogo.cn/mmopen/RLZcTUr4lyhBYRz8vKMAVicmHdShyTG9DA1jEg9PMkBKy8M2KwAX9mOHD3TudcoL8Ph8gXwSlaBRW6MpsqKibd8Y8oXETIsUsic/0', 1, NULL, NULL, NULL, '1872836895', 1472522621, '5e542dc0c77b3749f2270cb3ec1d91acc895edc8', NULL, 0, '0.00', '0.00', '', 1, 0, 0, 0, 0, 0, 1472522409, 1),
(6, 'U1472739566', 'fe1552121baa4d206b7c84e144cbfded', 'Ray', '', NULL, 'http://wx.qlogo.cn/mmopen/l4fl4iboCt9RZUw8sVElUyz3dQchzKcpiaTZicLIH2YhkA3Qypvhc2ZyjLzxzUIYsf9NtFpicibeJfGF8AQZSiaBq8zju3Mias6YZsC/0', 1, NULL, NULL, NULL, '1394764909', 1472739567, '6321b4d8ecb1ce1049eab2be70c44335856c840d', NULL, 0, '0.00', '0.00', '', 1, 0, 0, 0, 0, 0, 1472739567, 1),
(7, 'U1471602501', '043fbac9765d914e705f473c36eabbda', '风尚', '', '', '/static/assets/img/default-avatar.svg', 1, NULL, '一个好人', NULL, '2073532707', 1474906424, '28d203804358325d41bef03f16c194994bef561c', NULL, 0, '0.00', '0.00', '', 1, 0, 0, 0, 0, 0, 1471602501, 1),
(8, 'U1472877421', '65b5fea1e22ae9a8863b18d45f8a2e9b', '印文博律师', '', NULL, 'http://wx.qlogo.cn/mmopen/ajNVdqHZLLA7FINjLK0kxvyX9BhicrMF31ldiaiagMZhv8crokiavvNuLC1od9K8lGluATGZhFdA1eCeIllqXGO1Sw/0', 1, NULL, NULL, NULL, '2073529233', 1473494692, 'e99521af40a282e84718f759ab6b1b4a989d8eb1', NULL, 0, '0.00', '0.00', '', 1, 0, 0, 0, 0, 0, 1472877421, 1),
(9, 'U1472966655', '3356a455c1f1503f70f7649fc0869fdd', '嘉伟', '', NULL, 'http://wx.qlogo.cn/mmopen/nyPpZGsicVpC68EYXh6m41AicibcMIZa5VA04sIt8LWBFbS7sn9tGibkKPQ3ibPOAic3urGomGn4rvc4ITdia9ssZ0uibzk27L6zoh9P/0', 1, NULL, NULL, NULL, '720909644', 1473397571, 'f1075223be5f53b9c2c1abea8288258545365d96', NULL, 0, '0.00', '0.00', '', 1, 0, 0, 0, 0, 0, 1472966655, 1),
(10, 'U1473304718', '0f07f4e63ad283dde05c09f57a49a203', '鬼谷学猛虎流', '', NULL, 'http://wx.qlogo.cn/mmopen/PiajxSqBRaELGyaDWOrqGfF7JibvU3hbuA7yYHJne8fw68wFQHjZTibcMxoR4keH7DSia4QuREIskmpe3mdxiaGwfJw/0', 1, NULL, NULL, NULL, '2946996753', 1473399843, '039fc7a3f9366adf55ee9e707c371a2459c17bd7', NULL, 0, '0.00', '0.00', '', 1, 0, 0, 0, 0, 0, 1473304719, 1),
(11, 'U1473391063', '3ba08148e4fde24dbc69dcaf83e31e56', '@Gyb.', '', NULL, 'http://wx.qlogo.cn/mmopen/OHrKu638Lt0WowUCElh711VTFOXGviatZ61VLCsGkfKCeETPIgGGjibn26v0Zd9ztIHkMYGC08hKYAic5zuEGyGW9eCicMNqpzPw/0', 1, NULL, NULL, NULL, '2003622040', 1473391063, '70d80a9f7599c81270a986abaea73e63101b3ecb', NULL, 0, '0.00', '0.00', '', 1, 0, 0, 0, 0, 0, 1473391063, 1),
(12, 'U1473396778', '4028d6d5a4cf4c3e75fc12f7d1749456', '董超楠', '', NULL, 'http://wx.qlogo.cn/mmopen/LIQXXYlOuN2jy45Uy8FrA1XpHMaUGvtGYrC9XIcgI2MKvzlPsb4uISBUpLxOXZ6nlqXpCvMoEicDM4HSltm9O4nGyvU11Lzib1/0', 2, NULL, NULL, NULL, '1911132108', 1473396778, '8bbf5242300e5e8e4917b287a31efcb0c9feedfd', NULL, 0, '0.00', '0.00', '', 1, 0, 0, 0, 0, 0, 1473396778, 1),
(13, 'U1473396819', '17ab2bff43b57cf46776728344f52969', '七里林', '', NULL, 'http://wx.qlogo.cn/mmopen/RlLibmYfibwCs6EPOR9ZRxyckic1kLZMqAibdQgC5RXIuaoIAQAYL1IWfxcuzBfqwuicxr246CszaXmmZViaDprDibR4mlMBib6lz30j/0', 2, NULL, NULL, NULL, '2073504303', 1474331920, '33eaf519d0d42de5a67112e2728880db7a293c8b', NULL, 0, '0.00', '0.00', '', 1, 0, 0, 0, 0, 0, 1506490927, 1),
(14, 'U1473396839', '3928540f538d3da96aee311b9a7dc4b3', '求真实者', '', NULL, 'http://wx.qlogo.cn/mmopen/9UjCmequjUib5ywquUZY1ibYhLogodtGeVc7E7jTG9XyrLn4BwPB7MicQ58KIOkJrxbTqk5snhXOlTYoglSm1HIXcGzAAo251so/0', 0, NULL, NULL, NULL, '2004314620', 1473396839, '8f7579a85981e1c1f726704b0865320dfadbef2e', NULL, 0, '0.00', '0.00', '', 1, 0, 0, 0, 0, 0, 1506503387, 1),
(15, 'U1473397391', '5b14c283863c7a9854421f3d650ca628', 'peter', '', NULL, 'http://wx.qlogo.cn/mmopen/PwJLJ0FGzVTsG2K1CtNGibzTSGD1788aslVUUSPBDq5Jpv8JxCzmCSbdRgW3wUJYCJTU8kgshcNn7g8Ox6LmscmM8YuicrgwNf/0', 1, NULL, NULL, NULL, '1701480067', 1473397391, 'c66d3a0e16a81a13173756a2832ba424b34a095c', NULL, 0, '0.00', '0.00', '', 1, 0, 0, 0, 0, 0, 1506491950, 1),
(16, 'U1473397426', '2ffb46af26a16e32a6187aaa10a85656', '随风而去的心情', '', NULL, 'http://wx.qlogo.cn/mmopen/9UjCmequjUib5ywquUZY1ibbK663y8qiaGXlcxQ4Hgjem9Hp2tVsnMbwErjuMuerBQMnrrK8NlmmeiaHT58ic9rG4SXI0l05IYQq1/0', 1, NULL, NULL, NULL, '2073532567', 1473397426, '14855b00775de46b451c8255e6a73a5c044fc188', NULL, 0, '0.00', '0.00', '', 1, 0, 0, 0, 0, 0, 1506527057, 1),
(17, 'U1474181145', '965c4aab5c6c73930930ef1cfc6f8802', '班鱼先生', '', NULL, 'http://wx.qlogo.cn/mmopen/PiajxSqBRaELgx8NFX4Nz0FtAPkwlouDOErFLmsbvXeJlwzYeMJDoSw5X59FuE86uRh49777cYCVyw2KNQWc6Bw/0', 1, NULL, NULL, NULL, '2938851779', 1474181146, '86d19a7b1f15db4fd25e0b64bfc17870a70f67e2', NULL, 0, '0.00', '0.00', '', 1, 0, 0, 0, 0, 0, 1506526964, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `eacoo_action`
--
ALTER TABLE `eacoo_action`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `eacoo_action_log`
--
ALTER TABLE `eacoo_action_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `eacoo_attachment`
--
ALTER TABLE `eacoo_attachment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_paty_type` (`path_type`);

--
-- Indexes for table `eacoo_auth_group`
--
ALTER TABLE `eacoo_auth_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `eacoo_auth_group_access`
--
ALTER TABLE `eacoo_auth_group_access`
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `eacoo_auth_rule`
--
ALTER TABLE `eacoo_auth_rule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `eacoo_comments`
--
ALTER TABLE `eacoo_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_from_object_id` (`from`,`object_id`);

--
-- Indexes for table `eacoo_comment_zan`
--
ALTER TABLE `eacoo_comment_zan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_comment_id` (`comment_id`),
  ADD KEY `idx_uid` (`uid`);

--
-- Indexes for table `eacoo_config`
--
ALTER TABLE `eacoo_config`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_name` (`name`);

--
-- Indexes for table `eacoo_hooks`
--
ALTER TABLE `eacoo_hooks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `eacoo_links`
--
ALTER TABLE `eacoo_links`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `eacoo_messages`
--
ALTER TABLE `eacoo_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `eacoo_modules`
--
ALTER TABLE `eacoo_modules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `eacoo_nav`
--
ALTER TABLE `eacoo_nav`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `eacoo_plugins`
--
ALTER TABLE `eacoo_plugins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `eacoo_plugin_social_login`
--
ALTER TABLE `eacoo_plugin_social_login`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `eacoo_postmeta`
--
ALTER TABLE `eacoo_postmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- Indexes for table `eacoo_posts`
--
ALTER TABLE `eacoo_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_type` (`type`),
  ADD KEY `idx_recommended` (`recommended`);

--
-- Indexes for table `eacoo_rewrite`
--
ALTER TABLE `eacoo_rewrite`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `eacoo_terms`
--
ALTER TABLE `eacoo_terms`
  ADD PRIMARY KEY (`term_id`),
  ADD KEY `taxonomy` (`taxonomy`);

--
-- Indexes for table `eacoo_term_relationships`
--
ALTER TABLE `eacoo_term_relationships`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_term_id` (`term_id`),
  ADD KEY `idx_object_id` (`object_id`);

--
-- Indexes for table `eacoo_themes`
--
ALTER TABLE `eacoo_themes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `eacoo_users`
--
ALTER TABLE `eacoo_users`
  ADD PRIMARY KEY (`uid`),
  ADD KEY `idx_username` (`username`),
  ADD KEY `idx_email` (`email`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `eacoo_action`
--
ALTER TABLE `eacoo_action`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=18;
--
-- 使用表AUTO_INCREMENT `eacoo_action_log`
--
ALTER TABLE `eacoo_action_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=12;
--
-- 使用表AUTO_INCREMENT `eacoo_attachment`
--
ALTER TABLE `eacoo_attachment`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=97;
--
-- 使用表AUTO_INCREMENT `eacoo_auth_group`
--
ALTER TABLE `eacoo_auth_group`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- 使用表AUTO_INCREMENT `eacoo_auth_rule`
--
ALTER TABLE `eacoo_auth_rule`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;
--
-- 使用表AUTO_INCREMENT `eacoo_comments`
--
ALTER TABLE `eacoo_comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `eacoo_comment_zan`
--
ALTER TABLE `eacoo_comment_zan`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- 使用表AUTO_INCREMENT `eacoo_config`
--
ALTER TABLE `eacoo_config`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '配置ID', AUTO_INCREMENT=60;
--
-- 使用表AUTO_INCREMENT `eacoo_hooks`
--
ALTER TABLE `eacoo_hooks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '钩子ID', AUTO_INCREMENT=15;
--
-- 使用表AUTO_INCREMENT `eacoo_links`
--
ALTER TABLE `eacoo_links`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=15;
--
-- 使用表AUTO_INCREMENT `eacoo_messages`
--
ALTER TABLE `eacoo_messages`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '消息ID', AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `eacoo_modules`
--
ALTER TABLE `eacoo_modules`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=6;
--
-- 使用表AUTO_INCREMENT `eacoo_nav`
--
ALTER TABLE `eacoo_nav`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `eacoo_plugins`
--
ALTER TABLE `eacoo_plugins`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=4;
--
-- 使用表AUTO_INCREMENT `eacoo_plugin_social_login`
--
ALTER TABLE `eacoo_plugin_social_login`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID';
--
-- 使用表AUTO_INCREMENT `eacoo_postmeta`
--
ALTER TABLE `eacoo_postmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `eacoo_posts`
--
ALTER TABLE `eacoo_posts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=8;
--
-- 使用表AUTO_INCREMENT `eacoo_rewrite`
--
ALTER TABLE `eacoo_rewrite`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id自增';
--
-- 使用表AUTO_INCREMENT `eacoo_terms`
--
ALTER TABLE `eacoo_terms`
  MODIFY `term_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=14;
--
-- 使用表AUTO_INCREMENT `eacoo_term_relationships`
--
ALTER TABLE `eacoo_term_relationships`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- 使用表AUTO_INCREMENT `eacoo_themes`
--
ALTER TABLE `eacoo_themes`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `eacoo_users`
--
ALTER TABLE `eacoo_users`
  MODIFY `uid` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
