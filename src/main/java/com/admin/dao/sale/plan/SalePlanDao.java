package com.admin.dao.sale.plan;

import com.admin.dao.BaseDao;
import com.admin.entity.sale.plan.SalePlan;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 销售计划DAO接口
 * @author WangDeYu
 * @version 2017-12-20
 */
@Repository
public class SalePlanDao  extends BaseDao {
    public SalePlan getById(Long id){
        return this.getSqlSession().selectOne(namespace+"getById", id);
    }

    public List<SalePlan> queryListBy(Map<String, Object> params){
        return this.getSqlSession().selectList(namespace+"queryListBy", params);
    }

    public Integer queryCountBy(Map<String, Object> params){
        return this.getSqlSession().selectOne(namespace+"queryCountBy", params);
    }

    //新增
    public Integer insert(SalePlan entity){
        return this.getSqlSession().insert(namespace+"insert", entity);
    }

    //更新
    public Integer update(SalePlan entity){
        return this.getSqlSession().update(namespace+"update", entity);
    }

    //删除
    public Integer delete(SalePlan entity) {
        return this.getSqlSession().update(namespace+"deleteById", entity);
    }
}
