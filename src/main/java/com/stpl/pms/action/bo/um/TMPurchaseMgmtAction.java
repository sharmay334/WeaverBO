package com.stpl.pms.action.bo.um;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.joda.time.LocalDateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;

public class TMPurchaseMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> particularsList;
	private List<String> employeeUnderList;
	private List<String> partyAccName;
	private List<String> salesAccountList;
	private List<String> goDownList;
	private int purchaseNo;
	private List<String> salesStockItemList;
	private List<String> batchLists;
	// create payment fields

	private String referenceNo;
	private String employeeUnder;
	private String partyAcc;
	private String salesAccount;
	private String salesStockItems;
	private String amount;
	private String Qty;
	private String rate;
	private String narration;
	private String currBalance;
	private String itemName;
	private String goDown;
	private String totalQty;
	private String unit;
	private String availableQtyInGodown;
	//batch number variable hower effect
	
	private String hiddenBatchNumber;
	private String hiddenMfgDate;
	private String hiddenExpDate;
	private String hiddenExpAlert;
	private String hiddenExpAlertDate;
	private String paymentDate;
	private String totalAmt;
	private String hcrdr;
	private String partyName;
	public void getCurrentBalance() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String balance = controller.getPartyBalanceByName(partyAcc);
		servletResponse.getWriter().write("" + balance);
		return;
	}
	public void getPartyPeriodLimit() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		int partyId = controller.findLedgerIdByName(partyName);
		int creditPeriod = controller.getCreditPeriod(partyId);
		if(creditPeriod!=-1) {
			DateTimeFormatter dtfOut = DateTimeFormat.forPattern("yyyy-MM-dd");
			LocalDateTime date = LocalDateTime.parse(paymentDate);
		//	DateTime dateTime = new DateTime();
			String dateBeforePeriod = dtfOut.print(date.minusDays(creditPeriod));
			List<String> billDetailsMap = controller.getBillDetails(partyId,"",dateBeforePeriod);
			String result="";
			if(billDetailsMap!=null && !billDetailsMap.isEmpty()) {
				for(String st:billDetailsMap)
					result=result+st+";";
				servletResponse.getWriter().write(""+result);
			}
			else {
				servletResponse.getWriter().write("skip");
			}
			
		}
		else {
			servletResponse.getWriter().write("skip");
		}
	}
	public void getCreditLimit() throws IOException{
		GameLobbyController controller = new GameLobbyController();
		String limit = controller.getPartyCreditLimitByName(partyAcc);
		if(!limit.equals("none"))
		servletResponse.getWriter().write("" + limit);
		else
			servletResponse.getWriter().write("Not Specified");	
		return;
	}
	public void getTotalQtyCall() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String totalQty = controller.TotalQtyFromGoDown(itemName);
		servletResponse.getWriter().write("" + totalQty);
		return;
	}
	public void getAvailableQtyCall() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String availableQtyInGodown = controller.TotalQtyFromGoDownByName(goDown,itemName);
		servletResponse.getWriter().write("" + availableQtyInGodown);
		return;
	}
	public void getAvailableBatches() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String availableBatchesInGodown = "Not Applicable,New Number";
		availableBatchesInGodown+=controller.TotalBatchesFromGoDownByName(goDown,itemName);
		servletResponse.getWriter().write("" + availableBatchesInGodown);
		return;
	}
	public void getAvailableBatcheDates() throws IOException{
		GameLobbyController controller = new GameLobbyController();
		String availableBatchesdtInGodown=controller.TotalBatchesDtFromGoDownByName(goDown,itemName,hiddenBatchNumber);
		servletResponse.getWriter().write("" + availableBatchesdtInGodown);
		return;
	}
	public void getTaxBalance() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		Map<String, Integer> taxes = controller.getTaxesByItemName(itemName);
		if (taxes == null)
			servletResponse.getWriter().write("none");
		else
			servletResponse.getWriter()
					.write("" + taxes.get("IGST") + ";" + taxes.get("CGST") + ";" + taxes.get("SGST"));
		return;
	}
	
	public String loadPurchasePage() {
		GameLobbyController controller = new GameLobbyController();
		particularsList = new ArrayList<String>();
		salesStockItemList = new ArrayList<>();
		particularsList = controller.getaccountListForTxnPayment("");
		partyAccName = new ArrayList<>();
		partyAccName = controller.getaccountListForTxnPayment("");
		employeeUnderList = controller.getEmployeeNamesList();
		salesAccountList = controller.getaccountListForTxnPayment("purchase acc");
		salesStockItemList = controller.getSalesStockItemList();
		purchaseNo = controller.getPurchaseNo();
		goDownList = new ArrayList<>();
		goDownList = controller.getAllGoDownList();
		
		
		return SUCCESS;
	}

	public void createPurchase() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.createTransactionPurchase(referenceNo, employeeUnder, partyAcc, salesAccount, salesStockItems,
				amount, Qty, rate, narration)) {
			if (controller.updateTransactionPartyBalance(partyAcc, currBalance,hcrdr)) {
				if (controller.updateOrCreateStock(salesStockItems, goDown, Qty, unit,hiddenBatchNumber,hiddenMfgDate,hiddenExpDate,hiddenExpAlert,hiddenExpAlertDate)) // st_rm_item_qty_godown update
					if(controller.insertNewBill(paymentDate,"Agst Ref",partyAcc,totalAmt))
						servletResponse.getWriter().write("success");
			}

		}
		else {
			servletResponse.getWriter().write("error");
		}
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

	public int getPurchaseNo() {
		return purchaseNo;
	}

	public void setPurchaseNo(int purchaseNo) {
		this.purchaseNo = purchaseNo;
	}

	public String getCurrBalance() {
		return currBalance;
	}

	public void setCurrBalance(String currBalance) {
		this.currBalance = currBalance;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public List<String> getGoDownList() {
		return goDownList;
	}

	public void setGoDownList(List<String> goDownList) {
		this.goDownList = goDownList;
	}

	public String getGoDown() {
		return goDown;
	}

	public void setGoDown(String goDown) {
		this.goDown = goDown;
	}

	public String getTotalQty() {
		return totalQty;
	}

	public void setTotalQty(String totalQty) {
		this.totalQty = totalQty;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getAvailableQtyInGodown() {
		return availableQtyInGodown;
	}

	public void setAvailableQtyInGodown(String availableQtyInGodown) {
		this.availableQtyInGodown = availableQtyInGodown;
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

	public List<String> getBatchLists() {
		return batchLists;
	}

	public void setBatchLists(List<String> batchLists) {
		this.batchLists = batchLists;
	}
	public String getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}
	public String getTotalAmt() {
		return totalAmt;
	}
	public void setTotalAmt(String totalAmt) {
		this.totalAmt = totalAmt;
	}
	public String getHcrdr() {
		return hcrdr;
	}
	public void setHcrdr(String hcrdr) {
		this.hcrdr = hcrdr;
	}
	public String getPartyName() {
		return partyName;
	}
	public void setPartyName(String partyName) {
		this.partyName = partyName;
	}

}
