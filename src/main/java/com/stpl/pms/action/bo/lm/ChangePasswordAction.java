package com.stpl.pms.action.bo.lm;

import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.hibernate.Session;

import com.stpl.pms.controller.lm.BOLoginController;
import com.stpl.pms.exception.PMSException;
import com.stpl.pms.struts.common.BaseActionSupport;

public class ChangePasswordAction extends BaseActionSupport{
	private static final Logger log=Logger.getLogger(ChangePasswordAction.class);
	static Log logger = LogFactory.getLog(ChangePasswordAction.class);
	private static final long serialVersionUID = 1L;
	private String newPassword = null;
	private String password = null;
	private String verifynewPassword = null;
	private String emailId = null;
	private String errorMsg;

	@Override
	public String execute() throws Exception {
		logger.debug("inside change pass action");
		HttpSession session = request.getSession();
		String returntype = "";

		if (!newPassword.equals(verifynewPassword)) {
			addActionError("New Password is not Match with Verified Password !!");
			return "wrongpass";
		}

		if (userInfoBean == null) {
			addActionError("You have to login to change your password ");
			return "NOTLOGIN";
		}

		logger.debug(session.getAttribute("FIRST") + "****************");
		boolean first = false;
		if (session.getAttribute("FIRST") != null) {
			first = (Boolean) session.getAttribute("FIRST");
		}
		String ipAddress = (request.getHeader("X-Real-IP")== null)?request.getRemoteAddr():request.getHeader("X-Real-IP");
		BOLoginController service = new BOLoginController();

		if (userInfoBean != null && password != null && newPassword != null
				&& verifynewPassword != null) {
			if (service.verifyPasswordChars(newPassword)) {
				returntype = service.changePassword(userInfoBean, password,
						newPassword,  ipAddress);
			} else {
				returntype = "PASSWORD INAPPROPRIATE";
			}
		}

		logger.debug("***" + returntype);
		if (returntype.equals("ERROR")) {
			addActionError("New Password is not Match with Verified Password !!");
			return ERROR;
		} else if (returntype.equals("INPUT")) {
			addActionError("You Have Used This Password Recently");
			return INPUT;
		} else if (returntype.equals("SUCCESS")) {
			if (first) {
				session.setAttribute("FIRST", false);
				return "UserFirstSuccess";
			}
			return "UserSuccess";
		} else if (returntype.equals("INCORRECT")) {
			addActionError("Enter Correct Old Password !!");
			return "wrongpass";
		} else if (returntype.equals("PASSWORD INAPPROPRIATE")) {
			addActionError("Password inappropriate: Password Should Contain AtLeast one digit,one special symbol one lower and one uppercase alphabet!!");
		} else if (returntype.equals("PASSWORD_IN_HISTORY")) {
			addActionError("You can not use previous password !!");
		}
		// addActionError("Enter Correct  Old Password");
		return ERROR;
	}

	public String changePasswordPage() {
		ServletContext sc = ServletActionContext.getServletContext();
		String passPolicy = (String) sc.getAttribute("PASS_POLICY");
		request.setAttribute("passPolicy", passPolicy);
		return SUCCESS;
	}
	
	public String forgotPassword() throws PMSException{
		try{
			HttpSession session = getRequest().getSession();
			ResourceBundle bundle;
			if(session.getAttribute("localeValue")==null)
				bundle = ResourceBundle.getBundle("global",new Locale("en"));
			else
				 bundle = ResourceBundle.getBundle("global",new Locale(session.getAttribute("localeValue").toString()));
			
		log.info("------inside change password method-------");
		errorMsg = "";
		log.info(getEmailId());
		String returntype = "";
		if (getEmailId().equals("")){
			errorMsg = bundle.getString("global.forgotpass.blankerr");
			return INPUT;
		}
		String email = getEmailId();
		BOLoginController service = new BOLoginController();
		returntype = service.forgotPassword(email);
		if(returntype=="emailId_not_registered"){
			 errorMsg =  bundle.getString("global.forgotpass.noregemail");
				return INPUT;
		}
		else{
			return SUCCESS;
		}
		}
		catch(PMSException pmse){
			pmse.printStackTrace();
			errorMsg = "Error : Some internal error! Please retry resetting password!";
			return INPUT;
		}
		catch (Exception be) {
			be.printStackTrace();
			errorMsg = "Error : Some internal error! Please retry resetting password!";
			return INPUT;
		}
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getVerifynewPassword() {
		return verifynewPassword;
	}

	public void setVerifynewPassword(String verifynewPassword) {
		this.verifynewPassword = verifynewPassword;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

}
