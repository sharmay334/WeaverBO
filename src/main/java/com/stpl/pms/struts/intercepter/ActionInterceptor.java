package com.stpl.pms.struts.intercepter;

import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.stpl.pms.exception.PMSException;
import com.stpl.pms.javabeans.PrivFunctionBean;
import com.stpl.pms.struts.common.BaseActionSupport;
import com.stpl.pms.utility.WithoutLoginAction;

public class ActionInterceptor extends AbstractInterceptor {
	static Log logger = LogFactory.getLog(ActionInterceptor.class);
	private static final long serialVersionUID = 1L;
	private String actionName;

	public String intercept(ActionInvocation invocation) throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		setActionName((String) ActionContext.getContext().getContextMap().get(ActionContext.ACTION_NAME));
		if (!WithoutLoginAction.contains(actionName) && !isSessionValid(request.getSession(),invocation)) {
			if(!"bo_lm_newLogin".equals(actionName))
				return "SESSION_TIME_OUT";
		}
		String result = null;
		if (!isAllowed(request)) {
			return "unauthorize";
		} else {
			result = invocation.invoke();
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	protected boolean isAllowed(HttpServletRequest request) throws SQLException {
		HttpSession session = request.getSession();
		boolean result = true; //set false when priv works properly
		Map<String, PrivFunctionBean> actionPrivFunctionMap = null;
		actionPrivFunctionMap = (Map<String, PrivFunctionBean>) session.getAttribute("PRIV_MAP");
		if (actionPrivFunctionMap!=null && actionPrivFunctionMap.containsKey(getActionName())) {
			PrivFunctionBean privFunctionBean;
			privFunctionBean = actionPrivFunctionMap.get(actionName);
			request.setAttribute("ALLOWED_PRIV", privFunctionBean);
			request.setAttribute("ALLOWED_ACTION", actionPrivFunctionMap);
			result = true;
		}
		return result;
	}

	public boolean isSessionValid(HttpSession session, ActionInvocation invocation) {
		Action action = (Action) invocation.getAction();
		if (action instanceof BaseActionSupport) {
			try {
				((BaseActionSupport) action).checkUserLogin(session);
			} catch (PMSException e) {
				return false;
			}
		}
		return true;
	}

	public void setActionName(String actionName) {
		this.actionName = actionName;
	}

	public String getActionName() {
		return actionName;
	}

}
