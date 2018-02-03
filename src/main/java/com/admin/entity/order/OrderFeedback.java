package com.admin.entity.order;

import com.admin.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 订单跟进反馈实体类
 * Created by GaoJingFei on 2017/11/13.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class OrderFeedback extends BaseEntity{

    private Integer orderId;

    private Integer customerId;

	private String customerCode;

    private String customerName;

    private String responsiblePerson;

    private Integer responsiblePersonId;

    private String description;

}