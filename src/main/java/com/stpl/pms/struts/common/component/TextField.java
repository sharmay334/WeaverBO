package com.stpl.pms.struts.common.component;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.views.annotations.StrutsTag;
import org.apache.struts2.views.annotations.StrutsTagAttribute;

import com.opensymphony.xwork2.util.ValueStack;

/**
 * <!-- START SNIPPET: javadoc -->
 * Render an HTML input field of type text</p>
 * <!-- END SNIPPET: javadoc -->
 *
 * <p/> <b>Examples</b>
 * <p/>
 * <!-- START SNIPPET: exdescription -->
 * In this example, a text control for the "user" property is rendered. The label is also retrieved from a ResourceBundle via the key attribute.
 * <!-- END SNIPPET: exdescription -->
 * <pre>
 * <!-- START SNIPPET: example -->
 * &lt;s:textfield key="user" /&gt;
 * <!-- END SNIPPET: example -->
 * </pre>
 *
 * In this sample you can see how the "viewmode" attribute can be used
 * <pre>
 * <!-- START SNIPPET: example2 -->
 * &lt;s:textfield name="user" viewmode="true" label="User Name" /&gt;
 * <!-- END SNIPPET: example -->
 * </pre>
 */
@StrutsTag(name = "textfield", tldTagClass = "com.stpl.pms.struts.common.ui.TextFieldTag", description = "Render an HTML input field of type text",allowDynamicAttributes=true)
public class TextField extends org.apache.struts2.components.TextField {

    /**
     * The name of the default template for the TextFieldTag
     */
    protected String errorMassage;
    protected String pattern;
    protected String min;
    protected String max;
    protected String action;
    protected String minLength;
    protected String checkRequired;
    protected String required;
    protected String patternOn;
    protected String ajaxParam;
    public TextField(ValueStack stack, HttpServletRequest request, HttpServletResponse response) {
        super(stack, request, response);
    }

    protected void evaluateExtraParams() {
        super.evaluateExtraParams();
        if (errorMassage!=null) {
        	//addParameter(expr, getViewmode());
        	addParameter("errorMassage", findString(errorMassage));
        }
        if (pattern!=null) {
        	//addParameter(expr, getViewmode());
        	
        	addParameter("pattern", findString(pattern));
        }
        if (min!=null) {
        	//addParameter(expr, getViewmode());
        	addParameter("min", findString(min));
        }
        if (max!=null) {
        	//addParameter(expr, getViewmode());
        	addParameter("max", findString(max));
        }
        if (action!=null) {
        	//addParameter(expr, getViewmode());
        	addParameter("action", findString(action));
        }
        if (minLength!=null) {
        	//addParameter(expr, getViewmode());
        	addParameter("minLength", findString(minLength));
        }
        if (checkRequired != null) {
            addParameter("checkRequired", findString(checkRequired));
        }
        if (required != null) {
            addParameter("required", findString(required));
        }
        if (patternOn != null) {
            addParameter("patternOn", findString(patternOn));
        }
        if (ajaxParam != null) {
            addParameter("ajaxParam", findString(ajaxParam));
        }
    
    
    }

    @StrutsTagAttribute(description = "It set data, the element is use to set Div|massages" )
    public void setErrorMassage(String errorMassage) {
        this.errorMassage = errorMassage;
    }
    
    public String getErrorMassage(){
    	return errorMassage;
    }
    @StrutsTagAttribute(description = "It set the action for ajax request" )
    public void setAction(String action) {
        this.action = action;
    }
    
    public String getAction(){
    	return action;
    }
    @StrutsTagAttribute(description = "It set characters in which data will show, the element is use to set pattern" )
    public void setPattern(String pattern) {
        this.pattern = pattern;
    }
    
    public String getPattern(){
    	return pattern;
    }
    @StrutsTagAttribute(description="HTML minlength attribute", type="Integer")
    public void setMin(String min) {
        this.min = min;
    }
    
    public String getMin(){
    	return min;
    }
    @StrutsTagAttribute(description="HTML maxlength attribute", type="Integer")
    public void setMax(String max) {
        this.max = max;
    }
    
    public String getMax(){
    	return max;
    }
    @StrutsTagAttribute(description="HTML minLength attribute", type="Integer")
    public void setMinLength(String minLength) {
        this.minLength = minLength;
    }
    
    public String getMinLength(){
    	return minLength;
    }
    @StrutsTagAttribute(description="HTML required value attribute", type="String")
    public void setCheckRequired(String checkRequired) {
        this.checkRequired = checkRequired;
    }
    public String getCheckRequired(){
    	return checkRequired;
    }
    @StrutsTagAttribute(description="It set field to define event", type="String")
    public void setPatternOn(String patternOn) {
        this.patternOn = patternOn;
    }
    public String getPatternOn(){
    	return patternOn;
    }
    public void setAjaxParam(String ajaxParam) {
        this.ajaxParam = ajaxParam;
    }
    public String getAjaxParam(){
    	return ajaxParam;
    }
}
