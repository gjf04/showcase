package com.admin.service.impl.system;

import com.admin.dao.system.ProspectDao;
import com.admin.entity.system.Prospect;
import com.admin.service.system.ProspectService;
import com.gao.common.ServiceResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by lx on 17-11-17.
 */
@Slf4j
@Service
public class ProspectServiceImpl implements ProspectService {
    @Autowired
    private ProspectDao prospectDao;

    @Override
    public ServiceResult<Prospect> getById(Integer id) {
        ServiceResult<Prospect> result = new ServiceResult<Prospect>();
        result.setResult(prospectDao.getById(id));

        return result;
    }

    @Override
    public ServiceResult<List<Prospect>> getProspectList(Map<String, Object> paramMap) {
        ServiceResult<List<Prospect>> result = new ServiceResult<List<Prospect>>();
        result.setResult(prospectDao.getProspectList(paramMap));

        return result;
    }

    @Override
    public ServiceResult<Integer> insert(Prospect prospect) {
        ServiceResult<Integer> result = new ServiceResult<Integer>();
        result.setResult(prospectDao.insert(prospect));

        return result;
    }

    @Override
    public ServiceResult<Integer> update(Prospect prospect) {
        ServiceResult<Integer> result = new ServiceResult<Integer>();
        result.setResult(prospectDao.update(prospect));

        return result;
    }
}
