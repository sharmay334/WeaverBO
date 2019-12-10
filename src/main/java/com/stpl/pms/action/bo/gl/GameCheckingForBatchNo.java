package com.stpl.pms.action.bo.gl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;

@SuppressWarnings("serial")
public class GameCheckingForBatchNo extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {

	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private int gameNo;
	private List<Integer> batchNoData;
	private List<Integer> gameNoList;
	private String ticketStatus;

	
	public List<Integer> getBatchNoData() {
		return batchNoData;
	}

	public void setBatchNoData(List<Integer> batchNoData) {
		this.batchNoData = batchNoData;
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

	public int getGameNo() {
		return gameNo;
	}

	public void setGameNo(int gameNo) {
		this.gameNo = gameNo;
	}

	public String TicketGenerationBatch() {
		try {
			GameLobbyController gameLobbyController = new GameLobbyController();
			if(userInfoBean.getParentUserId()==0)
			batchNoData = gameLobbyController.getGameStatus(gameNo,ticketStatus);
			if(userInfoBean.getParentUserId()!=0)
				batchNoData = gameLobbyController.getGameStatus(gameNo,ticketStatus,userInfoBean.getUserId());
					
			if (batchNoData != null) {
				return SUCCESS;
			} else {
				batchNoData = new ArrayList<>();
				return ERROR;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String TicketGenerationGame() {
		try {
			Set<Integer> tempList = new HashSet<>();
			GameLobbyController gameLobbyController = new GameLobbyController();
			if(userInfoBean.getParentUserId()==0){
				gameNoList = gameLobbyController.getGameStatus(ticketStatus);
				tempList.addAll(gameNoList);
				gameNoList.clear();
				gameNoList.addAll(tempList);
				Collections.sort(gameNoList);
			}if(userInfoBean.getParentUserId()!=0){
				gameNoList = gameLobbyController.getGameStatus(ticketStatus,userInfoBean.getUserId());
				tempList.addAll(gameNoList);
				gameNoList.clear();
				gameNoList.addAll(tempList);
				Collections.sort(gameNoList);
			}	
			if (gameNoList != null) {
				return SUCCESS;
			} else {
				gameNoList = new ArrayList<>();
				return ERROR;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	

	public void checkGame() {

		try {
			GameLobbyController gameLobbyController = new GameLobbyController();
			batchNoData = gameLobbyController.getGameStatus(gameNo);
			if (batchNoData != null) {
				Integer i = Collections.max(batchNoData);

				servletResponse.getWriter().write("exists" + (i + 1));
			} else {
				servletResponse.getWriter().write("new");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	public void getGameStatus()
	{


		try {
			GameLobbyController gameLobbyController = new GameLobbyController();
			if(userInfoBean.getParentUserId()==0)
			batchNoData = gameLobbyController.getGameStatus(gameNo);
			if(userInfoBean.getParentUserId()!=0)
				batchNoData = gameLobbyController.getGameStatus(gameNo,userInfoBean.getUserId(),null);
					
			if (batchNoData != null) {
				Integer i = Collections.max(batchNoData);

				servletResponse.getWriter().write("exists" + (i + 1));
			} else {
				servletResponse.getWriter().write("new");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	
	}
	public String getTicketStatus() {
		return ticketStatus;
	}

	public void setTicketStatus(String ticketStatus) {
		this.ticketStatus = ticketStatus;
	}

	public List<Integer> getGameNoList() {
		return gameNoList;
	}

	public void setGameNoList(List<Integer> gameNoList) {
		this.gameNoList = gameNoList;
	}

}
