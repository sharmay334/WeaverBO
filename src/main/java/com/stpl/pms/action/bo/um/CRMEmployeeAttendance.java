package com.stpl.pms.action.bo.um;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;

public class CRMEmployeeAttendance extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {

	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;

	private int employeeUserName;
	private String attendanceType;
	private String workType;
	private String workArea;
	private String travellingMode;
	private File odoMeterPicture;
	private String odoMeterPictureContentType;
	private String odoMeterPictureFileName;
	private String odometer_reading;
	private String leave_reason;
	private File selfiePicture;
	private String selfiePictureContentType;
	private String selfiePictureFileName;
	private String travellingModeVia;

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

	public String markAttendance() throws IOException {
		employeeUserName = getUserInfoBean().getUserId();
		LocalDate date = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalTime time = LocalTime.now();
        DateTimeFormatter pattern = DateTimeFormatter.ofPattern("hh:mm:ss a");
        String currentTimeAMPM[] = time.format(pattern).split(" ");
		String filePath = "";
		String finalPath="";
		if (attendanceType.equals("PI") || attendanceType.equals("PO")) {
			filePath = ServletActionContext.getServletContext().getRealPath("/");
			filePath = filePath.substring(0, filePath.lastIndexOf("default/"));
			File file = new File(filePath + "attendance/" + employeeUserName);
			if (file.mkdir()) {
				File file1 = new File(filePath + "attendance/" + employeeUserName + "/" + date.format(formatter));
				if (file1.mkdir()) {
					filePath = filePath.concat("attendance/" + employeeUserName + "/" + date.format(formatter));
					odoMeterPictureFileName = "odo_"+date.format(formatter) + "_"+currentTimeAMPM[1]+"_" + odoMeterPictureFileName;
					selfiePictureFileName = "selfie_"+date.format(formatter) + "_"+currentTimeAMPM[1]+"_" + selfiePictureFileName;
					File fileToCreate = new File(filePath, odoMeterPictureFileName);
					FileUtils.copyFile(odoMeterPicture, fileToCreate);// copying source file to new file
					File fileToCreateSelfie = new File(filePath, selfiePictureFileName);
					FileUtils.copyFile(selfiePicture, fileToCreateSelfie);// copying source file to new file
					finalPath  = filePath;
				} else if (file1.exists()) {
					filePath = filePath.concat("attendance/" + employeeUserName + "/" + date.format(formatter));
					odoMeterPictureFileName = "odo_"+date.format(formatter) + "_"+currentTimeAMPM[1]+"_" + odoMeterPictureFileName;
					selfiePictureFileName = "selfie_"+date.format(formatter) + "_"+currentTimeAMPM[1]+"_" + selfiePictureFileName;
					File fileToCreate = new File(filePath, odoMeterPictureFileName);
					FileUtils.copyFile(odoMeterPicture, fileToCreate);// copying source file to new file
					File fileToCreateSelfie = new File(filePath, selfiePictureFileName);
					FileUtils.copyFile(selfiePicture, fileToCreateSelfie);// copying source file to new file
					finalPath  = filePath;
				}
			} else if (file.exists()) {
				filePath = filePath.concat("attendance/" + employeeUserName + "/" + date.format(formatter));
				odoMeterPictureFileName = "odo_"+date.format(formatter) + "_"+currentTimeAMPM[1]+"_" + odoMeterPictureFileName;
				selfiePictureFileName = "selfie_"+date.format(formatter) + "_"+currentTimeAMPM[1]+"_" + selfiePictureFileName;
				File fileToCreate = new File(filePath, odoMeterPictureFileName);
				FileUtils.copyFile(odoMeterPicture, fileToCreate);// copying source file to new file
				File fileToCreateSelfie = new File(filePath, selfiePictureFileName);
				FileUtils.copyFile(selfiePicture, fileToCreateSelfie);// copying source file to new file
				finalPath  = filePath;
			}

		}
		String filePathStructureOdometer = finalPath + "/" + date.format(formatter) + "_"+"_"+currentTimeAMPM[1] + odoMeterPictureFileName;
		String filePathStructureSelfie = finalPath + "/" + date.format(formatter) + "_" +"_"+currentTimeAMPM[1]+ selfiePictureFileName;

		GameLobbyController controller = new GameLobbyController();
		if (controller.markAttendance(employeeUserName, attendanceType, workType, workArea, travellingMode,
				filePathStructureOdometer,filePathStructureSelfie, odometer_reading, leave_reason,travellingModeVia))
			return SUCCESS;
		else
			return ERROR;
	}

	public String getAttendanceType() {
		return attendanceType;
	}

	public void setAttendanceType(String attendanceType) {
		this.attendanceType = attendanceType;
	}

	public String getWorkType() {
		return workType;
	}

	public void setWorkType(String workType) {
		this.workType = workType;
	}

	public String getWorkArea() {
		return workArea;
	}

	public void setWorkArea(String workArea) {
		this.workArea = workArea;
	}

	public String getTravellingMode() {
		return travellingMode;
	}

	public void setTravellingMode(String travellingMode) {
		this.travellingMode = travellingMode;
	}

	public String getOdometer_reading() {
		return odometer_reading;
	}

	public void setOdometer_reading(String odometer_reading) {
		this.odometer_reading = odometer_reading;
	}

	public String getLeave_reason() {
		return leave_reason;
	}

	public void setLeave_reason(String leave_reason) {
		this.leave_reason = leave_reason;
	}

	public int getEmployeeUserName() {
		return employeeUserName;
	}

	public void setEmployeeUserName(int employeeUserName) {
		this.employeeUserName = employeeUserName;
	}

	public File getOdoMeterPicture() {
		return odoMeterPicture;
	}

	public void setOdoMeterPicture(File odoMeterPicture) {
		this.odoMeterPicture = odoMeterPicture;
	}

	public String getOdoMeterPictureContentType() {
		return odoMeterPictureContentType;
	}

	public void setOdoMeterPictureContentType(String odoMeterPictureContentType) {
		this.odoMeterPictureContentType = odoMeterPictureContentType;
	}

	public String getOdoMeterPictureFileName() {
		return odoMeterPictureFileName;
	}

	public void setOdoMeterPictureFileName(String odoMeterPictureFileName) {
		this.odoMeterPictureFileName = odoMeterPictureFileName;
	}

	public File getSelfiePicture() {
		return selfiePicture;
	}

	public void setSelfiePicture(File selfiePicture) {
		this.selfiePicture = selfiePicture;
	}

	public String getSelfiePictureContentType() {
		return selfiePictureContentType;
	}

	public void setSelfiePictureContentType(String selfiePictureContentType) {
		this.selfiePictureContentType = selfiePictureContentType;
	}

	public String getSelfiePictureFileName() {
		return selfiePictureFileName;
	}

	public void setSelfiePictureFileName(String selfiePictureFileName) {
		this.selfiePictureFileName = selfiePictureFileName;
	}

	public String getTravellingModeVia() {
		return travellingModeVia;
	}

	public void setTravellingModeVia(String travellingModeVia) {
		this.travellingModeVia = travellingModeVia;
	}

}
