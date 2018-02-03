package com.admin.service.system;
import com.admin.entity.system.SysLog;
import com.gao.common.ServiceResult;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface SysLogService {
    /**
     * 根据手机号获取用户信息
     * */
    public ServiceResult<SysLog> getByMobile(String mobile);
}
