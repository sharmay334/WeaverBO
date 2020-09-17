package com.stpl.pms.action.bo.um;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.controller.um.UserMgmtController;
import com.stpl.pms.exception.PMSException;
import com.stpl.pms.hibernate.mapping.StRmBoUserInfo;
import com.stpl.pms.javabeans.UserDetailsBean;
import com.stpl.pms.javabeans.UserInfoBean;
import com.stpl.pms.struts.common.BaseActionSupport;

public class TMAttendanceAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private String userName;
	private List<String> companyNameList;
	private List<String> employeeNameList;
	private String companyName;
	private String employeeName;
	private List<StRmBoUserInfo> userList;
	protected UserInfoBean userInfoBean;
	private StRmBoUserInfo userDetailsBean;
	private int user_id;
	private List<String> underledgersList;

	public String getAttendancePage() {
		GameLobbyController controller = new GameLobbyController();
		userName = getUserInfoBean().getUserName();
		underledgersList = new ArrayList<String>();
		underledgersList = controller.getLedgerNames(getUserInfoBean().getUserId());
		return SUCCESS;
	}

	public String viewEmployee() {
		GameLobbyController controller = new GameLobbyController();
		companyNameList = controller.getCompanyNameList();
		employeeNameList = controller.getEmployeeNamesList();
		return SUCCESS;
	}

	public String searchBoUsers() {
		UserMgmtController service = new UserMgmtController();
		// PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
		// .getAttribute("ALLOWED_PRIV");
		try {
			userList = service.searchBoUsers(companyName, employeeName, "ACTIVE");
			return SUCCESS;
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception_nodecorate";
		}
	}
	
	public String showUserDetails() {
		
		UserMgmtController service = new UserMgmtController();
		// PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
		// .getAttribute("ALLOWED_PRIV");
		try {
			userDetailsBean = service.searchBoUser(user_id);
			return SUCCESS;
		} catch (Exception be) {
			return ERROR;
		}
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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public List<String> getCompanyNameList() {
		return companyNameList;
	}

	public void setCompanyNameList(List<String> companyNameList) {
		this.companyNameList = companyNameList;
	}

	public List<String> getEmployeeNameList() {
		return employeeNameList;
	}

	public void setEmployeeNameList(List<String> employeeNameList) {
		this.employeeNameList = employeeNameList;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public List<StRmBoUserInfo> getUserList() {
		return userList;
	}

	public void setUserList(List<StRmBoUserInfo> userList) {
		this.userList = userList;
	}
	
	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public StRmBoUserInfo getUserDetailsBean() {
		return userDetailsBean;
	}

	public void setUserDetailsBean(StRmBoUserInfo userDetailsBean) {
		this.userDetailsBean = userDetailsBean;
	}

	public List<String> getUnderledgersList() {
		return underledgersList;
	}

	public void setUnderledgersList(List<String> underledgersList) {
		this.underledgersList = underledgersList;
	}

}
