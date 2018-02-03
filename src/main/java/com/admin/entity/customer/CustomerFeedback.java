package com.admin.entity.customer;

import com.admin.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 客户反馈实体类
 * Created by GaoJingFei on 2017/11/13.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class CustomerFeedback extends BaseEntity{

    private Integer customerId;

	private String customerCode;

    private String customerName;

    private String responsiblePerson;

    private Integer responsiblePersonId;

    private String description;

}