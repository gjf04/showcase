package com.admin.entity.reimbursement;

import com.admin.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

/**
 * Created by WangDeYu on 2017-12-25.
 */

@Getter
@Setter
public class Reimbursement extends BaseEntity {

    private static final long serialVersionUID = 1L;

    private String userId;
    private String userName;
    private String style;
    private String approvalMan;
    private String caiwuMan;
    private Date approvalDate;
    private Date caiwuDate;
    private Integer approvalState;
    private Date feeDate;
    private Double feeAmt;


}
