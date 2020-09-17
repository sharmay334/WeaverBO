package com.stpl.pms.action.bo.um;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.joda.time.LocalDateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.hibernate.factory.HibernateSessionFactory;
import com.stpl.pms.javabeans.ItemBean;
import com.stpl.pms.javabeans.VoucherBean;
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
	private String purchaseNoVoucher;
	private VoucherBean voucherBean;
	private String referenceNo;
	private String orderNo;
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
	private String partyOldBalance;
	// batch number variable hower effect
	
	private String hiddenBatchNumber;
	private String hiddenMfgDate;
	private String hiddenExpDate;
	private String hiddenExpAlert;
	private String hiddenExpAlertDate;
	private String paymentDate;
	private String totalAmt;
	private String hcrdr;
	private String partyName;
	private List<ItemBean> itemBeans;
	private String POId;
	private String partyAccNamePO;
	private String activeVoucherNumber;
	private String consignee;
	private String Dname;
	private String propName;
	private String contact;
	private String address;
	private String gstnNo;
	private String ddn;
	private String tn;
	private String des;
	private String billt;
	private String vn;
	private String transportFreight;
	private String suffix;
	private File docPicture;
	private String docPictureContentType;
	private String docPictureFileName;
	private String status;

	public void getCurrentBalance() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String balance = controller.getPartyBalanceByName(partyAcc);
		servletResponse.getWriter().write("" + balance);
		return;
	}

	public void getStandardRate() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String response = controller.getStandardRate(itemName);
		servletResponse.getWriter().write("" + response);
		return;

	}

	public void getInterestAmount() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String response = controller.getInterestAmount(partyAcc, suffix, referenceNo);
		servletResponse.getWriter().write("" + response);
		return;
	}

	public void getIsBatchApplicable() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String response = controller.getBatchApplicable(itemName);
		if (response.equals("Yes"))
			servletResponse.getWriter().write("Yes");
		else
			servletResponse.getWriter().write("No");
		return;
	}

	public void getPartyPeriodLimit() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		int partyId = controller.findLedgerIdByName(partyName);
		int creditPeriod = controller.getCreditPeriod(partyId);
		if (creditPeriod != -1) {

			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
			Calendar c = Calendar.getInstance();
			TimeZone tz = TimeZone.getTimeZone("Asia/Kolkata");
			c.setTimeZone(tz);

			try {
				if (paymentDate != null && !paymentDate.isEmpty())
					c.setTime(sdf.parse(paymentDate));
				else {
					Date today = new Date();
					DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
					df.setTimeZone(TimeZone.getTimeZone("Asia/Kolkata"));
					String date = df.format(today);
					c.setTime(sdf.parse(date));
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}

			// Number of Days to add
			c.add(Calendar.DAY_OF_MONTH, -creditPeriod);
			// Date after adding the days to the given date
			String dateBeforePeriod = sdf.format(c.getTime());

			List<String> billDetailsMap = controller.getBillDetails(partyId, "", dateBeforePeriod);
			String result = "";
			if (billDetailsMap != null && !billDetailsMap.isEmpty()) {
				for (String st : billDetailsMap)
					result = result + st + ";";
				servletResponse.getWriter().write("" + result);
			} else {
				servletResponse.getWriter().write("skip");
			}

		} else {
			servletResponse.getWriter().write("skip");
		}
	}

	public void getCreditLimit() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String limit = controller.getPartyCreditLimitByName(partyAcc);
		if (!limit.equals("none"))
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
		String availableQtyInGodown = controller.TotalQtyFromGoDownByName(goDown, itemName);
		servletResponse.getWriter().write("" + availableQtyInGodown);
		return;
	}

	public void getAvailableBatches() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String availableBatchesInGodown = "Not Applicable,New Number";
		availableBatchesInGodown += controller.TotalBatchesFromGoDownByName(goDown, itemName);
		servletResponse.getWriter().write("" + availableBatchesInGodown);
		return;
	}

	public void getAvailableBatcheDates() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String availableBatchesdtInGodown = controller.TotalBatchesDtFromGoDownByName(goDown, itemName,
				hiddenBatchNumber);
		servletResponse.getWriter().write("" + availableBatchesdtInGodown);
		return;
	}

	public void getTaxBalance() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		Map<String, Double> taxes = controller.getTaxesByItemName(itemName);
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
		particularsList = controller.getaccountListForTxnPayment("", 1);
		partyAccName = new ArrayList<>();
		partyAccName = controller.getaccountListForTxnPayment("", 1);
		employeeUnderList = controller.getEmployeeNamesList();
		salesAccountList = controller.getaccountListForTxnPayment("purchase acc", 1);
		salesStockItemList = controller.getSalesStockItemList();
		purchaseNo = controller.getPurchaseNo();
		goDownList = new ArrayList<>();
		goDownList = controller.getAllGoDownList();
		String checkIsVoucherActive = controller.getActiveVoucher("purchase");
		if (checkIsVoucherActive.equalsIgnoreCase("duplicate")) {
			return ERROR;
		}

		else {
			voucherBean = controller.getVoucherNumbering("purchase", checkIsVoucherActive);
			if (checkIsVoucherActive.equalsIgnoreCase("not found"))
				activeVoucherNumber = "0";
			else
				activeVoucherNumber = checkIsVoucherActive;
			if (voucherBean == null)
				purchaseNoVoucher = String.valueOf(controller.getPurchaseNo());
			else {

				if (voucherBean.getVoucherNumbering().equals("Manual")) {
					purchaseNoVoucher = String.valueOf(controller.getPurchaseNo());
				} else {
					if (voucherBean.getAdvanceNumbering().equals("Yes")) {
						int getMaxNumber = controller.getPurchaseVoucherNumber(activeVoucherNumber);
						if (getMaxNumber == 0) {
							purchaseNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix()
									+ String.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d",
											Integer.valueOf(voucherBean.getStartingNumber()));
						} else {
							getMaxNumber++;
							purchaseNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix() + String
									.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d", getMaxNumber);
							;

						}
					} else {
						purchaseNoVoucher = String.valueOf(controller.getPurchaseNo());
					}

				}

			}
			return SUCCESS;
		}

	}

	public String loadEmpPurchaseOrder() {
		GameLobbyController controller = new GameLobbyController();
		String str = controller.fetchEmpPOData(0, POId);
		String[] resArr = str.split("\\|");
		orderNo = resArr[0].trim();
		String[] itemArr = resArr[3].split(",");
		ItemBean bean = null;
		itemBeans = new ArrayList<ItemBean>();
		int id = 1;
		for (int i = 0; i < itemArr.length; i++) {

			if (resArr[3].split(",")[i].trim().equals("-1")) {

			} else {

				bean = new ItemBean();
				bean.setRowId(String.valueOf(id));
				bean.setItemName(resArr[3].split(",")[i].trim());
				bean.setItemQty(resArr[4].split(",")[i].trim());
				bean.setItemRate(resArr[5].split(",")[i].trim());
				bean.setItemAmount(resArr[6].split(",")[i].trim());
				itemBeans.add(bean);
				id++;
			}
		}
		partyAccNamePO = resArr[1].trim();
		totalAmt = resArr[8].trim();
		narration = resArr[7].trim();
		status = resArr[9].trim();
		Dname = resArr[10].trim();
		propName = resArr[11].trim();
		contact = resArr[12].trim();
		address = resArr[13].trim();
		gstnNo = resArr[14].trim();
		paymentDate = resArr[15].trim();
		docPictureFileName = resArr[16].trim();

		particularsList = new ArrayList<String>();
		salesStockItemList = new ArrayList<>();
		particularsList = controller.getaccountListForTxnPayment("", getUserInfoBean().getUserId());
		partyAccName = new ArrayList<>();
		partyAccName = controller.getaccountListForTxnPayment("", getUserInfoBean().getUserId());
		employeeUnderList = controller.getEmployeeNamesList();
		salesAccountList = controller.getaccountListForTxnPayment("purchase acc", getUserInfoBean().getUserId());
		salesStockItemList = controller.getSalesStockItemList();
		return SUCCESS;
	}

	public String loadPurchasePageAlert() {

		GameLobbyController controller = new GameLobbyController();
		String str = controller.fetchEmpPOData(0, POId);
		String[] resArr = str.split("\\|");
		orderNo = resArr[0].trim();
		String[] itemArr = resArr[3].split(",");
		ItemBean bean = null;
		itemBeans = new ArrayList<ItemBean>();
		int id = 1;
		for (int i = 0; i < itemArr.length; i++) {

			if (resArr[3].split(",")[i].trim().equals("-1")) {

			} else {

				bean = new ItemBean();
				bean.setRowId(String.valueOf(id));
				bean.setItemName(resArr[3].split(",")[i].trim());
				bean.setItemQty(resArr[4].split(",")[i].trim());
				bean.setItemRate(resArr[5].split(",")[i].trim());
				bean.setItemAmount(resArr[6].split(",")[i].trim());
				itemBeans.add(bean);
				id++;
			}
		}
		partyAccNamePO = resArr[1].trim();
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
		purchaseNo = controller.getPurchaseNo();
		goDownList = new ArrayList<>();
		goDownList = controller.getAllGoDownList();
		String checkIsVoucherActive = controller.getActiveVoucher("purchase");
		if (checkIsVoucherActive.equalsIgnoreCase("duplicate")) {
			return ERROR;
		}

		else {
			voucherBean = controller.getVoucherNumbering("purchase", checkIsVoucherActive);
			if (checkIsVoucherActive.equalsIgnoreCase("not found"))
				activeVoucherNumber = "0";
			else
				activeVoucherNumber = checkIsVoucherActive;
			if (voucherBean == null)
				purchaseNoVoucher = String.valueOf(controller.getPurchaseNo());
			else {

				if (voucherBean.getVoucherNumbering().equals("Manual")) {
					purchaseNoVoucher = String.valueOf(controller.getPurchaseNo());
				} else {
					if (voucherBean.getAdvanceNumbering().equals("Yes")) {
						int getMaxNumber = controller.getPurchaseVoucherNumber(activeVoucherNumber);
						if (getMaxNumber == 0) {
							purchaseNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix()
									+ String.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d",
											Integer.valueOf(voucherBean.getStartingNumber()));
						} else {
							getMaxNumber++;
							purchaseNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix() + String
									.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d", getMaxNumber);
							;

						}
					} else {
						purchaseNoVoucher = String.valueOf(controller.getPurchaseNo());
					}

				}

			}
			return SUCCESS;
		}
	}

	public void createPurchase() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		Transaction transaction = null;
		Session session = HibernateSessionFactory.getSession();
		transaction = session.beginTransaction();
		if (activeVoucherNumber.equals("0")) {
			if (controller.createTransactionPurchase(partyOldBalance, employeeUnder, partyAcc, salesAccount,
					salesStockItems, amount, Qty, rate, narration, purchaseNoVoucher, consignee, Dname, propName,
					contact, address, gstnNo, ddn, tn, des, billt, vn, transportFreight, paymentDate,
					activeVoucherNumber, totalAmt, goDown, hiddenBatchNumber, session, transaction)) {
				if (controller.updateTransactionPartyBalance(partyAcc, currBalance, hcrdr, session, transaction)) {
					if (controller.updateOrCreateStock(salesStockItems, goDown, Qty, unit, hiddenBatchNumber,
							hiddenMfgDate, hiddenExpDate, hiddenExpAlert, hiddenExpAlertDate, session, transaction)) // st_rm_item_qty_godown
						// update
						if (controller.insertNewBill(paymentDate, "Agst Ref", partyAcc, totalAmt, purchaseNoVoucher,
								session, transaction)) {
							transaction.commit();
							if (orderNo != null && !orderNo.isEmpty()) {
								if (controller.changeStatusSuccessPurchase(Integer.valueOf(orderNo),
										userInfoBean.getUserId()))
									servletResponse.getWriter().write("success");

							} else {
								servletResponse.getWriter().write("success");
							}

						}

				}

			} else {
				servletResponse.getWriter().write("error");
			}

		} else {
			voucherBean = controller.getVoucherNumbering("purchase", activeVoucherNumber);
			boolean voucherDate = compareTwoDate(voucherBean.getEndDate(), paymentDate + " 00:00");
			boolean voucherDate1 = compareTwoDate(paymentDate + " 00:00", voucherBean.getStartDate());
			if (voucherDate == true || voucherDate1 == true) {
				servletResponse.getWriter().write("date");
			} else {
				if (controller.createTransactionPurchase(partyOldBalance, employeeUnder, partyAcc, salesAccount,
						salesStockItems, amount, Qty, rate, narration, purchaseNoVoucher, consignee, Dname, propName,
						contact, address, gstnNo, ddn, tn, des, billt, vn, transportFreight, paymentDate,
						activeVoucherNumber, totalAmt, goDown, hiddenBatchNumber, session, transaction)) {
					if (controller.updateTransactionPartyBalance(partyAcc, currBalance, hcrdr, session, transaction)) {
						if (controller.updateOrCreateStock(salesStockItems, goDown, Qty, unit, hiddenBatchNumber,
								hiddenMfgDate, hiddenExpDate, hiddenExpAlert, hiddenExpAlertDate, session, transaction)) // st_rm_item_qty_godown
							// update
							if (controller.insertNewBill(paymentDate, "Agst Ref", partyAcc, totalAmt, purchaseNoVoucher,
									session, transaction)) {
								transaction.commit();
								if (orderNo != null && !orderNo.isEmpty()) {
									if (controller.changeStatusSuccessPurchase(Integer.valueOf(orderNo),
											userInfoBean.getUserId()))
										servletResponse.getWriter().write("success");

								} else {
									servletResponse.getWriter().write("success");
								}

							}

					}

				} else {
					servletResponse.getWriter().write("error");
				}

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

	public void checkPurchaseStatus() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String status = controller.checkPurchaseOrder(Integer.valueOf(orderNo));
		if (status == null) {
			servletResponse.getWriter().write("error");
		} else if (status.equalsIgnoreCase("pending")) {
			servletResponse.getWriter().write("pending");
		} else if (status.equalsIgnoreCase("accepted")) {
			servletResponse.getWriter().write("accept");
		} else if (status.equalsIgnoreCase("rejected")) {
			servletResponse.getWriter().write("reject");
		}

	}

	public void rejectPurchase() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.rejectPurchaseOrder(Integer.valueOf(orderNo), userInfoBean.getUserId())) {
			servletResponse.getWriter().write("success");
		} else {
			servletResponse.getWriter().write("error");
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

	public String getPOId() {
		return POId;
	}

	public void setPOId(String pOId) {
		POId = pOId;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getPartyAccNamePO() {
		return partyAccNamePO;
	}

	public void setPartyAccNamePO(String partyAccNamePO) {
		this.partyAccNamePO = partyAccNamePO;
	}

	public String getPurchaseNoVoucher() {
		return purchaseNoVoucher;
	}

	public void setPurchaseNoVoucher(String purchaseNoVoucher) {
		this.purchaseNoVoucher = purchaseNoVoucher;
	}

	public VoucherBean getVoucherBean() {
		return voucherBean;
	}

	public void setVoucherBean(VoucherBean voucherBean) {
		this.voucherBean = voucherBean;
	}

	public List<ItemBean> getItemBeans() {
		return itemBeans;
	}

	public void setItemBeans(List<ItemBean> itemBeans) {
		this.itemBeans = itemBeans;
	}

	public String getActiveVoucherNumber() {
		return activeVoucherNumber;
	}

	public void setActiveVoucherNumber(String activeVoucherNumber) {
		this.activeVoucherNumber = activeVoucherNumber;
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

	public String getVn() {
		return vn;
	}

	public void setVn(String vn) {
		this.vn = vn;
	}

	public String getTransportFreight() {
		return transportFreight;
	}

	public void setTransportFreight(String transportFreight) {
		this.transportFreight = transportFreight;
	}

	public String getSuffix() {
		return suffix;
	}

	public void setSuffix(String suffix) {
		this.suffix = suffix;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPartyOldBalance() {
		return partyOldBalance;
	}

	public void setPartyOldBalance(String partyOldBalance) {
		this.partyOldBalance = partyOldBalance;
	}

}
