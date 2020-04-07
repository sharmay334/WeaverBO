package com.stpl.pms.struts.common;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionSupport;
import com.stpl.pms.controller.commonMethods.CommonMethodController;
import com.stpl.pms.controller.rm.RoleMgmtController;
import com.stpl.pms.exception.PMSException;
import com.stpl.pms.javabeans.CountryBean;
import com.stpl.pms.javabeans.CurrencyBean;
import com.stpl.pms.javabeans.LanguageBean;
import com.stpl.pms.javabeans.LoginBean;
import com.stpl.pms.javabeans.PrivFunctionBean;
import com.stpl.pms.javabeans.UserInfoBean;
import com.stpl.pms.javabeans.VipLevelMasterBean;

public class BaseActionSupport extends ActionSupport implements
		ServletRequestAware, ServletResponseAware {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(BaseActionSupport.class);
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected UserInfoBean userInfoBean;
	protected long onlinePlayerCount;
	protected short domainId;
	protected String domainName;
	protected Map<Short, String> domainMap;
	protected Map<Short, String> aliasMap;
	protected short bydefaultSelectedDomain;
	protected List<CurrencyBean> currencyBeanList;
	protected List<CountryBean> countryBeanList;
	protected List<VipLevelMasterBean> vipLevelBeanList;
	protected List<LanguageBean> languageBeanList;
	protected String menuStr;
	protected Map<String, PrivFunctionBean> actionPrivFunctionMap;
	protected String aliasName;
	protected short aliasId;

	public void checkUserLogin(HttpSession session) throws PMSException {
		CommonMethodController controller = CommonMethodController.getInstance();
		userInfoBean = controller.checkBoUserLogin(session.getId());
		UserInfoBean impersonateeBean=(UserInfoBean)session.getAttribute("impersionateeBean");
		
	LoginBean loginBean=null;
//	String userCachedName = null;
	/*if(impersonateeBean != null)
		
		userCachedName = impersonateeBean!= null?""+impersonateeBean.getUserName()+"_"+impersonateeBean.getUserId():null;
	else	
		userCachedName = userInfoBean!= null?""+userInfoBean.getUserName()+"_"+userInfoBean.getUserId():null;*/
		
		/*Cache cache = CacheManager.getInstance().getCache("userLoginBean");
	if(cache.get(userCachedName) != null){
		loginBean = (LoginBean) cache.get(userCachedName).getObjectValue();*/
//		if(impersonateeBean!=null)
////			duplicateBoUser(userInfoBean, impersonateeBean);
//	}
//	else{
		if(impersonateeBean!=null){
			loginBean=new RoleMgmtController().fetchActivePriv("WEB", impersonateeBean);
			duplicateBoUser(userInfoBean, impersonateeBean);
		}else
			loginBean=new RoleMgmtController().fetchActivePriv("WEB", userInfoBean);
		/*Element e = new Element(userCachedName,loginBean);
		cache.put(e);
	}*/
		menuStr = loginBean.getMenuStr();
		ResourceBundle bundle;
		if(session.getAttribute("localeValue")==null) {
			bundle = ResourceBundle.getBundle("global",new Locale("en"));
		}
		else
			 bundle = ResourceBundle.getBundle("global",new Locale(session.getAttribute("localeValue").toString()));
		
		String searchUser = bundle.getString("global.scratchWeaver.SearchUser");
		String subUsrReg = bundle.getString("global.scratchWeaver.subuserreg");
		String editSubUsrReg = bundle.getString("global.scratchWeaver.edituserpriv");
		String netAccessmgmt = bundle.getString("global.scratchWeaver.networkaccess");
		
		String searchGame = bundle.getString("global.scratchWeaver.searchgame");
		String uploadnewgame = bundle.getString("global.scratchWeaver.uploadgame");
		String gentestrdy = bundle.getString("global.scratchWeaver.gentest");
		String genprintrdy = bundle.getString("global.scratchWeaver.genprint");
		
		
		menuStr = menuStr.replaceAll("Search User",searchUser);
		menuStr = menuStr.replaceAll("Sub User Registration",subUsrReg);
		menuStr = menuStr.replaceAll("Edit Sub User Privileges",editSubUsrReg);
		menuStr = menuStr.replaceAll("Network Access Management",netAccessmgmt);
		
		menuStr = menuStr.replaceAll("Search Games",searchGame);
		menuStr = menuStr.replaceAll("Upload New Game",uploadnewgame);
		menuStr = menuStr.replaceAll("Generate Test Ready Data",gentestrdy);
		menuStr = menuStr.replaceAll("Generate Print Ready Data",genprintrdy);
		
		session.setAttribute("menuStr", menuStr);

		
		actionPrivFunctionMap=loginBean.getActionPrivFunctionMap();
		if(session.getAttribute("ACTIVE_SERVICE") == null)
			session.setAttribute("ACTIVE_SERVICE", "MGMT");
		short domainId = userInfoBean != null ? userInfoBean.getDomainId() : 0;
		onlinePlayerCount = CommonMethodController.getInstance()
				.fetchOnlinePlayers(domainId);
	}

	private void duplicateBoUser(UserInfoBean to,UserInfoBean from) {
		to.setUserId(from.getUserId());
		to.setIsRoleHeadUser(from.getIsRoleHeadUser());
		to.setUserType(from.getUserType());
		to.setRoleId(from.getRoleId());
		to.setDomainId(from.getDomainId());
	}
	public void defaulValues(String reqProp) {
		logger.info("--Default Values--");
		try {
			CommonMethodController controller = CommonMethodController
					.getInstance();
			if("DOMAIN".equals(userInfoBean.getUserType())){
				domainId = userInfoBean.getDomainId();
				aliasMap = controller.fetchAliasMap(domainId);
			}
			if (domainId > 1) {
				domainName = controller.getDmProperty(domainId, "domainName");
				bydefaultSelectedDomain = domainId;
				if (reqProp != null) {
					List<String> list = Arrays.asList(reqProp.split(","));
					if (list.contains("currencyList")) {
						currencyBeanList = new ArrayList<CurrencyBean>(
								controller.fetchActiveDmCurrMap(domainId)
										.values());
					}
					if (list.contains("countryList")) {
						countryBeanList = controller
								.fetchActiveCountryList(domainId);
					}
					if (list.contains("vipList")) {
						vipLevelBeanList = controller.fetchDomainVipLevelList(
								domainId, "");
					}
					if (list.contains("languageList")) {
						languageBeanList = new ArrayList<LanguageBean>(
								controller.fetchDmActiveLangMap(domainId)
										.values());
					}
				}
			} else {
				domainMap = controller.getDomainIdMap();
				bydefaultSelectedDomain = Short.valueOf(controller
						.fetchSystemProperties("BYDEFAULT_SELECTED_DOMAIN"));
				aliasMap = controller.fetchAliasMap(bydefaultSelectedDomain);
			}
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;

	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;

	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setUserInfoBean(UserInfoBean userInfoBean) {
		this.userInfoBean = userInfoBean;
	}

	public UserInfoBean getUserInfoBean() {
		return userInfoBean;
	}

	public void setOnlinePlayerCount(long onlinePlayerCount) {
		this.onlinePlayerCount = onlinePlayerCount;
	}

	public long getOnlinePlayerCount() {
		return onlinePlayerCount;
	}

	public short getDomainId() {
		return domainId;
	}

	public void setDomainId(short domainId) {
		this.domainId = domainId;
	}

	public String getDomainName() {
		return domainName;
	}

	public void setDomainName(String domainName) {
		this.domainName = domainName;
	}

	public Map<Short, String> getDomainMap() {
		return domainMap;
	}

	public void setDomainMap(Map<Short, String> domainMap) {
		this.domainMap = domainMap;
	}

	public short getBydefaultSelectedDomain() {
		return bydefaultSelectedDomain;
	}

	public void setBydefaultSelectedDomain(short bydefaultSelectedDomain) {
		this.bydefaultSelectedDomain = bydefaultSelectedDomain;
	}

	public List<CurrencyBean> getCurrencyBeanList() {
		return currencyBeanList;
	}

	public void setCurrencyBeanList(List<CurrencyBean> currencyBeanList) {
		this.currencyBeanList = currencyBeanList;
	}

	public List<CountryBean> getCountryBeanList() {
		return countryBeanList;
	}

	public void setCountryBeanList(List<CountryBean> countryBeanList) {
		this.countryBeanList = countryBeanList;
	}

	public List<VipLevelMasterBean> getVipLevelBeanList() {
		return vipLevelBeanList;
	}

	public void setVipLevelBeanList(List<VipLevelMasterBean> vipLevelBeanList) {
		this.vipLevelBeanList = vipLevelBeanList;
	}

	public List<LanguageBean> getLanguageBeanList() {
		return languageBeanList;
	}

	public void setLanguageBeanList(List<LanguageBean> languageBeanList) {
		this.languageBeanList = languageBeanList;
	}
	
	public String getMenuStr() {
		return menuStr;
	}

	public void setMenuStr(String menuStr) {
		this.menuStr = menuStr;
	}
	public Map<String, PrivFunctionBean> getActionPrivFunctionMap() {
		return actionPrivFunctionMap;
	}

	public void setActionPrivFunctionMap(
			Map<String, PrivFunctionBean> actionPrivFunctionMap) {
		this.actionPrivFunctionMap = actionPrivFunctionMap;
	}



	public String getAliasName() {
		return aliasName;
	}

	public void setAliasName(String aliasName) {
		this.aliasName = aliasName;
	}

	public Map<Short, String> getAliasMap() {
		return aliasMap;
	}

	public void setAliasMap(Map<Short, String> aliasMap) {
		this.aliasMap = aliasMap;
	}

	public short getAliasId() {
		return aliasId;
	}

	public void setAliasId(short aliasId) {
		this.aliasId = aliasId;
	}
	
	
}
