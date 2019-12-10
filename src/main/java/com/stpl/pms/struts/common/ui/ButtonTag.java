/*
 * @Author : Nitish Bansal
 * @Class : ButtonTag
 * @Desc: To create custom struts tag name button.
 * 
 */

package com.stpl.pms.struts.common.ui;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.components.Component;

import com.opensymphony.xwork2.util.ValueStack;
import com.stpl.pms.struts.common.component.Button;

public class ButtonTag extends org.apache.struts2.views.jsp.ui.AbstractClosingTag {
	 private static final long serialVersionUID = 2179281109958301343L;
	protected String ajaxAction;
	protected String target;
	protected String ajaxParam;
	public Component getBean(ValueStack stack, HttpServletRequest req,
			HttpServletResponse res) {
		return new Button(stack, req, res);
	}

	protected void populateParams() {
		super.populateParams();
		Button button = (Button) component;
		button.setAjaxAction(ajaxAction);
		button.setTarget(target);
		button.setAjaxParam(ajaxParam);
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
