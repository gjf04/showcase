/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.admin.service.salary.base;

import java.util.Map;

import com.admin.entity.salary.base.SalaryBaseRule;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;

/**
 * 底薪设置Service
 * @author CongLin
 * @version 2017-12-10
 */
public interface SalaryBaseRuleService {


    /**
     * 分页查询
     * @param params
     * @param pagerInfo
     * @return
     */
    public ServiceResult<Map<String, Object>> search(Map<String, Object> params, PagerInfo pagerInfo);

    /**
     * 创建
     * @param salaryBaseRule
     */
    public ServiceResult<SalaryBaseRule> create(SalaryBaseRule salaryBaseRule);

    /**
     * 更新
     * @param SalaryBaseRule
     */
    public ServiceResult<SalaryBaseRule> update(SalaryBaseRule salaryBaseRule);

    /**
     * 删除
     * @param SalaryBaseRule
     */
    public ServiceResult<SalaryBaseRule> delete(SalaryBaseRule salaryBaseRule);
	
}