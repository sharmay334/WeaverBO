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

public class TMEmpCreditNoteMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> particularsList;
	private List<String> employeeUnderList;
	private List<String> partyAccName;
	private List<String> salesAccountList;
	private int cnNo;
	private List<String> goDownList;
	private List<String> salesStockItemList;
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
	private String totalAmt;

	private String hiddenBatchNumber;
	private String hiddenMfgDate;
	private String hiddenExpDate;
	private String hiddenExpAlert;
	private String hiddenExpAlertDate;

	private File docPictureDD;
	private String docPictureDDContentType;
	private String docPictureDDFileName;

	private File docPictureTB;
	private String docPictureTBContentType;
	private String docPictureTBFileName;

	private String consignee;
	private String Dname;
	private String propName;
	private String contact;
	private String address;
	private String gstnNo;
	private String tn;
	private String txnType;

	public void uploadDocument() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		boolean flag = false;
		Date today = new Date();
		String fName="";
		if(txnType!=null && txnType.equalsIgnoreCase("creditNote"))
			fName="creditNote";
		else
			fName="creditNoteOrder";
		DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
		df.setTimeZone(TimeZone.getTimeZone("Asia/Kolkata"));
		String date = df.format(today);
		String filePath = ServletActionContext.getServletContext().getRealPath("/");
		filePath = filePath.substring(0, filePath.lastIndexOf("default/"));
		File file = new File(filePath+ fName+ "/" + getUserInfoBean().getUserId());
		if (file.mkdir()) {
			filePath = filePath.concat(fName+"/" + getUserInfoBean().getUserId());

			if (docPictureDDFileName != null && !docPictureDDFileName.isEmpty()) {
				docPictureDDFileName = cnNo + "_" + date + "_dd_" + docPictureDDFileName;
				File fileToCreateDD = new File(filePath, docPictureDDFileName);
				FileUtils.copyFile(docPictureDD, fileToCreateDD);// copying source file to new file
				flag = true;

			}
			if (docPictureTBFileName != null && !docPictureTBFileName.isEmpty()) {
				docPictureTBFileName = cnNo + "_" + date + "_billT_" + docPictureTBFileName;

				File fileToCreateTB = new File(filePath, docPictureTBFileName);
				FileUtils.copyFile(docPictureTB, fileToCreateTB);// copying source file to new file
				flag = true;
			}
		} else {
			filePath = filePath.concat(fName+"/" + getUserInfoBean().getUserId());

			if (docPictureDDFileName != null && !docPictureDDFileName.isEmpty()) {
				docPictureDDFileName = cnNo + "_" + date + "_dd_" + docPictureDDFileName;
				File fileToCreateDD = new File(filePath, docPictureDDFileName);
				FileUtils.copyFile(docPictureDD, fileToCreateDD);// copying source file to new file
				flag = true;

			}
			if (docPictureTBFileName != null && !docPictureTBFileName.isEmpty()) {
				docPictureTBFileName = cnNo + "_" + date + "_billT_" + docPictureTBFileName;

				File fileToCreateTB = new File(filePath, docPictureTBFileName);
				FileUtils.copyFile(docPictureTB, fileToCreateTB);// copying source file to new file
				flag = true;
			}

		}
		if (flag == true) {
			String fileFullPathDD = filePath + "/" + docPictureDDFileName;
			String fileFullPathTB = filePath + "/" + docPictureTBFileName;

			controller.setDocumentPathCreditNote(cnNo, fileFullPathDD, fileFullPathTB, getUserInfoBean().getUserId(),txnType);

			servletResponse.getWriter().write("success");

		} else
			servletResponse.getWriter().write("failed");

		return;

	}

	public String loadCreditNotePage() {
		GameLobbyController controller = new GameLobbyController();
		particularsList = new ArrayList<String>();
		salesStockItemList = new ArrayList<>();
		particularsList = controller.getaccountListForTxnPayment("", getUserInfoBean().getUserId());
		partyAccName = new ArrayList<>();
		partyAccName = controller.getaccountListForTxnPayment("", getUserInfoBean().getUserId());
		employeeUnderList = controller.getEmployeeNamesList();
		salesAccountList = controller.getaccountListForTxnPayment("sales acc", getUserInfoBean().getUserId());
		salesStockItemList = controller.getSalesStockItemList();
		cnNo = controller.getCreditNoteNoEmp(userInfoBean.getUserId());
		goDownList = new ArrayList<>();
		goDownList = controller.getAllGoDownList();
		return SUCCESS;
	}

	public void createCreditNote() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.createEmpTransactionCreditNote(referenceNo, employeeUnder, partyAcc, salesAccount,
				salesStockItems, amount, Qty, rate, narration, userInfoBean.getUserId(), userInfoBean.getParentUserId(),
				totalAmt, consignee, Dname, propName, contact, address, gstnNo, tn)) {
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

	public String getTotalAmt() {
		return totalAmt;
	}

	public void setTotalAmt(String totalAmt) {
		this.totalAmt = totalAmt;
	}

	public File getDocPictureDD() {
		return docPictureDD;
	}

	public void setDocPictureDD(File docPictureDD) {
		this.docPictureDD = docPictureDD;
	}

	public String getDocPictureDDContentType() {
		return docPictureDDContentType;
	}

	public void setDocPictureDDContentType(String docPictureDDContentType) {
		this.docPictureDDContentType = docPictureDDContentType;
	}

	public String getDocPictureDDFileName() {
		return docPictureDDFileName;
	}

	public void setDocPictureDDFileName(String docPictureDDFileName) {
		this.docPictureDDFileName = docPictureDDFileName;
	}

	public File getDocPictureTB() {
		return docPictureTB;
	}

	public void setDocPictureTB(File docPictureTB) {
		this.docPictureTB = docPictureTB;
	}

	public String getDocPictureTBContentType() {
		return docPictureTBContentType;
	}

	public void setDocPictureTBContentType(String docPictureTBContentType) {
		this.docPictureTBContentType = docPictureTBContentType;
	}

	public String getDocPictureTBFileName() {
		return docPictureTBFileName;
	}

	public void setDocPictureTBFileName(String docPictureTBFileName) {
		this.docPictureTBFileName = docPictureTBFileName;
	}

	public String getConsignee() {
		return consignee;
	}

	public void setConsignee(String consignee) {
		this.consignee = consignee;
	}

	public String getDname() {
		return Dname;
	}

	public void setDname(String dname) {
		Dname = dname;
	}

	public String getPropName() {
		return propName;
	}

	public void setPropName(String propName) {
		this.propName = propName;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getGstnNo() {
		return gstnNo;
	}

	public void setGstnNo(String gstnNo) {
		this.gstnNo = gstnNo;
	}

	public String getTn() {
		return tn;
	}

	public void setTn(String tn) {
		this.tn = tn;
	}

	public String getTxnType() {
		return txnType;
	}

	public void setTxnType(String txnType) {
		this.txnType = txnType;
	}

}
