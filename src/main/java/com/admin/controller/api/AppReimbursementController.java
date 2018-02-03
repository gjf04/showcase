package com.admin.controller.api;

import com.admin.entity.reimbursement.Reimbursement;
import com.admin.entity.reimbursement.Reimbursement;
import com.admin.entity.system.UserInfo;
import com.admin.service.reimbursement.ReimbursementService;
import com.admin.service.system.UserInfoService;
import com.admin.web.util.DateUtil;
import com.admin.web.util.HttpJsonResult;
import com.admin.web.util.SessionSecurityConstants;
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
 * 报销管理-api接口 Controller
 * @author GaoJingFei
 * @version 2018-1-11
 */

@Controller
@RequestMapping("/api")
@Slf4j

public class AppReimbursementController {
    @Resource
    private UserInfoService userInfoService;
    @Autowired
    private ReimbursementService reimbursementService;

    @RequestMapping(value = "/searchReimbursement", method = { RequestMethod.GET, RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void searchReimbursement(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="userId",required = true) String userId,
            @RequestParam(value="startAt",required = false) String startAt,
            @RequestParam(value="endAt",required = false) String endAt,
            @RequestParam(value="style",required = false) String style,
            @RequestParam(value="pageSize",required = true) String pageSize,
            @RequestParam(value="pageIndex",required = true) String pageIndex,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppReimbursementController][searchReimbursement] /searchReimbursement accepted token:{}, userId:{}, startAt:{}, endAt:{}, style:{}",
                token, userId,  startAt, endAt, style);
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
                    if(userId != null && !"".equals(userId)){
                        criteria.put("userId", userId);
                    }
                    if(startAt != null && !"".equals(startAt)){
                        criteria.put("createdAtStart", startAt);
                    }
                    if(endAt != null && !"".equals(endAt)){
                        criteria.put("createdAtEnd", endAt);
                    }
                    if(style != null && !"".equals(style)){
                        criteria.put("style", style);
                    }

                    PagerInfo pager = new PagerInfo(Integer.parseInt(pageSize), Integer.parseInt(pageIndex));
                    ServiceResult<Map<String, Object>> serviceResult = reimbursementService.search(criteria, pager);
                    if(serviceResult.getSuccess()){
                        Map<String, Object> map = serviceResult.getResult();
                        if(map!=null&&map.size()>0){
                            List<Reimbursement> list = (List<Reimbursement>)map.get("data");
                            List< Map<String, Object>> reimbursementList = new ArrayList<Map<String, Object>>();
                            for(Reimbursement cus : list){
                                Map<String, Object> reimbursement = new HashMap<String, Object>();
                                reimbursement.put("userName", cus.getUserName());
                                reimbursement.put("style", cus.getStyle());
                                reimbursement.put("feeAmt", cus.getFeeAmt());
                                reimbursement.put("feeDate", DateUtil.format(DateUtil.format5, cus.getFeeDate()));
                                reimbursement.put("createdAt", DateUtil.format(DateUtil.format5, cus.getCreatedAt()));
                                //审核状态 初始:0 提交:1 总监已审:2 财务已审:3 打回:4
                                String s = "初始";
                                if(cus.getApprovalState().equals(1)){
                                    s = "提交";
                                }
                                if(cus.getApprovalState().equals(2)){
                                    s = "总监已审";
                                }
                                if(cus.getApprovalState().equals(3)){
                                    s = "财务已审";
                                }
                                if(cus.getApprovalState().equals(4)){
                                    s = "打回";
                                }
                                reimbursement.put("approvalState", s);
                                reimbursement.put("approvalMan", cus.getApprovalMan());
                                reimbursement.put("approvalDate", DateUtil.format(DateUtil.format5, cus.getApprovalDate()));
                                reimbursement.put("caiwuMan", cus.getStyle());
                                reimbursement.put("caiwuDate", DateUtil.format(DateUtil.format5, cus.getCaiwuDate()));
                                reimbursementList.add(reimbursement);
                            }
                            int total = (Integer)map.get("total");
                            dataMap.put("total", total);
                            dataMap.put("reimbursementList", reimbursementList);
                        }
                    }
                }
            }
        }catch (Exception e) {
            log.error("[AppReimbursementController][searchReimbursement] /searchReimbursement accepted token:{}, userId:{},  error:{}",
                    token, userId,  Throwables.getStackTraceAsString(e));
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
