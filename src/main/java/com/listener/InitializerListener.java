package com.listener;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.service.MessageServiceImpl;
import com.util.HibernateUtil;

@WebListener
public class InitializerListener implements ServletContextListener {
	
	private ScheduledExecutorService scheduler;
	private MessageServiceImpl messageServiceImpl;
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("context started");
		HibernateUtil.getSessionFactory();
//		messageServiceImpl = new MessageServiceImpl();
//		ScheduledExecutorService scheduler = Executors.newSingleThreadScheduledExecutor();
//		scheduler.scheduleAtFixedRate(messageServiceImpl::scheduleMessage, 0, 1, TimeUnit.MINUTES);
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("context ended");
		HibernateUtil.shutdown();
//		if (scheduler != null) {
//            scheduler.shutdownNow();
//            try {
//                if (!scheduler.awaitTermination(60, TimeUnit.SECONDS)) {
//                    scheduler.shutdownNow();
//                }
//            } catch (InterruptedException e) {
//                scheduler.shutdownNow();
//            }
//        }
//        System.out.println("通知排程器已停止");
	}
}
