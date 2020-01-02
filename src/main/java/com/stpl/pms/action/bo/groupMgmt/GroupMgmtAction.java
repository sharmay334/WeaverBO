package com.stpl.pms.action.bo.groupMgmt;

import com.stpl.pms.controller.commonMethods.CommonMethodController;
import com.stpl.pms.struts.common.BaseActionSupport;
import com.stpl.pms.utility.Utility;

public class GroupMgmtAction extends BaseActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String userName;
	private Long playerId;
	private String groupName;
	
	
	
	public String addPlrToPlrGroup(){
		StringBuilder pokerReq = new StringBuilder();
		String url = null;
		try{
			url = CommonMethodController.getInstance().fetchSystemProperties("capi_req_url");
			pokerReq.append("<PKT>").append("<Method Name=\"AddPlayerToPlayerGroup\" LayerName=\"").append("\" ServerID=\"").append("\"").append(">");
			pokerReq.append("<Auth Login=\"").append("").append("\" Password=\"").append("").append("\" TicketID=\"").append("").append("\" />");
			pokerReq.append("<Params>");
			pokerReq.append("<LoginName Value=\"").append(userName).append("\" />");
			pokerReq.append("<PlayerGroupName Value=\"").append(groupName).append("\" />");
		    pokerReq.append("</Params>");
		    pokerReq.append("</Method></PKT>");
		}catch (Exception e) {
			e.printStackTrace();
		}
		int []timeout = {5000,10000};
	    Utility.callUrl(url, pokerReq.toString(),timeout);
		return SUCCESS;
	}
	
	public String rmvPlrFromPlrGroup(){
		StringBuilder pokerReq = new StringBuilder();
		String url = null;
		try{
			url = CommonMethodController.getInstance().fetchSystemProperties("capi_req_url");
			pokerReq.append("<PKT>").append("<Method Name=\"AddPlayerToPlayerGroup\" LayerName=\"").append("\" ServerID=\"").append("\"").append(">");
			pokerReq.append("<Auth Login=\"").append("").append("\" Password=\"").append("").append("\" TicketID=\"").append("").append("\" />");
			pokerReq.append("<Params>");
			pokerReq.append("<LoginName Value=\"").append(userName).append("\" />");
			pokerReq.append("<PlayerGroupName Value=\"").append(groupName).append("\" />");
		    pokerReq.append("</Params>");
		    pokerReq.append("</Method></PKT>");
		}catch (Exception e) {
			e.printStackTrace();
		}
		int []timeout = {5000,25000};
	    Utility.callUrl(url, pokerReq.toString(),timeout);
		return SUCCESS;
	}
	
	
	public static void main(String args[]){
		GroupMgmtAction mgmtAction = new GroupMgmtAction();
		mgmtAction.addPlrToPlrGroup();
	}
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Long getPlayerId() {
		return playerId;
	}
	public void setPlayerId(Long playerId) {
		this.playerId = playerId;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	

}
