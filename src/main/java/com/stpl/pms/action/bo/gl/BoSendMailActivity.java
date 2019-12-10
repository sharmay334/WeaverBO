package com.stpl.pms.action.bo.gl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gm.GameMgmtController;
import com.stpl.pms.controller.um.UserMgmtController;
import com.stpl.pms.hibernate.mapping.StRmBoUserInfo;
import com.stpl.pms.javabeans.UserDetailsBean;
import com.stpl.pms.security.ZipFileProtection;
import com.stpl.pms.struts.common.BaseActionSupport;

@SuppressWarnings("serial")
public class BoSendMailActivity extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private String emailType;
	private int batchNo;
	private int gameNo;
	private String mailMsg;

	public String getEmailType() {
		return emailType;
	}

	public void setEmailType(String emailType) {
		this.emailType = emailType;
	}

	public HttpServletRequest getServletRequest() {
		return servletRequest;
	}

	public void setServletRequest(HttpServletRequest servletRequest) {
		this.servletRequest = servletRequest;
	}

	public HttpServletResponse getServletResponse() {
		return servletResponse;
	}

	public void setServletResponse(HttpServletResponse servletResponse) {
		this.servletResponse = servletResponse;
	}

	public void sendActivityMail() {
		try {
			UserMgmtController service = new UserMgmtController();
			Map<String, String> emailContentMap = new HashMap<String, String>();
			GameMgmtController gameMgmtController = new GameMgmtController();
			System.out.println("::::::::::::::" + emailType);
			if (emailType.equals("GENERATE_TICKET_EMAIL_USER")) {
				String gameName = gameMgmtController.getGameName(gameNo, batchNo);
				String userEmail = service.getUserMailId(userInfoBean.getUserId());
				emailContentMap.put("UserName", userInfoBean.getUserName());
				emailContentMap.put("GameName", gameName);
				emailContentMap.put("GameNo", String.valueOf(gameNo));
				emailContentMap.put("BatchNo", String.valueOf(batchNo));
				emailContentMap.put("EmailId", userEmail);

				service.sendMailITGS(emailContentMap, emailType, userInfoBean);

			} else if (emailType.contains("DOWNLOAD_PRINT_READY_EMAIL") && userInfoBean.getParentUserId() != 0
					&& ZipFileProtection.sms_mail_activity != 2) {

				String gameName = gameMgmtController.getGameName(gameNo, batchNo);
				String userEmail = service.getUserMailId(userInfoBean.getUserId());
				String userFirstName = service.getUserFirstName(userInfoBean.getUserId());
				emailContentMap.put("UserName", userInfoBean.getUserName());
				emailContentMap.put("GameName", gameName);
				emailContentMap.put("GameNo", String.valueOf(gameNo));
				emailContentMap.put("BatchNo", String.valueOf(batchNo));
				emailContentMap.put("EmailId", userEmail);
				emailContentMap.put("UserFirstName", userFirstName);
				if (emailType.equals("DOWNLOAD_PRINT_READY_EMAIL_USER")) {
					service.sendMailITGS(emailContentMap, emailType, userInfoBean);
				}
				if (emailType.equals("DOWNLOAD_PRINT_READY_EMAIL_BO") && ZipFileProtection.sms_mail_activity != 2) {
					String ParentEmail = service.getUserMailId(userInfoBean.getParentUserId());
					emailContentMap.put("BOUserName", "BOMASTER");
					if (ZipFileProtection.ZIP_LOGIN_PASSWORD != null) {
						emailContentMap.put("ZipPasscode", ZipFileProtection.ZIP_LOGIN_PASSWORD.substring(4));
						emailContentMap.put("EmailId", ParentEmail);
						service.sendMailITGS(emailContentMap, emailType, userInfoBean);
						ZipFileProtection.sms_mail_activity++;
					}

				}
			}

			else if (emailType.equals("DOWNLOAD_PRINT_READY_EMAIL_BO") && userInfoBean.getParentUserId() == 0
					&& ZipFileProtection.sms_mail_activity != 2) {

				String gameName = gameMgmtController.getGameName(gameNo, batchNo);
				String userEmail = service.getUserMailId(userInfoBean.getUserId());
				String userFirstName = service.getUserFirstName(userInfoBean.getUserId());
				emailContentMap.put("UserName", userInfoBean.getUserName());
				emailContentMap.put("BOUserName", "BOMASTER");
				if (ZipFileProtection.ZIP_LOGIN_PASSWORD != null) {
					emailContentMap.put("ZipPasscode", ZipFileProtection.ZIP_LOGIN_PASSWORD.substring(4));
				}
				emailContentMap.put("UserFirstName", userFirstName);
				emailContentMap.put("GameName", gameName);
				emailContentMap.put("GameNo", String.valueOf(gameNo));
				emailContentMap.put("BatchNo", String.valueOf(batchNo));
				emailContentMap.put("EmailId", userEmail);
				service.sendMailITGS(emailContentMap, emailType, userInfoBean);
				ZipFileProtection.sms_mail_activity++;
			} else if (emailType.contains("DOWNLOAD_TEST_READY_EMAIL") && userInfoBean.getParentUserId() != 0) {
				String gameName = gameMgmtController.getGameName(gameNo, batchNo);
				String userEmail = service.getUserMailId(userInfoBean.getUserId());
				String userFirstName = service.getUserFirstName(userInfoBean.getUserId());
				emailContentMap.put("UserName", userInfoBean.getUserName());
				emailContentMap.put("GameName", gameName);
				emailContentMap.put("GameNo", String.valueOf(gameNo));
				emailContentMap.put("BatchNo", String.valueOf(batchNo));
				emailContentMap.put("EmailId", userEmail);
				emailContentMap.put("UserFirstName", userFirstName);
				if (emailType.equals("DOWNLOAD_TEST_READY_EMAIL_USER")) {
					service.sendMailITGS(emailContentMap, emailType, userInfoBean);
				}
				if (emailType.equals("DOWNLOAD_TEST_READY_EMAIL_BO")) {
					String ParentEmail = service.getUserMailId(userInfoBean.getParentUserId());
					emailContentMap.put("BOUserName", "BOMASTER");
					emailContentMap.put("EmailId", ParentEmail);
					service.sendMailITGS(emailContentMap, emailType, userInfoBean);
				}

			}

			else if (emailType.equals("DOWNLOAD_TEST_READY_EMAIL_BO") && userInfoBean.getParentUserId() == 0) {
				String gameName = gameMgmtController.getGameName(gameNo, batchNo);
				String userEmail = service.getUserMailId(userInfoBean.getUserId());
				String userFirstName = service.getUserFirstName(userInfoBean.getUserId());
				emailContentMap.put("UserName", userInfoBean.getUserName());
				emailContentMap.put("BOUserName", "BOMASTER");
				emailContentMap.put("UserFirstName", userFirstName);
				emailContentMap.put("GameName", gameName);
				emailContentMap.put("GameNo", String.valueOf(gameNo));
				emailContentMap.put("BatchNo", String.valueOf(batchNo));
				emailContentMap.put("EmailId", userEmail);
				service.sendMailITGS(emailContentMap, emailType, userInfoBean);
			} /*else if (emailType.equals("GENERATE_TICKET_SUPPORT")) {
					
				String gameName = gameMgmtController.getGameName(gameNo, batchNo);
				String supportEmail = "swsupport@skilrock.com";
				emailContentMap.put("UserName", "skilrock");
				emailContentMap.put("GameName", gameName);
				emailContentMap.put("GameNo", String.valueOf(gameNo));
				emailContentMap.put("BatchNo", String.valueOf(batchNo));
				emailContentMap.put("EmailId", supportEmail);
				service.sendMailITGS(emailContentMap, emailType, userInfoBean);
				System.out.println("::::generate ticket ->support mail sent:::");
			}*/ else if (emailType.equals("DOWNLOAD_TICKET_SUPPORT")) {
				String gameName = gameMgmtController.getGameName(gameNo, batchNo);
				String supporttEmail = "swsupport@skilrock.com";
				emailContentMap.put("UserName", "skilrock");
				emailContentMap.put("GameName", gameName);
				emailContentMap.put("GameNo", String.valueOf(gameNo));
				emailContentMap.put("BatchNo", String.valueOf(batchNo));
				
				emailContentMap.put("EmailId", supporttEmail);
				service.sendMailITGS(emailContentMap, emailType, userInfoBean);
			
				System.out.println("::::download ticket ->support mail sent:::");
			} else if (emailType.equals("PRINT_TICKET_SUPPORT")) {

				String gameName = gameMgmtController.getGameName(gameNo, batchNo);
				String supportEmail = "swsupport@skilrock.com";
				String userFirstName = service.getUserFirstName(userInfoBean.getUserId());
				emailContentMap.put("UserName", "skilrock");
				emailContentMap.put("GameName", gameName);
				emailContentMap.put("GameNo", String.valueOf(gameNo));
				emailContentMap.put("BatchNo", String.valueOf(batchNo));
				emailContentMap.put("EmailId", supportEmail);
				emailContentMap.put("UserFirstName", userFirstName);
				service.sendMailITGS(emailContentMap, emailType, userInfoBean);
				System.out.println("::::print ticket ->support mail sent:::");
			}
			/*
			 * else if (userInfoBean.getParentUserId() != 0) { List<StRmBoUserInfo>
			 * stRmBoUserInfo = service.getUserInformation(userInfoBean.getParentUserId());
			 * List<StRmBoUserInfo> stRmBoUserInfo1 =
			 * service.getUserInformation(userInfoBean.getUserId());
			 * 
			 * service.editBOUserDetails(userInfoBean.getUserId(),
			 * stRmBoUserInfo.get(0).getEmailId(), stRmBoUserInfo.get(0).getPhoneNum(),
			 * "useractivity", null, emailType,userInfoBean, gameNo,
			 * batchNo,mailMsg,stRmBoUserInfo1.get(0).getEmailId());
			 * 
			 * }
			 */

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

	}

	public int getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(int batchNo) {
		this.batchNo = batchNo;
	}

	public int getGameNo() {
		return gameNo;
	}

	public void setGameNo(int gameNo) {
		this.gameNo = gameNo;
	}

	public String getMailMsg() {
		return mailMsg;
	}

	public void setMailMsg(String mailMsg) {
		this.mailMsg = mailMsg;
	}

}
