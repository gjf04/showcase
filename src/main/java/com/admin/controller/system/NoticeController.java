package com.admin.controller.system;

import com.gao.common.ServiceResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 *
 * Created by GaoJingFei on 2017/11/13.
 */

@Controller  
@RequestMapping("/system") 
@Slf4j
public class NoticeController {

    @RequestMapping(value = "notice.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(HttpServletRequest request, Model model) throws Exception {
        
        return "system/notice_list";
    }
    
    @RequestMapping("/noticeList")
    public String noticeList(HttpServletRequest request,Map<String, Object> stack){
       
        return "showUser2";  
    }  
}  