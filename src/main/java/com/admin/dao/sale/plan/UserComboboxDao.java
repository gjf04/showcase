package com.admin.dao.sale.plan;

import com.admin.dao.BaseDao;
import com.admin.entity.sale.plan.SalePlan;
import com.admin.entity.sale.plan.UserCombo;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by WangDeYu on 2017-12-21.
 */

@Repository
public class UserComboboxDao extends BaseDao {
    public List<UserCombo> getUserInfo(){
        return this.getSqlSession().selectList(namespace+"getUserInfo");
    }
}
