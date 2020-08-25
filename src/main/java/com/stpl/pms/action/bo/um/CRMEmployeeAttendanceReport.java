package com.stpl.pms.action.bo.um;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.drools.core.command.runtime.GetIdCommand;

import com.stpl.pms.commonJavabeans.AttendanceBean;
import com.stpl.pms.commonJavabeans.ExpenseBean;
import com.stpl.pms.commonJavabeans.VisitBean;
import com.stpl.pms.controller.commonMethods.CommonMethodController;
import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;

public class CRMEmployeeAttendanceReport extends BaseActionSupport
		implements ServletRequestAware, ServletResponseAware {

	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> companyList;
	private List<String> employeeList;
	private Map<String,AttendanceBean> attendanceMapResult;
	private String companyName;
	private String employeeName;
	private String fromDate;
	private String toDate;
	private String empId;
	private String attendanceDate;
	private Map<String,VisitBean> visitMapResult;
	private Map<String,ExpenseBean> expenseMapResult;
	
	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		GameLobbyController controller = new GameLobbyController();
		companyList = controller.getCompanyNameList();
		employeeList = controller.getEmployeeNamesList();
		return SUCCESS;
	}
	
	public String getAttendanceReportVisit() {
		GameLobbyController controller = new GameLobbyController();
		visitMapResult = controller.getVisitReport(attendanceDate,empId);
		return SUCCESS;
	}
	public String getAttendanceReport() {
		GameLobbyController controller = new GameLobbyController();
		int empId = controller.getUserIdByName(employeeName);
		int companyId = controller.getCompanyIdByName(companyName);
		attendanceMapResult = controller.getAttendanceReport(empId,companyId,fromDate,toDate,employeeName,companyName);
		return SUCCESS;
	}
	public String getExpenseReport() {
		GameLobbyController controller = new GameLobbyController();
		Integer empId = controller.getUserIdByName(employeeName);
		expenseMapResult = controller.getExpenseReport(empId,fromDate,toDate);
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
	public List<String> getCompanyList() {
		return companyList;
	}
	public void setCompanyList(List<String> companyList) {
		this.companyList = companyList;
	}
	public List<String> getEmployeeList() {
		return employeeList;
	}
	public void setEmployeeList(List<String> employeeList) {
		this.employeeList = employeeList;
	}
	public Map<String,AttendanceBean> getAttendanceMapResult() {
		return attendanceMapResult;
	}
	public void setAttendanceMapResult(Map<String,AttendanceBean> attendanceMapResult) {
		this.attendanceMapResult = attendanceMapResult;
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

	public String getFromDate() {
		return fromDate;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

	public String getToDate() {
		return toDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getAttendanceDate() {
		return attendanceDate;
	}

	public void setAttendanceDate(String attendanceDate) {
		this.attendanceDate = attendanceDate;
	}

	public Map<String,VisitBean> getVisitMapResult() {
		return visitMapResult;
	}

	public void setVisitMapResult(Map<String,VisitBean> visitMapResult) {
		this.visitMapResult = visitMapResult;
	}

	public Map<String,ExpenseBean> getExpenseMapResult() {
		return expenseMapResult;
	}

	public void setExpenseMapResult(Map<String,ExpenseBean> expenseMapResult) {
		this.expenseMapResult = expenseMapResult;
	}

}
