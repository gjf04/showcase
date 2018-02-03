package com.admin.dao.appraisal;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.admin.dao.BaseDao;
import com.admin.entity.appraisal.AppraisalUser;

/**
 * Created by CongLin on 2018-01-04.
 */

@Repository
public class AppraisalUserDao extends BaseDao {
    public List<AppraisalUser> getUserInfo(){
        return this.getSqlSession().selectList(namespace+"getUserInfo");
    }
}
