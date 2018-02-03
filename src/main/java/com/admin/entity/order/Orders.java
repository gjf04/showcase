package com.admin.entity.order;

import com.admin.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.text.SimpleDateFormat;
import java.util.Date;
/**
 * 客户实体类
 * Created by GaoJingFei on 2017/12/12.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class Orders  extends BaseEntity {

    private String orderSn;

    private String customerCode;

    private String customerName;

    private String agreeSn;

    private Integer approvalStatus;

    private Date preInstallAt;

    private Date deliverAt;

    private Date installAt;

    private Date completedAt;

    /**
     * 生成订单号
     * */
    public static String generateOrderSn(){
        StringBuffer orderSn = new StringBuffer();
        orderSn.append(new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()));
        return orderSn.toString();
    }

}