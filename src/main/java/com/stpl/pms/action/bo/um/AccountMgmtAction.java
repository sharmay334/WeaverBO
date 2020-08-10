package com.stpl.pms.action.bo.um;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.javabeans.AccountGroupMaster;
import com.stpl.pms.javabeans.VoucherBean;
import com.stpl.pms.struts.common.BaseActionSupport;

public class AccountMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> groupNamesList;
	private String groupName;
	private String groupUnder;
	private String subLedger;
	private String blncForRep;
	private String forCalc;
	private String purInvoice;
	private List<AccountGroupMaster> accountGroupMaster;
	private AccountGroupMaster groupMaster;
	private int group_id;
	private List<String> voucherList;
	private VoucherBean voucherBean;
	private int voucherId;
	private List<String> voucherNameList;
	private List<VoucherBean> voucherBeans;
	private String voucherUnderName;
	private Map<String, VoucherBean> voucherMap;
	private String status;
	private String voucheRowId;

	public String billingNumber() {

		return SUCCESS;

	}

	public void changeStatusVoucher() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.changeVoucherStatus(voucheRowId, status))
			servletResponse.getWriter().write("success");
		else
			servletResponse.getWriter().write("error");
			return;
	}

	public String loadPageVocuherReport() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		voucherList = gameLobbyController.getVoucherTypeList();
		return SUCCESS;
	}

	public String getVouchers() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		voucherMap = gameLobbyController.getAvailableVoucherList(voucherUnderName);
		return SUCCESS;
	}

	public String createGroup() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		groupNamesList = gameLobbyController.getGroupNamesList();

		return SUCCESS;
	}

	public String editGroup() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		if (gameLobbyController.editGroupDetails(groupMaster))
			return SUCCESS;
		else
			return ERROR;
	}

	public String showGroupDetails() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		groupMaster = gameLobbyController.getEditGroupDisplay(group_id);
		return SUCCESS;
	}

	public String deleteGroup() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		if (gameLobbyController.deleteGroupByName(groupName))
			return SUCCESS;
		else
			return ERROR;
	}

	public String groupSearchResult() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		accountGroupMaster = gameLobbyController.getAccountGroupMaster(groupName);
		return SUCCESS;
	}

	public String getGroupList() {
		groupNamesList = new ArrayList<String>();
		GameLobbyController gameLobbyController = new GameLobbyController();
		groupNamesList = gameLobbyController.getCustomGroupNameList();
		return SUCCESS;
	}

	public String insertGroup() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		if (gameLobbyController.insertGroup(groupName, groupUnder.toUpperCase(), subLedger.toUpperCase(),
				blncForRep.toUpperCase(), forCalc.toUpperCase(), purInvoice.toUpperCase().replaceAll(" ", "_")))
			return SUCCESS;
		else
			return ERROR;
	}

	public String createVoucher() {
		GameLobbyController controller = new GameLobbyController();
		if (controller.createNewVoucher(voucherBean))
			return SUCCESS;
		else
			return ERROR;
	}

	public String viewVoucher() {
		GameLobbyController controller = new GameLobbyController();
		voucherNameList = controller.getCustomVoucherList();
		return SUCCESS;
	}

	public String showVoucherDetails() {
		GameLobbyController controller = new GameLobbyController();
		voucherBean = controller.getVouchetBeanById(voucherId);
		voucherList = controller.getVoucherTypeList();

		return SUCCESS;
	}

	public String getVoucherResult() {
		GameLobbyController controller = new GameLobbyController();
		voucherBeans = controller.getVouchetBeanByName(voucherBean.getVoucherName());
		return SUCCESS;
	}

	public String deleteVoucher() {
		GameLobbyController controller = new GameLobbyController();
		if (controller.deleteVoucher(voucherBean.getVoucherName()))
			return SUCCESS;
		else
			return ERROR;
	}

	public String editVoucher() {
		GameLobbyController controller = new GameLobbyController();
		if (controller.updateVoucher(voucherBean))
			return SUCCESS;
		else
			return ERROR;
	}

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		GameLobbyController controller = new GameLobbyController();
		voucherList = controller.getVoucherTypeList();
		return SUCCESS;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getGroupUnder() {
		return groupUnder;
	}

	public void setGroupUnder(String groupUnder) {
		this.groupUnder = groupUnder;
	}

	public String getSubLedger() {
		return subLedger;
	}

	public void setSubLedger(String subLedger) {
		this.subLedger = subLedger;
	}

	public String getBlncForRep() {
		return blncForRep;
	}

	public void setBlncForRep(String blncForRep) {
		this.blncForRep = blncForRep;
	}

	public String getForCalc() {
		return forCalc;
	}

	public void setForCalc(String forCalc) {
		this.forCalc = forCalc;
	}

	public String getPurInvoice() {
		return purInvoice;
	}

	public void setPurInvoice(String purInvoice) {
		this.purInvoice = purInvoice;
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

	public List<AccountGroupMaster> getAccountGroupMaster() {
		return accountGroupMaster;
	}

	public void setAccountGroupMaster(List<AccountGroupMaster> accountGroupMaster) {
		this.accountGroupMaster = accountGroupMaster;
	}

	public AccountGroupMaster getGroupMaster() {
		return groupMaster;
	}

	public void setGroupMaster(AccountGroupMaster groupMaster) {
		this.groupMaster = groupMaster;
	}

	public int getGroup_id() {
		return group_id;
	}

	public void setGroup_id(int group_id) {
		this.group_id = group_id;
	}

	public List<String> getVoucherList() {
		return voucherList;
	}

	public void setVoucherList(List<String> voucherList) {
		this.voucherList = voucherList;
	}

	public VoucherBean getVoucherBean() {
		return voucherBean;
	}

	public void setVoucherBean(VoucherBean voucherBean) {
		this.voucherBean = voucherBean;
	}

	public List<String> getVoucherNameList() {
		return voucherNameList;
	}

	public void setVoucherNameList(List<String> voucherNameList) {
		this.voucherNameList = voucherNameList;
	}

	public List<VoucherBean> getVoucherBeans() {
		return voucherBeans;
	}

	public void setVoucherBeans(List<VoucherBean> voucherBeans) {
		this.voucherBeans = voucherBeans;
	}

	public int getVoucherId() {
		return voucherId;
	}

	public void setVoucherId(int voucherId) {
		this.voucherId = voucherId;
	}

	public String getVoucherUnderName() {
		return voucherUnderName;
	}

	public void setVoucherUnderName(String voucherUnderName) {
		this.voucherUnderName = voucherUnderName;
	}

	public Map<String, VoucherBean> getVoucherMap() {
		return voucherMap;
	}

	public void setVoucherMap(Map<String, VoucherBean> voucherMap) {
		this.voucherMap = voucherMap;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getVoucheRowId() {
		return voucheRowId;
	}

	public void setVoucheRowId(String voucheRowId) {
		this.voucheRowId = voucheRowId;
	}

}
