package com.admin.controller.api;

import com.admin.entity.system.Department;
import com.admin.entity.system.Role;
import com.admin.entity.system.UserInfo;
import com.admin.service.system.DepartmentService;
import com.admin.service.system.RoleService;
import com.admin.service.system.UserInfoService;
import com.admin.web.util.PasswordUtil;
import com.admin.web.util.SessionSecurityConstants;
import com.admin.web.util.Signatures;
import com.alibaba.fastjson.JSONObject;
import com.google.common.base.Throwables;
import com.gao.common.ServiceResult;
import com.gao.common.util.JsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/api")
@Slf4j
public class AppLoginController {
    @Resource  
    private UserInfoService userInfoService;

    @Resource
    private RoleService roleService;

    @Resource
    private DepartmentService departmentService;
    
    @RequestMapping(value = "/login", method = { RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public void login(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="userName",required = true) String userName,
            @RequestParam(value="password",required = true) String password,
            HttpServletRequest request,
			HttpServletResponse response)throws IOException {
        log.info("[AppLoginController][login] /login accepted token:{}, userName:{}, password:{}",
                token, userName, "******");
        Map<String, Object> dataMap = new HashMap<String, Object>();
        dataMap.put("success", true);
        try {
            dataMap = VerifyTokenUtil.verify(request, dataMap);
            if (VerifyTokenUtil.VERIFY_SUCCESS.equals(dataMap.get("verifyPassed").toString())) {
                ServiceResult<UserInfo> result = userInfoService.login(userName, password, "");
                if (!result.getSuccess()) {
                    log.error(result.getMessage());
                    dataMap.put("success", false);
                    dataMap.put("error", "201");
                    dataMap.put("msg", "账号密码不正确");
                }else{
                    UserInfo user = result.getResult();
                    List<Role> roleList = roleService.getUserRoles(user.getId());
                    Role role = new Role();
                    if(roleList != null && roleList.size() > 0){
                        role = roleList.get(0);
                    }
                    List<Department> departmentList = departmentService.getUserDepartments(user.getId());
                    Department department = new Department();
                    if(departmentList != null && departmentList.size() > 0){
                        department = departmentList.get(0);
                    }
                    dataMap.put("userId", user.getId());
                    dataMap.put("userName", user.getUserName());
                    dataMap.put("nickName", user.getNickName());
                    dataMap.put("roleId", role.getId());
                    dataMap.put("roleName", role.getName());
                    dataMap.put("departmentId", department.getId());
                    dataMap.put("departmentName", department.getName());
                    request.getSession().setAttribute(SessionSecurityConstants.KEY_USER_ID_APP, user.getId());
                    request.getSession().setAttribute(SessionSecurityConstants.KEY_USER_NAME_APP, user.getUserName());
                    request.getSession().setAttribute(SessionSecurityConstants.KEY_USER_NICK_NAME_APP, user.getNickName());
                }
            }
        }catch (Exception e) {
            log.error("[AppLoginController][login] /login accepted token:{}, userName:{}, password:{}, error:{}",
                    token, userName, "******", Throwables.getStackTraceAsString(e));
            dataMap.put("success", false);
            dataMap.put("error", "105");
            dataMap.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(JsonUtil.toJson(dataMap));
        response.getWriter().flush();
        response.getWriter().close();
    }

    @RequestMapping(value = "/logout", method = { RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void logout(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="id",required = true) String id,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppLoginController][logout] /logout accepted token:{}, id:{}",
                token, id);
        Map<String, Object> dataMap = new HashMap<String, Object>();
        dataMap.put("success", true);
        try {
            if (VerifyTokenUtil.VERIFY_SUCCESS.equals(dataMap.get("success").toString())) {
                HttpSession session = request.getSession();
                if(session.getAttribute(SessionSecurityConstants.KEY_USER_ID_APP) != null){
                    session.removeAttribute(SessionSecurityConstants.KEY_USER_ID_APP);
                    session.removeAttribute(SessionSecurityConstants.KEY_USER_NAME_APP);
                    session.removeAttribute(SessionSecurityConstants.KEY_USER_NICK_NAME_APP);
                }
            }
        }catch (Exception e) {
            log.error("[AppLoginController][logout] /logout accepted token:{}, id:{}, error:{}",
                    token, id, Throwables.getStackTraceAsString(e));
            dataMap.put("success", false);
            dataMap.put("error", "105");
            dataMap.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(JsonUtil.toJson(dataMap));
        response.getWriter().flush();
        response.getWriter().close();
    }

    @RequestMapping(value = "/resetPasswordByApp", method = { RequestMethod.POST }, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public void resetPasswordByApp(
            @RequestParam(value="token",required = true) String token,
            @RequestParam(value="id",required = true) String id,
            @RequestParam(value="newPassword",required = true) String newPassword,
            HttpServletRequest request,
            HttpServletResponse response)throws IOException {
        log.info("[AppLoginController][resetPasswordByApp] /resetPasswordByApp accepted token:{}, id:{}, newPassword:{}",
                token, id, "******");
        Map<String, Object> dataMap = new HashMap<String, Object>();
        dataMap.put("success", true);
        try {
            String key = "CRM";
            Boolean signFlag = Signatures.verify(request, key);
            if (!signFlag) {
                log.error("token未通过验证");
                dataMap.put("success", false);
                dataMap.put("error", "103");
                dataMap.put("msg", "token错误");
            }else{
                UserInfo userInfo = new UserInfo();
                userInfo.setId(Long.parseLong(id));
                userInfo.setPassword(PasswordUtil.encrypt(newPassword));
                //userInfo.setPassword(newPassword);
                ServiceResult<UserInfo> result = userInfoService.updateUserInfo(userInfo);
                if (!result.getSuccess()) {
                    log.error("重置密码失败！");
                    dataMap.put("success", false);
                    dataMap.put("error", "201");
                    dataMap.put("msg", "重置密码失败，" + result.getMessage());
                }
            }
        }catch (Exception e) {
            log.error("[AppLoginController][resetPasswordByApp] /resetPasswordByApp accepted token:{}, id:{}, newPassword:{}, error:{}",
                    token, id, "******", Throwables.getStackTraceAsString(e));
            dataMap.put("success", false);
            dataMap.put("error", "105");
            dataMap.put("msg", "调用服务出错");
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(JsonUtil.toJson(dataMap));
        response.getWriter().flush();
        response.getWriter().close();
    }

}  