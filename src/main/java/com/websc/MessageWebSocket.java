package com.websc;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.entity.Message;
import com.fasterxml.jackson.databind.ObjectMapper;

@ServerEndpoint("/socket/message")
public class MessageWebSocket {
	
	 private static Map<String, Set<Session>> userSessions = new ConcurrentHashMap<>();

	    @OnOpen
	    public void onOpen(Session session) {
	    	 String userId = String.valueOf(getUserIdFromQueryString(session));
	    	 System.out.println("WebSocket connection opened with userId: " + userId);
	         if (userId != null) {
	             userSessions.computeIfAbsent(userId, k -> Collections.newSetFromMap(new ConcurrentHashMap<>())).add(session);
	             session.getUserProperties().put("userId", userId);
	             System.out.println("User connected: " + userId);
	         } else {
	             try {
	                 session.close();
	             } catch (IOException e) {
	                 e.printStackTrace();
	             }
	         }
	    }

	    @OnClose
	    public void onClose(Session session) {
	    	String userId = String.valueOf(session.getUserProperties().get("userId"));
	    	System.out.println("WebSocket connection closed for userId: " + userId);
	        if (userId != null) {
	            Set<Session> sessions = userSessions.get(userId);
	            System.out.println(userId);
	            if (sessions != null) {
	                sessions.remove(session);
	                if (sessions.isEmpty()) {
	                    userSessions.remove(userId);
	                }
	            }
	        }
	    }

	    @OnMessage
	    public void onMessage(String message, Session session) {

	    }

	    public static void broadcast(Integer userId, Message message) {
	    	 Set<Session> sessions = userSessions.get(String.valueOf(userId));
	         if(sessions == null) {
	        	 System.out.println("sessions為空值");
	         }
	         System.out.println("廣播用戶ID" + userId);
	    	 if (sessions != null) {
	             String messageJson;
	             try {
	                 messageJson = new ObjectMapper().writeValueAsString(message);
	             } catch (IOException e) {
	                 e.printStackTrace();
	                 return;
	             }
	             synchronized (sessions) {
	                 for (Session userSession : sessions) {
	                     try {
	                    	 System.out.println("發送消息到用戶: " + userSession.getId());
	                         userSession.getBasicRemote().sendText(messageJson);
	                     } catch (IOException e) {
	                         e.printStackTrace();
	                     }
	                 }
	             }
	         }
	    }
	    
	    private Integer getUserIdFromQueryString(Session session) { 
	    	Map<String, List<String>> queryParams = session.getRequestParameterMap();
	    	if(queryParams.isEmpty()) {
	        	System.out.println("queryParams: null");
	        }
	        List<String> userIdValues = queryParams.get("userId");
	        if(userIdValues == null) {
	        	System.out.println("userIdValues: null");
	        }
	        if (userIdValues != null && !userIdValues.isEmpty()) {
	            try {
	                Integer userId = Integer.parseInt(userIdValues.get(0));
	                return userId;
	            } catch (NumberFormatException e) {
	                System.out.println("Invalid user ID format: " + userIdValues.get(0));
	            }
	        }
	        return null;
	    }

}
