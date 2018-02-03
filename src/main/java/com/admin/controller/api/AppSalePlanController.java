package com.admin.controller.api;

import com.admin.entity.sale.plan.SalePlan;
import com.admin.entity.system.UserInfo;
import com.admin.service.sale.plan.SalePlanService;
import com.admin.service.system.UserInfoService;
import com.admin.web.util.HttpJsonResult;
import com.admin.web.util.ReadExcelUtils;
import com.admin.web.util.WebUtil;
import com.gao.common.BusinessException;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;
import com.gao.common.util.JsonUtil;
import com.google.common.base.Throwables;
import com.google.common.collect.Maps;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.*;

/**
 * 销售计划-api 接口 Controller
 * @author GaoJingFei
 * @version 2018-1-11
 */

@Controller
@RequestMapping("/api")
@Slf4j
public class AppSalePlanController {
    @Resource
    private UserInfoService userInfoService;
    @Autowired
    private SalePlanService salePlanService;

    @RequestMapping(value = "/createSalePlan", method = { RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void createSalePlan(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="userId",required = true) String userId,
            @RequestParam(value="userName",required = true) String userName,
            @RequestParam(value="planYear",required = true) String planYear,
            @RequestParam(value="planMonth",required = true) String planMonth,
            @RequestParam(value="planAmt",required = true) String planAmt,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppSalePlanController][createSalePlan] /createSalePlan accepted token:{}, userId:{}, userName:{}, planYear:{}, planMonth:{}, planAmt:{}",
                token, userId, userName, planYear, planMonth, planAmt);
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
                    Double db = 0.00;
                    SalePlan salePlan = new SalePlan();
                    salePlan.setUserId(userId);
                    salePlan.setUserName(userName);
                    salePlan.setPlanYear(Integer.parseInt(planYear));
                    salePlan.setPlanMonth(Integer.parseInt(planMonth));
                    salePlan.setPlanAmt(db.valueOf(planAmt));
                    salePlan.setCreatedBy("system");
                    salePlan.setUpdatedBy("system");

                    ServiceResult<SalePlan> result = salePlanService.create(salePlan);
                    if (!result.getSuccess()) {
                        log.error("新增失败！");
                        dataMap.put("success", false);
                        dataMap.put("error", "");
                        dataMap.put("msg", "新增失败" + result.getMessage());
                    }
                }
            }
        }catch (Exception e) {
            log.error("[AppSalePlanController][createSalePlan] /createSalePlan accepted token:{}, userId:{}, userName:{}, planYear:{}, planMonth:{}, planAmt:{}",
                    token, userId, userName, planYear, planMonth, planAmt, Throwables.getStackTraceAsString(e));
            dataMap.put("success", false);
            dataMap.put("error", "105");
            dataMap.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(JsonUtil.toJson(dataMap));
        response.getWriter().flush();
        response.getWriter().close();
    }

    @RequestMapping(value = "/searchSalePlan", method = { RequestMethod.GET, RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void searchSalePlan(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="userId",required = true) String userId,
            @RequestParam(value="userName",required = false) String userName,
            @RequestParam(value="pageSize",required = true) String pageSize,
            @RequestParam(value="pageIndex",required = true) String pageIndex,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppSalePlanController][searchSalePlan] /searchSalePlan accepted token:{}, userId:{}, userName:{}",
                token, userId, userName);
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
                    if(userName != null && !"".equals(userName)){
                        criteria.put("userName", userName);
                    }
                    PagerInfo pager = new PagerInfo(Integer.parseInt(pageSize), Integer.parseInt(pageIndex));
                    ServiceResult<Map<String, Object>> serviceResult = salePlanService.search(criteria, pager);
                    if(serviceResult.getSuccess()){
                        Map<String, Object> map = serviceResult.getResult();
                        if(map!=null&&map.size()>0){
                            List<SalePlan> list = (List<SalePlan>)map.get("data");
                            List< Map<String, Object>> salePlanList = new ArrayList<Map<String, Object>>();
                            for(SalePlan cus : list){
                                Map<String, Object> salePlan = new HashMap<String, Object>();
                                salePlan.put("userName", cus.getUserName());
                                salePlan.put("planYear", cus.getPlanYear());
                                salePlan.put("planMonth", cus.getPlanMonth());
                                salePlan.put("planAmt", cus.getPlanAmt());
                                salePlanList.add(salePlan);
                            }
                            int total = (Integer)map.get("total");
                            dataMap.put("total", total);
                            dataMap.put("salePlanList", salePlanList);
                        }
                    }
                }
            }
        }catch (Exception e) {
            log.error("[AppSalePlanController][searchSalePlan] /searchSalePlan accepted token:{}, userId:{}, userName:{}, error:{}",
                    token, userId, userName, Throwables.getStackTraceAsString(e));
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
