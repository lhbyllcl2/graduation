/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 50553
 Source Host           : localhost:3306
 Source Schema         : graduation

 Target Server Type    : MySQL
 Target Server Version : 50553
 File Encoding         : 65001

 Date: 20/05/2019 09:07:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for vae_admin
-- ----------------------------
DROP TABLE IF EXISTS `vae_admin`;
CREATE TABLE `vae_admin`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `salt` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1正常-1禁止登陆',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  `last_login_time` int(11) NOT NULL DEFAULT 0,
  `login_num` int(11) NOT NULL DEFAULT 0,
  `last_login_ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `phone` bigint(11) NULL DEFAULT 0,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  `thumb` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`id`, `username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vae_admin
-- ----------------------------
INSERT INTO `vae_admin` VALUES (1, 'admin', '3dc877f39b5496dc9870490662a015a2', 'PVFxItXQcDjhkURN02sA', 1, 1554791776, 1554791776, 1557890593, 13, '127.0.0.1', 0, 'Admin', NULL, '/themes/admin_themes/lib/vaeyo/img/thumb.png');

-- ----------------------------
-- Table structure for vae_admin_group
-- ----------------------------
DROP TABLE IF EXISTS `vae_admin_group`;
CREATE TABLE `vae_admin_group`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT 1,
  `rules` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户组拥有的规则id， 多个规则\",\"隔开',
  `menus` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限分组' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vae_admin_group
-- ----------------------------
INSERT INTO `vae_admin_group` VALUES (1, '系统所有者', 1, '1,2,57,58,59,60,3,19,20,21,22,23,24,25,26,27,28,29,30,31,32,7,8,9,10,11,12,13,14,15,16,17,18,50,51,52,53,54,55,56,4,5,39,40,41,42,43,44,45,46,47,48,49,33,34,35,36,37,38,69,70,71,72,73,74,75,76,77,78,79,80,81,82,6,61,62,63,64,65,66,67,68,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99', '1,2,3,4,5,6,14,15,16,17,7,10,11,12,13,24,22,23,18,19,20,21,24,25,26,27,28,29,30,31,32,33', '系统所有者，系统自动分配所有可操作权限及菜单。', 0, 1557728331);

-- ----------------------------
-- Table structure for vae_admin_group_access
-- ----------------------------
DROP TABLE IF EXISTS `vae_admin_group_access`;
CREATE TABLE `vae_admin_group_access`  (
  `uid` mediumint(11) UNSIGNED NULL DEFAULT NULL,
  `group_id` mediumint(11) NULL DEFAULT NULL,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  UNIQUE INDEX `uid_group_id`(`uid`, `group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限分组和管理员的关联表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vae_admin_group_access
-- ----------------------------
INSERT INTO `vae_admin_group_access` VALUES (1, 1, 0, 0);

-- ----------------------------
-- Table structure for vae_admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `vae_admin_menu`;
CREATE TABLE `vae_admin_menu`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT 0,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `src` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `param` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `order` int(11) NOT NULL DEFAULT 1 COMMENT '越大越靠前',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台菜单' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vae_admin_menu
-- ----------------------------
INSERT INTO `vae_admin_menu` VALUES (1, 0, '系统', NULL, NULL, 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (2, 1, '菜单', 'admin/menu/index', NULL, 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (3, 1, '管理', NULL, NULL, 2, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (4, 3, '管理员', 'admin/admin/index', NULL, 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (5, 3, '管理组', 'admin/group/index', NULL, 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (6, 1, '节点', 'admin/rule/index', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (7, 0, 'app相关', '', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (10, 7, '分类', 'admin/cate/index', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (11, 7, '内容', '', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (12, 11, '文章', 'admin/article/index', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (13, 11, '回收站', 'admin/recycle/index', '', 2, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (14, 1, '路由', 'admin/route/index', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (15, 1, '配置', '', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (16, 15, '网站信息', 'admin/conf/webConf', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (17, 15, '邮箱配置', 'admin/conf/emailConf', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (18, 0, '插件', '', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (19, 18, '内置钩子', 'admin/hook/index', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (20, 18, '插件管理', 'admin/plugin/index', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (22, 7, '轮播', 'admin/slide/index', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (24, 15, '短信配置', 'admin/conf/dayuConf', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (25, 0, '菜品管理', '', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (26, 25, '分类管理', 'admin/CookbookItem/index', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (27, 25, '菜谱管理', 'admin/Cookbook/index', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (28, 0, '订单管理', 'admin/order/default', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (29, 28, '订单列表', 'admin/order/index', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (30, 0, '用户管理', 'admin/member/default', '', 1, 0, 0);
INSERT INTO `vae_admin_menu` VALUES (31, 30, '用户列表', 'admin/member/index', '', 1, 0, 0);

-- ----------------------------
-- Table structure for vae_admin_rule
-- ----------------------------
DROP TABLE IF EXISTS `vae_admin_rule`;
CREATE TABLE `vae_admin_rule`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `type` int(1) NOT NULL DEFAULT 1,
  `condition` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附加规则',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL COMMENT '0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限节点' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vae_admin_rule
-- ----------------------------
INSERT INTO `vae_admin_rule` VALUES (1, 0, '', '系统', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (2, 1, '', '配置', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (3, 1, '', '管理', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (4, 0, '', '门户', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (5, 4, '', '内容', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (6, 0, '', '插件', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (7, 1, 'menu/index', '菜单', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (8, 7, 'menu/getMenuList', '菜单列表', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (9, 7, 'menu/add', '添加菜单', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (10, 9, 'menu/addSubmit', '保存添加的菜单', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (11, 7, 'menu/editSubmit', '保存菜单修改', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (12, 7, 'menu/delete', '删除菜单', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (13, 1, 'rule/index', '节点', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (14, 13, 'rule/getRuleList', '节点列表', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (15, 13, 'rule/add', '添加节点', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (16, 15, 'rule/addSubmit', '保存添加的节点', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (17, 13, 'rule/editSubmit', '保存节点修改', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (18, 13, 'rule/delete', '节点删除', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (19, 3, 'admin/index', '管理员', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (20, 19, 'admin/getAdminList', '管理员列表', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (21, 19, 'admin/add', '添加管理员', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (22, 21, 'admin/addSubmit', '保存添加的管理员', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (23, 19, 'admin/edit', '修改管理员', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (24, 23, 'admin/editSubmit', '保存管理员的修改', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (25, 19, 'admin/delete', '管理员删除', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (26, 3, 'group/index', '管理组', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (27, 26, 'group/getGroupList', '管理组列表', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (28, 26, 'group/add', '添加管理组', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (29, 28, 'group/addSubmit', '保存添加的管理组', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (30, 26, 'group/edit', '管理组修改', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (31, 30, 'group/editSubmit', '保存管理组的修改', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (32, 26, 'group/delete', '管理组删除', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (33, 4, 'cate/index', '分类', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (34, 33, 'cate/getCateList', '分类列表', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (35, 33, 'cate/add', '添加分类', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (36, 35, 'cate/addSubmit', '保存添加的分类', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (37, 33, 'cate/editSubmit', '保存修改的分类', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (38, 33, 'cate/delete', '删除分类', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (39, 5, 'article/index', '文章', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (40, 39, 'article/getContentList', '文章列表', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (41, 39, 'article/add', '添加文章', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (42, 41, 'article/addSubmit', '保存添加的文章', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (43, 39, 'article/edit', '编辑文章', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (44, 43, 'article/editSubmit', '保存编辑的文章', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (45, 39, 'article/delete', '删除文章', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (46, 5, 'recycle/index', '回收站', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (47, 46, 'recycle/getRecycleList', '回收列表', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (48, 46, 'recycle/reduction', '还原', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (49, 46, 'recycle/delete', '彻底删除', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (50, 1, 'route/index', '路由', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (51, 50, 'route/getRouteList', '路由列表', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (52, 50, 'route/add', '添加路由', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (53, 52, 'route/addSubmit', '保存添加的路由', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (54, 50, 'route/edit', '修改路由', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (55, 54, 'route/editSubmit', '保存修改的路由', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (56, 50, 'route/delete', '删除路由', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (57, 2, 'conf/webConf', '网站信息', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (58, 57, 'conf/webConfSubmit', '保存网站信息', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (59, 2, 'conf/emailConf', '邮箱配置', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (60, 59, 'conf/emailConfSubmit', '保存邮箱配置', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (61, 6, 'hook/index', '钩子管理', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (62, 61, 'hook/getHookList', '钩子列表', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (63, 6, 'plugin/index', '插件管理', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (64, 63, 'plugin/getPluginList', '插件列表', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (65, 63, 'plugin/start', '启用插件', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (66, 63, 'plugin/disabled', '禁用插件', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (67, 63, 'plugin/uninstall', '卸载插件', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (68, 63, 'plugin/install', '安装插件', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (69, 4, 'slide/index', '轮播组', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (70, 69, 'slide/add', '添加轮播组', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (71, 70, 'slide/addSubmit', '保存添加的轮播组', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (72, 69, 'slide/edit', '修改轮播组', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (73, 72, 'slide/editSubmit', '保存修改的轮播组', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (74, 69, 'slide/delete', '删除轮播组', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (75, 69, 'slide/getSlideList', '轮播组列表', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (76, 4, 'slide/slideInfo', '轮播', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (77, 76, 'slide/getSlideInfoList', '轮播列表', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (78, 76, 'slide/addSlideInfo', '添加轮播', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (79, 78, 'slide/addSlideInfoSubmit', '保存添加的轮播', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (80, 76, 'slide/editSlideInfo', '编辑轮播', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (81, 80, 'slide/editSlideInfoSubmit', '保存编辑的轮播', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (82, 76, 'slide/deleteSlideInfo', '删除轮播', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (83, 4, '', '导航', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (84, 83, 'nav/index', '导航组', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (85, 84, 'nav/getNavList', '导航组列表', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (86, 84, 'nav/add', '添加导航组', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (87, 86, 'nav/addSubmit', '保存添加的导航组', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (88, 84, 'nav/edit', '修改导航组', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (89, 88, 'nav/editSubmit', '保存修改的导航组', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (90, 84, 'nav/delete', '删除导航组', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (91, 83, 'nav/navInfo', '管理导航', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (92, 91, 'nav/getNavInfoList', '导航列表', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (93, 91, 'nav/addNavInfo', '添加导航', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (94, 93, 'nav/addNavInfoSubmit', '保存添加的导航', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (95, 91, 'nav/editNavInfoSubmit', '保存修改的导航', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (96, 91, 'nav/deleteNavInfo', '删除导航', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (97, 63, 'plugin/setConfig', '配置插件', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (98, 2, 'conf/dayuConf', '短信配置', 1, '', 0, 0);
INSERT INTO `vae_admin_rule` VALUES (99, 98, 'conf/dayuConfSubmit', '保存短信配置', 1, '', 0, 0);

-- ----------------------------
-- Table structure for vae_article
-- ----------------------------
DROP TABLE IF EXISTS `vae_article`;
CREATE TABLE `vae_article`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `keywords` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `desc` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1正常-1下架',
  `thumb` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `read` int(11) NOT NULL DEFAULT 0 COMMENT '阅读量',
  `article_cate_id` int(11) NOT NULL DEFAULT 0,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '内容' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vae_article_cate
-- ----------------------------
DROP TABLE IF EXISTS `vae_article_cate`;
CREATE TABLE `vae_article_cate`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT 0,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `keywords` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `desc` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`, `pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '内容分类' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vae_article_cate
-- ----------------------------
INSERT INTO `vae_article_cate` VALUES (1, 0, '测试分类', '', '', 0, 0);

-- ----------------------------
-- Table structure for vae_cookbook
-- ----------------------------
DROP TABLE IF EXISTS `vae_cookbook`;
CREATE TABLE `vae_cookbook`  (
  `cookbook_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cookbook_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜谱名称',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜谱的描述',
  `thumb` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜谱的主图',
  `item_id` smallint(5) UNSIGNED NOT NULL COMMENT '分类id',
  `price` decimal(8, 2) NOT NULL COMMENT '价格',
  `sales_volume` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '销量',
  `sales_promotion` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '促销信息',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否上架 0-未上架  1-上架',
  `is_delete` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除 0-未删除 1-已删除',
  PRIMARY KEY (`cookbook_id`) USING BTREE,
  INDEX `idx_vae_cookbook`(`item_id`) USING BTREE,
  CONSTRAINT `fk_vae_cookbook` FOREIGN KEY (`item_id`) REFERENCES `vae_cookbook_item` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜系表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vae_cookbook
-- ----------------------------
INSERT INTO `vae_cookbook` VALUES (4, '红烧肉', '好吃的很', 'http://lhy01.oss-cn-beijing.aliyuncs.com/dd4ced770528d5e5feffafcbffe3d5037ea844ba.jpeg', 1, 24.00, 0, '', '2019-04-20 15:10:00', '0000-00-00 00:00:00', 1, 0);
INSERT INTO `vae_cookbook` VALUES (5, '水煮鱼', '', 'http://lhy01.oss-cn-beijing.aliyuncs.com/a1dc658ab957d2743fb0152caf1297dfa540ea81.jpeg', 2, 32.50, 0, '', '2019-04-24 17:38:25', '0000-00-00 00:00:00', 1, 0);
INSERT INTO `vae_cookbook` VALUES (6, '清炒青菜', '', 'http://lhy01.oss-cn-beijing.aliyuncs.com/d8442c121a97f435ef7778265779efe27675a185.jpeg', 1, 2.56, 0, '买一送一', '2019-04-24 17:44:37', '0000-00-00 00:00:00', 1, 0);
INSERT INTO `vae_cookbook` VALUES (7, '蒜苗回锅肉', '蒜苗很新鲜', 'http://lhy01.oss-cn-beijing.aliyuncs.com/cedd760e4480d17c29f4b45d2580e6c73e2a8a65.jpeg', 2, 36.26, 0, '', '2019-04-24 17:46:22', '0000-00-00 00:00:00', 1, 0);
INSERT INTO `vae_cookbook` VALUES (8, '清蒸熊猫', '', 'http://lhy01.oss-cn-beijing.aliyuncs.com/1398a92a793016f5aae2dab5c16647c998072c11.jpeg', 1, 10000.00, 0, '', '2019-03-22 17:48:35', '0000-00-00 00:00:00', 1, 0);
INSERT INTO `vae_cookbook` VALUES (9, '牛肉面', '', 'http://lhy01.oss-cn-beijing.aliyuncs.com/26cebc52f6f84163daf4e0a0ecdd4c8af78f8511.jpeg', 3, 15.00, 0, '满30减2', '2019-05-09 10:21:44', '0000-00-00 00:00:00', 1, 0);
INSERT INTO `vae_cookbook` VALUES (10, '红烧茄子', '', 'http://lhy01.oss-cn-beijing.aliyuncs.com/ead3b6d219c108f40a638f8efbffc5c25938861c.jpeg', 1, 8.00, 0, '', '2019-05-09 10:27:07', '0000-00-00 00:00:00', 1, 0);
INSERT INTO `vae_cookbook` VALUES (11, '剁椒鱼头（辣）', '', 'http://lhy01.oss-cn-beijing.aliyuncs.com/d27a800ed56623c6c580da6cdfa90cfead541ab1.png', 4, 50.00, 0, '', '2019-05-14 15:34:02', '0000-00-00 00:00:00', 1, 0);

-- ----------------------------
-- Table structure for vae_cookbook_item
-- ----------------------------
DROP TABLE IF EXISTS `vae_cookbook_item`;
CREATE TABLE `vae_cookbook_item`  (
  `item_id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` smallint(6) UNSIGNED NULL DEFAULT 0 COMMENT '父级id',
  `item_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`item_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜系分类表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vae_cookbook_item
-- ----------------------------
INSERT INTO `vae_cookbook_item` VALUES (1, 0, '火爆小炒', '卖的很火', 0);
INSERT INTO `vae_cookbook_item` VALUES (2, 0, '麻辣川菜', '味道独特', 0);
INSERT INTO `vae_cookbook_item` VALUES (3, 0, '面条', '', 1);
INSERT INTO `vae_cookbook_item` VALUES (4, 0, '湘菜馆', '', 0);

-- ----------------------------
-- Table structure for vae_hook
-- ----------------------------
DROP TABLE IF EXISTS `vae_hook`;
CREATE TABLE `vae_hook`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '钩子类型1:系统钩子,2:应用钩子,3:模板钩子',
  `only` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否只允许一个插件运行0:多个,1:一个',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '钩子名称',
  `hook` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '钩子',
  `module` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '模块名，模块专属钩子',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '钩子表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vae_hook
-- ----------------------------
INSERT INTO `vae_hook` VALUES (1, 1, 0, '应用初始化', 'app_init', 'vae', '应用初始化');
INSERT INTO `vae_hook` VALUES (2, 1, 0, '应用开始', 'app_begin', 'vae', '应用开始');
INSERT INTO `vae_hook` VALUES (3, 1, 0, '模块初始化', 'module_init', 'vae', '模块初始化');
INSERT INTO `vae_hook` VALUES (4, 1, 0, '控制器开始', 'action_begin', 'vae', '控制器开始');
INSERT INTO `vae_hook` VALUES (5, 1, 0, '视图输出过滤', 'view_filter', 'vae', '视图输出过滤');
INSERT INTO `vae_hook` VALUES (6, 1, 0, '应用结束', 'app_end', 'vae', '应用结束');
INSERT INTO `vae_hook` VALUES (7, 1, 0, '日志write方法', 'log_write', 'vae', '日志write方法');
INSERT INTO `vae_hook` VALUES (8, 1, 0, '输出结束', 'response_end', 'vae', '输出结束');
INSERT INTO `vae_hook` VALUES (9, 1, 0, '后台控制器初始化', 'admin_init', 'vae', '后台控制器初始化');
INSERT INTO `vae_hook` VALUES (10, 1, 0, 'API控制器初始化', 'api_init', 'vae', 'API控制器初始化');
INSERT INTO `vae_hook` VALUES (11, 2, 1, '后台首页', 'admin_main', 'admin', '后台首页');
INSERT INTO `vae_hook` VALUES (12, 2, 1, '后台登录页面', 'admin_login', 'admin', '后台登录页面初始化');
INSERT INTO `vae_hook` VALUES (13, 1, 0, '文件上传前', 'upload_begin', 'vae', '文件上传完成前');
INSERT INTO `vae_hook` VALUES (14, 1, 0, '文件上传后', 'upload_end', 'vae', '文件上传完成后');
INSERT INTO `vae_hook` VALUES (15, 2, 0, 'port模块数据输出前', 'port_return', 'port', 'port模块数据输出前');
INSERT INTO `vae_hook` VALUES (16, 2, 0, 'port模块接收参数前', 'port_param', 'vae', 'port模块接收参数前');
INSERT INTO `vae_hook` VALUES (17, 2, 0, 'port模块开始前', 'port_begin', 'port', 'port模块开始前');

-- ----------------------------
-- Table structure for vae_hook_plugin
-- ----------------------------
DROP TABLE IF EXISTS `vae_hook_plugin`;
CREATE TABLE `vae_hook_plugin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '状态-1禁用,1启用',
  `hook` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '钩子名',
  `plugin` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '插件名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '钩子关联插件表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vae_member
-- ----------------------------
DROP TABLE IF EXISTS `vae_member`;
CREATE TABLE `vae_member`  (
  `member_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nickname` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '昵称',
  `login_name` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录名，只允许手机号',
  `password` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `birthday` date NULL DEFAULT '1990-10-01' COMMENT '生日,用于活动等',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态 0-禁用 1-正常',
  `last_login_time` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `is_delete` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否删除 0-未删除 1-删除',
  `last_login_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`member_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vae_member
-- ----------------------------
INSERT INTO `vae_member` VALUES (1, '', '18780125571', '', '1990-10-01', 1, '2019-05-17 13:51:39', 0, '10.3.41.166', '2019-04-28 17:39:03');

-- ----------------------------
-- Table structure for vae_member_address
-- ----------------------------
DROP TABLE IF EXISTS `vae_member_address`;
CREATE TABLE `vae_member_address`  (
  `address_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `member_id` int(11) UNSIGNED NOT NULL COMMENT '用户id',
  `address_detail` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '详细地址',
  `is_default` tinyint(1) NULL DEFAULT NULL COMMENT '是否为默认地址',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `phone` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话',
  `phone_bk` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备用电话',
  `sex` tinyint(1) UNSIGNED NOT NULL COMMENT '1-男 2女',
  `tag` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标签',
  `is_delete` tinyint(1) NOT NULL COMMENT '是否删除',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `geohash` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '经纬度',
  PRIMARY KEY (`address_id`) USING BTREE,
  INDEX `idx_vae_member_address`(`member_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户地址表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vae_member_address
-- ----------------------------
INSERT INTO `vae_member_address` VALUES (6, 1, '电子科技大学沙河校区20号', 1, '张三', '18780125571', '', 1, '学校', 0, '2019-05-17 13:56:08', '104.100227,30.675702');

-- ----------------------------
-- Table structure for vae_nav
-- ----------------------------
DROP TABLE IF EXISTS `vae_nav`;
CREATE TABLE `vae_nav`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标识',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1可用-1禁用',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '导航' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vae_nav_info
-- ----------------------------
DROP TABLE IF EXISTS `vae_nav_info`;
CREATE TABLE `vae_nav_info`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT 0,
  `nav_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `title` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `src` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `param` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1可用-1禁用',
  `order` int(11) NOT NULL DEFAULT 0,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '导航详情' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vae_order
-- ----------------------------
DROP TABLE IF EXISTS `vae_order`;
CREATE TABLE `vae_order`  (
  `order_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_sn` bigint(14) NOT NULL COMMENT '订单号',
  `member_id` int(11) UNSIGNED NOT NULL COMMENT '用户id',
  `total_prices` decimal(10, 2) NOT NULL COMMENT '总价',
  `address_id` int(11) NOT NULL COMMENT '地址id',
  `leave_words` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '留言',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '订单状态 0-待付款 1-已付款 2-已送到 3-待评价 -1已取消 -2系统自动取消',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '订单的支付时间',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`order_id`) USING BTREE,
  UNIQUE INDEX `order_sn`(`order_sn`) USING BTREE,
  INDEX `idx_vae_order`(`member_id`) USING BTREE,
  CONSTRAINT `fk_vae_order` FOREIGN KEY (`member_id`) REFERENCES `vae_member` (`member_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vae_order
-- ----------------------------
INSERT INTO `vae_order` VALUES (22, 2019051710254975, 1, 28.00, 6, '', 1, '2019-05-17 13:56:19', '2019-05-17 13:56:15');

-- ----------------------------
-- Table structure for vae_order_book
-- ----------------------------
DROP TABLE IF EXISTS `vae_order_book`;
CREATE TABLE `vae_order_book`  (
  `order_book_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` int(11) UNSIGNED NOT NULL COMMENT '订单id',
  `cookbook_id` int(11) UNSIGNED NOT NULL COMMENT '菜单id',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜品名称',
  `price` decimal(8, 2) NOT NULL COMMENT '价格',
  `num` smallint(6) NOT NULL COMMENT '数量',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`order_book_id`) USING BTREE,
  INDEX `idx_vae_order_book`(`order_id`) USING BTREE,
  INDEX `idx_vae_order_book_0`(`cookbook_id`) USING BTREE,
  CONSTRAINT `fk_vae_order_book` FOREIGN KEY (`order_id`) REFERENCES `vae_order` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_vae_order_book_0` FOREIGN KEY (`cookbook_id`) REFERENCES `vae_cookbook` (`cookbook_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '点单菜品表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vae_order_book
-- ----------------------------
INSERT INTO `vae_order_book` VALUES (10, 22, 10, '红烧茄子', 8.00, 3, '2019-05-17 13:56:15');

-- ----------------------------
-- Table structure for vae_order_comment
-- ----------------------------
DROP TABLE IF EXISTS `vae_order_comment`;
CREATE TABLE `vae_order_comment`  (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) UNSIGNED NOT NULL COMMENT '订单号',
  `contents` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论的内容',
  `item1` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论维度1-服务态度',
  `item2` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论维度2-菜品评价',
  `average` float(4, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '平均分',
  `member_id` int(10) NOT NULL COMMENT '用户id',
  `reply_time` datetime NULL DEFAULT NULL COMMENT '回复时间',
  `reply_contents` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '回复内容',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '评论时间',
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `idx_vae_order_comment`(`order_id`) USING BTREE,
  CONSTRAINT `fk_vae_order_comment` FOREIGN KEY (`order_id`) REFERENCES `vae_order` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '评论表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vae_plugin
-- ----------------------------
DROP TABLE IF EXISTS `vae_plugin`;
CREATE TABLE `vae_plugin`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '插件标识',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件名称',
  `hook` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '实现的钩子;以“,”分隔',
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '插件作者',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '插件描述',
  `interface` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否有后台管理,0:没有;1:有',
  `config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '插件配置',
  `create_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '插件安装时间',
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '插件表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vae_route
-- ----------------------------
DROP TABLE IF EXISTS `vae_route`;
CREATE TABLE `vae_route`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `full_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1启用-1禁用',
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '路由设置' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vae_shop
-- ----------------------------
DROP TABLE IF EXISTS `vae_shop`;
CREATE TABLE `vae_shop`  (
  `shop_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `shop_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '店铺名称',
  `shop_address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '店铺地址',
  `contact_number` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系电话',
  `recommend` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '介绍',
  `shop_signs` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标语',
  `category_id` int(11) NOT NULL COMMENT '分类id',
  `shop_trait` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '店铺特色如准时达',
  `deliver_amount` smallint(6) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配送费',
  `minimum_amount` decimal(6, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '起送价',
  `business_start_house` time NULL DEFAULT NULL COMMENT '营业开始时间',
  `business_end_house` time NULL DEFAULT NULL COMMENT '营业结束时间',
  `thumb` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '封面图',
  `activity_description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '优惠活动说明',
  `is_delete` tinyint(1) NOT NULL COMMENT '是否删除',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`shop_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '店铺表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for vae_shop_cart
-- ----------------------------
DROP TABLE IF EXISTS `vae_shop_cart`;
CREATE TABLE `vae_shop_cart`  (
  `cart_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `member_id` int(11) UNSIGNED NOT NULL COMMENT '用户id',
  `cookbook_id` int(11) NOT NULL COMMENT '菜谱id',
  `cookbook_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜谱名称',
  `price` decimal(8, 2) UNSIGNED NULL DEFAULT NULL COMMENT '价格',
  `count` smallint(6) UNSIGNED NOT NULL COMMENT '数量',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`cart_id`) USING BTREE,
  INDEX `idx_vae_shop_cart`(`member_id`) USING BTREE,
  INDEX `idx_vae_shop_cart_0`(`cookbook_id`) USING BTREE,
  CONSTRAINT `fk_vae_shop_cart` FOREIGN KEY (`member_id`) REFERENCES `vae_member` (`member_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '购物车表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vae_slide
-- ----------------------------
DROP TABLE IF EXISTS `vae_slide`;
CREATE TABLE `vae_slide`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标识',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1可用-1禁用',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '幻灯片' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vae_slide
-- ----------------------------
INSERT INTO `vae_slide` VALUES (1, '首页轮播', 'VAE_INDEX_SLIDE', 1, '首页轮播组。', 0, 0);

-- ----------------------------
-- Table structure for vae_slide_info
-- ----------------------------
DROP TABLE IF EXISTS `vae_slide_info`;
CREATE TABLE `vae_slide_info`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `slide_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `title` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `src` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1可用-1禁用',
  `order` int(11) NOT NULL DEFAULT 0,
  `create_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '幻灯片详情' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of vae_slide_info
-- ----------------------------
INSERT INTO `vae_slide_info` VALUES (4, 1, 'a', '', 'http://lhy01.oss-cn-beijing.aliyuncs.com/dfd9e175e3023aebb3cf47e812837ce638c55062.jpeg', '', 1, 0, 0, 0);
INSERT INTO `vae_slide_info` VALUES (5, 1, 'b', '', 'http://lhy01.oss-cn-beijing.aliyuncs.com/2ac5fea8c18ae1026f497d4af6c12a4ce0f832b0.jpeg', '', 1, 0, 0, 0);

SET FOREIGN_KEY_CHECKS = 1;
