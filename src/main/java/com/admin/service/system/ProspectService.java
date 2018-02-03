package com.admin.service.system;

import com.admin.entity.system.Prospect;
import com.gao.common.ServiceResult;

import java.util.List;
import java.util.Map;

/**
 * Created by lx on 17-11-17.
 */
public interface ProspectService {

    public ServiceResult<Prospect> getById(Integer id);

    public ServiceResult<List<Prospect>> getProspectList(Map<String, Object> paramMap);

    public ServiceResult<Integer> insert(Prospect prospect);

    public ServiceResult<Integer> update(Prospect prospect);
}
