package com.admin.service.impl.reimbursement;


import com.admin.dao.reimbursement.ReimbursementDao;
import com.admin.entity.reimbursement.Reimbursement;
import com.admin.service.reimbursement.ReimbursementService;
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
 * Created by WangDeYu on 2017/12/25 0020.
 */
@Slf4j
@Service
public class ReimbursementServiceImpl implements ReimbursementService {
    @Autowired
    private ReimbursementDao reimbursementDao;

    @Override
    public ServiceResult<Map<String, Object>> search(Map<String, Object> params, PagerInfo pagerInfo) {
        ServiceResult<Map<String, Object>> result = new ServiceResult<Map<String, Object>>();
        Map<String, Object> map = new HashMap<String, Object>();
        // 记录总数
        int rowsCount = reimbursementDao.queryCountBy(params);
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
        List<Reimbursement> rules = reimbursementDao.queryListBy(params);
        map.put("data", rules);
        map.put("total", rowsCount);
        result.setResult(map);
        return result;
    }

    @Override
    public ServiceResult<Reimbursement> create(Reimbursement reimbursement) {
        ServiceResult<Reimbursement> executeResult = new ServiceResult<Reimbursement>();
        reimbursement.setCreatedAt(new Date());
        reimbursement.setUpdatedAt(new Date());
        reimbursementDao.insert(reimbursement);
        executeResult.setResult(reimbursement);
        return executeResult;
    }
    @Override
    public ServiceResult<Reimbursement> update(Reimbursement reimbursement) {
        ServiceResult<Reimbursement> executeResult = new ServiceResult<Reimbursement>();
        Reimbursement dbEntity = reimbursementDao.getById(reimbursement.getId());
        if(dbEntity == null){
            executeResult.setMessage("该笔报销不存在或已经被删除。");
            return executeResult;
        }

        reimbursement.setUpdatedBy("system");
        reimbursement.setUpdatedAt(new Date());
        Integer result = reimbursementDao.update(reimbursement);
        if(result == 1) {
            executeResult.setSuccess(true);
        }
        return executeResult;
    }

    @Override
    public ServiceResult<Reimbursement> delete(Reimbursement reimbursement) {
        ServiceResult<Reimbursement> executeResult = new ServiceResult<Reimbursement>();

        Integer result = reimbursementDao.delete(reimbursement);
        if(result == 1) {
            executeResult.setSuccess(true);
        }
        return executeResult;
    }

    @Override
    public ServiceResult<Reimbursement> approval(Reimbursement reimbursement) {
        ServiceResult<Reimbursement> executeResult = new ServiceResult<Reimbursement>();

        Integer result = reimbursementDao.approval(reimbursement);
        if(result == 1) {
            executeResult.setSuccess(true);
        }
        return executeResult;
    }


}
