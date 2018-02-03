package com.admin.dao.agreement;

import java.util.List;

import com.admin.dao.BaseDao;
import com.admin.entity.agreement.AgreementApproval;
import com.admin.entity.agreement.AgreementInfo;

import org.springframework.stereotype.Repository;

/**
 * Created by wangss on 2017/11/17.
 */
@Repository
public class AgreementApprovalDao extends BaseDao{
	
	public List<AgreementApproval> selectByAgreeId(Long agreeId){
    	return this.getSqlSession().selectList(namespace+"selectByAgreeId", agreeId);
    }
	
	public AgreementApproval selectLastByAgreeId(Long agreeId){
    	return this.getSqlSession().selectOne(namespace+"selectLastByAgreeId", agreeId);
    }
	
	public AgreementApproval selectById(Long id){
		return this.getSqlSession().selectOne(namespace+"selectById", id);
	}
	
	public int insert(AgreementApproval agreementApproval){
		return this.getSqlSession().insert(namespace+"insert", agreementApproval);
	}
	
}