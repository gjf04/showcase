package com.admin.controller.api;

import com.admin.entity.customer.Customer;
import com.admin.entity.order.Orders;
import com.admin.entity.order.OrderFeedback;
import com.admin.entity.order.Orders;
import com.admin.entity.system.UserInfo;
import com.admin.service.order.OrderFeedbackService;
import com.admin.service.order.OrdersService;
import com.admin.service.system.ResourceInfoService;
import com.admin.service.system.UserInfoService;
import com.admin.web.util.*;
import com.gao.common.BusinessException;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;
import com.gao.common.util.JsonUtil;
import com.google.common.base.Throwables;
import com.google.common.collect.Maps;
import lombok.extern.slf4j.Slf4j;
import org.apache.log4j.LogManager;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

/**
 *
 * Created by GaoJingFei on 2018/1/11.
 */

@Controller  
@RequestMapping("/api")
@Slf4j
public class AppOrdersController {
    private final static org.apache.log4j.Logger logger = LogManager.getLogger(AppOrdersController.class);
    @Resource
    private UserInfoService userInfoService;
    @Resource
    private OrdersService ordersService;
    @Resource
    private OrderFeedbackService orderFeedbackService;

    @RequestMapping(value = "/searchOrders", method = { RequestMethod.GET, RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void searchOrders(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="userId",required = true) String userId,
            @RequestParam(value="customerName",required = false) String customerName,
            @RequestParam(value="startAt",required = false) String startAt,
            @RequestParam(value="endAt",required = false) String endAt,
            @RequestParam(value="status",required = false) String status,
            @RequestParam(value="pageSize",required = true) String pageSize,
            @RequestParam(value="pageIndex",required = true) String pageIndex,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppOrdersController][searchOrders] /searchOrders accepted token:{}, userId:{}, customerName:{}, startAt:{}, endAt:{}, status:{}",
                token, userId, customerName, startAt, endAt, status);
        Map<String, Object> dataMap = new HashMap<String, Object>();
        Map <String, Object> criteria = Maps.newHashMap();
        dataMap.put("success", true);
        if(userId == null || "".equals(userId)){
            log.error("获取当前登录用户异常,userId不能为空");
            dataMap.put("success", false);
            dataMap.put("error", "");
            dataMap.put("msg", "获取当前登录用户异常,userId不能为空");
        }
        try {
            dataMap = VerifyTokenUtil.verify(request, dataMap);
            if (VerifyTokenUtil.VERIFY_SUCCESS.equals(dataMap.get("verifyPassed").toString())) {
                ServiceResult<UserInfo> userResult = userInfoService.getById(Long.parseLong(userId));
                if (!userResult.getSuccess()) {
                    log.error(userResult.getMessage());
                    dataMap.put("success", false);
                    dataMap.put("error", "");
                    dataMap.put("msg", "获取当前登录用户异常");
                }else{
                    //UserInfo user = userResult.getResult();
                    if(customerName != null && !"".equals(customerName)){
                        criteria.put("customerName", customerName);
                    }
                    if(startAt != null && !"".equals(startAt)){
                        criteria.put("createdAtStart", startAt);
                    }
                    if(endAt != null && !"".equals(endAt)){
                        criteria.put("createdAtEnd", endAt);
                    }
                    if(status != null && !"".equals(status)){
                        criteria.put("status", status);
                    }
                    PagerInfo pager = new PagerInfo(Integer.parseInt(pageSize), Integer.parseInt(pageIndex));
                    ServiceResult<Map<String, Object>> serviceResult = ordersService.searchOrders(criteria, pager);
                    if(serviceResult.getSuccess()){
                        Map<String, Object> map = serviceResult.getResult();
                        if(map!=null&&map.size()>0){
                            List<Orders> list = (List<Orders>)map.get("data");
                            List< Map<String, Object>> ordersList = new ArrayList<Map<String, Object>>();
                            for(Orders cus : list){
                                Map<String, Object> orders = new HashMap<String, Object>();
                                orders.put("id", cus.getId());
                                orders.put("customerName", cus.getCustomerName());
                                //合同状态。0已保存待提交 1待内勤初审 2总监审核 3合同上传 4签订完成
                                String s = "已保存待提交";
                                if(cus.getApprovalStatus().equals(1)){
                                    s = "待内勤初审";
                                }
                                if(cus.getApprovalStatus().equals(2)){
                                    s = "总监审核";
                                }
                                if(cus.getApprovalStatus().equals(3)){
                                    s = "合同上传";
                                }
                                if(cus.getApprovalStatus().equals(4)){
                                    s = "签订完成";
                                }
                                orders.put("approvalStatus", s);
                                orders.put("responsiblePerson", "");//TODO
                                orders.put("description", "");//TODO
                                orders.put("preInstallAt", DateUtil.format(DateUtil.format5, cus.getPreInstallAt()));
                                orders.put("completedStatus", "待验收");//TODO
                                ordersList.add(orders);
                            }
                            int total = (Integer)map.get("total");
                            dataMap.put("total", total);
                            dataMap.put("ordersList", ordersList);
                        }
                    }
                }
            }
        }catch (Exception e) {
            log.error("[AppOrdersController][searchOrders] /searchOrders accepted token:{}, userId:{}, customerName:{}, error:{}",
                    token, userId, customerName, Throwables.getStackTraceAsString(e));
            dataMap.put("success", false);
            dataMap.put("error", "105");
            dataMap.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(JsonUtil.toJson(dataMap));
        response.getWriter().flush();
        response.getWriter().close();
    }

    /**
     * 订单跟进反馈
     * @param request
     * @return
     */
    @RequestMapping(value = "/createOrderFeedback", method = { RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void createOrderFeedback(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="userId",required = true) String userId,
            @RequestParam(value="orderId",required = true) String orderId,
            @RequestParam(value="responsiblePerson",required = true) String responsiblePerson,
            @RequestParam(value="description",required = true) String description,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppOrdersController][createOrderFeedback] accepted token:{}, userId:{}, orderId:{}, responsiblePerson:{}, description:{}",
                token, userId, orderId, responsiblePerson, description);
        Map<String, Object> dataMap = new HashMap<String, Object>();
        dataMap.put("success", true);
        try {
            dataMap = VerifyTokenUtil.verify(request, dataMap);
            if (VerifyTokenUtil.VERIFY_SUCCESS.equals(dataMap.get("verifyPassed").toString())) {
                ServiceResult<UserInfo> userResult = userInfoService.getById(Long.parseLong(userId));
                if (!userResult.getSuccess()) {
                    log.error(userResult.getMessage());
                    dataMap.put("success", false);
                    dataMap.put("error", "");
                    dataMap.put("msg", "获取当前登录用户异常");
                }else{
                    UserInfo user = userResult.getResult();
                    ServiceResult<Orders> ordersResult = ordersService.getById(Long.parseLong(orderId));
                    if(ordersResult != null && ordersResult.getSuccess() && ordersResult.getResult() != null){
                        Orders orders = ordersResult.getResult();
                        OrderFeedback orderFeedback = new OrderFeedback();
                        orderFeedback.setOrderId(Integer.parseInt(orderId));
                        orderFeedback.setCustomerId(0);
                        orderFeedback.setCustomerCode(orders.getCustomerCode());
                        orderFeedback.setCustomerName(orders.getCustomerName());
                        orderFeedback.setResponsiblePerson(responsiblePerson);
                        orderFeedback.setDescription(description);
                        orderFeedback.setCreatedBy(String.valueOf(request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_NICK_NAME)));
                        orderFeedback.setUpdatedBy(String.valueOf(request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_NICK_NAME)));
                        ServiceResult<OrderFeedback> result = orderFeedbackService.createOrderFeedback(orderFeedback);
                        if (!result.getSuccess()) {
                            log.error("app订单跟进反馈保存失败！");
                            dataMap.put("success", false);
                            dataMap.put("error", "");
                            dataMap.put("msg", "app订单跟进反馈保存失败" + result.getMessage());
                        }
                    }else{
                        log.error("根据订单id获取订单信息失败，请检查后重试");
                        dataMap.put("success", false);
                        dataMap.put("error", "");
                        dataMap.put("msg", "根据订单id获取订单信息失败，请检查后重试,orderId=" + orderId);
                    }

                }
            }
        }catch (Exception e) {
            log.error("[AppOrdersController][createOrderFeedback] accepted token:{}, userId:{}, orderId:{}, responsiblePerson:{}, description:{}, error:{}",
                    token, userId, orderId, responsiblePerson, description, Throwables.getStackTraceAsString(e));
            dataMap.put("success", false);
            dataMap.put("error", "105");
            dataMap.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(JsonUtil.toJson(dataMap));
        response.getWriter().flush();
        response.getWriter().close();
    }

    /**
     * 预约安装时间
     * @param request
     * @return
     */
    @RequestMapping(value = "/preInstallTime", method = { RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void preInstallTime(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="userId",required = true) String userId,
            @RequestParam(value="orderId",required = true) String orderId,
            @RequestParam(value="installAt",required = true) String installAt,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppOrdersController][preInstallTime] accepted token:{}, userId:{}, orderId:{}, installAt:{}",
                token, userId, orderId, installAt);
        Map<String, Object> dataMap = new HashMap<String, Object>();
        dataMap.put("success", true);
        try {
            dataMap = VerifyTokenUtil.verify(request, dataMap);
            if (VerifyTokenUtil.VERIFY_SUCCESS.equals(dataMap.get("verifyPassed").toString())) {
                ServiceResult<UserInfo> userResult = userInfoService.getById(Long.parseLong(userId));
                if (!userResult.getSuccess()) {
                    log.error(userResult.getMessage());
                    dataMap.put("success", false);
                    dataMap.put("error", "");
                    dataMap.put("msg", "获取当前登录用户异常");
                }else{
                    //UserInfo user = userResult.getResult();
                    ServiceResult<Orders> ordersResult = ordersService.getById(Long.parseLong(orderId));
                    if(ordersResult != null && ordersResult.getSuccess() && ordersResult.getResult() != null){
                        //Orders orders = ordersResult.getResult();
                        Orders updateOrder = new Orders();
                        updateOrder.setId(Long.parseLong(orderId));
                        updateOrder.setPreInstallAt(DateUtil.parse(DateUtil.format5, installAt));
                        updateOrder.setUpdatedBy(String.valueOf(request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_NICK_NAME)));
                        ServiceResult<Orders> result = ordersService.updateOrders(updateOrder);
                        if (!result.getSuccess()) {
                            log.error("app订单预约安装时间失败！");
                            dataMap.put("success", false);
                            dataMap.put("error", "");
                            dataMap.put("msg", "app订单预约安装时间失败" + result.getMessage());
                        }
                    }else{
                        log.error("根据订单id获取订单信息失败，请检查后重试");
                        dataMap.put("success", false);
                        dataMap.put("error", "");
                        dataMap.put("msg", "根据订单id获取订单信息失败，请检查后重试,orderId=" + orderId);
                    }

                }
            }
        }catch (Exception e) {
            log.error("[AppOrdersController][preInstallTime] accepted token:{}, userId:{}, orderId:{}, installAt:{}, error:{}",
                    token, userId, orderId, installAt, Throwables.getStackTraceAsString(e));
            dataMap.put("success", false);
            dataMap.put("error", "105");
            dataMap.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(JsonUtil.toJson(dataMap));
        response.getWriter().flush();
        response.getWriter().close();
    }

}  