package com.admin.entity.agreement;

import java.math.BigDecimal;
import java.util.Date;

import com.admin.entity.BaseEntity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Created by wss on 2017/11/13.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class AgreementInfo extends BaseEntity{
	
	private static final long serialVersionUID = -2129501816916986944L;

    private String agreeSn;

    private String firstParty;

    private Long customerId;
    
    private String customerName;

    private Long contactId;

    private String contactName;

    private Integer serviceLife;

    private String projectName;

    private BigDecimal hardwareAll;

    private BigDecimal installAll;

    private BigDecimal serviceAll;

    private BigDecimal expensesAll;

    private BigDecimal payablesAll;

    private BigDecimal serviceYearAll;

    private Integer serviceMonth;

    private Integer serviceDay;

    private BigDecimal agreementAmount;
    
    private String agreementAmountUpper;
    
    private BigDecimal firstRatio;//首付比例
    
    private BigDecimal lastRatio;

    private Integer repairYears;

    /** 审批状态: 0已保存待提交 1待内勤初审 2总监审核 3合同上传 4签订完成 7已退回待修改*/
    private Integer approvalStatus;

    private String refuseInfo;
    
    private Date agreeDate;

}