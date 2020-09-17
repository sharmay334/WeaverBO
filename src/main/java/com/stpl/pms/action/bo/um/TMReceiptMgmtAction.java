package com.stpl.pms.action.bo.um;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
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
import com.stpl.pms.javabeans.ItemBean;
import com.stpl.pms.javabeans.VoucherBean;
import com.stpl.pms.struts.common.BaseActionSupport;
import com.stpl.pms.utility.SendSMS;

public class TMReceiptMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> accountList;
	private List<String> particularsList;
	private List<String> employeeUnderList;
	private int receiptNo;
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
	private String currentblnc;
	private String paymentDate;
	private String hiddenAmnt;
	private String hiddenBilId;
	private String typeOfRef;
	private String hiddenTypeOfRef;
	private String hiddenBillWiseName;
	private String hcrdr;
	private String rcptId;
	private String totalAmt;
	private VoucherBean voucherBean;
	private String receiptNoVoucher;
	private String activeVoucherNumber;
	private String txn_dd_chq_no;
	private String txn_bnkNm;
	private String ccrdrH;
	private String status;
	private File docPicture;
	private String docPictureContentType;
	private String docPictureFileName;
	private String accountOldBal;
	private String particularsOldBal;
	private List<ReceiptBean> receiptBeans;

	public String loadEmpReceiptOrder() {
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
		String str = controller.fetchEmpReceiptData(0, rcptId);
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

	public String loadReceiptPage() {
		GameLobbyController controller = new GameLobbyController();
		accountList = new ArrayList<String>();
		particularsList = new ArrayList<String>();
		accountList = controller.getaccountListForTxnPayment("accList", 1);
		particularsList = controller.getaccountListForTxnPayment("particulars", 1);
		employeeUnderList = controller.getEmployeeNamesList();
		receiptNo = controller.getReceiptNo();
		bankNameList = new ArrayList<String>();
		bankNameList = controller.getBankNameList();
		String checkIsVoucherActive = controller.getActiveVoucher("receipt");
		if (checkIsVoucherActive.equalsIgnoreCase("duplicate")) {
			return ERROR;
		}

		else {
			voucherBean = controller.getVoucherNumbering("Receipt", checkIsVoucherActive);
			if (checkIsVoucherActive.equalsIgnoreCase("not found"))
				activeVoucherNumber = "0";
			else
				activeVoucherNumber = checkIsVoucherActive;
			if (voucherBean == null)
				receiptNoVoucher = String.valueOf(controller.getReceiptNo());
			else {

				if (voucherBean.getVoucherNumbering().equals("Manual")) {
					receiptNoVoucher = String.valueOf(controller.getReceiptNo());
				} else {
					if (voucherBean.getAdvanceNumbering().equals("Yes")) {
						int getMaxNumber = controller.getReceiptVoucherNumber(activeVoucherNumber);
						if (getMaxNumber == 0) {
							receiptNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix()
									+ String.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d",
											Integer.valueOf(voucherBean.getStartingNumber()));
						} else {
							getMaxNumber++;
							receiptNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix() + String
									.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d", getMaxNumber);
							;

						}
					} else {
						receiptNoVoucher = String.valueOf(controller.getReceiptNo());
					}

				}

			}
			return SUCCESS;
		}
	}

	public String loadReceiptPageAlert() {
		GameLobbyController controller = new GameLobbyController();
		accountList = new ArrayList<String>();
		particularsList = new ArrayList<String>();
		accountList = controller.getaccountListForTxnPayment("accList", 1);
		particularsList = controller.getaccountListForTxnPayment("particulars", 1);
		employeeUnderList = controller.getEmployeeNamesList();
		receiptNo = controller.getReceiptNo();
		bankNameList = new ArrayList<String>();
		bankNameList = controller.getBankNameList();
		receiptBeans = new ArrayList<ReceiptBean>();
		ReceiptBean bean = null;
		String str = controller.fetchEmpReceiptData(0, rcptId);
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
		totalAmt = resArr[8].trim();
		status = resArr[9].trim();
		paymentDate = resArr[10].toString();
		txnType = resArr[5].split(",")[0];
		bankName = resArr[6].split(",")[0];
		docPictureFileName = resArr[11].toString();
		String checkIsVoucherActive = controller.getActiveVoucher("receipt");
		if (checkIsVoucherActive.equalsIgnoreCase("duplicate")) {
			return ERROR;
		}

		else {
			voucherBean = controller.getVoucherNumbering("Receipt", checkIsVoucherActive);
			if (checkIsVoucherActive.equalsIgnoreCase("not found"))
				activeVoucherNumber = "0";
			else
				activeVoucherNumber = checkIsVoucherActive;
			if (voucherBean == null)
				receiptNoVoucher = String.valueOf(controller.getReceiptNo());
			else {

				if (voucherBean.getVoucherNumbering().equals("Manual")) {
					receiptNoVoucher = String.valueOf(controller.getReceiptNo());
				} else {
					if (voucherBean.getAdvanceNumbering().equals("Yes")) {
						int getMaxNumber = controller.getReceiptVoucherNumber(activeVoucherNumber);
						if (getMaxNumber == 0) {
							receiptNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix()
									+ String.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d",
											Integer.valueOf(voucherBean.getStartingNumber()));
						} else {
							getMaxNumber++;
							receiptNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix() + String
									.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d", getMaxNumber);
							;

						}
					} else {
						receiptNoVoucher = String.valueOf(controller.getReceiptNo());
					}

				}

			}
		}
		return SUCCESS;

	}

	private void sendSmsAlert() {
		GameLobbyController controller = new GameLobbyController();
		String getPropName = controller.getPropName(particulars.split(",")[0].trim());
		String mobile = controller.getPropContact(particulars.split(",")[0].trim());
		String getUnderEmpName = controller.getUnderEmpName(particulars.split(",")[0].trim());
		String getEmpMobile = controller.getUnderEmpMobile(particulars.split(",")[0].trim());
		String sms = "Dear " + getPropName + ",Prop " + particulars.split(",")[0].trim() + ". Your Rcceipt No-"
				+ receiptNoVoucher + " of AMT " + totalAmt + " " + " Dated " + paymentDate
				+ " has been generated. Your closing balance is " + currentblnc.split(",")[0] + " "
				+ hcrdr.split(",")[0] + ". Thank you for choosing us. Regards JAMIDARA SEEDS CORPORATION (Karnataka)";
		String smsEmp = "Dear " + getUnderEmpName + ", Your party " + getPropName + ",Prop "
				+ particulars.split(",")[0].trim() + " Rcceipt No-" + receiptNoVoucher + " of AMT " + totalAmt + " "
				+ " Dated " + paymentDate + " has been generated. His closing balance is " + currentblnc.split(",")[0]
				+ " " + hcrdr.split(",")[0]
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

	public void createReceipt() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		Transaction transaction = null;
		Session session = null;
		session = HibernateSessionFactory.getSession();
		transaction = session.beginTransaction();
		if (activeVoucherNumber.equals("0")) {
			if (controller.createTransactionReceipt(account, employeeUnder, currBalance, particulars, amount, bankName,
					txnType, narration, currentblnc, hiddenTypeOfRef, hiddenBillWiseName, hiddenAmnt, hiddenBilId,
					receiptNoVoucher, txn_dd_chq_no, txn_bnkNm, activeVoucherNumber, paymentDate, ccrdrH, session,
					transaction, accountOldBal, particularsOldBal,totalAmt)) {
				if (controller.updateTransactionPartyBalancePayment(account, currBalance, hcrdr, session,
						transaction)) {
					transaction.commit();
					if (controller.allowAlert(particulars.split(",")[0].trim(), "SMS"))
						sendSmsAlert();
					servletResponse.getWriter().write("success");
				}

			} else
				servletResponse.getWriter().write("error");
		} else {
			voucherBean = controller.getVoucherNumbering("Receipt", activeVoucherNumber);
			boolean voucherDate = compareTwoDate(voucherBean.getEndDate(), paymentDate + " 00:00");
			boolean voucherDate1 = compareTwoDate(paymentDate + " 00:00", voucherBean.getStartDate());
			if (voucherDate == true || voucherDate1 == true) {
				servletResponse.getWriter().write("date");
			} else {
				if (controller.createTransactionReceipt(account, employeeUnder, currBalance, particulars, amount,
						bankName, txnType, narration, currentblnc, hiddenTypeOfRef, hiddenBillWiseName, hiddenAmnt,
						hiddenBilId, receiptNoVoucher, txn_dd_chq_no, txn_bnkNm, activeVoucherNumber, paymentDate,
						ccrdrH, session, transaction, accountOldBal, particularsOldBal,totalAmt)) {
					if (controller.updateTransactionPartyBalancePayment(account, currBalance, hcrdr, session,
							transaction)) {
						transaction.commit();
						if (controller.allowAlert(particulars.split(",")[0].trim(), "SMS"))
							sendSmsAlert();
						servletResponse.getWriter().write("success");
					}

				} else
					servletResponse.getWriter().write("error");
			}
		}

		return;
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

	public int getReceiptNo() {
		return receiptNo;
	}

	public void setReceiptNo(int receiptNo) {
		this.receiptNo = receiptNo;
	}

	public List<String> getBankNameList() {
		return bankNameList;
	}

	public void setBankNameList(List<String> bankNameList) {
		this.bankNameList = bankNameList;
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

	public String getHcrdr() {
		return hcrdr;
	}

	public void setHcrdr(String hcrdr) {
		this.hcrdr = hcrdr;
	}

	public String getRcptId() {
		return rcptId;
	}

	public void setRcptId(String rcptId) {
		this.rcptId = rcptId;
	}

	public String getTotalAmt() {
		return totalAmt;
	}

	public void setTotalAmt(String totalAmt) {
		this.totalAmt = totalAmt;
	}

	public VoucherBean getVoucherBean() {
		return voucherBean;
	}

	public void setVoucherBean(VoucherBean voucherBean) {
		this.voucherBean = voucherBean;
	}

	public String getReceiptNoVoucher() {
		return receiptNoVoucher;
	}

	public void setReceiptNoVoucher(String receiptNoVoucher) {
		this.receiptNoVoucher = receiptNoVoucher;
	}

	public String getActiveVoucherNumber() {
		return activeVoucherNumber;
	}

	public void setActiveVoucherNumber(String activeVoucherNumber) {
		this.activeVoucherNumber = activeVoucherNumber;
	}

	public String getTxn_dd_chq_no() {
		return txn_dd_chq_no;
	}

	public void setTxn_dd_chq_no(String txn_dd_chq_no) {
		this.txn_dd_chq_no = txn_dd_chq_no;
	}

	public String getTxn_bnkNm() {
		return txn_bnkNm;
	}

	public void setTxn_bnkNm(String txn_bnkNm) {
		this.txn_bnkNm = txn_bnkNm;
	}

	public String getCcrdrH() {
		return ccrdrH;
	}

	public void setCcrdrH(String ccrdrH) {
		this.ccrdrH = ccrdrH;
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

	public File getDocPicture() {
		return docPicture;
	}

	public void setDocPicture(File docPicture) {
		this.docPicture = docPicture;
	}

	public String getDocPictureContentType() {
		return docPictureContentType;
	}

	public void setDocPictureContentType(String docPictureContentType) {
		this.docPictureContentType = docPictureContentType;
	}

	public String getDocPictureFileName() {
		return docPictureFileName;
	}

	public void setDocPictureFileName(String docPictureFileName) {
		this.docPictureFileName = docPictureFileName;
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

}
