/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.admin.dao.appraisal;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.admin.dao.BaseDao;
import com.admin.entity.appraisal.Appraisal;

/**
 * 考评激励DAO接口
 * @author CongLin
 * @version 2018-01-03
 */
@Repository
public class AppraisalDao extends BaseDao{	
	 public Appraisal getById(Long id){
	        return this.getSqlSession().selectOne(namespace+"getById", id);
	    }

	    public List<Appraisal> queryListBy(Map<String, Object> params){
	        return this.getSqlSession().selectList(namespace+"queryListBy", params);
	    }

	    public Integer queryCountBy(Map<String, Object> params){
	        return this.getSqlSession().selectOne(namespace+"queryCountBy", params);
	    }

	    //新增
	    public Integer insert(Appraisal entity){
	        return this.getSqlSession().insert(namespace+"insert", entity);
	    }

	    //更新
	    public Integer update(Appraisal entity){
	        return this.getSqlSession().update(namespace+"update", entity);
	    }

	    //删除
		public Integer delete(Appraisal entity) {
			// TODO Auto-generated method stub
			return this.getSqlSession().update(namespace+"deleteById", entity);
		}
}