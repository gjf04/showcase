package com.admin.dao.reports;

import com.admin.dao.BaseDao;
import com.admin.entity.reports.PerformanceReports;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by lx on 17-12-24.
 */
@Repository
public class PerformanceReportsDao extends BaseDao {
    public List<PerformanceReports> getPerformanceReportsListByPerson(Map<String, Object> paramMap){
        return this.getSqlSession().selectList(namespace + "getPerformanceReportsListByPerson", paramMap);
    }

    public List<PerformanceReports> getPerformanceReportsListByMonth(Map<String, Object> paramMap){
        return this.getSqlSession().selectList(namespace + "getPerformanceReportsListByMonth", paramMap);
    }

    public PerformanceReports getPerformanceReportsCurrentYear() {
        return this.getSqlSession().selectOne(namespace + "getPerformanceReportsCurrentYear");
    }
}
