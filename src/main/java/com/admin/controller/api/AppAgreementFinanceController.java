package com.admin.controller.api;

import com.admin.entity.agreement.AgreementGoods;
import com.admin.entity.agreement.AgreementInfo;
import com.admin.entity.agreement.AgreementPay;
import com.admin.entity.system.UserInfo;
import com.admin.service.agreement.AgreementService;
import com.admin.service.system.UserInfoService;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;
import com.gao.common.util.JsonUtil;
import com.google.common.base.Throwables;
import com.google.common.collect.Maps;
import lombok.extern.slf4j.Slf4j;
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
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 合同-api 接口 Controller
 * @author wangshuaishuai
 * @version 2018-1-17
 */
@Controller  
@RequestMapping("/api")
@Slf4j
public class AppAgreementFinanceController {
    @Resource
    private UserInfoService userInfoService;

    @Resource
    private AgreementService agreementService;

    @RequestMapping(value = "/searchAgreementPayInfo", method = { RequestMethod.GET, RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void searchAgreementPayInfo(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="userId",required = true) String userId,
            @RequestParam(value="agreementId",required = true) String agreementId,
            @RequestParam(value="post",required = false) String post,
            @RequestParam(value="pageSize",required = true) String pageSize,
            @RequestParam(value="pageIndex",required = true) String pageIndex,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppAgreementFinanceController][searchAgreementPayInfo] /searchAgreementPayInfo accepted token:{}, userId:{},agreementId:{}, post:{}",
                token, userId,agreementId, post);
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
                    if(post != null && !"".equals(post)){
                        criteria.put("post", post);
                    }
                    PagerInfo pager = new PagerInfo(Integer.parseInt(pageSize), Integer.parseInt(pageIndex));
                    ServiceResult<Map<String, Object>> serviceResult = agreementService.selectAgreementPayByAgreeId(criteria, pager);
                    if(serviceResult.getSuccess()){
                        Map<String, Object> map = serviceResult.getResult();
                        if(map!=null&&map.size()>0){
                            List<AgreementPay> list = (List<AgreementPay>)map.get("data");
                            List< Map<String, Object>> infoResultList = new ArrayList<Map<String, Object>>();
                            for(AgreementPay info : list){
                                Map<String, Object> infoResult = new HashMap<String, Object>();
                                infoResult.put("userName", info.getUserName());
                                infoResult.put("shouldPay", info.getShouldPay());
                                infoResult.put("payAmount", info.getPayAmount());
                                infoResult.put("payType", info.getPayType());
                                infoResult.put("createdAt", info.getCreatedAt());
                                infoResult.put("remark", info.getRemark());
                                infoResultList.add(infoResult);
                            }
                            int total = (Integer)map.get("total");
                            dataMap.put("total", total);
                            dataMap.put("agreementPayInfoList", infoResultList);
                        }
                    }
                }
            }
        }catch (Exception e) {
            log.error("[AppAgreementInfoController][searchAgreementInfo] /searchAgreementPayInfo accepted token:{}, userId:{}, post:{}, error:{}",
                    token, userId, post, Throwables.getStackTraceAsString(e));
            dataMap.put("success", false);
            dataMap.put("error", "105");
            dataMap.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(JsonUtil.toJson(dataMap));
        response.getWriter().flush();
        response.getWriter().close();
    }


    @RequestMapping(value = "/saveAgreementPay", method = { RequestMethod.GET, RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void saveAgreementPay(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="userId",required = true) String userId,
            @RequestParam(value="agreeId",required = true) String agreeId,
            @RequestParam(value="shouldPay",required = true) String shouldPay,
            @RequestParam(value="payAmount",required = true) String payAmount,
            @RequestParam(value="userName",required = true) String userName,
            @RequestParam(value="payType",required = true) String payType,
            @RequestParam(value="remark",required = true) String remark,
            @RequestParam(value="post",required = false) String post,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppAgreementFinanceController][saveAgreementPay] /saveAgreementPay accepted token:{}, userId:{},agreementId:{}, post:{}",
                token, userId,agreeId, post);
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
                    if(post != null && !"".equals(post)){
                        criteria.put("post", post);
                    }
                    AgreementPay agreementPay = new AgreementPay();
                    agreementPay.setAgreeId(Long.valueOf(agreeId));
                    agreementPay.setShouldPay(new BigDecimal(shouldPay));
                    agreementPay.setPayAmount(new BigDecimal(payAmount));
                    agreementPay.setUserName(userName);
                    agreementPay.setPayType(Integer.valueOf(payType));
                    agreementPay.setRemark(remark);
                    ServiceResult<Boolean> serviceResult = agreementService.saveAgreementPay(agreementPay);
                    if(serviceResult!=null && serviceResult.getSuccess()){
                    }else{
                        dataMap.put("success", false);
                    }
                }
            }
        }catch (Exception e) {
            log.error("[AppAgreementInfoController][saveAgreementPay] /saveAgreementPay accepted token:{}, userId:{}, post:{}, error:{}",
                    token, userId, post, Throwables.getStackTraceAsString(e));
            dataMap.put("success", false);
            dataMap.put("error", "105");
            dataMap.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(JsonUtil.toJson(dataMap));
        response.getWriter().flush();
        response.getWriter().close();
    }

    @RequestMapping(value = "/saveAgreementPayRatio", method = { RequestMethod.GET, RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void saveAgreementPayRatio(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="userId",required = true) String userId,
            @RequestParam(value="agreeId",required = true) String agreeId,
            @RequestParam(value="firstRatio",required = true) String firstRatio,
            @RequestParam(value="lastRatio",required = true) String lastRatio,
            @RequestParam(value="post",required = false) String post,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppAgreementFinanceController][saveAgreementPay] /saveAgreementPay accepted token:{}, userId:{},agreementId:{}, post:{}",
                token, userId,agreeId, post);
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
                    if(post != null && !"".equals(post)){
                        criteria.put("post", post);
                    }
                    AgreementInfo agreement = new AgreementInfo();
                    agreement.setId(Long.valueOf(agreeId));
                    agreement.setFirstRatio(new BigDecimal(firstRatio));
                    agreement.setLastRatio(new BigDecimal(lastRatio));
                    List<AgreementGoods> agreementGoodsList = null;
                    ServiceResult<Boolean>  serviceResult = agreementService.updateAgreementInfo(agreement, agreementGoodsList);
                    if(serviceResult!=null && serviceResult.getSuccess()){
                    }else{
                        dataMap.put("success", false);
                    }
                }
            }
        }catch (Exception e) {
            log.error("[AppAgreementInfoController][saveAgreementPay] /saveAgreementPay accepted token:{}, userId:{}, post:{}, error:{}",
                    token, userId, post, Throwables.getStackTraceAsString(e));
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