package com.stpl.pms.action.bo.um;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;

public class AccountMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> groupNamesList;
	private String groupName;
	private String groupUnder;
	private String subLedger;
	private String blncForRep;
	private String forCalc;
	private String purInvoice;

	public String createGroup() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		groupNamesList = gameLobbyController.getGroupNamesList();
		return SUCCESS; 
	}

	public String insertGroup() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		gameLobbyController.insertGroup(groupName,groupUnder.toUpperCase(),subLedger.toUpperCase(),blncForRep.toUpperCase(),forCalc.toUpperCase(),purInvoice.toUpperCase().replaceAll(" ","_"));
		return SUCCESS;
	}

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return SUCCESS;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getGroupUnder() {
		return groupUnder;
	}

	public void setGroupUnder(String groupUnder) {
		this.groupUnder = groupUnder;
	}

	public String getSubLedger() {
		return subLedger;
	}

	public void setSubLedger(String subLedger) {
		this.subLedger = subLedger;
	}

	public String getBlncForRep() {
		return blncForRep;
	}

	public void setBlncForRep(String blncForRep) {
		this.blncForRep = blncForRep;
	}

	public String getForCalc() {
		return forCalc;
	}

	public void setForCalc(String forCalc) {
		this.forCalc = forCalc;
	}

	public String getPurInvoice() {
		return purInvoice;
	}

	public void setPurInvoice(String purInvoice) {
		this.purInvoice = purInvoice;
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

	public List<String> getGroupNamesList() {
		return groupNamesList;
	}

	public void setGroupNamesList(List<String> groupNamesList) {
		this.groupNamesList = groupNamesList;
	}
}