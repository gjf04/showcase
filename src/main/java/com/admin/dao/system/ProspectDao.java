package com.admin.dao.system;

import com.admin.dao.BaseDao;
import com.admin.entity.system.Prospect;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by lx on 2017/11/17.
 */
@Repository
public class ProspectDao extends BaseDao {

    public Prospect getById(Integer id){
        return this.getSqlSession().selectOne(namespace+"getById", id);
    }

    public List<Prospect> getProspectList(Map<String, Object> paramMap){
        return this.getSqlSession().selectList(namespace + "getProspectList", paramMap);
    }

    public Integer insert(Prospect prospect){
        return this.getSqlSession().insert(namespace+"insert", prospect);
    }

    public Integer update(Prospect prospect){
        return this.getSqlSession().update(namespace+"update",prospect);
    }
}
