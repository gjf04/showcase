package com.admin.service.impl.reports;

import com.admin.dao.reports.ExpenseReportsDao;
import com.admin.dao.reports.PerformanceReportsDao;
import com.admin.entity.reports.ExpenseReports;
import com.admin.entity.reports.PerformanceReports;
import com.admin.service.reports.ReportsService;
import com.gao.common.ServiceResult;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by lx on 2017/12/19.
 */
@Slf4j
@Service
public class ReportsServiceImpl implements ReportsService {
    @Autowired
    private ExpenseReportsDao expenseReportsDao;
    @Autowired
    private PerformanceReportsDao performanceReportsDao;

    @Override
    public ServiceResult<List<ExpenseReports>> getExpenseReportsListByPerson(Map<String, Object> paramMap) {
        ServiceResult<List<ExpenseReports>> result = new ServiceResult<List<ExpenseReports>>();
        result.setResult(expenseReportsDao.getExpenseReportsListByPerson(paramMap));

        return result;
    }

    @Override
    public ServiceResult<List<ExpenseReports>> getExpenseReportsListByMonth(Map<String, Object> paramMap) {
        ServiceResult<List<ExpenseReports>> result = new ServiceResult<List<ExpenseReports>>();
        result.setResult(expenseReportsDao.getExpenseReportsListByMonth(paramMap));

        return result;
    }

    @Override
    public ServiceResult<List<PerformanceReports>> getPerformanceReportsListByPerson(Map<String, Object> paramMap) {
        ServiceResult<List<PerformanceReports>> result = new ServiceResult<List<PerformanceReports>>();
        result.setResult(performanceReportsDao.getPerformanceReportsListByPerson(paramMap));

        return result;
    }

    @Override
    public ServiceResult<List<PerformanceReports>> getPerformanceReportsListByMonth(Map<String, Object> paramMap) {
        ServiceResult<List<PerformanceReports>> result = new ServiceResult<List<PerformanceReports>>();
        result.setResult(performanceReportsDao.getPerformanceReportsListByMonth(paramMap));

        return result;
    }

    @Override
    public ServiceResult<PerformanceReports> getPerformanceReportsCurrentYear() {
        ServiceResult<PerformanceReports> result = new ServiceResult<PerformanceReports>();
        result.setResult(performanceReportsDao.getPerformanceReportsCurrentYear());

        return result;
    }
}
