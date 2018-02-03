package com.admin.service.impl.sale.plan;

import com.admin.dao.sale.plan.UserComboboxDao;
import com.admin.entity.sale.plan.UserCombo;
import com.admin.service.sale.plan.UserComboboxService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2017-12-21.
 */
@Slf4j
@Service
public class UserComboboxServiceImpl implements UserComboboxService {
    @Autowired
    private UserComboboxDao userComboboxDao;

    @Override
    public List<UserCombo> getUserInfo(){
        return userComboboxDao.getUserInfo();
    }
}
