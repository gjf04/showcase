package com.admin.dao.system;

import com.admin.entity.system.UserInfo;
import org.springframework.stereotype.Repository;

import com.admin.dao.BaseDao;

import java.util.List;
import java.util.Map;

/**
 * Created by GaoJingFei on 2017/11/17.
 */
@Repository
public class UserInfoDao   extends BaseDao{
    public UserInfo getById(Long id){
        return this.getSqlSession().selectOne(namespace+"getById", id);
    }

    public UserInfo getByUserName(String userName){
        return this.getSqlSession().selectOne(namespace+"getByUserName", userName);
    }

    public List<UserInfo> queryListBy(Map<String, Object> params){
        return this.getSqlSession().selectList(namespace+"queryListBy", params);
    }

    public Integer queryCountBy(Map<String, Object> params){
        return this.getSqlSession().selectOne(namespace+"queryCountBy", params);
    }

    //新增
    public Integer insert(UserInfo userInfo){
        return this.getSqlSession().insert(namespace+"insert", userInfo);
    }

    //更新
    public Integer update(UserInfo userInfo){
        return this.getSqlSession().update(namespace+"update", userInfo);
    }

    public List<UserInfo> getAll(){
        return this.getSqlSession().selectList(namespace+"getAll");
    }

    public List<UserInfo> getUserByRoleId(Long roleId){
        return this.getSqlSession().selectList(namespace+"getUserByRoleId", roleId);
    }
}