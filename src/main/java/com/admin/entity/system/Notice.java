package com.admin.entity.system;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import com.admin.entity.BaseEntity;

/**
 * 公告实体类
 * Created by GaoJingFei on 2017/11/13.
 */
@ToString(callSuper=true)
@Getter
@Setter
public class Notice  extends BaseEntity{

    /**
	 * 
	 */
	private static final long serialVersionUID = -5397383428069814515L;

	private Date startAt;

    private Date endAt;

    private String title;

    private String content;

}