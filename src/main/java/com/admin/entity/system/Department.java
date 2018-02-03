package com.admin.entity.system;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.admin.entity.BaseEntity;

/**
 * 部门实体类
 * Created by GaoJingFei on 2017/11/13.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class Department extends BaseEntity {

    /**
	 * 
	 */
	private static final long serialVersionUID = 3628838287611717188L;

	private String code;

    private String name;

    private Long principalUserId;

    private String principalNickName;

    private String description;

    private Department parent;

}