/*
 * @Author : Nitish Bansal
 * @Class : CheckboxTag
 * @Desc: To create custom struts attribute .
 * @attr: errorMassage,action
 * 
 */
package com.stpl.pms.struts.common.ui;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.components.Component;

import com.opensymphony.xwork2.util.ValueStack;
import com.stpl.pms.struts.common.component.Checkbox;

public class CheckboxTag extends org.apache.struts2.views.jsp.ui.CheckboxTag{
	private static final long serialVersionUID = 5811285953670562288L;
    protected String errorMassage;
    protected String action;
    
    public Component getBean(ValueStack stack, HttpServletRequest req, HttpServletResponse res) {
    	return new Checkbox(stack, req, res);
    }

    protected void populateParams() {
        super.populateParams();
        Checkbox checkBox = ((Checkbox) component);
        checkBox.setErrorMassage(errorMassage);
        checkBox.setAction(action);
    }

    public void setErrorMassage(String errorMassage) {
    	this.errorMassage = errorMassage;
    }
    public void setAction(String action) {
    	this.action = action;
    }

}
