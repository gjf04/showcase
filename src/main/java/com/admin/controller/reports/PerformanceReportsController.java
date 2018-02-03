package com.admin.controller.reports;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.web.util.CommUtil;
import com.admin.web.util.ExcelCallbackInterfaceUtil;
import com.admin.web.util.ExcelExportUtil;
import jxl.biff.DisplayFormat;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.UnderlineStyle;
import jxl.write.*;
import lombok.extern.slf4j.Slf4j;

import org.apache.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.admin.entity.reports.PerformanceReports;
import com.admin.service.reports.ReportsService;
import com.gao.common.BusinessException;
import com.gao.common.ServiceResult;
import com.gao.common.util.JsonUtil;

/**
 * Created by lx on 17-12-24.
 */
@Controller
@RequestMapping("/report")
@Slf4j
public class PerformanceReportsController {
    private final static org.apache.log4j.Logger logger = LogManager.getLogger(PerformanceReportsController.class);

    @Resource
    private ReportsService reportsService;

    @RequestMapping(value = "personalPerformance.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String personalPerformance(HttpServletRequest request,Map<String, Object> dataMap) throws Exception {
        return "reports/personal_performance_list";
    }

    @RequestMapping("/findPersonalPerformanceList")
    public void findPersonalPerformanceList(@RequestParam(required = false) Integer year,
                                        @RequestParam(required = false) Integer month,
                                        @RequestParam(required = false) Integer rows,
                                        @RequestParam(required = false) Integer page,
                                        HttpServletRequest request, HttpServletResponse response) {
        try {
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
            if(result == null || !result.getSuccess()) {
                logger.error("人员业绩完成率报表查询失败");
                throw new BusinessException("人员业绩完成率报表查询失败");
            }
            List<PerformanceReports> performanceReportsList = result.getResult();

            //获得条数
            int resultcount = performanceReportsList.size();
            Map<String, Object> retMap = new HashMap<String, Object>();
            retMap.put("total", resultcount);
            retMap.put("rows", performanceReportsList);

            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(JsonUtil.toJson(retMap));
            response.getWriter().flush();
            response.getWriter().close();
        } catch (Exception e) {
            logger.error("人员业绩完成率报表查询失败", e);
            throw new BusinessException("人员业绩完成率报表查询失败" + e.getMessage());
        }
    }

    /**
     * 业绩-人员 列表导出Excel
     * @param request
     * @param response
     */
    @RequestMapping(value = { "/exportPersonalPerformanceList" })
    public void exportPersonalPerformanceList(HttpServletRequest request, HttpServletResponse response) {
        String year = request.getParameter("year");
        String month = request.getParameter("month");

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("m", 0);
        params.put("n", 5000);
        //参数加入params里
        if(year != null && !"".equals(year)){
            //参数加入params里
            params.put("year", year);
        }
        if(month != null && !"".equals(month)){
            //参数加入params里
            params.put("month", month);
        }

        ServiceResult<List<PerformanceReports>> serviceResult = reportsService.getPerformanceReportsListByPerson(params);
        if(serviceResult == null || !serviceResult.getSuccess()) {
            logger.error("人员业绩完成率报表查询失败");
            throw new BusinessException("人员业绩完成率报表查询失败");
        }
        List<PerformanceReports> performanceReportsList = serviceResult.getResult();

        final List<PerformanceReports> result = performanceReportsList;

        String fileName = "业绩完成率报表-人员累计" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        String sheetName = "数据导出";
        String[] sheetHead = new String[] { "人员", "月份",  "订单完成目标", "订单完成实际", "订单完成率", "订单季度目标", "订单季度实际", "订单季度完成率",
                            "合同回款目标", "合同回款实际", "合同回款完成率", "日常考核订单签约", "日常考核合同回款", "日常考核完成率", "日常", "考核排名" };

        try {
            ExcelExportUtil.exportEntity(logger, request, response, fileName, sheetName, sheetHead,
                    new ExcelCallbackInterfaceUtil() {

                        @Override
                        public void setExcelBodyTotal(OutputStream os, WritableSheet sheet, int temp)
                                throws Exception {
                            setExcelBodyTotalForPersonalPerformanceList(sheet, temp, result);
                        }

                    });
        } catch (Exception e) {
            log.error("人员业绩完成率报表导出失败！", e);
            e.printStackTrace();
        }
    }

    /**
     * 导出业绩列表的具体数据，实现回调函数
     * @param sheet
     * @param temp 行号
     * @param list 传入需要导出的 list
     */
    private void setExcelBodyTotalForPersonalPerformanceList(WritableSheet sheet, int temp, List<PerformanceReports> list) throws Exception {
        WritableFont font = new WritableFont(WritableFont.ARIAL, 9, WritableFont.NO_BOLD, false,
                UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.BLACK);
        WritableCellFormat textFormat = new WritableCellFormat(font);
        textFormat.setAlignment(Alignment.CENTRE);
        textFormat.setBorder(Border.ALL, BorderLineStyle.THIN);

        DisplayFormat displayFormat = NumberFormats.INTEGER;
        WritableCellFormat numberFormat = new WritableCellFormat(font, displayFormat);
        numberFormat.setAlignment(jxl.format.Alignment.RIGHT);
        numberFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);

        for (PerformanceReports performanceReports : list) {
            //jxl.write.Number(列号,行号 ,内容 )
            // "人员", "月份",  "订单完成目标", "订单完成实际", "订单完成率", "订单季度目标", "订单季度实际", "订单季度完成率",
            // "合同回款目标", "合同回款实际", "合同回款完成率", "日常考核订单签约", "日常考核合同回款", "日常考核完成率", "日常", "考核排名"
            sheet.setColumnView(0, 25);
            sheet.addCell(new Label(0, temp, CommUtil.getStringValue(performanceReports.getName()), textFormat));

            sheet.setColumnView(1, 25);
            sheet.addCell(new Label(1, temp, CommUtil.getStringValue(performanceReports.getMonth()),textFormat));

            sheet.setColumnView(2, 25);
            sheet.addCell(new Label(2, temp, CommUtil.getStringValue(performanceReports.getOrderMonthTarget()),textFormat));

            sheet.setColumnView(3, 25);
            sheet.addCell(new Label(3, temp, CommUtil.getStringValue(performanceReports.getOrderMonthActual()),textFormat));

            sheet.setColumnView(4, 25);
            sheet.addCell(new Label(4, temp, CommUtil.getStringValue(performanceReports.getOrderMonthRate()),textFormat));

            sheet.setColumnView(5, 25);
            sheet.addCell(new Label(5, temp, CommUtil.getStringValue(performanceReports.getOrderQuarterTarget()),textFormat));

            sheet.setColumnView(6, 25);
            sheet.addCell(new Label(6, temp, CommUtil.getStringValue(performanceReports.getOrderQuarterActual()),textFormat));

            sheet.setColumnView(7, 25);
            sheet.addCell(new Label(7, temp, CommUtil.getStringValue(performanceReports.getOrderQuarterRate()),textFormat));

            sheet.setColumnView(8, 25);
            sheet.addCell(new Label(8, temp, CommUtil.getStringValue(performanceReports.getContractTarget()),textFormat));

            sheet.setColumnView(9, 25);
            sheet.addCell(new Label(9, temp, CommUtil.getStringValue(performanceReports.getContractActual()),textFormat));

            sheet.setColumnView(10, 25);
            sheet.addCell(new Label(10, temp, CommUtil.getStringValue(performanceReports.getContractRate()),textFormat));

            sheet.setColumnView(11, 25);
            sheet.addCell(new Label(11, temp, CommUtil.getStringValue(performanceReports.getOrderMonthActual()),textFormat));

            sheet.setColumnView(12, 25);
            sheet.addCell(new Label(12, temp, CommUtil.getStringValue(performanceReports.getContractActual()),textFormat));

            sheet.setColumnView(13, 25);
            sheet.addCell(new Label(13, temp, CommUtil.getStringValue(performanceReports.getDailyCheckRate()),textFormat));

            sheet.setColumnView(14, 25);
            sheet.addCell(new Label(14, temp, CommUtil.getStringValue(performanceReports.getDaily()),textFormat));

            sheet.setColumnView(15, 25);
            sheet.addCell(new Label(15, temp, CommUtil.getStringValue(performanceReports.getCheckRanking()),textFormat));

            temp++;
        }
    }

    @RequestMapping(value = "monthPerformance.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String monthPerformance(HttpServletRequest request,Map<String, Object> dataMap) throws Exception {
        return "reports/month_performance_list";
    }

    @RequestMapping("/findMonthPerformanceList")
    public void findMonthPerformanceList(@RequestParam(required = false) Integer year,
                                     @RequestParam(required = false) Integer rows,
                                     @RequestParam(required = false) Integer page,
                                     HttpServletRequest request, HttpServletResponse response) {
        try {
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
            if(result == null || !result.getSuccess()) {
                logger.error("按月业绩完成率报表查询失败");
                throw new BusinessException("按月业绩完成率报表查询失败");
            }
            List<PerformanceReports> performanceReportsList = result.getResult();

            //获得条数
            int resultcount = performanceReportsList.size();
            Map<String, Object> retMap = new HashMap<String, Object>();
            retMap.put("total", resultcount);
            retMap.put("rows", performanceReportsList);

            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(JsonUtil.toJson(retMap));
            response.getWriter().flush();
            response.getWriter().close();
        } catch (Exception e) {
            logger.error("按月业绩完成率报表查询失败", e);
            throw new BusinessException("按月业绩完成率报表查询失败" + e.getMessage());
        }
    }

    /**
     * 业绩-月度 列表导出Excel
     * @param request
     * @param response
     */
    @RequestMapping(value = { "/exportMonthPerformanceList" })
    public void exportMonthPerformanceList(HttpServletRequest request, HttpServletResponse response) {
        String year = request.getParameter("year");

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("m", 0);
        params.put("n", 5000);
        //参数加入params里
        if(year != null && !"".equals(year)){
            //参数加入params里
            params.put("year", year);
        }

        ServiceResult<List<PerformanceReports>> serviceResult = reportsService.getPerformanceReportsListByMonth(params);
        if(serviceResult == null || !serviceResult.getSuccess()) {
            logger.error("按月业绩完成率报表查询失败");
            throw new BusinessException("按月业绩完成率报表查询失败");
        }
        List<PerformanceReports> performanceReportsList = serviceResult.getResult();

        final List<PerformanceReports> result = performanceReportsList;

        String fileName = "业绩完成率报表-月度累计" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        String sheetName = "数据导出";
        String[] sheetHead = new String[] { "月份",  "订单完成目标", "订单完成实际", "订单完成率", "订单季度目标", "订单季度实际", "订单季度完成率" };

        try {
            ExcelExportUtil.exportEntity(logger, request, response, fileName, sheetName, sheetHead,
                    new ExcelCallbackInterfaceUtil() {

                        @Override
                        public void setExcelBodyTotal(OutputStream os, WritableSheet sheet, int temp)
                                throws Exception {
                            setExcelBodyTotalForMonthPerformanceList(sheet, temp, result);
                        }

                    });
        } catch (Exception e) {
            log.error("月度业绩完成率报表导出失败！", e);
            e.printStackTrace();
        }
    }

    /**
     * 导出业绩列表的具体数据，实现回调函数
     * @param sheet
     * @param temp 行号
     * @param list 传入需要导出的 list
     */
    private void setExcelBodyTotalForMonthPerformanceList(WritableSheet sheet, int temp, List<PerformanceReports> list) throws Exception {
        WritableFont font = new WritableFont(WritableFont.ARIAL, 9, WritableFont.NO_BOLD, false,
                UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.BLACK);
        WritableCellFormat textFormat = new WritableCellFormat(font);
        textFormat.setAlignment(Alignment.CENTRE);
        textFormat.setBorder(Border.ALL, BorderLineStyle.THIN);

        DisplayFormat displayFormat = NumberFormats.INTEGER;
        WritableCellFormat numberFormat = new WritableCellFormat(font, displayFormat);
        numberFormat.setAlignment(jxl.format.Alignment.RIGHT);
        numberFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);

        for (PerformanceReports performanceReports : list) {
            //jxl.write.Number(列号,行号 ,内容 )
            // "月份",  "订单完成目标", "订单完成实际", "订单完成率", "订单季度目标", "订单季度实际", "订单季度完成率"
            sheet.setColumnView(0, 25);
            sheet.addCell(new Label(0, temp, CommUtil.getStringValue(performanceReports.getMonth()),textFormat));

            sheet.setColumnView(1, 25);
            sheet.addCell(new Label(1, temp, CommUtil.getStringValue(performanceReports.getOrderMonthTarget()),textFormat));

            sheet.setColumnView(2, 25);
            sheet.addCell(new Label(2, temp, CommUtil.getStringValue(performanceReports.getOrderMonthActual()),textFormat));

            sheet.setColumnView(3, 25);
            sheet.addCell(new Label(3, temp, CommUtil.getStringValue(performanceReports.getOrderMonthRate()),textFormat));

            sheet.setColumnView(4, 25);
            sheet.addCell(new Label(4, temp, CommUtil.getStringValue(performanceReports.getOrderQuarterTarget()),textFormat));

            sheet.setColumnView(5, 25);
            sheet.addCell(new Label(5, temp, CommUtil.getStringValue(performanceReports.getOrderQuarterActual()),textFormat));

            sheet.setColumnView(6, 25);
            sheet.addCell(new Label(6, temp, CommUtil.getStringValue(performanceReports.getOrderQuarterRate()),textFormat));

            temp++;
        }
    }
}
