package com.admin.service.reimbursement;

import com.admin.entity.reimbursement.Reimbursement;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;

import java.util.Map;

/**
 * 报销管理Service
 * @author WangDeYu
 * @version 2017-12-25
 */
public interface ReimbursementService {
    /**
     * 分页查询
     * @param params
     * @param pagerInfo
     * @return
     */
    public ServiceResult<Map<String, Object>> search(Map<String, Object> params, PagerInfo pagerInfo);

    /**
     * 创建
     * @param reimbursement
     */
    public ServiceResult<Reimbursement> create(Reimbursement reimbursement);

    /**
     * 更新
     * @param reimbursement
     */
    public ServiceResult<Reimbursement> update(Reimbursement reimbursement);

    /**
     * 删除
     * @param reimbursement
     */
    public ServiceResult<Reimbursement> delete(Reimbursement reimbursement);

    /**
     * 提交
     */
    public ServiceResult<Reimbursement> approval(Reimbursement reimbursement);
}
