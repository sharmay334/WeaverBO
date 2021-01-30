package com.stpl.pms.action.bo.um;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.commonJavabeans.BillsBean;
import com.stpl.pms.commonJavabeans.ReceiptSaleBillMapping;
import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;
import com.stpl.pms.struts.common.QuartzScheduling;

public class TMSchedularReportMgmtAction extends BaseActionSupport
		implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> ledgerNames;
	private String ledgerName;
	private Map<String, BillsBean> reportData;
	private String alertType;
	private String partyId;
	private String voucherNo;
	private String status;
	private String billId;
	private String remindBefDay;
	private String remindAftDay;
	private String remindInterval;
	private String deductPercent;
	private List<String> employeeNames;
	private String employeeName;
	private String fromDate;
	private String toDate;
	private String txnType;
	private Map<String, ReceiptSaleBillMapping> mappingMap;
	private String totalTransactionAmount;
	
	public void runOldOverDueBills() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if(controller.runOldOverDueBills(ledgerName,voucherNo))
		servletResponse.getWriter().write("success");
		else
		servletResponse.getWriter().write("failed");	
		return;
	}
	public void getOldSetReminder() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String data = controller.getOldSetReminder(partyId,voucherNo);
		servletResponse.getWriter().write(""+data);
		return;
	}
	public void runOverDueBill() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		controller.runScheduleOverDueBillsSales();
		servletResponse.getWriter().write("success");
		return;
	}
	public void runBalanceSchedular()throws IOException{
		
		QuartzScheduling quartzScheduling = new QuartzScheduling();
		quartzScheduling.calculateTax();
	}

	public void changeStatusAlert() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.changeAlertStatus(alertType, partyId, voucherNo, status, billId))
			servletResponse.getWriter().write("success");
		else
			servletResponse.getWriter().write("error");
		return;
	}

	public void deleteWholeBill() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.deleteBill(txnType, voucherNo,ledgerName))
			servletResponse.getWriter().write("yes");
		else
			servletResponse.getWriter().write("no");

		return;
	}

	public void deleteSingleBill() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.deleteSingleBill(txnType, voucherNo))
			servletResponse.getWriter().write("yes");
		else
			servletResponse.getWriter().write("no");

		return;
	}

	public void ChangeInterestSchedular() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.changeStatus(ledgerName, status))
			servletResponse.getWriter().write("yes");
		else
			servletResponse.getWriter().write("no");

		return;
	}
	public void ChangeSMSSchedular() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.changeStatusSMS(ledgerName, status))
			servletResponse.getWriter().write("yes");
		else
			servletResponse.getWriter().write("no");

		return;
	}
	
	

	public String getPartyTxnReport() {
		GameLobbyController controller = new GameLobbyController();
		reportData = controller.getPartyTransactionReport(txnType, toDate, fromDate, employeeName, ledgerName, billId);
		Double amt = 0.0;
		for(Map.Entry<String, BillsBean> map:reportData.entrySet()) {
			amt = amt+Double.valueOf(map.getValue().getActualBillAmount().trim());
			
		}
		totalTransactionAmount = String.format("%.2f",amt);
		
		return SUCCESS;
	}

	public String getPartyTxnReportDetail() {
		GameLobbyController controller = new GameLobbyController();
		mappingMap = controller.getTransactionDetail(txnType, voucherNo);
		return SUCCESS;
	}

	public void checkForInterestSchedular() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.getActiveInterest(ledgerName))
			servletResponse.getWriter().write("yes");
		else
			servletResponse.getWriter().write("no");

		return;
	}
	public void checkForSMSSchedular() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.getActiveInterestSMS(ledgerName))
			servletResponse.getWriter().write("yes");
		else
			servletResponse.getWriter().write("no");

		return;
	}
	

	public void deductInterest() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.deductInterestRate(partyId, voucherNo, billId, deductPercent))
			servletResponse.getWriter().write("success");
		else
			servletResponse.getWriter().write("error");
		return;
	}

	public void changeAlertDueBills() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.changeAlertStatus(partyId, voucherNo, status, billId, remindBefDay, remindAftDay,
				remindInterval))
			servletResponse.getWriter().write("success");
		else
			servletResponse.getWriter().write("error");
		return;
	}

	public String loadPage() {
		GameLobbyController controller = new GameLobbyController();
		ledgerNames = controller.getLedgerNamesList();
		employeeNames = controller.getEmployeeNamesList();
		return SUCCESS;
	}

	public String showReport() {
		GameLobbyController controller = new GameLobbyController();
		reportData = controller.getSchedularReport(ledgerName);
		return SUCCESS;
	}

	public String showReportOverDueBill() {
		GameLobbyController controller = new GameLobbyController();
		reportData = controller.getSchedularReportOverDueBills(ledgerName);
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

	public List<String> getLedgerNames() {
		return ledgerNames;
	}

	public void setLedgerNames(List<String> ledgerNames) {
		this.ledgerNames = ledgerNames;
	}

	public String getLedgerName() {
		return ledgerName;
	}

	public void setLedgerName(String ledgerName) {
		this.ledgerName = ledgerName;
	}

	public Map<String, BillsBean> getReportData() {
		return reportData;
	}

	public void setReportData(Map<String, BillsBean> reportData) {
		this.reportData = reportData;
	}

	public String getAlertType() {
		return alertType;
	}

	public void setAlertType(String alertType) {
		this.alertType = alertType;
	}

	public String getPartyId() {
		return partyId;
	}

	public void setPartyId(String partyId) {
		this.partyId = partyId;
	}

	public String getVoucherNo() {
		return voucherNo;
	}

	public void setVoucherNo(String voucherNo) {
		this.voucherNo = voucherNo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getBillId() {
		return billId;
	}

	public void setBillId(String billId) {
		this.billId = billId;
	}

	public String getRemindBefDay() {
		return remindBefDay;
	}

	public void setRemindBefDay(String remindBefDay) {
		this.remindBefDay = remindBefDay;
	}

	public String getRemindAftDay() {
		return remindAftDay;
	}

	public void setRemindAftDay(String remindAftDay) {
		this.remindAftDay = remindAftDay;
	}

	public String getRemindInterval() {
		return remindInterval;
	}

	public void setRemindInterval(String remindInterval) {
		this.remindInterval = remindInterval;
	}

	public String getDeductPercent() {
		return deductPercent;
	}

	public void setDeductPercent(String deductPercent) {
		this.deductPercent = deductPercent;
	}

	public List<String> getEmployeeNames() {
		return employeeNames;
	}

	public void setEmployeeNames(List<String> employeeNames) {
		this.employeeNames = employeeNames;
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

	public String getTxnType() {
		return txnType;
	}

	public void setTxnType(String txnType) {
		this.txnType = txnType;
	}

	public Map<String, ReceiptSaleBillMapping> getMappingMap() {
		return mappingMap;
	}

	public void setMappingMap(Map<String, ReceiptSaleBillMapping> mappingMap) {
		this.mappingMap = mappingMap;
	}
	public String getTotalTransactionAmount() {
		return totalTransactionAmount;
	}
	public void setTotalTransactionAmount(String totalTransactionAmount) {
		this.totalTransactionAmount = totalTransactionAmount;
	}

}
