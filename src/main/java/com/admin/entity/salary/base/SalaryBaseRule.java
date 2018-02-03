/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.admin.entity.salary.base;

import com.admin.entity.BaseEntity;


/**
 * 底薪设置Entity
 * @author CongLin
 * @version 2017-12-10
 */
public class SalaryBaseRule  extends BaseEntity{
	
	private static final long serialVersionUID = 1L;
	private String post;		// 岗位
	private Integer base;		// 底薪基数
	private Integer baseLevel;		// 底薪档位
	private Double floatBase;		// 浮动绩效基数
	private String floatProportion;		// 浮动绩效计提比例
	private String floatCompletionRate;		// 个人销售计划完成率(与浮动绩效计提比例相匹配)
	private Double percentageComplete;		// 销售提成（完成销售计划）
	private Double percentageIncomplete;		// 销售提成（未完成销售计划）
	
	public SalaryBaseRule() {
		super();
	}

	public SalaryBaseRule(String id){
		//super(id);
	}

	//@Length(min=1, max=30, message="岗位长度必须介于 1 和 30 之间")
	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}
	
	//@NotNull(message="底薪基数不能为空")
	public Integer getBase() {
		return base;
	}

	public void setBase(Integer base) {
		this.base = base;
	}
	
	public Integer getBaseLevel() {
		return baseLevel;
	}

	public void setBaseLevel(Integer baseLevel) {
		this.baseLevel = baseLevel;
	}
	
	public Double getFloatBase() {
		return floatBase;
	}

	public void setFloatBase(Double floatBase) {
		this.floatBase = floatBase;
	}
	
	public String getFloatProportion() {
		return floatProportion;
	}

	public void setFloatProportion(String floatProportion) {
		this.floatProportion = floatProportion;
	}
	
	public String getFloatCompletionRate() {
		return floatCompletionRate;
	}

	public void setFloatCompletionRate(String floatCompletionRate) {
		this.floatCompletionRate = floatCompletionRate;
	}

	public Double getPercentageComplete() {
		return percentageComplete;
	}

	public void setPercentageComplete(Double percentageComplete) {
		this.percentageComplete = percentageComplete;
	}

	public Double getPercentageIncomplete() {
		return percentageIncomplete;
	}

	public void setPercentageIncomplete(Double percentageIncomplete) {
		this.percentageIncomplete = percentageIncomplete;
	}
}