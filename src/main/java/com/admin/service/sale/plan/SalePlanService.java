package com.admin.service.sale.plan;

import com.admin.entity.sale.plan.SalePlan;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;

import java.util.Map;

/**
 * 销售计划Service
 * @author WangDeYu
 * @version 2017-12-20
 */
public interface SalePlanService {
    /**
     * 分页查询
     * @param params
     * @param pagerInfo
     * @return
     */
    public ServiceResult<Map<String, Object>> search(Map<String, Object> params, PagerInfo pagerInfo);

    /**
     * 创建
     * @param salePlan
     */
    public ServiceResult<SalePlan> create(SalePlan salePlan);

    /**
     * 更新
     * @param salePlan
     */
    public ServiceResult<SalePlan> update(SalePlan salePlan);

    /**
     * 删除
     * @param salePlan
     */
    public ServiceResult<SalePlan> delete(SalePlan salePlan);
}
