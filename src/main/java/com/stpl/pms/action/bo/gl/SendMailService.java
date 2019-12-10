package com.stpl.pms.action.bo.gl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.um.UserMgmtController;
import com.stpl.pms.hibernate.mapping.StGenSmsEmailProviderMaster;
import com.stpl.pms.hibernate.mapping.StRmBoUserInfo;
import com.stpl.pms.javabeans.UserInfoBean;
import com.stpl.pms.mail.services.SMTPMailService;
import com.stpl.pms.struts.common.BaseActionSupport;

@SuppressWarnings("serial")
public class SendMailService extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private String emailType;
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
	
	public void returnMailServiceResult()
	{
		try{
			if(userInfoBean.getParentUserId()!=0 || userInfoBean.getParentUserId()==0){
				UserMgmtController service = new UserMgmtController();
				List<StRmBoUserInfo> stRmBoUserInfo = service.getUserInformation(userInfoBean.getUserId());
				
				service.editBOUserDetails(userInfoBean.getUserId(), stRmBoUserInfo.get(0).getEmailId(), stRmBoUserInfo.get(0).getPhoneNum(), "downloadCase", null,emailType);
					
			}
			
			
		}catch(Exception e){e.printStackTrace();}
	}
	public void returnMailServiceResult(String zipPassword,UserInfoBean userInfoBean)
	{
		try{
			
			UserMgmtController service = new UserMgmtController();
			List<StRmBoUserInfo> stRmBoUserInfo = service.getUserInformation(userInfoBean.getUserId());
			
			service.editBOUserDetails(userInfoBean.getUserId(), stRmBoUserInfo.get(0).getEmailId(), stRmBoUserInfo.get(0).getPhoneNum(), "printCase", null,"PRINT_TICKET",userInfoBean);
			
		}catch(Exception e){e.printStackTrace();}
	}
	public String getEmailType() {
		return emailType;
	}
	public void setEmailType(String emailType) {
		this.emailType = emailType;
	}
	
}
