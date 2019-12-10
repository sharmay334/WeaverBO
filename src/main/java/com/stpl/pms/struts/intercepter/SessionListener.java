package com.stpl.pms.struts.intercepter;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.log4j.Logger;

import com.stpl.pms.controller.lm.BOLoginController;

public class SessionListener implements HttpSessionListener {

	private static int totalActiveSessions;
	private static final Logger logger = Logger.getLogger(SessionListener.class);
	private List<HttpSession> sessionList = new ArrayList<HttpSession>();

	public static int getTotalActiveSession() {
		return totalActiveSessions;
	}

	public void sessionCreated(HttpSessionEvent event) {
		totalActiveSessions++;
		sessionList.add(event.getSession());
		logger.info("sessionCreated - add one session into counter "+event.getSession().getId());
	}

	public void sessionDestroyed(HttpSessionEvent event) {
		logger.info("In sessionDestroyed(HttpSessionEvent) ");

		    HttpSession httpSession = event.getSession();
		    long createdTime = httpSession.getCreationTime();
		    long lastAccessedTime = httpSession.getLastAccessedTime();
		    int maxInactiveTime = httpSession.getMaxInactiveInterval();
		    long currentTime = System.currentTimeMillis();

//		    System.out.println("Session Id :f"+httpSession.getId() );
//		    System.out.println("Created Time : " + createdTime);
//		    System.out.println("Last Accessed Time : " + lastAccessedTime);
//		    System.out.println("Current Time : " + currentTime);
		    boolean possibleSessionTimeout = (currentTime-lastAccessedTime) >= (maxInactiveTime*1000);

//		    System.out.println("Possbile Timeout : " + possibleSessionTimeout);
//		    System.out.println("Exiting sessionDestroyed(HttpSessionEvent)");
//		    System.out.println();
		    
		    if(possibleSessionTimeout){
		    	new BOLoginController().logoutUser(httpSession.getId());
		    }
		    sessionList.remove(event.getSession());
		logger.info("sessionDestroyed - deduct one session from counter "+httpSession.getId());
		    
	}
}