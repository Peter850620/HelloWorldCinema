package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.util.HibernateUtil;

@WebFilter(urlPatterns = { "/*" })
public class OpenSessionInViewFilter implements Filter {

    private SessionFactory factory;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        factory = HibernateUtil.getSessionFactory();
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        Session session = factory.getCurrentSession(); // 獲取當前 session
        Transaction tx = null;
        try {
            tx = session.beginTransaction(); // 開始事務
            chain.doFilter(req, res); // 繼續處理請求
            tx.commit(); // 提交事務
        } catch (Exception e) {
            if (tx != null) tx.rollback(); // 如果發生異常，回滾事務
            e.printStackTrace();
          
        }
    }

    @Override
    public void destroy() {
        // 清理資源
    }
}
