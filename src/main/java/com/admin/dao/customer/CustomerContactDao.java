package com.admin.dao.customer;

import com.admin.dao.BaseDao;
import com.admin.entity.customer.CustomerContact;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by GaoJingFei on 2017/11/17.
 */
@Repository
public class CustomerContactDao extends BaseDao{
    public CustomerContact getById(Long id){
        return this.getSqlSession().selectOne(namespace+"getById", id);
    }

    public List<CustomerContact> getByCustomerId(Long customerId){
        return this.getSqlSession().selectList(namespace + "getByCustomerId", customerId);
    }

    public List<CustomerContact> queryListBy(Map<String, Object> params){
        return this.getSqlSession().selectList(namespace+"queryListBy", params);
    }

    public Integer queryCountBy(Map<String, Object> params){
        return this.getSqlSession().selectOne(namespace+"queryCountBy", params);
    }

    //新增
    public Integer insert(CustomerContact customerContact){
        return this.getSqlSession().insert(namespace+"insert", customerContact);
    }

    //更新
    public Integer update(CustomerContact customerContact){
        return this.getSqlSession().update(namespace+"update", customerContact);
    }

    //根据客户id 和客户联系人类别更新
    public Integer updateByType(CustomerContact customerContact){
        return this.getSqlSession().update(namespace+"updateByType", customerContact);
    }
}