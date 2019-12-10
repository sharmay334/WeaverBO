package com.stpl.pms.action.bo.gl;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gm.GameMgmtController;
import com.stpl.pms.struts.common.BaseActionSupport;

@SuppressWarnings("serial")
public class DisplayImageMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	Map<String,byte[]> imagesMap;
	private int gameNo;
	private int batchNo;
	
	public void fetchImageData() {
		try {
			ServletContext sc = ServletActionContext.getServletContext();
			String path = sc.getRealPath("/");
		GameMgmtController gameMgmtController = new GameMgmtController();
		imagesMap = gameMgmtController.getAllImages(gameNo,batchNo);
		File file1=new File(path+"/images/frontImg_"+gameNo+"_"+batchNo+".png");
        FileOutputStream frontImg=new FileOutputStream(file1);
        File file2=new File(path+"/images/backImg_"+gameNo+"_"+batchNo+".png");
        FileOutputStream backImg=new FileOutputStream(file2);
        File file3=new File(path+"/images/scratchedImg_"+gameNo+"_"+batchNo+".png");
        FileOutputStream scratchedImg=new FileOutputStream(file3);
       
        frontImg.write(imagesMap.get("frontImg_"+gameNo+"_"+batchNo));
        backImg.write(imagesMap.get("backImg_"+gameNo+"_"+batchNo));
        scratchedImg.write(imagesMap.get("scratchedImg_"+gameNo+"_"+batchNo));
        servletResponse.getWriter().write(path);
		//servletResponse.getOutputStream().write(path);
	/*	servletResponse.getOutputStream().write(imagesMap.get("backImg"));
		servletResponse.getOutputStream().write(imagesMap.get("scratchedImg"));
	*/	}catch (Exception e) {
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

	public Map<String, byte[]> getImagesMap() {
		return imagesMap;
	}
	public void setImagesMap(Map<String, byte[]> imagesMap) {
		this.imagesMap = imagesMap;
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
	
}
