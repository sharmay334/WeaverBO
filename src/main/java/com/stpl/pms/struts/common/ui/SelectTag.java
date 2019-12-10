package com.stpl.pms.struts.common.ui;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.components.Component;

import com.opensymphony.xwork2.util.ValueStack;
//import com.stpl.pms.struts.common.component.Button;
import com.stpl.pms.struts.common.component.Select;

public class SelectTag extends org.apache.struts2.views.jsp.ui.SelectTag {
	 private static final long serialVersionUID = 2179281109958301343L;
		protected String ajaxAction;
		protected String ajaxParam;
		protected String target;
		public Component getBean(ValueStack stack, HttpServletRequest req,
				HttpServletResponse res) {
			return new Select(stack, req, res);
		}

		protected void populateParams() {
			super.populateParams();
			Select select = (Select) component;
			select.setThrowExceptionOnNullValueAttribute(false);
			select.setAjaxAction(ajaxAction);
			select.setTarget(target);
			select.setAjaxParam(ajaxParam);
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
