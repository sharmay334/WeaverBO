package com.stpl.pms.action.bo.gl;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.hibernate.mapping.Itgs;
import com.stpl.pms.struts.common.BaseActionSupport;

@SuppressWarnings("serial")
public class DraftStatusMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {

	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> draftselectboxdata;
	private int gameNo;
	private List<Itgs> draftdata;

	public String successCall() {
		return SUCCESS;
	}

	public String showDraftData() {
		GameLobbyController controller = new GameLobbyController();
		try {
			draftselectboxdata = controller.getDraftStatus(userInfoBean.getUserId());
			if (!draftselectboxdata.isEmpty()) {
				return SUCCESS;
			} else {
				return ERROR;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public String getDraftData() {
		GameLobbyController controller = new GameLobbyController();
		try {

			draftdata = controller.getDraftData(gameNo, userInfoBean.getUserId());
			if (!draftdata.isEmpty()) {
				return SUCCESS;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
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

	public List<String> getDraftselectboxdata() {
		return draftselectboxdata;
	}

	public void setDraftselectboxdata(List<String> draftselectboxdata) {
		this.draftselectboxdata = draftselectboxdata;
	}

	public int getGameNo() {
		return gameNo;
	}

	public void setGameNo(int gameNo) {
		this.gameNo = gameNo;
	}

	public List<Itgs> getDraftdata() {
		return draftdata;
	}

	public void setDraftdata(List<Itgs> draftdata) {
		this.draftdata = draftdata;
	}

}
