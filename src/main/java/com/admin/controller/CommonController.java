package com.admin.controller;

import com.admin.web.util.HttpJsonResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;

@Controller
@Slf4j
public class CommonController {

    @RequestMapping(value = { "/", "/login", "/login.html" }, method = { RequestMethod.GET })
    public String login(HttpServletRequest request) {
        return "login";
    }

    @RequestMapping(value = { "/downloadTemplate" }, method = { RequestMethod.GET, RequestMethod.POST })
    @ResponseBody
    public Object downloadTemplate(HttpServletRequest request, HttpServletResponse response) {
        HttpJsonResult<Object> jsonResult = new HttpJsonResult<Object>();
        String location = request.getParameter("location");
        String path = request.getSession().getServletContext().getRealPath(location);
        String fileName = request.getParameter("fileName");
        File file = new File(path);
        OutputStream out = null;
        InputStream is = null;
        try {
            is = new BufferedInputStream(new FileInputStream(file),1024*1024);
            response.setContentType("application/x-download"); // 设置返回的文件类型
            response.setHeader("Content-Disposition","attachment;filename="+ URLEncoder.encode(fileName, "UTF-8"));
            out = response.getOutputStream(); // 得到向客户端输出二进制数据的对象
            byte[] bytes = new byte [ 1024 ];
            int readTemp = 0;
            while ((readTemp =is.read(bytes)) != -1) {
                out.write( bytes,0,readTemp);
            }
            out.flush();
        } catch (Exception e) {
            log.error(e.getMessage());
            jsonResult.setMessage(e.getMessage());
            jsonResult.setData(false);
        }finally{
            if (is != null) {
                try {
                    is.close();
                } catch (IOException e ) {
                }
            }
            if (out != null) {
                try {
                    out.close();
                } catch (IOException e ) {
                }
            }
        }
        return jsonResult;
    }
}  