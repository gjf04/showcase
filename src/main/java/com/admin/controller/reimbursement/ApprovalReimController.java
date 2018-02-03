package com.admin.controller.reimbursement;

import com.admin.entity.reimbursement.Reimbursement;
import com.admin.service.reimbursement.ReimbursementService;
import com.admin.web.util.DateUtil;
import com.admin.web.util.HttpJsonResult;
import com.admin.web.util.SessionSecurityConstants;
import com.admin.web.util.WebUtil;
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
import java.util.List;
import java.util.Map;

/**
 * 报销管理Controller
 * @author WangDeYu
 * @version 2017-12-25
 */

@Controller
@RequestMapping("/approval")
@Slf4j

public class ApprovalReimController {
    @Autowired
    private ReimbursementService reimbursementService;

    @RequestMapping(value = "approvallist.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index1(HttpServletRequest request, Map<String, Object> dataMap) throws Exception {
        return "approval/approvallist";
    }


    @RequestMapping(value = "/approvallist", method = { RequestMethod.GET, RequestMethod.POST })
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
     * 提交报销审核
     */
    @RequestMapping(value = "/approval1", method = RequestMethod.POST)
    @ResponseBody
    public Object approval(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        Reimbursement entity = new Reimbursement();
        String userName = request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_NICK_NAME).toString();

        String id = request.getParameter("id");
        String status = request.getParameter("status");
        String approvalState = request.getParameter("paramstyle");
        entity.setId(Long.valueOf(id));

        // 错误打回
        if (Integer.parseInt(status) == 2) {
            entity.setApprovalState(4);
            entity.setApprovalMan("");
            entity.setCaiwuMan("");
        // 各级审核通过
        } else {
            entity.setApprovalState(Integer.parseInt(approvalState)+1);
            // 总监审核
            if (Integer.parseInt(approvalState) == 1) {
                entity.setApprovalMan(userName);
                entity.setCaiwuMan("");
            // 财务审核
            } else if (Integer.parseInt(approvalState) == 2) {
                entity.setApprovalMan("");
                entity.setCaiwuMan(userName);
            }
        }

        ServiceResult<Reimbursement> result = reimbursementService.approval(entity);
        if (!result.getSuccess()) {
            log.error("审核失败！");
            jsonResult.setMessage("审核失败！");
            return jsonResult;
        }

        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }

}
