package com.stpl.pms.action.bo.misc;

import java.util.List;

import org.apache.log4j.Logger;

//import com.google.gson.Gson;
//import com.stpl.pms.controller.misc.AffilateAdCompanyController;
//import com.stpl.pms.exception.PMSException;
//import com.stpl.pms.javabeans.AdCompanyInfoBean;
import com.stpl.pms.struts.common.BaseActionSupport;

public class AffilateAdCompanyAction extends BaseActionSupport{
}
/*
	private static final Logger logger = Logger
			.getLogger(AffilateAdCompanyAction.class);
	private static final long serialVersionUID = 1L;
	private short domainId;
	private short aliasId;
	private String affiliateName;
	private String offerId;
	private String affilateOption;
	private double rakePercentage;
	private String status;
	private long affilateInfoId;
	
	
	public String saveAffilateAdCompany(){
		
		logger.info(" Call addAffilateAdCompany Start");
		try{
			new AffilateAdCompanyController().addAffilateAdCompany(aliasId, domainId, affiliateName, offerId, affilateOption, rakePercentage);
			request.setAttribute("msg", "Affilate Ad Company Info Saved Successfully");
		} catch (PMSException e) {
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			return "exception";
		}
		logger.info(" Call addAffilateAdCompany End");
		return SUCCESS;
		
	}
	
	public void getAffilateName(){
		logger.info("Call  getAffilateName Start");
		try{
			List <String> dataList =new AffilateAdCompanyController().
					searchAdCompanyNameDomainAliasWise(aliasId, domainId);
			
			response.getWriter().write(
					new Gson().toJson(dataList));
		}catch (Exception e) {
			addActionError("Some internal error.");		
		}	
		logger.info("Call  getAffilateName End");
	}
	
	
	public void getOfferIdForAffilateName(){
		logger.info("Call  getOfferIdForAffilateName Start");
		try{
			List <String> dataList =new AffilateAdCompanyController().
					searchAdCompanyOrderIdDomainAliasWise(aliasId, domainId,affiliateName);
			
			response.getWriter().write(
					new Gson().toJson(dataList));
		}catch (Exception e) {
			addActionError("Some internal error.");		
		}	
		logger.info("Call  getOfferIdForAffilateName End");
	}
	
		
	public void getAffilateInfo(){
		logger.info("Call  getAffilateInfo Start");
		try{
			AdCompanyInfoBean bean =new AffilateAdCompanyController().
					searchAdCompany(aliasId, domainId, affiliateName, offerId);
			
			response.getWriter().write(
					new Gson().toJson(bean));
		}catch (Exception e) {
			addActionError("Some internal error.");		
		}	
		logger.info("Call  getAffilateInfo End");
	}
	
	public String editAffilateAdCompany(){
		
		logger.info(" Call editAffilateAdCompany Start");
		try{
			new AffilateAdCompanyController().updateAffilateAdCompany(affilateInfoId, rakePercentage, 
					status,affilateOption);
			request.setAttribute("msg", "Affilate Ad Company Info Edit Successfully");
		} catch (PMSException e) {
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			return "exception";
		}
		logger.info(" Call editAffilateAdCompany End");
		return SUCCESS;
		
	} 
	
	
	public short getDomainId() {
		return domainId;
	}
	public void setDomainId(short domainId) {
		this.domainId = domainId;
	}
	public short getAliasId() {
		return aliasId;
	}
	public void setAliasId(short aliasId) {
		this.aliasId = aliasId;
	}
	public String getAffiliateName() {
		return affiliateName;
	}
	public void setAffiliateName(String affiliateName) {
		this.affiliateName = affiliateName;
	}
	
	public String getOfferId() {
		return offerId;
	}
	public void setOfferId(String offerId) {
		this.offerId = offerId;
	}
	public String getAffilateOption() {
		return affilateOption;
	}
	public void setAffilateOption(String affilateOption) {
		this.affilateOption = affilateOption;
	}
	public double getRakePercentage() {
		return rakePercentage;
	}
	public void setRakePercentage(double rakePercentage) {
		this.rakePercentage = rakePercentage;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

	public long getAffilateInfoId() {
		return affilateInfoId;
	}

	public void setAffilateInfoId(long affilateInfoId) {
		this.affilateInfoId = affilateInfoId;
	}
	
	
}
*/