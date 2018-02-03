package com.admin.dao.system;

import com.admin.entity.system.Department;
import com.admin.entity.system.UserDepartment;
import org.springframework.stereotype.Repository;

import com.admin.dao.BaseDao;

import java.util.List;
import java.util.Map;

/**
 * Created by GaoJingFei on 2017/11/17.
 */
@Repository
public class DepartmentDao extends BaseDao{
    public Department getById(Long id){
        return this.getSqlSession().selectOne(namespace+"getById", id);
    }

    public List<Department> queryListBy(Map<String, Object> params){
        return this.getSqlSession().selectList(namespace+"queryListBy", params);
    }

    public Integer queryCountBy(Map<String, Object> params){
        return this.getSqlSession().selectOne(namespace+"queryCountBy", params);
    }

    //新增
    public Integer insert(Department department){
        return this.getSqlSession().insert(namespace+"insert", department);
    }

    //更新
    public Integer update(Department department){
        return this.getSqlSession().update(namespace+"update", department);
    }

    /**
     * 获取所有部门
     *
     */
    public List<Department> getAll(){
        return this.getSqlSession().selectList(namespace+"getAll");
    }

    /**
     * 查询子部门
     * @param departmentId
     * @return
     */
    public List<Department> getChildren(Long departmentId){
        return this.getSqlSession().selectList(namespace+"getChildren", departmentId);
    }

    /**
     * 获取根节点部门 信息列表
     * @return
     */
    public List<Department> getRoots(){
        return this.getSqlSession().selectList(namespace+"getRoots");
    }

    /**
     * 获取用户所在的部门信息
     * @param userId
     * @return
     */
    public List<Department> getUserDepartments(Long userId){
        return this.getSqlSession().selectList(namespace+"getUserDepartments", userId);
    }

    /**
     * 删除用户关联的部门信息
     * @param userId
     */
    public Integer deleteUserDepartments(Long userId){
        return this.getSqlSession().update(namespace + "update", userId);
    }

    /**
     * 将用户添加到部门中
     * @param userDepartment
     */
    public Integer addUserToDepartment(UserDepartment userDepartment){
        return this.getSqlSession().insert(namespace+"addUserToDepartment", userDepartment);
    }

    /**
     * 获取部门中相关的下拉列表方法
     * @param type
     *
     */
    public List<Department> getDepartmentCombox(String type){
        return this.getSqlSession().selectList(namespace+"getDepartmentCombox", type);
    }

    /**
     * 根据名称查询
     * @param name
     * @return
     */
    public Department getDepartmentByName(String name){
        return this.getSqlSession().selectOne(namespace + "getDepartmentByName", name);
    }
    /**
     * 根据部门编码获取部门
     * @param code
     * @return
     */
    public Department getDepartmentByCode(String code){
        return this.getSqlSession().selectOne(namespace + "getDepartmentByCode", code);
    }
    /**
     * 根据用户查询部门
     * @param userId
     * @return
     */
    public Department searchDepartmentByUserId(Long userId){
        return this.getSqlSession().selectOne(namespace + "searchDepartmentByUserId", userId);
    }
    /**
     * 根据code获取部门名称
     * @param code
     * @return
     */
    public String getNameByCode(String code){
        return this.getSqlSession().selectOne(namespace + "getNameByCode", code);
    }
    /**
     * 根据code获取部门id
     *
     * @author GaoJingFei
     * @since 2014-11-3
     * @param code
     * @return
     */
    public String getIdByCode(String code){
        return this.getSqlSession().selectOne(namespace + "getIdByCode", code);
    }
    /**
     * 根据用户获取所在的部门
     * @author GaoJingFei
     * @since 2014-11-3
     * @param name
     * @return
     */
    public Department getDepartmentByUser(String name){
        return this.getSqlSession().selectOne(namespace + "getDepartmentByUser", name);
    }
}