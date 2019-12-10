package com.stpl.pms.action.bo.lm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.lm.DiskSpaceController;
import com.stpl.pms.struts.common.BaseActionSupport;

@SuppressWarnings("serial")
public class DiskStorageMgmt extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
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
	
	public void returnDiskSpace(){
		
		try{
			/*
			 * Double percentage=0.0; DiskSpaceController diskSpaceController = new
			 * DiskSpaceController(); percentage = diskSpaceController.getDiskSpace();
			 * if(percentage.intValue()>80){ servletResponse.getWriter().write("error"); }
			 * else if(percentage.intValue()>50){
			 * servletResponse.getWriter().write("warning"); } else{
			 * servletResponse.getWriter().write("success"); }
			 */
			servletResponse.getWriter().write("success");
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}
}
