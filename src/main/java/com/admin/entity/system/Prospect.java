package com.admin.entity.system;

import com.admin.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

/**
 * 勘察数据表
 * Created by lx on 17-11-17.
 */
@ToString(callSuper=true)
public class Prospect extends BaseEntity {

    private static final long serialVersionUID = 2648004984368789978L;

    private String customerName;

    private String prospectAddress;

    private String name;

    private String mobile;

    private Date prospectConfirmTime;

    private Date prospectStartTime;

    private Date prospectEndTime;

    private String prospectName;

    private String prospectContent;

    private String prospectRequire;

    private Integer status;

    private String prospectFileAddress;

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getProspectAddress() {
        return prospectAddress;
    }

    public void setProspectAddress(String prospectAddress) {
        this.prospectAddress = prospectAddress;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public Date getProspectConfirmTime() {
        return prospectConfirmTime;
    }

    public void setProspectConfirmTime(Date prospectConfirmTime) {
        this.prospectConfirmTime = prospectConfirmTime;
    }

    public Date getProspectStartTime() {
        return prospectStartTime;
    }

    public void setProspectStartTime(Date prospectStartTime) {
        this.prospectStartTime = prospectStartTime;
    }

    public Date getProspectEndTime() {
        return prospectEndTime;
    }

    public void setProspectEndTime(Date prospectEndTime) {
        this.prospectEndTime = prospectEndTime;
    }

    public String getProspectName() {
        return prospectName;
    }

    public void setProspectName(String prospectName) {
        this.prospectName = prospectName;
    }

    public String getProspectContent() {
        return prospectContent;
    }

    public void setProspectContent(String prospectContent) {
        this.prospectContent = prospectContent;
    }

    public String getProspectRequire() {
        return prospectRequire;
    }

    public void setProspectRequire(String prospectRequire) {
        this.prospectRequire = prospectRequire;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getProspectFileAddress() {
        return prospectFileAddress;
    }

    public void setProspectFileAddress(String prospectFileAddress) {
        this.prospectFileAddress = prospectFileAddress;
    }
}
