package com.stpl.pms.action.bo.um;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.TimeZone;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.ImageTypeSpecifier;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.metadata.IIOMetadata;
import javax.imageio.stream.ImageInputStream;
import javax.imageio.stream.ImageOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.javabeans.VisitFormBean;
import com.stpl.pms.struts.common.BaseActionSupport;
import com.stpl.pms.utility.SendSMS;

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
	private String attendaceDate;
	private String resultType;
	private VisitFormBean visitFormBean;
	private String docPath;
	private String visitLocation;
	
	
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
	public void compressJPGFormat(String odoMeterPictureFileName,File odoMeterPicture,String filePath) {
		try {
		//File input = new File(odoMeterPicture);
	      BufferedImage image = ImageIO.read(odoMeterPicture);

	      File compressedImageFile = new File(filePath+"/"+odoMeterPictureFileName);
	      OutputStream os =new FileOutputStream(compressedImageFile);

	      Iterator<ImageWriter>writers =  ImageIO.getImageWritersByFormatName("jpg");
	      ImageWriter writer = (ImageWriter) writers.next();

	      ImageOutputStream ios = ImageIO.createImageOutputStream(os);
	      writer.setOutput(ios);

	      ImageWriteParam param = writer.getDefaultWriteParam();
	      
	      param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
	      param.setCompressionQuality(0.05f);
	      writer.write(null, new IIOImage(image, null, null), param);
	      
	      os.close();
	      ios.close();
	      writer.dispose();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public void compressPNGFormat(String odoMeterPictureFileName,File odoMeterPicture) throws IOException {
		
		BufferedImage image;
		IIOMetadata metadata;

		try (ImageInputStream in = ImageIO.createImageInputStream(odoMeterPicture)) {
		    ImageReader reader = ImageIO.getImageReadersByFormatName("png").next();
		    reader.setInput(in, true, false);
		    image = reader.read(0);
		    metadata = reader.getImageMetadata(0);
		    reader.dispose();
		}

		try (ImageOutputStream out = ImageIO.createImageOutputStream(Files.newOutputStream(Paths.get(odoMeterPictureFileName)))) {
		    ImageTypeSpecifier type = ImageTypeSpecifier.createFromRenderedImage(image);
		    ImageWriter writer = ImageIO.getImageWriters(type, "png").next();

		    ImageWriteParam param = writer.getDefaultWriteParam();
		    if (param.canWriteCompressed()) {
		        param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
		        param.setCompressionQuality(0.0f);
		    }

		    writer.setOutput(out);
		    writer.write(null, new IIOImage(image, null, metadata), param);
		    writer.dispose();
		}
		
		
		
	}
	public String markAttendance() throws IOException {
		employeeUserName = getUserInfoBean().getUserId();
		Date today = new Date();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		DateFormat df1 = new SimpleDateFormat("hh:mm:ss a");
		df.setTimeZone(TimeZone.getTimeZone("Asia/Kolkata"));
		df1.setTimeZone(TimeZone.getTimeZone("Asia/Kolkata"));
		String IST = df.format(today);
		String AMPM = df1.format(today);
		String currentTimeAMPM[] = AMPM.split(" ");
		String filePath = "";
		String finalPath = "";
		if (attendanceType.equals("PI") || attendanceType.equals("PO")) {
			filePath = ServletActionContext.getServletContext().getRealPath("/");
			filePath = filePath.substring(0, filePath.lastIndexOf("default/"));
			File file = new File(filePath + "attendance/" + employeeUserName);
			if (file.mkdir()) {
				File file1 = new File(filePath + "attendance/" + employeeUserName + "/" + IST);
				if (file1.mkdir()) {
					filePath = filePath.concat("attendance/" + employeeUserName + "/" + IST);
					odoMeterPictureFileName = "odo_" + IST + "_" + currentTimeAMPM[1] + "_" + odoMeterPictureFileName;
					selfiePictureFileName = "selfie_" + IST + "_" + currentTimeAMPM[1] + "_" + selfiePictureFileName;
					File fileToCreate = null;
					if (workType.equalsIgnoreCase("Field_work")) {
						if(odoMeterPictureFileName.contains("jpg")) {
							compressJPGFormat(odoMeterPictureFileName,odoMeterPicture,filePath); //compress and upload
						}
						else {
							fileToCreate = new File(filePath, odoMeterPictureFileName);
							FileUtils.copyFile(odoMeterPicture, fileToCreate);// copying source file to new file
					
						}
					}
					if(selfiePictureFileName.contains("jpg")) {
						compressJPGFormat(selfiePictureFileName,selfiePicture,filePath); //compress and upload
					}
					else {
						File fileToCreateSelfie = new File(filePath, selfiePictureFileName);
						FileUtils.copyFile(selfiePicture, fileToCreateSelfie);// copying source file to new file
					}
					finalPath = filePath;
				} else if (file1.exists()) {
					filePath = filePath.concat("attendance/" + employeeUserName + "/" + IST);
					if (workType.equalsIgnoreCase("Field_work")) {
						odoMeterPictureFileName = "odo_" + IST + "_" + currentTimeAMPM[1] + "_"
								+ odoMeterPictureFileName;
					}
					selfiePictureFileName = "selfie_" + IST + "_" + currentTimeAMPM[1] + "_" + selfiePictureFileName;
					if (workType.equalsIgnoreCase("Field_work")) {
						if(odoMeterPictureFileName.contains("jpg")) {
							compressJPGFormat(odoMeterPictureFileName,odoMeterPicture,filePath); //compress and upload
						}
						else {
						File fileToCreate = new File(filePath, odoMeterPictureFileName);
						FileUtils.copyFile(odoMeterPicture, fileToCreate);// copying source file to new file
						}
					}
					if(selfiePictureFileName.contains("jpg")) {
						compressJPGFormat(selfiePictureFileName,selfiePicture,filePath); //compress and upload
					}
					else {
					File fileToCreateSelfie = new File(filePath, selfiePictureFileName);
					FileUtils.copyFile(selfiePicture, fileToCreateSelfie);// copying source file to new file
					}
					finalPath = filePath;
				}
			} else if (file.exists()) {
				File file1 = new File(filePath + "attendance/" + employeeUserName + "/" + IST);
				
				if (file1.mkdir()) {
					filePath = filePath.concat("attendance/" + employeeUserName + "/" + IST);
					odoMeterPictureFileName = "odo_" + IST + "_" + currentTimeAMPM[1] + "_" + odoMeterPictureFileName;
					selfiePictureFileName = "selfie_" + IST + "_" + currentTimeAMPM[1] + "_" + selfiePictureFileName;
					File fileToCreate = null;
					if (workType.equalsIgnoreCase("Field_work")) {
						if(odoMeterPictureFileName.contains("jpg")) {
							compressJPGFormat(odoMeterPictureFileName,odoMeterPicture,filePath); //compress and upload
						}
						else {
							fileToCreate = new File(filePath, odoMeterPictureFileName);
							FileUtils.copyFile(odoMeterPicture, fileToCreate);// copying source file to new file
					
						}
					}
					if(selfiePictureFileName.contains("jpg")) {
						compressJPGFormat(selfiePictureFileName,selfiePicture,filePath); //compress and upload
					}
					else {
						File fileToCreateSelfie = new File(filePath, selfiePictureFileName);
						FileUtils.copyFile(selfiePicture, fileToCreateSelfie);// copying source file to new file
					}
					finalPath = filePath;
				} else if (file1.exists()) {
					filePath = filePath.concat("attendance/" + employeeUserName + "/" + IST);
					if (workType.equalsIgnoreCase("Field_work")) {
						odoMeterPictureFileName = "odo_" + IST + "_" + currentTimeAMPM[1] + "_"
								+ odoMeterPictureFileName;
					}
					selfiePictureFileName = "selfie_" + IST + "_" + currentTimeAMPM[1] + "_" + selfiePictureFileName;
					if (workType.equalsIgnoreCase("Field_work")) {
						if(odoMeterPictureFileName.contains("jpg")) {
							compressJPGFormat(odoMeterPictureFileName,odoMeterPicture,filePath); //compress and upload
						}
						else {
						File fileToCreate = new File(filePath, odoMeterPictureFileName);
						FileUtils.copyFile(odoMeterPicture, fileToCreate);// copying source file to new file
						}
					}
					if(selfiePictureFileName.contains("jpg")) {
						compressJPGFormat(selfiePictureFileName,selfiePicture,filePath); //compress and upload
					}
					else {
					File fileToCreateSelfie = new File(filePath, selfiePictureFileName);
					FileUtils.copyFile(selfiePicture, fileToCreateSelfie);// copying source file to new file
					}
					finalPath = filePath;
				}
			}

		}
		String filePathStructureOdometer = finalPath + "/" + odoMeterPictureFileName;
		String filePathStructureSelfie = finalPath + "/" + selfiePictureFileName;
		if(workType.equalsIgnoreCase("Office_setting"))
			filePathStructureOdometer = filePathStructureSelfie;
		GameLobbyController controller = new GameLobbyController();
		if (controller.markAttendance(employeeUserName, attendanceType, workType, workArea, travellingMode,
				filePathStructureOdometer, filePathStructureSelfie, odometer_reading, leave_reason, travellingModeVia,
				visitFormBean,visitLocation)) {
			if (attendanceType.equals("PI")) {
				resultType = "Your Present Marked Successfully!!!";
				String mobile = "91"+controller.getMobileNoByEmpId(getUserInfoBean().getUserId());
				String sms = "Dear "+getUserInfoBean().getUserName()+". Your Present on "+IST+" "+AMPM+" has been marked successfully!! Have a Nice Day. Regards JAMIDARA SEEDS CORPORATION (Karnataka)" ;
				SendSMS sendSMS = new SendSMS();
				sendSMS.setMobileNo(mobile);
				sendSMS.setMsg(sms);
				Thread thread = new Thread(sendSMS);
				thread.setDaemon(true);
				thread.start();	
				
				}
			else if (attendanceType.equals("PO")) {
				resultType = "HAHA!!! Your Day Over Marked Successfully!!!";
				String mobile = "91"+controller.getMobileNoByEmpId(getUserInfoBean().getUserId());
				String sms = "Dear "+getUserInfoBean().getUserName()+". Your day over on "+IST+" "+AMPM+" has been marked successfully!! Have a Nice Day. Regards JAMIDARA SEEDS CORPORATION (Karnataka)" ;
				SendSMS sendSMS = new SendSMS();
				sendSMS.setMobileNo(mobile);
				sendSMS.setMsg(sms);
				Thread thread = new Thread(sendSMS);
				thread.setDaemon(true);
				thread.start();	
			}
			else if (attendanceType.equals("L"))
				resultType = "Your Leave Marked Successfully!!!";
			else if (attendanceType.equals("W"))
				resultType = "Your Week Off Marked Successfully!!!";
			return SUCCESS;
		}

		else
			return ERROR;
	}
	
	public void getuserName() throws IOException {
			servletResponse.getWriter().write(""+getUserInfoBean().getUserName());
		return;
		
	}
	public void getPicture() throws IOException {
		String filePath = ServletActionContext.getServletContext().getRealPath("/");
		String finalUrl = "";
			String temp = "";
			temp = "/WeaverBO" +docPath;
			finalUrl =  temp;
				Path src = Paths.get(docPath);
				Path dest = Paths.get(filePath);
				File file = new File(dest.toFile(), docPath);
				FileUtils.copyFile(src.toFile(), file);

		
		servletResponse.getWriter().write("" + finalUrl);
		return;
	}
	public void getPictureReport() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String response = controller.getEmployeePictureReport(employeeUserName, attendaceDate);
		String filePath = ServletActionContext.getServletContext().getRealPath("/");
		String[] responseArr = response.split(";");
		String finalUrl = "";
		for (int i = 0; i < responseArr.length; i++) {
			String temp = "";
			temp = "/WeaverBO" + responseArr[i];
			finalUrl = finalUrl + temp + ";";
			if (!responseArr[i].equalsIgnoreCase("no")) {
				Path src = Paths.get(responseArr[i]);
				Path dest = Paths.get(filePath);
				File file = new File(dest.toFile(), responseArr[i]);
				FileUtils.copyFile(src.toFile(), file);
			}

		}
		servletResponse.getWriter().write("" + finalUrl);
		return;
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

	public String getAttendaceDate() {
		return attendaceDate;
	}

	public void setAttendaceDate(String attendaceDate) {
		this.attendaceDate = attendaceDate;
	}

	public String getResultType() {
		return resultType;
	}

	public void setResultType(String resultType) {
		this.resultType = resultType;
	}

	public VisitFormBean getVisitFormBean() {
		return visitFormBean;
	}

	public void setVisitFormBean(VisitFormBean visitFormBean) {
		this.visitFormBean = visitFormBean;
	}

	public String getDocPath() {
		return docPath;
	}

	public void setDocPath(String docPath) {
		this.docPath = docPath;
	}

	public String getVisitLocation() {
		return visitLocation;
	}

	public void setVisitLocation(String visitLocation) {
		this.visitLocation = visitLocation;
	}

}
