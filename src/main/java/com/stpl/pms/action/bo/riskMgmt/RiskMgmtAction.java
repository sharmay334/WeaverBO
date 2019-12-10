package com.stpl.pms.action.bo.riskMgmt;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import com.stpl.pms.controller.commonMethods.CommonMethodController;
import com.stpl.pms.controller.riskMgmt.BORiskMgmtController;
import com.stpl.pms.exception.PMSException;
import com.stpl.pms.javabeans.DBConfigBean;
import com.stpl.pms.struts.common.BaseActionSupport;

public class RiskMgmtAction extends BaseActionSupport {
	private static final long serialVersionUID = 1L;

	private String reason;
	private List<String> domainIpList;
	private List<String> emailIdList;
	private List<Long> phoneNoList;
	private Map<Integer, String> ipAddresses;
	private static String userName;
	private String ipAdd;
	private String searchEmail;
	private String searchPhone;
	private String[] cachedTable;
	private String tableName;
	private DBConfigBean configBean;

	public String blockIpSearchResult() {
		BORiskMgmtController controller = new BORiskMgmtController();
		try {
			if (userName != null) {
				int userId = controller.getUserId(userName);
				ipAddresses = controller.blockIpSearchResult(userId);

			}
		} catch (PMSException be) {
			addActionError(be.getErrorMessage());
			return "exception_nodecorate";
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception_nodecorate";
		}
		return SUCCESS;
	}

	public String blockIpEditSave() {
		try {
			if (domainIpList != null) {
				BORiskMgmtController controller = new BORiskMgmtController();
				int userId = controller.getUserId(userName);
				controller.blockIpSave(userInfoBean.getDomainId(), reason, domainIpList, userId);
			} else {
				
				//addActionError("No IP found to Block");
				return ERROR;
			}
		} catch (PMSException be) {
			addActionError(be.getErrorMessage());
			be.printStackTrace();
			return "exception";
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}

	public String blockEmailSearchResult() {
		BORiskMgmtController controller = new BORiskMgmtController();
		try {
			if (CommonMethodController.getInstance().getDmProperty(domainId, "blockedEmail")
					.equalsIgnoreCase("BYDEFAULT")) {
				domainId = 1;
			}
			ipAddresses = controller.blockEmailSearchResult(domainId, searchEmail);
		} catch (PMSException be) {
			addActionError(be.getErrorMessage());
			be.printStackTrace();
			return "exception_nodecorate";
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception_nodecorate";
		}
		return SUCCESS;
	}

	public String blockEmailEditSave() {
		try {
			if (emailIdList != null) {
				Set<String> emailSet = new HashSet<String>(emailIdList);
				if (emailSet.size() != emailIdList.size()) {
					addActionError("Duplicate IP Address.");
					return "exception";
				}
				BORiskMgmtController controller = new BORiskMgmtController();
				controller.blockEmailSave(domainId, reason, emailSet, userInfoBean.getUserId());
			} else {
				addActionError("No Email found to Block");
				return "exception";
			}
		} catch (PMSException be) {
			addActionError(be.getErrorMessage());
			be.printStackTrace();
			return "exception";
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}

	public String blockPhoneSearchResult() {
		BORiskMgmtController controller = new BORiskMgmtController();
		try {
			if (CommonMethodController.getInstance().getDmProperty(domainId, "blockedPhone")
					.equalsIgnoreCase("BYDEFAULT")) {
				domainId = 1;
			}
			ipAddresses = controller.blockPhoneSearchResult(domainId, searchPhone);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}

	public String blockPhoneEditSave() {
		try {
			if (phoneNoList != null) {
				Set<Long> phoneSet = new HashSet<Long>(phoneNoList);
				if (phoneSet.size() != phoneNoList.size()) {
					addActionError("Duplicate IP Address.");
					return "exception";
				}
				BORiskMgmtController controller = new BORiskMgmtController();
				controller.blockPhoneSave(domainId, reason, phoneSet, userInfoBean.getUserId());
			} else {
				addActionError("No Phone No found to Block");
				return "exception";
			}
		} catch (PMSException be) {
			addActionError(be.getErrorMessage());
			be.printStackTrace();
			return "exception";
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}

	public String invalidateCache() {
		try {
			CommonMethodController.getInstance().invalidateCache(tableName);
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error!");
			return "exception";
		}
		return SUCCESS;
	}

	public String fetchDBConfiguration() {
		try {
			configBean = new BORiskMgmtController().fetchDBConfiguration();
			configBean.setPortalContDmName(getDomainName(configBean.getPortalContDmName()));
			configBean.setCshDmName(getDomainName(configBean.getCshDmName()));
			configBean.setCommonContDmName(getDomainName(configBean.getCommonContDmName()));
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error!");
			return "exception";
		}
	}

	public static String getDomainName(String url) {
		try {
			if (!url.startsWith("http") && !url.startsWith("https"))
				url = "http://" + url;
			URI uri = new URI(url);
			String domain = uri.getHost();
			return domain.startsWith("www.") ? domain.substring(4) : domain;
		} catch (URISyntaxException e) {
			e.printStackTrace();
			return null;
		} catch (Exception be) {
			be.printStackTrace();
			return null;
		}
	}

	public String dbConfiguration() {
		try {
			new BORiskMgmtController().dbConfiguration(configBean);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error!");
			return "exception";
		}
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public Map<Integer, String> getIpAddresses() {
		return ipAddresses;
	}

	public void setIpAddresses(Map<Integer, String> ipAddresses) {
		this.ipAddresses = ipAddresses;
	}

	public void setIpAdd(String ipAdd) {
		this.ipAdd = ipAdd;
	}

	public String getIpAdd() {
		return ipAdd;
	}

	public void setSearchEmail(String searchEmail) {
		this.searchEmail = searchEmail;
	}

	public String getSearchEmail() {
		return searchEmail;
	}

	public void setSearchPhone(String searchPhone) {
		this.searchPhone = searchPhone;
	}

	public String getSearchPhone() {
		return searchPhone;
	}
	

	public static String getUserName() {
		return userName;
	}

	public static void setUserName(String userName) {
		RiskMgmtAction.userName = userName;
	}

	public void setDomainIpList(List<String> domainIpList) {
		this.domainIpList = domainIpList;
	}

	public List<String> getDomainIpList() {
		return domainIpList;
	}

	public List<String> getEmailIdList() {
		return emailIdList;
	}

	public void setEmailIdList(List<String> emailIdList) {
		this.emailIdList = emailIdList;
	}

	public List<Long> getPhoneNoList() {
		return phoneNoList;
	}

	public void setPhoneNoList(List<Long> phoneNoList) {
		this.phoneNoList = phoneNoList;
	}

	public String[] getCachedTable() {
		return cachedTable;
	}

	public void setCachedTable(String[] cachedTable) {
		this.cachedTable = cachedTable;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public DBConfigBean getConfigBean() {
		return configBean;
	}

	public void setConfigBean(DBConfigBean configBean) {
		this.configBean = configBean;
	}
}
