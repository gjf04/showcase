package com.admin.service.impl.salary.base;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.admin.dao.salary.base.SalaryBaseRuleDao;
import com.admin.entity.salary.base.SalaryBaseRule;
import com.admin.service.salary.base.SalaryBaseRuleService;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;

import lombok.extern.slf4j.Slf4j;


/**
 * Created by CongLin on 2017/12/11.
 */
@Slf4j
@Service
public class SalaryBaseRuleServiceImpl implements SalaryBaseRuleService {
    @Autowired
    private SalaryBaseRuleDao salaryBaseRuleDao;

    @Override
    public ServiceResult<Map<String, Object>> search(Map<String, Object> params, PagerInfo pagerInfo) {
        ServiceResult<Map<String, Object>> result = new ServiceResult<Map<String, Object>>();
        Map<String, Object> map = new HashMap<String, Object>();
        // 记录总数
        int rowsCount = salaryBaseRuleDao.queryCountBy(params);
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
        params.put("start", start);
        params.put("size", size);
        List<SalaryBaseRule> rules = salaryBaseRuleDao.queryListBy(params);
        map.put("data", rules);
        map.put("total", rowsCount);
        result.setResult(map);
        return result;
    }

    @Override
    public ServiceResult<SalaryBaseRule> create(SalaryBaseRule salaryBaseRule) {
        ServiceResult<SalaryBaseRule> executeResult = new ServiceResult<SalaryBaseRule>();
        salaryBaseRule.setCreatedAt(new Date());
        salaryBaseRule.setUpdatedAt(new Date());
        salaryBaseRuleDao.insert(salaryBaseRule);
        executeResult.setResult(salaryBaseRule);
        return executeResult;
    }
    @Override
    public ServiceResult<SalaryBaseRule> update(SalaryBaseRule salaryBaseRule) {
        ServiceResult<SalaryBaseRule> executeResult = new ServiceResult<SalaryBaseRule>();
        SalaryBaseRule dbEntity = salaryBaseRuleDao.getById(salaryBaseRule.getId());
        if(dbEntity == null){
            executeResult.setMessage("该底薪规则不存在或已经被删除。");
            return executeResult;
        }

        salaryBaseRule.setUpdatedBy("system");
        salaryBaseRule.setUpdatedAt(new Date());
        Integer result = salaryBaseRuleDao.update(salaryBaseRule);
        if(result == 1) {
        	executeResult.setSuccess(true);
        }
        return executeResult;
    }
    
    @Override
    public ServiceResult<SalaryBaseRule> delete(SalaryBaseRule salaryBaseRule) {
        ServiceResult<SalaryBaseRule> executeResult = new ServiceResult<SalaryBaseRule>();
        
        Integer result = salaryBaseRuleDao.delete(salaryBaseRule);
        if(result == 1) {
        	executeResult.setSuccess(true);
        }
        return executeResult;
    }
}
