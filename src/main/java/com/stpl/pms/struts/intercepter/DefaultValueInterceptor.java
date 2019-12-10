package com.stpl.pms.struts.intercepter;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.stpl.pms.struts.common.BaseActionSupport;

public class DefaultValueInterceptor extends AbstractInterceptor {
	private String requireProperties;
	private static Logger logger = Logger.getLogger(DefaultValueInterceptor.class);
	private static final long serialVersionUID = 1L;
	
	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		logger.info("--Set Default Values--");
		Action action = (Action) invocation.getAction();
		if (action instanceof BaseActionSupport) {
			((BaseActionSupport) action).defaulValues(requireProperties);
		}
		return invocation.invoke();
	}

	public String getRequireProperties() {
		return requireProperties;
	}

	public void setRequireProperties(String requireProperties) {
		this.requireProperties = requireProperties;
	}
}
