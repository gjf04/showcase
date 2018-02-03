package com.admin.dao.system;

import com.admin.dao.BaseDao;
import com.admin.entity.system.UserDepartment;
import org.springframework.stereotype.Repository;

/**
 * Created by GaoJingFei on 2017/11/17.
 */
@Repository
public class UserDepartmentDao   extends BaseDao{
    public Integer insert(UserDepartment userDepartment){
        return this.getSqlSession().insert(namespace + "insert", userDepartment);
    }

    public Integer deleteByUserId(Long userId){
        return this.getSqlSession().delete(namespace + "deleteByUserId", userId);
    }
}