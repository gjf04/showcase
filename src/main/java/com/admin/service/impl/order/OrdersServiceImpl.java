package com.admin.service.impl.order;

import com.admin.dao.order.OrdersDao;
import com.admin.entity.customer.Customer;
import com.admin.entity.order.Orders;
import com.admin.service.order.OrdersService;
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
public class OrdersServiceImpl implements OrdersService {
    @Autowired
    private OrdersDao ordersDao;

    @Override
    public ServiceResult<Map<String, Object>> searchOrders(Map<String, Object> params, PagerInfo pagerInfo) {
        ServiceResult<Map<String, Object>> result = new ServiceResult<Map<String, Object>>();
        Map<String, Object> map = new HashMap<String, Object>();
        // 记录总数
        int rowsCount = ordersDao.queryCountBy(params);
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
        List<Orders> orderss = ordersDao.queryListBy(params);
        map.put("data", orderss);
        map.put("total", rowsCount);
        result.setResult(map);
        return result;
    }

    @Override
    public ServiceResult<Orders> createOrders(Orders orders) {
        ServiceResult<Orders> executeResult = new ServiceResult<Orders>();
        orders.setCreatedAt(new Date());
        orders.setUpdatedAt(new Date());
        ordersDao.insert(orders);
        executeResult.setResult(orders);
        return executeResult;
    }
    @Override
    public ServiceResult<Orders> updateOrders(Orders orders) {
        ServiceResult<Orders> executeResult = new ServiceResult<Orders>();
        Orders dbOrders = ordersDao.getById(orders.getId());
        if(dbOrders == null){
            executeResult.setMessage("该订单不存在或已经被删除。");
            return executeResult;
        }
//        dbOrders.setUpdatedBy(orders.getUpdatedBy());
//        dbOrders.setUpdatedAt(new Date());
        ordersDao.update(orders);
        return executeResult;
    }

    @Override
    public ServiceResult<Orders> getById(Long id) {
        ServiceResult<Orders> executeResult = new ServiceResult<Orders>();
        Orders orders = ordersDao.getById(id);
        executeResult.setResult(orders);
        return executeResult;
    }
}
