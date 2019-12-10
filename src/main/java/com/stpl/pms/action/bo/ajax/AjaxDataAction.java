package com.stpl.pms.action.bo.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.stpl.pms.controller.commonMethods.CommonMethodController;
import com.stpl.pms.exception.PMSException;
import com.stpl.pms.javabeans.AliasBean;
import com.stpl.pms.javabeans.CountryBean;
import com.stpl.pms.javabeans.CurrencyBean;
import com.stpl.pms.javabeans.LanguageBean;
import com.stpl.pms.javabeans.StateBean;
import com.stpl.pms.javabeans.VipLevelMasterBean;
import com.stpl.pms.struts.common.BaseActionSupport;

//import java.io.IOException;
//import java.io.PrintWriter;
//import java.lang.reflect.Type;
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpSession;
//
//import com.google.gson.Gson;
//import com.google.gson.reflect.TypeToken;
//import com.stpl.pms.controller.commonMethods.CommonMethodController;
//import com.stpl.pms.exception.PMSException;
//import com.stpl.pms.javabeans.AliasBean;
//import com.stpl.pms.javabeans.CountryBean;
//import com.stpl.pms.javabeans.CurrencyBean;
//import com.stpl.pms.javabeans.LanguageBean;
//import com.stpl.pms.javabeans.StateBean;
//import com.stpl.pms.javabeans.VipLevelMasterBean;
//import com.stpl.pms.struts.common.BaseActionSupport;

public class AjaxDataAction extends BaseActionSupport /*extends BaseActionSupport*/{


	private static final long serialVersionUID = 1L;
	private short domainId;
	private String jsonList;
	private String countryCode;
	private Integer countryId;
	private List<Object> dataList;
	private String vendorCode;
	private short aliasId;
	private String channelType;
	
	
//	public void fetchUnMappedPlayers() throws PMSException, IOException {
//		try {
//			response.getWriter().write(
//					new Gson().toJson(CommonMethodController.getInstance()
//							.fetchEventList(domainId,aliasId,channelType)));
//		}catch(PMSException e){
//			throw new PMSException(e.getErrorCode(),e.getErrorMessage());
//		}
//	}
	
	/**
	 * Event List in response
	 * @throws PMSException
	 * @throws IOException
	 */
	public void fetchEventList() throws PMSException, IOException{
		try {
			/*response.getWriter().write(
					new Gson().toJson(CommonMethodController.getInstance()
							.fetchEventList(domainId,aliasId,channelType)));*/
		}catch(Exception e){
//			throw new PMSException(,e.getErrorMessage());
		}
	}
	
	@SuppressWarnings("rawtypes")
	public void fetchCommonAjaxData(){
		PrintWriter out = null;
		String jsonMap = null;
		try{
			if(jsonList!=null && !"".equals(jsonList)){
				CommonMethodController controller = CommonMethodController.getInstance();
				Gson gson = new Gson();
				Map<String, List> map = new HashMap<>();
				Type dataType = new TypeToken<List<String>>() {
				}.getType();
				List<String> list = gson.fromJson(jsonList, dataType);
				if(list.contains("currencyList")){
					List<CurrencyBean> currencyList = new ArrayList<CurrencyBean>(controller.fetchActiveDmCurrMap(domainId).values());
					map.put("currencyList", currencyList);
				}
				if(list.contains("countryList")){
					List<CountryBean> countryList = controller.fetchActiveCountryList(domainId);
					map.put("countryList", countryList);
				}
				if(list.contains("vipList")){
					List<VipLevelMasterBean> vipList = controller.fetchDomainVipLevelList(domainId,"");
					map.put("vipList", vipList);
				}
				if(list.contains("languageList")){
					List<LanguageBean> languageList = new ArrayList<LanguageBean>(controller.fetchDmActiveLangMap(domainId).values());
					map.put("languageList", languageList);
				}
				if(countryId!=null && list.contains("stateList")){
					if(domainId > 0 && "BYDEFAULT".equals(controller.getDmProperty(domainId, "allowedStates"))) {
						domainId = 1;
					}
					List<StateBean> stateList = controller.fetchActiveStateList(domainId, countryId);
					map.put("stateList", stateList);
				}
				if(list.contains("aliasList")){
					List<AliasBean> aliasList = controller.fetchActiveAliasList(domainId);
					map.put("aliasList", aliasList);
				}
				if(list.contains("campaignList")){
					map.put("campaignList",controller.fetchCampaignMap(domainId, aliasId));
				}
				jsonMap = gson.toJson(map);
				out = response.getWriter();
				out.write(jsonMap);
			}
		}catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
		}catch (Exception e) {
			e.printStackTrace();
				addActionError("Some internal error.");
			}
		}
	
	public void fetchAlaisMap() {
		try {
			response.getWriter().write(
					new Gson().toJson(CommonMethodController.getInstance()
							.fetchAliasMap(domainId)));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void fetchGameMap(){
	try{
		response.getWriter().write(
				new Gson().toJson(CommonMethodController.getInstance()
						.fetchGameMap(domainId,aliasId)));
	}catch (Exception be) {
		be.printStackTrace();
	}
	}
	public void checkDomainVendorAvailable(){
		try {
			response.getWriter().write(
					new Gson().toJson(CommonMethodController.getInstance()
							.checkDomainVendorAvailable(domainId,vendorCode)));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@SuppressWarnings("unchecked")
	public String dataTableResult(){
		HttpSession session = request.getSession();
		List<Object> resultList =  (List<Object>) session.getAttribute("dataTableValue");
		session.removeAttribute("dataTableValue");
		if(resultList!=null)
			dataList = resultList;
		return SUCCESS;
	}

	public void setDomainId(short domainId) {
		this.domainId = domainId;
	}

	public short getDomainId() {
		return domainId;
	}

	public void setJsonList(String jsonList) {
		this.jsonList = jsonList;
	}

	public String getJsonList() {
		return jsonList;
	}
	public String getCountryCode() {
		return countryCode;
	}

	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}

	public List<Object> getDataList() {
		return dataList;
	}

	public void setDataList(List<Object> dataList) {
		this.dataList = dataList;
	}

	public Integer getCountryId() {
		return countryId;
	}

	public void setCountryId(Integer countryId) {
		this.countryId = countryId;
	}

	public String getVendorCode() {
		return vendorCode;
	}

	public void setVendorCode(String vendorCode) {
		this.vendorCode = vendorCode;
	}

	public short getAliasId() {
		return aliasId;
	}

	public void setAliasId(short aliasId) {
		this.aliasId = aliasId;
	}

	public String getChannelType() {
		return channelType;
	}

	public void setChannelType(String channelType) {
		this.channelType = channelType;
	}
}
