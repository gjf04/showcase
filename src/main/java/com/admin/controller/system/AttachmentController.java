package com.admin.controller.system;

import com.admin.entity.customer.Customer;
import com.admin.entity.customer.CustomerContact;
import com.admin.entity.system.Attachment;
import com.admin.service.system.AttachmentService;
import com.admin.service.system.ProspectService;
import com.admin.web.util.HttpJsonResult;
import com.admin.web.util.SessionSecurityConstants;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.gao.common.ServiceResult;
import com.gao.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * Created by GaoJingFei on 2017/11/13.
 */

@Controller  
@RequestMapping("/system") 
@Slf4j
public class AttachmentController {
    //附件保存路径
    public static final String ATTACHMENT_PATH = File.separator + "usr" + File.separator + "attachment" + File.separator;

    //public static final String ATTACHMENT_PATH= "D:\\usr\\attachment\\";//本地测试

    @Resource
    private AttachmentService attachmentService;

    @RequestMapping(value = "attachment.html", method = { RequestMethod.GET, RequestMethod.POST })
    public String index(HttpServletRequest request, Model model) throws Exception {
        
        return "system/attachment_list";
    }

    /**
     * 附件上传
     */
    @RequestMapping(value =  "/uploadAttachment" )
    public void uploadAttachment(HttpServletRequest request,
                               HttpServletResponse response) {
        HttpJsonResult<Map<String, Object>> result = new HttpJsonResult<Map<String, Object>>();
        String relateId = request.getParameter("relateId");
        String fileType = request.getParameter("fileType");
        // 转型为MultipartHttpRequest
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

        // 获得文件
        MultipartFile file = multipartRequest.getFile("file");
        if (file == null) {
            result.setMessage("没有选择文件，请选择文件后再操作！");
            writeAjaxHtmlResponse(result, request, response);
            return;
        }

        try {
            String path = ATTACHMENT_PATH;
            String fileName = file.getOriginalFilename();
            File targetFile = new File(path, fileName);
            if(!targetFile.exists()){
                targetFile.mkdirs();
            }
            //保存
            try {
                file.transferTo(targetFile);
            } catch (Exception e) {
                e.printStackTrace();
            }
            Attachment attachment = new Attachment();
            attachment.setFileCode("0000");
            attachment.setFileName(fileName);
            attachment.setFileType(Integer.parseInt(fileType));
            attachment.setRelateId(Long.parseLong(relateId));
            attachment.setUrl(path);
            attachment.setCreatedBy(String.valueOf(request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_NICK_NAME)));
            attachment.setUpdatedBy(String.valueOf(request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_NICK_NAME)));
            ServiceResult<Attachment> attachmentResult = attachmentService.createAttachment(attachment);
            if(!attachmentResult.getSuccess()){
                log.error("附件上传失败", attachmentResult.getMessage());
                result.setMessage(attachmentResult.getMessage());
                writeAjaxHtmlResponse(result, request, response);
                return;
            }
            writeAjaxHtmlResponse(result, request, response);
            return;

        }catch (Exception e) {
            e.printStackTrace();
            log.error("附件上传失败", e);
            result.setMessage(e.getMessage());
            writeAjaxHtmlResponse(result, request, response);
            return;
        }
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

}  