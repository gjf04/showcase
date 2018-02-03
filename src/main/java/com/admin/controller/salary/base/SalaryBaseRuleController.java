/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.admin.controller.salary.base;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.admin.entity.salary.base.SalaryBaseRule;
import com.admin.service.salary.base.SalaryBaseRuleService;
import com.admin.web.util.HttpJsonResult;
import com.admin.web.util.WebUtil;
import com.google.common.base.Throwables;
import com.google.common.collect.Maps;
import com.gao.common.BusinessException;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;
import com.gao.common.util.JsonUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * 底薪设置Controller
 * @author CongLin
 * @version 2017-12-10
 */
@Controller  
@RequestMapping("/salary/base")
@Slf4j
public class SalaryBaseRuleController {

	@Resource
	private SalaryBaseRuleService salaryBaseRuleService;
	
    @RequestMapping(value = "ruleList.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(HttpServletRequest request,Map<String, Object> dataMap) throws Exception {
        return "salary/base/ruleList";
    }

    @RequestMapping("/ruleList")	
	public void list(HttpServletRequest request, HttpServletResponse response, Map<String, Object> dataMap) {
		
        Map <String, Object> criteria = Maps.newHashMap();
        try {
            String post = request.getParameter("q_post");
            if(post != null && !"".equals(post)){
                criteria.put("post", post);
            }
            PagerInfo pager = WebUtil.handlerPagerInfo(request, dataMap);
            ServiceResult<Map<String, Object>> serviceResult = salaryBaseRuleService.search(criteria, pager);
            if(serviceResult.getSuccess()){
                Map<String, Object> map = serviceResult.getResult();
                if(map!=null&&map.size()>0){
                    List<SalaryBaseRule> list = (List<SalaryBaseRule>)map.get("data");
                    int total = (Integer)map.get("total");
                    dataMap.put("total", total);
                    dataMap.put("rows", list);
                    response.setContentType("application/json;charset=UTF-8");
                    response.getWriter().write(JsonUtil.toJson(dataMap));
                    response.getWriter().flush();
                    response.getWriter().close();
                }
            }
        }catch (Exception e) {
            log.error("查询客户列表失败，error={},condition={}", Throwables.getStackTraceAsString(e),criteria);
            throw new BusinessException("查询客户列表失败");
        }

    	
    	//return "modules/salary/base/salaryBaseRuleList";
	}
    
    /**
     * 新增
     * @param request
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public Object create(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        SalaryBaseRule entity = new SalaryBaseRule();
        Double db = 0.00;
        
        String post = request.getParameter("post");
        String base = request.getParameter("base");
        String baseLevel = request.getParameter("baseLevel");
        String floatBase = request.getParameter("floatBase");
        String floatProportion = request.getParameter("floatProportion");
        String floatCompletionRate = request.getParameter("floatCompletionRate");
        
        
        entity.setPost(post);
        entity.setBase(Integer.parseInt(base));
        entity.setBaseLevel(Integer.parseInt(baseLevel));
        entity.setFloatBase(db.valueOf(floatBase));
        entity.setFloatProportion(floatProportion);
        entity.setFloatCompletionRate(floatCompletionRate);
        entity.setPercentageComplete(0.03);
        entity.setPercentageIncomplete(0.02);
        entity.setCreatedBy("system");
        entity.setUpdatedBy("system");
        
        ServiceResult<SalaryBaseRule> result = salaryBaseRuleService.create(entity);
        if (!result.getSuccess()) {
            log.error("新增底薪设置失败！");
            jsonResult.setMessage("新增底薪设置失败！");
            return jsonResult;
        }
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }

    /**
     * 更新
     * @param request
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Object update(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
       

        SalaryBaseRule entity = new SalaryBaseRule();
        Double db = 0.00;
        
        String id = request.getParameter("id");
        String post = request.getParameter("post");
        String base = request.getParameter("base");
        String baseLevel = request.getParameter("baseLevel");
        String floatBase = request.getParameter("floatBase");
        String floatProportion = request.getParameter("floatProportion");
        String floatCompletionRate = request.getParameter("floatCompletionRate");
        
        entity.setId(Long.valueOf(id));
        entity.setPost(post);
        entity.setBase(Integer.parseInt(base));
        entity.setBaseLevel(Integer.parseInt(baseLevel));
        entity.setFloatBase(db.valueOf(floatBase));
        entity.setFloatProportion(floatProportion);
        entity.setFloatCompletionRate(floatCompletionRate);
                
        ServiceResult<SalaryBaseRule> result = salaryBaseRuleService.update(entity);
        if (!result.getSuccess()) {
            log.error("更新失败！");
            jsonResult.setMessage("更新失败！");
            return jsonResult;
        }
        
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }
    /**
     * 删除
     * @param request
     * @return
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
       

        SalaryBaseRule entity = new SalaryBaseRule();
        
        String id = request.getParameter("id");
             
        entity.setId(Long.valueOf(id));
                 
        ServiceResult<SalaryBaseRule> result = salaryBaseRuleService.delete(entity);
        if (!result.getSuccess()) {
            log.error("更新失败！");
            jsonResult.setMessage("更新失败！");
            return jsonResult;
        }
        
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }
}