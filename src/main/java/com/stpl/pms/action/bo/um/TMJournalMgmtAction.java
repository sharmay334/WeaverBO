package com.stpl.pms.action.bo.um;

import java.io.IOException;
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

public class TMJournalMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> employeeUnderList;
	private int journalNo;
	private List<String> particularsList;
	// create payment fields
	private String journalNoVoucher;
	private String employeeUnder;
	private String particulars;
	private String cr_dr;
	private String debitAmt;
	private String creditAmt;
	private String narration;
	private String partyName;
	private String partyAcc;
	private String typeOfRef;
	private VoucherBean voucherBean;
	private String paymentDate;
	private String hiddenAmnt;
	private String hiddenBilId;
	private String hiddenTypeOfRef;
	private String hiddenBillWiseName;
	private String activeVoucherNumber;

	public String loadJournalPage() {
		GameLobbyController controller = new GameLobbyController();
		employeeUnderList = controller.getEmployeeNamesList();
		particularsList = new ArrayList<String>();
		particularsList = controller.getaccountListForTxnPayment("particulars", getUserInfoBean().getUserId());
		journalNo = controller.getJournalNo();

		String checkIsVoucherActive = controller.getActiveVoucher("journal");
		if (checkIsVoucherActive.equalsIgnoreCase("duplicate")) {
			return ERROR;
		}

		else {
			voucherBean = controller.getVoucherNumbering("journal", checkIsVoucherActive);
			if (checkIsVoucherActive.equalsIgnoreCase("not found"))
				activeVoucherNumber = "0";
			else
				activeVoucherNumber = checkIsVoucherActive;
			if (voucherBean == null)
				journalNoVoucher = String.valueOf(controller.getJournalNo());
			else {

				if (voucherBean.getVoucherNumbering().equals("Manual")) {
					journalNoVoucher = String.valueOf(controller.getJournalNo());
				} else {
					if (voucherBean.getAdvanceNumbering().equals("Yes")) {
						int getMaxNumber = controller.getJournalVoucherNumber(activeVoucherNumber);
						if (getMaxNumber == 0) {
							journalNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix()
									+ String.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d",
											Integer.valueOf(voucherBean.getStartingNumber()));
						} else {
							getMaxNumber++;
							journalNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix() + String
									.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d", getMaxNumber);
							;

						}
					} else {
						journalNoVoucher = String.valueOf(controller.getJournalNo());
					}

				}

			}
			return SUCCESS;
		}
	}

	public void getPartyBills() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String newBillNo = controller.getOldBillNoJournal(partyAcc, typeOfRef);
		servletResponse.getWriter().write("" + newBillNo);

		return;

	}

	public void getNewBillNo() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String newBillNo = controller.getNewBillNoJournal(partyAcc, typeOfRef);
		servletResponse.getWriter().write("" + newBillNo);

		return;
	}

	public void getPartyType() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		int ledgerId = controller.findLedgerIdByName(partyName);
		String partyType = controller.getPartyTypeById(ledgerId);
		if (partyType.equals("Sundry debtors") || partyType.equals("Sundry creditors")) {
			if (controller.checkForBillByBill(partyName))
				servletResponse.getWriter().write("eligible");
			else
				servletResponse.getWriter().write("no");
		} else {
			servletResponse.getWriter().write("other");
		}
		return;
	}

	public void createJournal() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if(activeVoucherNumber.equals("0")) {
			if (controller.createTransactionJournal(employeeUnder, particulars, cr_dr, debitAmt, creditAmt, narration,
					journalNoVoucher, paymentDate, activeVoucherNumber))
				if (controller.updateTransactionPartyBalanceJournal(particulars, debitAmt, creditAmt, cr_dr, hiddenAmnt,
						hiddenTypeOfRef, hiddenBillWiseName, journalNoVoucher))
					servletResponse.getWriter().write("success");
				else
					servletResponse.getWriter().write("no");
		}
		else {
			
			voucherBean = controller.getVoucherNumbering("journal", activeVoucherNumber);
			boolean voucherDate = compareTwoDate(voucherBean.getEndDate(),paymentDate+" 00:00");
			if(voucherDate==true) {
				servletResponse.getWriter().write("date");
			}
			else {
				
				if (controller.createTransactionJournal(employeeUnder, particulars, cr_dr, debitAmt, creditAmt, narration,
						journalNoVoucher, paymentDate, activeVoucherNumber))
					if (controller.updateTransactionPartyBalanceJournal(particulars, debitAmt, creditAmt, cr_dr, hiddenAmnt,
							hiddenTypeOfRef, hiddenBillWiseName, journalNoVoucher))
						servletResponse.getWriter().write("success");
					else
						servletResponse.getWriter().write("no");
			}
		}
		
		return;
	}
	private boolean compareTwoDate(String endDate, String currentDate){
		// TODO Auto-generated method stub
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy h:m");
			if (sdf.parse(currentDate).after(sdf.parse(endDate))) {
				return true;
			}

			
		}catch(Exception e) {
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

	public List<String> getEmployeeUnderList() {
		return employeeUnderList;
	}

	public void setEmployeeUnderList(List<String> employeeUnderList) {
		this.employeeUnderList = employeeUnderList;
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

	public String getNarration() {
		return narration;
	}

	public void setNarration(String narration) {
		this.narration = narration;
	}

	public int getJournalNo() {
		return journalNo;
	}

	public void setJournalNo(int journalNo) {
		this.journalNo = journalNo;
	}

	public String getCr_dr() {
		return cr_dr;
	}

	public void setCr_dr(String cr_dr) {
		this.cr_dr = cr_dr;
	}

	public String getDebitAmt() {
		return debitAmt;
	}

	public void setDebitAmt(String debitAmt) {
		this.debitAmt = debitAmt;
	}

	public String getCreditAmt() {
		return creditAmt;
	}

	public void setCreditAmt(String creditAmt) {
		this.creditAmt = creditAmt;
	}

	public List<String> getParticularsList() {
		return particularsList;
	}

	public void setParticularsList(List<String> particularsList) {
		this.particularsList = particularsList;
	}

	public String getPartyName() {
		return partyName;
	}

	public void setPartyName(String partyName) {
		this.partyName = partyName;
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

	public String getJournalNoVoucher() {
		return journalNoVoucher;
	}

	public void setJournalNoVoucher(String journalNoVoucher) {
		this.journalNoVoucher = journalNoVoucher;
	}

	public VoucherBean getVoucherBean() {
		return voucherBean;
	}

	public void setVoucherBean(VoucherBean voucherBean) {
		this.voucherBean = voucherBean;
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

}