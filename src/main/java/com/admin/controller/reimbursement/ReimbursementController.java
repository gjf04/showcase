package com.admin.controller.reimbursement;

import com.admin.entity.reimbursement.Reimbursement;
import com.admin.service.reimbursement.ReimbursementService;
import com.admin.web.util.*;
import com.google.common.base.Throwables;
import com.google.common.collect.Maps;
import com.gao.common.BusinessException;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;
import com.gao.common.util.JsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 报销管理Controller
 * @author WangDeYu
 * @version 2017-12-25
 */

@Controller
@RequestMapping("/fee")
@Slf4j

public class ReimbursementController {
    @Autowired
    private ReimbursementService reimbursementService;


    @RequestMapping(value = "feelist.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(HttpServletRequest request, Map<String, Object> dataMap) throws Exception {
        return "fee/feelist";
    }

    @RequestMapping(value = "/feelist", method = { RequestMethod.GET, RequestMethod.POST })
    public void list(HttpServletRequest request, HttpServletResponse response, Map<String, Object> dataMap) {

        Map <String, Object> criteria = Maps.newHashMap();
        try {
            // 业务员
            String userName = request.getParameter("userName");
            if (userName != null && !"".equals(userName)) {
                criteria.put("userName", userName);
            }
            // 费用类型
            String style = request.getParameter("style");
            if (style != null && !"".equals(style)) {
                criteria.put("style", style);
            }
            // 审核标记
            String approvalState = request.getParameter("approvalState");
            if (approvalState != null && !"".equals(approvalState)) {
                criteria.put("approvalState", approvalState);
            }

            PagerInfo pager = WebUtil.handlerPagerInfo(request, dataMap);
            ServiceResult<Map<String, Object>> serviceResult = reimbursementService.search(criteria, pager);
            if(serviceResult.getSuccess()){
                Map<String, Object> map = serviceResult.getResult();
                if(map!=null&&map.size()>0){
                    List<Reimbursement> list = (List<Reimbursement>)map.get("data");
                    int total = (Integer)map.get("total");
                    dataMap.put("total", total);
                    dataMap.put("rows", list);
                    response.setContentType("application/json;charset=UTF-8");
                    response.getWriter().write(JsonUtil.toJson(dataMap));
                    response.getWriter().flush();
                    response.getWriter().close();
                }
            }
        }catch (Exception e) {
            log.error("查询列表失败，error={},condition={}", Throwables.getStackTraceAsString(e),criteria);
            throw new BusinessException("查询列表失败");
        }

        //return "modules/salary/base/salaryBaseRuleList";
    }


    /**
     * 新增
     * @param request
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public Object create(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        Reimbursement entity = new Reimbursement();
        Double db = 0.00;

        // DONE: 初始化系统的登入人员 userId userName
        String user_id = request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_ID).toString();
        String user_name = request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_NICK_NAME).toString();
        String style = request.getParameter("style");
        String approval_man = request.getParameter("approvalMan");
        String caiwu_man = request.getParameter("caiwuMan");
        String approval_state = request.getParameter("approvalState");
        String feeAmt = request.getParameter("feeAmt");
        String feeDate = request.getParameter("feeDate");

        entity.setUserId(user_id);
        if (user_name!=null && !"".equals(user_name)) {
            entity.setUserName(user_name);
        }

        entity.setStyle(style);
        entity.setApprovalMan(approval_man);
        entity.setCaiwuMan(caiwu_man);
        entity.setApprovalState(0);
        entity.setFeeDate(DateUtil.parse(DateUtil.format5, feeDate));
        entity.setFeeAmt(Double.parseDouble(feeAmt));
        entity.setCreatedBy(user_name);
        entity.setUpdatedBy(user_name);

        ServiceResult<Reimbursement> result = reimbursementService.create(entity);
        if (!result.getSuccess()) {
            log.error("新增失败！");
            jsonResult.setMessage("新增失败！");
            return jsonResult;
        }
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }

    /**
     * 更新
     * @param request
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Object update(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();

        Reimbursement entity = new Reimbursement();
        Double db = 0.00;

        String id = request.getParameter("id");
        String style = request.getParameter("style");
        String feeAmt = request.getParameter("feeAmt");
        String feeDate = request.getParameter("feeDate");
        String approvalMan = request.getParameter("approvalMan");
        String caiwuMan = request.getParameter("caiwuMan");
        String approvalDate = request.getParameter("approvalDate");
        String caiwuDate = request.getParameter("caiwuDate");
        String approvalState = request.getParameter("approvalState");

        entity.setId(Long.valueOf(id));
        entity.setStyle(style);
        entity.setFeeAmt(Double.parseDouble(feeAmt));
        entity.setFeeDate(DateUtil.parse(DateUtil.format5, feeDate));
        entity.setApprovalMan(approvalMan);
        entity.setCaiwuMan(caiwuMan);
        entity.setApprovalDate(DateUtil.parse(DateUtil.format5, approvalDate));
        entity.setCaiwuDate(DateUtil.parse(DateUtil.format5, caiwuDate));
        entity.setApprovalState(Integer.parseInt(approvalState));

        ServiceResult<Reimbursement> result = reimbursementService.update(entity);
        if (!result.getSuccess()) {
            log.error("更新失败！");
            jsonResult.setMessage("更新失败！");
            return jsonResult;
        }

        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }
    /**
     * 删除
     * @param request
     * @return
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        Reimbursement entity = new Reimbursement();

        String id = request.getParameter("id");

        entity.setId(Long.valueOf(id));

        ServiceResult<Reimbursement> result = reimbursementService.delete(entity);
        if (!result.getSuccess()) {
            log.error("更新失败！");
            jsonResult.setMessage("更新失败！");
            return jsonResult;
        }

        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }

    /**
     * 提交报销审核
     */
    @RequestMapping(value = "/approval", method = RequestMethod.POST)
    @ResponseBody
    public Object approval(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        Reimbursement entity = new Reimbursement();

        String id = request.getParameter("id");
        entity.setId(Long.valueOf(id));
        entity.setApprovalMan("");
        entity.setCaiwuMan("");
        entity.setApprovalState(1);

        ServiceResult<Reimbursement> result = reimbursementService.approval(entity);
        if (!result.getSuccess()) {
            log.error("提交失败！");
            jsonResult.setMessage("提交失败！");
            return jsonResult;
        }

        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }

}
