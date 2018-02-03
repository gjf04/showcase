package com.admin.dao.customer;

import com.admin.dao.BaseDao;
import com.admin.entity.customer.Customer;
import com.admin.entity.customer.CustomerFeedback;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by GaoJingFei on 2017/11/17.
 */
@Repository
public class CustomerFeedbackDao extends BaseDao{
    public CustomerFeedback getById(Long id){
        return this.getSqlSession().selectOne(namespace+"getById", id);
    }

    public List<CustomerFeedback> queryListBy(Map<String, Object> params){
        return this.getSqlSession().selectList(namespace+"queryListBy", params);
    }

    public Integer queryCountBy(Map<String, Object> params){
        return this.getSqlSession().selectOne(namespace+"queryCountBy", params);
    }

    //新增
    public Integer insert(CustomerFeedback customerFeedback){
        return this.getSqlSession().insert(namespace+"insert", customerFeedback);
    }

    //更新
    public Integer update(CustomerFeedback customerFeedback){
        return this.getSqlSession().update(namespace+"update", customerFeedback);
    }
}