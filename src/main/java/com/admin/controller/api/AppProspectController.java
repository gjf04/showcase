package com.admin.controller.api;

import com.admin.entity.system.Prospect;
import com.admin.entity.system.UserInfo;
import com.admin.service.system.ProspectService;
import com.admin.service.system.UserInfoService;
import com.admin.web.util.HttpJsonResult;
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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/api")
@Slf4j
public class AppProspectController {
    @Resource
    private UserInfoService userInfoService;
    @Resource
    private ProspectService prospectService;

    @RequestMapping(value = "/createProspect", method = { RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void createProspect(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="customerName",required = true) String customerName,
            @RequestParam(value="prospectAddress",required = false) String prospectAddress,
            @RequestParam(value="name",required = false) String name,
            @RequestParam(value="mobile",required = false) String mobile,
            @RequestParam(value="prospectConfirmTime",required = false) String prospectConfirmTime,
            @RequestParam(value="prospectContent",required = false) String prospectContent,
            @RequestParam(value="prospectRequire",required = false) String prospectRequire,
            HttpServletRequest request, HttpServletResponse response) throws IOException {
        log.info("[AppProspectController][createProspect] /createProspect accepted token:{}, customerName:{}", token, customerName);

        Map<String, Object> dataMap = new HashMap<String, Object>();
        dataMap.put("success", true);
        try {
            dataMap = VerifyTokenUtil.verify(request, dataMap);
            if (VerifyTokenUtil.VERIFY_SUCCESS.equals(dataMap.get("verifyPassed").toString())) {
                Date confirmDate = null;
                try
                {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    confirmDate = sdf.parse(prospectConfirmTime);
                }
                catch (ParseException e) {
                    dataMap.put("success", false);
                    dataMap.put("error", "");
                    dataMap.put("msg", "日期解析异常");
                }
                Prospect prospect = new Prospect();
                prospect.setCustomerName(customerName);
                prospect.setProspectAddress(prospectAddress);
                prospect.setName(name);
                prospect.setMobile(mobile);
                prospect.setProspectConfirmTime(confirmDate);
                prospect.setProspectContent(prospectContent);
                prospect.setProspectRequire(prospectRequire);
                prospect.setStatus(0);
                prospect.setCreatedBy("admin");
                prospect.setUpdatedBy("admin");
                ServiceResult<Integer> result = prospectService.insert(prospect);

                if (!result.getSuccess() || result.getResult() == 0) {
                    log.error("新增勘查派工单失败！");
                    dataMap.put("success", false);
                    dataMap.put("error", "");
                    dataMap.put("msg", "新增勘查派工单失败" + result.getMessage());
                }
            }

        }catch (Exception e) {
            log.error("[AppProspectController][createProspect] /createProspect accepted token:{}, customerName:{}, error:{}", token, customerName, Throwables.getStackTraceAsString(e));
            dataMap.put("success", false);
            dataMap.put("error", "105");
            dataMap.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(JsonUtil.toJson(dataMap));
        response.getWriter().flush();
        response.getWriter().close();
    }

    @RequestMapping(value = "/getProspectById", method = { RequestMethod.GET, RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void getProspectById(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="id",required = true) String id,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppProspectController][getProspectById] /getProspectById accepted token:{}, id:{}", token, id);

        Map<String, Object> dataMap = new HashMap<String, Object>();
        dataMap.put("success", true);
        try {
            dataMap = VerifyTokenUtil.verify(request, dataMap);
            if (VerifyTokenUtil.VERIFY_SUCCESS.equals(dataMap.get("verifyPassed").toString())) {
                ServiceResult<Prospect> serviceResult = prospectService.getById(Integer.parseInt(id));
                if(serviceResult.getSuccess()){
                    Prospect prospect = serviceResult.getResult();
                    Map<String, Object> prospectMap = new HashMap<String, Object>();
                    prospectMap.put("id", prospect.getId());
                    prospectMap.put("customerName", prospect.getCustomerName());
                    prospectMap.put("prospectAddress", prospect.getProspectAddress());
                    prospectMap.put("name", prospect.getName());//TODO
                    prospectMap.put("mobile", prospect.getMobile());
                    prospectMap.put("prospectConfirmTime", prospect.getProspectConfirmTime());
                    prospectMap.put("prospectStartTime", prospect.getProspectStartTime());
                    prospectMap.put("prospectEndTime", prospect.getProspectEndTime());
                    prospectMap.put("prospectName", prospect.getProspectName());

                    String content = "";
                    String[] contentNo = prospect.getProspectContent().split(",");
                    for(String no: contentNo) {
                        if("1".equals(no)) {
                            content = content.concat("电气火灾监测系统，");
                        }
                        if("2".equals(no)) {
                            content = content.concat("安全隐患巡查系统，");
                        }
                        if("3".equals(no)) {
                            content = content.concat("建筑消防用水监测系统，");
                        }
                        if("4".equals(no)) {
                            content = content.concat("重点部位可视化监管系统，");
                        }
                        if("5".equals(no)) {
                            content = content.concat("火灾在线联网报警系统，");
                        }
                    }
                    if(!"".equals(content)) {
                        content = content.substring(0, content.length()-1);
                    }
                    prospectMap.put("prospectContent", content);
                    prospectMap.put("prospectRequire", prospect.getProspectRequire());

                    String statusContent = "";
                    if(prospect.getStatus() == 0) {
                        statusContent = "已派工，待勘查";
                    } else if(prospect.getStatus() == 1) {
                        statusContent = "勘查完成，待安装";
                    }
                    prospectMap.put("status", statusContent);
                    prospectMap.put("prospectFileAddress", prospect.getProspectFileAddress());

                    dataMap.put("prospect", prospectMap);
                }
            }
        }catch (Exception e) {
            log.error("[AppProspectController][getProspectById] /getProspectById accepted token:{}, id:{}, error:{}",
                    token, id, Throwables.getStackTraceAsString(e));
            dataMap.put("success", false);
            dataMap.put("error", "105");
            dataMap.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(JsonUtil.toJson(dataMap));
        response.getWriter().flush();
        response.getWriter().close();
    }

    @RequestMapping(value = "/findProspectList", method = { RequestMethod.GET, RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void findProspectList(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="customerName",required = false) String customerName,
            @RequestParam(value="status",required = false) Integer status,
            @RequestParam(value="rows",required = false) Integer rows,
            @RequestParam(value="page",required = false) Integer page,
            HttpServletRequest request, HttpServletResponse response)throws IOException {
        log.info("[AppProspectController][findProspectList] /findProspectList accepted token:{}, customerName:{}, status:{}, rows:{}, page:{}",
                token, customerName, status, rows, page);

        Map<String, Object> dataMap = new HashMap<String, Object>();
        Map <String, Object> criteria = Maps.newHashMap();
        dataMap.put("success", true);
        try {
            dataMap = VerifyTokenUtil.verify(request, dataMap);
            if (VerifyTokenUtil.VERIFY_SUCCESS.equals(dataMap.get("verifyPassed").toString())) {
                if (rows == null)
                    rows = 20;
                if (page == null)
                    page = 1;
                Map<String, Object> params = new HashMap<String, Object>();
                params.put("m", (page - 1) * rows);
                params.put("n", rows);
                //参数加入params里
                params.put("customerName", customerName);
                params.put("status", status);

                ServiceResult<List<Prospect>> result = prospectService.getProspectList(params);
                if(result != null && result.getSuccess()) {
                    List<Prospect> prospectList = result.getResult();
                    List<Map<String, Object>> mapsList = new ArrayList<Map<String, Object>>();
                    for(Prospect prospect: prospectList) {
                        Map<String, Object> prospectMap = new HashMap<String, Object>();
                        prospectMap.put("id", prospect.getId());
                        prospectMap.put("customerName", prospect.getCustomerName());
                        prospectMap.put("prospectAddress", prospect.getProspectAddress());
                        prospectMap.put("name", prospect.getName());
                        prospectMap.put("mobile", prospect.getMobile());
                        prospectMap.put("prospectConfirmTime", prospect.getProspectConfirmTime());
                        prospectMap.put("prospectStartTime", prospect.getProspectStartTime());
                        prospectMap.put("prospectEndTime", prospect.getProspectEndTime());
                        prospectMap.put("prospectName", prospect.getProspectName());

                        String content = "";
                        String[] contentNo = prospect.getProspectContent().split(",");
                        for(String no: contentNo) {
                            if("1".equals(no)) {
                                content = content.concat("电气火灾监测系统，");
                            }
                            if("2".equals(no)) {
                                content = content.concat("安全隐患巡查系统，");
                            }
                            if("3".equals(no)) {
                                content = content.concat("建筑消防用水监测系统，");
                            }
                            if("4".equals(no)) {
                                content = content.concat("重点部位可视化监管系统，");
                            }
                            if("5".equals(no)) {
                                content = content.concat("火灾在线联网报警系统，");
                            }
                        }
                        if(!"".equals(content)) {
                            content = content.substring(0, content.length()-1);
                        }
                        prospectMap.put("prospectContent", content);
                        prospectMap.put("prospectRequire", prospect.getProspectRequire());

                        String statusContent = "";
                        if(prospect.getStatus() == 0) {
                            statusContent = "已派工，待勘查";
                        } else if(prospect.getStatus() == 1) {
                            statusContent = "勘查完成，待安装";
                        }
                        prospectMap.put("status", statusContent);
                        prospectMap.put("prospectFileAddress", prospect.getProspectFileAddress());

                        mapsList.add(prospectMap);
                    }
                    dataMap.put("total", mapsList.size());
                    dataMap.put("prospectList", mapsList);
                }
            }
        }catch (Exception e) {
            log.error("[AppProspectController][findProspectList] /findProspectList accepted token:{}, customerName:{}, error:{}",
                    token, customerName, Throwables.getStackTraceAsString(e));
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
     * 勘查反馈
     * @param request
     * @return
     */
    @RequestMapping(value = "/createProspectFeedback", method = { RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void createProspectFeedback(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="id",required = true) Integer id,
            @RequestParam(value="prospectName",required = true) String prospectName,
            @RequestParam(value="prospectStartTime",required = true) String prospectStartTime,
            @RequestParam(value="prospectEndTime",required = true) String prospectEndTime,
            @RequestParam(value="remark",required = true) String remark,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppCustomerController][createProspectFeedback] accepted token:{}, id:{}, prospectName:{}, prospectStartTime:{}, prospectEndTime:{}, remark:{}",
                token, id, prospectName, prospectStartTime, prospectEndTime, remark);
        Map<String, Object> dataMap = new HashMap<String, Object>();
        dataMap.put("success", true);
        try {
            dataMap = VerifyTokenUtil.verify(request, dataMap);
            if (VerifyTokenUtil.VERIFY_SUCCESS.equals(dataMap.get("verifyPassed").toString())) {
                Date startDate = null;
                Date endDate = null;
                try
                {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    startDate = sdf.parse(prospectStartTime);
                    endDate = sdf.parse(prospectEndTime);
                }
                catch (ParseException e) {
                    log.error("app勘查反馈失败！");
                    dataMap.put("success", false);
                    dataMap.put("error", "");
                    dataMap.put("msg", "app勘查反馈失败");
                }

                ServiceResult<Prospect> result = prospectService.getById(id);

                if(result != null && result.getSuccess()) {
                    Prospect prospect = result.getResult();
                    prospect.setProspectName(prospectName);
                    prospect.setProspectStartTime(startDate);
                    prospect.setProspectEndTime(endDate);
                    prospect.setRemark(remark);
                    ServiceResult<Integer> upResult = prospectService.update(prospect);
                    if (!upResult.getSuccess() || upResult.getResult() == 0) {
                        log.error("app勘查反馈失败！");
                        dataMap.put("success", false);
                        dataMap.put("error", "");
                        dataMap.put("msg", "app勘查反馈失败" + upResult.getMessage());
                    }
                }
            }
        }catch (Exception e) {
            log.error("[AppCustomerController][createProspectFeedback] accepted token:{}, id:{}, prospectName:{}, prospectStartTime:{}, prospectEndTime:{}, remark:{}, error:{}",
                    token, id, prospectName, prospectStartTime, prospectEndTime, remark, Throwables.getStackTraceAsString(e));
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
