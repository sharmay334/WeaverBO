package com.stpl.pms.action.bo.um;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;

public class GoDownMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> goDownUnderList;
	private List<String> goDownList;
	private String godownName;
	private String godownUnder;
	private String allowStorage;
	private String ourStockwithTparty;
	private String thirdPartyStockWithus;

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		goDownUnderList = new ArrayList<String>();
		GameLobbyController controller = new GameLobbyController();
		goDownUnderList.addAll(controller.getAllGoDownList());
		return SUCCESS;
	}

	public String creategoDown() {
		GameLobbyController controller = new GameLobbyController();
		if (controller.createNewGodown(godownName, godownUnder, allowStorage, ourStockwithTparty,
				thirdPartyStockWithus))
			return SUCCESS;
		else
			return ERROR;
	}

	public String viewGodownList() {
		GameLobbyController controller = new GameLobbyController();
		goDownList = new ArrayList<String>();
		goDownList = controller.getAllGoDownList();
		return SUCCESS;
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

	public List<String> getGoDownUnderList() {
		return goDownUnderList;
	}

	public void setGoDownUnderList(List<String> goDownUnderList) {
		this.goDownUnderList = goDownUnderList;
	}

	public String getGodownName() {
		return godownName;
	}

	public void setGodownName(String godownName) {
		this.godownName = godownName;
	}

	public String getGodownUnder() {
		return godownUnder;
	}

	public void setGodownUnder(String godownUnder) {
		this.godownUnder = godownUnder;
	}

	public String getAllowStorage() {
		return allowStorage;
	}

	public void setAllowStorage(String allowStorage) {
		this.allowStorage = allowStorage;
	}

	public String getOurStockwithTparty() {
		return ourStockwithTparty;
	}

	public void setOurStockwithTparty(String ourStockwithTparty) {
		this.ourStockwithTparty = ourStockwithTparty;
	}

	public String getThirdPartyStockWithus() {
		return thirdPartyStockWithus;
	}

	public void setThirdPartyStockWithus(String thirdPartyStockWithus) {
		this.thirdPartyStockWithus = thirdPartyStockWithus;
	}

	public List<String> getGoDownList() {
		return goDownList;
	}

	public void setGoDownList(List<String> goDownList) {
		this.goDownList = goDownList;
	}

}
