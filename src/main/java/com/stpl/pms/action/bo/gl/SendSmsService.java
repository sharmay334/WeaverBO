package com.stpl.pms.action.bo.gl;

import com.stpl.pms.controller.gm.GameMgmtController;
import com.stpl.pms.controller.um.UserMgmtController;
import com.stpl.pms.javabeans.UserDetailsBean;
import com.stpl.pms.security.ZipFileProtection;
import com.stpl.pms.struts.common.BaseActionSupport;

@SuppressWarnings("serial")
public class SendSmsService extends BaseActionSupport {

	private String smsType;
	private int gameNo;
	private int batchNo;

	public String getSmsType() {
		return smsType;
	}

	public void setSmsType(String smsType) {
		this.smsType = smsType;
	}

	public void sendSms() {
		UserDetailsBean usrdetBean = new UserDetailsBean();
		String gameName;
		GameMgmtController gameMgmtController = new GameMgmtController();
		
		try{
			usrdetBean = gameMgmtController.getUserDetailsBean(userInfoBean.getUserId());
			UserMgmtController userMgmtController = new UserMgmtController();
			gameName = gameMgmtController.getGameName(gameNo,batchNo);
			userMgmtController.sendSmsService(smsType, usrdetBean,gameName,gameNo,batchNo);
		}catch(Exception e){e.printStackTrace();}
		
		
	}
	public void sendSmsToBo(){
		String gameName;
		try{
			UserDetailsBean usrdetBean = new UserDetailsBean();
			UserMgmtController userMgmtController = new UserMgmtController();
			GameMgmtController gameMgmtController = new GameMgmtController();
			if(userInfoBean.getParentUserId()!=0 && ZipFileProtection.sms_mail_activity!=2){
				usrdetBean = gameMgmtController.getUserDetailsBean(userInfoBean.getParentUserId());
				gameName = gameMgmtController.getGameName(gameNo,batchNo);
				userMgmtController.sendSmsServiceBO(smsType, usrdetBean,gameName,gameNo,batchNo,userInfoBean.getUserName(),gameMgmtController.getUserDetailsBean(userInfoBean.getUserId()).getFirstName());
				if(smsType.equals("BO_PRINT_TICKET")){
					ZipFileProtection.sms_mail_activity ++;
				}
				System.out.println("VALUE IS::::::::"+ZipFileProtection.sms_mail_activity);
			}
			else if(smsType.equals("BO_PRINT_TICKET") && userInfoBean.getParentUserId()==0 && ZipFileProtection.sms_mail_activity!=2){
				usrdetBean = gameMgmtController.getUserDetailsBean(userInfoBean.getUserId());
				gameName = gameMgmtController.getGameName(gameNo,batchNo);
				userMgmtController.sendSmsServiceBO(smsType, usrdetBean,gameName,gameNo,batchNo,userInfoBean.getUserName(),gameMgmtController.getUserDetailsBean(userInfoBean.getUserId()).getFirstName());
				ZipFileProtection.sms_mail_activity ++;
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public int getGameNo() {
		return gameNo;
	}

	public void setGameNo(int gameNo) {
		this.gameNo = gameNo;
	}

	public int getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(int batchNo) {
		this.batchNo = batchNo;
	}
}
