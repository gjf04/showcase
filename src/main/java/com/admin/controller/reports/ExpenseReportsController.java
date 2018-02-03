package com.admin.controller.reports;

import com.admin.entity.reports.ExpenseReports;
import com.admin.service.reports.ReportsService;
import com.admin.web.util.CommUtil;
import com.admin.web.util.ExcelCallbackInterfaceUtil;
import com.admin.web.util.ExcelExportUtil;
import com.gao.common.BusinessException;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;
import com.gao.common.util.JsonUtil;
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

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by lx on 2017/12/19.
 */
@Controller
@RequestMapping("/report")
@Slf4j
public class ExpenseReportsController {
    private final static org.apache.log4j.Logger logger = LogManager.getLogger(ExpenseReportsController.class);

    @Resource
    private ReportsService reportsService;

    @RequestMapping(value = "personalExpense.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String personalExpense(HttpServletRequest request,Map<String, Object> dataMap) throws Exception {
        return "reports/personal_expense_list";
    }

    @RequestMapping("/findPersonalExpenseList")
    public void findPersonalExpenseList(@RequestParam(required = false) Integer year,
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

            ServiceResult<List<ExpenseReports>> result = reportsService.getExpenseReportsListByPerson(params);
            if(result == null || !result.getSuccess()) {
                logger.error("人员费用支出报表查询失败");
                throw new BusinessException("人员费用支出报表查询失败");
            }
            List<ExpenseReports> expenseReportsList = result.getResult();

            //获得条数
            int resultcount = expenseReportsList.size();
            Map<String, Object> retMap = new HashMap<String, Object>();
            retMap.put("total", resultcount);
            retMap.put("rows", expenseReportsList);

            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(JsonUtil.toJson(retMap));
            response.getWriter().flush();
            response.getWriter().close();
        } catch (Exception e) {
            logger.error("人员费用支出报表查询失败", e);
            throw new BusinessException("人员费用支出报表查询失败" + e.getMessage());
        }
    }

    /**
     * 费用-人员 列表导出Excel
     * @param request
     * @param response
     */
    @RequestMapping(value = { "/exportPersonalExpenseList" })
    public void exportPersonalExpenseList(HttpServletRequest request, HttpServletResponse response) {
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

        ServiceResult<List<ExpenseReports>> serviceResult = reportsService.getExpenseReportsListByPerson(params);
        if(serviceResult == null || !serviceResult.getSuccess()) {
            logger.error("人员费用支出报表查询失败");
            throw new BusinessException("人员费用支出报表查询失败");
        }
        List<ExpenseReports> expenseReportsList = serviceResult.getResult();

        final List<ExpenseReports> result = expenseReportsList;

        String fileName = "费用支出报表-人员累计" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        String sheetName = "数据导出";
        String[] sheetHead = new String[] { "人员", "月份",  "燃油费", "公交/长途车", "出租车", "话费", "宴请", "出差", "营销费用", "费用总计" };

        try {
            ExcelExportUtil.exportEntity(logger, request, response, fileName, sheetName, sheetHead,
                    new ExcelCallbackInterfaceUtil() {

                        @Override
                        public void setExcelBodyTotal(OutputStream os, WritableSheet sheet, int temp)
                                throws Exception {
                            setExcelBodyTotalForPersonalExpenseList(sheet, temp, result);
                        }

                    });
        } catch (Exception e) {
            log.error("费用支出报表导出失败！", e);
            e.printStackTrace();
        }
    }

    /**
     * 导出费用列表的具体数据，实现回调函数
     * @param sheet
     * @param temp 行号
     * @param list 传入需要导出的 list
     */
    private void setExcelBodyTotalForPersonalExpenseList(WritableSheet sheet, int temp, List<ExpenseReports> list) throws Exception {
        WritableFont font = new WritableFont(WritableFont.ARIAL, 9, WritableFont.NO_BOLD, false,
                UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.BLACK);
        WritableCellFormat textFormat = new WritableCellFormat(font);
        textFormat.setAlignment(Alignment.CENTRE);
        textFormat.setBorder(Border.ALL, BorderLineStyle.THIN);

        DisplayFormat displayFormat = NumberFormats.INTEGER;
        WritableCellFormat numberFormat = new WritableCellFormat(font, displayFormat);
        numberFormat.setAlignment(jxl.format.Alignment.RIGHT);
        numberFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);

        for (ExpenseReports expenseReports : list) {
            //jxl.write.Number(列号,行号 ,内容 )
            // "人员", "月份",  "燃油费", "公交/长途车", "出租车", "话费", "宴请", "出差", "营销费用", "费用总计"
            sheet.setColumnView(0, 25);
            sheet.addCell(new Label(0, temp, CommUtil.getStringValue(expenseReports.getName()), textFormat));

            sheet.setColumnView(1, 25);
            sheet.addCell(new Label(1, temp, CommUtil.getStringValue(expenseReports.getMonth()),textFormat));

            sheet.setColumnView(2, 25);
            sheet.addCell(new Label(2, temp, CommUtil.getStringValue(expenseReports.getFuelCharge()),textFormat));

            sheet.setColumnView(3, 25);
            sheet.addCell(new Label(3, temp, CommUtil.getStringValue(expenseReports.getBusFee()),textFormat));

            sheet.setColumnView(4, 25);
            sheet.addCell(new Label(4, temp, CommUtil.getStringValue(expenseReports.getTaxiFee()),textFormat));

            sheet.setColumnView(5, 25);
            sheet.addCell(new Label(5, temp, CommUtil.getStringValue(expenseReports.getTelephoneCharge()),textFormat));

            sheet.setColumnView(6, 25);
            sheet.addCell(new Label(6, temp, CommUtil.getStringValue(expenseReports.getFeteFee()),textFormat));

            sheet.setColumnView(7, 25);
            sheet.addCell(new Label(7, temp, CommUtil.getStringValue(expenseReports.getTravellingExpenses()),textFormat));

            sheet.setColumnView(8, 25);
            sheet.addCell(new Label(8, temp, CommUtil.getStringValue(expenseReports.getMarketingCosts()),textFormat));

            sheet.setColumnView(9, 25);
            sheet.addCell(new Label(9, temp, CommUtil.getStringValue(expenseReports.getAllCosts()),textFormat));

            temp++;
        }
    }

    @RequestMapping(value = "monthExpense.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String monthExpense(HttpServletRequest request,Map<String, Object> dataMap) throws Exception {
        return "reports/month_expense_list";
    }

    @RequestMapping("/findMonthExpenseList")
    public void findMonthExpenseList(@RequestParam(required = false) Integer year,
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

            ServiceResult<List<ExpenseReports>> result = reportsService.getExpenseReportsListByMonth(params);
            if(result == null || !result.getSuccess()) {
                logger.error("按月费用支出报表查询失败");
                throw new BusinessException("按月费用支出报表查询失败");
            }
            List<ExpenseReports> expenseReportsList = result.getResult();

            //获得条数
            int resultcount = expenseReportsList.size();
            Map<String, Object> retMap = new HashMap<String, Object>();
            retMap.put("total", resultcount);
            retMap.put("rows", expenseReportsList);

            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(JsonUtil.toJson(retMap));
            response.getWriter().flush();
            response.getWriter().close();
        } catch (Exception e) {
            logger.error("按月费用支出报表查询失败", e);
            throw new BusinessException("按月费用支出报表查询失败" + e.getMessage());
        }
    }

    /**
     * 费用-月度 列表导出Excel
     * @param request
     * @param response
     */
    @RequestMapping(value = { "/exportMonthExpenseList" })
    public void exportMonthExpenseList(HttpServletRequest request, HttpServletResponse response) {
        String year = request.getParameter("year");

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("m", 0);
        params.put("n", 5000);
        //参数加入params里
        if(year != null && !"".equals(year)){
            //参数加入params里
            params.put("year", year);
        }

        ServiceResult<List<ExpenseReports>> serviceResult = reportsService.getExpenseReportsListByMonth(params);
        if(serviceResult == null || !serviceResult.getSuccess()) {
            logger.error("按月费用支出报表查询失败");
            throw new BusinessException("按月费用支出报表查询失败");
        }
        List<ExpenseReports> expenseReportsList = serviceResult.getResult();

        final List<ExpenseReports> result = expenseReportsList;

        String fileName = "费用支出报表-按月汇总" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        String sheetName = "数据导出";
        String[] sheetHead = new String[] { "月份",  "燃油费", "公交/长途车", "出租车", "话费", "宴请", "出差", "营销费用", "费用总计" };

        try {
            ExcelExportUtil.exportEntity(logger, request, response, fileName, sheetName, sheetHead,
                    new ExcelCallbackInterfaceUtil() {

                        @Override
                        public void setExcelBodyTotal(OutputStream os, WritableSheet sheet, int temp)
                                throws Exception {
                            setExcelBodyTotalForMonthExpenseList(sheet, temp, result);
                        }

                    });
        } catch (Exception e) {
            log.error("费用支出报表导出失败！", e);
            e.printStackTrace();
        }
    }

    /**
     * 导出费用列表的具体数据，实现回调函数
     * @param sheet
     * @param temp 行号
     * @param list 传入需要导出的 list
     */
    private void setExcelBodyTotalForMonthExpenseList(WritableSheet sheet, int temp, List<ExpenseReports> list) throws Exception {
        WritableFont font = new WritableFont(WritableFont.ARIAL, 9, WritableFont.NO_BOLD, false,
                UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.BLACK);
        WritableCellFormat textFormat = new WritableCellFormat(font);
        textFormat.setAlignment(Alignment.CENTRE);
        textFormat.setBorder(Border.ALL, BorderLineStyle.THIN);

        DisplayFormat displayFormat = NumberFormats.INTEGER;
        WritableCellFormat numberFormat = new WritableCellFormat(font, displayFormat);
        numberFormat.setAlignment(jxl.format.Alignment.RIGHT);
        numberFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);

        for (ExpenseReports expenseReports : list) {
            //jxl.write.Number(列号,行号 ,内容 )
            // "月份",  "燃油费", "公交/长途车", "出租车", "话费", "宴请", "出差", "营销费用", "费用总计"
            sheet.setColumnView(0, 25);
            sheet.addCell(new Label(0, temp, CommUtil.getStringValue(expenseReports.getMonth()),textFormat));

            sheet.setColumnView(1, 25);
            sheet.addCell(new Label(1, temp, CommUtil.getStringValue(expenseReports.getFuelCharge()),textFormat));

            sheet.setColumnView(2, 25);
            sheet.addCell(new Label(2, temp, CommUtil.getStringValue(expenseReports.getBusFee()),textFormat));

            sheet.setColumnView(3, 25);
            sheet.addCell(new Label(3, temp, CommUtil.getStringValue(expenseReports.getTaxiFee()),textFormat));

            sheet.setColumnView(4, 25);
            sheet.addCell(new Label(4, temp, CommUtil.getStringValue(expenseReports.getTelephoneCharge()),textFormat));

            sheet.setColumnView(5, 25);
            sheet.addCell(new Label(5, temp, CommUtil.getStringValue(expenseReports.getFeteFee()),textFormat));

            sheet.setColumnView(6, 25);
            sheet.addCell(new Label(6, temp, CommUtil.getStringValue(expenseReports.getTravellingExpenses()),textFormat));

            sheet.setColumnView(7, 25);
            sheet.addCell(new Label(7, temp, CommUtil.getStringValue(expenseReports.getMarketingCosts()),textFormat));

            sheet.setColumnView(8, 25);
            sheet.addCell(new Label(8, temp, CommUtil.getStringValue(expenseReports.getAllCosts()),textFormat));

            temp++;
        }
    }
}
