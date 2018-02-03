package com.admin.service.sale.plan;

import com.admin.entity.sale.plan.UserCombo;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2017-12-21.
 */
@Repository
public interface UserComboboxService {

    public List<UserCombo> getUserInfo();
}
