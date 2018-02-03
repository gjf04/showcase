package com.admin.entity.system;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.admin.entity.BaseEntity;

/**
 * 附件实体类
 * Created by GaoJingFei on 2017/11/13.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class Attachment  extends BaseEntity{

    /**
	 * 
	 */
	private static final long serialVersionUID = -9086126311607335864L;

	private String fileCode;

    private String fileName;

    private Integer fileType;//文件类别 1:合同  2:勘察报告  3:安装验收报告

    private Long relateId;

    private String url;

    public static enum FileTypeEnum{
        /**
         * 文件类别 1:合同  2:勘察报告  3:安装验收报告
         */
        AGREEMENT(1),PROSPECT(2),ACCEPTANCE(3);
        @Getter
        private Integer fileType;
        private FileTypeEnum(Integer fileType) {
            this.fileType = fileType;
        }
    }

}