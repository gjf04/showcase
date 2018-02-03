package com.admin.entity.agreement;


import com.admin.entity.BaseEntity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString(callSuper=true)
@Getter
@Setter
public class AgreementApproval extends BaseEntity {

	private static final long serialVersionUID = -8888462661483579290L;

	private Long agreeId;
	
	private Long userId;

	private String userName;
	
    private String approvalInfo;

    private Integer status; //处理状态。1通过 2未通过
    
    public static enum statusEnum {
        PASS(1,"通过"),
        NOT_PASS(2, "未通过");

        private final int value;
        private final String description;

        private statusEnum(int value, String description) {
            this.value = value;
            this.description = description;
        }

        public int value() {
            return this.value;
        }
        @Override
        public String toString() {
            return description;
        }
    }

}