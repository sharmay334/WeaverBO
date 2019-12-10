/*
 * @Author : Nitish Bansal
 * @Class : Password
 * @Desc: To create custom struts attribute .
 * @attr: errorMassage,action,min,max
 * 
 */
package com.stpl.pms.struts.common.component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.views.annotations.StrutsTag;
import org.apache.struts2.views.annotations.StrutsTagAttribute;

import com.opensymphony.xwork2.util.ValueStack;

@StrutsTag(name = "password", tldTagClass = "com.stpl.pms.struts.common.ui.PasswordTag", description = "Render an HTML input field of type text",allowDynamicAttributes=true)
public class Password extends org.apache.struts2.components.Password{
	 protected String errorMassage;
	 protected String pattern;
	    protected String min;
	    protected String max;
	    public Password(ValueStack stack, HttpServletRequest request, HttpServletResponse response) {
	        super(stack, request, response);
	    }

	    public void evaluateExtraParams() {
	        super.evaluateExtraParams();
	        if (errorMassage!=null) {
	        	//addParameter(expr, getViewmode());
	        	addParameter("errorMassage", findString(errorMassage));
	        }
	        if (pattern!=null) {
	        	//addParameter(expr, getViewmode());
	        	addParameter("pattern", findString(pattern));
	        }
	        if (min!=null) {
	        	//addParameter(expr, getViewmode());
	        	addParameter("min", findString(min));
	        }
	        if (max!=null) {
	        	//addParameter(expr, getViewmode());
	        	addParameter("max", findString(max));
	        }
	    }

	    @StrutsTagAttribute(description = "It set data, the element is use to set Div|massages" )
	    public void setErrorMassage(String errorMassage) {
	        this.errorMassage = errorMassage;
	    }
	    
	    public String getErrorMassage(){
	    	return errorMassage;
	    }
	    @StrutsTagAttribute(description = "It set characters in which data will show, the element is use to set pattern" )
	    public void setPattern(String pattern) {
	        this.pattern = pattern;
	    }
	    
	    public String getPattern(){
	    	return pattern;
	    }
	    @StrutsTagAttribute(description="HTML minlength attribute", type="Integer")
	    public void setMin(String min) {
	        this.min = min;
	    }
	    
	    public String getMin(){
	    	return min;
	    }
	    @StrutsTagAttribute(description="HTML maxlength attribute", type="Integer")
	    public void setMax(String max) {
	        this.max = max;
	    }
	    
	    public String getMax(){
	    	return max;
	    }
}
