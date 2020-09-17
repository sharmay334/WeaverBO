package com.stpl.pms.action.bo.um;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.javabeans.VoucherBean;
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
	private String dnNoVoucher;
	private VoucherBean voucherBean;
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

	private String DNId;
	private String orderNo;
	private String partyAccNameSO;
	private String itemName;
	private String totalAmt;

	public String loadDebitNotePageAlert() {
		GameLobbyController controller = new GameLobbyController();
		String str = controller.fetchEmpDNData(0, DNId);
		String[] resArr = str.split("\\|");
		orderNo = resArr[0].trim();
		partyAccNameSO = resArr[1].trim();
		itemName = resArr[3].split(",")[0].trim();
		Qty = resArr[4].split(",")[0].trim();
		rate = resArr[5].split(",")[0].trim();
		totalAmt = resArr[8].trim();
		narration = resArr[7].trim();
		particularsList = new ArrayList<String>();
		salesStockItemList = new ArrayList<>();
		particularsList = controller.getaccountListForTxnPayment("", getUserInfoBean().getUserId());
		partyAccName = new ArrayList<>();
		partyAccName = controller.getaccountListForTxnPayment("", getUserInfoBean().getUserId());
		employeeUnderList = controller.getEmployeeNamesList();
		salesAccountList = controller.getaccountListForTxnPayment("purchase acc", getUserInfoBean().getUserId());
		salesStockItemList = controller.getSalesStockItemList();
		dnNo = controller.getDebitNoteNo();
		goDownList = new ArrayList<>();
		goDownList = controller.getAllGoDownList();
		voucherBean = controller.getVoucherNumbering("Debit Note");
		if (voucherBean == null)
			dnNoVoucher = String.valueOf(controller.getDebitNoteNo());
		else {
			if (voucherBean.getVoucherNumbering().equals("Manual")) {
				dnNoVoucher = String.valueOf(controller.getDebitNoteNo());
			} else {
				if (voucherBean.getAdvanceNumbering().equals("Yes")) {
					int getMaxNumber = controller.getDNVoucherNumber();
					if (getMaxNumber == 0) {
						dnNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix()
								+ voucherBean.getStartingNumber();
					} else {
						getMaxNumber++;
						dnNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix() + getMaxNumber;

					}
				} else {
					dnNoVoucher = String.valueOf(controller.getDebitNoteNo());
				}

			}
		}
		return SUCCESS;
	}

	public String loadDebitNotePage() {
		GameLobbyController controller = new GameLobbyController();
		particularsList = new ArrayList<String>();
		salesStockItemList = new ArrayList<>();
		particularsList = controller.getaccountListForTxnPayment("", 1);
		partyAccName = new ArrayList<>();
		partyAccName = controller.getaccountListForTxnPayment("", 1);
		employeeUnderList = controller.getEmployeeNamesList();
		salesAccountList = controller.getaccountListForTxnPayment("purchase acc", 1);
		salesStockItemList = controller.getSalesStockItemList();
		dnNo = controller.getDebitNoteNo();
		goDownList = new ArrayList<>();
		goDownList = controller.getAllGoDownList();
		voucherBean = controller.getVoucherNumbering("Debit Note");
		if (voucherBean == null)
			dnNoVoucher = String.valueOf(controller.getDebitNoteNo());
		else {
			if (voucherBean.getVoucherNumbering().equals("Manual")) {
				dnNoVoucher = String.valueOf(controller.getDebitNoteNo());
			} else {
				if (voucherBean.getAdvanceNumbering().equals("Yes")) {
					int getMaxNumber = controller.getDNVoucherNumber();
					if (getMaxNumber == 0) {
						dnNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix()
								+ voucherBean.getStartingNumber();
					} else {
						getMaxNumber++;
						dnNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix() + getMaxNumber;

					}
				} else {
					dnNoVoucher = String.valueOf(controller.getDebitNoteNo());
				}

			}
		}
		return SUCCESS;
	}

	@SuppressWarnings("null")
	public void createDebitNote() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		Transaction transaction = null;
		Session session = null;
		if (controller.createTransactionDebitNote(referenceNo, employeeUnder, partyAcc, salesAccount, salesStockItems,
				amount, Qty, rate, narration, dnNoVoucher)) {
			if (controller.updateTransactionPartyBalance(partyAcc, currBalance, hcrdr,null,null))
				if (controller.updateOrCreateStockSale(salesStockItems, goDown, Qty, unit, hiddenBatchNumber,
						hiddenMfgDate, hiddenExpDate, hiddenExpAlert, hiddenExpAlertDate,"",null,null)) {
					transaction.commit();
					servletResponse.getWriter().write("success");
				}
					
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

	public String getDNId() {
		return DNId;
	}

	public void setDNId(String dNId) {
		DNId = dNId;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getPartyAccNameSO() {
		return partyAccNameSO;
	}

	public void setPartyAccNameSO(String partyAccNameSO) {
		this.partyAccNameSO = partyAccNameSO;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getTotalAmt() {
		return totalAmt;
	}

	public void setTotalAmt(String totalAmt) {
		this.totalAmt = totalAmt;
	}

	public String getDnNoVoucher() {
		return dnNoVoucher;
	}

	public void setDnNoVoucher(String dnNoVoucher) {
		this.dnNoVoucher = dnNoVoucher;
	}

	public VoucherBean getVoucherBean() {
		return voucherBean;
	}

	public void setVoucherBean(VoucherBean voucherBean) {
		this.voucherBean = voucherBean;
	}

}
