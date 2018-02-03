package com.admin.service.impl.agreement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.admin.dao.agreement.AgreementApprovalDao;
import com.admin.dao.agreement.AgreementGoodsDao;
import com.admin.dao.agreement.AgreementInfoDao;
import com.admin.dao.agreement.AgreementPayDao;
import com.admin.entity.agreement.AgreementApproval;
import com.admin.entity.agreement.AgreementGoods;
import com.admin.entity.agreement.AgreementInfo;
import com.admin.entity.agreement.AgreementPay;
import com.admin.service.agreement.AgreementService;
import com.google.common.base.Throwables;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import static com.google.common.base.Preconditions.checkNotNull;

/**
 * Created by wangss
 */
@Slf4j
@Service
public class AgreementServiceImpl implements AgreementService {
    
	@Autowired
    private AgreementInfoDao agreementInfoDao;

	@Autowired
	private AgreementGoodsDao agreementGoodsDao;
	
	@Autowired
	private AgreementApprovalDao agreementApprovalDao;
	
	@Autowired
	private AgreementPayDao agreementPayDao;
    
	@Override
	public ServiceResult<Map<String, Object>> getAgreementList(
			Map<String, Object> paramMap, PagerInfo pagerInfo) {
		ServiceResult<Map<String, Object>> result = new ServiceResult<Map<String, Object>>();
        Map<String, Object> map = new HashMap<String, Object>();
        try{
        	// 记录总数
            int rowsCount = agreementInfoDao.getAgreementListCount(paramMap);
            int start = pagerInfo.getStart();
            int size = pagerInfo.getPageSize();
            if (rowsCount > 0) {
                int totalPage = (rowsCount + size - 1) / size;// 总页数
                int pageIndex = pagerInfo.getPageIndex();// 当前页码
                if (pageIndex > totalPage) {
                    // 总页数作为当前页
                    start = (totalPage - 1) * size;
                }
            }
            paramMap.put("start", start);
            paramMap.put("size", size);
            List<AgreementInfo> roles = agreementInfoDao.getAgreementList(paramMap);
            map.put("data", roles);
            map.put("total", rowsCount);
            result.setResult(map);
        }catch(Exception e){
        	result.setError("error","合同信息查询失败");
        	log.error("合同信息查询失败:" + Throwables.getStackTraceAsString(e) );
        }
		return result;
	}
	
    @Override
    public ServiceResult<Integer> insertAgreementInfo(AgreementInfo agreementInfo,List<AgreementGoods> agreementGoodsList){
        checkNotNull(agreementInfo, "agreementInfo不能为空");
        ServiceResult<Integer> result = new ServiceResult<Integer>();
        try{
            agreementInfoDao.insert(agreementInfo);
            Long agreementId = agreementInfo.getId();
            result.setResult( agreementId.intValue());
            
            if(agreementGoodsList!=null && agreementGoodsList.size()>0){
            	for(AgreementGoods agreementGoods :agreementGoodsList){
            		agreementGoods.setAgreementId(agreementId);
            	}
            	agreementGoodsDao.insertAgreementGoodsBatch(agreementGoodsList);
            }
        }catch(Exception e){
        	result.setError("error","合同信息插入失败");
        	log.error("合同信息插入失败:" + Throwables.getStackTraceAsString(e) );
        }
        return result;
    }
    
    @Override
    public ServiceResult<Boolean> updateAgreementInfo(AgreementInfo agreementInfo,List<AgreementGoods> agreementGoodsList){
    	checkNotNull(agreementInfo, "agreementInfo不能为空");
    	ServiceResult<Boolean> result = new ServiceResult<Boolean>();
    	try{
    		int id = agreementInfoDao.updateById(agreementInfo);
    		Long agreementId = agreementInfo.getId();
    		
    		if(agreementGoodsList!=null && agreementGoodsList.size()>0){
            	for(AgreementGoods agreementGoods :agreementGoodsList){
            		agreementGoods.setAgreementId(agreementId);
            	}
            	agreementGoodsDao.insertAgreementGoodsBatch(agreementGoodsList);
            }
    		result.setResult(true);
    	}catch(Exception e){
    		result.setError("error","合同信息更新失败");
    		log.error("合同信息更新失败:" + Throwables.getStackTraceAsString(e) );
    	}
    	return result;
    }
    
    @Override
    public ServiceResult<AgreementInfo> selectAgreementInfoById(AgreementInfo agreementInfo){
    	checkNotNull(agreementInfo, "agreementInfo不能为空");
    	ServiceResult<AgreementInfo> result = new ServiceResult<AgreementInfo>();
    	try{
    		AgreementInfo agreement = agreementInfoDao.selectById(agreementInfo.getId());
    		result.setResult(agreement);
    	}catch(Exception e){
    		result.setError("error","合同信息更新失败");
    		log.error("合同信息更新失败:" + Throwables.getStackTraceAsString(e) );
    	}
    	return result;
    }
    
    @Override
    public ServiceResult<Boolean> deleteAgreementInfo(Long agreementInfoId){
    	checkNotNull(agreementInfoId, "agreementInfoId不能为空");
    	ServiceResult<Boolean> result = new ServiceResult<Boolean>();
    	try{
    		int id = agreementInfoDao.deleteAgreementInfo(agreementInfoId);
    		result.setResult(true);
    	}catch(Exception e){
    		result.setError("error","删除合同信息失败");
    		log.error("删除合同信息失败:" + Throwables.getStackTraceAsString(e) );
    	}
    	return result;
    }
    
    @Override
    public ServiceResult<Boolean> deleteAgreementGoods(Long agreementInfoId){
    	checkNotNull(agreementInfoId, "agreementInfoId不能为空");
    	ServiceResult<Boolean> result = new ServiceResult<Boolean>();
    	try{
    		int id = agreementGoodsDao.deleteByAgreementId(agreementInfoId);
    		result.setResult(true);
    	}catch(Exception e){
    		result.setError("error","删除合同货品清单失败");
    		log.error("删除合同货品清单 失败:" + Throwables.getStackTraceAsString(e) );
    	}
    	return result;
    }
    
    @Override
    public ServiceResult<List<AgreementGoods>> selectAgreementGoodsByAgreementInfoId(Long agreementInfoId){
    	ServiceResult<List<AgreementGoods>> result = new ServiceResult<List<AgreementGoods>>();
    	try{
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("agreementId", agreementInfoId);
    		List<AgreementGoods> agreementGoodsList = agreementGoodsDao.getAgreementGoodsList(params);
    		result.setResult(agreementGoodsList);
    	}catch(Exception e){
    		result.setError("error","查询合同货品清单失败");
    		log.error("查询合同货品清单失败:" + Throwables.getStackTraceAsString(e) );
    	}
    	return result;
    }

	@Override
	public ServiceResult<List<AgreementApproval>> selectAgreementApprovalByAgreeId(
			Long agreeId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceResult<Boolean> saveAgreementApproval(AgreementApproval agreementApproval) {
		ServiceResult<Boolean> result = new ServiceResult<Boolean>();
		try{
    		agreementApprovalDao.insert(agreementApproval);
    		
    		Long agreeId = agreementApproval.getAgreeId();
    		AgreementInfo agreementInfo1 = agreementInfoDao.selectById( agreeId );
    		//0已保存待提交 1待内勤初审 2总监审核 3合同上传 4签订完成 7已退回待修改
    		int approvalStatus = agreementInfo1.getApprovalStatus();
    		if(agreementApproval.getStatus() == AgreementApproval.statusEnum.PASS.value() ){
    			approvalStatus += 1;
    		}else{
    			approvalStatus = 7;
    		}
    		AgreementInfo agreementInfo = new AgreementInfo();
    		agreementInfo.setId( agreeId );
    		agreementInfo.setApprovalStatus(approvalStatus);
    		agreementInfo.setRefuseInfo( agreementApproval.getApprovalInfo() );
    		agreementInfoDao.updateById(agreementInfo);
    		result.setResult(true);
    	}catch(Exception e){
    		result.setError("error","保存合同审核信息失败");
    		log.error("保存合同审核信息失败:" + Throwables.getStackTraceAsString(e) );
    	}
    	return result;
	}

	@Override
	public ServiceResult<Boolean> saveAgreementPay(AgreementPay agreementPay) {
		ServiceResult<Boolean> result = new ServiceResult<Boolean>();
    	try{
			int i = agreementPayDao.insertAgreementPay(agreementPay);
    		result.setResult(true);
    	}catch(Exception e){
    		result.setError("error","保存合同付款信息失败");
    		log.error("保存合同付款信息失败:" + Throwables.getStackTraceAsString(e) );
    	}
    	return result;
	}

	@Override
	public ServiceResult<Map<String, Object>> selectAgreementPayByAgreeId(
			Map<String, Object> paramMap, PagerInfo pagerInfo) {
		ServiceResult<Map<String, Object>> result = new ServiceResult<Map<String, Object>>();
        Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		// 记录总数
            int rowsCount = agreementPayDao.getAgreementPayCount(paramMap);
            int start = pagerInfo.getStart();
            int size = pagerInfo.getPageSize();
            if (rowsCount > 0) {
                int totalPage = (rowsCount + size - 1) / size;// 总页数
                int pageIndex = pagerInfo.getPageIndex();// 当前页码
                if (pageIndex > totalPage) {
                    // 总页数作为当前页
                    start = (totalPage - 1) * size;
                }
            }
            paramMap.put("start", start);
            paramMap.put("size", size);
            List<AgreementPay> roles = agreementPayDao.getAgreementPayList(paramMap);
            map.put("data", roles);
            map.put("total", rowsCount);
            result.setResult(map);
            
    	}catch(Exception e){
    		result.setError("error","查询合同付款信息失败");
    		log.error("查询合同付款信息失败:" + Throwables.getStackTraceAsString(e) );
    	}
    	return result;
	}
}
