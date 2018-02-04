package com.admin.controller.customer;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.biff.DisplayFormat;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.UnderlineStyle;
import jxl.read.biff.BiffException;
import jxl.write.Label;
import jxl.write.NumberFormats;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import lombok.extern.slf4j.Slf4j;

import org.apache.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.admin.entity.customer.Customer;
import com.admin.entity.customer.CustomerContact;
import com.admin.entity.util.TreeNode;
import com.admin.service.customer.CustomerService;
import com.admin.service.system.ResourceInfoService;
import com.admin.web.util.ButtonConstant;
import com.admin.web.util.CommUtil;
import com.admin.web.util.ExcelCallbackInterfaceUtil;
import com.admin.web.util.ExcelExportUtil;
import com.admin.web.util.HttpJsonResult;
import com.admin.web.util.SessionSecurityConstants;
import com.admin.web.util.WebUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.gao.common.BusinessException;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;
import com.gao.common.util.JsonUtil;
import com.gao.common.util.StringUtil;
import com.google.common.base.Throwables;
import com.google.common.collect.Maps;

/**
 *
 * Created by GaoJingFei on 2017/11/13.
 */

@Controller  
@RequestMapping("/customer")
@Slf4j
public class CustomerController {
    private final static org.apache.log4j.Logger logger = LogManager.getLogger(CustomerController.class);
    private String checkStr = "客户名称,所属行业,电话,传真,地址,网址,公司法人/总经理,联系方式,对接部门,对接部门联系人,对接部门联系方式,关联部门,关联部门联系人,关联部门联系方式,姓名,职务,手机,电话,姓名,职务,手机,电话,姓名,职务,手机,电话,姓名,职务,手机,电话,姓名,职务,手机,电话";

    @Resource
    private ResourceInfoService resourceInfoService;
    @Resource  
    private CustomerService customerService;

    @RequestMapping(value = "customer.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(HttpServletRequest request,Map<String, Object> dataMap) throws Exception {
        Long userId = (Long)(request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_ID));
        if (null == userId) {
            log.error("[CustomerController][index] userId不存在,userId={}", userId);
            return "redirect:/login.html";
        }
        Map<String, String> buttonsMap = resourceInfoService.getButtonCodeByUserId(userId);
        String showDistributionCustomerButton = "NO";
        String showCreateCustomerButton = "NO";
        String showFeedbackCustomerButton = "NO";
        if(buttonsMap.containsKey(ButtonConstant.CUSTOMER_DISTRIBUTION_CODE)){
            showDistributionCustomerButton = "YES";
        }
        if(buttonsMap.containsKey(ButtonConstant.CUSTOMER_ADD_CODE)){
            showCreateCustomerButton = "YES";
        }
        if(buttonsMap.containsKey(ButtonConstant.CUSTOMER_FEEDBACK_CODE)){
            showFeedbackCustomerButton = "YES";
        }
        dataMap.put("showDistributionCustomerButton", showDistributionCustomerButton);
        dataMap.put("showCreateCustomerButton", showCreateCustomerButton);
        dataMap.put("showFeedbackCustomerButton", showFeedbackCustomerButton);
        return "customer/customer_list";
    }

    @RequestMapping("/customerList")
    public void customerList(HttpServletRequest request, HttpServletResponse response, Map<String, Object> dataMap){
        Map <String, Object> criteria = Maps.newHashMap();
        try {
            String customerName = request.getParameter("q_customerName");
            String responsiblePersonId = request.getParameter("q_responsiblePersonId");
            if(customerName != null && !"".equals(customerName)){
                criteria.put("customerName", customerName);
            }
            if(responsiblePersonId != null && !"".equals(responsiblePersonId)){
                criteria.put("responsiblePersonId", responsiblePersonId);
            }
            PagerInfo pager = WebUtil.handlerPagerInfo(request, dataMap);
            ServiceResult<Map<String, Object>> serviceResult = customerService.searchCustomers(criteria, pager);
            if(serviceResult.getSuccess()){
                Map<String, Object> map = serviceResult.getResult();
                if(map!=null&&map.size()>0){
                    List<Customer> list = (List<Customer>)map.get("data");
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
            log.error("查询客户列表失败，error={},condition={}", Throwables.getStackTraceAsString(e),criteria);
            throw new BusinessException("查询客户列表失败");
        }
    }

    /**
     * 新增
     * @param request
     * @return
     */
    @RequestMapping(value = "/createCustomer", method = RequestMethod.POST)
    @ResponseBody
    public Object createCustomer(HttpServletRequest request) {
        String nickName = (String)(request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_NICK_NAME));
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        String customerCode = request.getParameter("customerCode");
        String customerName = request.getParameter("customerName");
        String typeCode = request.getParameter("typeCode");
        String typeName = request.getParameter("typeName");
        String phone = request.getParameter("phone");
        String fax = request.getParameter("fax");
        String address = request.getParameter("address");
        String url = request.getParameter("url");
        String manager = request.getParameter("manager");
        String contact = request.getParameter("contact");
        String dockDepartment = request.getParameter("dockDepartment");
        String dockPerson = request.getParameter("dockPerson");
        String dockContact = request.getParameter("dockContact");
        String relateDepartment = request.getParameter("relateDepartment");
        String relatePerson = request.getParameter("relatePerson");
        String relateContact = request.getParameter("relateContact");

        String electric_contactName = request.getParameter("electric_contactName");
        String electric_contactPost = request.getParameter("electric_contactPost");
        String electric_phone = request.getParameter("electric_phone");
        String electric_mobile = request.getParameter("electric_mobile");

        String water_contactName = request.getParameter("water_contactName");
        String water_contactPost = request.getParameter("water_contactPost");
        String water_phone = request.getParameter("water_phone");
        String water_mobile = request.getParameter("water_mobile");

        String safe_contactName = request.getParameter("safe_contactName");
        String safe_contactPost = request.getParameter("safe_contactPost");
        String safe_phone = request.getParameter("safe_phone");
        String safe_mobile = request.getParameter("safe_mobile");

        String visual_contactName = request.getParameter("visual_contactName");
        String visual_contactPost = request.getParameter("visual_contactPost");
        String visual_phone = request.getParameter("visual_phone");
        String visual_mobile = request.getParameter("visual_mobile");

        String emergency_contactName = request.getParameter("emergency_contactName");
        String emergency_contactPost = request.getParameter("emergency_contactPost");
        String emergency_phone = request.getParameter("emergency_phone");
        String emergency_mobile = request.getParameter("emergency_mobile");
        String draft = request.getParameter("draft");

        Customer customer = new Customer();
        customer.setCustomerCode(customerCode);
        customer.setCustomerName(customerName);
        customer.setTypeCode(typeCode);
        customer.setTypeName(typeName);
        customer.setPhone(phone);
        customer.setFax(fax);
        customer.setAddress(address);
        customer.setUrl(url);
        customer.setManager(manager);
        customer.setContact(contact);
        customer.setDockDepartment(dockDepartment);
        customer.setDockPerson(dockPerson);
        customer.setDockContact(dockContact);
        customer.setRelateDepartment(relateDepartment);
        customer.setRelatePerson(relatePerson);
        customer.setRelateContact(relateContact);
        customer.setCreatedBy(nickName);
        customer.setUpdatedBy(nickName);
        if(electric_contactName != null && !"".equals(electric_contactName)){
            CustomerContact electric = new CustomerContact();
            electric.setContactName(electric_contactName);
            electric.setContactPost(electric_contactPost);
            electric.setPhone(electric_phone);
            electric.setMobile(electric_mobile);
            electric.setCreatedBy(nickName);
            electric.setUpdatedBy(nickName);
            customer.setElectric(electric);
        }
        if(water_contactName != null && !"".equals(water_contactName)){
            CustomerContact water = new CustomerContact();
            water.setContactName(water_contactName);
            water.setContactPost(water_contactPost);
            water.setPhone(water_phone);
            water.setMobile(water_mobile);
            water.setCreatedBy(nickName);
            water.setUpdatedBy(nickName);
            customer.setWater(water);
        }
        if(safe_contactName != null && !"".equals(safe_contactName)){
            CustomerContact safe = new CustomerContact();
            safe.setContactName(safe_contactName);
            safe.setContactPost(safe_contactPost);
            safe.setPhone(safe_phone);
            safe.setMobile(safe_mobile);
            safe.setCreatedBy(nickName);
            safe.setUpdatedBy(nickName);
            customer.setSafe(safe);
        }
        if(visual_contactName != null && !"".equals(visual_contactName)){
            CustomerContact visual = new CustomerContact();
            visual.setContactName(visual_contactName);
            visual.setContactPost(visual_contactPost);
            visual.setPhone(visual_phone);
            visual.setMobile(visual_mobile);
            visual.setCreatedBy(nickName);
            visual.setUpdatedBy(nickName);
            customer.setVisual(visual);
        }
        if(emergency_contactName != null && !"".equals(emergency_contactName)){
            CustomerContact emergency = new CustomerContact();
            emergency.setContactName(emergency_contactName);
            emergency.setContactPost(emergency_contactPost);
            emergency.setPhone(emergency_phone);
            emergency.setMobile(emergency_mobile);
            emergency.setCreatedBy(nickName);
            emergency.setUpdatedBy(nickName);
            customer.setEmergency(emergency);
        }
        customer.setStatus(1);
        customer.setDraft(Integer.parseInt(draft));
        ServiceResult<Customer> result = customerService.createCustomer(customer);
        if (!result.getSuccess()) {
            log.error("新增客户失败！");
            jsonResult.setMessage("新增客户失败！");
            return jsonResult;
        }
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }

    /**
     * 修改
     * @param request
     * @return
     */
    @RequestMapping(value = "/updateCustomer", method = RequestMethod.POST)
    @ResponseBody
    public Object updateCustomer(HttpServletRequest request) {
        String nickName = (String)(request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_NICK_NAME));
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        String customeId = request.getParameter("customeId");
        String customerCode = request.getParameter("customerCode");
        String customerName = request.getParameter("customerName");
        String typeCode = request.getParameter("typeCode");
        String typeName = request.getParameter("typeName");
        String phone = request.getParameter("phone");
        String fax = request.getParameter("fax");
        String address = request.getParameter("address");
        String url = request.getParameter("url");
        String manager = request.getParameter("manager");
        String contact = request.getParameter("contact");
        String dockDepartment = request.getParameter("dockDepartment");
        String dockPerson = request.getParameter("dockPerson");
        String dockContact = request.getParameter("dockContact");
        String relateDepartment = request.getParameter("relateDepartment");
        String relatePerson = request.getParameter("relatePerson");
        String relateContact = request.getParameter("relateContact");

        String electric_contactName = request.getParameter("electric_contactName");
        String electric_contactPost = request.getParameter("electric_contactPost");
        String electric_phone = request.getParameter("electric_phone");
        String electric_mobile = request.getParameter("electric_mobile");

        String water_contactName = request.getParameter("water_contactName");
        String water_contactPost = request.getParameter("water_contactPost");
        String water_phone = request.getParameter("water_phone");
        String water_mobile = request.getParameter("water_mobile");

        String safe_contactName = request.getParameter("safe_contactName");
        String safe_contactPost = request.getParameter("safe_contactPost");
        String safe_phone = request.getParameter("safe_phone");
        String safe_mobile = request.getParameter("safe_mobile");

        String visual_contactName = request.getParameter("visual_contactName");
        String visual_contactPost = request.getParameter("visual_contactPost");
        String visual_phone = request.getParameter("visual_phone");
        String visual_mobile = request.getParameter("visual_mobile");

        String emergency_contactName = request.getParameter("emergency_contactName");
        String emergency_contactPost = request.getParameter("emergency_contactPost");
        String emergency_phone = request.getParameter("emergency_phone");
        String emergency_mobile = request.getParameter("emergency_mobile");
        String draft = request.getParameter("draft");

        Customer customer = new Customer();
        customer.setId(Long.parseLong(customeId));
        customer.setCustomerCode(customerCode);
        customer.setCustomerName(customerName);
        customer.setTypeCode(typeCode);
        customer.setTypeName(typeName);
        customer.setPhone(phone);
        customer.setFax(fax);
        customer.setAddress(address);
        customer.setUrl(url);
        customer.setManager(manager);
        customer.setContact(contact);
        customer.setDockDepartment(dockDepartment);
        customer.setDockPerson(dockPerson);
        customer.setDockContact(dockContact);
        customer.setRelateDepartment(relateDepartment);
        customer.setRelatePerson(relatePerson);
        customer.setRelateContact(relateContact);
        customer.setCreatedBy(nickName);
        customer.setUpdatedBy(nickName);
        if(electric_contactName != null && !"".equals(electric_contactName)){
            CustomerContact electric = new CustomerContact();
            electric.setContactName(electric_contactName);
            electric.setContactPost(electric_contactPost);
            electric.setPhone(electric_phone);
            electric.setMobile(electric_mobile);
            electric.setCreatedBy(nickName);
            electric.setUpdatedBy(nickName);
            customer.setElectric(electric);
        }
        if(water_contactName != null && !"".equals(water_contactName)){
            CustomerContact water = new CustomerContact();
            water.setContactName(water_contactName);
            water.setContactPost(water_contactPost);
            water.setPhone(water_phone);
            water.setMobile(water_mobile);
            water.setCreatedBy(nickName);
            water.setUpdatedBy(nickName);
            customer.setWater(water);
        }
        if(safe_contactName != null && !"".equals(safe_contactName)){
            CustomerContact safe = new CustomerContact();
            safe.setContactName(safe_contactName);
            safe.setContactPost(safe_contactPost);
            safe.setPhone(safe_phone);
            safe.setMobile(safe_mobile);
            safe.setCreatedBy(nickName);
            safe.setUpdatedBy(nickName);
            customer.setSafe(safe);
        }
        if(visual_contactName != null && !"".equals(visual_contactName)){
            CustomerContact visual = new CustomerContact();
            visual.setContactName(visual_contactName);
            visual.setContactPost(visual_contactPost);
            visual.setPhone(visual_phone);
            visual.setMobile(visual_mobile);
            visual.setCreatedBy(nickName);
            visual.setUpdatedBy(nickName);
            customer.setVisual(visual);
        }
        if(emergency_contactName != null && !"".equals(emergency_contactName)){
            CustomerContact emergency = new CustomerContact();
            emergency.setContactName(emergency_contactName);
            emergency.setContactPost(emergency_contactPost);
            emergency.setPhone(emergency_phone);
            emergency.setMobile(emergency_mobile);
            emergency.setCreatedBy(nickName);
            emergency.setUpdatedBy(nickName);
            customer.setEmergency(emergency);
        }
        customer.setStatus(1);
        customer.setDraft(Integer.parseInt(draft));
        ServiceResult<Customer> result = customerService.updateCustomer(customer);
        if (!result.getSuccess()) {
            log.error("新增客户失败！");
            jsonResult.setMessage("新增客户失败！");
            return jsonResult;
        }
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }

    /**
     * 分配
     * @param request
     * @return
     */
    @RequestMapping(value = "/distributionCustomer", method = RequestMethod.POST)
    @ResponseBody
    public Object distributionCustomer(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        String customeId = request.getParameter("customeId");
        String responsiblePersonId = request.getParameter("responsiblePersonId");
        String responsiblePerson = request.getParameter("responsiblePerson");
        Customer customer = new Customer();
        customer.setId(Long.parseLong(customeId));
        customer.setResponsiblePerson(responsiblePerson);
        customer.setResponsiblePersonId(Integer.parseInt(responsiblePersonId));
        customer.setUpdatedBy(String.valueOf(request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_NICK_NAME)));
        customer.setUpdatedAt(new Date());
        ServiceResult<Customer> result = customerService.updateCustomer(customer);
        if (!result.getSuccess()) {
            log.error("客户分配失败！");
            jsonResult.setMessage("客户分配失败！");
            return jsonResult;
        }
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }

    /**
     * 客户 列表导出Excel
     * @param request
     * @param response
     */
    @RequestMapping(value = { "/exportCustomerList" })
    public void exportCustomerList(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> params = new HashMap<String, Object>();

        String customerName = request.getParameter("customerName");
        if(customerName != null && !"".equals(customerName)){
            //参数加入params里
            params.put("customerName", customerName);
        }
        PagerInfo pager = new PagerInfo(5000, 1);

        ServiceResult<Map<String, Object>> serviceResult = customerService.searchCustomers(params, pager);
        if(!serviceResult.getSuccess()){
            log.error("查询列表发生异常！");
            return;
        }
        Map<String, Object> map = serviceResult.getResult();
        List<Customer> list = new ArrayList<Customer>();
        if(map != null && map.size() > 0){
            list = (List<Customer>)map.get("data");
        }
        final List<Customer> result = list;

        String fileName = "客户列表" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        String sheetName = "数据导出";
        String[] sheetHead = new String[] { "客户名称", "电话",  "地址", "公司法人或总经理", "业务人员" };

        try {
            ExcelExportUtil.exportEntity(logger, request, response, fileName, sheetName, sheetHead,
                    new ExcelCallbackInterfaceUtil() {

                        @Override
                        public void setExcelBodyTotal(OutputStream os, WritableSheet sheet, int temp)
                                throws Exception {
                            setExcelBodyTotalForUserList(sheet, temp, result);
                        }

                    });
        } catch (Exception e) {
            log.error("客户列表导出失败！", e);
            e.printStackTrace();
        }
    }

    /**
     * 导出用户列表的具体数据，实现回调函数
     * @param sheet
     * @param temp 行号
     * @param list 传入需要导出的 list
     */
    private void setExcelBodyTotalForUserList(WritableSheet sheet, int temp, List<Customer> list) throws Exception {
        WritableFont font = new WritableFont(WritableFont.ARIAL, 9, WritableFont.NO_BOLD, false,
                UnderlineStyle.NO_UNDERLINE, jxl.format.Colour.BLACK);
        WritableCellFormat textFormat = new WritableCellFormat(font);
        textFormat.setAlignment(Alignment.CENTRE);
        textFormat.setBorder(Border.ALL, BorderLineStyle.THIN);

        DisplayFormat displayFormat = NumberFormats.INTEGER;
        WritableCellFormat numberFormat = new WritableCellFormat(font, displayFormat);
        numberFormat.setAlignment(jxl.format.Alignment.RIGHT);
        numberFormat.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);

        for (Customer customer : list) {
            //jxl.write.Number(列号,行号 ,内容 )
            // "客户名称", "电话",  "地址",  "总经理", "业务人员"
            sheet.setColumnView(0, 25);
            sheet.addCell(new Label(0, temp, CommUtil.getStringValue(customer.getCustomerName()), textFormat));

            sheet.setColumnView(1, 25);
            sheet.addCell(new Label(1, temp, CommUtil.getStringValue(customer.getPhone()),textFormat));

            sheet.setColumnView(2, 25);
            sheet.addCell(new Label(2, temp, CommUtil.getStringValue(customer.getAddress()),textFormat));

            sheet.setColumnView(4, 25);
            sheet.addCell(new Label(4, temp, CommUtil.getStringValue(customer.getManager()),textFormat));

            sheet.setColumnView(5, 25);
            sheet.addCell(new Label(5, temp, CommUtil.getStringValue(customer.getResponsiblePerson()),textFormat));

            temp++;
        }
    }

    /**
     * 客户导入
     */
    @RequestMapping(value =  "/importCustomer" )
    public void importCustomer(HttpServletRequest request,
                                   HttpServletResponse response) {
        HttpJsonResult<Map<String, Object>> result = new HttpJsonResult<Map<String, Object>>();
        // 转型为MultipartHttpRequest
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

        // 获得文件
        MultipartFile file = multipartRequest.getFile("file");
        if (file == null) {
            result.setMessage("没有选择导入文件，请选择导入文件后再点击导入操作！");
            writeAjaxHtmlResponse(result, request, response);
            return;
        }

        try {

            List<String[]> list = this.readExcel(file.getInputStream(), 2);

            //验证模板表头信息
            String[] firstLineData = list.get(0);
            boolean flag = this.checkDataTemplate(firstLineData, checkStr);
            if (!flag) {
                result.setMessage("很抱歉！你导入的Excel数据格式与系统模板格式存在差异，请下载模板后重新导入！");
                writeAjaxHtmlResponse(result, request, response);
                return;
            }

            //验证是否有数据
            if (list.size() <= 1) {
                result.setMessage("很抱歉！你导入的Excel没有数据记录，请重新整理导入！");
                writeAjaxHtmlResponse(result, request, response);
                return;
            }

            if (list.size() > 5000 ) {
                result.setMessage("很抱歉！你导入的Excel数据超出限制 5000条，请重新整理导入！");
                writeAjaxHtmlResponse(result, request, response);
                return;
            }
            String nickName = (String)(request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_NICK_NAME));
            List<Customer> customerList = new ArrayList<Customer>();
            for( int i=1 ; i < list.size() ; i++){
                String[] str = list.get(i);
                String customerName = StringUtil.nullSafeString(str[0]);
                String typeName = StringUtil.nullSafeString(str[1]);
                String phone = StringUtil.nullSafeString(str[2]);
                String fax = StringUtil.nullSafeString(str[3]);
                String address = StringUtil.nullSafeString(str[4]);
                String url = StringUtil.nullSafeString(str[5]);
                String manager = StringUtil.nullSafeString(str[6]);
                String contact = StringUtil.nullSafeString(str[7]);
                String dockDepartment = StringUtil.nullSafeString(str[8]);
                String dockPerson = StringUtil.nullSafeString(str[9]);
                String dockContact = StringUtil.nullSafeString(str[10]);
                String relateDepartment = StringUtil.nullSafeString(str[11]);
                String relatePerson = StringUtil.nullSafeString(str[12]);
                String relateContact = StringUtil.nullSafeString(str[13]);

                String electric_contactName = StringUtil.nullSafeString(str[14]);
                String electric_contactPost = StringUtil.nullSafeString(str[15]);
                String electric_phone = StringUtil.nullSafeString(str[16]);
                String electric_mobile = StringUtil.nullSafeString(str[17]);

                String water_contactName = StringUtil.nullSafeString(str[18]);
                String water_contactPost = StringUtil.nullSafeString(str[19]);
                String water_phone = StringUtil.nullSafeString(str[20]);
                String water_mobile = StringUtil.nullSafeString(str[21]);

                String safe_contactName = StringUtil.nullSafeString(str[22]);
                String safe_contactPost = StringUtil.nullSafeString(str[23]);
                String safe_phone = StringUtil.nullSafeString(str[24]);
                String safe_mobile = StringUtil.nullSafeString(str[25]);

                String visual_contactName = StringUtil.nullSafeString(str[26]);
                String visual_contactPost = StringUtil.nullSafeString(str[27]);
                String visual_phone = StringUtil.nullSafeString(str[28]);
                String visual_mobile = StringUtil.nullSafeString(str[29]);

                String emergency_contactName = StringUtil.nullSafeString(str[30]);
                String emergency_contactPost = StringUtil.nullSafeString(str[31]);
                String emergency_phone = StringUtil.nullSafeString(str[32]);
                String emergency_mobile = StringUtil.nullSafeString(str[33]);

                if (StringUtil.isEmpty(customerName, true)) {
                    result.setMessage("很抱歉！你导入的Excel数据,第"+ (i+1) +"行数据 客户名称不能为空! 请核查后重新导入！");
                    writeAjaxHtmlResponse(result, request, response);
                    return;
                }

                Customer customer = new Customer();
                customer.setCustomerName(customerName);
                customer.setTypeName(typeName);
                customer.setPhone(phone);
                customer.setFax(fax);
                customer.setAddress(address);
                customer.setUrl(url);
                customer.setManager(manager);
                customer.setContact(contact);
                customer.setDockDepartment(dockDepartment);
                customer.setDockPerson(dockPerson);
                customer.setDockContact(dockContact);
                customer.setRelateDepartment(relateDepartment);
                customer.setRelatePerson(relatePerson);
                customer.setRelateContact(relateContact);
                customer.setCreatedBy(nickName);
                customer.setUpdatedBy(nickName);
                if(electric_contactName != null && !"".equals(electric_contactName)){
                    CustomerContact electric = new CustomerContact();
                    electric.setContactName(electric_contactName);
                    electric.setContactPost(electric_contactPost);
                    electric.setPhone(electric_phone);
                    electric.setMobile(electric_mobile);
                    electric.setCreatedBy(nickName);
                    electric.setUpdatedBy(nickName);
                    customer.setElectric(electric);
                }
                if(water_contactName != null && !"".equals(water_contactName)){
                    CustomerContact water = new CustomerContact();
                    water.setContactName(water_contactName);
                    water.setContactPost(water_contactPost);
                    water.setPhone(water_phone);
                    water.setMobile(water_mobile);
                    water.setCreatedBy(nickName);
                    water.setUpdatedBy(nickName);
                    customer.setWater(water);
                }
                if(safe_contactName != null && !"".equals(safe_contactName)){
                    CustomerContact safe = new CustomerContact();
                    safe.setContactName(safe_contactName);
                    safe.setContactPost(safe_contactPost);
                    safe.setPhone(safe_phone);
                    safe.setMobile(safe_mobile);
                    safe.setCreatedBy(nickName);
                    safe.setUpdatedBy(nickName);
                    customer.setSafe(safe);
                }
                if(visual_contactName != null && !"".equals(visual_contactName)){
                    CustomerContact visual = new CustomerContact();
                    visual.setContactName(visual_contactName);
                    visual.setContactPost(visual_contactPost);
                    visual.setPhone(visual_phone);
                    visual.setMobile(visual_mobile);
                    visual.setCreatedBy(nickName);
                    visual.setUpdatedBy(nickName);
                    customer.setVisual(visual);
                }
                if(emergency_contactName != null && !"".equals(emergency_contactName)){
                    CustomerContact emergency = new CustomerContact();
                    emergency.setContactName(emergency_contactName);
                    emergency.setContactPost(emergency_contactPost);
                    emergency.setPhone(emergency_phone);
                    emergency.setMobile(emergency_mobile);
                    emergency.setCreatedBy(nickName);
                    emergency.setUpdatedBy(nickName);
                    customer.setEmergency(emergency);
                }
                customer.setCreatedBy(nickName);
                customer.setUpdatedBy(nickName);
                customer.setStatus(2);
                customer.setDraft(0);
                ServiceResult<Customer> createResult = customerService.createCustomer(customer);
                if(!createResult.getSuccess()){
                    log.error("导入失败");
                    result.setMessage(createResult.getMessage());
                    writeAjaxHtmlResponse(result, request, response);
                    return;
                }
                writeAjaxHtmlResponse(result, request, response);
                return;
            }

        }catch (Exception e) {
            e.printStackTrace();
            log.error("导入失败", e);
            result.setMessage(e.getMessage());
            writeAjaxHtmlResponse(result, request, response);
            return;
        }

    }

    private boolean checkDataTemplate(String[] firstLineData, String checkStr) {
        boolean flag = false;
        StringBuffer sb = new StringBuffer();
        for (String str : firstLineData) {
            if (sb.length() > 0){
                sb.append(",");
            }
            sb.append(str.trim());
        }
        String str = sb.toString();
        if(str.endsWith(",")){
            str = str.substring(0,str.length()-1);
        }
        if (str.equals(checkStr))
            flag = true;
        return flag;
    }

    /**
     *
     * @param stream 读取文件对象
     * @param rowNum 从第几行开始读，如果有一行表头则从第二行开始读
     */
    private List<String[]> readExcel(InputStream stream, int rowNum) throws BiffException,
            IOException {
        // 创建一个list 用来存储读取的内容
        List<String[]> list = new ArrayList<String[]>();
        Workbook rwb = null;
        Cell cell = null;
        // 创建输入流
        //        InputStream stream = new FileInputStream(excelFile);
        // 获取Excel文件对象
        rwb = Workbook.getWorkbook(stream);
        // 获取文件的指定工作表 默认的第一个
        Sheet sheet = rwb.getSheet(0);
        // 行数(表头的目录不需要，从1开始)
        for (int i = rowNum - 1; i < sheet.getRows(); i++) {
            // 创建一个数组 用来存储每一列的值
            String[] str = new String[sheet.getColumns()];
            // 列数
            for (int j = 0; j < sheet.getColumns(); j++) {
                // 获取第i行，第j列的值
                cell = sheet.getCell(j, i);
                str[j] = cell.getContents();
            }
            // 把刚获取的列存入list
            list.add(str);
        }
        rwb.close();
        stream.close();
        // 返回值集合
        return list;
    }

    /**
     * 将json或jsonp的返回数据写入到response中。
     *
     * @param result 要转换为json或jsonp的对象
     * @param request
     * @param response
     */
    private void writeAjaxHtmlResponse(Object result, HttpServletRequest request, HttpServletResponse response) {
        PrintWriter out = null;
        try {
            response.setContentType("text/html;charset=utf-8");
            out = response.getWriter();
            String jsonStr = null;
            String callback = request.getParameter("callback");
            String json = JSON.toJSONString(result, SerializerFeature.BrowserCompatible);
            if (StringUtil.isEmpty(callback, true)) {
                jsonStr = json;
            } else {
                jsonStr = callback + "(" + json + ")";
            }
            out.write(jsonStr);
        } catch (IOException e) {
            log.error("[writeAjaxResponse]开启输出流错误", e);
        } finally {
            if (out != null) {
                try {
                    out.flush();
                    out.close();
                } catch (Exception e) {
                    log.error("[writeAjaxResponse]关闭输出流错误", e);
                }
            }
        }
    }

    /**
     * 特定角色的用户下拉菜单
     * @param request
     * @return
     */
    @RequestMapping(value = "/searchCustomerIdCombo", method = {RequestMethod.POST,RequestMethod.GET} )
    @ResponseBody
    public Object searchUserByRoleIdCombo(HttpServletRequest request) {
        List<TreeNode> nodeList = new ArrayList<TreeNode>();
        /*String roleId = request.getParameter("roleId");
        if(roleId == null || "".equals(roleId)){
            return JsonUtil.toJson(nodeList);
        }*/
        Map<String, Object> params = new HashMap<String, Object>();
        ServiceResult<List<Customer>> result = customerService.searchCustomerIdCombo(params);
        if(!result.getSuccess()){
            log.error("查询特定客户的客户列表发生异常！");
            return null;
        }
        List<Customer> userList = result.getResult();
        for (Customer userInfo : userList) {
            TreeNode node = new TreeNode();
            node.setId(String.valueOf(userInfo.getId()));
            node.setText(userInfo.getCustomerName());
            node.setState("open");
            nodeList.add(node);
        }
        return JsonUtil.toJson(nodeList);
    }

    /**
     * 协助
     * @param request
     * @return
     */
    @RequestMapping(value = "/assistCustomer", method = RequestMethod.POST)
    @ResponseBody
    public Object assistCustomer(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        String customeId = request.getParameter("customeId");
        String assistPersonId = request.getParameter("assistPersonId");
        String assistPerson = request.getParameter("assistPerson");
        Customer customer = new Customer();
        customer.setId(Long.parseLong(customeId));
        customer.setAssistPerson(assistPerson);
        customer.setAssistPersonId(Integer.parseInt(assistPersonId));
        customer.setUpdatedBy(String.valueOf(request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_NICK_NAME)));
        customer.setUpdatedAt(new Date());
        ServiceResult<Customer> result = customerService.updateCustomer(customer);
        if (!result.getSuccess()) {
            log.error("客户协助失败！");
            jsonResult.setMessage("客户协助失败！");
            return jsonResult;
        }
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }

    /**
     * 审核
     * @param request
     * @return
     */
    @RequestMapping(value = "/auditCustomer", method = RequestMethod.POST)
    @ResponseBody
    public Object auditCustomer(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        String customeId = request.getParameter("customeId");
        String status = request.getParameter("status");
        Customer customer = new Customer();
        customer.setId(Long.parseLong(customeId));
        customer.setStatus(Integer.parseInt(status));
        customer.setUpdatedBy(String.valueOf(request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_NICK_NAME)));
        customer.setUpdatedAt(new Date());
        ServiceResult<Customer> result = customerService.updateCustomer(customer);
        if (!result.getSuccess()) {
            log.error("客户审核失败！");
            jsonResult.setMessage("客户审核失败！");
            return jsonResult;
        }
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }

    /**
     * 移入公海
     * @param request
     * @return
     */
    @RequestMapping(value = "/updateCustomerToOpenSea", method = RequestMethod.POST)
    @ResponseBody
    public Object updateCustomerToOpenSea(HttpServletRequest request) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        String customeId = request.getParameter("customeId");
        Customer customer = new Customer();
        customer.setId(Long.parseLong(customeId));
        customer.setUpdatedBy(String.valueOf(request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_NICK_NAME)));
        customer.setUpdatedAt(new Date());
        ServiceResult<Customer> result = customerService.updateToOpenSea(customer);
        if (!result.getSuccess()) {
            log.error("客户移入公海失败！");
            jsonResult.setMessage("客户移入公海失败！");
            return jsonResult;
        }
        jsonResult.setData(result.getSuccess());
        return jsonResult;
    }

}  