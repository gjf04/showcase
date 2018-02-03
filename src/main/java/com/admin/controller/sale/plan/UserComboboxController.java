package com.admin.controller.sale.plan;

import com.admin.entity.sale.plan.UserCombo;
import com.admin.service.sale.plan.UserComboboxService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 用户Combox列表加载Controller
 * @author WangDeYu
 * @version 2017-12-19
 */

@Controller
@RequestMapping("/sale/plan")
@Slf4j
public class UserComboboxController {
    @Autowired
    private UserComboboxService userComboboxService;

    @RequestMapping("/getusers")
    @ResponseBody
    public List<UserCombo> GetUserList(){
        return userComboboxService.getUserInfo();
    }
}
