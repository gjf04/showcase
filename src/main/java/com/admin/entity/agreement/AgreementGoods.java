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
public class AgreementGoods extends BaseEntity{

	private static final long serialVersionUID = 761793797606743096L;

    private Long agreementId;

    private String systemName;

    private String hardwareName;

    private Integer goodsNum;

    private BigDecimal price;

    private BigDecimal hardwareAmount;

    private BigDecimal serviceAmount;

    private BigDecimal allAmount;

}