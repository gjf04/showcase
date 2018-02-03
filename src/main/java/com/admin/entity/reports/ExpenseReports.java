package com.admin.entity.reports;

import com.admin.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.math.BigDecimal;

/**
 * Created by lx on 2017/12/19.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class ExpenseReports extends BaseEntity {
    private static final long serialVersionUID = 2648004986369887978L;

    private String name;

    private Integer year;

    private Integer month;

    private BigDecimal fuelCharge;

    private BigDecimal busFee;

    private BigDecimal taxiFee;

    private BigDecimal telephoneCharge;

    private BigDecimal feteFee;

    private BigDecimal travellingExpenses;

    private BigDecimal marketingCosts;

    private BigDecimal allCosts;

    private Integer enable;
}
