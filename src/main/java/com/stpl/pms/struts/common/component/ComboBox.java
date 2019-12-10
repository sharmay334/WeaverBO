/*
 * @Author : Nitish Bansal
 * @Class : ComboBox
 * @Desc: To create custom struts attribute .
 * @attr: errorMassage,action
 * 
 */
package com.stpl.pms.struts.common.component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.views.annotations.StrutsTag;
import org.apache.struts2.views.annotations.StrutsTagAttribute;

import com.opensymphony.xwork2.util.ValueStack;

@StrutsTag(name = "combobox", tldTagClass = "com.stpl.pms.struts.common.ui.ComboBoxTag", description = "Render an HTML input field of type text",allowDynamicAttributes=true)
public class ComboBox extends org.apache.struts2.components.ComboBox{
	 protected String errorMassage;
	 protected String action;

	    public ComboBox(ValueStack stack, HttpServletRequest request, HttpServletResponse response) {
	        super(stack, request, response);
	    }

	    public void evaluateExtraParams() {
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
