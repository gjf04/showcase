package com.admin.entity.system;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.admin.entity.BaseEntity;

/**
 * 用户角色实体类
 * Created by GaoJingFei on 2017/11/13.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class UserRole  extends BaseEntity{
    /**
	 * 
	 */
	private static final long serialVersionUID = 6652498176594348711L;

	private Long userId;

    private Long roleId;

}