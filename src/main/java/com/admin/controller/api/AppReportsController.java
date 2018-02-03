package com.admin.controller.api;

import com.admin.entity.reports.ExpenseReports;
import com.admin.entity.reports.PerformanceReports;
import com.admin.service.reports.ReportsService;
import com.gao.common.BusinessException;
import com.gao.common.ServiceResult;
import com.gao.common.util.JsonUtil;
import com.google.common.base.Throwables;
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

@Controller
@RequestMapping("/api")
@Slf4j
public class AppReportsController {

    @Resource
    private ReportsService reportsService;

    @RequestMapping(value = "/findPersonalExpenseList", method = { RequestMethod.GET, RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void findPersonalExpenseList(
            @RequestParam(value="token", required = true) String token,
            @RequestParam(value="year", required = false) Integer year,
            @RequestParam(value="month", required = false) Integer month,
            @RequestParam(value="rows", required = false) Integer rows,
            @RequestParam(value="page", required = false) Integer page,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppReportsController][findPersonalExpenseList] /findPersonalExpenseList accepted token:{}", token);

        Map<String, Object> dataMap = new HashMap<String, Object>();
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
                params.put("year", year);
                params.put("month", month);

                ServiceResult<List<ExpenseReports>> result = reportsService.getExpenseReportsListByPerson(params);
                if(result != null && result.getSuccess()) {
                    List<ExpenseReports> expenseReportsList = result.getResult();
                    List<Map<String, Object>> mapsList = new ArrayList<Map<String, Object>>();
                    for(ExpenseReports expenseReports: expenseReportsList) {
                        Map<String, Object> map = new HashMap<String, Object>();
                        map.put("id", expenseReports.getId());
                        map.put("name", expenseReports.getName());
                        map.put("year", expenseReports.getYear());
                        map.put("month", expenseReports.getMonth());
                        map.put("fuelCharge", expenseReports.getFuelCharge());
                        map.put("busFee", expenseReports.getBusFee());
                        map.put("taxiFee", expenseReports.getTaxiFee());
                        map.put("telephoneCharge", expenseReports.getTelephoneCharge());
                        map.put("feteFee", expenseReports.getFeteFee());
                        map.put("travellingExpenses", expenseReports.getTravellingExpenses());
                        map.put("marketingCosts", expenseReports.getMarketingCosts());
                        map.put("allCosts", expenseReports.getAllCosts());
                        mapsList.add(map);
                    }
                    dataMap.put("total", mapsList.size());
                    dataMap.put("expenseReportsList", mapsList);
                }
            }
        }catch (Exception e) {
            log.error("[AppReportsController][findPersonalExpenseList] /findPersonalExpenseList accepted token:{}, error:{}",
                    token, Throwables.getStackTraceAsString(e));
            dataMap.put("success", false);
            dataMap.put("error", "105");
            dataMap.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(JsonUtil.toJson(dataMap));
        response.getWriter().flush();
        response.getWriter().close();
    }

    @RequestMapping(value = "/findMonthExpenseList", method = { RequestMethod.GET, RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void findMonthExpenseList(
            @RequestParam(value="token", required = true) String token,
            @RequestParam(value="year", required = false) Integer year,
            @RequestParam(value="rows", required = false) Integer rows,
            @RequestParam(value="page", required = false) Integer page,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppReportsController][findMonthExpenseList] /findMonthExpenseList accepted token:{}", token);

        Map<String, Object> dataMap = new HashMap<String, Object>();
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
                params.put("year", year);

                ServiceResult<List<ExpenseReports>> result = reportsService.getExpenseReportsListByMonth(params);
                if(result != null && result.getSuccess()) {
                    List<ExpenseReports> expenseReportsList = result.getResult();
                    List<Map<String, Object>> mapsList = new ArrayList<Map<String, Object>>();
                    for(ExpenseReports expenseReports: expenseReportsList) {
                        Map<String, Object> map = new HashMap<String, Object>();
                        map.put("year", expenseReports.getYear());
                        map.put("month", expenseReports.getMonth());
                        map.put("fuelCharge", expenseReports.getFuelCharge());
                        map.put("busFee", expenseReports.getBusFee());
                        map.put("taxiFee", expenseReports.getTaxiFee());
                        map.put("telephoneCharge", expenseReports.getTelephoneCharge());
                        map.put("feteFee", expenseReports.getFeteFee());
                        map.put("travellingExpenses", expenseReports.getTravellingExpenses());
                        map.put("marketingCosts", expenseReports.getMarketingCosts());
                        map.put("allCosts", expenseReports.getAllCosts());
                        mapsList.add(map);
                    }
                    dataMap.put("total", mapsList.size());
                    dataMap.put("expenseReportsList", mapsList);
                }
            }
        }catch (Exception e) {
            log.error("[AppReportsController][findMonthExpenseList] /findMonthExpenseList accepted token:{}, error:{}",

                    token, Throwables.getStackTraceAsString(e));
            dataMap.put("success", false);
            dataMap.put("error", "105");
            dataMap.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(JsonUtil.toJson(dataMap));
        response.getWriter().flush();
        response.getWriter().close();
    }

    @RequestMapping(value = "/findPersonalPerformanceList", method = { RequestMethod.GET, RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void findPersonalPerformanceList(
            @RequestParam(value="token", required = true) String token,
            @RequestParam(value="year", required = false) Integer year,
            @RequestParam(value="month", required = false) Integer month,
            @RequestParam(value="rows", required = false) Integer rows,
            @RequestParam(value="page", required = false) Integer page,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppReportsController][findPersonalPerformanceList] /findPersonalPerformanceList accepted token:{}", token);

        Map<String, Object> dataMap = new HashMap<String, Object>();
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
                params.put("year", year);
                params.put("month", month);

                ServiceResult<List<PerformanceReports>> result = reportsService.getPerformanceReportsListByPerson(params);
                if(result != null && result.getSuccess()) {
                    List<PerformanceReports> performanceReportsList = result.getResult();
                    List<Map<String, Object>> mapsList = new ArrayList<Map<String, Object>>();
                    for(PerformanceReports performanceReports: performanceReportsList) {
                        Map<String, Object> map = new HashMap<String, Object>();
                        map.put("id", performanceReports.getId());
                        map.put("name", performanceReports.getName());
                        map.put("year", performanceReports.getYear());
                        map.put("month", performanceReports.getMonth());
                        map.put("orderMonthTarget", performanceReports.getOrderMonthTarget());
                        map.put("orderMonthActual", performanceReports.getOrderMonthActual());
                        map.put("orderMonthRate", performanceReports.getOrderMonthRate());
                        map.put("orderQuarterTarget", performanceReports.getOrderQuarterTarget());
                        map.put("orderQuarterActual", performanceReports.getOrderQuarterActual());
                        map.put("orderQuarterRate", performanceReports.getOrderQuarterRate());
                        map.put("contractTarget", performanceReports.getContractTarget());
                        map.put("contractActual", performanceReports.getContractActual());
                        map.put("contractRate", performanceReports.getContractRate());
                        map.put("dailyCheckRate", performanceReports.getDailyCheckRate());
                        map.put("daily", performanceReports.getDaily());
                        map.put("checkRanking", performanceReports.getCheckRanking());
                        mapsList.add(map);
                    }
                    dataMap.put("total", mapsList.size());
                    dataMap.put("performanceReportsList", mapsList);
                }
            }
        }catch (Exception e) {
            log.error("[AppReportsController][findPersonalPerformanceList] /findPersonalPerformanceList accepted token:{}, error:{}",
                    token, Throwables.getStackTraceAsString(e));
            dataMap.put("success", false);
            dataMap.put("error", "105");
            dataMap.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(JsonUtil.toJson(dataMap));
        response.getWriter().flush();
        response.getWriter().close();
    }

    @RequestMapping(value = "/findMonthPerformanceList", method = { RequestMethod.GET, RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void findMonthPerformanceList(
            @RequestParam(value="token", required = true) String token,
            @RequestParam(value="year", required = false) Integer year,
            @RequestParam(value="rows", required = false) Integer rows,
            @RequestParam(value="page", required = false) Integer page,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppReportsController][findMonthPerformanceList] /findMonthPerformanceList accepted token:{}", token);

        Map<String, Object> dataMap = new HashMap<String, Object>();
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
                params.put("year", year);

                ServiceResult<List<PerformanceReports>> result = reportsService.getPerformanceReportsListByMonth(params);
                if(result != null && result.getSuccess()) {
                    List<PerformanceReports> performanceReportsList = result.getResult();
                    List<Map<String, Object>> mapsList = new ArrayList<Map<String, Object>>();
                    for(PerformanceReports performanceReports: performanceReportsList) {
                        Map<String, Object> map = new HashMap<String, Object>();
                        map.put("year", performanceReports.getYear());
                        map.put("month", performanceReports.getMonth());
                        map.put("orderMonthTarget", performanceReports.getOrderMonthTarget());
                        map.put("orderMonthActual", performanceReports.getOrderMonthActual());
                        map.put("orderMonthRate", performanceReports.getOrderMonthRate());
                        map.put("orderQuarterTarget", performanceReports.getOrderQuarterTarget());
                        map.put("orderQuarterActual", performanceReports.getOrderQuarterActual());
                        map.put("orderQuarterRate", performanceReports.getOrderQuarterRate());
                        map.put("contractTarget", performanceReports.getContractTarget());
                        map.put("contractActual", performanceReports.getContractActual());
                        map.put("contractRate", performanceReports.getContractRate());
                        mapsList.add(map);
                    }
                    dataMap.put("total", mapsList.size());
                    dataMap.put("performanceReportsList", mapsList);
                }
            }
        }catch (Exception e) {
            log.error("[AppReportsController][findMonthPerformanceList] /findMonthPerformanceList" +
                    " accepted token:{}, error:{}",


                    token, Throwables.getStackTraceAsString(e));
            dataMap.put("success", false);
            dataMap.put("error", "105");
            dataMap.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(JsonUtil.toJson(dataMap));
        response.getWriter().flush();
        response.getWriter().close();
    }

    @RequestMapping(value = "/getPerformanceReportsCurrentYear", method = { RequestMethod.GET, RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void getPerformanceReportsCurrentYear(
            @RequestParam(value="token",required = true) String token,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppReportsController][getPerformanceReportsCurrentYear] /getPerformanceReportsCurrentYear accepted token:{}", token);

        Map<String, Object> dataMap = new HashMap<String, Object>();
        dataMap.put("success", true);
        try {
            dataMap = VerifyTokenUtil.verify(request, dataMap);
            if (VerifyTokenUtil.VERIFY_SUCCESS.equals(dataMap.get("verifyPassed").toString())) {
                ServiceResult<PerformanceReports> serviceResult = reportsService.getPerformanceReportsCurrentYear();
                if(serviceResult.getSuccess()){
                    PerformanceReports performanceReports = serviceResult.getResult();
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("contractTarget", performanceReports.getContractTarget());
                    map.put("contractActual", performanceReports.getContractActual());
                    map.put("contractRate", performanceReports.getContractRate());

                    dataMap.put("performanceReports", map);
                }
            }
        }catch (Exception e) {
            log.error("[AppReportsController][getPerformanceReportsCurrentYear] /getPerformanceReportsCurrentYear accepted token:{}, error:{}",
                    token, Throwables.getStackTraceAsString(e));
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
