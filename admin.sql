/*
Navicat MySQL Data Transfer

Source Server         : aliyun
Source Server Version : 50558
Source Host           : 47.100.31.217:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 50558
File Encoding         : 65001

Date: 2018-02-12 18:30:41
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for agreement_approval
-- ----------------------------
DROP TABLE IF EXISTS `agreement_approval`;
CREATE TABLE `agreement_approval` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `agree_id` bigint(11) unsigned DEFAULT NULL COMMENT '合同id',
  `user_id` bigint(11) unsigned DEFAULT NULL COMMENT '审核人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '审核人 用户名',
  `approval_info` varchar(255) DEFAULT NULL COMMENT '审核信息',
  `status` tinyint(1) DEFAULT NULL COMMENT '处理状态。1通过 2未通过',
  `created_by` varchar(100) DEFAULT NULL COMMENT '记录创建人',
  `created_at` datetime DEFAULT NULL COMMENT '记录创建时间',
  `updated_by` varchar(100) DEFAULT NULL COMMENT '记录创建人',
  `updated_at` datetime DEFAULT NULL COMMENT '最近修改时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='合同审核信息表';

-- ----------------------------
-- Records of agreement_approval
-- ----------------------------

-- ----------------------------
-- Table structure for agreement_goods
-- ----------------------------
DROP TABLE IF EXISTS `agreement_goods`;
CREATE TABLE `agreement_goods` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `agreement_id` bigint(11) unsigned DEFAULT NULL,
  `system_name` varchar(50) DEFAULT NULL COMMENT '系统名称',
  `hardware_name` varchar(50) DEFAULT NULL COMMENT '硬件名称',
  `goods_num` int(4) unsigned DEFAULT NULL COMMENT '数量',
  `price` decimal(10,2) unsigned DEFAULT NULL COMMENT '单价',
  `hardware_amount` decimal(10,2) unsigned DEFAULT NULL COMMENT '设备费合计/元',
  `service_amount` decimal(10,2) unsigned DEFAULT NULL COMMENT '服务费（元/年）	',
  `all_amount` decimal(10,2) unsigned DEFAULT NULL COMMENT '安装费及辅材费用 合计（元/套）',
  `created_by` varchar(100) DEFAULT NULL COMMENT '记录创建人',
  `created_at` datetime DEFAULT NULL COMMENT '记录创建时间',
  `updated_by` varchar(100) DEFAULT NULL COMMENT '记录创建人',
  `updated_at` datetime DEFAULT NULL COMMENT '最近修改时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='合同货品清单 价款及支付信息';

-- ----------------------------
-- Records of agreement_goods
-- ----------------------------

-- ----------------------------
-- Table structure for agreement_info
-- ----------------------------
DROP TABLE IF EXISTS `agreement_info`;
CREATE TABLE `agreement_info` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `agree_sn` varchar(50) DEFAULT NULL COMMENT '合同编号',
  `first_party` varchar(50) DEFAULT NULL COMMENT '甲方名称',
  `customer_id` bigint(11) unsigned DEFAULT NULL COMMENT '客户id',
  `contact_id` bigint(11) unsigned DEFAULT NULL COMMENT '联络人id',
  `contact_name` varchar(50) DEFAULT NULL COMMENT '联系人(销售经理)',
  `service_life` int(4) unsigned DEFAULT NULL COMMENT '服务年限',
  `project_name` varchar(80) DEFAULT NULL COMMENT '项目名称',
  `hardware_all` decimal(10,2) unsigned DEFAULT NULL COMMENT '设备费合计/元',
  `install_all` decimal(10,2) unsigned DEFAULT NULL COMMENT '安装费合计/元',
  `service_all` decimal(10,2) unsigned DEFAULT NULL COMMENT '服务费合计/元',
  `expenses_all` decimal(10,2) unsigned DEFAULT NULL COMMENT '费用总合计',
  `payables_all` decimal(10,2) unsigned DEFAULT NULL COMMENT '应付款',
  `service_year_all` decimal(10,2) unsigned DEFAULT NULL COMMENT '服务费（每年）',
  `service_month` int(4) unsigned DEFAULT NULL COMMENT '服务费起付日期 月',
  `service_day` int(4) unsigned DEFAULT NULL COMMENT '服务费起付日期 日',
  `agreement_amount` decimal(10,2) unsigned DEFAULT NULL COMMENT '合同应付款总额',
  `agreement_amount_upper` varchar(50) DEFAULT NULL COMMENT '合同应付款总额 大写',
  `first_ratio` decimal(6,2) unsigned DEFAULT NULL COMMENT '首付比例',
  `last_ratio` decimal(6,2) unsigned DEFAULT NULL COMMENT '尾款比例',
  `repair_years` int(4) unsigned DEFAULT NULL COMMENT '保修年限',
  `approval_status` tinyint(1) DEFAULT NULL COMMENT '审批状态。0已保存待提交 1待内勤初审 2总监审核 3合同上传 4签订完成',
  `refuse_info` varchar(100) DEFAULT NULL COMMENT '审批不通过原因',
  `agree_date` datetime DEFAULT NULL COMMENT '签订日期',
  `created_by` varchar(100) DEFAULT NULL COMMENT '记录创建人',
  `created_at` datetime DEFAULT NULL COMMENT '记录创建时间',
  `updated_by` varchar(100) DEFAULT NULL COMMENT '记录创建人',
  `updated_at` datetime DEFAULT NULL COMMENT '最近修改时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='合同信息表';

-- ----------------------------
-- Records of agreement_info
-- ----------------------------

-- ----------------------------
-- Table structure for agreement_pay
-- ----------------------------
DROP TABLE IF EXISTS `agreement_pay`;
CREATE TABLE `agreement_pay` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `agree_id` bigint(11) unsigned DEFAULT NULL COMMENT '合同id',
  `user_id` bigint(11) unsigned DEFAULT NULL COMMENT '操作人id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '收款人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `should_pay` decimal(10,2) unsigned DEFAULT NULL COMMENT '应当付款金额',
  `pay_amount` decimal(10,2) unsigned DEFAULT NULL COMMENT '付款金额',
  `pay_type` tinyint(1) DEFAULT NULL COMMENT '审批状态。1首付款/2发货前款/3发货后款/4验收款/5尾款',
  `created_by` varchar(100) DEFAULT NULL COMMENT '记录创建人',
  `created_at` datetime DEFAULT NULL COMMENT '记录创建时间',
  `updated_by` varchar(100) DEFAULT NULL COMMENT '记录创建人',
  `updated_at` datetime DEFAULT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='合同付款信息表';

-- ----------------------------
-- Records of agreement_pay
-- ----------------------------

-- ----------------------------
-- Table structure for appraisal
-- ----------------------------
DROP TABLE IF EXISTS `appraisal`;
CREATE TABLE `appraisal` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) DEFAULT NULL,
  `user_name` varchar(64) DEFAULT NULL COMMENT '用户名',
  `item_ids` varchar(64) DEFAULT NULL COMMENT '考评项id集合,逗号隔开',
  `item_scores` varchar(64) DEFAULT NULL COMMENT '考评项得分集合，逗号隔开',
  `score` varchar(20) DEFAULT NULL COMMENT '得分',
  `year` int(4) DEFAULT '2018' COMMENT '年份',
  `month` int(2) DEFAULT '1' COMMENT '月份',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of appraisal
-- ----------------------------

-- ----------------------------
-- Table structure for appraisal_item
-- ----------------------------
DROP TABLE IF EXISTS `appraisal_item`;
CREATE TABLE `appraisal_item` (
  `id` int(3) NOT NULL AUTO_INCREMENT COMMENT '考评项ID',
  `name` varchar(50) DEFAULT NULL COMMENT '考评项',
  `weight` int(10) DEFAULT '0' COMMENT '权重',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of appraisal_item
-- ----------------------------

-- ----------------------------
-- Table structure for attachment
-- ----------------------------
DROP TABLE IF EXISTS `attachment`;
CREATE TABLE `attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_code` varchar(20) NOT NULL COMMENT '文件编码',
  `file_name` varchar(50) NOT NULL COMMENT '文件名称',
  `file_type` tinyint(2) DEFAULT '1' COMMENT '文件类别 1:合同  2:勘察报告  3:安装验收报告',
  `relate_id` int(11) DEFAULT NULL COMMENT '关联id，比如合同id、勘查报告id、安装验收报告id',
  `url` varchar(200) NOT NULL COMMENT '访问路径',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='系统附件表';

-- ----------------------------
-- Records of attachment
-- ----------------------------
INSERT INTO `attachment` VALUES ('5', '0000', '工程验收表.jpg', '3', '1', 'D:\\usr\\attachment\\', '2017-12-30 23:19:31', '2017-12-30 23:19:31', '系统管理员', '系统管理员', null, '0');
INSERT INTO `attachment` VALUES ('6', '0000', '工程验收表.jpg', '3', '1', '\\usr\\attachment\\', '2017-12-30 23:27:01', '2017-12-30 23:27:01', '系统管理员', '系统管理员', null, '0');
INSERT INTO `attachment` VALUES ('7', '0000', '工程验收表.jpg', '3', '1', '/usr/attachment/', '2017-12-30 23:41:51', '2017-12-30 23:41:51', '系统管理员', '系统管理员', null, '0');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_code` varchar(20) DEFAULT NULL COMMENT '客户编码',
  `customer_name` varchar(50) NOT NULL COMMENT '客户名称',
  `type_code` varchar(20) DEFAULT NULL COMMENT '所属行业编码',
  `type_name` varchar(50) DEFAULT NULL COMMENT '所属行业名称',
  `phone` varchar(50) DEFAULT NULL COMMENT '电话',
  `fax` varchar(50) DEFAULT NULL COMMENT '传真',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `url` varchar(50) DEFAULT NULL COMMENT '网址',
  `manager` varchar(50) DEFAULT NULL COMMENT '公司法人或总经理',
  `contact` varchar(50) DEFAULT NULL COMMENT '联系方式',
  `dock_department` varchar(50) DEFAULT NULL COMMENT '对接部门',
  `dock_person` varchar(50) DEFAULT NULL COMMENT '对接部门联系人',
  `dock_contact` varchar(50) DEFAULT NULL COMMENT '对接部门联系方式',
  `relate_department` varchar(50) DEFAULT NULL COMMENT '关联部门',
  `relate_person` varchar(50) DEFAULT NULL COMMENT '关联部门联系人',
  `relate_contact` varchar(50) DEFAULT NULL COMMENT '关联部门联系方式',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  `responsible_person` varchar(50) DEFAULT NULL COMMENT '负责人',
  `responsible_person_id` int(11) DEFAULT NULL COMMENT '负责人id',
  `assist_person` varchar(50) DEFAULT NULL COMMENT '协助人',
  `assist_person_id` int(11) DEFAULT NULL COMMENT '协助人id',
  `status` tinyint(2) DEFAULT '1' COMMENT '客户状态 1：申请中 2：审核通过 3：审核不通过',
  `draft` tinyint(1) DEFAULT '0' COMMENT '是否草稿 1:是   0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='客户表';

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('32', null, '测试', null, '市场部', '18753233152', '', '青岛市市南区', '', '', '', '', '', '', '', '', '', '2018-02-01 14:34:46', '2018-02-01 14:34:46', '系统管理员', '系统管理员', null, '0', null, null, null, null, '1', '0');

-- ----------------------------
-- Table structure for customer_contact
-- ----------------------------
DROP TABLE IF EXISTS `customer_contact`;
CREATE TABLE `customer_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL COMMENT '客户id',
  `customer_code` varchar(20) DEFAULT NULL COMMENT '客户编码',
  `customer_name` varchar(50) NOT NULL COMMENT '客户名称',
  `type` varchar(20) NOT NULL COMMENT '类别：设备用电管理人、建筑消防用水、安全巡检、可视化监管、紧急联系人',
  `contact_name` varchar(50) NOT NULL COMMENT '姓名',
  `contact_post` varchar(50) DEFAULT NULL COMMENT '职务',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机',
  `phone` varchar(50) DEFAULT NULL COMMENT '电话',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='客户联系人表';

-- ----------------------------
-- Records of customer_contact
-- ----------------------------

-- ----------------------------
-- Table structure for customer_feedback
-- ----------------------------
DROP TABLE IF EXISTS `customer_feedback`;
CREATE TABLE `customer_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL COMMENT '客户id',
  `customer_code` varchar(20) DEFAULT NULL COMMENT '客户编码',
  `customer_name` varchar(50) NOT NULL COMMENT '客户名称',
  `responsible_person` varchar(50) DEFAULT NULL COMMENT '负责人',
  `responsible_person_id` int(11) DEFAULT NULL COMMENT '负责人id',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='客户反馈表';

-- ----------------------------
-- Records of customer_feedback
-- ----------------------------

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL COMMENT '编码',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `principal_user_id` int(11) DEFAULT NULL COMMENT '部门负责人id',
  `principal_nick_name` varchar(50) DEFAULT NULL COMMENT '部门负责人姓名',
  `description` varchar(200) DEFAULT NULL COMMENT '描述',
  `parent_id` int(11) NOT NULL COMMENT '上级部门id',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='部门表';

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '100', '淼盾物联', null, null, '淼盾物联', '1', '2017-11-19 00:00:00', '2017-11-19 00:00:00', 'admin', 'admin', null, '0');
INSERT INTO `department` VALUES ('2', '100101', '市场部', null, null, '市场部', '1', '2017-11-19 00:00:00', '2017-11-19 00:00:00', 'admin', 'admin', null, '0');
INSERT INTO `department` VALUES ('3', '100102', '客服部', null, null, '客服部', '1', '2017-11-19 00:00:00', '2017-11-19 00:00:00', 'admin', 'admin', null, '0');
INSERT INTO `department` VALUES ('8', '100103', '销售部', '10', '张财霞', '', '1', '2017-12-12 18:52:27', '2017-12-12 18:52:27', 'system', 'system', null, null);

-- ----------------------------
-- Table structure for expense_reports
-- ----------------------------
DROP TABLE IF EXISTS `expense_reports`;
CREATE TABLE `expense_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL COMMENT '人员姓名',
  `year` int(5) DEFAULT NULL COMMENT '年份',
  `month` tinyint(3) DEFAULT NULL COMMENT '月份',
  `fuel_charge` decimal(10,2) DEFAULT NULL COMMENT '燃油费',
  `bus_fee` decimal(10,2) DEFAULT NULL COMMENT '公交/长途费',
  `taxi_fee` decimal(10,2) DEFAULT NULL COMMENT '出租车费',
  `telephone_charge` decimal(10,2) DEFAULT NULL COMMENT '话费',
  `fete_fee` decimal(10,2) DEFAULT NULL COMMENT '宴请费用',
  `travelling_expenses` decimal(10,2) DEFAULT NULL COMMENT '出差费',
  `marketing_costs` decimal(10,2) DEFAULT NULL COMMENT '营销费用',
  `all_costs` decimal(10,2) DEFAULT NULL COMMENT '费用总计',
  `enable` tinyint(3) DEFAULT '1' COMMENT '是否删除：0-无效，1-有效',
  `created_by` varchar(64) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(64) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of expense_reports
-- ----------------------------

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_at` datetime NOT NULL COMMENT '开始时间',
  `end_at` datetime NOT NULL COMMENT '结束时间',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `content` varchar(512) DEFAULT NULL COMMENT '内容',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公告表';

-- ----------------------------
-- Records of notice
-- ----------------------------

-- ----------------------------
-- Table structure for order_feedback
-- ----------------------------
DROP TABLE IF EXISTS `order_feedback`;
CREATE TABLE `order_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '订单id',
  `customer_id` int(11) NOT NULL COMMENT '客户id',
  `customer_code` varchar(20) DEFAULT NULL COMMENT '客户编码',
  `customer_name` varchar(50) NOT NULL COMMENT '客户名称',
  `responsible_person` varchar(50) DEFAULT NULL COMMENT '负责人',
  `responsible_person_id` int(11) DEFAULT NULL COMMENT '负责人id',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='订单跟进反馈表';

-- ----------------------------
-- Records of order_feedback
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(20) NOT NULL COMMENT '订单编号',
  `customer_code` varchar(20) DEFAULT NULL COMMENT '客户编码',
  `customer_name` varchar(50) NOT NULL COMMENT '客户名称',
  `agree_sn` varchar(50) NOT NULL COMMENT '合同编号',
  `approval_status` tinyint(2) DEFAULT NULL COMMENT '合同状态。0已保存待提交 1待内勤初审 2总监审核 3合同上传 4签订完成',
  `pre_install_at` datetime DEFAULT NULL COMMENT '预约安装时间',
  `deliver_at` datetime DEFAULT NULL COMMENT '发货时间',
  `install_at` datetime DEFAULT NULL COMMENT '实际安装时间',
  `completed_at` datetime DEFAULT NULL COMMENT '安装完成时间',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for performance_reports
-- ----------------------------
DROP TABLE IF EXISTS `performance_reports`;
CREATE TABLE `performance_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL COMMENT '人员姓名',
  `year` int(5) DEFAULT NULL COMMENT '年份',
  `month` tinyint(3) DEFAULT NULL COMMENT '月份',
  `order_month_target` decimal(10,2) DEFAULT NULL COMMENT '订单月度目标',
  `order_month_actual` decimal(10,2) DEFAULT NULL COMMENT '订单月度实际',
  `order_month_rate` decimal(10,4) DEFAULT NULL COMMENT '订单月度完成率',
  `order_quarter_target` decimal(10,2) DEFAULT NULL COMMENT '订单季度目标',
  `order_quarter_actual` decimal(10,2) DEFAULT NULL COMMENT '订单季度实际',
  `order_quarter_rate` decimal(10,4) DEFAULT NULL COMMENT '订单季度完成率',
  `contract_target` decimal(10,2) DEFAULT NULL COMMENT '合同回款目标',
  `contract_actual` decimal(10,2) DEFAULT NULL COMMENT '合同回款实际',
  `contract_rate` decimal(10,4) DEFAULT NULL COMMENT '合同回款完成率',
  `daily_check_rate` decimal(10,4) DEFAULT NULL COMMENT '日常考核完成率：合同回款实际/订单月度实际',
  `daily` varchar(20) DEFAULT NULL COMMENT '日常',
  `check_ranking` int(100) DEFAULT NULL COMMENT '考核排名',
  `enable` tinyint(3) DEFAULT '1' COMMENT '是否删除：0-无效，1-有效',
  `created_by` varchar(64) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(64) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of performance_reports
-- ----------------------------

-- ----------------------------
-- Table structure for prospect
-- ----------------------------
DROP TABLE IF EXISTS `prospect`;
CREATE TABLE `prospect` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(30) DEFAULT NULL COMMENT '客户名称',
  `prospect_address` varchar(200) DEFAULT NULL COMMENT '勘查地址',
  `name` varchar(30) DEFAULT NULL COMMENT '联系人',
  `mobile` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `prospect_confirm_time` datetime DEFAULT NULL COMMENT '确定勘查时间',
  `prospect_start_time` datetime DEFAULT NULL COMMENT '实际勘查时间',
  `prospect_end_time` datetime DEFAULT NULL COMMENT '勘查结束时间',
  `prospect_name` varchar(30) DEFAULT NULL COMMENT '勘查人员姓名',
  `prospect_content` varchar(200) DEFAULT NULL COMMENT '勘查内容:1-电气火灾监测系统，2-安全隐患巡查系统，3-建筑消防用水监测系统，4-重点部位可视化监管系统，5-火灾在线联网报警系统；多项以逗号隔开',
  `prospect_require` varchar(200) DEFAULT NULL COMMENT '勘查要求',
  `status` tinyint(3) DEFAULT NULL COMMENT '勘查状态：0-已派工，待勘查，1-勘查完成，待安装',
  `prospect_file_address` varchar(200) DEFAULT NULL COMMENT '勘查数据文件地址',
  `enable` tinyint(3) DEFAULT '1' COMMENT '是否删除：0-无效，1-有效',
  `created_by` varchar(64) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(64) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of prospect
-- ----------------------------
INSERT INTO `prospect` VALUES ('12', '测试', '青岛市李沧区', '刘先生', '186532563256', null, null, null, null, '1,2,5', '测试信息', '0', null, '1', 'admin', '2018-02-01 17:56:17', 'admin', '2018-02-01 17:56:17', null);
INSERT INTO `prospect` VALUES ('13', '测试', '青岛市李沧区', '刘先生', '186532563256', '2018-02-01 00:00:00', '2018-02-01 00:00:00', '2018-02-01 00:00:00', '于', '1,2,5', '测试信息', '0', null, '1', 'admin', '2018-02-01 17:56:28', 'admin', '2018-02-01 17:58:07', '测试');
INSERT INTO `prospect` VALUES ('14', '', '', '', '', null, null, null, null, '', '', '0', null, '1', 'admin', '2018-02-01 18:18:02', 'admin', '2018-02-01 18:18:02', null);
INSERT INTO `prospect` VALUES ('15', '', '', '', '', null, null, null, null, '', '', '0', null, '1', 'admin', '2018-02-01 18:18:10', 'admin', '2018-02-01 18:18:10', null);

-- ----------------------------
-- Table structure for reimbursement
-- ----------------------------
DROP TABLE IF EXISTS `reimbursement`;
CREATE TABLE `reimbursement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(20) DEFAULT NULL COMMENT '业务员ID',
  `user_name` varchar(20) DEFAULT NULL COMMENT '业务员',
  `style` varchar(20) DEFAULT NULL COMMENT '费用类型',
  `approval_man` varchar(20) DEFAULT NULL COMMENT '营销总监人',
  `caiwu_man` varchar(20) DEFAULT NULL COMMENT '财务审核人',
  `approval_date` datetime DEFAULT NULL COMMENT '总监审核日期',
  `caiwu_date` datetime DEFAULT NULL COMMENT '财务审核日期',
  `approval_state` int(11) DEFAULT '0' COMMENT '审核状态 初始:0 提交:1 总监已审:2 财务已审:3 打回:4',
  `fee_amt` decimal(12,3) DEFAULT NULL COMMENT '费用金额',
  `fee_date` datetime DEFAULT NULL COMMENT '费用发生日期',
  `created_by` varchar(20) DEFAULT NULL COMMENT '记录创建人',
  `created_at` datetime DEFAULT NULL COMMENT '记录创建时间',
  `updated_by` varchar(20) DEFAULT NULL COMMENT '记录创建人',
  `updated_at` datetime DEFAULT NULL COMMENT '最近修改时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(4) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reimbursement
-- ----------------------------

-- ----------------------------
-- Table structure for resource_info
-- ----------------------------
DROP TABLE IF EXISTS `resource_info`;
CREATE TABLE `resource_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL COMMENT '编码',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `description` varchar(200) NOT NULL COMMENT '描述',
  `url` varchar(200) NOT NULL COMMENT '访问路径',
  `type` tinyint(2) DEFAULT '0' COMMENT '类别 0:模块 1:页面  2:按钮',
  `order_index` int(4) DEFAULT '0' COMMENT '顺序',
  `parent_id` int(11) NOT NULL COMMENT '上级资源id',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 COMMENT='资源表';

-- ----------------------------
-- Records of resource_info
-- ----------------------------
INSERT INTO `resource_info` VALUES ('1', '100', '淼盾物联', '淼盾物联', '#', '0', '1', '1', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', null, '0');
INSERT INTO `resource_info` VALUES ('2', '100101', '系统管理', '系统管理', '#', '0', '2', '1', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('3', '100102', '客户管理', '客户管理', '#', '0', '3', '1', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('4', '100103', '订单管理', '订单管理', '#', '0', '5', '1', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('5', '100104', '合同管理', '合同管理', '#', '0', '4', '1', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('6', '100105', '财务管理', '财务管理', '#', '0', '6', '1', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('7', '100102101', '客户接入', '客户接入', '/customer/customer.html', '1', '7', '3', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('8', '100101101', '部门管理', '部门管理', '/system/department.html', '1', '8', '2', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('9', '100101102', '角色管理', '角色管理', '/system/role.html', '1', '9', '2', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('10', '100101103', '权限管理', '权限管理', '/system/roleResource.html', '1', '10', '2', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('11', '100101104', '用户管理', '用户管理', '/system/user.html', '1', '11', '2', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('12', '100102101101', '查询', '客户接入-查询', '#', '2', '12', '7', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('13', '100104101', '合同管理', '合同管理', '/agreementInfo/agreement.html', '1', '13', '5', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('14', '100102102', '客户反馈', '客户反馈', '/customer/customerFeedback.html', '1', '14', '3', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('15', '100102103', '协助客户', '协助客户', '/customer/customer.html', '1', '15', '3', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('16', '100102104', '客户公海', '客户公海', '/customer/customer.html', '1', '16', '3', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('17', '100103101', '订单查询', '订单查询', '/order/order.html', '1', '17', '4', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('18', '100103102', '订单执行', '订单执行', '/order/orderExecute.html', '1', '18', '4', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('19', '100103103', '客户勘查', '客户勘查', '/prospect/prospect.html', '1', '19', '3', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('20', '100105101', '财务管理', '财务管理', '#', '1', '20', '6', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '1');
INSERT INTO `resource_info` VALUES ('21', '100102101102', '分配', '客户接入-分配', '#', '2', '21', '7', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('22', '100101101101', '查询', '部门管理-查询', '#', '2', '22', '8', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('23', '100101101102', '新增', '部门管理-新增', '#', '2', '23', '8', '2017-11-30 10:44:40', '2017-11-30 10:44:40', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('24', '100101101103', '修改', '部门管理-修改', '#', '2', '24', '8', '2017-11-30 10:44:41', '2017-11-30 10:44:41', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('25', '100101101104', '删除', '部门管理-删除', '#', '2', '25', '8', '2017-11-30 10:44:42', '2017-11-30 10:44:42', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('26', '100101102101', '查询', '角色管理-查询', '#', '2', '26', '9', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('27', '100101102102', '新增', '角色管理-新增', '#', '2', '27', '9', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('28', '100101102103', '修改', '角色管理-修改', '#', '2', '28', '9', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('29', '100101102104', '删除', '角色管理-删除', '#', '2', '29', '9', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('30', '100101103101', '查询', '权限管理-查询', '#', '2', '30', '10', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('31', '100101103102', '设置权限', '权限管理-设置权限', '#', '2', '31', '10', '2017-11-30 10:44:40', '2017-11-30 10:44:40', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('32', '100101104101', '查询', '用户管理-查询', '#', '2', '32', '11', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('33', '100101104102', '重置密码', '用户管理-重置密码', '#', '2', '33', '11', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('34', '100101104103', '修改', '用户管理-修改', '#', '2', '34', '11', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('35', '100101104104', '审核通过', '用户管理-审核通过', '#', '2', '35', '11', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('36', '100102101103', '反馈', '客户接入-反馈', '#', '2', '36', '7', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('37', '100104101101', '查询', '合同管理-查询', '#', '2', '37', '13', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('38', '100102102101', '查询', '客户反馈-查询', '#', '2', '38', '14', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('39', '100102103101', '查询', '协助客户-查询', '#', '2', '39', '15', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('40', '100102104101', '查询', '客户公海-查询', '#', '2', '40', '16', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('41', '100103101101', '查询', '订单查询-查询', '#', '2', '41', '17', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('42', '100103102101', '查询', '订单执行-查询', '#', '2', '42', '18', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('43', '100103103101', '查询', '客户勘查-查询', '#', '2', '43', '19', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('44', '100105101101', '查询', '财务管理-查询', '#', '2', '44', '20', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '1');
INSERT INTO `resource_info` VALUES ('45', '100102101104', '新增', '客户接入-新增', '#', '2', '45', '7', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('46', '100104102', '财务收款', '财务收款', '/agreementFinance/agreement.html', '1', '13', '6', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('47', '100104102101', '查询', '财务收款-查询', '#', '2', '37', '46', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('48', '100106', '报表管理', '报表管理', '#', '0', '48', '1', '2017-12-24 10:44:39', '2017-12-24 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('49', '100106101', '费用-人员累计', '费用-人员累计', '/report/personalExpense.html', '1', '49', '48', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('50', '100106102', '费用-按月汇总', '费用-按月汇总', '/report/monthExpense.html', '1', '50', '48', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('51', '100106103', '业绩-人员累计', '业绩-人员累计', '/report/personalPerformance.html', '1', '51', '48', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('52', '100106104', '业绩-月度累计', '业绩-月度累计', '/report/monthPerformance.html', '1', '52', '48', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('53', '100106101101', '查询', '费用-人员累计-查询', '#', '2', '53', '49', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('54', '100106102101', '查询', '费用-按月汇总-查询', '#', '2', '54', '50', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('55', '100106103101', '查询', '业绩-人员累计-查询', '#', '2', '55', '51', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('56', '100106104101', '查询', '业绩-月度累计-查询', '#', '2', '56', '52', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('57', '100103102102', '跟进反馈', '订单执行-跟进反馈', '#', '2', '57', '18', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('58', '100103102103', '预约安装时间', '订单执行-预约安装时间', '#', '2', '58', '18', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('59', '100103102104', '验收', '订单执行-验收', '#', '2', '59', '18', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('60', '100107', '销售管理', '销售管理', '#', '0', '60', '1', '2017-12-19 23:34:42', '2017-12-19 23:34:42', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('61', '100107101', '销售计划', '销售计划', '/sale/plan/saleplan.html', '1', '61', '60', '2017-12-19 23:34:42', '2017-12-19 23:19:22', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('62', '100105102', '报销管理', '报销管理', '/fee/feelist.html', '1', '62', '6', '2017-12-25 21:25:59', '2017-12-25 21:26:02', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('63', '100105103', '总监审核报销', '总监审核报销', '/approval/approvallist.html?style=1', '1', '63', '6', '2017-12-28 13:06:48', '2017-12-28 13:06:54', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('64', '100105104', '财务审核报销', '财务审核报销', '/approval/approvallist.html?style=2', '1', '64', '6', '2017-12-29 12:43:35', '2017-12-29 12:43:41', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('65', '100107101101', '查询', '销售计划-查询', '#', '2', '65', '61', '2017-11-30 10:44:39', '2017-11-30 10:44:39', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('66', '100105102101', '查询', '报销管理-查询', '#', '2', '66', '62', '2017-11-30 10:44:40', '2017-11-30 10:44:40', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('67', '100105103101', '查询', '总监审核报销-查询', '#', '2', '67', '63', '2017-11-30 10:44:41', '2017-11-30 10:44:41', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('68', '100105104101', '查询', '财务审核报销-查询', '#', '2', '68', '64', '2017-11-30 10:44:42', '2017-11-30 10:44:42', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('69', '100108', '薪酬管理', '薪酬管理', '#', '0', '69', '1', '2017-12-12 22:25:23', '2017-12-12 22:25:29', 'admin', 'admin', null, '0');
INSERT INTO `resource_info` VALUES ('70', '100108101', '底薪设置', '底薪设置', '/salary/base/ruleList.html', '1', '70', '69', '2017-12-12 22:34:42', '2017-12-12 22:34:45', 'admin', 'admin', null, '0');
INSERT INTO `resource_info` VALUES ('71', '100106101101', '查询', '底薪设置-查询', '#', '2', '71', '70', '2017-11-30 10:44:43', '2017-11-30 10:44:43', 'admin', 'admin', '', '0');
INSERT INTO `resource_info` VALUES ('72', '100133', '晋升管理', '晋升管理', '#', '0', '72', '1', '2018-01-04 18:07:50', '2018-01-04 18:07:57', 'admin', 'admin', null, '0');
INSERT INTO `resource_info` VALUES ('73', '100133101', '考评激励', '考评激励', '/appraisal//appraisal.html', '1', '73', '72', '2018-01-04 18:10:53', '2018-01-04 18:10:56', 'admin', 'admin', null, '0');
INSERT INTO `resource_info` VALUES ('74', '100133101101', '查询', '考评激励-查询', '#', '2', '74', '73', '2017-11-30 10:44:43', '2017-11-30 10:44:43', 'admin', 'admin', '', '0');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL COMMENT '编码',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `description` varchar(200) NOT NULL COMMENT '描述',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '101', '系统管理员', '系统管理员', '2017-12-06 01:43:00', '2017-12-06 01:43:00', 'admin', 'admin', null, '0');
INSERT INTO `role` VALUES ('2', '102', '总监', '市场部总监', '2017-12-10 20:07:01', '2017-12-10 20:07:01', '系统管理员', '系统管理员', null, '0');
INSERT INTO `role` VALUES ('3', '103', '总监助理', '市场部总监助理', '2017-12-10 20:07:28', '2017-12-10 20:07:28', '系统管理员', '系统管理员', null, '0');
INSERT INTO `role` VALUES ('4', '104', '区域经理', '区域经理', '2017-12-10 20:07:52', '2017-12-10 20:07:52', '系统管理员', '系统管理员', null, '0');
INSERT INTO `role` VALUES ('5', '105', '业务员', '业务员', '2017-12-10 20:08:11', '2017-12-10 20:08:11', '系统管理员', '系统管理员', null, '0');
INSERT INTO `role` VALUES ('6', '106', '客服部经理', '客服部经理', '2017-12-10 20:08:28', '2017-12-10 20:08:28', '系统管理员', '系统管理员', null, '0');
INSERT INTO `role` VALUES ('7', '107', '客服', '客服', '2017-12-10 20:08:47', '2017-12-10 20:08:47', '系统管理员', '系统管理员', null, '0');
INSERT INTO `role` VALUES ('8', '108', '销售内勤', '销售内勤', '2017-12-10 20:09:05', '2017-12-10 20:09:05', '系统管理员', '系统管理员', null, '0');

-- ----------------------------
-- Table structure for role_resource
-- ----------------------------
DROP TABLE IF EXISTS `role_resource`;
CREATE TABLE `role_resource` (
  `role_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色资源表';

-- ----------------------------
-- Records of role_resource
-- ----------------------------
INSERT INTO `role_resource` VALUES ('8', '8');
INSERT INTO `role_resource` VALUES ('8', '22');
INSERT INTO `role_resource` VALUES ('8', '23');
INSERT INTO `role_resource` VALUES ('8', '24');
INSERT INTO `role_resource` VALUES ('8', '25');
INSERT INTO `role_resource` VALUES ('8', '9');
INSERT INTO `role_resource` VALUES ('8', '26');
INSERT INTO `role_resource` VALUES ('8', '27');
INSERT INTO `role_resource` VALUES ('8', '28');
INSERT INTO `role_resource` VALUES ('8', '29');
INSERT INTO `role_resource` VALUES ('8', '30');
INSERT INTO `role_resource` VALUES ('8', '11');
INSERT INTO `role_resource` VALUES ('8', '32');
INSERT INTO `role_resource` VALUES ('8', '33');
INSERT INTO `role_resource` VALUES ('8', '34');
INSERT INTO `role_resource` VALUES ('8', '35');
INSERT INTO `role_resource` VALUES ('8', '12');
INSERT INTO `role_resource` VALUES ('8', '45');
INSERT INTO `role_resource` VALUES ('8', '14');
INSERT INTO `role_resource` VALUES ('8', '38');
INSERT INTO `role_resource` VALUES ('8', '15');
INSERT INTO `role_resource` VALUES ('8', '39');
INSERT INTO `role_resource` VALUES ('8', '16');
INSERT INTO `role_resource` VALUES ('8', '40');
INSERT INTO `role_resource` VALUES ('8', '19');
INSERT INTO `role_resource` VALUES ('8', '43');
INSERT INTO `role_resource` VALUES ('8', '4');
INSERT INTO `role_resource` VALUES ('8', '17');
INSERT INTO `role_resource` VALUES ('8', '41');
INSERT INTO `role_resource` VALUES ('8', '18');
INSERT INTO `role_resource` VALUES ('8', '42');
INSERT INTO `role_resource` VALUES ('8', '5');
INSERT INTO `role_resource` VALUES ('8', '13');
INSERT INTO `role_resource` VALUES ('8', '37');
INSERT INTO `role_resource` VALUES ('8', '6');
INSERT INTO `role_resource` VALUES ('8', '20');
INSERT INTO `role_resource` VALUES ('8', '44');
INSERT INTO `role_resource` VALUES ('8', '8');
INSERT INTO `role_resource` VALUES ('8', '22');
INSERT INTO `role_resource` VALUES ('8', '23');
INSERT INTO `role_resource` VALUES ('8', '24');
INSERT INTO `role_resource` VALUES ('8', '25');
INSERT INTO `role_resource` VALUES ('8', '9');
INSERT INTO `role_resource` VALUES ('8', '26');
INSERT INTO `role_resource` VALUES ('8', '27');
INSERT INTO `role_resource` VALUES ('8', '28');
INSERT INTO `role_resource` VALUES ('8', '29');
INSERT INTO `role_resource` VALUES ('8', '30');
INSERT INTO `role_resource` VALUES ('8', '11');
INSERT INTO `role_resource` VALUES ('8', '32');
INSERT INTO `role_resource` VALUES ('8', '33');
INSERT INTO `role_resource` VALUES ('8', '34');
INSERT INTO `role_resource` VALUES ('8', '35');
INSERT INTO `role_resource` VALUES ('8', '12');
INSERT INTO `role_resource` VALUES ('8', '45');
INSERT INTO `role_resource` VALUES ('8', '14');
INSERT INTO `role_resource` VALUES ('8', '38');
INSERT INTO `role_resource` VALUES ('8', '15');
INSERT INTO `role_resource` VALUES ('8', '39');
INSERT INTO `role_resource` VALUES ('8', '16');
INSERT INTO `role_resource` VALUES ('8', '40');
INSERT INTO `role_resource` VALUES ('8', '19');
INSERT INTO `role_resource` VALUES ('8', '43');
INSERT INTO `role_resource` VALUES ('8', '4');
INSERT INTO `role_resource` VALUES ('8', '17');
INSERT INTO `role_resource` VALUES ('8', '41');
INSERT INTO `role_resource` VALUES ('8', '18');
INSERT INTO `role_resource` VALUES ('8', '42');
INSERT INTO `role_resource` VALUES ('8', '5');
INSERT INTO `role_resource` VALUES ('8', '13');
INSERT INTO `role_resource` VALUES ('8', '37');
INSERT INTO `role_resource` VALUES ('8', '6');
INSERT INTO `role_resource` VALUES ('8', '20');
INSERT INTO `role_resource` VALUES ('8', '44');
INSERT INTO `role_resource` VALUES ('7', '8');
INSERT INTO `role_resource` VALUES ('7', '22');
INSERT INTO `role_resource` VALUES ('7', '23');
INSERT INTO `role_resource` VALUES ('7', '24');
INSERT INTO `role_resource` VALUES ('7', '25');
INSERT INTO `role_resource` VALUES ('7', '9');
INSERT INTO `role_resource` VALUES ('7', '26');
INSERT INTO `role_resource` VALUES ('7', '27');
INSERT INTO `role_resource` VALUES ('7', '28');
INSERT INTO `role_resource` VALUES ('7', '29');
INSERT INTO `role_resource` VALUES ('7', '30');
INSERT INTO `role_resource` VALUES ('7', '11');
INSERT INTO `role_resource` VALUES ('7', '32');
INSERT INTO `role_resource` VALUES ('7', '33');
INSERT INTO `role_resource` VALUES ('7', '34');
INSERT INTO `role_resource` VALUES ('7', '35');
INSERT INTO `role_resource` VALUES ('7', '12');
INSERT INTO `role_resource` VALUES ('7', '14');
INSERT INTO `role_resource` VALUES ('7', '38');
INSERT INTO `role_resource` VALUES ('7', '15');
INSERT INTO `role_resource` VALUES ('7', '39');
INSERT INTO `role_resource` VALUES ('7', '16');
INSERT INTO `role_resource` VALUES ('7', '40');
INSERT INTO `role_resource` VALUES ('7', '19');
INSERT INTO `role_resource` VALUES ('7', '43');
INSERT INTO `role_resource` VALUES ('7', '4');
INSERT INTO `role_resource` VALUES ('7', '17');
INSERT INTO `role_resource` VALUES ('7', '41');
INSERT INTO `role_resource` VALUES ('7', '18');
INSERT INTO `role_resource` VALUES ('7', '42');
INSERT INTO `role_resource` VALUES ('7', '5');
INSERT INTO `role_resource` VALUES ('7', '13');
INSERT INTO `role_resource` VALUES ('7', '37');
INSERT INTO `role_resource` VALUES ('7', '6');
INSERT INTO `role_resource` VALUES ('7', '20');
INSERT INTO `role_resource` VALUES ('7', '44');
INSERT INTO `role_resource` VALUES ('6', '8');
INSERT INTO `role_resource` VALUES ('6', '22');
INSERT INTO `role_resource` VALUES ('6', '23');
INSERT INTO `role_resource` VALUES ('6', '24');
INSERT INTO `role_resource` VALUES ('6', '25');
INSERT INTO `role_resource` VALUES ('6', '9');
INSERT INTO `role_resource` VALUES ('6', '26');
INSERT INTO `role_resource` VALUES ('6', '27');
INSERT INTO `role_resource` VALUES ('6', '28');
INSERT INTO `role_resource` VALUES ('6', '29');
INSERT INTO `role_resource` VALUES ('6', '30');
INSERT INTO `role_resource` VALUES ('6', '32');
INSERT INTO `role_resource` VALUES ('6', '12');
INSERT INTO `role_resource` VALUES ('6', '14');
INSERT INTO `role_resource` VALUES ('6', '38');
INSERT INTO `role_resource` VALUES ('6', '15');
INSERT INTO `role_resource` VALUES ('6', '39');
INSERT INTO `role_resource` VALUES ('6', '16');
INSERT INTO `role_resource` VALUES ('6', '40');
INSERT INTO `role_resource` VALUES ('6', '19');
INSERT INTO `role_resource` VALUES ('6', '43');
INSERT INTO `role_resource` VALUES ('6', '4');
INSERT INTO `role_resource` VALUES ('6', '17');
INSERT INTO `role_resource` VALUES ('6', '41');
INSERT INTO `role_resource` VALUES ('6', '18');
INSERT INTO `role_resource` VALUES ('6', '42');
INSERT INTO `role_resource` VALUES ('6', '5');
INSERT INTO `role_resource` VALUES ('6', '13');
INSERT INTO `role_resource` VALUES ('6', '37');
INSERT INTO `role_resource` VALUES ('6', '6');
INSERT INTO `role_resource` VALUES ('6', '20');
INSERT INTO `role_resource` VALUES ('6', '44');
INSERT INTO `role_resource` VALUES ('5', '8');
INSERT INTO `role_resource` VALUES ('5', '22');
INSERT INTO `role_resource` VALUES ('5', '23');
INSERT INTO `role_resource` VALUES ('5', '24');
INSERT INTO `role_resource` VALUES ('5', '25');
INSERT INTO `role_resource` VALUES ('5', '9');
INSERT INTO `role_resource` VALUES ('5', '26');
INSERT INTO `role_resource` VALUES ('5', '27');
INSERT INTO `role_resource` VALUES ('5', '28');
INSERT INTO `role_resource` VALUES ('5', '29');
INSERT INTO `role_resource` VALUES ('5', '30');
INSERT INTO `role_resource` VALUES ('5', '32');
INSERT INTO `role_resource` VALUES ('5', '12');
INSERT INTO `role_resource` VALUES ('5', '45');
INSERT INTO `role_resource` VALUES ('5', '14');
INSERT INTO `role_resource` VALUES ('5', '38');
INSERT INTO `role_resource` VALUES ('5', '15');
INSERT INTO `role_resource` VALUES ('5', '39');
INSERT INTO `role_resource` VALUES ('5', '16');
INSERT INTO `role_resource` VALUES ('5', '40');
INSERT INTO `role_resource` VALUES ('5', '19');
INSERT INTO `role_resource` VALUES ('5', '43');
INSERT INTO `role_resource` VALUES ('5', '4');
INSERT INTO `role_resource` VALUES ('5', '17');
INSERT INTO `role_resource` VALUES ('5', '41');
INSERT INTO `role_resource` VALUES ('5', '18');
INSERT INTO `role_resource` VALUES ('5', '42');
INSERT INTO `role_resource` VALUES ('5', '5');
INSERT INTO `role_resource` VALUES ('5', '13');
INSERT INTO `role_resource` VALUES ('5', '37');
INSERT INTO `role_resource` VALUES ('5', '6');
INSERT INTO `role_resource` VALUES ('5', '20');
INSERT INTO `role_resource` VALUES ('5', '44');
INSERT INTO `role_resource` VALUES ('4', '8');
INSERT INTO `role_resource` VALUES ('4', '22');
INSERT INTO `role_resource` VALUES ('4', '23');
INSERT INTO `role_resource` VALUES ('4', '24');
INSERT INTO `role_resource` VALUES ('4', '25');
INSERT INTO `role_resource` VALUES ('4', '9');
INSERT INTO `role_resource` VALUES ('4', '26');
INSERT INTO `role_resource` VALUES ('4', '27');
INSERT INTO `role_resource` VALUES ('4', '28');
INSERT INTO `role_resource` VALUES ('4', '29');
INSERT INTO `role_resource` VALUES ('4', '30');
INSERT INTO `role_resource` VALUES ('4', '32');
INSERT INTO `role_resource` VALUES ('4', '12');
INSERT INTO `role_resource` VALUES ('4', '45');
INSERT INTO `role_resource` VALUES ('4', '14');
INSERT INTO `role_resource` VALUES ('4', '38');
INSERT INTO `role_resource` VALUES ('4', '15');
INSERT INTO `role_resource` VALUES ('4', '39');
INSERT INTO `role_resource` VALUES ('4', '16');
INSERT INTO `role_resource` VALUES ('4', '40');
INSERT INTO `role_resource` VALUES ('4', '19');
INSERT INTO `role_resource` VALUES ('4', '43');
INSERT INTO `role_resource` VALUES ('4', '4');
INSERT INTO `role_resource` VALUES ('4', '17');
INSERT INTO `role_resource` VALUES ('4', '41');
INSERT INTO `role_resource` VALUES ('4', '18');
INSERT INTO `role_resource` VALUES ('4', '42');
INSERT INTO `role_resource` VALUES ('4', '5');
INSERT INTO `role_resource` VALUES ('4', '13');
INSERT INTO `role_resource` VALUES ('4', '37');
INSERT INTO `role_resource` VALUES ('4', '6');
INSERT INTO `role_resource` VALUES ('4', '20');
INSERT INTO `role_resource` VALUES ('4', '44');
INSERT INTO `role_resource` VALUES ('1', '1');
INSERT INTO `role_resource` VALUES ('1', '2');
INSERT INTO `role_resource` VALUES ('1', '8');
INSERT INTO `role_resource` VALUES ('1', '22');
INSERT INTO `role_resource` VALUES ('1', '23');
INSERT INTO `role_resource` VALUES ('1', '24');
INSERT INTO `role_resource` VALUES ('1', '25');
INSERT INTO `role_resource` VALUES ('1', '9');
INSERT INTO `role_resource` VALUES ('1', '26');
INSERT INTO `role_resource` VALUES ('1', '27');
INSERT INTO `role_resource` VALUES ('1', '28');
INSERT INTO `role_resource` VALUES ('1', '29');
INSERT INTO `role_resource` VALUES ('1', '10');
INSERT INTO `role_resource` VALUES ('1', '30');
INSERT INTO `role_resource` VALUES ('1', '31');
INSERT INTO `role_resource` VALUES ('1', '11');
INSERT INTO `role_resource` VALUES ('1', '32');
INSERT INTO `role_resource` VALUES ('1', '35');
INSERT INTO `role_resource` VALUES ('1', '3');
INSERT INTO `role_resource` VALUES ('1', '7');
INSERT INTO `role_resource` VALUES ('1', '12');
INSERT INTO `role_resource` VALUES ('1', '21');
INSERT INTO `role_resource` VALUES ('1', '36');
INSERT INTO `role_resource` VALUES ('1', '45');
INSERT INTO `role_resource` VALUES ('1', '14');
INSERT INTO `role_resource` VALUES ('1', '38');
INSERT INTO `role_resource` VALUES ('1', '15');
INSERT INTO `role_resource` VALUES ('1', '39');
INSERT INTO `role_resource` VALUES ('1', '16');
INSERT INTO `role_resource` VALUES ('1', '40');
INSERT INTO `role_resource` VALUES ('1', '19');
INSERT INTO `role_resource` VALUES ('1', '43');
INSERT INTO `role_resource` VALUES ('1', '4');
INSERT INTO `role_resource` VALUES ('1', '17');
INSERT INTO `role_resource` VALUES ('1', '41');
INSERT INTO `role_resource` VALUES ('1', '18');
INSERT INTO `role_resource` VALUES ('1', '42');
INSERT INTO `role_resource` VALUES ('1', '57');
INSERT INTO `role_resource` VALUES ('1', '58');
INSERT INTO `role_resource` VALUES ('1', '59');
INSERT INTO `role_resource` VALUES ('1', '5');
INSERT INTO `role_resource` VALUES ('1', '13');
INSERT INTO `role_resource` VALUES ('1', '37');
INSERT INTO `role_resource` VALUES ('1', '6');
INSERT INTO `role_resource` VALUES ('1', '20');
INSERT INTO `role_resource` VALUES ('1', '44');
INSERT INTO `role_resource` VALUES ('1', '46');
INSERT INTO `role_resource` VALUES ('1', '47');
INSERT INTO `role_resource` VALUES ('1', '62');
INSERT INTO `role_resource` VALUES ('1', '63');
INSERT INTO `role_resource` VALUES ('1', '64');
INSERT INTO `role_resource` VALUES ('1', '48');
INSERT INTO `role_resource` VALUES ('1', '49');
INSERT INTO `role_resource` VALUES ('1', '53');
INSERT INTO `role_resource` VALUES ('1', '50');
INSERT INTO `role_resource` VALUES ('1', '54');
INSERT INTO `role_resource` VALUES ('1', '51');
INSERT INTO `role_resource` VALUES ('1', '55');
INSERT INTO `role_resource` VALUES ('1', '52');
INSERT INTO `role_resource` VALUES ('1', '56');
INSERT INTO `role_resource` VALUES ('1', '60');
INSERT INTO `role_resource` VALUES ('1', '61');
INSERT INTO `role_resource` VALUES ('1', '65');
INSERT INTO `role_resource` VALUES ('1', '66');
INSERT INTO `role_resource` VALUES ('1', '67');
INSERT INTO `role_resource` VALUES ('1', '68');
INSERT INTO `role_resource` VALUES ('1', '69');
INSERT INTO `role_resource` VALUES ('1', '70');
INSERT INTO `role_resource` VALUES ('1', '71');
INSERT INTO `role_resource` VALUES ('2', '1');
INSERT INTO `role_resource` VALUES ('2', '2');
INSERT INTO `role_resource` VALUES ('2', '8');
INSERT INTO `role_resource` VALUES ('2', '22');
INSERT INTO `role_resource` VALUES ('2', '23');
INSERT INTO `role_resource` VALUES ('2', '24');
INSERT INTO `role_resource` VALUES ('2', '25');
INSERT INTO `role_resource` VALUES ('2', '9');
INSERT INTO `role_resource` VALUES ('2', '26');
INSERT INTO `role_resource` VALUES ('2', '27');
INSERT INTO `role_resource` VALUES ('2', '28');
INSERT INTO `role_resource` VALUES ('2', '29');
INSERT INTO `role_resource` VALUES ('2', '10');
INSERT INTO `role_resource` VALUES ('2', '30');
INSERT INTO `role_resource` VALUES ('2', '31');
INSERT INTO `role_resource` VALUES ('2', '11');
INSERT INTO `role_resource` VALUES ('2', '32');
INSERT INTO `role_resource` VALUES ('2', '33');
INSERT INTO `role_resource` VALUES ('2', '34');
INSERT INTO `role_resource` VALUES ('2', '35');
INSERT INTO `role_resource` VALUES ('2', '3');
INSERT INTO `role_resource` VALUES ('2', '7');
INSERT INTO `role_resource` VALUES ('2', '12');
INSERT INTO `role_resource` VALUES ('2', '21');
INSERT INTO `role_resource` VALUES ('2', '36');
INSERT INTO `role_resource` VALUES ('2', '45');
INSERT INTO `role_resource` VALUES ('2', '14');
INSERT INTO `role_resource` VALUES ('2', '38');
INSERT INTO `role_resource` VALUES ('2', '15');
INSERT INTO `role_resource` VALUES ('2', '39');
INSERT INTO `role_resource` VALUES ('2', '16');
INSERT INTO `role_resource` VALUES ('2', '40');
INSERT INTO `role_resource` VALUES ('2', '19');
INSERT INTO `role_resource` VALUES ('2', '43');
INSERT INTO `role_resource` VALUES ('2', '4');
INSERT INTO `role_resource` VALUES ('2', '17');
INSERT INTO `role_resource` VALUES ('2', '41');
INSERT INTO `role_resource` VALUES ('2', '18');
INSERT INTO `role_resource` VALUES ('2', '42');
INSERT INTO `role_resource` VALUES ('2', '57');
INSERT INTO `role_resource` VALUES ('2', '58');
INSERT INTO `role_resource` VALUES ('2', '59');
INSERT INTO `role_resource` VALUES ('2', '5');
INSERT INTO `role_resource` VALUES ('2', '13');
INSERT INTO `role_resource` VALUES ('2', '37');
INSERT INTO `role_resource` VALUES ('2', '6');
INSERT INTO `role_resource` VALUES ('2', '20');
INSERT INTO `role_resource` VALUES ('2', '44');
INSERT INTO `role_resource` VALUES ('2', '46');
INSERT INTO `role_resource` VALUES ('2', '47');
INSERT INTO `role_resource` VALUES ('2', '62');
INSERT INTO `role_resource` VALUES ('2', '66');
INSERT INTO `role_resource` VALUES ('2', '63');
INSERT INTO `role_resource` VALUES ('2', '67');
INSERT INTO `role_resource` VALUES ('2', '64');
INSERT INTO `role_resource` VALUES ('2', '68');
INSERT INTO `role_resource` VALUES ('2', '48');
INSERT INTO `role_resource` VALUES ('2', '49');
INSERT INTO `role_resource` VALUES ('2', '53');
INSERT INTO `role_resource` VALUES ('2', '50');
INSERT INTO `role_resource` VALUES ('2', '54');
INSERT INTO `role_resource` VALUES ('2', '51');
INSERT INTO `role_resource` VALUES ('2', '55');
INSERT INTO `role_resource` VALUES ('2', '52');
INSERT INTO `role_resource` VALUES ('2', '56');
INSERT INTO `role_resource` VALUES ('2', '60');
INSERT INTO `role_resource` VALUES ('2', '61');
INSERT INTO `role_resource` VALUES ('2', '65');
INSERT INTO `role_resource` VALUES ('2', '69');
INSERT INTO `role_resource` VALUES ('2', '70');
INSERT INTO `role_resource` VALUES ('2', '71');
INSERT INTO `role_resource` VALUES ('3', '1');
INSERT INTO `role_resource` VALUES ('3', '2');
INSERT INTO `role_resource` VALUES ('3', '8');
INSERT INTO `role_resource` VALUES ('3', '22');
INSERT INTO `role_resource` VALUES ('3', '23');
INSERT INTO `role_resource` VALUES ('3', '24');
INSERT INTO `role_resource` VALUES ('3', '25');
INSERT INTO `role_resource` VALUES ('3', '9');
INSERT INTO `role_resource` VALUES ('3', '26');
INSERT INTO `role_resource` VALUES ('3', '27');
INSERT INTO `role_resource` VALUES ('3', '28');
INSERT INTO `role_resource` VALUES ('3', '29');
INSERT INTO `role_resource` VALUES ('3', '10');
INSERT INTO `role_resource` VALUES ('3', '30');
INSERT INTO `role_resource` VALUES ('3', '31');
INSERT INTO `role_resource` VALUES ('3', '11');
INSERT INTO `role_resource` VALUES ('3', '32');
INSERT INTO `role_resource` VALUES ('3', '33');
INSERT INTO `role_resource` VALUES ('3', '34');
INSERT INTO `role_resource` VALUES ('3', '35');
INSERT INTO `role_resource` VALUES ('3', '3');
INSERT INTO `role_resource` VALUES ('3', '7');
INSERT INTO `role_resource` VALUES ('3', '12');
INSERT INTO `role_resource` VALUES ('3', '21');
INSERT INTO `role_resource` VALUES ('3', '36');
INSERT INTO `role_resource` VALUES ('3', '45');
INSERT INTO `role_resource` VALUES ('3', '14');
INSERT INTO `role_resource` VALUES ('3', '38');
INSERT INTO `role_resource` VALUES ('3', '15');
INSERT INTO `role_resource` VALUES ('3', '39');
INSERT INTO `role_resource` VALUES ('3', '16');
INSERT INTO `role_resource` VALUES ('3', '40');
INSERT INTO `role_resource` VALUES ('3', '19');
INSERT INTO `role_resource` VALUES ('3', '43');
INSERT INTO `role_resource` VALUES ('3', '4');
INSERT INTO `role_resource` VALUES ('3', '17');
INSERT INTO `role_resource` VALUES ('3', '41');
INSERT INTO `role_resource` VALUES ('3', '18');
INSERT INTO `role_resource` VALUES ('3', '42');
INSERT INTO `role_resource` VALUES ('3', '57');
INSERT INTO `role_resource` VALUES ('3', '58');
INSERT INTO `role_resource` VALUES ('3', '59');
INSERT INTO `role_resource` VALUES ('3', '5');
INSERT INTO `role_resource` VALUES ('3', '13');
INSERT INTO `role_resource` VALUES ('3', '37');
INSERT INTO `role_resource` VALUES ('3', '6');
INSERT INTO `role_resource` VALUES ('3', '20');
INSERT INTO `role_resource` VALUES ('3', '44');
INSERT INTO `role_resource` VALUES ('3', '46');
INSERT INTO `role_resource` VALUES ('3', '47');
INSERT INTO `role_resource` VALUES ('3', '62');
INSERT INTO `role_resource` VALUES ('3', '66');
INSERT INTO `role_resource` VALUES ('3', '63');
INSERT INTO `role_resource` VALUES ('3', '67');
INSERT INTO `role_resource` VALUES ('3', '64');
INSERT INTO `role_resource` VALUES ('3', '68');
INSERT INTO `role_resource` VALUES ('3', '48');
INSERT INTO `role_resource` VALUES ('3', '49');
INSERT INTO `role_resource` VALUES ('3', '53');
INSERT INTO `role_resource` VALUES ('3', '50');
INSERT INTO `role_resource` VALUES ('3', '54');
INSERT INTO `role_resource` VALUES ('3', '51');
INSERT INTO `role_resource` VALUES ('3', '55');
INSERT INTO `role_resource` VALUES ('3', '52');
INSERT INTO `role_resource` VALUES ('3', '56');
INSERT INTO `role_resource` VALUES ('3', '60');
INSERT INTO `role_resource` VALUES ('3', '61');
INSERT INTO `role_resource` VALUES ('3', '65');
INSERT INTO `role_resource` VALUES ('3', '69');
INSERT INTO `role_resource` VALUES ('3', '70');
INSERT INTO `role_resource` VALUES ('3', '71');
INSERT INTO `role_resource` VALUES ('1', '72');
INSERT INTO `role_resource` VALUES ('1', '73');
INSERT INTO `role_resource` VALUES ('1', '33');
INSERT INTO `role_resource` VALUES ('1', '34');
INSERT INTO `role_resource` VALUES ('1', '74');

-- ----------------------------
-- Table structure for salary_base_rule
-- ----------------------------
DROP TABLE IF EXISTS `salary_base_rule`;
CREATE TABLE `salary_base_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '底薪规则ID',
  `post` varchar(30) NOT NULL COMMENT '岗位',
  `base` float(20,2) NOT NULL DEFAULT '0.00' COMMENT '底薪基数',
  `base_level` int(2) DEFAULT '0' COMMENT '底薪档位',
  `float_base` float(20,2) DEFAULT '0.00' COMMENT '浮动绩效基数',
  `float_proportion` varchar(20) DEFAULT '0,0,0' COMMENT '浮动绩效计提比例',
  `float_completion_rate` varchar(20) DEFAULT '0,0,0' COMMENT '个人销售计划完成率(与浮动绩效计提比例相匹配)',
  `percentage_complete` float(20,2) DEFAULT '0.00' COMMENT '销售提成（完成销售计划）',
  `percentage_incomplete` float(20,2) DEFAULT '0.00' COMMENT '销售提成（未完成销售计划）',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of salary_base_rule
-- ----------------------------

-- ----------------------------
-- Table structure for sale_plan
-- ----------------------------
DROP TABLE IF EXISTS `sale_plan`;
CREATE TABLE `sale_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(11) DEFAULT NULL COMMENT '业务员id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '业务员',
  `plan_year` int(11) DEFAULT NULL COMMENT '计划年',
  `plan_month` int(11) DEFAULT NULL COMMENT '计划月',
  `plan_amt` decimal(10,3) DEFAULT NULL COMMENT '销售计划',
  `created_by` varchar(20) DEFAULT NULL COMMENT '记录创建人',
  `created_at` datetime DEFAULT NULL COMMENT '记录创建时间',
  `updated_by` varchar(20) DEFAULT NULL COMMENT '记录创建人',
  `updated_at` datetime DEFAULT NULL COMMENT '最近修改时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(4) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sale_plan
-- ----------------------------
INSERT INTO `sale_plan` VALUES ('41', '1', '薛爱洁', '2018', '3', '400000.000', 'system', '2018-02-01 18:06:46', 'system', '2018-02-01 18:06:46', null, '0');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL COMMENT '用户名',
  `ip` varchar(20) DEFAULT NULL COMMENT 'ip',
  `page_name` varchar(50) NOT NULL COMMENT '页面名称',
  `event_name` varchar(50) NOT NULL COMMENT '事件名称',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统日志表';

-- ----------------------------
-- Records of sys_log
-- ----------------------------

-- ----------------------------
-- Table structure for user_department
-- ----------------------------
DROP TABLE IF EXISTS `user_department`;
CREATE TABLE `user_department` (
  `user_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户部门表';

-- ----------------------------
-- Records of user_department
-- ----------------------------
INSERT INTO `user_department` VALUES ('4', '2');
INSERT INTO `user_department` VALUES ('5', '2');
INSERT INTO `user_department` VALUES ('6', '2');
INSERT INTO `user_department` VALUES ('7', '2');
INSERT INTO `user_department` VALUES ('8', '2');
INSERT INTO `user_department` VALUES ('9', '2');
INSERT INTO `user_department` VALUES ('10', '3');
INSERT INTO `user_department` VALUES ('11', '3');
INSERT INTO `user_department` VALUES ('12', '3');

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态 0:申请中  1:正常  -1:冻结',
  `sex` varchar(4) DEFAULT '男' COMMENT '性别 男  女  其他',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `nick_name` varchar(50) DEFAULT NULL COMMENT '昵称',
  `birthday` datetime DEFAULT '1900-00-00 00:00:00' COMMENT '生日',
  `identity_no` varchar(25) DEFAULT NULL COMMENT '身份证号',
  `address` varchar(200) DEFAULT NULL COMMENT '家庭住址',
  `parent_id` int(11) DEFAULT NULL COMMENT '直线上级id',
  `parent_nick_name` varchar(50) DEFAULT NULL COMMENT '直线上级昵称',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('1', 'admin', '21232f297a57a5a743894a0e4a801fc3', '1', '男', '18777777777', '123@163.com', '系统管理员', '2017-12-07 08:02:18', '370251198812065541', '山东省青岛市东海路9号', null, null, '2017-12-06 01:41:53', '2017-12-16 14:34:53', 'system', 'system', null, '0');
INSERT INTO `user_info` VALUES ('4', '18605326326', '439108fe0c659248246293b3b1470d5e', '1', '男', '18605326326', '', '周武伟', '1976-01-06 00:00:00', '210422197601062532', '山东省青岛市城阳区', null, null, '2017-12-11 01:13:51', '2017-12-11 01:29:03', 'system', 'system', null, '0');
INSERT INTO `user_info` VALUES ('5', '18661673768', 'c0aad4406df850bc8e7ce60a28f4bc2c', '1', '男', '18661673768', '', '李朋', '1974-08-19 00:00:00', '372801197408190619', '山东省青岛市李沧区', null, null, '2017-12-11 01:14:36', '2017-12-11 01:29:23', 'system', 'system', null, '0');
INSERT INTO `user_info` VALUES ('6', '18753288588', 'cb5040364ec4bbb878bba449d0b13e1b', '1', '男', '18753288588', '', '王艳军', '1980-04-29 00:00:00', '370724198004294317', '山东省青岛市城阳区', null, null, '2017-12-11 01:15:19', '2017-12-11 01:29:39', 'system', 'system', null, '0');
INSERT INTO `user_info` VALUES ('7', '15318789168', '383e8798132333f59a4ac9e19063347d', '1', '男', '15318789168', '', '张雷', '1981-04-17 00:00:00', '230103198104171917', '山东省青岛市市北区', null, null, '2017-12-11 01:16:04', '2017-12-11 01:29:53', 'system', 'system', null, '0');
INSERT INTO `user_info` VALUES ('8', '15166656233', '69a976b284d3b63885db6c7f0d2f2f2f', '1', '男', '15166656233', '', '高思铖', '1994-09-27 00:00:00', '370214199409276517', '山东省青岛市高新区', null, null, '2017-12-11 01:16:48', '2017-12-11 01:30:10', 'system', 'system', null, '0');
INSERT INTO `user_info` VALUES ('9', '13326398799', '9fb2af2874a891631e0c544b7af09bc7', '1', '女', '13326398799', '', '薛爱洁', '1965-03-01 00:00:00', '370205196503015022', '山东省青岛市崂山区', null, null, '2017-12-11 01:17:33', '2017-12-11 01:30:31', 'system', 'system', null, '0');
INSERT INTO `user_info` VALUES ('10', '18766236145', '4c5bd40725bd1c2a799a6fd65cdf44e5', '1', '女', '18766236145', '', '张财霞', '1992-12-05 00:00:00', '371122199212050341', '山东省日照市莒县', null, null, '2017-12-11 01:18:17', '2017-12-11 01:30:53', 'system', 'system', null, '0');
INSERT INTO `user_info` VALUES ('11', '17862865221', 'b8d45eb323ee50867ff400a558893c85', '1', '男', '17862865221', '', '艾宇', '1994-03-14 00:00:00', '370602199403141319', '高新区招商海德花园 ', null, null, '2017-12-11 01:19:03', '2017-12-11 01:31:07', 'system', 'system', null, '0');
INSERT INTO `user_info` VALUES ('12', '13326390719', '9ffd0ee89a94894c0b7a529d8b506e5e', '1', '女', '13326390719', '', '王小雪', '1991-05-13 00:00:00', '371328199105131022', '山东省青岛市城阳区', '11', '艾宇', '2017-12-11 01:19:48', '2017-12-12 18:47:45', 'system', 'system', null, '0');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色表';

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('1', '1');
INSERT INTO `user_role` VALUES ('4', '2');
INSERT INTO `user_role` VALUES ('5', '3');
INSERT INTO `user_role` VALUES ('6', '4');
INSERT INTO `user_role` VALUES ('7', '4');
INSERT INTO `user_role` VALUES ('8', '5');
INSERT INTO `user_role` VALUES ('9', '5');
INSERT INTO `user_role` VALUES ('10', '6');
INSERT INTO `user_role` VALUES ('11', '7');
INSERT INTO `user_role` VALUES ('12', '8');
