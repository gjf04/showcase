package com.admin.service.impl.system;


import com.admin.entity.system.SysLog;
import com.admin.service.system.RoleService;
import com.admin.service.system.SysLogService;
import com.gao.common.ServiceResult;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import static com.google.common.base.Preconditions.checkNotNull;

/**
 * Created by GaoJingFei on 2017/11/13.
 */
@Slf4j
@Service
public class SysLogServiceImpl implements SysLogService {
    @Override
    public ServiceResult<SysLog> getByMobile(String mobile){
        checkNotNull(mobile, "mobile不能为空");
        ServiceResult<SysLog> result = new ServiceResult<SysLog>();
        return result;
    }
}
