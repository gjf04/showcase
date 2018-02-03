/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.admin.service.appraisal;

import java.util.List;
import java.util.Map;

import com.admin.entity.appraisal.Appraisal;
import com.admin.entity.appraisal.AppraisalUser;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;

/**
 * 考评激励Service
 * @author CongLin
 * @version 2018-01-03
 */
public interface AppraisalService {


    /**
     * 分页查询
     * @param params
     * @param pagerInfo
     * @return
     */
    public ServiceResult<Map<String, Object>> search(Map<String, Object> params, PagerInfo pagerInfo);

    /**
     * 创建
     * @param appraisal
     */
    public ServiceResult<Appraisal> create(Appraisal appraisal);

    /**
     * 更新
     * @param Appraisal
     */
    public ServiceResult<Appraisal> update(Appraisal appraisal);

    /**
     * 删除
     * @param Appraisal
     */
    public ServiceResult<Appraisal> delete(Appraisal appraisal);

    /**
     *获取业务员列表 
     */
    public List<AppraisalUser> getSalesmanList();
}