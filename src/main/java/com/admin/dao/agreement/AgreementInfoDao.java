package com.admin.dao.agreement;

import java.util.List;
import java.util.Map;

import com.admin.dao.BaseDao;
import com.admin.entity.agreement.AgreementInfo;

import org.springframework.stereotype.Repository;

/**
 * Created by wangss on 2017/11/17.
 */
@Repository
public class AgreementInfoDao extends BaseDao{
	
	public List<AgreementInfo> getAgreementList(Map<String, Object> params){
    	return this.getSqlSession().selectList(namespace+"getAgreementList", params);
    }
	
	public Integer getAgreementListCount(Map<String, Object> params){
        return this.getSqlSession().selectOne(namespace+"getAgreementListCount", params);
    }
	
	public AgreementInfo selectById(Long id){
    	return this.getSqlSession().selectOne(namespace+"selectById", id);
    }
	
	public int deleteById(Long id){
    	return this.getSqlSession().delete(namespace+"deleteById", id);
    }
	
	public int insert(AgreementInfo agreementInfo){
		return this.getSqlSession().insert(namespace+"insert", agreementInfo);
	}
	
	public int updateById(AgreementInfo agreementInfo){
		return this.getSqlSession().update(namespace+"updateById", agreementInfo);
	}
	
	public int deleteAgreementInfo(Long agreementInfoId){
		return this.getSqlSession().delete(namespace+"deleteAgreementInfo", agreementInfoId);
	}
}