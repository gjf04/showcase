package com.admin.dao.system;

import com.admin.entity.system.Attachment;
import org.springframework.stereotype.Repository;

import com.admin.dao.BaseDao;

import java.util.List;
import java.util.Map;

/**
 * Created by GaoJingFei on 2017/11/17.
 */
@Repository
public class AttachmentDao  extends BaseDao {
    public Attachment getById(Long id){
        return this.getSqlSession().selectOne(namespace+"getById", id);
    }

    public List<Attachment> getByRelateId(Long relateId){
        return this.getSqlSession().selectList(namespace+"getByRelateId", relateId);
    }

    //新增
    public Integer insert(Attachment attachment){
        return this.getSqlSession().insert(namespace+"insert", attachment);
    }

    //更新
    public Integer update(Attachment attachment){
        return this.getSqlSession().update(namespace+"update", attachment);
    }
}