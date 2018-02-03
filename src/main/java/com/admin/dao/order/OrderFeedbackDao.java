package com.admin.dao.order;

import com.admin.dao.BaseDao;
import com.admin.entity.order.OrderFeedback;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by GaoJingFei on 2017/11/17.
 */
@Repository
public class OrderFeedbackDao extends BaseDao{
    public OrderFeedback getById(Long id){
        return this.getSqlSession().selectOne(namespace+"getById", id);
    }

    public List<OrderFeedback> queryListBy(Map<String, Object> params){
        return this.getSqlSession().selectList(namespace+"queryListBy", params);
    }

    public Integer queryCountBy(Map<String, Object> params){
        return this.getSqlSession().selectOne(namespace+"queryCountBy", params);
    }

    //新增
    public Integer insert(OrderFeedback orderFeedback){
        return this.getSqlSession().insert(namespace+"insert", orderFeedback);
    }

    //更新
    public Integer update(OrderFeedback orderFeedback){
        return this.getSqlSession().update(namespace+"update", orderFeedback);
    }
}