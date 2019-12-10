package com.stpl.pms.action.bo.misc;

//import java.io.IOException;
//import java.util.HashMap;
//import java.util.HashSet;
//import java.util.List;
//import java.util.Map;
//import java.util.Set;
//
//import org.jfree.util.Log;
//
//import com.google.gson.Gson;
//import com.stpl.pms.controller.commonMethods.CommonMethodController;
//import com.stpl.pms.controller.misc.MiscMgmtController;
//import com.stpl.pms.exception.PMSException;
//import com.stpl.pms.hibernate.mapping.StGenAppVersionDetails;
//import com.stpl.pms.javabeans.CurrencyConversionDefBean;
import com.stpl.pms.struts.common.BaseActionSupport;

public class MiscAction extends BaseActionSupport {
}
/*	private static final long serialVersionUID = 1L;
	private Map<Integer, List<CurrencyConversionDefBean>> currencyConBean = new HashMap<Integer, List<CurrencyConversionDefBean>>();
	private String nativeCurrencyId;
	private boolean pushAppToAll;
	private String labelValues[];
	int nativeId;
	double exchangeRate[];
	String status[];
	private Map<Integer, String> ipAddresses;
	private String ipSearch;
	private List<String> domainIpList;
	private String reason;
	private String domainsId;
	private String alaisId;
	private String os;
	private String appType;
	private String version;
	private String versionCode;
	private String mandatory;
	private String message;
	private String url;
	private String appStatus;
	private Long appVerId;
	private Long altAppId;
	private String oldAppVer;
	private List<String> osList;
	private List<StGenAppVersionDetails> appList;
	private boolean cashAppExists;
	private boolean freeAppExists;
	private String userName;
	private String nickName;
	private String version_type;

	public void resetDomain() {

	}

	public String showCurrencyExchange() {
		MiscMgmtController miscMgmtController = new MiscMgmtController();
		try {
			nativeCurrencyId = CommonMethodController.getInstance()
					.fetchSystemProperties("NATIVE_CURRENCY");
			nativeId = Integer.parseInt(nativeCurrencyId);
			currencyConBean = miscMgmtController
					.getCurrencyExchnageMenu(nativeId);
			List<CurrencyConversionDefBean> beans = currencyConBean
					.get(nativeId);
			for (CurrencyConversionDefBean conversionBean : beans) {
				if (conversionBean.getCurrencyId() == nativeId) {
					nativeCurrencyId = conversionBean.getCurrencyName();
				}

			}
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}

	public String saveCurrency() {
		MiscMgmtController miscMgmtController = new MiscMgmtController();
		try {
			nativeCurrencyId = CommonMethodController.getInstance()
					.fetchSystemProperties("NATIVE_CURRENCY");
			nativeId = Integer.parseInt(nativeCurrencyId);
			miscMgmtController.setSaveCurrency(labelValues, exchangeRate,
					status, nativeId);
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}
	
	public String allowIpSearchResult() {
		try {
			MiscMgmtController controller = new MiscMgmtController();
			ipAddresses = controller.allowedIpSearchResult(domainId, ipSearch);
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}

	public String allowIpEditSave() {
		try {
			if (domainIpList != null) {
				Set<String> ipSet = new HashSet<String>(domainIpList);
				if (ipSet.size() != domainIpList.size()) {
					addActionError("Duplicate IP Address.");
					return "exception";
				}
				MiscMgmtController controller = new MiscMgmtController();
				controller.allowIpSave(domainId, ipSet,
						userInfoBean.getUserId(), reason);
			} else {
				addActionError("No IP found to Allow");
				return "exception";
			}
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}
	
	public String saveAppVersionDetails() {
		try {
			new MiscMgmtController().saveAppVersion(domainId, aliasId, os,
					appType, version, versionCode, url, mandatory, message,
					pushAppToAll,version_type);
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error");
			return "exception";
		}
		return SUCCESS;
	}
	public void releaseVersionCheck(){
		try {
			response.getWriter()
					.write(new MiscMgmtController().releaseVersionCheck(
							domainId, aliasId, version_type, appType,
							os) ? "<p>Beta Version already Exist. Not avaiable for Update</p>" : "");
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	public void appVersionCheck(){
		try {
			if (version != null) {
					response.getWriter()
						.write(new MiscMgmtController().appVersionCheck(
								domainId, aliasId, version, null, appType,
								os) ? "<p>App Version not Available.</p>" : "");
			} else if (versionCode != null) {
				response.getWriter()
						.write(new MiscMgmtController().appVersionCheck(
								domainId, aliasId, null, versionCode,
								appType, os) ? "<p>Version code not Available</p>"
								: "");
			} else {
				response.getWriter().write(
						"<p>Please Select version or Version Code</p>");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String fetchAppList() {
		try {
			appList=new MiscMgmtController().fetchAppVersionList(domainId, aliasId, os, "ACTIVE","all");
			for(StGenAppVersionDetails app:appList){
				if("FREE".equals(app.getAppType()) && !freeAppExists)
					freeAppExists=true;
				if("CASH".equals(app.getAppType()) && !cashAppExists)
					cashAppExists=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "exception_nodecorate";
		}
			return SUCCESS;
	}
	
	public void makeAppObsolete() throws IOException{
		try {
			new MiscMgmtController().makeAppObsolete(appVerId, altAppId, oldAppVer);
			response.getWriter().write(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("Failed");
		}		
	}
	public String updateVersionRelease() throws IOException{
		try {
			new MiscMgmtController().updateVersionRelease(appVerId);

		} catch (Exception e) {

			e.printStackTrace();
			return "exception";


		}
		return SUCCESS;
	}
	
	public void pushToAll() throws IOException {
		try {
			new MiscMgmtController().pushToAll(appVerId);
			response.getWriter().write(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("failed");
		}
	}
	
	public String fetchAltVersion() {
		try {
			appList=new MiscMgmtController().fetchAltVersion(appVerId, domainId, aliasId, os, appType);
		} catch (Exception e) {
			e.printStackTrace();
			return "exception_nodecorate";
		}
		return SUCCESS;
	}
	
	public void getPokerNickName() throws IOException{
		Log.info("fetch Poker Nick Name.");
		Map<String, Object> data = new HashMap<>();
		String nickName = null;
		try{
			nickName = new MiscMgmtController().getPokerNickName(Short.parseShort(domainsId), userName);
			data.put("nickName", nickName);
			data.put("status", 200);
		}catch(PMSException e){
			data.put("status", 400);
		}
		
		response.getWriter().write(new Gson().toJson(data));
		Log.info("Poker Nick Name sent "+nickName);
	}
	
	public void isPokerNickNameAvailable() throws IOException{
		Log.info("isPokerNickNameAvailable::started");
		Map<String, Object> data = new HashMap<>();
		boolean isAvailable =false;
		try{
			isAvailable = new MiscMgmtController().isPokerNickNameAvailable(nickName, Short.parseShort(alaisId));
			data.put("status", isAvailable?200:400);
		}catch(PMSException pe){
			pe.printStackTrace();
			data.put("status",pe.getErrorCode());
			data.put("message", pe.getMessage());
		}catch(Exception e){
			data.put("status", 400);
		}
		
		response.getWriter().write(new Gson().toJson(data));
		Log.info("isPokerNickNameAvailable::"+isAvailable);
	}
	
	public void updatePokerNickName() throws IOException{
		Log.info("updatePokerNickName::started");
		Map<String, Object> data = new HashMap<>();
		boolean success =false;
		try{
			success = new MiscMgmtController().updatePokerNickName(userName, nickName, Short.parseShort(domainsId),Short.parseShort(alaisId));
		}catch(PMSException pe){
			pe.printStackTrace();
			data.put("status",pe.getErrorCode());
			data.put("message", pe.getMessage());
		}catch(Exception e){
			data.put("status", 400);
		}
		
		response.getWriter().write(new Gson().toJson(data));
		Log.info("updatePokerNickName::finished success:"+success);
	}


	public String getVersion_type() {
		return version_type;
	}

	public void setVersion_type(String version_type) {
		this.version_type = version_type;
	}

	public String getIpSearch() {
		return ipSearch;
	}

	public void setIpSearch(String ipSearch) {
		this.ipSearch = ipSearch;
	}

	public Map<Integer, String> getIpAddresses() {
		return ipAddresses;
	}

	public void setIpAddresses(Map<Integer, String> ipAddresses) {
		this.ipAddresses = ipAddresses;
	}

	public double[] getExchangeRate() {
		return exchangeRate;
	}

	public void setExchangeRate(double[] exchangeRate) {
		this.exchangeRate = exchangeRate;
	}

	public String[] getStatus() {
		return status;
	}

	public void setStatus(String[] status) {
		this.status = status;
	}

	public String[] getLabelValues() {
		return labelValues;
	}

	public void setLabelValues(String[] labelValues) {
		this.labelValues = labelValues;
	}

	public int getNativeId() {
		return nativeId;
	}

	public void setNativeId(int nativeId) {
		this.nativeId = nativeId;
	}

	public Map<Integer, List<CurrencyConversionDefBean>> getCurrencyConBean() {
		return currencyConBean;
	}

	public void setCurrencyConBean(
			Map<Integer, List<CurrencyConversionDefBean>> currencyConBean) {
		this.currencyConBean = currencyConBean;
	}

	public String getNativeCurrencyId() {
		return nativeCurrencyId;
	}

	public void setNativeCurrencyId(String nativeCurrencyId) {
		this.nativeCurrencyId = nativeCurrencyId;
	}

	public List<String> getDomainIpList() {
		return domainIpList;
	}

	public void setDomainIpList(List<String> domainIpList) {
		this.domainIpList = domainIpList;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getDomainsId() {
		return domainsId;
	}

	public void setDomainsId(String domainsId) {
		this.domainsId = domainsId;
	}

	public String getAlaisId() {
		return alaisId;
	}

	public void setAlaisId(String alaisId) {
		this.alaisId = alaisId;
	}

	public String getOs() {
		return os;
	}

	public void setOs(String os) {
		this.os = os;
	}

	public String getAppType() {
		return appType;
	}

	public void setAppType(String appType) {
		this.appType = appType;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getVersionCode() {
		return versionCode;
	}

	public void setVersionCode(String versionCode) {
		this.versionCode = versionCode;
	}

	public String getMandatory() {
		return mandatory;
	}

	public void setMandatory(String mandatory) {
		this.mandatory = mandatory;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public List<StGenAppVersionDetails> getAppList() {
		return appList;
	}

	public void setAppList(List<StGenAppVersionDetails> appList) {
		this.appList = appList;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getAppStatus() {
		return appStatus;
	}

	public void setAppStatus(String appStatus) {
		this.appStatus = appStatus;
	}

	public Long getAppVerId() {
		return appVerId;
	}

	public void setAppVerId(Long appVerId) {
		this.appVerId = appVerId;
	}

	public boolean isPushAppToAll() {
		return pushAppToAll;
	}

	public void setPushAppToAll(boolean pushAppToAll) {
		this.pushAppToAll = pushAppToAll;
	}

	public Long getAltAppId() {
		return altAppId;
	}

	public void setAltAppId(Long altAppId) {
		this.altAppId = altAppId;
	}

	public List<String> getOsList() {
		return osList;
	}

	public void setOsList(List<String> osList) {
		this.osList = osList;
	}

	public String getOldAppVer() {
		return oldAppVer;
	}

	public void setOldAppVer(String oldAppVer) {
		this.oldAppVer = oldAppVer;
	}
	public boolean isCashAppExists() {
		return cashAppExists;
	}

	public void setCashAppExists(boolean cashAppExists) {
		this.cashAppExists = cashAppExists;
	}

	public boolean isFreeAppExists() {
		return freeAppExists;
	}

	public void setFreeAppExists(boolean freeAppExists) {
		this.freeAppExists = freeAppExists;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
}
*/