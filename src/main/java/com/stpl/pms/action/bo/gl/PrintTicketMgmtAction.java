package com.stpl.pms.action.bo.gl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gm.GameMgmtController;
import com.stpl.pms.controller.um.UserMgmtController;
import com.stpl.pms.daoImpl.gl.Shuffler;
import com.stpl.pms.hibernate.mapping.Itgs;
import com.stpl.pms.hibernate.mapping.StRmBoUserInfo;
import com.stpl.pms.mail.services.SMTPMailService;
import com.stpl.pms.security.ZipFileProtection;
import com.stpl.pms.struts.common.BaseActionSupport;

@SuppressWarnings("serial")
public class PrintTicketMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {

	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> batchNoList;
	private List<String> gameNoList;
	private int gameNo;
	private int batchNo;
	private Itgs itgs;

	private Map<String, String> zipFileMap;

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

	public String successCall() {
		try {
			Set<String> tempbatchNoList = new HashSet<>();
			GameMgmtController gameMgmtController = new GameMgmtController();
			if (userInfoBean.getParentUserId() == 0) {
				gameNoList = gameMgmtController.getGameNoList();
				tempbatchNoList.addAll(gameNoList);
				gameNoList.clear();
				gameNoList.addAll(tempbatchNoList);
				Collections.sort(gameNoList);
			}
			if (userInfoBean.getParentUserId() != 0) {
				gameNoList = gameMgmtController.getGameNoList(userInfoBean.getUserId());
				tempbatchNoList.addAll(gameNoList);
				gameNoList.clear();
				gameNoList.addAll(tempbatchNoList);
				Collections.sort(gameNoList);
			}
			if (gameNoList == null || gameNoList.isEmpty()) {
				gameNoList = new ArrayList<>();
			//	gameNoList.add("No game available");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	public String getBatchNoListResult() {
		try {

			GameMgmtController gameMgmtController = new GameMgmtController();
			if (userInfoBean.getParentUserId() == 0)
				batchNoList = gameMgmtController.getBatchNoList(gameNo);
			if (userInfoBean.getParentUserId() != 0)
				batchNoList = gameMgmtController.getBatchNoList(gameNo, userInfoBean.getUserId());
			if (batchNoList.isEmpty() || batchNoList == null) {
				batchNoList = new ArrayList<>();
			//	batchNoList.add("No batch available");
			}
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();

		}
		return null;
	}

	public String printTicketResult() {
		try {
			String shufflerStatus = null;
			String shuffleFileStatus = null;
			SendMailService sendMailService = new SendMailService();
			ServletContext sc = ServletActionContext.getServletContext();
			String path = sc.getRealPath("/");
			String serverPath = sc.getRealPath("/");
			GameMgmtController gameMgmtController = new GameMgmtController();
			itgs = gameMgmtController.getGameDataForPrintTicket(gameNo, batchNo);
			String mergedTicketLoc = path + gameNo + "/TextFiles/" + gameNo + "_" + batchNo
					+ "_After-Merge-Final-Tickets.txt";
			File file = new File(mergedTicketLoc);
			if (file.exists()) {
				int totalNoOfPacks = itgs.getNo_Of_Tickets()
						/ (itgs.getNo_Of_Tickets_Per_Book() * itgs.getNo_Of_Books_Per_Pack());
				shuffleFileStatus = path + gameNo + "/TextFiles/" + gameNo + "_" + batchNo + "_printReadyData.zip";
				File shufFile = new File(shuffleFileStatus);
				if (!shufFile.exists()) {
					shufflerStatus = Shuffler.shuffler(gameNo, totalNoOfPacks, itgs.getNo_Of_Books_Per_Pack(),
							itgs.getNo_Of_Tickets_Per_Book(), mergedTicketLoc, batchNo, itgs.getStarting_Pack());
					if (shufflerStatus.equalsIgnoreCase("success")) {
						zipFileMap = gameMgmtController.getZipFileName(gameNo, batchNo, path,
								userInfoBean.getUserName());
						if (zipFileMap != null) {
							//sendMailService.returnMailServiceResult(ZipFileProtection.ZIP_LOGIN_PASSWORD, userInfoBean);
							return SUCCESS;

						} else {
							return ERROR;
						}
					}
				} else {
					String ZIP_FILE_NAME1 = path + "" + gameNo + "/TextFiles/" + gameNo + "_" + batchNo
							+ "_printReadyData.zip";
					String ZIP_FILE_NAME2 = path + "" + gameNo + "/TextFiles/" + gameNo + "_" + batchNo
							+ "_virnRankData.zip";
					zipFileMap = new HashMap<>();
					zipFileMap.put(ZIP_FILE_NAME1, gameNo + "_" + batchNo + "_printReadyData.zip");
					zipFileMap.put(ZIP_FILE_NAME2, gameNo + "_" + batchNo + "_virnRankData.zip");
					
					if (zipFileMap != null) {
						//sendMailService.returnMailServiceResult(ZipFileProtection.ZIP_LOGIN_PASSWORD, userInfoBean);
						return SUCCESS;

					} else {
						return ERROR;
					}

				}

			} else if (!file.exists()) {
				path = path.substring(0, path.lastIndexOf("/"));
				path = path.substring(0, path.lastIndexOf("/"));
				path = path.substring(0, path.lastIndexOf("/"));
				path = path.substring(0, path.lastIndexOf("/"));
				path = path.substring(0, path.lastIndexOf("/"));
				path = path.substring(0, path.lastIndexOf("/"));
				path = path.substring(0, path.lastIndexOf("/"));
				mergedTicketLoc = path + "/docs/.empty/" + gameNo + "/" + gameNo + "_" + batchNo + "_"
						+ "After-Merge-Final-Tickets.txt";
				int totalNoOfPacks = itgs.getNo_Of_Tickets()
						/ (itgs.getNo_Of_Tickets_Per_Book() * itgs.getNo_Of_Books_Per_Pack());
				shuffleFileStatus = path + "/docs/.empty/" + gameNo + "/" + gameNo + "_" + batchNo
						+ "_printReadyData.zip";
				File sfile = new File(shuffleFileStatus);
				if (!sfile.exists()) {
					shufflerStatus = Shuffler.shuffler(gameNo, totalNoOfPacks, itgs.getNo_Of_Books_Per_Pack(),
							itgs.getNo_Of_Tickets_Per_Book(), mergedTicketLoc, batchNo,itgs.getStarting_Pack());
					if (shufflerStatus.equalsIgnoreCase("success")) {

						zipFileMap = gameMgmtController.getZipFileName(gameNo, batchNo, path,
								userInfoBean.getUserName());
						if (zipFileMap != null) {
							//sendMailService.returnMailServiceResult(ZipFileProtection.ZIP_LOGIN_PASSWORD, userInfoBean);
							return SUCCESS;

						} else {
							return ERROR;
						}
					} else {
						return ERROR;
					}
				} else {
					String ZIP_FILE_NAME1 = path + "/docs/.empty/" + gameNo + "/" + gameNo + "_" + batchNo
							+ "_printReadyData.zip";
					String ZIP_FILE_NAME2 = path + "/docs/.empty/" + gameNo + "/" + gameNo + "_" + batchNo
							+ "_virnRankData.zip";
					zipFileMap = new HashMap<>();
					zipFileMap.put(ZIP_FILE_NAME1, gameNo + "_" + batchNo + "_printReadyData.zip");
					zipFileMap.put(ZIP_FILE_NAME2, gameNo + "_" + batchNo + "_virnRankData.zip");
					if (zipFileMap != null) {
						//sendMailService.returnMailServiceResult(ZipFileProtection.ZIP_LOGIN_PASSWORD, userInfoBean);
						return SUCCESS;

					} else {
						return ERROR;
					}

				}

			} else {
				return ERROR;
			}

		} catch (Exception e) {

			e.printStackTrace();
		}
		return ERROR;
	}

	public List<String> getBatchNoList() {
		return batchNoList;
	}

	public void setBatchNoList(List<String> batchNoList) {
		this.batchNoList = batchNoList;
	}

	public List<String> getGameNoList() {
		return gameNoList;
	}

	public void setGameNoList(List<String> gameNoList) {
		this.gameNoList = gameNoList;
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

	public Map<String, String> getZipFileMap() {
		return zipFileMap;
	}

	public void setZipFileMap(Map<String, String> zipFileMap) {
		this.zipFileMap = zipFileMap;
	}

	public Itgs getItgs() {
		return itgs;
	}

	public void setItgs(Itgs itgs) {
		this.itgs = itgs;
	}

}
