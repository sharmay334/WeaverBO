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

public class TMDebitNoteMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> particularsList;
	private List<String> employeeUnderList;
	private List<String> partyAccName;
	private List<String> salesAccountList;
	private int dnNo;
	private List<String> salesStockItemList;
	private List<String> goDownList;

	// create payment fields

	private String referenceNo;
	private String employeeUnder;
	private String partyAcc;
	private String salesAccount;
	private String salesStockItems;
	private String amount;
	private String Qty;
	private String rate;
	private String unit;
	private String goDown;
	private String currBalance;
	private String narration;

	private String hiddenBatchNumber;
	private String hiddenMfgDate;
	private String hiddenExpDate;
	private String hiddenExpAlert;
	private String hiddenExpAlertDate;
	private String hcrdr;

	public String loadDebitNotePage() {
		GameLobbyController controller = new GameLobbyController();
		particularsList = new ArrayList<String>();
		salesStockItemList = new ArrayList<>();
		particularsList = controller.getaccountListForTxnPayment("");
		partyAccName = new ArrayList<>();
		partyAccName = controller.getaccountListForTxnPayment("");
		employeeUnderList = controller.getEmployeeNamesList();
		salesAccountList = controller.getaccountListForTxnPayment("purchase acc");
		salesStockItemList = controller.getSalesStockItemList();
		dnNo = controller.getDebitNoteNo();
		goDownList = new ArrayList<>();
		goDownList = controller.getAllGoDownList();
		return SUCCESS;
	}

	public void createDebitNote() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.createTransactionDebitNote(referenceNo, employeeUnder, partyAcc, salesAccount, salesStockItems,
				amount, Qty, rate, narration)) {
			if (controller.updateTransactionPartyBalance(partyAcc, currBalance, hcrdr))
				if (controller.updateOrCreateStockSale(salesStockItems, goDown, Qty, unit, hiddenBatchNumber,
						hiddenMfgDate, hiddenExpDate, hiddenExpAlert, hiddenExpAlertDate)) 
					servletResponse.getWriter().write("success");
		} else
			servletResponse.getWriter().write("success");
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

	public String getEmployeeUnder() {
		return employeeUnder;
	}

	public void setEmployeeUnder(String employeeUnder) {
		this.employeeUnder = employeeUnder;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getNarration() {
		return narration;
	}

	public void setNarration(String narration) {
		this.narration = narration;
	}

	public List<String> getPartyAccName() {
		return partyAccName;
	}

	public void setPartyAccName(List<String> partyAccName) {
		this.partyAccName = partyAccName;
	}

	public List<String> getSalesAccountList() {
		return salesAccountList;
	}

	public void setSalesAccountList(List<String> salesAccountList) {
		this.salesAccountList = salesAccountList;
	}

	public List<String> getSalesStockItemList() {
		return salesStockItemList;
	}

	public void setSalesStockItemList(List<String> salesStockItemList) {
		this.salesStockItemList = salesStockItemList;
	}

	public String getReferenceNo() {
		return referenceNo;
	}

	public void setReferenceNo(String referenceNo) {
		this.referenceNo = referenceNo;
	}

	public String getPartyAcc() {
		return partyAcc;
	}

	public void setPartyAcc(String partyAcc) {
		this.partyAcc = partyAcc;
	}

	public String getSalesAccount() {
		return salesAccount;
	}

	public void setSalesAccount(String salesAccount) {
		this.salesAccount = salesAccount;
	}

	public String getSalesStockItems() {
		return salesStockItems;
	}

	public void setSalesStockItems(String salesStockItems) {
		this.salesStockItems = salesStockItems;
	}

	public String getQty() {
		return Qty;
	}

	public void setQty(String qty) {
		Qty = qty;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public int getDnNo() {
		return dnNo;
	}

	public void setDnNo(int dnNo) {
		this.dnNo = dnNo;
	}

	public String getCurrBalance() {
		return currBalance;
	}

	public void setCurrBalance(String currBalance) {
		this.currBalance = currBalance;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getGoDown() {
		return goDown;
	}

	public void setGoDown(String goDown) {
		this.goDown = goDown;
	}

	public List<String> getGoDownList() {
		return goDownList;
	}

	public void setGoDownList(List<String> goDownList) {
		this.goDownList = goDownList;
	}

	public String getHiddenBatchNumber() {
		return hiddenBatchNumber;
	}

	public void setHiddenBatchNumber(String hiddenBatchNumber) {
		this.hiddenBatchNumber = hiddenBatchNumber;
	}

	public String getHiddenMfgDate() {
		return hiddenMfgDate;
	}

	public void setHiddenMfgDate(String hiddenMfgDate) {
		this.hiddenMfgDate = hiddenMfgDate;
	}

	public String getHiddenExpDate() {
		return hiddenExpDate;
	}

	public void setHiddenExpDate(String hiddenExpDate) {
		this.hiddenExpDate = hiddenExpDate;
	}

	public String getHiddenExpAlert() {
		return hiddenExpAlert;
	}

	public void setHiddenExpAlert(String hiddenExpAlert) {
		this.hiddenExpAlert = hiddenExpAlert;
	}

	public String getHiddenExpAlertDate() {
		return hiddenExpAlertDate;
	}

	public void setHiddenExpAlertDate(String hiddenExpAlertDate) {
		this.hiddenExpAlertDate = hiddenExpAlertDate;
	}

	public String getHcrdr() {
		return hcrdr;
	}

	public void setHcrdr(String hcrdr) {
		this.hcrdr = hcrdr;
	}

}
