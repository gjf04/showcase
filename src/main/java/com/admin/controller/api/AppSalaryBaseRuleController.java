package com.admin.controller.api;

import com.admin.entity.salary.base.SalaryBaseRule;
import com.admin.entity.system.UserInfo;
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
 * 底薪-api 接口 Controller
 * @author GaoJingFei
 * @version 2018-1-12
 */
@Controller  
@RequestMapping("/api")
@Slf4j
public class AppSalaryBaseRuleController {
    @Resource
    private UserInfoService userInfoService;
	@Resource
	private SalaryBaseRuleService salaryBaseRuleService;

    @RequestMapping(value = "/searchSalaryBaseRule", method = { RequestMethod.GET, RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void searchSalaryBaseRule(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="userId",required = true) String userId,
            @RequestParam(value="post",required = false) String post,
            @RequestParam(value="pageSize",required = true) String pageSize,
            @RequestParam(value="pageIndex",required = true) String pageIndex,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppSalaryBaseRuleController][searchSalaryBaseRule] /searchSalaryBaseRule accepted token:{}, userId:{}, post:{}",
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
                    //UserInfo user = userResult.getResult();
                    if(post != null && !"".equals(post)){
                        criteria.put("post", post);
                    }
                    PagerInfo pager = new PagerInfo(Integer.parseInt(pageSize), Integer.parseInt(pageIndex));
                    ServiceResult<Map<String, Object>> serviceResult = salaryBaseRuleService.search(criteria, pager);
                    if(serviceResult.getSuccess()){
                        Map<String, Object> map = serviceResult.getResult();
                        if(map!=null&&map.size()>0){
                            List<SalaryBaseRule> list = (List<SalaryBaseRule>)map.get("data");
                            List< Map<String, Object>> salaryBaseRuleList = new ArrayList<Map<String, Object>>();
                            for(SalaryBaseRule cus : list){
                                Map<String, Object> salaryBaseRule = new HashMap<String, Object>();
                                String s = "";
                                if(cus.getPost().equals("1")){
                                    s = "业务员";
                                }
                                if(cus.getPost().equals("2")){
                                    s = "区域经理";
                                }
                                if(cus.getPost().equals("3")){
                                    s = "副总监";
                                }
                                salaryBaseRule.put("post", s);
                                salaryBaseRule.put("base", cus.getBase());
                                salaryBaseRule.put("baseLevel", cus.getBaseLevel());
                                salaryBaseRule.put("floatBase", cus.getFloatBase());
                                salaryBaseRule.put("floatProportion", cus.getFloatProportion());
                                salaryBaseRule.put("floatCompletionRate", cus.getFloatCompletionRate());
                                salaryBaseRule.put("percentageComplete", cus.getPercentageComplete());
                                salaryBaseRule.put("percentageIncomplete", cus.getPercentageIncomplete());
                                salaryBaseRuleList.add(salaryBaseRule);
                            }
                            int total = (Integer)map.get("total");
                            dataMap.put("total", total);
                            dataMap.put("salaryBaseRuleList", salaryBaseRuleList);
                        }
                    }
                }
            }
        }catch (Exception e) {
            log.error("[AppSalaryBaseRuleController][searchSalaryBaseRule] /searchSalaryBaseRule accepted token:{}, userId:{}, post:{}, error:{}",
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