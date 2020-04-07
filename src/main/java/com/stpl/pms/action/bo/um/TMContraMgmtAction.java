package com.stpl.pms.action.bo.um;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;

public class TMContraMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> accountList;
	private List<String> particularsList;
	private List<String> employeeUnderList;
	private int contraNo;
	private List<String> bankNameList;

	// create payment fields

	private String account;
	private String employeeUnder;
	private String currBalance;
	private String particulars;
	private String amount;
	private String bankName;
	private String txnType;
	private String narration;
	private String pcurBalance;
	private String paymentDate;
	private String hcrdr;
	private String phcrdr;

	public String loadContraPage() {
		GameLobbyController controller = new GameLobbyController();
		accountList = new ArrayList<String>();
		particularsList = new ArrayList<String>();
		accountList = controller.getaccountListForTxnPayment("accList");
		particularsList = controller.getaccountListForTxnPayment("accList");
		employeeUnderList = controller.getEmployeeNamesList();
		contraNo = controller.getContraNo();
		bankNameList = new ArrayList<String>();
		bankNameList = controller.getBankNameList();
		return SUCCESS;
	}

	public void createContra() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.createTransactionContra(account, employeeUnder, currBalance, particulars, amount, bankName,
				txnType, narration, pcurBalance,phcrdr)) {
			if (controller.updateTransactionPartyBalanceContra(account, currBalance, hcrdr))
				servletResponse.getWriter().write("success");
		}

		else
			servletResponse.getWriter().write("error");
		return;
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

	public List<String> getAccountList() {
		return accountList;
	}

	public void setAccountList(List<String> accountList) {
		this.accountList = accountList;
	}

	public List<String> getEmployeeUnderList() {
		return employeeUnderList;
	}

	public void setEmployeeUnderList(List<String> employeeUnderList) {
		this.employeeUnderList = employeeUnderList;
	}

	public List<String> getParticularsList() {
		return particularsList;
	}

	public void setParticularsList(List<String> particularsList) {
		this.particularsList = particularsList;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getEmployeeUnder() {
		return employeeUnder;
	}

	public void setEmployeeUnder(String employeeUnder) {
		this.employeeUnder = employeeUnder;
	}

	public String getCurrBalance() {
		return currBalance;
	}

	public void setCurrBalance(String currBalance) {
		this.currBalance = currBalance;
	}

	public String getParticulars() {
		return particulars;
	}

	public void setParticulars(String particulars) {
		this.particulars = particulars;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getTxnType() {
		return txnType;
	}

	public void setTxnType(String txnType) {
		this.txnType = txnType;
	}

	public String getNarration() {
		return narration;
	}

	public void setNarration(String narration) {
		this.narration = narration;
	}

	public int getContraNo() {
		return contraNo;
	}

	public void setContraNo(int contraNo) {
		this.contraNo = contraNo;
	}

	public List<String> getBankNameList() {
		return bankNameList;
	}

	public void setBankNameList(List<String> bankNameList) {
		this.bankNameList = bankNameList;
	}

	public String getPcurBalance() {
		return pcurBalance;
	}

	public void setPcurBalance(String pcurBalance) {
		this.pcurBalance = pcurBalance;
	}

	public String getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}

	public String getHcrdr() {
		return hcrdr;
	}

	public void setHcrdr(String hcrdr) {
		this.hcrdr = hcrdr;
	}

	public String getPhcrdr() {
		return phcrdr;
	}

	public void setPhcrdr(String phcrdr) {
		this.phcrdr = phcrdr;
	}
}
