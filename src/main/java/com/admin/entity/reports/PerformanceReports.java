package com.admin.entity.reports;

import com.admin.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.math.BigDecimal;

/**
 * Created by lx on 17-12-24.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class PerformanceReports extends BaseEntity {
    private static final long serialVersionUID = 2648700986369887978L;

    private String name;

    private Integer year;

    private Integer month;

    private BigDecimal orderMonthTarget;

    private BigDecimal orderMonthActual;

    private BigDecimal orderMonthRate;

    private BigDecimal orderQuarterTarget;

    private BigDecimal orderQuarterActual;

    private BigDecimal orderQuarterRate;

    private BigDecimal contractTarget;

    private BigDecimal contractActual;

    private BigDecimal contractRate;

    private BigDecimal dailyCheckRate;

    private String daily;

    private Integer checkRanking;

    private Integer enable;
}
