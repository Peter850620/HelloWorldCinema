package com.websc;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import com.fasterxml.jackson.databind.ObjectMapper;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.entity.Message;

@ServerEndpoint("/socket/message")
public class MessageWebSocket {
	
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());
	private static ObjectMapper objectMapper = new ObjectMapper();

    @OnOpen
    public void onOpen(Session session) {
        clients.add(session);
    }

    @OnClose
    public void onClose(Session session) {
        clients.remove(session);
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        
    }

    public static void broadcast(Message  message) {
    	try {
    		String messageJson = objectMapper.writeValueAsString(message);
            synchronized (clients) {
                for (Session client : clients) {
                    try {
                        client.getBasicRemote().sendText(messageJson);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
    	}catch (IOException e) {
            e.printStackTrace();
        }
    	
    }

}
