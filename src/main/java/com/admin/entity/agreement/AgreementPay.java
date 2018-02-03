package com.admin.entity.agreement;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.admin.entity.BaseEntity;

/**
 * 合同货品清单
 * Created by wss on 2017/11/29.
 */

@ToString(callSuper=true)
@Getter
@Setter
public class AgreementPay extends BaseEntity{

	private static final long serialVersionUID = 2588762098564688100L;
	
	private Long agreeId;
    private Long userId;
    private String userName;
    private BigDecimal shouldPay;
    private BigDecimal payAmount;
    private Integer payType;
}