package com.admin.service.impl.appraisal;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.admin.dao.appraisal.AppraisalDao;
import com.admin.dao.appraisal.AppraisalUserDao;
import com.admin.entity.appraisal.Appraisal;
import com.admin.entity.appraisal.AppraisalUser;
import com.admin.service.appraisal.AppraisalService;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;

import lombok.extern.slf4j.Slf4j;


/**
 * Created by CongLin on 2018/01/03.
 */
@Slf4j
@Service
public class AppraisalServiceImpl implements AppraisalService {
    @Autowired
    private AppraisalDao appraisalDao;
    @Autowired
    private AppraisalUserDao appraissalUserDao;
    
    @Override
    public ServiceResult<Map<String, Object>> search(Map<String, Object> params, PagerInfo pagerInfo) {
        ServiceResult<Map<String, Object>> result = new ServiceResult<Map<String, Object>>();
        Map<String, Object> map = new HashMap<String, Object>();
        // 记录总数
        int rowsCount = appraisalDao.queryCountBy(params);
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
        List<Appraisal> rules = appraisalDao.queryListBy(params);
        map.put("data", rules);
        map.put("total", rowsCount);
        result.setResult(map);
        return result;
    }

    @Override
    public ServiceResult<Appraisal> create(Appraisal appraisal) {
        ServiceResult<Appraisal> executeResult = new ServiceResult<Appraisal>();
        appraisal.setCreatedAt(new Date());
        appraisal.setUpdatedAt(new Date());
        appraisalDao.insert(appraisal);
        executeResult.setResult(appraisal);
        return executeResult;
    }
    @Override
    public ServiceResult<Appraisal> update(Appraisal appraisal) {
        ServiceResult<Appraisal> executeResult = new ServiceResult<Appraisal>();
        Appraisal dbEntity = appraisalDao.getById(appraisal.getId());
        if(dbEntity == null){
            executeResult.setMessage("该底薪规则不存在或已经被删除。");
            return executeResult;
        }

        appraisal.setUpdatedBy("system");
        appraisal.setUpdatedAt(new Date());
        Integer result = appraisalDao.update(appraisal);
        if(result == 1) {
        	executeResult.setSuccess(true);
        }
        return executeResult;
    }
    
    @Override
    public ServiceResult<Appraisal> delete(Appraisal appraisal) {
        ServiceResult<Appraisal> executeResult = new ServiceResult<Appraisal>();
        
        Integer result = appraisalDao.delete(appraisal);
        if(result == 1) {
        	executeResult.setSuccess(true);
        }
        return executeResult;
    }
    @Override
    public List<AppraisalUser> getSalesmanList(){
        return appraissalUserDao.getUserInfo();
    }
}
