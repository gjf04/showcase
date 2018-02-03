package com.admin.dao.order;

import com.admin.dao.BaseDao;
import com.admin.entity.order.Orders;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by GaoJingFei on 2017/12/12.
 */
@Repository
public class OrdersDao extends BaseDao {
    public Orders getById(Long id){
        return this.getSqlSession().selectOne(namespace+"getById", id);
    }

    public List<Orders> queryListBy(Map<String, Object> params){
        return this.getSqlSession().selectList(namespace+"queryListBy", params);
    }

    public Integer queryCountBy(Map<String, Object> params){
        return this.getSqlSession().selectOne(namespace+"queryCountBy", params);
    }

    //新增
    public Integer insert(Orders orders){
        return this.getSqlSession().insert(namespace+"insert", orders);
    }

    //更新
    public Integer update(Orders orders){
        return this.getSqlSession().update(namespace+"update", orders);
    }
}