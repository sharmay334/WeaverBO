/*
 * @Author : Nitish Bansal
 * @Class : Checkbox
 * @Desc: To create custom struts tag .
 * @attr: errorMassage,action
 * 
 */
package com.stpl.pms.struts.common.component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.views.annotations.StrutsTag;
import org.apache.struts2.views.annotations.StrutsTagAttribute;

import com.opensymphony.xwork2.util.ValueStack;

@StrutsTag(name = "checkbox", tldTagClass = "com.stpl.struts2.view.jsp.ui.CheckboxTag", description = "Render an HTML input field of type text",allowDynamicAttributes=true)
public class Checkbox extends org.apache.struts2.components.Checkbox{
	 protected String errorMassage;
	 protected String action;
	    public Checkbox(ValueStack stack, HttpServletRequest request, HttpServletResponse response) {
	        super(stack, request, response);
	    }

	    protected void evaluateExtraParams() {
	        super.evaluateExtraParams();
	        if (errorMassage!=null) {
	        	//addParameter(expr, getViewmode());
	        	addParameter("errorMassage", findString(errorMassage));
	        }
	        if (action!=null) {
	        	//addParameter(expr, getViewmode());
	        	addParameter("action", findString(action));
	        }
	    
	    }

	    @StrutsTagAttribute(description = "It set data, the element is use to set Div|massages" )
	    public void setErrorMassage(String errorMassage) {
	    	this.errorMassage = errorMassage;
	    }
	    
	    public String getErrorMassage(){
	    	return errorMassage;
	    }
	    @StrutsTagAttribute(description = "It set the action for ajax request" )
	    public void setAction(String action) {
	        this.action = action;
	    }
	    
	    public String getAction(){
	    	return action;
	    }
}
