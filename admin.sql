--admin system CREATE TABLE sql
--2017-11-16

-- system begin--
-- DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code`	varchar(20) NOT NULL COMMENT '编码',
  `name`	varchar(50) NOT NULL COMMENT '名称',
  `description`	varchar(200) DEFAULT NULL COMMENT '描述',
  `parent_id`   int(11) NOT NULL COMMENT '上级部门id',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='部门表';

-- DROP TABLE IF EXISTS `resource_info`;
CREATE TABLE `resource_info`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code`	varchar(20) NOT NULL COMMENT '编码',
  `name`	varchar(50) NOT NULL COMMENT '名称',
  `description`	varchar(200) NOT NULL COMMENT '描述',
  `url`	varchar(200) NOT NULL COMMENT '访问路径',
  `type` tinyint(2) DEFAULT '0' COMMENT '类别 0:模块 1:页面  2:按钮',
  `order_index` int(4) DEFAULT '0' COMMENT '顺序',
  `parent_id`   int(11) NOT NULL COMMENT '上级资源id',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='资源表';

-- DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code`	varchar(20) NOT NULL COMMENT '编码',
  `name`	varchar(50) NOT NULL COMMENT '名称',
  `description`	varchar(200) NOT NULL COMMENT '描述',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- DROP TABLE IF EXISTS `role_resource`;
CREATE TABLE `role_resource`
(
  role_id   int(11) NOT NULL,
  resource_id  int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色资源表';

-- DROP TABLE IF EXISTS `user_department`;
CREATE TABLE `user_department`
(
  user_id   int(11) NOT NULL,
  department_id int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户部门表';

-- DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name`	varchar(50) NOT NULL COMMENT '用户名',
  `password`	varchar(50) NOT NULL COMMENT '密码',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态 0:申请中  1:正常  -1:冻结',
  `sex` varchar(4) DEFAULT '男' COMMENT '性别 男  女  其他',
  `mobile`	varchar(20) DEFAULT NULL COMMENT '手机',
  `email`	varchar(50) DEFAULT NULL COMMENT '邮箱',
  `nick_name`	varchar(50) DEFAULT NULL COMMENT '昵称',
  `birthday` datetime NOT NULL COMMENT '生日',
  `identity_no`	varchar(25) DEFAULT NULL COMMENT '身份证号',
  `address`	varchar(200) DEFAULT NULL COMMENT '家庭住址',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`
(
  user_id int(11) NOT NULL,
  role_id int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色表';

-- DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name`	varchar(50) NOT NULL COMMENT '用户名',
  `ip`	varchar(20) DEFAULT NULL COMMENT 'ip',
  `page_name`	varchar(50) NOT NULL COMMENT '页面名称',
  `event_name`	varchar(50) NOT NULL COMMENT '事件名称',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='系统日志表';

-- DROP TABLE IF EXISTS `attachment`;
CREATE TABLE `attachment`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_code`	varchar(20) NOT NULL COMMENT '文件编码',
  `file_name`	varchar(50) NOT NULL COMMENT '文件名称',
  `file_type` tinyint(2) DEFAULT '1' COMMENT '文件类别 1:合同  2:勘察报告  3:安装验收报告',
  `relate_id`	int(11) DEFAULT NULL COMMENT '关联id，比如合同id、勘查报告id、安装验收报告id',
  `url`	varchar(200) NOT NULL COMMENT '访问路径',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='系统附件表';

-- DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_at` datetime NOT NULL COMMENT '开始时间',
  `end_at` datetime NOT NULL COMMENT '结束时间',
  `title`	varchar(50) NOT NULL COMMENT '标题',
  `content` varchar(512) DEFAULT NULL COMMENT '内容',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='公告表';
-- system end--

--admin系统业务表 begin--
--客户主数据
-- DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_code`	varchar(20) DEFAULT NULL COMMENT '客户编码',
  `customer_name`	varchar(50) NOT NULL COMMENT '客户名称',
  `type_code`	varchar(20) DEFAULT NULL COMMENT '所属行业编码',
  `type_name`	varchar(50) DEFAULT NULL COMMENT '所属行业名称',
  `phone`	varchar(50) DEFAULT NULL COMMENT '电话',
  `fax`	varchar(50) DEFAULT NULL COMMENT '传真',
  `address`	varchar(100) DEFAULT NULL COMMENT '地址',
  `url`	varchar(50) DEFAULT NULL COMMENT '网址',
  `manager`	varchar(50) DEFAULT NULL COMMENT '公司法人或总经理',
  `contact`	varchar(50) DEFAULT NULL COMMENT '联系方式',
  `dock_department`	varchar(50) DEFAULT NULL COMMENT '对接部门',
  `dock_person`	varchar(50) DEFAULT NULL COMMENT '对接部门联系人',
  `dock_contact`	varchar(50) DEFAULT NULL COMMENT '对接部门联系方式',
  `relate_department`	varchar(50) DEFAULT NULL COMMENT '关联部门',
  `relate_person`	varchar(50) DEFAULT NULL COMMENT '关联部门联系人',
  `relate_contact`	varchar(50) DEFAULT NULL COMMENT '关联部门联系方式',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
  `responsible_person`	varchar(50) DEFAULT NULL COMMENT '负责人',
  `responsible_person_id`	int(11) DEFAULT NULL COMMENT '负责人id',
  `assist_person`	varchar(50) DEFAULT NULL COMMENT '协助人',
  `assist_person_id`	int(11) DEFAULT NULL COMMENT '协助人id',
  `status` tinyint(2) DEFAULT '1' COMMENT '客户状态 1：申请中 2：审核通过 3：审核不通过',
  `draft` tinyint(1) DEFAULT '0' COMMENT '是否草稿 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='客户表';

--客户联系人
-- DROP TABLE IF EXISTS `customer_contact`;
CREATE TABLE `customer_contact`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id`	int(11) NOT NULL COMMENT '客户id',
  `customer_code`	varchar(20) DEFAULT NULL COMMENT '客户编码',
  `customer_name`	varchar(50) NOT NULL COMMENT '客户名称',
  `type`	varchar(20) NOT NULL COMMENT '类别：设备用电管理人、建筑消防用水、安全巡检、可视化监管、紧急联系人',
  `contact_name`	varchar(50) NOT NULL COMMENT '姓名',
  `contact_post`	varchar(50) DEFAULT NULL COMMENT '职务',
  `mobile`	varchar(50) DEFAULT NULL COMMENT '手机',
  `phone`	varchar(50) DEFAULT NULL COMMENT '电话',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='客户联系人表';

--客户反馈
-- DROP TABLE IF EXISTS `customer_feedback`;
CREATE TABLE `customer_feedback`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id`	int(11) NOT NULL COMMENT '客户id',
  `customer_code`	varchar(20) DEFAULT NULL COMMENT '客户编码',
  `customer_name`	varchar(50) NOT NULL COMMENT '客户名称',
  `responsible_person`	varchar(50) DEFAULT NULL COMMENT '负责人',
  `responsible_person_id`	int(11) DEFAULT NULL COMMENT '负责人id',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='客户反馈表';

--订单
-- DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(20) NOT NULL COMMENT '订单编号',
  `customer_code`	varchar(20) DEFAULT NULL COMMENT '客户编码',
  `customer_name`	varchar(50) NOT NULL COMMENT '客户名称',
  `agree_sn` varchar(50) NOT NULL COMMENT '合同编号',
  `approval_status` tinyint(2) COMMENT '合同状态。0已保存待提交 1待内勤初审 2总监审核 3合同上传 4签订完成',
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='订单表';

--订单跟进反馈
-- DROP TABLE IF EXISTS `order_feedback`;
CREATE TABLE `order_feedback`
(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id`	int(11) NOT NULL COMMENT '订单id',
  `customer_id`	int(11) NOT NULL COMMENT '客户id',
  `customer_code`	varchar(20) DEFAULT NULL COMMENT '客户编码',
  `customer_name`	varchar(50) NOT NULL COMMENT '客户名称',
  `responsible_person`	varchar(50) DEFAULT NULL COMMENT '负责人',
  `responsible_person_id`	int(11) DEFAULT NULL COMMENT '负责人id',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `created_at` datetime NOT NULL COMMENT '创建时间',
  `updated_at` datetime NOT NULL COMMENT '最近更新时间',
  `created_by` varchar(20) NOT NULL COMMENT '创建人',
  `updated_by` varchar(20) NOT NULL COMMENT '最近更新人',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除 1:是   0:否',
PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='订单跟进反馈表';

-- 底薪设置表 start --
CREATE TABLE `salary_base_rule` (
`id`  int(11) NOT NULL AUTO_INCREMENT COMMENT '底薪规则ID' ,
`post`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位' ,
`base`  float(20,2) NOT NULL DEFAULT 0 COMMENT '底薪基数' ,
`base_level`  int(2) NULL DEFAULT 0 COMMENT '底薪档位' ,
`float_base`  float(20,2) NULL DEFAULT 0 COMMENT '浮动绩效基数' ,
`float_proportion`  varchar(20) NULL DEFAULT '0,0,0' COMMENT '浮动绩效计提比例' ,
`float_completion_rate`  varchar(20) NULL DEFAULT '0,0,0' COMMENT '个人销售计划完成率(与浮动绩效计提比例相匹配)' ,
`percentage_complete`  float(20,2) NULL DEFAULT 0 COMMENT '销售提成（完成销售计划）' ,
`percentage_incomplete`  float(20,2) NULL DEFAULT 0 COMMENT '销售提成（未完成销售计划）' ,
`created_at`  datetime NOT NULL COMMENT '创建时间' ,
`updated_at`  datetime NOT NULL COMMENT '最近更新时间' ,
`created_by`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人' ,
`updated_by`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '最近更新人' ,
`remark`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注' ,
`is_delete`  tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 1:是   0:否' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=3
ROW_FORMAT=DYNAMIC
;
-- 底薪设置表 end --

-- 考评激励 --
CREATE TABLE `appraisal` (
`id`  int(11) NOT NULL AUTO_INCREMENT COMMENT '主键' ,
`user_id`  int(11) NULL DEFAULT NULL ,
`user_name`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名' ,
`item_ids`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '考评项id集合,逗号隔开' ,
`item_scores`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '考评项得分集合，逗号隔开' ,
`score`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '得分' ,
`year`  int(4) NULL DEFAULT 2018 COMMENT '年份' ,
`month`  int(2) NULL DEFAULT 1 COMMENT '月份' ,
`created_at`  datetime NOT NULL COMMENT '创建时间' ,
`updated_at`  datetime NOT NULL COMMENT '最近更新时间' ,
`created_by`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人' ,
`updated_by`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '最近更新人' ,
`remark`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注' ,
`is_delete`  tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 1:是   0:否' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1
ROW_FORMAT=DYNAMIC
;

CREATE TABLE `appraisal_item` (
`id`  int(3) NOT NULL AUTO_INCREMENT COMMENT '考评项ID' ,
`name`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '考评项' ,
`weight`  int(10) NULL DEFAULT 0 COMMENT '权重' ,
`created_at`  datetime NOT NULL COMMENT '创建时间' ,
`updated_at`  datetime NOT NULL COMMENT '最近更新时间' ,
`created_by`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建人' ,
`updated_by`  varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '最近更新人' ,
`remark`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注' ,
`is_delete`  tinyint(1) NULL DEFAULT 0 COMMENT '是否删除 1:是   0:否' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=5
ROW_FORMAT=DYNAMIC
;

INSERT INTO `resource_info` VALUES (33, '100133', '晋升管理', '晋升管理', '#', 0, 33, 1, '2018-1-4 18:07:50', '2018-1-4 18:07:57', 'admin', 'admin', NULL, 0);
INSERT INTO `resource_info` VALUES (34, '100133101', '考评激励', '考评激励', '/appraisal//appraisal.html', 1, 34, 33, '2018-1-4 18:10:53', '2018-1-4 18:10:56', 'admin', 'admin', NULL, 0);
INSERT INTO `role_resource` VALUES (1, 33);
INSERT INTO `role_resource` VALUES (1, 34);
INSERT INTO `appraisal_item` VALUES (1, '合同金额', 25, '2018-1-4 17:15:01', '2018-1-4 17:15:04', 'admin', 'admin', NULL, 0);
INSERT INTO `appraisal_item` VALUES (2, '回款金额', 25, '2018-1-4 17:15:50', '2018-1-4 17:15:53', 'admin', 'admin', NULL, 0);
INSERT INTO `appraisal_item` VALUES (3, '计划完成率', 30, '2018-1-4 17:16:23', '2018-1-4 17:16:26', 'admin', 'admin', NULL, 0);
INSERT INTO `appraisal_item` VALUES (4, '日常工作考核', 20, '2018-1-4 17:16:57', '2018-1-4 17:17:01', 'admin', 'admin', NULL, 0);

--admin系统业务表 end--

