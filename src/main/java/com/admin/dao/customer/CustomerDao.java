package com.admin.dao.customer;

import com.admin.dao.BaseDao;
import com.admin.entity.customer.Customer;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by GaoJingFei on 2017/11/17.
 */
@Repository
public class CustomerDao extends BaseDao{
    public Customer getById(Long id){
        return this.getSqlSession().selectOne(namespace+"getById", id);
    }

    public List<Customer> queryListBy(Map<String, Object> params){
        return this.getSqlSession().selectList(namespace+"queryListBy", params);
    }

    public Integer queryCountBy(Map<String, Object> params){
        return this.getSqlSession().selectOne(namespace+"queryCountBy", params);
    }

    //新增
    public Integer insert(Customer customer){
        return this.getSqlSession().insert(namespace+"insert", customer);
    }

    //更新
    public Integer update(Customer customer){
        return this.getSqlSession().update(namespace+"update", customer);
    }

    //移入公海
    public Integer updateToOpenSea(Customer customer){
        return this.getSqlSession().update(namespace+"updateToOpenSea", customer);
    }
}