/*
 * @Author : Nitish Bansal
 * @Class : PasswordTag
 * @Desc: To create custom struts attribute .
 * @attr: errorMassage,action,min,max
 * 
 */
package com.stpl.pms.struts.common.ui;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.components.Component;

import com.opensymphony.xwork2.util.ValueStack;
import com.stpl.pms.struts.common.component.Password;

public class PasswordTag extends org.apache.struts2.views.jsp.ui.PasswordTag {
	 private static final long serialVersionUID = 5811285953670562288L;
	    protected String errorMassage;
	    protected String pattern;
	    protected String min;
	    protected String max;
	    public Component getBean(ValueStack stack, HttpServletRequest req, HttpServletResponse res) {
	    	return new Password(stack, req, res);
	    }

	    protected void populateParams() {
	        super.populateParams();
	        Password password = ((Password) component);
	        password.setErrorMassage(errorMassage);
	        password.setPattern(pattern);
	        password.setMin(min);
	        password.setMax(max);
	    }

	    public void setErrorMassage(String errorMassage) {
	    	this.errorMassage = errorMassage;
	    }
	    public void setPattern(String pattern) {
	    	this.pattern = pattern;
	    }
	    public void setMin(String min) {
	    	this.min = min;
	    }
	    public void setMax(String max) {
	    	this.max = max;
	    }
}
