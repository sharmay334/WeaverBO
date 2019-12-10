/*
 * @Author : Nitish Bansal
 * @Class : Button
 * @Desc: To create custom struts tag .
 * @attr: target,ajaxAction
 * 
 */
package com.stpl.pms.struts.common.component;

import java.io.Writer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.views.annotations.StrutsTag;

import com.opensymphony.xwork2.util.ValueStack;

@StrutsTag(name = "button", tldTagClass = "com.stpl.pms.struts.common.ui.ButtonTag", description = "Render an HTML input field of type text", allowDynamicAttributes = true)
public class Button extends org.apache.struts2.components.FormButton {

	private static final Logger log=Logger.getLogger(Button.class);
	protected String ajaxAction;
	protected String target;
	protected String ajaxParam;
	final public static String OPEN_TEMPLATE = "button";
    final public static String TEMPLATE = "button-close";
    public void evaluateParams() {
        if ((key == null) && (value == null)) {
            value = "Submit";
        }

        if (((key != null)) && (value == null)) {
            this.value = "%{getText('"+key +"')}";
        }

        super.evaluateParams();
    }
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
    public String getDefaultOpenTemplate() {
        return OPEN_TEMPLATE;
    }

    protected String getDefaultTemplate() {
        return TEMPLATE;
    }
	public Button(ValueStack stack, HttpServletRequest request, HttpServletResponse response) {
		super(stack, request, response);
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

	

	public boolean end(Writer writer, String body) {
        evaluateParams();
        try {
            addParameter("body", body);
            mergeTemplate(writer, buildTemplateName(template, getDefaultTemplate()));
        } catch (Exception e) {
            log.error("error when rendering"+e);
            e.printStackTrace();
        }
        finally {
            popComponentStack();
        }

        return false;
    }

	@Override
	public boolean usesBody() {
		return true;
	}
	 protected boolean supportsImageType() {
	        return true;
	    }
}
