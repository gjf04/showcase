package com.admin.entity.customer;

import com.admin.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 客户实体类
 * Created by GaoJingFei on 2017/11/13.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class Customer extends BaseEntity{
    /**
	 * 
	 */
	private static final long serialVersionUID = -1228505501747126397L;

	private String customerCode;

    private String customerName;

    private String typeCode;

    private String typeName;

    private String phone;

    private String fax;

    private String address;

    private String url;

    //private String corporate;

    private String manager;

    private String contact;

    private String dockDepartment;

    private String dockPerson;

    private String dockContact;

    private String relateDepartment;

    private String relatePerson;

    private String relateContact;

    private String responsiblePerson;

    private Integer responsiblePersonId;

    private String assistPerson;

    private Integer assistPersonId;

    private CustomerContact electric;//设备用电管理人

    private CustomerContact water;//建筑消防用水

    private CustomerContact safe;//安全巡检

    private CustomerContact visual;//可视化监管

    private CustomerContact emergency;//紧急联系人

    private Integer status;//客户状态 1：申请中 2：审核通过 3：审核不通过

    private Integer draft;//是否草稿 1:是   0:否

}