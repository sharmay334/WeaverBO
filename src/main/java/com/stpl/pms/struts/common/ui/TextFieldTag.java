/*
 * @Author : Nitish Bansal
 * @Class : TextFieldTag
 * @Desc: To create custom struts attribute .
 * @attr: errorMassage,action,min,max,action,minLength
 * 
 */
package com.stpl.pms.struts.common.ui;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.components.Component;

import com.opensymphony.xwork2.util.ValueStack;
import com.stpl.pms.struts.common.component.TextField;

/**
 * Customisation of Struts2 TextFieldTag (viewmode attribute added)
 * @see TextField
 */
public class TextFieldTag extends org.apache.struts2.views.jsp.ui.TextFieldTag {
	
    private static final long serialVersionUID = 5811285953670562288L;
    protected String errorMassage;
    protected String pattern;
    protected String min;
    protected String max;
    protected String action;
    protected String minLength;
    protected String checkRequired;
    protected String patternOn;
    protected String ajaxParam;
    public Component getBean(ValueStack stack, HttpServletRequest req, HttpServletResponse res) {
    	return new TextField(stack, req, res);
    }

    protected void populateParams() {
        super.populateParams();
        TextField textField = ((TextField) component);
        textField.setErrorMassage(errorMassage);
        textField.setPattern(pattern);
        textField.setMin(min);
        textField.setMax(max);
        textField.setAction(action);
        textField.setMinLength(minLength);
        textField.setCheckRequired(checkRequired);
        textField.setPatternOn(patternOn);
        textField.setAjaxParam(ajaxParam);
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
    public void setAction(String action) {
    	this.action = action;
    }
    public void setMinLength(String minLength) {
    	this.minLength = minLength;
    }
    public void setCheckRequired(String checkRequired) {
    	this.checkRequired = checkRequired;
    }
    public void setPatternOn(String patternOn) {
    	this.patternOn = patternOn;
    }
    public void setAjaxParam(String ajaxParam) {
    	this.ajaxParam = ajaxParam;
    }
   
}
