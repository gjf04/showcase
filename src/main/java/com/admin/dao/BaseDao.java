package com.admin.dao;
import static com.google.common.base.Preconditions.checkNotNull;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.google.common.collect.Maps;

import lombok.Setter;

@Setter
@Repository
public class BaseDao extends SqlSessionDaoSupport {
	protected String namespace = this.getClass().getName()+".";
     @Resource(name="sqlSessionFactory")
     public  void  initSqlsessionFactory(SqlSessionFactory sqlSessionFactory){
         super.setSqlSessionFactory(sqlSessionFactory);
     }
     
     /**
 	 * 根据某个属性的名字获取对象--如通过员工号获取员工对象
 	 * @param property
 	 * @param value
 	 * @return
 	 */
 	public <T> T findOneByProperty(String property,Object value){
 		checkNotNull(property);
 		checkNotNull(value);
 		Map<String, Object> map = Maps.newHashMap();
 		map.put(property, value);
 		T one = findOneByPropertys(map);
 		return one;
 	}
 	
 	/**
 	 * 根据某个属性的名字获取对象--如通过员工号获取员工对象
 	 * @param property
 	 * @param value
 	 * @return
 	 */
 	public <T> List<T> findListByProperty(String property,Object value){
 		checkNotNull(property);
 		checkNotNull(value);
 		Map<String, Object> map = Maps.newHashMap();
 		map.put(property, value);
 		List<T> one = findListByPropertys(map);
 		return one;
 	}
 	/**
 	 * 根据某个属性的名字获取对象--如通过员工号获取员工对象
 	 * @param property
 	 * @param value
 	 * @return
 	 */
 	public <T> List<T> findListByPropertys(Map<String, Object> propertyMap){
 		checkNotNull(propertyMap);
 		
 		Map<String, Map<String,Object>> map = Maps.newHashMap();
 		map.put("map", propertyMap);
 		return getSqlSession().selectList(namespace+"findListByPropertys",map);
 	}
 	
 	/**
 	 * 通过键值对更新字段的值
 	 * @param propertyMap
 	 * @return
 	 */
 	protected int updateByProperty(String property,String value){
 		checkNotNull(property);
 		
 		Map<String, Object> propertyMap = Maps.newHashMap();
 		propertyMap.put(property, value);
 		
 		return updateByPropertys(propertyMap);
 	}
 	
 	/**
 	 * 通过键值对更新字段的值
 	 * @param propertyMap
 	 * @return
 	 */
 	protected int updateByPropertys(Map<String,Object> propertyMap){
 		checkNotNull(propertyMap);
 		
 		Map<String, Map<String,Object>> map = Maps.newHashMap();
 		map.put("map", propertyMap);
 		return getSqlSession().update(namespace+"updateByPropertys", map);
 	}
 	
 	/**
 	 * 根据某个属性的名字获取对象--如通过员工号获取员工对象
 	 * @param property
 	 * @param value
 	 * @return
 	 */
 	public <T> T findOneByPropertys(Map<String, Object> propertyMap){
 		checkNotNull(propertyMap);
 		Map<String, Map<String,Object>> map = Maps.newHashMap();
 		map.put("map", propertyMap);
 		return getSqlSession().selectOne(namespace+"findListByPropertys",map);
 	}
}
