package com.admin.system;
import javax.annotation.Resource;  

import org.apache.log4j.Logger;  
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;  
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;  
import com.admin.entity.system.UserInfo;
import com.admin.service.system.UserInfoService;
import com.gao.common.ServiceResult;

 /**
 * 
 * @Filename 
 * @Version: 1.0
 * @author gaojingfei
 * @date 2017年11月13日
 */
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml"}) 
@RunWith(SpringJUnit4ClassRunner.class)     //表示继承了SpringJUnit4ClassRunner类  
public class UserServiceImplTest{
	private static Logger logger = Logger.getLogger(UserServiceImplTest.class);  
	@Resource
	private UserInfoService userInfoService;
	
	@Test
	public void testGetByMobile(){
		
	}

	@Test
	public void test1() {
        //TODO
	}
}
