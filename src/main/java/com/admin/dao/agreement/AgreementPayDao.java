package com.admin.dao.agreement;

import java.util.List;
import java.util.Map;

import com.admin.dao.BaseDao;
import com.admin.entity.agreement.AgreementGoods;
import com.admin.entity.agreement.AgreementPay;

import org.springframework.stereotype.Repository;

/**
 * Created by wangss on 2017/11/29.
 */
@Repository
public class AgreementPayDao extends BaseDao{
	
	public List<AgreementPay> getAgreementPayList(Map<String, Object> params){
    	return this.getSqlSession().selectList(namespace+"getAgreementPayList", params);
    }
	
	public Integer getAgreementPayCount(Map<String, Object> params){
    	return this.getSqlSession().selectOne(namespace+"getAgreementPayCount", params);
    }
	
	
	public int insertAgreementPay(AgreementPay agreementPay){
		return this.getSqlSession().insert(namespace+"insertAgreementPay", agreementPay);
	}
	
}