package com.stpl.pms.action.bo.reports;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.commonJavabeans.BillsBean;
import com.stpl.pms.commonJavabeans.InterestBean;
import com.stpl.pms.commonJavabeans.LedgerReportBean;
import com.stpl.pms.commonJavabeans.SalaryReportBean;
import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.controller.gm.GameMgmtController;
import com.stpl.pms.controller.um.UserMgmtController;
import com.stpl.pms.exception.PMSException;
import com.stpl.pms.hibernate.mapping.StRmBoUserInfo;
import com.stpl.pms.javabeans.UserDetailsBean;
import com.stpl.pms.javabeans.UserInfoBean;
import com.stpl.pms.struts.common.BaseActionSupport;

@SuppressWarnings("serial")
public class ReportsAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> ledgerNames;
	private Map<String, LedgerReportBean> beanMap;
	private String ledgerName;
	private String fromDate;
	private String toDate;
	private String empName;
	private List<String> empList;
	private Map<String, BillsBean> billBeanMap;
	private String totCreditAmt;
	private String totDebitAmt;
	private String closingBal;
	private String openingBal;
	private String taxAmount;
	private List<String> itemNameList;
	private String itemName;
	private String regularPrice;
	private String superCashPrice;
	private String isNegative;
	private String dueType;
	private List<String> employeeNames;
	private String juniorAccName;
	private String dispatcherName;
	private String seniorAccName;
	private String openingBalanceType;
	private Map<String, InterestBean> interestMap;
	private String totalInterestAmount;
	private Map<String, SalaryReportBean> salaryBeanMap;
	private String monthYear;
	private String totalOdoReading;
	private String totalTAAmt;
	private String totalSalary;
	private String totalDaAmt;
	private String totalOtherExpAmt;
	private String totalHotelExpAmt;
	private String employeeName;
	private List<StRmBoUserInfo> userList;
	private List<String> branchList;
	private List<String> regionList;
	private List<String> roleList;
	private List<String> departmentList;
	private int user_id;
	private StRmBoUserInfo userDetailsBean;
	private UserInfoBean userInfoBean;

	public String editEmployeeSave() {
		GameLobbyController controller = new GameLobbyController();
		if (controller.saveUserInfoBean(userDetailsBean, userDetailsBean.getUserId()))
			return SUCCESS;
		else
			return ERROR;
	}

	public String editEmployeePage() {
		GameLobbyController controller = new GameLobbyController();
		UserMgmtController service = new UserMgmtController();

		branchList = controller.getDynamicFieldList("branch");
		regionList = controller.getDynamicFieldList("region");
		roleList = controller.getDynamicFieldList("role");
		departmentList = controller.getDynamicFieldList("department");

		// PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
		// .getAttribute("ALLOWED_PRIV");
		try {
			userDetailsBean = service.searchBoUser(user_id);
		} catch (Exception be) {
		}
		return SUCCESS;

	}

	public String viewEmployeeDetails() {
		UserMgmtController service = new UserMgmtController();
		try {
			userList = service.searchBoUsers("yash", employeeName, "ACTIVE");
			return SUCCESS;
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception_nodecorate";
		}
	}

	public String viewEmployee() {
		GameLobbyController controller = new GameLobbyController();
		setEmployeeNames(controller.getEmployeeNamesList());
		return SUCCESS;
	}

	public String generateSalaryReport() {
		GameLobbyController controller = new GameLobbyController();
		Map<String, String> mm = new HashMap<>();

		mm.put("JAN", "01");
		mm.put("FEB", "02");
		mm.put("MAR", "03");
		mm.put("APR", "04");
		mm.put("MAY", "05");
		mm.put("JUN", "06");
		mm.put("JUL", "07");
		mm.put("AUG", "08");
		mm.put("SEP", "09");
		mm.put("OCT", "10");
		mm.put("NOV", "11");
		mm.put("DEC", "12");
		String[] ar = monthYear.split("-");
		String fromDate = ar[1] + "-" + mm.get(ar[0]) + "-01";
		String toDate = ar[1] + "-" + mm.get(ar[0]) + "-31";
		salaryBeanMap = controller.generateSalaryReportBean(empName, fromDate, toDate);
		Double totalOReading = 0.0;
		Double totalTaAmt = 0.0;
		Double totaldaAmt = 0.0;
		Double totalsalAmt = 0.0;
		Double totalOthrAmt = 0.0;
		Double totalHotelAmt = 0.0;

		for (Map.Entry<String, SalaryReportBean> map : salaryBeanMap.entrySet()) {
			totalOReading = totalOReading + Double.valueOf(map.getValue().getOdoReading());
			totalTaAmt = totalTaAmt + Double.valueOf(map.getValue().getTA());
			totaldaAmt = totaldaAmt + Double.valueOf(map.getValue().getdA());
			totalsalAmt = totalsalAmt + Double.valueOf(map.getValue().getSalary());
			totalOthrAmt = totalOthrAmt + Double.valueOf(map.getValue().getOtherExp());
			totalHotelAmt = totalHotelAmt + Double.valueOf(map.getValue().getHotelExp());

		}
		totalOdoReading = String.format("%.2f", totalOReading);
		totalTAAmt = String.format("%.2f", totalTaAmt);
		totalSalary = String.format("%.2f", totalsalAmt);
		totalDaAmt = String.format("%.2f", totaldaAmt);
		totalOtherExpAmt = String.format("%.2f", totalOthrAmt);
		totalHotelExpAmt = String.format("%.2f", totalHotelAmt);

		return SUCCESS;
	}

	public void getEmployeSalaryMonthsList() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String dateOfJoining = controller.getEmployeeDateOfJoining(empName);
		Map<String, String> mm = new HashMap<>();

		mm.put("01", "JAN");
		mm.put("02", "FEB");
		mm.put("03", "MAR");
		mm.put("04", "APR");
		mm.put("05", "MAY");
		mm.put("06", "JUN");
		mm.put("07", "JUL");
		mm.put("08", "AUG");
		mm.put("09", "SEP");
		mm.put("10", "OCT");
		mm.put("11", "NOV");
		mm.put("12", "DEC");

		if (dateOfJoining != null) {
			LocalDate date11 = LocalDate.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM-yyyy");
			String currentDate = date11.format(formatter).toUpperCase();

			String[] dojArr = dateOfJoining.split("-");
			String doj = mm.get(dojArr[1].trim()) + "-" + dojArr[0];

			DateFormat formater = new SimpleDateFormat("MMM-yyyy");

			Calendar beginCalendar = Calendar.getInstance();
			Calendar finishCalendar = Calendar.getInstance();

			try {
				beginCalendar.setTime(formater.parse(doj));
				finishCalendar.setTime(formater.parse(currentDate));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			String appender = "";
			while (beginCalendar.before(finishCalendar)) {
				// add one month to date per loop
				String date = formater.format(beginCalendar.getTime()).toUpperCase();
				appender = appender + date + ";";
				beginCalendar.add(Calendar.MONTH, 1);
			}
			servletResponse.getWriter().write("" + appender);
			return;
		}

		servletResponse.getWriter().write("error");
		return;
	}

	public String loadEmployeeSalaryPage() {
		GameLobbyController controller = new GameLobbyController();
		setEmployeeNames(controller.getEmployeeNamesList());
		return SUCCESS;
	}

	public String loadPageTransactionApproval() {
		GameLobbyController controller = new GameLobbyController();
		setEmployeeNames(controller.getEmployeeNamesList());

		return SUCCESS;
	}

	public String loadInterestReport() {
		GameLobbyController controller = new GameLobbyController();
		ledgerNames = controller.getLedgerNamesList();

		return SUCCESS;
	}

	public String loadInterestReportResult() {
		GameLobbyController controller = new GameLobbyController();
		interestMap = controller.getInterestReportResult(ledgerName, fromDate, toDate);
		Double intAmt = 0.0;
		for (Entry<String, InterestBean> map : interestMap.entrySet()) {
			intAmt = intAmt + Double.valueOf(map.getValue().getInterestBalance());

		}
		totalInterestAmount = String.format("%.2f", intAmt);
		return SUCCESS;
	}

	public String getTransactionApprovals() {
		GameLobbyController controller = new GameLobbyController();
		employeeNames = controller.getEmployeeNamesList();
		juniorAccName = controller.getAccNameByEmpId(controller.getUserIdByName(empName), "junior_acc_id");
		dispatcherName = controller.getAccNameByEmpId(controller.getUserIdByName(empName), "dispatcher_id");
		seniorAccName = controller.getAccNameByEmpId(controller.getUserIdByName(empName), "senior_acc_id");
		return SUCCESS;
	}

	public void setUpdateApproval() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (!juniorAccName.equals("-1") && !dispatcherName.equals("-1") && !seniorAccName.equals("-1")) {
			if (controller.setUpdateApprovalStages(empName, juniorAccName, dispatcherName, seniorAccName))
				servletResponse.getWriter().write("success");
			else
				servletResponse.getWriter().write("error");
		} else
			servletResponse.getWriter().write("validation");
	}

	public String loadLedgerReport() {
		GameLobbyController controller = new GameLobbyController();
		ledgerNames = controller.getLedgerNamesList();
		return SUCCESS;
	}

	public void updatePriceListData() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.updatePriceListData(itemName, regularPrice, superCashPrice))

			servletResponse.getWriter().write("success");
		return;

	}

	public String loadcreditDaysReminderReport() {
		GameLobbyController controller = new GameLobbyController();
		ledgerNames = controller.getLedgerNamesList();
		empList = controller.getEmployeeNamesList();
		return SUCCESS;
	}

	public String loadItems() {
		GameLobbyController controller = new GameLobbyController();
		itemNameList = controller.getSalesStockItemList();
		return SUCCESS;
	}

	public String loadItemResult() {
		GameLobbyController controller = new GameLobbyController();
		regularPrice = controller.getItemRegularRate(itemName);
		superCashPrice = controller.getItemSuperCashRate(itemName);
		return SUCCESS;
	}

	public String loadLedgerReportResult() {
		GameLobbyController controller = new GameLobbyController();
		beanMap = controller.loadLedgerReportResult(ledgerName, fromDate, toDate);
		Double debAmt = 0.0;
		Double credAmt = 0.0;
		for (Map.Entry<String, LedgerReportBean> m : beanMap.entrySet()) {

			String dAmt = m.getValue().getDebit().isEmpty() ? "0.0" : m.getValue().getDebit();
			String cAmt = m.getValue().getCredit().isEmpty() ? "0.0" : m.getValue().getCredit();
			debAmt += Double.valueOf(dAmt);
			credAmt += Double.valueOf(cAmt);
		}

		openingBal = controller.getOpeningBal(ledgerName, fromDate);
		String temp[] = openingBal.split(" ");
		String openBal = String.format("%.2f", Double.valueOf(temp[0]));
		openingBalanceType = temp[1];
		if (openingBalanceType.equals("Cr")) {

			credAmt = credAmt + Double.valueOf(temp[0]);
		} else {
			debAmt = debAmt + Double.valueOf(temp[0]);

		}

		taxAmount = controller.getPartyTaxAmount(ledgerName, fromDate, toDate);
		String taxAmt = String.format("%.2f", Double.valueOf(taxAmount));
		totCreditAmt = String.format("%.2f", credAmt);
		totDebitAmt = String.format("%.2f", Double.valueOf(debAmt) + Double.valueOf(taxAmount));

		closingBal = String.format("%.2f", (Double.valueOf(totDebitAmt)) - Double.valueOf(totCreditAmt));

		Double d = Double.valueOf(closingBal);
		if (d < 0) {
			isNegative = "Yes";
			d = d * (-1);
			closingBal = String.valueOf(d);
		} else {
			isNegative = "No";
			closingBal = String.valueOf(d);
		}

		return SUCCESS;
	}

	public String loadcreditDaysReminderReportResult() {
		GameLobbyController controller = new GameLobbyController();
		billBeanMap = controller.loadcreditDaysReminderReportResult(ledgerName, empName, fromDate, toDate);
		return SUCCESS;
	}

	public void getMonthlyReports() throws IOException {
		GameMgmtController controller = new GameMgmtController();
		Map<Integer, Integer> saleData = controller.getSaleReportByStoredProc();
		Map<Integer, Integer> purchaseData = controller.getPurchaseReportByStoredProc();
		Map<Integer, Integer> creditNoteData = controller.getCNReportByStoredProc();
		Map<Integer, Integer> DebitNoteData = controller.getDNReportByStoredProc();

		String finalResult = "[";

		finalResult += "{name:'Sale',data:[";
		String saleString = "";
		for (int i = 1; i < 13; i++) {
			saleString += saleData.get(i) + ",";
		}
		saleString = saleString.substring(0, saleString.length() - 1);
		finalResult += saleString + "]},";

		finalResult += "{name:'Purchase',data:[";
		String purchaseString = "";
		for (int i = 1; i < 13; i++) {
			purchaseString += purchaseData.get(i) + ",";
		}
		purchaseString = purchaseString.substring(0, purchaseString.length() - 1);
		finalResult += purchaseString + "]},";

		finalResult += "{name:'Credit Note',data:[";
		String cnString = "";
		for (int i = 1; i < 13; i++) {
			cnString += creditNoteData.get(i) + ",";
		}
		cnString = cnString.substring(0, cnString.length() - 1);
		finalResult += cnString + "]},";

		finalResult += "{name:'Debit Note',data:[";
		String dnString = "";
		for (int i = 1; i < 13; i++) {
			dnString += DebitNoteData.get(i) + ",";
		}
		dnString = dnString.substring(0, dnString.length() - 1);
		finalResult += dnString + "]}]";

		servletResponse.getWriter().write("" + finalResult);
		return;
	}

	public void getMonthlyPendingBillsReports() throws IOException {
		GameMgmtController controller = new GameMgmtController();
		Map<Integer, Integer> billsData = controller.getSalePendingBillsStoredProc();

		String finalResult = "[";

		finalResult += "{name:'Sale Pending Bills',data:[";
		String saleString = "";
		for (int i = 1; i < 13; i++) {
			saleString += billsData.get(i) + ",";
		}
		saleString = saleString.substring(0, saleString.length() - 1);
		finalResult += saleString + "]}]";
		servletResponse.getWriter().write("" + finalResult);
		return;
	}

	public void getSaleReceiptPieChart() throws IOException {
		GameMgmtController controller = new GameMgmtController();
		String saleAmount = controller.getTotalSaleAmount();
		String receiptAmount = controller.getTotalReceiptAmount();
		String creditAmount = controller.getTotalCNAmount();
		String finalString = "[{name:'Amount',colorByPoint: true,data:[{";
		finalString += "name:'Sale',y:" + saleAmount + ", sliced: true,selected: true},{";
		finalString += "name:'Credit Note',y:" + creditAmount + "},{";
		finalString += "name:'Receipt',y:" + receiptAmount + "}]}]";
		servletResponse.getWriter().write("" + finalString);
		return;

	}

	public String loadPageBalanceSheet() {
		GameLobbyController controller = new GameLobbyController();
		empList = controller.getEmployeeNamesList();

		return SUCCESS;
	}

	public String loadPageBalanceSheetResult() {
		GameLobbyController controller = new GameLobbyController();
		beanMap = controller.getEmployeeBalanceSheetReport(empName);
		Double totCredAm = 0.0;
		Double totDebAm = 0.0;
		for (Entry<String, LedgerReportBean> map : beanMap.entrySet()) {

			totCredAm += map.getValue().getCredit() == null ? 0.0 : Double.valueOf(map.getValue().getCredit());
			totDebAm += map.getValue().getDebit() == null ? 0.0 : Double.valueOf(map.getValue().getDebit());
		}
		totCreditAmt = String.format("%.2f", totCredAm);
		totDebitAmt = String.format("%.2f", totDebAm);
		return SUCCESS;
	}

	public void runSchSuperCashPartyBlock() throws Exception {
		GameLobbyController controller = new GameLobbyController();
		controller.blockSuperCashParty();
		servletResponse.getWriter().write("ok");
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

	public Map<String, LedgerReportBean> getBeanMap() {
		return beanMap;
	}

	public void setBeanMap(Map<String, LedgerReportBean> beanMap) {
		this.beanMap = beanMap;
	}

	public String getLedgerName() {
		return ledgerName;
	}

	public void setLedgerName(String ledgerName) {
		this.ledgerName = ledgerName;
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

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public List<String> getEmpList() {
		return empList;
	}

	public void setEmpList(List<String> empList) {
		this.empList = empList;
	}

	public Map<String, BillsBean> getBillBeanMap() {
		return billBeanMap;
	}

	public void setBillBeanMap(Map<String, BillsBean> billBeanMap) {
		this.billBeanMap = billBeanMap;
	}

	public String getTotCreditAmt() {
		return totCreditAmt;
	}

	public void setTotCreditAmt(String totCreditAmt) {
		this.totCreditAmt = totCreditAmt;
	}

	public String getTotDebitAmt() {
		return totDebitAmt;
	}

	public void setTotDebitAmt(String totDebitAmt) {
		this.totDebitAmt = totDebitAmt;
	}

	public String getClosingBal() {
		return closingBal;
	}

	public void setClosingBal(String closingBal) {
		this.closingBal = closingBal;
	}

	public String getOpeningBal() {
		return openingBal;
	}

	public void setOpeningBal(String openingBal) {
		this.openingBal = openingBal;
	}

	public String getTaxAmount() {
		return taxAmount;
	}

	public void setTaxAmount(String taxAmount) {
		this.taxAmount = taxAmount;
	}

	public List<String> getItemNameList() {
		return itemNameList;
	}

	public void setItemNameList(List<String> itemNameList) {
		this.itemNameList = itemNameList;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getRegularPrice() {
		return regularPrice;
	}

	public void setRegularPrice(String regularPrice) {
		this.regularPrice = regularPrice;
	}

	public String getSuperCashPrice() {
		return superCashPrice;
	}

	public void setSuperCashPrice(String superCashPrice) {
		this.superCashPrice = superCashPrice;
	}

	public String getIsNegative() {
		return isNegative;
	}

	public void setIsNegative(String isNegative) {
		this.isNegative = isNegative;
	}

	public String getDueType() {
		return dueType;
	}

	public void setDueType(String dueType) {
		this.dueType = dueType;
	}

	public List<String> getEmployeeNames() {
		return employeeNames;
	}

	public void setEmployeeNames(List<String> employeeNames) {
		this.employeeNames = employeeNames;
	}

	public String getJuniorAccName() {
		return juniorAccName;
	}

	public void setJuniorAccName(String juniorAccName) {
		this.juniorAccName = juniorAccName;
	}

	public String getDispatcherName() {
		return dispatcherName;
	}

	public void setDispatcherName(String dispatcherName) {
		this.dispatcherName = dispatcherName;
	}

	public String getSeniorAccName() {
		return seniorAccName;
	}

	public void setSeniorAccName(String seniorAccName) {
		this.seniorAccName = seniorAccName;
	}

	public String getOpeningBalanceType() {
		return openingBalanceType;
	}

	public void setOpeningBalanceType(String openingBalanceType) {
		this.openingBalanceType = openingBalanceType;
	}

	public Map<String, InterestBean> getInterestMap() {
		return interestMap;
	}

	public void setInterestMap(Map<String, InterestBean> interestMap) {
		this.interestMap = interestMap;
	}

	public String getTotalInterestAmount() {
		return totalInterestAmount;
	}

	public void setTotalInterestAmount(String totalInterestAmount) {
		this.totalInterestAmount = totalInterestAmount;
	}

	public Map<String, SalaryReportBean> getSalaryBeanMap() {
		return salaryBeanMap;
	}

	public void setSalaryBeanMap(Map<String, SalaryReportBean> salaryBeanMap) {
		this.salaryBeanMap = salaryBeanMap;
	}

	public String getMonthYear() {
		return monthYear;
	}

	public void setMonthYear(String monthYear) {
		this.monthYear = monthYear;
	}

	public String getTotalOdoReading() {
		return totalOdoReading;
	}

	public void setTotalOdoReading(String totalOdoReading) {
		this.totalOdoReading = totalOdoReading;
	}

	public String getTotalTAAmt() {
		return totalTAAmt;
	}

	public void setTotalTAAmt(String totalTAAmt) {
		this.totalTAAmt = totalTAAmt;
	}

	public String getTotalSalary() {
		return totalSalary;
	}

	public void setTotalSalary(String totalSalary) {
		this.totalSalary = totalSalary;
	}

	public String getTotalDaAmt() {
		return totalDaAmt;
	}

	public void setTotalDaAmt(String totalDaAmt) {
		this.totalDaAmt = totalDaAmt;
	}

	public String getTotalOtherExpAmt() {
		return totalOtherExpAmt;
	}

	public void setTotalOtherExpAmt(String totalOtherExpAmt) {
		this.totalOtherExpAmt = totalOtherExpAmt;
	}

	public String getTotalHotelExpAmt() {
		return totalHotelExpAmt;
	}

	public void setTotalHotelExpAmt(String totalHotelExpAmt) {
		this.totalHotelExpAmt = totalHotelExpAmt;
	}

	public List<StRmBoUserInfo> getUserList() {
		return userList;
	}

	public void setUserList(List<StRmBoUserInfo> userList) {
		this.userList = userList;
	}

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public List<String> getBranchList() {
		return branchList;
	}

	public void setBranchList(List<String> branchList) {
		this.branchList = branchList;
	}

	public List<String> getRegionList() {
		return regionList;
	}

	public void setRegionList(List<String> regionList) {
		this.regionList = regionList;
	}

	public List<String> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<String> roleList) {
		this.roleList = roleList;
	}

	public List<String> getDepartmentList() {
		return departmentList;
	}

	public void setDepartmentList(List<String> departmentList) {
		this.departmentList = departmentList;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public StRmBoUserInfo getUserDetailsBean() {
		return userDetailsBean;
	}

	public void setUserDetailsBean(StRmBoUserInfo userDetailsBean) {
		this.userDetailsBean = userDetailsBean;
	}

	public UserInfoBean getUserInfoBean() {
		return userInfoBean;
	}

	public void setUserInfoBean(UserInfoBean userInfoBean) {
		this.userInfoBean = userInfoBean;
	}

}
