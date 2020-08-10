package com.stpl.pms.action.bo.lm;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;

public class AlertManagementAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private String deleteId;
	
	public void getAlert() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String alert = controller.getAlerts(userInfoBean.getUserId());
		servletResponse.getWriter().write(""+alert);
		
	}
	public void getAlertPO() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String alert = controller.getAlertsPO(userInfoBean.getUserId());
		servletResponse.getWriter().write(""+alert);
		
	}
	public void getAlertSO() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String alert = controller.getAlertsSO(userInfoBean.getUserId());
		servletResponse.getWriter().write(""+alert);
		
	}
	public void getAlertCN() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String alert = controller.getAlertsCN(userInfoBean.getUserId());
		servletResponse.getWriter().write(""+alert);
		
	}
	public void getAlertDN() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String alert = controller.getAlertsDN(userInfoBean.getUserId());
		servletResponse.getWriter().write(""+alert);
		
	}
	public void getAlertPMT() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String alert = controller.getAlertsPMT(userInfoBean.getUserId());
		servletResponse.getWriter().write(""+alert);
		
	}
	public void getAlertRCPT() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String alert = controller.getAlertsRCPT(userInfoBean.getUserId());
		servletResponse.getWriter().write(""+alert);
		
	}
	public void deleteAlert() throws IOException  {
		GameLobbyController controller = new GameLobbyController();
		String alert = controller.deleteAlert(deleteId);
		servletResponse.getWriter().write(""+alert);
		
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
	public String getDeleteId() {
		return deleteId;
	}
	public void setDeleteId(String deleteId) {
		this.deleteId = deleteId;
	}

}
