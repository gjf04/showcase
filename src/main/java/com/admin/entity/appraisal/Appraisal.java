/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.admin.entity.appraisal;

import com.admin.entity.BaseEntity;


/**
 * 考评激励Entity
 * @author CongLin
 * @version 2018-01-03
 */
public class Appraisal  extends BaseEntity{
	
	private static final long serialVersionUID = 1L;
	private String userId;		// 用户ID
	private String userName;		// 用户名
	private String itemIds;		// 考评项id集合,逗号隔开
	private String itemScores;		// 考评项得分集合，逗号隔开
	private int score;		// 得分
	private String month;		// 月份
	private String year;		// 年份

	public Appraisal() {
		super();
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getItemIds() {
		return itemIds;
	}

	public void setItemIds(String itemIds) {
		this.itemIds = itemIds;
	}

	public String getItemScores() {
		return itemScores;
	}

	public void setItemScores(String itemScores) {
		this.itemScores = itemScores;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}
	
	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}