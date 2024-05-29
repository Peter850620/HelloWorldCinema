package com.websc;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import io.lettuce.core.output.SocketAddressOutput;

@ServerEndpoint("/seatSync")
public class SeatWebSocket {
    // 儲存用戶ID  跟用戶座位集合
    private static Map<String, Set<String>> userSeatsMap = new ConcurrentHashMap<>();  //執行續安全
    private static Map<String, String> userShow= new HashMap();
    private static Set<Session> sessions = new HashSet<>();

    @OnOpen
    public void onOpen(Session session) {


        userSeatsMap.put(session.getId(), new HashSet<>());//有新用戶時把用戶ID加入 userSeatsMap的KEY 值是座位的SET
        sessions.add(session);  
        
        sendAllSeatsStatus(session);
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        String[] parts = message.split(",");   //接收客戶端傳來的座位訊息把座位用逗號分割成 座位 以及狀態
        String seatId = parts[0];
        String action = parts[1];
        String showid=parts[2];
     

        String userId = session.getId();
        Set<String> seats = userSeatsMap.get(userId);  //取得用戶對應的座位Set
       	userShow.put(userId, showid);
 
      
        switch (action) {
            case "selected":
                seats.add(seatId);           //如果傳來的狀態是"已選",那把該座位加入到該用戶的集合
                break;
            case "cancelled":
                if (seats.contains(seatId)) {   //如果狀態是"取消",先檢查用戶的集合是否有該座位編號? 有的話就移除
                    seats.remove(seatId);
                  
                } else {
                	
                    sendToSession(session, seatId+","+"錯誤:您不具有權力取消該座位"+","+showid);
                    //沒有的話則發送錯誤訊息給前端
                    return;
                }
                break;
        }
        broadcast(seatId, action,showid);
    }
    
    
    private void broadcast(String seatId, String status,String showid) {  //推播地方
        String message = seatId + "," + status+","+showid;
        for (Session session : sessions) {
            if (session.isOpen()) {                             
                session.getAsyncRemote().sendText(message);
            }
        }
    }


    private synchronized void sendToSession(Session session, String message) {
        if (session.isOpen()) {
    
            session.getAsyncRemote().sendText(message);   //發送訊息給前端
        }
    }

    
    //當有新的工作人員預選同個場次時,要推播其他用戶的座位
    private synchronized void sendAllSeatsStatus(Session session) {
        for (Map.Entry<String, Set<String>> entry : userSeatsMap.entrySet()) {
            Set<String> seats = entry.getValue();
        	String show=userShow.get(entry.getKey());
  
            for (String seatId : seats) {
            
                String message = seatId + ",selected," +show; // 假设所有座位都属于相同的 showid
              
                sendToSession(session, message);
                
                try {
                    Thread.sleep(50); // 避免快速發送訊息給新用戶造成
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    
   

    @OnClose
    public void onClose(Session session) {
        System.out.println("連結關閉：" + session.getId());
        userSeatsMap.remove(session.getId());
        sessions.remove(session);
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        System.out.println("錯誤：" + throwable.getMessage());
    }
}
