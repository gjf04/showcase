package com.admin.controller.sale.plan;


import com.admin.entity.sale.plan.SalePlan;
import com.admin.service.sale.plan.SalePlanService;
import com.admin.web.util.HttpJsonResult;
import com.admin.web.util.ReadExcelUtils;
import com.admin.web.util.WebUtil;
import com.google.common.base.Throwables;
import com.google.common.collect.Maps;
import com.gao.common.BusinessException;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;
import com.gao.common.util.JsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 销售计划Controller
 * @author WangDeYu
 * @version 2017-12-19
 */

@Controller
@RequestMapping("/sale/plan")
@Slf4j
public class SalePlanController {
    @Autowired
    private SalePlanService salePlanService;

    @RequestMapping(value = "saleplan.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(HttpServletRequest request, Map<String, Object> dataMap) throws Exception {
        return "sale/plan/saleplan";
    }

    @RequestMapping("/saleplan")
    public void list(HttpServletRequest request, HttpServletResponse response, Map<String, Object> dataMap) {

        Map <String, Object> criteria = Maps.newHashMap();
        try {
            String post = request.getParameter("userName");
            if(post != null && !"".equals(post)){
                criteria.put("userName", post);
            }
            PagerInfo pager = WebUtil.handlerPagerInfo(request, dataMap);
            ServiceResult<Map<String, Object>> serviceResult = salePlanService.search(criteria, pager);
            if(serviceResult.getSuccess()){
                Map<String, Object> map = serviceResult.getResult();
                if(map!=null&&map.size()>0){
                    List<SalePlan> list = (List<SalePlan>)map.get("data");
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
            log.error("查询列表失败，error={},condition={}", Throwables.getStackTraceAsString(e),criteria);
            throw new BusinessException("查询列表失败");
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
        SalePlan entity = new SalePlan();
        Double db = 0.00;

        String user_id = request.getParameter("userId");
        String user_name = request.getParameter("userName");
        String plan_year = request.getParameter("planYear");
        String plan_month = request.getParameter("planMonth");
        String plan_amt = request.getParameter("planAmt");


        entity.setUserId(user_id);
        if (user_name!=null && !"".equals(user_name)) {
            entity.setUserName(user_name);
        }

        entity.setPlanYear(Integer.parseInt(plan_year));
        entity.setPlanMonth(Integer.parseInt(plan_month));
        entity.setPlanAmt(db.valueOf(plan_amt));
        entity.setCreatedBy("system");
        entity.setUpdatedBy("system");

        ServiceResult<SalePlan> result = salePlanService.create(entity);
        if (!result.getSuccess()) {
            log.error("新增失败！");
            jsonResult.setMessage("新增失败！");
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


        SalePlan entity = new SalePlan();
        Double db = 0.00;

        String id = request.getParameter("id");
        String userId = request.getParameter("userId");
        String userName = request.getParameter("userName");
        String planYear = request.getParameter("planYear");
        String planMonth = request.getParameter("planMonth");
        String planAmt = request.getParameter("planAmt");

        entity.setId(Long.valueOf(id));
        entity.setUserId(userId);
        entity.setUserName(userName);
        entity.setPlanYear(Integer.parseInt(planYear));
        entity.setPlanMonth(Integer.parseInt(planMonth));
        entity.setPlanAmt(db.valueOf(planAmt));
        entity.setCreatedBy("system");
        entity.setUpdatedBy("system");

        ServiceResult<SalePlan> result = salePlanService.update(entity);
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


        SalePlan entity = new SalePlan();

        String id = request.getParameter("id");

        entity.setId(Long.valueOf(id));

        ServiceResult<SalePlan> result = salePlanService.delete(entity);
        if (!result.getSuccess()) {
            log.error("更新失败！");
            jsonResult.setMessage("更新失败！");
            return jsonResult;
        }

        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }

    /**
     * 处理上传文件请求
     * @throws IOException
     */
    @RequestMapping("/uploadfile")
    @ResponseBody
    public Object uploadAction(MultipartFile xlsFile, String location, ModelMap map, HttpServletRequest request) throws IOException {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        //获取文件名
        String name=xlsFile.getOriginalFilename();
        //文件数据
        byte[] bytes=xlsFile.getBytes();
        //存放路径
        String path=request.getSession().getServletContext().getRealPath("/WEB-INF/upload");
        File dir=new File(path);
        if(! dir.exists()){
            dir.mkdir();
        }
        File file = new File(dir,name);
        FileOutputStream out=new FileOutputStream(file);
        out.write(bytes);
        out.close();

        SalePlan entity = new SalePlan();

        try {
            String filepath = path + "\\" + name;
            ReadExcelUtils excelReader = new ReadExcelUtils(filepath);

            // 对读取Excel表格内容
            Map<Integer, Map<Integer,Object>> mapcontext = excelReader.readExcelContent();
            System.out.println("获得Excel表格的内容:");
            for (int i = 1; i <= mapcontext.size(); i++) {
                System.out.println(mapcontext.get(i));

                entity.setUserId(mapcontext.get(i).get(0).toString());
                entity.setUserName(mapcontext.get(i).get(1).toString());
                entity.setPlanYear(Integer.parseInt(mapcontext.get(i).get(2).toString()));
                entity.setPlanMonth(Integer.parseInt(mapcontext.get(i).get(3).toString()));
                entity.setPlanAmt(Double.parseDouble(mapcontext.get(i).get(4).toString()));
                entity.setUpdatedAt(new Date());
                entity.setUpdatedBy("System");
                ServiceResult<SalePlan> upfileobj = salePlanService.create(entity);
                if (!upfileobj.getSuccess()) {
                    log.error("Excel数据导入失败！");
                    jsonResult.setMessage("Excel数据导入失败！");
                    return jsonResult;
                }
                jsonResult.setData(upfileobj.getSuccess());
            }
        } catch (FileNotFoundException e) {
            System.out.println("未找到指定路径的文件!");
            e.printStackTrace();
        }catch (Exception e) {
            e.printStackTrace();
        }

        return jsonResult;
    }
}
