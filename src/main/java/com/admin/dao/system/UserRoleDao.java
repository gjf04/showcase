package com.admin.dao.system;

import com.admin.dao.BaseDao;
import com.admin.entity.system.RoleResource;
import com.admin.entity.system.UserRole;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by GaoJingFei on 2017/11/17.
 */
@Repository
public class UserRoleDao   extends BaseDao{
    public List<UserRole> getByUserId(Long userId){
        return this.getSqlSession().selectList(namespace + "getByUserId", userId);
    }

    public Integer insert(UserRole userRole){
        return this.getSqlSession().insert(namespace + "insert", userRole);
    }

    public Integer deleteByUserId(Long userId){
        return this.getSqlSession().delete(namespace + "deleteByUserId", userId);
    }
}