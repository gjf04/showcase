package com.admin.web.interceptor;

import com.admin.web.util.SessionSecurityConstants;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashSet;
import java.util.Set;

/**
 * 系统权限拦截器
 * @Filename: AuthInterceptor.java
 * @Version: 1.0
 * @Author: gaojingfei
 */
public class AuthInterceptor extends HandlerInterceptorAdapter {

    private final static Logger      log  = LogManager.getLogger(AuthInterceptor.class);

    private final static Set<String> ANONYMOUS_URLS = new HashSet<String>();

    static {
        ANONYMOUS_URLS.add("/error.html");
        ANONYMOUS_URLS.add("/login.html");
        ANONYMOUS_URLS.add("/index.html");
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) {
        try {
            String path = request.getRequestURI();
            log.debug("[admin][AuthInterceptor][preHandle]url：" + path);
            if (ANONYMOUS_URLS.contains(path)) {
                return true;
            }
            //log.error("[admin][AuthInterceptor][preHandle]url：" + path);
            Long userId = (Long)(request.getSession().getAttribute(SessionSecurityConstants.KEY_USER_ID));

            // 跳转url
            if (null == userId) {
                response.sendRedirect("/login.html");
                return false;
            }
            
            return true;
        } catch (Exception e) {
            log.error("[admin][AuthInterceptor][preHandle] exception:", e);
            return false;
        }
    }
   
}
