/*
 * @Author : Nitish Bansal
 * @Class : ComboBoxTag
 * @Desc: To create custom struts attribute .
 * @attr: errorMassage,action
 * 
 */
package com.stpl.pms.struts.common.ui;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.components.Component;

import com.opensymphony.xwork2.util.ValueStack;
import com.stpl.pms.struts.common.component.ComboBox;

public class ComboBoxTag extends org.apache.struts2.views.jsp.ui.ComboBoxTag{
	private static final long serialVersionUID = 5811285953670562288L;
    protected String errorMassage;
    protected String action;
    
    public Component getBean(ValueStack stack, HttpServletRequest req, HttpServletResponse res) {
    	return new ComboBox(stack, req, res);
    }

    protected void populateParams() {
        super.populateParams();
        ComboBox comboBox = ((ComboBox) component);
        comboBox.setErrorMassage(errorMassage);
        comboBox.setAction(action);
    }

    public void setErrorMassage(String errorMassage) {
    	this.errorMassage = errorMassage;
    }
    public void setAction(String action) {
    	this.action = action;
    }
}
