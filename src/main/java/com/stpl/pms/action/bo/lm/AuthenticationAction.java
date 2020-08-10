package com.stpl.pms.action.bo.lm;

import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.stpl.pms.controller.commonMethods.CommonMethodController;
import com.stpl.pms.controller.gameService.GameServiceController;
import com.stpl.pms.controller.lm.BOLoginController;
import com.stpl.pms.controller.lm.VerifyRecaptcha;
import com.stpl.pms.daoImpl.lm.BOLoginDaoImpl;
import com.stpl.pms.exception.PMSException;
import com.stpl.pms.javabeans.LoginBean;
import com.stpl.pms.javabeans.NewLoginBean;
import com.stpl.pms.javabeans.UserInfoBean;
import com.stpl.pms.struts.common.BaseActionSupport;
//import com.journaldev.utils.VerifyRecaptcha;

public class AuthenticationAction extends BaseActionSupport {

	private static final Logger log = Logger.getLogger(AuthenticationAction.class);

	private static final long serialVersionUID = 1L;

	private String data;
	private NewLoginBean newLoginBean;
	private String errorMsg;
	private String url;
	private String loginToken;
	private String ipStatus;

	public String getLoginToken() {
		return loginToken;
	}

	public void setLoginToken(String loginToken) {
		this.loginToken = loginToken;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String redirectService() {
		String serviceName = request.getParameter("serviceName");
		serviceName = "RUMMY".equals(serviceName) ? "RUMMY_2X" : serviceName;
		GameServiceController serviceController = new GameServiceController();
		if (!serviceName.equalsIgnoreCase("MGMT") && !serviceName.equalsIgnoreCase("CASINO")) {
			url = serviceController.getBOServiceRedirectUrl(serviceName);
			url = url + request.getSession().getId() + "&userName=";
			url = url + userInfoBean.getUserName();
			log.info("----service name---" + request.getParameter("serviceName"));
		}
		request.getSession().setAttribute("ACTIVE_SERVICE", request.getParameter("serviceName").toUpperCase());
		return request.getParameter("serviceName").toLowerCase();
	}

	public String authentication() {
		log.info("Authentication Start");
		LoginBean loginBean = null;
		HttpSession session = getRequest().getSession();
		BOLoginController controller = new BOLoginController();
		errorMsg = "";
		String returntype = "ERROR";
		ResourceBundle bundle;
		if(session.getAttribute("localeValue")==null)
			bundle = ResourceBundle.getBundle("global",new Locale("en"));
		else
			 bundle = ResourceBundle.getBundle("global",new Locale(session.getAttribute("localeValue").toString()));
		
		try {
			
			
			boolean verify = false;
			String domainName = request.getServerName();
			short domainId = CommonMethodController.getInstance().getDomainIdFromName(domainName);
			// short domainId =
			// CommonMethodController.getInstance().getDomainIdFromDomainName(domainName);

			String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
			log.info("Google Recapche Authentication Start......");

			verify = VerifyRecaptcha.verify(gRecaptchaResponse);
			BOLoginDaoImpl boLoginDaoImpl = new BOLoginDaoImpl();

			// uncomment for google capche

			//if (verify == true) {

				loginBean = controller
						.loginAuthentication(newLoginBean.getUserName(),
								newLoginBean.getPassword(), loginToken, "WEB", (request.getHeader("X-Real-IP") == null)
										? request.getRemoteAddr() : request.getHeader("X-Real-IP"),
								session.getId(), domainId);
				
				ipStatus = boLoginDaoImpl.getIPStatus((request.getHeader("X-Real-IP") == null) ? request.getRemoteAddr()
						: request.getHeader("X-Real-IP"), loginBean.getUserInfo().getUserId());

				if (ipStatus.equalsIgnoreCase("ALLOWEDIP") || loginBean.getUserInfo().getParentUserId() == 0) {
					returntype = loginBean.getStatus();
				}
			/*} else {
				errorMsg = "Captcha verification required";
				return ERROR;
			}*/

			// END OF GOOGLE CAPCHA

			if (returntype.equals("success") || returntype.equals("FirstTime")) {
				// LinkedHashMap<String, LinkedHashMap<String,
				// ArrayList<PriviledgeBean>>> actionServiceMap = loginBean
				// .getActionServiceMap();
				//
				// Map<String, PrivFunctionBean > actionPrivFunctionMap =
				// loginBean.getActionPrivFunctionMap();
				// String menuStr = loginBean.getMenuStr();

				// loggedInUser(newLoginBean.getUserName(), session);
				// session.setAttribute("PRIV_MAP", actionPrivFunctionMap);
				// session.setAttribute("MENU_STR", menuStr);
				if (loginBean.getActionServiceMap().size() == 0) {
					// to destroy session
					errorMsg = bundle.getString("global.login.notauth");
					return ERROR;
				}

				if (returntype.equals("FirstTime")) {
					session.setAttribute("FIRST", true);
					return "SuccessFirstTime";
				}
				session.setAttribute("FIRST", false);
				session.setAttribute("ACTIVE_SERVICE", "MGMT");
				controller.insertLoginAlert(loginBean);	
				return SUCCESS;
			}

			else {
				if (ipStatus.equalsIgnoreCase("BLOCKEDIP")) {

					errorMsg = bundle.getString("global.login.accessdenied")+"!!!";
					controller.logoutUser(session.getId());
				} else
					errorMsg = returntype;
				return ERROR;

			}

		}

		catch (PMSException e) {
			addActionError("Enter Correct name password");
			errorMsg = bundle.getString("global.login.accessdenied");
			log.info("PMSexception in authentication");
		} catch (Exception be) {
			addActionError("Some internal error.");
			errorMsg = bundle.getString("global.login.userpasserr");
			log.info("Exception in authentication");
		}
		return ERROR;
	}

	public String welcomeUser() {
		if (userInfoBean != null) {
			return "alreadyLogin";
		}
		return SUCCESS;
	}

	// @SuppressWarnings("unchecked")
	// private void loggedInUser(String user, HttpSession session) {
	// ServletContext sc = ServletActionContext.getServletContext();
	// Map<String, HttpSession> currentUserSessionMap = (Map<String,
	// HttpSession>) sc.getAttribute("LOGGED_IN_USERS");
	// Map<String, String> currentSessionUserMap = (Map<String, String>)
	// sc.getAttribute("LOGGED_IN_SESSION");
	//
	// if (currentUserSessionMap == null) {
	// currentUserSessionMap = new HashMap<String, HttpSession>();
	// }
	// if (currentSessionUserMap == null) {
	// currentSessionUserMap = new HashMap<String, String>();
	// }
	//
	// if(currentSessionUserMap.containsKey(session.getId())){
	// currentUserSessionMap.remove(currentSessionUserMap.get(session.getId()));
	// }else if(currentUserSessionMap.containsKey(user)){
	// currentSessionUserMap.remove(currentUserSessionMap.get(user).getId());
	// }
	//
	// currentUserSessionMap.put(user.toLowerCase(), session);
	// currentSessionUserMap.put(session.getId(),user.toLowerCase());
	//
	// sc.setAttribute("LOGGED_IN_USERS", currentUserSessionMap);
	// sc.setAttribute("LOGGED_IN_SESSION", currentSessionUserMap);
	// }
	public void setNewLoginBean(NewLoginBean newLoginBean) {
		this.newLoginBean = newLoginBean;
	}

	public NewLoginBean getNewLoginBean() {
		return newLoginBean;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

}