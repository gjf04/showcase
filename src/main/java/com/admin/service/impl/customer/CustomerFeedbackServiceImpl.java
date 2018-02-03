package com.admin.service.impl.customer;

import com.admin.dao.customer.CustomerDao;
import com.admin.dao.customer.CustomerFeedbackDao;
import com.admin.entity.customer.Customer;
import com.admin.entity.customer.CustomerFeedback;
import com.admin.service.customer.CustomerFeedbackService;
import com.admin.service.customer.CustomerService;
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
 * Created by GaoJingFei on 2017/11/13.
 */
@Slf4j
@Service
public class CustomerFeedbackServiceImpl implements CustomerFeedbackService {
    @Autowired
    private CustomerFeedbackDao customerFeedbackDao;

    @Override
    public ServiceResult<Map<String, Object>> searchCustomerFeedbacks(Map<String, Object> params, PagerInfo pagerInfo) {
        ServiceResult<Map<String, Object>> result = new ServiceResult<Map<String, Object>>();
        Map<String, Object> map = new HashMap<String, Object>();
        // 记录总数
        int rowsCount = customerFeedbackDao.queryCountBy(params);
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
        List<CustomerFeedback> customers = customerFeedbackDao.queryListBy(params);
        map.put("data", customers);
        map.put("total", rowsCount);
        result.setResult(map);
        return result;
    }

    @Override
    public ServiceResult<CustomerFeedback> createCustomerFeedback(CustomerFeedback customerFeedback) {
        ServiceResult<CustomerFeedback> executeResult = new ServiceResult<CustomerFeedback>();
        customerFeedback.setCreatedAt(new Date());
        customerFeedback.setUpdatedAt(new Date());
        customerFeedbackDao.insert(customerFeedback);
        executeResult.setResult(customerFeedback);
        return executeResult;
    }
    @Override
    public ServiceResult<CustomerFeedback> updateCustomerFeedback(CustomerFeedback customerFeedback) {
        ServiceResult<CustomerFeedback> executeResult = new ServiceResult<CustomerFeedback>();
        CustomerFeedback dbCustomerFeedback = customerFeedbackDao.getById(customerFeedback.getId());
        if(dbCustomerFeedback == null){
            executeResult.setMessage("该客户不存在或已经被删除。");
            return executeResult;
        }
//        dbCustomer.setStatus(customer.getStatus());
//        dbCustomer.setPassword(customer.getPassword());
        dbCustomerFeedback.setResponsiblePerson(customerFeedback.getResponsiblePerson());
        dbCustomerFeedback.setUpdatedBy(customerFeedback.getUpdatedBy());
        dbCustomerFeedback.setUpdatedAt(new Date());
        customerFeedbackDao.update(dbCustomerFeedback);
        return executeResult;
    }
}
