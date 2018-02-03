package com.admin.service.impl.customer;

import com.admin.dao.customer.CustomerContactDao;
import com.admin.dao.customer.CustomerDao;
import com.admin.entity.BaseEntity;
import com.admin.entity.customer.Customer;
import com.admin.entity.customer.CustomerContact;
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
public class CustomerServiceImpl implements CustomerService {
    @Autowired
    private CustomerDao customerDao;
    @Autowired
    private CustomerContactDao customerContactDao;

    @Override
    public ServiceResult<Map<String, Object>> searchCustomers(Map<String, Object> params, PagerInfo pagerInfo) {
        ServiceResult<Map<String, Object>> result = new ServiceResult<Map<String, Object>>();
        Map<String, Object> map = new HashMap<String, Object>();
        // 记录总数
        int rowsCount = customerDao.queryCountBy(params);
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
        List<Customer> customers = customerDao.queryListBy(params);
        for(Customer customer : customers){
            setCustomerContact(customer);
        }
        map.put("data", customers);
        map.put("total", rowsCount);
        result.setResult(map);
        return result;
    }

    @Override
    public ServiceResult<List<Customer>> searchCustomerIdCombo(Map<String, Object> params) {
        ServiceResult<List<Customer>> result = new ServiceResult<List<Customer>>();
        List<Customer> customers = customerDao.queryListBy(params);
        for(Customer customer : customers){
            setCustomerContact(customer);
        }
        result.setResult(customers);
        return result;
    }
    /**
     * 设置客户联系人
     * */
    private void setCustomerContact(Customer customer){
        List<CustomerContact> customerContactList = customerContactDao.getByCustomerId(customer.getId());
        for(CustomerContact customerContact : customerContactList){
            if(CustomerContact.TYPE_ELECTRIC.equals(customerContact.getType())){
                customer.setElectric(customerContact);
            }
            if(CustomerContact.TYPE_WATER.equals(customerContact.getType())){
                customer.setWater(customerContact);
            }
            if(CustomerContact.TYPE_SAFE.equals(customerContact.getType())){
                customer.setSafe(customerContact);
            }
            if(CustomerContact.TYPE_VISUAL.equals(customerContact.getType())){
                customer.setVisual(customerContact);
            }
            if(CustomerContact.TYPE_EMERGENCY.equals(customerContact.getType())){
                customer.setEmergency(customerContact);
            }
        }
    }

    @Override
    public ServiceResult<Customer> createCustomer(Customer customer) {
        ServiceResult<Customer> executeResult = new ServiceResult<Customer>();
        customer.setCreatedAt(new Date());
        customer.setUpdatedAt(new Date());
        customer.setIsDelete(Customer.IsDeleteEnum.NO.getIsDelete());
        Integer count = customerDao.insert(customer);
        if(count < 1){
            executeResult.setMessage("客户保存失败。");
            return executeResult;
        }
        if(customer.getElectric() != null){
            saveCustomerContact(customer, customer.getElectric(), CustomerContact.TYPE_ELECTRIC);
        }
        if(customer.getWater() != null){
            saveCustomerContact(customer, customer.getWater(), CustomerContact.TYPE_WATER);
        }
        if(customer.getSafe() != null){
            saveCustomerContact(customer, customer.getSafe(), CustomerContact.TYPE_SAFE);
        }
        if(customer.getVisual() != null){
            saveCustomerContact(customer, customer.getVisual(), CustomerContact.TYPE_VISUAL);
        }
        if(customer.getEmergency() != null){
            saveCustomerContact(customer, customer.getEmergency(), CustomerContact.TYPE_EMERGENCY);
        }

        executeResult.setResult(customer);
        return executeResult;
    }

    /**
     * 保存客户联系人
     * */
    private void saveCustomerContact(Customer customer, CustomerContact customerContact, String type){
        customerContact.setCustomerId(customer.getId() == null ? 0L : customer.getId());
        customerContact.setCustomerName(customer.getCustomerName());
        customerContact.setCustomerCode(customer.getCustomerCode());
        customerContact.setType(type);
        customerContact.setCreatedAt(new Date());
        customerContact.setUpdatedAt(new Date());
        customerContact.setIsDelete(CustomerContact.IsDeleteEnum.NO.getIsDelete());
        customerContactDao.insert(customerContact);
    }

    /**
     * 更新客户联系人
     * */
    private void updateCustomerContact(Customer customer, CustomerContact customerContact, String type){
        customerContact.setCustomerId(customer.getId() == null ? 0L : customer.getId());
        customerContact.setType(type);
        customerContact.setUpdatedAt(new Date());
        customerContactDao.updateByType(customerContact);
    }

    @Override
    public ServiceResult<Customer> updateCustomer(Customer customer) {
        ServiceResult<Customer> executeResult = new ServiceResult<Customer>();
        Customer dbCustomer = customerDao.getById(customer.getId());
        if(dbCustomer == null){
            executeResult.setMessage("该客户不存在或已经被删除。");
            return executeResult;
        }
        Integer count = customerDao.update(customer);
        if(count < 1){
            executeResult.setMessage("客户更新失败。");
            return executeResult;
        }
        if(customer.getElectric() != null){
            updateCustomerContact(customer, customer.getElectric(), CustomerContact.TYPE_ELECTRIC);
        }
        if(customer.getWater() != null){
            updateCustomerContact(customer, customer.getWater(), CustomerContact.TYPE_WATER);
        }
        if(customer.getSafe() != null){
            updateCustomerContact(customer, customer.getSafe(), CustomerContact.TYPE_SAFE);
        }
        if(customer.getVisual() != null){
            updateCustomerContact(customer, customer.getVisual(), CustomerContact.TYPE_VISUAL);
        }
        if(customer.getEmergency() != null){
            updateCustomerContact(customer, customer.getEmergency(), CustomerContact.TYPE_EMERGENCY);
        }
        return executeResult;
    }

    @Override
    public ServiceResult<Customer> getById(Long id) {
        ServiceResult<Customer> executeResult = new ServiceResult<Customer>();
        Customer customer = customerDao.getById(id);
        setCustomerContact(customer);
        executeResult.setResult(customer);
        return executeResult;
    }

    @Override
    public ServiceResult<Customer> updateToOpenSea(Customer customer) {
        ServiceResult<Customer> executeResult = new ServiceResult<Customer>();
        Customer dbCustomer = customerDao.getById(customer.getId());
        if(dbCustomer == null){
            executeResult.setMessage("该客户不存在或已经被删除。");
            return executeResult;
        }
        customerDao.updateToOpenSea(customer);
        return executeResult;
    }
}
