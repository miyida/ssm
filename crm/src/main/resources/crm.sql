/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : 127.0.0.1:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2020-12-07 17:32:44
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_group_rule
-- ----------------------------
DROP TABLE IF EXISTS `sys_group_rule`;
CREATE TABLE `sys_group_rule` (
`id`  int(11) NOT NULL AUTO_INCREMENT ,
`group_id`  int(11) NOT NULL COMMENT '用户组id' ,
`rule_id`  int(11) NOT NULL COMMENT '菜单id' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=100

;

-- ----------------------------
-- Records of sys_group_rule
-- ----------------------------
BEGIN;
INSERT INTO `sys_group_rule` VALUES ('59', '5', '1'), ('60', '5', '2'), ('61', '5', '3'), ('62', '5', '4'), ('63', '5', '5'), ('64', '5', '6'), ('65', '5', '7'), ('86', '1', '1'), ('87', '1', '2'), ('88', '1', '3'), ('89', '1', '4'), ('90', '1', '5'), ('91', '1', '6'), ('92', '1', '7'), ('93', '2', '4'), ('94', '2', '6'), ('95', '3', '4'), ('96', '3', '5'), ('97', '4', '1'), ('98', '4', '2'), ('99', '4', '3');
COMMIT;

-- ----------------------------
-- Table structure for sys_rule
-- ----------------------------
DROP TABLE IF EXISTS `sys_rule`;
CREATE TABLE `sys_rule` (
`id`  int(11) NOT NULL AUTO_INCREMENT ,
`parent_id`  int(11) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '父id' ,
`describle`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述' ,
`pic`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片' ,
`rname`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名' ,
`url`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单地址' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=8

;

-- ----------------------------
-- Records of sys_rule
-- ----------------------------
BEGIN;
INSERT INTO `sys_rule` VALUES ('1', '00000000000', null, 'fa fa-gear', '系统管理', null), ('2', '00000000001', null, 'fa fa-user', '用户管理', 'admin/user/listPage'), ('3', '00000000001', null, 'fa fa-group', '用户组管理', 'admin/group/listPage'), ('4', '00000000000', null, 'fa fa-space-shuttle', '商品与赠品管理', null), ('5', '00000000004', null, 'fa fa-soccer-ball-o', '产品查询', null), ('6', '00000000004', null, 'fa fa-briefcase', '商品管理', null), ('7', '00000000000', null, 'fa fa-cart-plus', '销售管理', null);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
`id`  int(11) NOT NULL AUTO_INCREMENT ,
`username`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名' ,
`password`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码' ,
`group_id`  int(11) NOT NULL COMMENT '角色id' ,
`status`  int(11) NULL DEFAULT 1 COMMENT '状态 0:禁用 1可使用' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=23

;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '1', '1'), ('3', 'zhangsan', 'e10adc3949ba59abbe56e057f20f883e', '1', '1'), ('4', '213123123', '123123123', '2', '1'), ('5', '12312312', '123123123', '1', '1'), ('6', '123123', '12312', '2', '0'), ('7', '123123', '123123123123', '1', '0'), ('8', '12312', '3123', '2', '1'), ('9', '123123123', '123123', '1', '1'), ('10', '12312123123', '3123123', '1', '1'), ('11', '123456', '123456', '1', '1'), ('12', '123345', '123345', '2', '1'), ('13', '123456', '123456', '2', '0'), ('14', '1111111111', '22222222222222', '2', '1'), ('15', '123321', '123321', '2', '1'), ('16', '123333', '123333', '1', '1'), ('17', '123345', '123456', '1', '1'), ('18', '12312312', '123123123', '2', '1'), ('19', 'aaaaa', 'aaaaaaa', '1', '1'), ('20', 'admin123', '0192023a7bbd73250516f069df18b500', '2', '1'), ('21', 'superadmin', '17c4520f6cfd1ab53d8745e84681eb49', '1', '1'), ('22', '12312312', 'f5bb0c8de146c67b44babbf4e6584cc0', '2', '1');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_group
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_group`;
CREATE TABLE `sys_user_group` (
`id`  int(11) NOT NULL AUTO_INCREMENT ,
`group_name`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称' ,
`auth_desc`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限描述' ,
`describle`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色描述' ,
`status`  int(11) NULL DEFAULT NULL COMMENT '状态 1:有效 0:无效' ,
`updtime`  timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=18

;

-- ----------------------------
-- Records of sys_user_group
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_group` VALUES ('1', '超级管理员', '测试一下1', '超级管理员123', '1', null), ('2', '商品管理员', '', '', '1', null), ('15', '测12', null, null, null, '2020-12-03 22:28:49'), ('16', '测试', null, null, null, null), ('17', '测试', null, null, null, '2020-12-03 22:27:09');
COMMIT;

-- ----------------------------
-- Auto increment value for sys_group_rule
-- ----------------------------
ALTER TABLE `sys_group_rule` AUTO_INCREMENT=100;

-- ----------------------------
-- Auto increment value for sys_rule
-- ----------------------------
ALTER TABLE `sys_rule` AUTO_INCREMENT=8;

-- ----------------------------
-- Auto increment value for sys_user
-- ----------------------------
ALTER TABLE `sys_user` AUTO_INCREMENT=23;

-- ----------------------------
-- Auto increment value for sys_user_group
-- ----------------------------
ALTER TABLE `sys_user_group` AUTO_INCREMENT=18;
