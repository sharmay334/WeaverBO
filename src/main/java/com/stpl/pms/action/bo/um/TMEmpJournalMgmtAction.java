package com.stpl.pms.action.bo.um;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;

public class TMEmpJournalMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> employeeUnderList;
	private int journalNo;
	private List<String> particularsList;
	// create payment fields

	private String employeeUnder;
	private String particulars;
	private String cr_dr;
	private String debitAmt;
	private String creditAmt;
	private String narration;

	public String loadJournalPage() {
		GameLobbyController controller = new GameLobbyController();
		employeeUnderList = controller.getEmployeeNamesList();
		particularsList = new ArrayList<String>();
		particularsList = controller.getaccountListForTxnPayment("particulars");
		journalNo = controller.getJournalNo();
		return SUCCESS;
	}

	public String createJournal() {
		GameLobbyController controller = new GameLobbyController();
	/*	if (controller.createTransactionJournal( employeeUnder, particulars, cr_dr, debitAmt,
				creditAmt, narration))*/
			return SUCCESS;
		/*
		 * else return ERROR;
		 */
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

	public List<String> getEmployeeUnderList() {
		return employeeUnderList;
	}

	public void setEmployeeUnderList(List<String> employeeUnderList) {
		this.employeeUnderList = employeeUnderList;
	}

	public String getEmployeeUnder() {
		return employeeUnder;
	}

	public void setEmployeeUnder(String employeeUnder) {
		this.employeeUnder = employeeUnder;
	}

	public String getParticulars() {
		return particulars;
	}

	public void setParticulars(String particulars) {
		this.particulars = particulars;
	}

	public String getNarration() {
		return narration;
	}

	public void setNarration(String narration) {
		this.narration = narration;
	}

	public int getJournalNo() {
		return journalNo;
	}

	public void setJournalNo(int journalNo) {
		this.journalNo = journalNo;
	}

	public String getCr_dr() {
		return cr_dr;
	}

	public void setCr_dr(String cr_dr) {
		this.cr_dr = cr_dr;
	}

	public String getDebitAmt() {
		return debitAmt;
	}

	public void setDebitAmt(String debitAmt) {
		this.debitAmt = debitAmt;
	}

	public String getCreditAmt() {
		return creditAmt;
	}

	public void setCreditAmt(String creditAmt) {
		this.creditAmt = creditAmt;
	}

	public List<String> getParticularsList() {
		return particularsList;
	}

	public void setParticularsList(List<String> particularsList) {
		this.particularsList = particularsList;
	}
}
