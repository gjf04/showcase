package com.admin.service.impl.system;

import java.util.List;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.admin.dao.system.RoleResourceDao;
import com.admin.entity.system.RoleResource;
import com.admin.service.system.RoleResourceService;
import com.google.common.base.Throwables;
import com.gao.common.ServiceResult;

/**
 * Created by GaoJingFei on 2017/11/13.
 */
@Slf4j
@Service
public class RoleResourceServiceImpl implements RoleResourceService {
    
	@Autowired
    private RoleResourceDao roleResourceDao;
   
	@Override
	public ServiceResult<List<RoleResource>> selectAllByRoleId(
			Long roleId) {
		ServiceResult<List<RoleResource>> result = new ServiceResult<List<RoleResource>>();
        try{
        	List<RoleResource> list = roleResourceDao.selectAllByRoleId(roleId);
        	result.setResult(list);
        }catch(Exception e){
        	result.setError("error","信息查询失败");
        	log.error("信息查询失败:" + Throwables.getStackTraceAsString(e) );
        }
        return result;
	}

	@Override
	public ServiceResult<Integer> insert(RoleResource roleResource) {
		ServiceResult<Integer> result = new ServiceResult<Integer>();
        try{
            int id = roleResourceDao.insert(roleResource);
        }catch(Exception e){
        	result.setError("error","信息插入失败");
        	log.error("信息插入失败:" + Throwables.getStackTraceAsString(e) );
        }
        return result;
	}
	@Override
	public ServiceResult<Integer> deleteByRoleId(Long roleId) {
		ServiceResult<Integer> result = new ServiceResult<Integer>();
        try{
            int id = roleResourceDao.deleteByRoleId(roleId);
        }catch(Exception e){
        	result.setError("error","信息删除失败");
        	log.error("信息删除失败:" + Throwables.getStackTraceAsString(e) );
        }
        return result;
	}
}
