/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.admin.dao.salary.base;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.admin.dao.BaseDao;
import com.admin.entity.salary.base.SalaryBaseRule;

/**
 * 底薪设置DAO接口
 * @author CongLin
 * @version 2017-12-10
 */
@Repository
public class SalaryBaseRuleDao extends BaseDao{	
	 public SalaryBaseRule getById(Long id){
	        return this.getSqlSession().selectOne(namespace+"getById", id);
	    }

	    public List<SalaryBaseRule> queryListBy(Map<String, Object> params){
	        return this.getSqlSession().selectList(namespace+"queryListBy", params);
	    }

	    public Integer queryCountBy(Map<String, Object> params){
	        return this.getSqlSession().selectOne(namespace+"queryCountBy", params);
	    }

	    //新增
	    public Integer insert(SalaryBaseRule entity){
	        return this.getSqlSession().insert(namespace+"insert", entity);
	    }

	    //更新
	    public Integer update(SalaryBaseRule entity){
	        return this.getSqlSession().update(namespace+"update", entity);
	    }

	    //删除
		public Integer delete(SalaryBaseRule entity) {
			// TODO Auto-generated method stub
			return this.getSqlSession().update(namespace+"deleteById", entity);
		}
}