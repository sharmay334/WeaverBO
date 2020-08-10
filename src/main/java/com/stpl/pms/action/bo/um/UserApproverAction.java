package com.stpl.pms.action.bo.um;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;

public class UserApproverAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> functions;
	private List<String> users;
	private List<String> approver;
	private String functionName;
	private String userName;
	private String approverName;

	@Override
	public String execute() throws Exception {
		GameLobbyController controller = new GameLobbyController();
		functions = controller.getDynamicFieldList("functions");
		users = controller.getEmployeeNamesList();
		approver = controller.getEmployeeNamesList();
		return SUCCESS;
	}

	public String assignApprover() {
		GameLobbyController controller = new GameLobbyController();
		if (controller.assignApprover(functionName, userName, approverName))
			return SUCCESS;
		else
			return ERROR;
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

	public List<String> getFunctions() {
		return functions;
	}

	public void setFunctions(List<String> functions) {
		this.functions = functions;
	}

	public List<String> getUsers() {
		return users;
	}

	public void setUsers(List<String> users) {
		this.users = users;
	}

	public List<String> getApprover() {
		return approver;
	}

	public void setApprover(List<String> approver) {
		this.approver = approver;
	}

	public String getFunctionName() {
		return functionName;
	}

	public void setFunctionName(String functionName) {
		this.functionName = functionName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getApproverName() {
		return approverName;
	}

	public void setApproverName(String approverName) {
		this.approverName = approverName;
	}

}
