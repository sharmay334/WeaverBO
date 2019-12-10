package com.stpl.pms.struts.common.component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.views.annotations.StrutsTag;

import com.opensymphony.xwork2.util.ValueStack;

@StrutsTag(name = "Select", tldTagClass = "com.stpl.pms.struts.common.ui.SelectTag", description = "Render an HTML input field of type text",allowDynamicAttributes=true)
public class Select extends org.apache.struts2.components.Select{
	protected String ajaxAction;
	protected String ajaxParam;
	protected String target;
	public void evaluateExtraParams() {
		 super.evaluateExtraParams();
		if (ajaxAction != null) {
			addParameter("ajaxAction", findString(ajaxAction));
		}
		if (target != null) {
			addParameter("target", findString(target));
		}
		if (ajaxParam != null) {
			addParameter("ajaxParam", findString(ajaxParam));
		}
		
	}
	public Select(ValueStack stack, HttpServletRequest request, HttpServletResponse response) {
		super(stack, request, response);
	}
	 
	

	public void setAjaxAction(String ajaxAction) {
		this.ajaxAction = ajaxAction;
	}
	public void setAjaxParam(String ajaxParam) {
		this.ajaxParam = ajaxParam;
	}

	public void setTarget(String target) {
		this.target = target;
	}
}
