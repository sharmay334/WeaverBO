package com.stpl.pms.action.bo.gl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;

@SuppressWarnings("serial")
public class DeleteExistingGames extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {

	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private String userName;
	private String gameName;
	private int gameNO;
	private Double ticketPrize;
	private int batchNo;

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

	public String ReturnSuccess() {
		return SUCCESS;
	}

	public void deleteGame() {
		String result = "";
		try {
			GameLobbyController controller = new GameLobbyController();
			result = controller.deleteExistingGame(gameNO, batchNo, userInfoBean.getUserId());
			if (result.equalsIgnoreCase("deleted")) {
				servletResponse.getWriter().write("DELETED");
			} else {
				servletResponse.getWriter().write("ERROR");

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

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

	public int getGameNO() {
		return gameNO;
	}

	public void setGameNO(int gameNO) {
		this.gameNO = gameNO;
	}

	public Double getTicketPrize() {
		return ticketPrize;
	}

	public void setTicketPrize(Double ticketPrize) {
		this.ticketPrize = ticketPrize;
	}

	public int getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(int batchNo) {
		this.batchNo = batchNo;
	}

}
