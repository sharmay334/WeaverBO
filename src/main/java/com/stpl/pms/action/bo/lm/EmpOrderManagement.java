package com.stpl.pms.action.bo.lm;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;

public class EmpOrderManagement extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private String POId;

	public void fetchPOData() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String data = controller.fetchEmpPOData(userInfoBean.getUserId(),POId);
		servletResponse.getWriter().write("" + data);

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

	public String getPOId() {
		return POId;
	}

	public void setPOId(String pOId) {
		POId = pOId;
	}

}
