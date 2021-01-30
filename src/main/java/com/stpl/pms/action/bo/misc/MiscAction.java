package com.stpl.pms.action.bo.misc;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;

public class MiscAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> partyList;
	private String partyName;
	private String status;
	private List<String> employeeNames;
	private String empName;
	private String juniorAccName;
	private String dispatcherName;
	private String seniorAccName;
	
	public String loadPage() {
		GameLobbyController controller = new GameLobbyController();
		setPartyList(controller.getLedgerNamesList());
		return SUCCESS;
	}
	
	public void validatePartyStatus() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		boolean _status = controller.getPartyBlockStatus(partyName); 
		if(_status) {
			servletResponse.getWriter().write("Blocked");
	
		}
		else {
			servletResponse.getWriter().write("UnBlocked");
	
		}
	}
	public void PartyStatusChange() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		boolean _status = controller.changePartyStatus(partyName,status);
		if(_status) {
			if(status.equals("Block"))
			servletResponse.getWriter().write("blocked");
			else if(status.equalsIgnoreCase("Unblock"))
				servletResponse.getWriter().write("unblocked");	
		}
		else {
			servletResponse.getWriter().write("failed");
		}
		
	}
	
	

	
	
	public void setUpdateApproval() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if(!juniorAccName.equals("-1") && !dispatcherName.equals("-1") && !seniorAccName.equals("-1")) {
			if(controller.setUpdateApprovalStages(empName,juniorAccName,dispatcherName,seniorAccName))
				servletResponse.getWriter().write("success");	
			else
				servletResponse.getWriter().write("error");	
		}
		else
			servletResponse.getWriter().write("validation");	
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
	public List<String> getPartyList() {
		return partyList;
	}
	public void setPartyList(List<String> partyList) {
		this.partyList = partyList;
	}

	public String getPartyName() {
		return partyName;
	}

	public void setPartyName(String partyName) {
		this.partyName = partyName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<String> getEmployeeNames() {
		return employeeNames;
	}

	public void setEmployeeNames(List<String> employeeNames) {
		this.employeeNames = employeeNames;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getJuniorAccName() {
		return juniorAccName;
	}

	public void setJuniorAccName(String juniorAccName) {
		this.juniorAccName = juniorAccName;
	}

	public String getDispatcherName() {
		return dispatcherName;
	}

	public void setDispatcherName(String dispatcherName) {
		this.dispatcherName = dispatcherName;
	}

	public String getSeniorAccName() {
		return seniorAccName;
	}

	public void setSeniorAccName(String seniorAccName) {
		this.seniorAccName = seniorAccName;
	}
	
}