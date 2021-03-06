package com.stpl.pms.action.bo.um;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.commonJavabeans.LedgerSecondStepBean;
import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.javabeans.LedgerBankAccount;
import com.stpl.pms.javabeans.LedgerBean;
import com.stpl.pms.javabeans.LedgerCustomBean;
import com.stpl.pms.struts.common.BaseActionSupport;

public class LedgerMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> groupNamesList;
	private List<String> ledgerNamesList;
	private String ledger_id;
	private String ledgerName;
	private String groupUnder;
	private String name;
	private String address;
	private String country;
	private String state;
	private String pincode;
	private LedgerBankAccount ledgerBankAccount;
	private List<LedgerBean> accountLedgerMaster;
	private List<String> employeeUnderList;
	private LedgerCustomBean ledgerCustomBean;
	// sundry credtors fields

	private String blcBillByBill;
	private String defCreditPeriod;
	private String creditDayDuringVoucher;
	private String specifyCreditLimit;
	// + interest calculation fields for sundary cred..

	private String txnByTxnInterest;
	private String intesestBasedOn;
	private String foramtAdded;
	private String foramtDeduct;
	private String rate;
	private String ratePer;
	private String rateOn;
	private String intersetCalculationApplicability;
	private String intersetCalculationApplicabilityDays;
	private String intersetCalculationFrom;
	private String intersetCalculationApplicabilityGracePeriod;
	private String employeeUnder;
	private String intersetCalculationSecurityAmt;
	private String security;
	// ledger opening blnc

	private String openingDate;
	private String openingBalance;
	private String Cr_Dr;
	private LedgerSecondStepBean ledgerSecondStepBean;
	private String resultType;
	private String employeeNames;
	private String updateOpeningBalance;
	private List<String> locationNames;

	public String assignLedger() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		ledgerNamesList = new ArrayList<String>();
		ledgerNamesList = gameLobbyController.getLedgerNamesList();
		employeeUnderList = gameLobbyController.getEmployeeNamesList();
		return SUCCESS;

	}
	public String assignRetailer() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		ledgerNamesList = new ArrayList<String>();
		ledgerNamesList = gameLobbyController.getRetailerNamesList();
		employeeUnderList = gameLobbyController.getEmployeeNamesList();
		return SUCCESS;

	}

	public String assignLedgerSave() {
		GameLobbyController controller = new GameLobbyController();
		if (controller.editAssignLedgerToUser(ledgerName, employeeNames))
			return SUCCESS;
		else
			return ERROR;
	}
	public String assignRetailerSave() {
		GameLobbyController controller = new GameLobbyController();
		if (controller.editAssignRetailerToUser(ledgerName, employeeNames))
			return SUCCESS;
		else
			return ERROR;
	}

	@Override
	public String execute() throws Exception {
		GameLobbyController gameLobbyController = new GameLobbyController();
		groupNamesList = gameLobbyController.getGroupNamesList();
		groupNamesList.remove(0);
		employeeUnderList = gameLobbyController.getEmployeeNamesList();
		locationNames = gameLobbyController.getAllLocations();
		return SUCCESS;
	}

	public String deleteLedgerDB() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		if (gameLobbyController.deleteLedgerByName(ledgerName))
			return SUCCESS;
		else
			return ERROR;

	}

	public String editLedgerSave() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		if (gameLobbyController.saveUpdateLedgerData(ledgerCustomBean))
			return SUCCESS;
		else
			return ERROR;
	}

	public String viewLedgerResult() {

		GameLobbyController gameLobbyController = new GameLobbyController();
		accountLedgerMaster = gameLobbyController.getAccountLedgerMaster(ledgerName);
		return SUCCESS;
	}

	public String editLedger() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		ledgerCustomBean = gameLobbyController.getLedgerDetails(ledger_id);
		employeeUnderList = gameLobbyController.getEmployeeNamesList();
		locationNames = gameLobbyController.getAllLocations();
		return SUCCESS;
	}

	public String viewLedger() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		ledgerNamesList = new ArrayList<String>();
		ledgerNamesList = gameLobbyController.getLedgerNamesList();

		return SUCCESS;
	}

	public String insertLedger() {
		GameLobbyController gameLobbyController = new GameLobbyController();

		if (gameLobbyController.createLedger(ledgerName, groupUnder, name, address, country, state, pincode,
				ledgerBankAccount, blcBillByBill, defCreditPeriod, creditDayDuringVoucher, specifyCreditLimit,
				employeeUnder, txnByTxnInterest, intesestBasedOn, foramtAdded, foramtDeduct, rate, ratePer, rateOn,
				intersetCalculationApplicability, intersetCalculationApplicabilityDays, intersetCalculationFrom,
				intersetCalculationApplicabilityGracePeriod, intersetCalculationSecurityAmt, security)) {
			int id = gameLobbyController.InitialBalace(openingDate, openingBalance, Cr_Dr, ledgerName, groupUnder);
			if (id > 0) {
				ledger_id = String.valueOf(id);
				return SUCCESS;
			}

			else
				return ERROR;

		} else
			return ERROR;
	}

	public String completeSecondStep() {
		GameLobbyController controller = new GameLobbyController();
		if (controller.ledgerSecondStepInsert(ledgerSecondStepBean)) {
			resultType = "Your Ledger Created Successfully!!!";
			return SUCCESS;
		} else {
			resultType = "ERROR! Your Ledger Second Form details is Not Inserted!!!";
			return ERROR;

		}

	}

	public String deleteLedger() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		ledgerNamesList = new ArrayList<String>();
		ledgerNamesList = gameLobbyController.getLedgerNamesList();
		return SUCCESS;
	}

	public List<String> getLedgerNamesList() {
		return ledgerNamesList;
	}

	public void setLedgerNamesList(List<String> ledgerNamesList) {
		this.ledgerNamesList = ledgerNamesList;
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

	public List<String> getGroupNamesList() {
		return groupNamesList;
	}

	public void setGroupNamesList(List<String> groupNamesList) {
		this.groupNamesList = groupNamesList;
	}

	public String getLedgerName() {
		return ledgerName;
	}

	public void setLedgerName(String ledgerName) {
		this.ledgerName = ledgerName;
	}

	public String getGroupUnder() {
		return groupUnder;
	}

	public void setGroupUnder(String groupUnder) {
		this.groupUnder = groupUnder;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	public List<LedgerBean> getAccountLedgerMaster() {
		return accountLedgerMaster;
	}

	public void setAccountLedgerMaster(List<LedgerBean> accountLedgerMaster) {
		this.accountLedgerMaster = accountLedgerMaster;
	}

	public LedgerBankAccount getLedgerBankAccount() {
		return ledgerBankAccount;
	}

	public void setLedgerBankAccount(LedgerBankAccount ledgerBankAccount) {
		this.ledgerBankAccount = ledgerBankAccount;
	}

	public List<String> getEmployeeUnderList() {
		return employeeUnderList;
	}

	public void setEmployeeUnderList(List<String> employeeUnderList) {
		this.employeeUnderList = employeeUnderList;
	}

	public String getBlcBillByBill() {
		return blcBillByBill;
	}

	public void setBlcBillByBill(String blcBillByBill) {
		this.blcBillByBill = blcBillByBill;
	}

	public String getDefCreditPeriod() {
		return defCreditPeriod;
	}

	public void setDefCreditPeriod(String defCreditPeriod) {
		this.defCreditPeriod = defCreditPeriod;
	}

	public String getCreditDayDuringVoucher() {
		return creditDayDuringVoucher;
	}

	public void setCreditDayDuringVoucher(String creditDayDuringVoucher) {
		this.creditDayDuringVoucher = creditDayDuringVoucher;
	}

	public String getSpecifyCreditLimit() {
		return specifyCreditLimit;
	}

	public void setSpecifyCreditLimit(String specifyCreditLimit) {
		this.specifyCreditLimit = specifyCreditLimit;
	}

	public String getOpeningDate() {
		return openingDate;
	}

	public void setOpeningDate(String openingDate) {
		this.openingDate = openingDate;
	}

	public String getOpeningBalance() {
		return openingBalance;
	}

	public void setOpeningBalance(String openingBalance) {
		this.openingBalance = openingBalance;
	}

	public String getCr_Dr() {
		return Cr_Dr;
	}

	public void setCr_Dr(String cr_Dr) {
		Cr_Dr = cr_Dr;
	}

	public String getIntesestBasedOn() {
		return intesestBasedOn;
	}

	public void setIntesestBasedOn(String intesestBasedOn) {
		this.intesestBasedOn = intesestBasedOn;
	}

	public String getForamtAdded() {
		return foramtAdded;
	}

	public void setForamtAdded(String foramtAdded) {
		this.foramtAdded = foramtAdded;
	}

	public String getForamtDeduct() {
		return foramtDeduct;
	}

	public void setForamtDeduct(String foramtDeduct) {
		this.foramtDeduct = foramtDeduct;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getRatePer() {
		return ratePer;
	}

	public void setRatePer(String ratePer) {
		this.ratePer = ratePer;
	}

	public String getRateOn() {
		return rateOn;
	}

	public void setRateOn(String rateOn) {
		this.rateOn = rateOn;
	}

	public String getTxnByTxnInterest() {
		return txnByTxnInterest;
	}

	public void setTxnByTxnInterest(String txnByTxnInterest) {
		this.txnByTxnInterest = txnByTxnInterest;
	}

	public String getIntersetCalculationApplicability() {
		return intersetCalculationApplicability;
	}

	public void setIntersetCalculationApplicability(String intersetCalculationApplicability) {
		this.intersetCalculationApplicability = intersetCalculationApplicability;
	}

	public String getIntersetCalculationApplicabilityDays() {
		return intersetCalculationApplicabilityDays;
	}

	public void setIntersetCalculationApplicabilityDays(String intersetCalculationApplicabilityDays) {
		this.intersetCalculationApplicabilityDays = intersetCalculationApplicabilityDays;
	}

	public String getIntersetCalculationFrom() {
		return intersetCalculationFrom;
	}

	public void setIntersetCalculationFrom(String intersetCalculationFrom) {
		this.intersetCalculationFrom = intersetCalculationFrom;
	}

	public String getLedger_id() {
		return ledger_id;
	}

	public void setLedger_id(String ledger_id) {
		this.ledger_id = ledger_id;
	}

	public LedgerCustomBean getLedgerCustomBean() {
		return ledgerCustomBean;
	}

	public void setLedgerCustomBean(LedgerCustomBean ledgerCustomBean) {
		this.ledgerCustomBean = ledgerCustomBean;
	}

	public String getEmployeeUnder() {
		return employeeUnder;
	}

	public void setEmployeeUnder(String employeeUnder) {
		this.employeeUnder = employeeUnder;
	}

	public String getIntersetCalculationApplicabilityGracePeriod() {
		return intersetCalculationApplicabilityGracePeriod;
	}

	public void setIntersetCalculationApplicabilityGracePeriod(String intersetCalculationApplicabilityGracePeriod) {
		this.intersetCalculationApplicabilityGracePeriod = intersetCalculationApplicabilityGracePeriod;
	}

	public String getIntersetCalculationSecurityAmt() {
		return intersetCalculationSecurityAmt;
	}

	public void setIntersetCalculationSecurityAmt(String intersetCalculationSecurityAmt) {
		this.intersetCalculationSecurityAmt = intersetCalculationSecurityAmt;
	}

	public LedgerSecondStepBean getLedgerSecondStepBean() {
		return ledgerSecondStepBean;
	}

	public void setLedgerSecondStepBean(LedgerSecondStepBean ledgerSecondStepBean) {
		this.ledgerSecondStepBean = ledgerSecondStepBean;
	}

	public String getResultType() {
		return resultType;
	}

	public void setResultType(String resultType) {
		this.resultType = resultType;
	}

	public String getSecurity() {
		return security;
	}

	public void setSecurity(String security) {
		this.security = security;
	}

	public String getEmployeeNames() {
		return employeeNames;
	}

	public void setEmployeeNames(String employeeNames) {
		this.employeeNames = employeeNames;
	}

	public String getUpdateOpeningBalance() {
		return updateOpeningBalance;
	}

	public void setUpdateOpeningBalance(String updateOpeningBalance) {
		this.updateOpeningBalance = updateOpeningBalance;
	}

	public List<String> getLocationNames() {
		return locationNames;
	}

	public void setLocationNames(List<String> locationNames) {
		this.locationNames = locationNames;
	}

}
