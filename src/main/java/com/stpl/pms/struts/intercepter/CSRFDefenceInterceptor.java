package com.stpl.pms.struts.intercepter;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class CSRFDefenceInterceptor extends AbstractInterceptor{

	private static final long serialVersionUID = 1L;
	private static final String TOKEN = "token";

	@Override
	public String intercept(ActionInvocation invocation)
			throws Exception {

		/*HttpSession session = ServletActionContext.getRequest().getSession();

		

		HttpServletRequest request = ServletActionContext.getRequest();
		String hToken = request.getHeader(TOKEN);
		String formtoken = request.getParameter("token");
		String sessionToken = (String) session.getAttribute(TOKEN);
		if(formtoken!=null && sessionToken!=null && formtoken.equals(sessionToken)) {
			System.out.println();
		}


		String token = Encryption.createToken();
		session.setAttribute(TOKEN, token);
		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setHeader(TOKEN, token);*/
		return invocation.invoke();
	}

}
