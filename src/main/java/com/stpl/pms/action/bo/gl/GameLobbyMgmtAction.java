package com.stpl.pms.action.bo.gl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;

public class GameLobbyMgmtAction extends BaseActionSupport {

	private static final long serialVersionUID = 1L;

	private HttpServletRequest request;
	private HttpServletResponse response;
	private List<Object[]> getGameSearchData;
	private List<Integer> getUserList;
	private List<Integer> getGameNoList;
	private List<Integer> getBatchNoList;
	private int gameNO;
	private String userName;
	private String gameName;
	private Double ticketPrize;

	public List<Object[]> getGetGameSearchData() {
		return getGameSearchData;
	}

	public void setGetGameSearchData(List<Object[]> getGameSearchData) {
		this.getGameSearchData = getGameSearchData;
	}

	public String test() {

		GameLobbyController controller = new GameLobbyController();
		try {
			if (gameNO == 0 || userName.isEmpty() || gameName.isEmpty() || ticketPrize == null) {
				getBatchNoList = new ArrayList<>();
				getUserList = new ArrayList<Integer>();
				getGameNoList = new ArrayList<Integer>();
				if (userInfoBean.getParentUserId() == 0) {
					getUserList = controller.getGameList();
					getGameNoList = controller.getGameNoList(getUserList);
					getGameSearchData = controller.getGameSearchData(getGameNoList);
				}

				else if (userInfoBean.getParentUserId() != 0 && userInfoBean.getIsRoleHeadUser().equals("Y")) {
					getUserList = controller.getGameList(userInfoBean.getUserId());
					getUserList.add(userInfoBean.getUserId());
					getGameNoList = controller.getGameNoList(getUserList);
					getGameSearchData = controller.getGameSearchData(getGameNoList);

				} else {
					getUserList = controller.getGameList(userInfoBean.getUserId());// getParentUserId
					if (getUserList == null) {
						getUserList = new ArrayList<>();

					}
					getUserList.add(userInfoBean.getUserId());
					getGameNoList = controller.getGameNoList(getUserList);
					getBatchNoList = controller.getBatchNoList(userInfoBean.getUserId());
					getGameSearchData = controller.getGameSearchData(getGameNoList, getBatchNoList);

				}

			} else
				getGameSearchData = controller.getGameSearchData(gameNO, userName, gameName, ticketPrize);
			if (getGameSearchData != null)
				return SUCCESS;
			else
				return ERROR;
		} catch (Exception e) {
			e.printStackTrace();
			return "exception_nodecorate";
		}

	}

	public String callUplaodGames() {
		return SUCCESS;
	}

	public String successcall() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		gameLobbyController.getProductionType();
		return SUCCESS;
	}

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public int getGameNO() {
		return gameNO;
	}

	public void setGameNO(int gameNO) {
		this.gameNO = gameNO;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getGameName() {
		return gameName;
	}

	public void setGameName(String gameName) {
		this.gameName = gameName;
	}

	public Double getTicketPrize() {
		return ticketPrize;
	}

	public void setTicketPrize(Double ticket_Price) {
		this.ticketPrize = ticket_Price;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public List<Integer> getGetBatchNoList() {
		return getBatchNoList;
	}

	public void setGetBatchNoList(List<Integer> getBatchNoList) {
		this.getBatchNoList = getBatchNoList;
	}

}