package com.admin.dao.reports;

import com.admin.dao.BaseDao;
import com.admin.entity.reports.ExpenseReports;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by liuxian on 2017/12/18.
 */
@Repository
public class ExpenseReportsDao extends BaseDao {
    public List<ExpenseReports> getExpenseReportsListByPerson(Map<String, Object> paramMap){
        return this.getSqlSession().selectList(namespace + "getExpenseReportsListByPerson", paramMap);
    }

    public List<ExpenseReports> getExpenseReportsListByMonth(Map<String, Object> paramMap){
        return this.getSqlSession().selectList(namespace + "getExpenseReportsListByMonth", paramMap);
    }
}
