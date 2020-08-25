package com.stpl.pms.action.bo.um;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.javabeans.VoucherBean;
import com.stpl.pms.struts.common.BaseActionSupport;
import com.stpl.pms.utility.SendSMS;

public class TMCreditNoteMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> particularsList;
	private List<String> employeeUnderList;
	private List<String> partyAccName;
	private List<String> salesAccountList;
	private int cnNo;
	private List<String> goDownList;
	private List<String> salesStockItemList;
	private String cnNoVoucher;
	// create payment fields

	private String referenceNo;
	private String employeeUnder;
	private String partyAcc;
	private String salesAccount;
	private String salesStockItems;
	private String amount;
	private String Qty;
	private String rate;
	private String currBalance;
	private String narration;
	private String goDown;
	private String unit;
	private String paymentDate;
	private String hiddenBatchNumber;
	private String hiddenMfgDate;
	private String hiddenExpDate;
	private String hiddenExpAlert;
	private String hiddenExpAlertDate;
	private String hcrdr;

	private String CNId;
	private String orderNo;
	private String partyAccNameSO;
	private String itemName;
	private String totalAmt;
	private VoucherBean voucherBean;
	private String activeVoucherNumber;
	private String hiddenAmnt;
	private String hiddenBilId;
	private String typeOfRef;
	private String hiddenTypeOfRef;
	private String hiddenBillWiseName;

	private String ddn;
	private String tn;
	private String des;
	private String billt;
	private String transportFreight;
	private String vn;

	public String loadCreditNotePage() {
		GameLobbyController controller = new GameLobbyController();
		particularsList = new ArrayList<String>();
		salesStockItemList = new ArrayList<>();
		particularsList = controller.getaccountListForTxnPayment("", 1);
		partyAccName = new ArrayList<>();
		partyAccName = controller.getaccountListForTxnPayment("", 1);
		employeeUnderList = controller.getEmployeeNamesList();
		salesAccountList = controller.getaccountListForTxnPayment("sales acc", 1);
		salesStockItemList = controller.getSalesStockItemList();
		cnNo = controller.getCreditNoteNo();
		goDownList = new ArrayList<>();
		goDownList = controller.getAllGoDownList();
		String checkIsVoucherActive = controller.getActiveVoucher("credit note");

		if (checkIsVoucherActive.equalsIgnoreCase("duplicate")) {
			return ERROR;
		}

		else {
			voucherBean = controller.getVoucherNumbering("credit note", checkIsVoucherActive);
			if (checkIsVoucherActive.equalsIgnoreCase("not found"))
				activeVoucherNumber = "0";
			else
				activeVoucherNumber = checkIsVoucherActive;
			if (voucherBean == null)
				cnNoVoucher = String.valueOf(controller.getCreditNoteNo());
			else {

				if (voucherBean.getVoucherNumbering().equals("Manual")) {
					cnNoVoucher = String.valueOf(controller.getCreditNoteNo());
				} else {
					if (voucherBean.getAdvanceNumbering().equals("Yes")) {
						int getMaxNumber = controller.getCNVoucherNumber(activeVoucherNumber);
						if (getMaxNumber == 0) {
							cnNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix()
									+ String.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d",
											Integer.valueOf(voucherBean.getStartingNumber()));
						} else {
							getMaxNumber++;
							cnNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix() + String
									.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d", getMaxNumber);
							;

						}
					} else {
						cnNoVoucher = String.valueOf(controller.getCreditNoteNo());
					}

				}

			}
			return SUCCESS;
		}

	}

	public String loadCreditNotePageAlert() {
		GameLobbyController controller = new GameLobbyController();
		String str = controller.fetchEmpCNData(0, CNId);
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
		salesAccountList = controller.getaccountListForTxnPayment("sales acc", getUserInfoBean().getUserId());
		salesStockItemList = controller.getSalesStockItemList();
		cnNo = controller.getCreditNoteNo();
		goDownList = new ArrayList<>();
		goDownList = controller.getAllGoDownList();
		voucherBean = controller.getVoucherNumbering("Credit Note");
		if (voucherBean == null)
			cnNoVoucher = String.valueOf(controller.getCreditNoteNo());
		else {
			if (voucherBean.getVoucherNumbering().equals("Manual")) {
				cnNoVoucher = String.valueOf(controller.getCreditNoteNo());
			} else {
				if (voucherBean.getAdvanceNumbering().equals("Yes")) {
					int getMaxNumber = controller.getCNVoucherNumber("");
					if (getMaxNumber == 0) {
						cnNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix()
								+ String.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d",
										Integer.valueOf(voucherBean.getStartingNumber()));
					} else {
						getMaxNumber++;
						cnNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix() + String
								.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d", getMaxNumber);

					}
				} else {
					cnNoVoucher = String.valueOf(controller.getCreditNoteNo());
				}

			}
		}
		return SUCCESS;
	}

	private boolean compareTwoDate(String endDate, String currentDate) {
		// TODO Auto-generated method stub
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy h:m");
			if (sdf.parse(currentDate).after(sdf.parse(endDate))) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public void createCreditNote() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (activeVoucherNumber.equals("0")) {
			if (controller.createTransactionCreditNote(referenceNo, employeeUnder, partyAcc, salesAccount,
					salesStockItems, amount, Qty, rate, narration, cnNoVoucher, paymentDate, ddn, tn, des, billt,
					transportFreight, vn, activeVoucherNumber, totalAmt, goDown, hiddenBatchNumber)) {
				if (hiddenAmnt == null && hiddenAmnt.isEmpty()) {
					if (controller.updateTransactionPartyBalanceSaleCreditNote(partyAcc, currBalance, hcrdr))
						if (controller.updateOrCreateStock(salesStockItems, goDown, Qty, unit, hiddenBatchNumber,
								hiddenMfgDate, hiddenExpDate, hiddenExpAlert, hiddenExpAlertDate)) {

							if (controller.allowAlert(partyAcc, "SMS"))
								sendSmsAlert();
							servletResponse.getWriter().write("success");
						}

				} else {
					if (controller.adjustSaleBill(hiddenAmnt, hiddenBilId, hiddenTypeOfRef, partyAcc, cnNoVoucher))
						if (controller.updateTransactionPartyBalanceSaleCreditNote(partyAcc, currBalance, hcrdr))
							if (controller.updateOrCreateStock(salesStockItems, goDown, Qty, unit, hiddenBatchNumber,
									hiddenMfgDate, hiddenExpDate, hiddenExpAlert, hiddenExpAlertDate)) {
								if (controller.allowAlert(partyAcc, "SMS"))
									sendSmsAlert();
								servletResponse.getWriter().write("success");
							}

				}

			}

			else
				servletResponse.getWriter().write("error");

		} else {

			voucherBean = controller.getVoucherNumbering("credit note", activeVoucherNumber);
			boolean voucherDate = compareTwoDate(voucherBean.getEndDate(), paymentDate + " 00:00");
			boolean voucherDate1 = compareTwoDate(paymentDate + " 00:00", voucherBean.getStartDate());
			if (voucherDate == true || voucherDate1 == true) {
				servletResponse.getWriter().write("date");
			} else {
				if (controller.createTransactionCreditNote(referenceNo, employeeUnder, partyAcc, salesAccount,
						salesStockItems, amount, Qty, rate, narration, cnNoVoucher, paymentDate, ddn, tn, des, billt,
						transportFreight, vn, activeVoucherNumber, totalAmt, goDown, hiddenBatchNumber)) {
					if (hiddenAmnt == null && hiddenAmnt.isEmpty()) {
						if (controller.updateTransactionPartyBalanceSaleCreditNote(partyAcc, currBalance, hcrdr))
							if (controller.updateOrCreateStock(salesStockItems, goDown, Qty, unit, hiddenBatchNumber,
									hiddenMfgDate, hiddenExpDate, hiddenExpAlert, hiddenExpAlertDate)) {

								if (controller.allowAlert(partyAcc, "SMS"))
									sendSmsAlert();
								servletResponse.getWriter().write("success");
							}

					} else {
						if (controller.adjustSaleBill(hiddenAmnt, hiddenBilId, hiddenTypeOfRef, partyAcc, cnNoVoucher))
							if (controller.updateTransactionPartyBalanceSaleCreditNote(partyAcc, currBalance, hcrdr))
								if (controller.updateOrCreateStock(salesStockItems, goDown, Qty, unit,
										hiddenBatchNumber, hiddenMfgDate, hiddenExpDate, hiddenExpAlert,
										hiddenExpAlertDate)) {
									if (controller.allowAlert(partyAcc, "SMS"))
										sendSmsAlert();
									servletResponse.getWriter().write("success");
								}

					}

				}

				else
					servletResponse.getWriter().write("error");

			}
		}

		return;
	}

	private void sendSmsAlert() {
		GameLobbyController controller = new GameLobbyController();
		String getPropName = controller.getPropName(partyAcc);
		String mobile = controller.getPropContact(partyAcc);
		String getUnderEmpName = controller.getUnderEmpName(partyAcc);
		String getEmpMobile = controller.getUnderEmpMobile(partyAcc);
		String sms = "Dear " + getPropName + ",Prop " + partyAcc + ". Your Sales Return Bill No-" + cnNoVoucher
				+ " of AMT " + totalAmt + " " + " Dated " + paymentDate
				+ " has been generated. Your closing balance is " + currBalance + " " + hcrdr
				+ ". Thank you for choosing us. Regards JAMIDARA SEEDS CORPORATION (Karnataka)";
		String smsEmp = "Dear " + getUnderEmpName + ", Your party " + getPropName + ",Prop " + partyAcc
				+ " Sales Return Bill No-" + cnNoVoucher + " of AMT " + totalAmt + " " + " Dated " + paymentDate
				+ " has been generated. His closing balance is " + currBalance + " " + hcrdr
				+ ". Thank you for choosing us. Regards JAMIDARA SEEDS CORPORATION (Karnataka)";
		if (mobile != null && !mobile.isEmpty()) {
			SendSMS sendSMS = new SendSMS();
			sendSMS.setMobileNo("91" + mobile);
			sendSMS.setMsg(sms);
			Thread thread = new Thread(sendSMS);
			thread.setDaemon(true);
			thread.start();
		}

		if (getEmpMobile != null && !getEmpMobile.isEmpty()) {
			SendSMS sendSMS1 = new SendSMS();
			sendSMS1.setMobileNo("91" + getEmpMobile);
			sendSMS1.setMsg(smsEmp);
			Thread thread1 = new Thread(sendSMS1);
			thread1.setDaemon(true);
			thread1.start();
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

	public int getCnNo() {
		return cnNo;
	}

	public void setCnNo(int cnNo) {
		this.cnNo = cnNo;
	}

	public String getCurrBalance() {
		return currBalance;
	}

	public void setCurrBalance(String currBalance) {
		this.currBalance = currBalance;
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

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
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

	public String getCNId() {
		return CNId;
	}

	public void setCNId(String cNId) {
		CNId = cNId;
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

	public String getCnNoVoucher() {
		return cnNoVoucher;
	}

	public void setCnNoVoucher(String cnNoVoucher) {
		this.cnNoVoucher = cnNoVoucher;
	}

	public VoucherBean getVoucherBean() {
		return voucherBean;
	}

	public void setVoucherBean(VoucherBean voucherBean) {
		this.voucherBean = voucherBean;
	}

	public String getHiddenAmnt() {
		return hiddenAmnt;
	}

	public void setHiddenAmnt(String hiddenAmnt) {
		this.hiddenAmnt = hiddenAmnt;
	}

	public String getHiddenBilId() {
		return hiddenBilId;
	}

	public void setHiddenBilId(String hiddenBilId) {
		this.hiddenBilId = hiddenBilId;
	}

	public String getHiddenTypeOfRef() {
		return hiddenTypeOfRef;
	}

	public void setHiddenTypeOfRef(String hiddenTypeOfRef) {
		this.hiddenTypeOfRef = hiddenTypeOfRef;
	}

	public String getHiddenBillWiseName() {
		return hiddenBillWiseName;
	}

	public void setHiddenBillWiseName(String hiddenBillWiseName) {
		this.hiddenBillWiseName = hiddenBillWiseName;
	}

	public String getTypeOfRef() {
		return typeOfRef;
	}

	public void setTypeOfRef(String typeOfRef) {
		this.typeOfRef = typeOfRef;
	}

	public String getActiveVoucherNumber() {
		return activeVoucherNumber;
	}

	public void setActiveVoucherNumber(String activeVoucherNumber) {
		this.activeVoucherNumber = activeVoucherNumber;
	}

	public String getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}

	public String getDdn() {
		return ddn;
	}

	public void setDdn(String ddn) {
		this.ddn = ddn;
	}

	public String getTn() {
		return tn;
	}

	public void setTn(String tn) {
		this.tn = tn;
	}

	public String getDes() {
		return des;
	}

	public void setDes(String des) {
		this.des = des;
	}

	public String getBillt() {
		return billt;
	}

	public void setBillt(String billt) {
		this.billt = billt;
	}

	public String getTransportFreight() {
		return transportFreight;
	}

	public void setTransportFreight(String transportFreight) {
		this.transportFreight = transportFreight;
	}

	public String getVn() {
		return vn;
	}

	public void setVn(String vn) {
		this.vn = vn;
	}

}
