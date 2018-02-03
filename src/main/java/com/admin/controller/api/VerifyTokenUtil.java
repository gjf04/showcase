package com.admin.controller.api;

import com.admin.web.util.Signatures;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by gaojingfei on 2017/12/15.
 */
@Slf4j
public class VerifyTokenUtil {
    public static final String VERIFY_SUCCESS = "YES";
    public static final String VERIFY_FAIL = "NO";
    public static final String VERIFY_KEY = "CRM";
    public static Map<String, Object> verify(HttpServletRequest request, Map<String, Object> dataMap){
        dataMap.put("verifyPassed", VERIFY_SUCCESS);
//        Boolean signFlag = Signatures.verify(request, VERIFY_KEY);
//        if (!signFlag) {
//            log.error("token未通过验证");
//            dataMap.put("success", false);
//            dataMap.put("verifyPassed", VERIFY_FAIL);
//            dataMap.put("error", "103");
//            dataMap.put("msg", "token错误");
//        }
        return dataMap;
    }
}
