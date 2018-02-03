package com.admin.dao.agreement;

import java.util.List;
import java.util.Map;

import com.admin.dao.BaseDao;
import com.admin.entity.agreement.AgreementGoods;

import org.springframework.stereotype.Repository;

/**
 * Created by wangss on 2017/11/29.
 */
@Repository
public class AgreementGoodsDao extends BaseDao{
	
	public List<AgreementGoods> getAgreementGoodsList(Map<String, Object> params){
    	return this.getSqlSession().selectList(namespace+"getAgreementGoodsList", params);
    }
	
	public int deleteByAgreementId(Long agreementId){
    	return this.getSqlSession().delete(namespace+"deleteByAgreementId", agreementId);
    }
	
	public int insertAgreementGoodsBatch(List<AgreementGoods> agreementGoodsList){
		return this.getSqlSession().insert(namespace+"insertAgreementGoodsBatch", agreementGoodsList);
	}
	
}