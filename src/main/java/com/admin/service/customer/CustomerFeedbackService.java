package com.admin.service.customer;
import com.admin.entity.customer.Customer;
import com.admin.entity.customer.CustomerFeedback;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;

import java.util.Map;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface CustomerFeedbackService {

    /**
     * 分页查询
     * @param params
     * @param pagerInfo
     * @return
     */
    public ServiceResult<Map<String, Object>> searchCustomerFeedbacks(Map<String, Object> params, PagerInfo pagerInfo);

    /**
     * 创建
     * @param customerFeedback
     */
    public ServiceResult<CustomerFeedback> createCustomerFeedback(CustomerFeedback customerFeedback);

    /**
     * 更新
     * @param customerFeedback
     */
    public ServiceResult<CustomerFeedback> updateCustomerFeedback(CustomerFeedback customerFeedback);
}
