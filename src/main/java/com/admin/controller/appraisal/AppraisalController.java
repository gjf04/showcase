/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.admin.controller.appraisal;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.admin.entity.appraisal.Appraisal;
import com.admin.entity.appraisal.AppraisalUser;
import com.admin.service.appraisal.AppraisalService;
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
 * 考评激励 Controller
 * @author CongLin
 * @version 2018-01-03
 */
@Controller  
@RequestMapping("/appraisal")
@Slf4j
public class AppraisalController {

	@Resource
	private AppraisalService appraisalService;
	
    @RequestMapping(value = "appraisal.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(HttpServletRequest request,Map<String, Object> dataMap) throws Exception {
        return "appraisal/appraisal";
    }

    @RequestMapping("/list")	
	public void list(HttpServletRequest request, HttpServletResponse response, Map<String, Object> dataMap) {
		
        Map <String, Object> criteria = Maps.newHashMap();
        try {
            String month = request.getParameter("q_month");
            String year = request.getParameter("q_year");
            if(month != null && !"".equals(month)){
                criteria.put("month", month);
            }
            if(year != null && !"".equals(year)){
                criteria.put("year", year);
            }
            PagerInfo pager = WebUtil.handlerPagerInfo(request, dataMap);
            ServiceResult<Map<String, Object>> serviceResult = appraisalService.search(criteria, pager);
            if(serviceResult.getSuccess()){
                Map<String, Object> map = serviceResult.getResult();
                if(map!=null&&map.size()>0){
                    List<Appraisal> list = (List<Appraisal>)map.get("data");
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
        ServiceResult<Appraisal> result = null;
        Appraisal entity = null;
        int score = 0;
        String itemScores = "";
        String itemIds = "1,2,3,4";//TODO:目前固定考评项，后期可以动态，表结构已有
        
        String[] userIds = request.getParameterValues("addIds[]");
        String[] userNames = request.getParameterValues("addNames[]");
        String[] part1 = request.getParameterValues("part1[]");
        String[] part2 = request.getParameterValues("part2[]");
        String[] part3 = request.getParameterValues("part3[]");
        String[] part4 = request.getParameterValues("part4[]");
        String year = request.getParameter("year");
        String month = request.getParameter("month");
        
        for(int i=0; i<userIds.length; i++) {
        	entity = new Appraisal();
        	entity.setCreatedBy("system");
            entity.setUpdatedBy("system");
            entity.setUserId(userIds[i]);
            entity.setUserName(userNames[i]);
            entity.setMonth(month);
            entity.setYear(year);
            
            score = 0;
            score = null == part1[i]||part1[i].trim().equals("")?0:Integer.parseInt(part1[i]);
            score+= null == part2[i]||part2[i].trim().equals("")?0:Integer.parseInt(part2[i]);
            score+= null == part3[i]||part3[i].trim().equals("")?0:Integer.parseInt(part3[i]);
            score+= null == part4[i]||part4[i].trim().equals("")?0:Integer.parseInt(part4[i]);
            
            itemScores = part1[i]+","+part2[i]+","+part3[i]+","+part4[i];
            entity.setScore(score);
            entity.setItemScores(itemScores);
            entity.setItemIds(itemIds);
            
            result = appraisalService.create(entity);
            if (!result.getSuccess()) {
                log.error("新增考评激励失败！");
                jsonResult.setMessage("新增考评激励失败！");
                return jsonResult;
            }
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
        ServiceResult<Appraisal> result = null;
        Appraisal entity = null;
        int score = 0;
        String itemScores = "";
        
        String[] ids = request.getParameterValues("editIds[]");
        String[] userIds = request.getParameterValues("editUserIds[]");
        String[] userNames = request.getParameterValues("editNames[]");
        String[] part1 = request.getParameterValues("editPart1[]");
        String[] part2 = request.getParameterValues("editPart2[]");
        String[] part3 = request.getParameterValues("editPart3[]");
        String[] part4 = request.getParameterValues("editPart4[]");
        String[] itemIds = request.getParameterValues("editItemIds[]");
        String year = request.getParameter("year");
        String month = request.getParameter("month");
        
        
        for(int i=0; i<ids.length; i++) {
        	entity = new Appraisal();
        	 
        	entity.setId(Long.valueOf(ids[i]));
        	entity.setUserId(userIds[i]);
            entity.setUserName(userNames[i]);
            entity.setMonth(month);
            entity.setYear(year);
            
            score = 0;
            score = null == part1[i]||part1[i].trim().equals("")?0:Integer.parseInt(part1[i]);
            score+= null == part2[i]||part2[i].trim().equals("")?0:Integer.parseInt(part2[i]);
            score+= null == part3[i]||part3[i].trim().equals("")?0:Integer.parseInt(part3[i]);
            score+= null == part4[i]||part4[i].trim().equals("")?0:Integer.parseInt(part4[i]);
            
            itemScores = part1[i]+","+part2[i]+","+part3[i]+","+part4[i];
            entity.setScore(score);
            entity.setItemScores(itemScores);
            entity.setItemIds(itemIds[i]);
            
	        result = appraisalService.update(entity);
	        if (!result.getSuccess()) {
	            log.error("更新失败！");
	            jsonResult.setMessage("更新失败！");
	            return jsonResult;
	        }
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
       

        Appraisal entity = new Appraisal();
        
        String id = request.getParameter("id");
             
        entity.setId(Long.valueOf(id));
                 
        ServiceResult<Appraisal> result = appraisalService.delete(entity);
        if (!result.getSuccess()) {
            log.error("更新失败！");
            jsonResult.setMessage("更新失败！");
            return jsonResult;
        }
        
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }
 
    
    /**
     * 加载业务人员
     * @param request
     * @return
     */
    @RequestMapping(value = "/loadSalesman", method = RequestMethod.GET)
    @ResponseBody
    public Object loadSalesman(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
       
        Appraisal entity = new Appraisal();
        
        List<AppraisalUser> salesmanList = appraisalService.getSalesmanList();
        jsonResult.setData(salesmanList);

       return jsonResult;
    }
 
}