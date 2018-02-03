package com.admin.entity.sale.plan;

import com.admin.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Created by Administrator on 2017/12/20 0020.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class SalePlan extends BaseEntity {
    private static final long serialVersionUID = 1L;
    private String userId;
    private String userName;
    private Integer planYear;
    private Integer planMonth;
    private Double planAmt;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Integer getPlanYear() {
        return planYear;
    }

    public void setPlanYear(Integer planYear) {
        this.planYear = planYear;
    }

    public Integer getPlanMonth() {
        return planMonth;
    }

    public void setPlanMonth(Integer planMonth) {
        this.planMonth = planMonth;
    }

    public Double getPlanAmt() {
        return planAmt;
    }

    public void setPlanAmt(Double planAmt) {
        this.planAmt = planAmt;
    }
}
