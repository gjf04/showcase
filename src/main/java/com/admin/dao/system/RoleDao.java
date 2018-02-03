package com.admin.dao.system;

import com.admin.dao.BaseDao;
import com.admin.entity.system.Department;
import com.admin.entity.system.Role;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by GaoJingFei on 2017/11/17.
 */
@Repository
public class RoleDao   extends BaseDao{

    public Role getByName(String name){
        return this.getSqlSession().selectOne(namespace+"getByName", name);
    }

    public List<Role> getRoleList(Map<String, Object> paramMap){
        return this.getSqlSession().selectList(namespace + "getRoleList", paramMap);
    }

    public Integer getRoleListCount(Map<String, Object> params){
        return this.getSqlSession().selectOne(namespace+"getRoleListCount", params);
    }

    public Integer insert(Role role){
        return this.getSqlSession().insert(namespace + "insert", role);
    }

    /**
     * 获取所有
     *
     */
    public List<Role> getAll(){
        return this.getSqlSession().selectList(namespace+"getAll");
    }

    /**
     * 获取用户的角色信息
     * @param userId
     * @return
     */
    public List<Role> getUserRoles(Long userId){
        return this.getSqlSession().selectList(namespace+"getUserRoles", userId);
    }
}