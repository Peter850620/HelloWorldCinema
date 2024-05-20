package com.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;

@Component
public class PermissionFilter implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 从请求中获取名为 "loginAlready" 的 cookie
        String cookieValue = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("loginAlready".equals(cookie.getName())) {
                    cookieValue = cookie.getValue();
                    break;
                }
            }
        }

        // 解码 cookie 值并将其存储在请求属性中
        if (cookieValue != null && !cookieValue.isEmpty()) {
            byte[] decodedBytes = Base64.getDecoder().decode(cookieValue);
            String decodedValue = new String(decodedBytes);
            List<Integer> permissions = Arrays.asList(new ObjectMapper().readValue(decodedValue, Integer[].class));
            request.setAttribute("permissions", permissions);
        }

        return true; // 继续请求处理链
    }
}
