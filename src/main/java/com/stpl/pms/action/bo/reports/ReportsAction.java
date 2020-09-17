package com.stpl.pms.action.bo.reports;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.commonJavabeans.BillsBean;
import com.stpl.pms.commonJavabeans.LedgerReportBean;
import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.controller.gm.GameMgmtController;
import com.stpl.pms.struts.common.BaseActionSupport;

@SuppressWarnings("serial")
public class ReportsAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> ledgerNames;
	private Map<String, LedgerReportBean> beanMap;
	private String ledgerName;
	private String fromDate;
	private String toDate;
	private String empName;
	private List<String> empList;
	private Map<String, BillsBean> billBeanMap;
	private String totCreditAmt;
	private String totDebitAmt;
	private String closingBal;
	private String openingBal;
	private String taxAmount;
	private List<String> itemNameList;
	private String itemName;
	private String regularPrice;
	private String superCashPrice;
	
	public String loadLedgerReport() {
		GameLobbyController controller = new GameLobbyController();
		ledgerNames = controller.getLedgerNamesList();
		return SUCCESS;
	}
	public void updatePriceListData() throws IOException {
		GameLobbyController controller = new GameLobbyController();
			if(controller.updatePriceListData(itemName,regularPrice,superCashPrice))
				
				servletResponse.getWriter().write("success");
			return;
		
	}
	public String loadcreditDaysReminderReport() {
		GameLobbyController controller = new GameLobbyController();
		ledgerNames = controller.getLedgerNamesList();
		empList = controller.getEmployeeNamesList();
		return SUCCESS;
	}
	
	public String loadItems() {
		GameLobbyController controller = new GameLobbyController();
		itemNameList = controller.getSalesStockItemList();
		return SUCCESS;
	}
	public String loadItemResult() {
		GameLobbyController controller = new GameLobbyController();
		regularPrice = controller.getItemRegularRate(itemName);
		superCashPrice = controller.getItemSuperCashRate(itemName);
		return SUCCESS;
	}
	public String loadLedgerReportResult() {
		GameLobbyController controller = new GameLobbyController();
		beanMap = controller.loadLedgerReportResult(ledgerName, fromDate, toDate);
		Double debAmt = 0.0;
		Double credAmt = 0.0;		
		for(Map.Entry<String, LedgerReportBean> m:beanMap.entrySet()) {
			
			String dAmt = m.getValue().getDebit().isEmpty()?"0.0":m.getValue().getDebit();
			String cAmt = m.getValue().getCredit().isEmpty()?"0.0":m.getValue().getCredit();
			debAmt+=Double.valueOf(dAmt);
			credAmt+=Double.valueOf(cAmt);
		}
		openingBal = controller.getOpeningBal(ledgerName,fromDate);
		taxAmount = controller.getPartyTaxAmount(ledgerName,fromDate,toDate);
		String taxAmt = String.format("%.2f",Double.valueOf(taxAmount));
		totCreditAmt = String.format("%.2f", credAmt);
		totDebitAmt = String.format("%.2f", debAmt);
		String temp[] = openingBal.split(" ");
		String openBal = String.format("%.2f", Double.valueOf(temp[0]));
		closingBal = String.valueOf((Double.valueOf(openBal)+Double.valueOf(totDebitAmt)+Double.valueOf(taxAmt)) - Double.valueOf(totCreditAmt));
		return SUCCESS;
	}

	public String loadcreditDaysReminderReportResult() {
		GameLobbyController controller = new GameLobbyController();
		billBeanMap = controller.loadcreditDaysReminderReportResult(ledgerName, empName, fromDate, toDate);
		return SUCCESS;
	}

	public void getMonthlyReports() throws IOException {
		GameMgmtController controller = new GameMgmtController();
		Map<Integer,Integer> saleData=  controller.getSaleReportByStoredProc();
		Map<Integer,Integer> purchaseData=  controller.getPurchaseReportByStoredProc();
		Map<Integer,Integer> creditNoteData=  controller.getCNReportByStoredProc();
		Map<Integer,Integer> DebitNoteData=  controller.getDNReportByStoredProc();
		
		String finalResult = "[";
		
		finalResult += "{name:'Sale',data:[";
		String saleString="";
		for(int i=1;i<13;i++) {
			saleString+=saleData.get(i)+",";
		}
		saleString = saleString.substring(0,saleString.length()-1);
		finalResult+=saleString+"]},";
		
		
		finalResult += "{name:'Purchase',data:[";
		String purchaseString="";
		for(int i=1;i<13;i++) {
			purchaseString+=purchaseData.get(i)+",";
		}
		purchaseString = purchaseString.substring(0,purchaseString.length()-1);
		finalResult+=purchaseString+"]},";
		
		
		finalResult += "{name:'Credit Note',data:[";
		String cnString="";
		for(int i=1;i<13;i++) {
			cnString+=creditNoteData.get(i)+",";
		}
		cnString = cnString.substring(0,cnString.length()-1);
		finalResult+=cnString+"]},";
		
		finalResult += "{name:'Debit Note',data:[";
		String dnString="";
		for(int i=1;i<13;i++) {
			dnString+=DebitNoteData.get(i)+",";
		}
		dnString = dnString.substring(0,dnString.length()-1);
		finalResult+=dnString+"]}]";
		
		servletResponse.getWriter().write(""+finalResult);
		return;
	}
	
	public void getMonthlyPendingBillsReports() throws IOException {
		GameMgmtController controller = new GameMgmtController();
		Map<Integer,Integer> billsData=  controller.getSalePendingBillsStoredProc();
		
			String finalResult = "[";
		
		finalResult += "{name:'Sale Pending Bills',data:[";
		String saleString="";
		for(int i=1;i<13;i++) {
			saleString+=billsData.get(i)+",";
		}
		saleString = saleString.substring(0,saleString.length()-1);
		finalResult+=saleString+"]}]";
		servletResponse.getWriter().write(""+finalResult);
		return;
	}
	
	public void getSaleReceiptPieChart() throws IOException{
		GameMgmtController controller = new GameMgmtController();
		String saleAmount = controller.getTotalSaleAmount();
		String receiptAmount = controller.getTotalReceiptAmount();
		String creditAmount = controller.getTotalCNAmount();
		String finalString="[{name:'Amount',colorByPoint: true,data:[{";
		finalString+="name:'Sale',y:"+saleAmount+", sliced: true,selected: true},{";
		finalString+="name:'Credit Note',y:"+creditAmount+"},{";
		finalString+="name:'Receipt',y:"+receiptAmount+"}]}]";
		servletResponse.getWriter().write(""+finalString);
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

	public List<String> getLedgerNames() {
		return ledgerNames;
	}

	public void setLedgerNames(List<String> ledgerNames) {
		this.ledgerNames = ledgerNames;
	}

	public Map<String, LedgerReportBean> getBeanMap() {
		return beanMap;
	}

	public void setBeanMap(Map<String, LedgerReportBean> beanMap) {
		this.beanMap = beanMap;
	}

	public String getLedgerName() {
		return ledgerName;
	}

	public void setLedgerName(String ledgerName) {
		this.ledgerName = ledgerName;
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

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public List<String> getEmpList() {
		return empList;
	}

	public void setEmpList(List<String> empList) {
		this.empList = empList;
	}

	public Map<String, BillsBean> getBillBeanMap() {
		return billBeanMap;
	}

	public void setBillBeanMap(Map<String, BillsBean> billBeanMap) {
		this.billBeanMap = billBeanMap;
	}

	public String getTotCreditAmt() {
		return totCreditAmt;
	}

	public void setTotCreditAmt(String totCreditAmt) {
		this.totCreditAmt = totCreditAmt;
	}

	public String getTotDebitAmt() {
		return totDebitAmt;
	}

	public void setTotDebitAmt(String totDebitAmt) {
		this.totDebitAmt = totDebitAmt;
	}

	public String getClosingBal() {
		return closingBal;
	}

	public void setClosingBal(String closingBal) {
		this.closingBal = closingBal;
	}

	public String getOpeningBal() {
		return openingBal;
	}

	public void setOpeningBal(String openingBal) {
		this.openingBal = openingBal;
	}

	public String getTaxAmount() {
		return taxAmount;
	}

	public void setTaxAmount(String taxAmount) {
		this.taxAmount = taxAmount;
	}

	public List<String> getItemNameList() {
		return itemNameList;
	}

	public void setItemNameList(List<String> itemNameList) {
		this.itemNameList = itemNameList;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getRegularPrice() {
		return regularPrice;
	}

	public void setRegularPrice(String regularPrice) {
		this.regularPrice = regularPrice;
	}

	public String getSuperCashPrice() {
		return superCashPrice;
	}

	public void setSuperCashPrice(String superCashPrice) {
		this.superCashPrice = superCashPrice;
	}

}
