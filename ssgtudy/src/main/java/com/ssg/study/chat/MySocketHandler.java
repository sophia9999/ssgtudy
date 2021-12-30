package com.ssg.study.chat;

import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import javax.annotation.PostConstruct;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


public class MySocketHandler extends TextWebSocketHandler {
	private final Logger logger = LoggerFactory.getLogger(MySocketHandler.class);
	
	// 접속한 클라이언트의 정보를 저장할 Map
		private Map<String, User> sessionMap = new Hashtable<String, User>();
		
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			super.afterConnectionEstablished(session);
			
			// WebSocket 연결이 되고 사용이 준비될 때 호출
		}

		@Override
		public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
			super.handleMessage(session, message);
			
			// 클라이언트로부터 메시지가 도착했을 때 호출
			JSONObject jsonReceive = null;
			try {
				jsonReceive = new JSONObject(message.getPayload().toString());
				System.out.println(jsonReceive);
			} catch (Exception e) {
				return;
			}
			
			String cmd = jsonReceive.getString("cmd");
			if(cmd == null) {
				return;
			}
			
			if(cmd.equals("connect")) { // 처음 접속한 경우
				// 접속한 사용자의 아이디(회원번호)를 키로 session과 유저의 정보를 저장
				String uid = jsonReceive.getString("uid");
				String nickName = jsonReceive.getString("nickName");
				
				User user = new User();
				user.setUid(uid);
				user.setNickName(nickName);
				user.setSession(session);
				
				sessionMap.put(uid, user);
				
				// 현재 접속 중인 사용자 목록을 전송함
				Iterator<String> it = sessionMap.keySet().iterator();
				while(it.hasNext()) {
					String key = it.next();
					if(uid.equals(key)) { // 자기 자신
						continue;
					}
					
					User vo = sessionMap.get(key);
					
					JSONObject job = new JSONObject();
					job.put("cmd", "connectList");
					job.put("uid", vo.getUid());
					job.put("nickName", vo.getNickName());
					
					sendOneMessage(job.toString(), session);
				}
				
				// 다른 사용자에게 접속 사실을 알림
				JSONObject job = new JSONObject();
				job.put("cmd", "connect");
				job.put("uid", uid);
				job.put("nickName", nickName);
				sendAllMessage(job.toString(), uid);	
			} else if(cmd.equals("message")) {
				User vo = getUser(session);
				String msg = jsonReceive.getString("chatMsg");
				
				JSONObject job = new JSONObject();
				job.put("cmd", "message");
				job.put("chatMsg", msg);
				job.put("uid", vo.getUid());
				job.put("nickName", vo.getNickName());
				//다른 사용자에게 메시지 전송
				sendAllMessage(job.toString(), vo.getUid());
			} else if(cmd.equals("whisper")) {
				User vo = getUser(session);
				
				String msg = jsonReceive.getString("chatMsg");
				String receiver = jsonReceive.getString("receiver");
				User receiverVo = sessionMap.get(receiver);
				if(receiverVo == null) {
					return;
				}
				
				JSONObject job = new JSONObject();
				job.put("cmd", "whisper");
				job.put("chatMsg", msg);
				job.put("uid", vo.getUid());
				job.put("nickName", vo.getNickName());
				
				// 귓속말 대상자에게 메시지 보내기
				sendOneMessage(job.toString(), receiverVo.getSession());
			}
		}

		@Override
		public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
			super.handleTransportError(session, exception);
			
			// 전송 에러가 발생할 때 호출
			removeUser(session);
		}

		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			super.afterConnectionClosed(session, status);
			
			// WebSocket이 닫혔을 때 호출
			String uid = removeUser(session);
			
			logger.info("remove session : " + uid);
		}
		
		// 모든 사용자에게 메시지 전송
		protected void sendAllMessage(String message, String out) {
			Iterator<String> it = sessionMap.keySet().iterator();
			while(it.hasNext()) {
				String key = it.next();
				
				if(out != null && out.contentEquals(key)) { // 자기 자신 제외
					continue;
				}
				
				User user = sessionMap.get(key);
				WebSocketSession session = user.getSession();
				
				try {
					if(session.isOpen()) {
						session.sendMessage(new TextMessage(message));
					}
				} catch (Exception e) {
					removeUser(session);
				}
			}
			
		}
		
		// 특정 사용자에게 메시지 전송
		protected void sendOneMessage(String message, WebSocketSession session) {
			if(session.isOpen()) {
				try {
					session.sendMessage(new TextMessage(message));
				} catch (Exception e) {
					logger.error("fail to send message !", e);
				}
			}
		}
		
		// session에 해당하는 User 객체
		protected User getUser(WebSocketSession session) {
			Iterator<String> it = sessionMap.keySet().iterator();
			
			while(it.hasNext()) {
				String key = it.next();
				
				User dto = sessionMap.get(key);
				if(dto.getSession() == session) {
					return dto;
				}
			}
			
			return null;
		}
		
		// 서버에 저장된 User 객체 삭제
		protected String removeUser(WebSocketSession session) {
			User user = getUser(session);
			
			if(user == null) {
				return null;
			}
			
			// 퇴장 사실을 다른 모든 클라이언트에게 전송
			JSONObject job = new JSONObject();
			job.put("cmd", "disconnect");
			job.put("uid", user.getUid());
			job.put("nickName", user.getNickName());
			
			sendAllMessage(job.toString(), user.getUid());
			
			try {
				user.getSession().close();
			} catch (Exception e) {
			}
			
			// SessionMap에서 퇴장한 유저 지우기
			sessionMap.remove(user.getUid());
			
			return user.getUid();
		}
		
		@PostConstruct // init-method(생성자가 생성된 후 딱 한번만 실행됨)
		public void init() throws Exception {
			TimerTask task = new TimerTask() {
				@Override
				public void run() {
					Calendar cal = Calendar.getInstance();
					int h = cal.get(Calendar.HOUR_OF_DAY);
					int m = cal.get(Calendar.MINUTE);
					int s = cal.get(Calendar.SECOND);
					
					JSONObject job = new JSONObject();
					job.put("cmd", "time");
					job.put("hour", h);
					job.put("minute", m);
					job.put("second", s);
					
					sendAllMessage(job.toString(), null);
					
				}
			};
			
			Timer timer = new Timer();
			// 1분마다 실행
			timer.schedule(task, new Date(), 60000);
			
		}
}
