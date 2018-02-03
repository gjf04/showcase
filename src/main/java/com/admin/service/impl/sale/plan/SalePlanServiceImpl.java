package com.admin.service.impl.sale.plan;

import com.admin.dao.sale.plan.SalePlanDao;
import com.admin.entity.sale.plan.SalePlan;
import com.admin.service.sale.plan.SalePlanService;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by WangDeYu on 2017/12/20 0020.
 */
@Slf4j
@Service
public class SalePlanServiceImpl implements SalePlanService {
    @Autowired
    private SalePlanDao salePlanDao;

    @Override
    public ServiceResult<Map<String, Object>> search(Map<String, Object> params, PagerInfo pagerInfo) {
        ServiceResult<Map<String, Object>> result = new ServiceResult<Map<String, Object>>();
        Map<String, Object> map = new HashMap<String, Object>();
        // 记录总数
        int rowsCount = salePlanDao.queryCountBy(params);
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
        List<SalePlan> rules = salePlanDao.queryListBy(params);
        map.put("data", rules);
        map.put("total", rowsCount);
        result.setResult(map);
        return result;
    }

    @Override
    public ServiceResult<SalePlan> create(SalePlan salePlan) {
        ServiceResult<SalePlan> executeResult = new ServiceResult<SalePlan>();
        salePlan.setCreatedAt(new Date());
        salePlan.setUpdatedAt(new Date());
        salePlanDao.insert(salePlan);
        executeResult.setResult(salePlan);
        return executeResult;
    }
    @Override
    public ServiceResult<SalePlan> update(SalePlan salePlan) {
        ServiceResult<SalePlan> executeResult = new ServiceResult<SalePlan>();
        SalePlan dbEntity = salePlanDao.getById(salePlan.getId());
        if(dbEntity == null){
            executeResult.setMessage("该销售计划不存在或已经被删除。");
            return executeResult;
        }

        salePlan.setUpdatedBy("system");
        salePlan.setUpdatedAt(new Date());
        Integer result = salePlanDao.update(salePlan);
        if(result == 1) {
            executeResult.setSuccess(true);
        }
        return executeResult;
    }

    @Override
    public ServiceResult<SalePlan> delete(SalePlan salePlan) {
        ServiceResult<SalePlan> executeResult = new ServiceResult<SalePlan>();

        Integer result = salePlanDao.delete(salePlan);
        if(result == 1) {
            executeResult.setSuccess(true);
        }
        return executeResult;
    }
}
