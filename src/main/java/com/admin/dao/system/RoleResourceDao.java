package com.admin.dao.system;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.admin.dao.BaseDao;
import com.admin.entity.system.Role;
import com.admin.entity.system.RoleResource;

/**
 * Created by GaoJingFei on 2017/11/17.
 */
@Repository
public class RoleResourceDao   extends BaseDao{
	

	public List<RoleResource> selectAllByRoleId(Long roleId){
		return this.getSqlSession().selectList(namespace + "selectAllByRoleId", roleId);
	}
	
    public Integer insert(RoleResource roleResource){
        return this.getSqlSession().insert(namespace + "insert", roleResource);
    }
    
    public Integer deleteByRoleId(Long roleId){
    	return this.getSqlSession().delete(namespace + "deleteByRoleId", roleId);
    }
}