package com.admin.service.customer;
import com.admin.entity.customer.Customer;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;

import java.util.List;
import java.util.Map;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface CustomerService {

    /**
     * 分页查询
     * @param params
     * @param pagerInfo
     * @return
     */
    public ServiceResult<Map<String, Object>> searchCustomers(Map<String, Object> params, PagerInfo pagerInfo);

    public ServiceResult<List<Customer>> searchCustomerIdCombo(Map<String, Object> params);
    
    /**
     * 创建
     * @param customer
     */
    public ServiceResult<Customer> createCustomer(Customer customer);

    /**
     * 更新
     * @param customer
     */
    public ServiceResult<Customer> updateCustomer(Customer customer);

    /**
     * 根据id获取
     * @param id
     */
    public ServiceResult<Customer> getById(Long id);

    /**
     * 移入公海
     * @param customer
     */
    public ServiceResult<Customer> updateToOpenSea(Customer customer);
}
