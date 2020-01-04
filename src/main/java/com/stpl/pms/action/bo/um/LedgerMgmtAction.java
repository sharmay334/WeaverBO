package com.stpl.pms.action.bo.um;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.javabeans.LedgerBean;
import com.stpl.pms.struts.common.BaseActionSupport;

public class LedgerMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> groupNamesList;
	private List<String> ledgerNamesList;

	private String ledgerName;
	private String groupUnder;
	private String name;
	private String address;
	private String country;
	private String state;
	private String pincode;
	
	private List<LedgerBean> accountLedgerMaster;

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		GameLobbyController gameLobbyController = new GameLobbyController();
		groupNamesList = gameLobbyController.getGroupNamesList();
		groupNamesList.remove(0);
		return SUCCESS;
	}
	public String deleteLedgerDB() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		if (gameLobbyController.deleteLedgerByName(ledgerName))
			return SUCCESS;
		else
			return ERROR;
		
	}
	public String viewLedgerResult() {
		
		GameLobbyController gameLobbyController = new GameLobbyController();
		accountLedgerMaster = gameLobbyController.getAccountLedgerMaster(ledgerName);
		return SUCCESS;
	}
	public String viewLedger() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		ledgerNamesList = new ArrayList<String>();
		ledgerNamesList = gameLobbyController.getLedgerNamesList();
		
		return SUCCESS;
	}

	public String insertLedger() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		if (gameLobbyController.createLedger(ledgerName,groupUnder,name,address,country,state,pincode))
			return SUCCESS;
		else
			return ERROR;
	}

	public String deleteLedger() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		ledgerNamesList = new ArrayList<String>();
		ledgerNamesList = gameLobbyController.getLedgerNamesList();
		return SUCCESS;
	}

	public List<String> getLedgerNamesList() {
		return ledgerNamesList;
	}

	public void setLedgerNamesList(List<String> ledgerNamesList) {
		this.ledgerNamesList = ledgerNamesList;
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

	public String getLedgerName() {
		return ledgerName;
	}

	public void setLedgerName(String ledgerName) {
		this.ledgerName = ledgerName;
	}

	public String getGroupUnder() {
		return groupUnder;
	}

	public void setGroupUnder(String groupUnder) {
		this.groupUnder = groupUnder;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	public List<LedgerBean> getAccountLedgerMaster() {
		return accountLedgerMaster;
	}

	public void setAccountLedgerMaster(List<LedgerBean> accountLedgerMaster) {
		this.accountLedgerMaster = accountLedgerMaster;
	}

}
