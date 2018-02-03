package com.admin.service.reports;

import com.admin.entity.reports.ExpenseReports;
import com.admin.entity.reports.PerformanceReports;
import com.gao.common.ServiceResult;

import java.util.List;
import java.util.Map;

/**
 * Created by lx on 2017/12/19.
 */
public interface ReportsService {

    public ServiceResult<List<ExpenseReports>> getExpenseReportsListByPerson(Map<String, Object> paramMap);

    public ServiceResult<List<ExpenseReports>> getExpenseReportsListByMonth(Map<String, Object> paramMap);

    public ServiceResult<List<PerformanceReports>> getPerformanceReportsListByPerson(Map<String, Object> paramMap);

    public ServiceResult<List<PerformanceReports>> getPerformanceReportsListByMonth(Map<String, Object> paramMap);

    public ServiceResult<PerformanceReports> getPerformanceReportsCurrentYear();
}
