package com.stpl.pms.action.bo.lm;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.struts.common.BaseActionSupport;

@SuppressWarnings("serial")
public class LoadPropertiesFile extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private String localeValue;
	
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
	public String getLocaleValue() {
		return localeValue;
	}
	public void setLocaleValue(String localeValue) {
		this.localeValue = localeValue;
	}
	
	public String readPropertyFile(){
		try{
			Properties prop = new Properties();
			InputStream input = null;
			if(localeValue.equals("vi"))
			input = new FileInputStream("content_vi.properties");
			else
				input = new FileInputStream("content_en.properties");
			prop.load(input);
			System.out.println(prop.getProperty("content.login.username"));
			System.out.println(prop.getProperty("content.login.password"));
			
			return SUCCESS;
		}catch(Exception e){e.printStackTrace();}
		return ERROR;
	}

	
}
