package com.filter;

import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;


@Component
public class EmpFilter implements HandlerInterceptor {
    String[] ignoreUrls = {"/emp/toLogin","/emp/doLogin","/emp/resetPasswordLink"};
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Cookie[] cookies = request.getCookies();
        Optional<Cookie> loginAlready = null;
        if (!ObjectUtils.isEmpty(cookies)) {
            loginAlready = Arrays.stream(cookies).filter(cookie -> "loginAlready".equals(cookie.getName())).findFirst();
        }
        List<String> list = Arrays.stream(ignoreUrls).toList();
        for (String url :ignoreUrls){
            boolean equals = url.equals(request.getRequestURI());
            if (equals){
                return true;
            }
        }
        if (!ObjectUtils.isEmpty(loginAlready)) {
            return true;
        }
        response.sendRedirect("/emp/toLogin");
        return false;
    }
}
