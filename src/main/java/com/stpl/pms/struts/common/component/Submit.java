/*
 * @Author : Nitish Bansal
 * @Class : Submit
 * @Desc: To create custom struts attribute .
 * @attr: target,ajaxAction
 * 
 */
package com.stpl.pms.struts.common.component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.views.annotations.StrutsTag;
import org.apache.struts2.views.annotations.StrutsTagAttribute;

import com.opensymphony.xwork2.util.ValueStack;

@StrutsTag(name = "submit", tldTagClass = "com.stpl.pms.struts.common.ui.SubmitTag", description = "Render an HTML input field of type text", allowDynamicAttributes = true)
public class Submit extends org.apache.struts2.components.Submit {
	protected String ajaxAction;
	protected String target;
	protected String ajaxParam;

	public Submit(ValueStack stack, HttpServletRequest request,
			HttpServletResponse response) {
		super(stack, request, response);
	}

	public void evaluateExtraParams() {
		super.evaluateExtraParams();
		if (ajaxAction != null) {
			// addParameter(expr, getViewmode());
			addParameter("ajaxAction", findString(ajaxAction));
		}
		if (target != null) {
			// addParameter(expr, getViewmode());
			addParameter("target", findString(target));
		}
		if (ajaxParam != null) {
			// addParameter(expr, getViewmode());
			addParameter("ajaxParam", findString(ajaxParam));
		}
//		final Form formAttr = (Form) findAncestor(Form.class);
	}

	@StrutsTagAttribute(description = "It set the action for ajax request")
	public void setAjaxAction(String ajaxAction) {
		this.ajaxAction = ajaxAction;
	}

	public String getAjaxAction() {
		return ajaxAction;
	}

	@StrutsTagAttribute(description = "It set the action for ajax request")
	public void setTarget(String target) {
		this.target = target;
	}

	public String getTarget() {
		return target;
	}

	public void setAjaxParam(String ajaxParam) {
		this.ajaxParam = ajaxParam;
	}

	public String getAjaxParam() {
		return ajaxParam;
	}
}
