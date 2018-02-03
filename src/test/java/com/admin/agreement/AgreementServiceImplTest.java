package com.admin.agreement;
import javax.annotation.Resource;  

import org.apache.log4j.Logger;  
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;  
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;  

import com.admin.entity.agreement.AgreementInfo;
import com.admin.service.agreement.AgreementService;
import com.gao.common.ServiceResult;

 /**
 * @author wangss
 */
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml"}) 
@RunWith(SpringJUnit4ClassRunner.class)     //表示继承了SpringJUnit4ClassRunner类  
public class AgreementServiceImplTest{
	private static Logger logger = Logger.getLogger(AgreementServiceImplTest.class);  
	@Resource
	private AgreementService agreementService;
	
	
	@Test
	public void testInsert(){
		AgreementInfo agreementInfo = new AgreementInfo();
		agreementInfo.setCustomerId(111L);
		agreementInfo.setRemark("remark");
//		ServiceResult<Integer> result = agreementService.insertAgreementInfo(agreementInfo);
//		System.out.println(result.getSuccess());
	}

	@Test
	public void test1() {
        //TODO
	}
}
