package com.admin.entity.customer;

import com.admin.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 客户联系人实体类
 * Created by GaoJingFei on 2017/11/13.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class CustomerContact extends BaseEntity{
    public static final String TYPE_ELECTRIC = "electric";//设备用电管理人
    public static final String TYPE_WATER = "water";//建筑消防用水
    public static final String TYPE_SAFE = "safe";//安全巡检
    public static final String TYPE_VISUAL = "visual";//可视化监管
    public static final String TYPE_EMERGENCY = "emergency";//紧急联系人

    private Long customerId;

	private String customerCode;

    private String customerName;

    private String type;

    private String contactName;

    private String contactPost;

    private String phone;

    private String mobile;

}