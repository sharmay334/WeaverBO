/*
 * @Author : Nitish Bansal
 * @Class : SubmitTag
 * @Desc: To create custom struts attribute .
 * @attr: ajaxAction,target,check
 * 
 */
package com.stpl.pms.struts.common.ui;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.components.Component;

import com.opensymphony.xwork2.util.ValueStack;
import com.stpl.pms.struts.common.component.Submit;


public class SubmitTag extends org.apache.struts2.views.jsp.ui.SubmitTag{
	
	private static final long serialVersionUID = 1L;
	protected String ajaxAction;
	protected String target;
	protected String ajaxParam;
	public Component getBean(ValueStack stack, HttpServletRequest req, HttpServletResponse res) {
    	return new Submit(stack, req, res);
    }
	protected void populateParams() {
        super.populateParams();
        Submit submit = ((Submit) component);
        submit.setAjaxAction(ajaxAction);
        submit.setTarget(target);
        submit.setAjaxParam(ajaxParam);
	}
	public void setAjaxAction(String ajaxAction) {
    	this.ajaxAction = ajaxAction;
    }
    public void setTarget(String target) {
    	this.target = target;
    }
    public void setAjaxParam(String ajaxParam) {
    	this.ajaxParam = ajaxParam;
    }
}
