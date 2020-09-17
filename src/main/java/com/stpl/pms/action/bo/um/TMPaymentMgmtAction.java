package com.stpl.pms.action.bo.um;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.stpl.pms.commonJavabeans.ReceiptBean;
import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.hibernate.factory.HibernateSessionFactory;
import com.stpl.pms.javabeans.VoucherBean;
import com.stpl.pms.struts.common.BaseActionSupport;

public final class TMPaymentMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> accountList;
	private List<String> particularsList;
	private List<String> employeeUnderList;
	private int paymentNo;

	// create payment fields
	private String accountOldBal;
	private String particularsOldBal;
	private String account;
	private String employeeUnder;
	private String totalAmt;
	private String particulars;
	private String amount;
	private String bankName;
	private String txnType;
	private String currBalance;
	private String narration;
	private String billByBill;
	private String partyAcc;
	private String hiddenTypeOfRef;
	private String hiddenBillWiseName;
	private String typeOfRef;
	private String currentblnc;
	private String paymentDate;
	private String hiddenAmnt;
	private String hiddenBilId;
	private String suffix;
	private String hcrdr;
	private String activeVoucherNumber;
	private String paymentNoVoucher;
	private VoucherBean voucherBean;
	private String isSale;
	private String pmtId;
	private String status;
	private List<ReceiptBean> receiptBeans;
	private String document;
	
	
	public String loadEmpPaymentOrder() {
		GameLobbyController controller = new GameLobbyController();
		// accountList = new ArrayList<String>();
		// particularsList = new ArrayList<String>();
		// accountList = controller.getaccountListForTxnPayment("accList",
		// getUserInfoBean().getUserId());
		// particularsList = controller.getaccountListForTxnPayment("particulars",
		// getUserInfoBean().getUserId());
		// employeeUnderList = controller.getEmployeeNamesList();
		// receiptNo = controller.getReceiptNo();
		// bankNameList = new ArrayList<String>();
		// bankNameList = controller.getBankNameList();
		receiptBeans = new ArrayList<ReceiptBean>();
		ReceiptBean bean = null;
		String str = controller.fetchEmpPaymentData(0, pmtId);
		String[] resArr = str.split("\\|");
		String[] particularsArr = resArr[3].split(",");
		account = resArr[2];
		int id = 1;
		for (int i = 0; i < particularsArr.length; i++) {

			if (resArr[3].split(",")[i].trim().equals("none")) {

			} else {

				bean = new ReceiptBean();
				bean.setParticulars(resArr[3].split(",")[i].trim());
				bean.setAmount(resArr[4].split(",")[i].trim());
				bean.setBank_name(resArr[6].split(",")[i].trim());
				bean.setTxnType(resArr[5].split(",")[i].trim());
				bean.setRowId(id);
				receiptBeans.add(bean);
				id++;
			}

		}
		amount = resArr[4].split(",")[0];
		particulars = resArr[3].split(",")[0];
		narration = resArr[7].trim();
		totalAmt = resArr[8].trim();
		status = resArr[9].trim();
		paymentDate = resArr[10].toString();
		txnType = resArr[5].split(",")[0];
		bankName = resArr[6].split(",")[0];
		return SUCCESS;
	}

	public String loadPaymentPage() {
		GameLobbyController controller = new GameLobbyController();
		accountList = new ArrayList<String>();
		particularsList = new ArrayList<String>();
		accountList = controller.getaccountListForTxnPayment("accList", 1);
		particularsList = controller.getaccountListForTxnPayment("payment", 1);
		employeeUnderList = controller.getEmployeeNamesList();
		paymentNo = controller.getPaymentNo();
		String checkIsVoucherActive = controller.getActiveVoucher("payment");
		if (checkIsVoucherActive.equalsIgnoreCase("duplicate")) {
			return ERROR;
		} else {
			voucherBean = controller.getVoucherNumbering("payment", checkIsVoucherActive);
			if (checkIsVoucherActive.equalsIgnoreCase("not found"))
				activeVoucherNumber = "0";
			else
				activeVoucherNumber = checkIsVoucherActive;
			if (voucherBean == null)
				paymentNoVoucher = String.valueOf(controller.getPaymentNo());
			else {

				if (voucherBean.getVoucherNumbering().equals("Manual")) {
					paymentNoVoucher = String.valueOf(controller.getPaymentNo());
				} else {
					if (voucherBean.getAdvanceNumbering().equals("Yes")) {
						int getMaxNumber = controller.getPaymentVoucherNumber(activeVoucherNumber);
						if (getMaxNumber == 0) {
							paymentNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix()
									+ String.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d",
											Integer.valueOf(voucherBean.getStartingNumber()));
						} else {
							getMaxNumber++;
							paymentNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix() + String
									.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d", getMaxNumber);
							;

						}
					} else {
						paymentNoVoucher = String.valueOf(controller.getPaymentNo());
					}

				}

			}
			return SUCCESS;
		}

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

	public String loadPaymentPageAlert() {
		GameLobbyController controller = new GameLobbyController();
		accountList = new ArrayList<String>();
		particularsList = new ArrayList<String>();
		paymentNo = controller.getPaymentNo();
		particularsList = controller.getaccountListForTxnPayment("payment", getUserInfoBean().getUserId());
		employeeUnderList = controller.getEmployeeNamesList();
		accountList = controller.getaccountListForTxnPayment("accList", getUserInfoBean().getUserId());
		String str = controller.fetchEmpPaymentData(0, pmtId);
		String[] resArr = str.split("\\|");
		account = resArr[2];
		amount = resArr[4].split(",")[0];
		particulars = resArr[3].split(",")[0];
		narration = resArr[7].split(",")[0];
		document = resArr[11].split(",")[0];
		totalAmt = resArr[4].split(",")[0];
		txnType = resArr[5].split(",")[0];
		bankName = resArr[6].split(",")[0];
		paymentDate = resArr[10].split(",")[0];
		return SUCCESS;
	}

	public void createPayment() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		Session session = HibernateSessionFactory.getSession();
		Transaction transaction = session.beginTransaction();
		if (activeVoucherNumber.equals("0")) {

			if (controller.createTransactionPayment(account, employeeUnder, totalAmt, particulars, amount, bankName,
					txnType, narration, currentblnc, hiddenTypeOfRef, hiddenBillWiseName, hiddenAmnt, hiddenBilId,
					activeVoucherNumber, paymentDate, paymentNoVoucher, session, transaction, accountOldBal,
					particularsOldBal)) {
				if (controller.updateTransactionPartyBalancePayment(account, currBalance, hcrdr, session,
						transaction)) {
					transaction.commit();
					servletResponse.getWriter().write("success");
				}
			} else
				servletResponse.getWriter().write("error");
		} else {

			voucherBean = controller.getVoucherNumbering("payment", activeVoucherNumber);
			boolean voucherDate = compareTwoDate(voucherBean.getEndDate(), paymentDate + " 00:00");
			boolean voucherDate1 = compareTwoDate(paymentDate + " 00:00", voucherBean.getStartDate());
			if (voucherDate == true || voucherDate1 == true) {
				servletResponse.getWriter().write("date");
			} else {
				if (controller.createTransactionPayment(account, employeeUnder, totalAmt, particulars, amount, bankName,
						txnType, narration, currentblnc, hiddenTypeOfRef, hiddenBillWiseName, hiddenAmnt, hiddenBilId,
						activeVoucherNumber, paymentDate, paymentNoVoucher, session, transaction, accountOldBal,
						particularsOldBal)) {
					if (controller.updateTransactionPartyBalancePayment(account, currBalance, hcrdr, session,
							transaction)) {
						transaction.commit();
						servletResponse.getWriter().write("success");
					}
				} else
					servletResponse.getWriter().write("error");

			}
		}

		return;
	}

	public void checkForBillByBill() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.checkForBillByBill(billByBill))
			servletResponse.getWriter().write("true");
		else
			servletResponse.getWriter().write("false");
		return;
	}

	public void getNewBillNo() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String newBillNo = controller.getNewBillNo(partyAcc, typeOfRef, isSale);
		servletResponse.getWriter().write("" + newBillNo);

		return;
	}

	public void getOldBillNo() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String newBillNo = controller.getOldBillNo(partyAcc, typeOfRef, suffix);
		servletResponse.getWriter().write("" + newBillNo);

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

	public int getPaymentNo() {
		return paymentNo;
	}

	public void setPaymentNo(int paymentNo) {
		this.paymentNo = paymentNo;
	}

	public String getTotalAmt() {
		return totalAmt;
	}

	public void setTotalAmt(String totalAmt) {
		this.totalAmt = totalAmt;
	}

	public String getCurrBalance() {
		return currBalance;
	}

	public void setCurrBalance(String currBalance) {
		this.currBalance = currBalance;
	}

	public String getBillByBill() {
		return billByBill;
	}

	public void setBillByBill(String billByBill) {
		this.billByBill = billByBill;
	}

	public String getPartyAcc() {
		return partyAcc;
	}

	public void setPartyAcc(String partyAcc) {
		this.partyAcc = partyAcc;
	}

	public String getTypeOfRef() {
		return typeOfRef;
	}

	public void setTypeOfRef(String typeOfRef) {
		this.typeOfRef = typeOfRef;
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

	public String getCurrentblnc() {
		return currentblnc;
	}

	public void setCurrentblnc(String currentblnc) {
		this.currentblnc = currentblnc;
	}

	public String getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
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

	public String getSuffix() {
		return suffix;
	}

	public void setSuffix(String suffix) {
		this.suffix = suffix;
	}

	public String getHcrdr() {
		return hcrdr;
	}

	public void setHcrdr(String hcrdr) {
		this.hcrdr = hcrdr;
	}

	public String getPmtId() {
		return pmtId;
	}

	public void setPmtId(String pmtId) {
		this.pmtId = pmtId;
	}

	public String getActiveVoucherNumber() {
		return activeVoucherNumber;
	}

	public void setActiveVoucherNumber(String activeVoucherNumber) {
		this.activeVoucherNumber = activeVoucherNumber;
	}

	public String getPaymentNoVoucher() {
		return paymentNoVoucher;
	}

	public void setPaymentNoVoucher(String paymentNoVoucher) {
		this.paymentNoVoucher = paymentNoVoucher;
	}

	public VoucherBean getVoucherBean() {
		return voucherBean;
	}

	public void setVoucherBean(VoucherBean voucherBean) {
		this.voucherBean = voucherBean;
	}

	public String getIsSale() {
		return isSale;
	}

	public void setIsSale(String isSale) {
		this.isSale = isSale;
	}

	public String getAccountOldBal() {
		return accountOldBal;
	}

	public void setAccountOldBal(String accountOldBal) {
		this.accountOldBal = accountOldBal;
	}

	public String getParticularsOldBal() {
		return particularsOldBal;
	}

	public void setParticularsOldBal(String particularsOldBal) {
		this.particularsOldBal = particularsOldBal;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<ReceiptBean> getReceiptBeans() {
		return receiptBeans;
	}

	public void setReceiptBeans(List<ReceiptBean> receiptBeans) {
		this.receiptBeans = receiptBeans;
	}

	public String getDocument() {
		return document;
	}

	public void setDocument(String document) {
		this.document = document;
	}


}