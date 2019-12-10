package com.stpl.pms.struts.common.component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.views.annotations.StrutsTag;
import org.apache.struts2.views.annotations.StrutsTagAttribute;

import com.opensymphony.xwork2.util.ValueStack;
@StrutsTag(name = "textarea", tldTagClass = "com.stpl.pms.struts.common.ui.TextareaTag", description = "Render an HTML input field of type text",allowDynamicAttributes=true)
public class TextArea extends org.apache.struts2.components.TextArea{
	 protected String errorMassage;
	 protected String pattern;
	    public TextArea(ValueStack stack, HttpServletRequest request, HttpServletResponse response) {
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
	    
	    }

	    @StrutsTagAttribute(description = "It set data, the element is use to set Div|massages" )
	    public void setErrorMassage(String errorMassage) {
	        this.errorMassage = errorMassage;
	    }
	    
	    public String getErrorMassage(){
	    	return errorMassage;
	    } 
	    public void setPattern(String pattern) {
	        this.pattern = pattern;
	    }
	    
	    public String getPattern(){
	    	return pattern;
	    }
}
