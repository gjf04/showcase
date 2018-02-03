package com.admin.service.order;
import com.admin.entity.customer.Customer;
import com.admin.entity.order.Orders;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;

import java.util.Map;

/**
 * Created by GaoJingFei on 2017/12/13.
 */

public interface OrdersService {

    /**
     * 分页查询
     * @param params
     * @param pagerInfo
     * @return
     */
    public ServiceResult<Map<String, Object>> searchOrders(Map<String, Object> params, PagerInfo pagerInfo);

    /**
     * 创建
     * @param orders
     */
    public ServiceResult<Orders> createOrders(Orders orders);

    /**
     * 更新
     * @param orders
     */
    public ServiceResult<Orders> updateOrders(Orders orders);

    /**
     * 根据id获取
     * @param id
     */
    public ServiceResult<Orders> getById(Long id);
}
