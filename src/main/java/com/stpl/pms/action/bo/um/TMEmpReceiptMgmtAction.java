package com.stpl.pms.action.bo.um;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;

public class TMEmpReceiptMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
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
	private String totalAmt;
	private File docPicture;
	private String docPictureContentType;
	private String docPictureFileName;

	public void uploadDocument() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		boolean flag = false;
		String fName="";
		if(txnType!=null && txnType.equals("receipt"))
			fName="receipt";
		else
			fName="receiptOrder";
		Date today = new Date();
		DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
		df.setTimeZone(TimeZone.getTimeZone("Asia/Kolkata"));
		String date = df.format(today);
		String filePath = ServletActionContext.getServletContext().getRealPath("/");
		filePath = filePath.substring(0, filePath.lastIndexOf("default/"));
		File file = new File(filePath +fName+ "/" + getUserInfoBean().getUserId());
		if (file.mkdir()) {
			docPictureFileName = receiptNo + "_" + date + "_" + docPictureFileName;
			filePath = filePath.concat(fName+"/" + getUserInfoBean().getUserId());
			File fileToCreate = new File(filePath, docPictureFileName);
			FileUtils.copyFile(docPicture, fileToCreate);// copying source file to new file
			flag = true;
		} else {
			docPictureFileName = receiptNo + "_" + date + "_" + docPictureFileName;
			filePath = filePath.concat(fName+"/" + getUserInfoBean().getUserId());
			File fileToCreate = new File(filePath, docPictureFileName);
			FileUtils.copyFile(docPicture, fileToCreate);// copying source file to new file
			flag = true;

		}
		if (flag == true) {
			String fileFullPath = filePath + "/" + docPictureFileName;
			controller.setDocumentPathReceipt(receiptNo, fileFullPath, getUserInfoBean().getUserId(),txnType);

			servletResponse.getWriter().write("success");

		} else
			servletResponse.getWriter().write("failed");

		return;

	}

	public String loadReceiptPage() {
		GameLobbyController controller = new GameLobbyController();
		accountList = new ArrayList<String>();
		particularsList = new ArrayList<String>();
		accountList = controller.getaccountListForTxnPayment("accList", getUserInfoBean().getUserId());
		particularsList = controller.getaccountListForTxnPayment("particulars", getUserInfoBean().getUserId());
		employeeUnderList = controller.getEmployeeNamesList();
		receiptNo = controller.getReceiptNoEmp(userInfoBean.getUserId());
		bankNameList = new ArrayList<String>();
		bankNameList = controller.getBankNameList();
		return SUCCESS;
	}

	public void createReceipt() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		
		if (controller.createTransactionReceiptEmp(account, particulars, amount, bankName, txnType, narration,
				userInfoBean.getUserId(), userInfoBean.getParentUserId(), totalAmt))
			servletResponse.getWriter().write("success");
		else
			servletResponse.getWriter().write("error");
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

	public String getTotalAmt() {
		return totalAmt;
	}

	public void setTotalAmt(String totalAmt) {
		this.totalAmt = totalAmt;
	}

}
