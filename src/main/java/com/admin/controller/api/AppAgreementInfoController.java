package com.admin.controller.api;

import com.admin.entity.agreement.AgreementInfo;
import com.admin.entity.salary.base.SalaryBaseRule;
import com.admin.entity.system.UserInfo;
import com.admin.service.agreement.AgreementService;
import com.admin.service.salary.base.SalaryBaseRuleService;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 合同-api 接口 Controller
 * @author wangshuaishuai
 * @version 2018-1-14
 */
@Controller  
@RequestMapping("/api")
@Slf4j
public class AppAgreementInfoController {
    @Resource
    private UserInfoService userInfoService;

    @Resource
    private AgreementService agreementService;

    @RequestMapping(value = "/searchAgreementInfo", method = { RequestMethod.GET, RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void searchAgreementInfo(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="userId",required = true) String userId,
            @RequestParam(value="post",required = false) String post,
            @RequestParam(value="pageSize",required = true) String pageSize,
            @RequestParam(value="pageIndex",required = true) String pageIndex,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppAgreementInfoController][searchAgreementInfo] /searchAgreementInfo accepted token:{}, userId:{}, post:{}",
                token, userId, post);
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
                    ServiceResult<Map<String, Object>> serviceResult = agreementService.getAgreementList(criteria, pager);
                    if(serviceResult.getSuccess()){
                        Map<String, Object> map = serviceResult.getResult();
                        if(map!=null&&map.size()>0){
                            List<AgreementInfo> list = (List<AgreementInfo>)map.get("data");
                            List< Map<String, Object>> infoResultList = new ArrayList<Map<String, Object>>();
                            for(AgreementInfo info : list){
                                Map<String, Object> infoResult = new HashMap<String, Object>();
                                infoResult.put("id", info.getId());
                                infoResult.put("agreeSn", info.getAgreeSn());
                                infoResult.put("firstParty", info.getFirstParty());
                                infoResult.put("contactName", info.getContactName());
                                infoResult.put("serviceLife", info.getServiceLife());
                                infoResult.put("projectName", info.getProjectName());
                                infoResult.put("hardwareAll", info.getHardwareAll());
                                infoResult.put("installAll", info.getInstallAll());
                                infoResult.put("serviceAll", info.getServiceAll());
                                infoResult.put("expensesAll", info.getExpensesAll());
                                infoResult.put("payablesAll", info.getPayablesAll());
                                infoResult.put("serviceYearAll", info.getServiceYearAll());
                                infoResult.put("serviceMonth", info.getServiceMonth());
                                infoResult.put("serviceDay", info.getServiceDay());
                                infoResult.put("agreementAmount", info.getAgreementAmount());
                                infoResult.put("agreementAmountUpper", info.getAgreementAmountUpper());
                                infoResult.put("firstRatio", info.getFirstRatio());
                                infoResult.put("lastRatio", info.getLastRatio());
                                infoResult.put("repairYears", info.getRepairYears());
                                infoResult.put("approvalStatus", info.getApprovalStatus());
                                infoResult.put("refuseInfo", info.getRefuseInfo());
                                infoResult.put("agreeDate", info.getAgreeDate());
                                infoResultList.add(infoResult);
                            }
                            int total = (Integer)map.get("total");
                            dataMap.put("total", total);
                            dataMap.put("agreementInfoList", infoResultList);
                        }
                    }
                }
            }
        }catch (Exception e) {
            log.error("[AppAgreementInfoController][searchAgreementInfo] /searchAgreementInfo accepted token:{}, userId:{}, post:{}, error:{}",
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

    @RequestMapping(value = "/searchAgreementDetailById", method = { RequestMethod.GET, RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void searchAgreementDetailById(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="userId",required = true) String userId,
            @RequestParam(value="agreementId",required = true) String agreementId,
            @RequestParam(value="post",required = false) String post,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppAgreementInfoController][searchAgreementInfo] /searchAgreementDetailById accepted token:{}, userId:{},agreementId:{}, post:{}",
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
                    AgreementInfo agreementInfo = new AgreementInfo();
                    agreementInfo.setId(Long.valueOf(agreementId));
                    ServiceResult<AgreementInfo> serviceResult = agreementService.selectAgreementInfoById(agreementInfo);
                    if(serviceResult!=null && serviceResult.getSuccess()&& serviceResult.getResult()!=null ){
                        Map<String, Object> infoResult = new HashMap<String, Object>();
                        AgreementInfo info = serviceResult.getResult();
                        infoResult.put("agreeSn", info.getAgreeSn());
                        infoResult.put("firstParty", info.getFirstParty());
                        infoResult.put("contactName", info.getContactName());
                        infoResult.put("serviceLife", info.getServiceLife());
                        infoResult.put("projectName", info.getProjectName());
                        infoResult.put("hardwareAll", info.getHardwareAll());
                        infoResult.put("installAll", info.getInstallAll());
                        infoResult.put("serviceAll", info.getServiceAll());
                        infoResult.put("expensesAll", info.getExpensesAll());
                        infoResult.put("payablesAll", info.getPayablesAll());
                        infoResult.put("serviceYearAll", info.getServiceYearAll());
                        infoResult.put("serviceMonth", info.getServiceMonth());
                        infoResult.put("serviceDay", info.getServiceDay());
                        infoResult.put("agreementAmount", info.getAgreementAmount());
                        infoResult.put("agreementAmountUpper", info.getAgreementAmountUpper());
                        infoResult.put("firstRatio", info.getFirstRatio());
                        infoResult.put("lastRatio", info.getLastRatio());
                        infoResult.put("repairYears", info.getRepairYears());
                        infoResult.put("approvalStatus", info.getApprovalStatus());
                        infoResult.put("refuseInfo", info.getRefuseInfo());
                        infoResult.put("agreeDate", info.getAgreeDate());

                        dataMap.put("agreementInfo", infoResult);
                    }
                }
            }
        }catch (Exception e) {
            log.error("[AppAgreementInfoController][searchAgreementDetailById] /searchAgreementDetailById accepted token:{}, userId:{}, post:{}, error:{}",
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