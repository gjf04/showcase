package com.admin.service.impl.order;

import com.admin.dao.order.OrderFeedbackDao;
import com.admin.entity.order.OrderFeedback;
import com.admin.service.order.OrderFeedbackService;
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
public class OrderFeedbackServiceImpl implements OrderFeedbackService {
    @Autowired
    private OrderFeedbackDao orderFeedbackDao;

    @Override
    public ServiceResult<Map<String, Object>> searchOrderFeedbacks(Map<String, Object> params, PagerInfo pagerInfo) {
        ServiceResult<Map<String, Object>> result = new ServiceResult<Map<String, Object>>();
        Map<String, Object> map = new HashMap<String, Object>();
        // 记录总数
        int rowsCount = orderFeedbackDao.queryCountBy(params);
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
        List<OrderFeedback> orders = orderFeedbackDao.queryListBy(params);
        map.put("data", orders);
        map.put("total", rowsCount);
        result.setResult(map);
        return result;
    }

    @Override
    public ServiceResult<OrderFeedback> createOrderFeedback(OrderFeedback orderFeedback) {
        ServiceResult<OrderFeedback> executeResult = new ServiceResult<OrderFeedback>();
        orderFeedback.setCreatedAt(new Date());
        orderFeedback.setUpdatedAt(new Date());
        orderFeedbackDao.insert(orderFeedback);
        executeResult.setResult(orderFeedback);
        return executeResult;
    }
    @Override
    public ServiceResult<OrderFeedback> updateOrderFeedback(OrderFeedback orderFeedback) {
        ServiceResult<OrderFeedback> executeResult = new ServiceResult<OrderFeedback>();
        OrderFeedback dbOrderFeedback = orderFeedbackDao.getById(orderFeedback.getId());
        if(dbOrderFeedback == null){
            executeResult.setMessage("该客户不存在或已经被删除。");
            return executeResult;
        }
//        dbOrder.setStatus(order.getStatus());
//        dbOrder.setPassword(order.getPassword());
        dbOrderFeedback.setResponsiblePerson(orderFeedback.getResponsiblePerson());
        dbOrderFeedback.setUpdatedBy(orderFeedback.getUpdatedBy());
        dbOrderFeedback.setUpdatedAt(new Date());
        orderFeedbackDao.update(dbOrderFeedback);
        return executeResult;
    }
}
