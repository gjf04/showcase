package com.admin.dao.reimbursement;

import com.admin.dao.BaseDao;
import com.admin.entity.reimbursement.Reimbursement;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 报销管理DAO接口
 * @author WangDeYu
 * @version 2017-12-25
 */
@Repository
public class ReimbursementDao extends BaseDao {
    public Reimbursement getById(Long id){
        return this.getSqlSession().selectOne(namespace+"getById", id);
    }

    public List<Reimbursement> queryListBy(Map<String, Object> params){
        return this.getSqlSession().selectList(namespace+"queryListBy", params);
    }

    public Integer queryCountBy(Map<String, Object> params){
        return this.getSqlSession().selectOne(namespace+"queryCountBy", params);
    }

    //新增
    public Integer insert(Reimbursement entity){
        return this.getSqlSession().insert(namespace+"insert", entity);
    }

    //更新
    public Integer update(Reimbursement entity){
        return this.getSqlSession().update(namespace+"update", entity);
    }

    //删除
    public Integer delete(Reimbursement entity) {
        return this.getSqlSession().update(namespace+"deleteById", entity);
    }


    // 提交
    public Integer approval(Reimbursement entity) {
        return this.getSqlSession().update(namespace+"approval", entity);
    }
}
