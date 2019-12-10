/*
 * @Author : Nitish Bansal
 * @Class : TextareaTag
 * @Desc: To create custom struts attribute .
 * @attr: errorMassage,action
 * 
 */
package com.stpl.pms.struts.common.ui;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.components.Component;

import com.opensymphony.xwork2.util.ValueStack;
import com.stpl.pms.struts.common.component.TextArea;

public class TextareaTag extends org.apache.struts2.views.jsp.ui.TextareaTag{
	private static final long serialVersionUID = 5811285953670562288L;
    protected String errorMassage;
    protected String pattern;
    
    public Component getBean(ValueStack stack, HttpServletRequest req, HttpServletResponse res) {
    	return new TextArea(stack, req, res);
    }

    protected void populateParams() {
        super.populateParams();
        TextArea textArea = ((TextArea) component);
        textArea.setErrorMassage(errorMassage);
        textArea.setPattern(pattern);
    }

    public void setErrorMassage(String errorMassage) {
    	this.errorMassage = errorMassage;
    }
    public void setPattern(String pattern) {
    	this.pattern = pattern;
    }
}
