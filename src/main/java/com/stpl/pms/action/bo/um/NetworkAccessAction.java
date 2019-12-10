package com.stpl.pms.action.bo.um;

import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;

@SuppressWarnings("serial")
public class NetworkAccessAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	

	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> accessType;
	private String ipAddress;
	private String status;
	private static String userName;
	
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String successCall()
	{
		return SUCCESS;
	}
	public String getSubUserNetworkAccess()
	{
		accessType=new ArrayList<String>();
		accessType.add("ACTIVE");
		accessType.add("INACTIVE");
		return SUCCESS;
	}
	public String assignSubUserNetworkAccess()
	{
		String status=null;
		try
		{
			Date date = new Date();
			GameLobbyController gameLobbyController=new GameLobbyController();
			//gameLobbyController.getUserId();
			status=gameLobbyController.assignSubUserNetworkAccess(ipAddress,this.status,userInfoBean.getDomainId(),userInfoBean.getUserId(),new Timestamp(date.getTime()),userName);
			return status;
			
		}catch(Exception e){e.printStackTrace();}
		return null;
	}
	public HttpServletRequest getServletRequest() {
		return servletRequest;
	}
	public void setServletRequest(HttpServletRequest servletRequest) {
		this.servletRequest = servletRequest;
	}
	public HttpServletResponse getServletResponse() {
		return servletResponse;
	}
	public void setServletResponse(HttpServletResponse servletResponse) {
		this.servletResponse = servletResponse;
	}
	public List<String> getAccessType() {
		return accessType;
	}
	public void setAccessType(List<String> accessType) {
		this.accessType = accessType;
	}
	public static String getUserName() {
		return userName;
	}
	public static void setUserName(String userName) {
		NetworkAccessAction.userName = userName;
	}

}
