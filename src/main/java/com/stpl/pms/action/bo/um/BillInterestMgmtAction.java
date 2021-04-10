package com.stpl.pms.action.bo.um;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.commonJavabeans.SaleBillsBean;
import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;

public class BillInterestMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> ledgerNames;
	private String ledgerName;
	private String billList;
	private SaleBillsBean resultreport;
	private String itemName;

	public String loadPage() {
		GameLobbyController controller = new GameLobbyController();
		ledgerNames = controller.getLedgerNamesList();
		return SUCCESS;
	}

	public String getBillsReport() {
		GameLobbyController controller = new GameLobbyController();
		resultreport = controller.getResultOfBills(ledgerName, billList);
		return SUCCESS;
	}

	public void showBills() throws IOException {

		GameLobbyController controller = new GameLobbyController();
		String data = controller.getBillsOfParty(ledgerName);
		if (data.equals("")) {
			servletResponse.getWriter().write("error");
		} else {
			servletResponse.getWriter().write("" + data);
		}
		return;

	}
	
	public void showBatches() throws IOException {

		GameLobbyController controller = new GameLobbyController();
		String data = controller.showBatches(itemName);
		if (data.equals("")) {
			servletResponse.getWriter().write("error");
		} else {
			servletResponse.getWriter().write("" + data);
		}
		return;

	}
	public void showBillsOverDue() throws IOException {

		GameLobbyController controller = new GameLobbyController();
		String data = controller.getBillsOfPartyOverDue(ledgerName);
		if (data.equals("")) {
			servletResponse.getWriter().write("error");
		} else {
			servletResponse.getWriter().write("" + data);
		}
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

	public List<String> getLedgerNames() {
		return ledgerNames;
	}

	public void setLedgerNames(List<String> ledgerNames) {
		this.ledgerNames = ledgerNames;
	}

	public String getLedgerName() {
		return ledgerName;
	}

	public void setLedgerName(String ledgerName) {
		this.ledgerName = ledgerName;
	}

	public String getBillList() {
		return billList;
	}

	public void setBillList(String billList) {
		this.billList = billList;
	}

	public SaleBillsBean getResultreport() {
		return resultreport;
	}

	public void setResultreport(SaleBillsBean resultreport) {
		this.resultreport = resultreport;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

}
