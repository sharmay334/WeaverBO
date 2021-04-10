package com.stpl.pms.action.bo.um;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.struts.common.BaseActionSupport;

@SuppressWarnings("serial")
public class TMBusinessDevelopment extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {

	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;

	private String teamName;
	private String teamTarget;
	private List<String> teamsList;
	private List<String> productCategoryList;

	private String subTeamName;
	private String productCategory;
	private String subTeamTarget;
	private List<String> subTeamNameList;
	private List<String> empNameList;
	private List<String> yearList;
	private String rsmName;
	private String rsmTarget;

	private String tsmName;
	private String tsmTarget;

	private String smName;
	private String smTarget;

	private String faName;
	private String faTarget;

	private String empName;
	private String targetYear;
	private String target;

	private String sourceLoc;
	private String targetLoc;
	private String dynamicList;

	private String firmName;
	private String retName;
	private String retContact;
	private String retAddress;
	private String location;
	private String retTehsil;
	private String retDistrict;

	
	private List<String> employeeNames;
	
	private String employeeName;
	private String monthYear;
	private File docPicture;
	private String docPictureContentType;
	private String docPictureFileName;
	
	private List<String> sourceLocationList;
	private List<String> targetLocationList;
	private Map<Integer, String> fieldValuesMap; 
	private List<String> itemNamesList;
	private String itemName;
	
	public String loadItemBrochure() {
		GameLobbyController controller = new GameLobbyController();
		itemNamesList = controller.getAllStockItemsList();
		return SUCCESS;
	}
	public void uploadBrochureFile()throws IOException{
		GameLobbyController controller = new GameLobbyController();
		int itemId = controller.getItemIdByItemName(itemName);
		String tempFileName="broucher_"+itemId+".pdf";
		String filePath = "";
		filePath = "/var/www/html/jamidaraSeeds/";//ServletActionContext.getServletContext().getRealPath("/");
		//filePath = filePath.substring(0, filePath.lastIndexOf("default/"));
		File file = new File(filePath + "brochure/" + itemId);
		if(file.mkdir()) {
				filePath = filePath.concat("brochure/" + itemId);
				File fileToCreate = null;
				fileToCreate = new File(filePath, tempFileName);
				FileUtils.copyFile(docPicture, fileToCreate);
		}
		else {
			filePath = filePath.concat("brochure/"+ itemId);
			File fileToCreate = null;
			fileToCreate = new File(filePath, tempFileName);
			FileUtils.copyFile(docPicture, fileToCreate);
			
		}
		if(controller.uploadBrochureFile(filePath+"/"+tempFileName,tempFileName,itemId)) {
			servletResponse.getWriter().write("success");
		}
		else
			servletResponse.getWriter().write("failed");
		
	}
	public String loadLocShowPage() {
		GameLobbyController controller = new GameLobbyController();
		sourceLocationList = controller.getLocationListByColumnType("source");
		targetLocationList = controller.getLocationListByColumnType("target");
		
		return SUCCESS;
	}
	
	public String viewEditLocationSubmit() {
		GameLobbyController controller = new GameLobbyController();
		fieldValuesMap = controller.getLocationData(sourceLoc, targetLoc);
		return SUCCESS;
	}
	
	public void removeLocation() throws IOException{
		GameLobbyController controller = new GameLobbyController();
		controller.removeLocation(sourceLoc,targetLoc,dynamicList);
		servletResponse.getWriter().write("success");
		
	}
	public void uploadSalaryFile()throws IOException{
		GameLobbyController controller = new GameLobbyController();
		int empId = controller.getEmployeeId(employeeName);
		String filePath = "";
		filePath = ServletActionContext.getServletContext().getRealPath("/");
		filePath = filePath.substring(0, filePath.lastIndexOf("default/"));
		File file = new File(filePath + "salary/" + empId);
		if(file.mkdir()) {
			File my = new File("salary/" + empId+"/"+monthYear);
			if(my.mkdir()) {
				filePath = filePath.concat("salary/" + empId+"/"+monthYear);
				File fileToCreate = null;
				fileToCreate = new File(filePath, docPictureFileName);
				FileUtils.copyFile(docPicture, fileToCreate);
			}
			else {
				
				filePath = filePath.concat("salary/" + empId+"/"+monthYear);
				File fileToCreate = null;
				fileToCreate = new File(filePath, docPictureFileName);
				FileUtils.copyFile(docPicture, fileToCreate);
			}
		}
		else {
			filePath = filePath.concat("salary/" + empId+"/"+monthYear);
			File fileToCreate = null;
			fileToCreate = new File(filePath, docPictureFileName);
			FileUtils.copyFile(docPicture, fileToCreate);
			
		}
		if(controller.uploadEmpSalary(filePath+"/"+docPictureFileName,empId,monthYear)) {
			servletResponse.getWriter().write("success");
		}
		else
			servletResponse.getWriter().write("failed");
		
	}
	public String loadDefineRetailerForm() {
		GameLobbyController controller  = new GameLobbyController();
		sourceLocationList = controller.getAllLocations();
		return SUCCESS;
		
	}
	public String loadDefineLocationForm() {
		return SUCCESS;
	}
	
	public String loadEmpSalUploadForm() {
		GameLobbyController controller = new GameLobbyController();
		employeeNames = controller.getEmployeeNamesList();
		return SUCCESS;
	}

	public void DefineLocationFormSubmit() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if(controller.storeDefinedLocation(sourceLoc,targetLoc,dynamicList))
			servletResponse.getWriter().write("success");
		else
			servletResponse.getWriter().write("failed");
	}
	
	public void DefineRetailerFormSubmit() throws IOException{
		GameLobbyController controller = new GameLobbyController();
		if(controller.storeDefinedRetailer(retName,retContact,retAddress,location,firmName,retTehsil,retDistrict))
			servletResponse.getWriter().write("success");
		else
			servletResponse.getWriter().write("failed");
		
	}

	public String loadCreateTeam() {
		return SUCCESS;
	}

	public String loadEmpYearTarget() {
		GameLobbyController controller = new GameLobbyController();
		empNameList = controller.getEmployeeNamesList();
		productCategoryList = controller.getAllStockCatagory();
		Date d = new Date();
		int year = d.getYear();
		int currentYear = year + 1900;
		yearList = new ArrayList<>();
		yearList.add("" + currentYear);
		currentYear = currentYear + 1;
		yearList.add("" + currentYear);

		return SUCCESS;
	}

	public void assignYearlyTarget() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.assignYearlyTargetEmp(empName, targetYear, target, productCategory))
			servletResponse.getWriter().write("success");
		else
			servletResponse.getWriter().write("failed");

	}

	public String loadCreateSubTeam() {
		GameLobbyController controller = new GameLobbyController();
		teamsList = controller.getAllBDMTeamsList();
		productCategoryList = controller.getAllStockCatagory();
		return SUCCESS;
	}

	public void createTeam() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.createBDMTeam(teamName, teamTarget))
			servletResponse.getWriter().write("success");
		else
			servletResponse.getWriter().write("duplicate");
	}

	public void getTeamTargetAmount() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		teamTarget = controller.getBDMTargetAmount(teamName);
		servletResponse.getWriter().write("" + teamTarget);

	}

	public void getSubTeamTargetAmount() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		teamTarget = controller.getBDMSubTeamTargetAmount(teamName);
		servletResponse.getWriter().write("" + teamTarget);

	}

	public void getRSMTeamTargetAmount() throws IOException {

		GameLobbyController controller = new GameLobbyController();
		teamTarget = controller.getRSMTeamTargetAmount(rsmName, subTeamName, "RSM");
		servletResponse.getWriter().write("" + teamTarget);

	}

	public void getTSMTeamTargetAmount() throws IOException {

		GameLobbyController controller = new GameLobbyController();
		teamTarget = controller.getRSMTeamTargetAmount(tsmName, subTeamName, "TSM");
		servletResponse.getWriter().write("" + teamTarget);

	}

	public void getSMTeamTargetAmount() throws IOException {

		GameLobbyController controller = new GameLobbyController();
		teamTarget = controller.getRSMTeamTargetAmount(smName, subTeamName, "SM");
		servletResponse.getWriter().write("" + teamTarget);

	}

	public void createSubTeam() throws IOException {

		GameLobbyController controller = new GameLobbyController();

		if (controller.createBDMSubTeam(subTeamName, teamName, productCategory, subTeamTarget))
			servletResponse.getWriter().write("success");
		else
			servletResponse.getWriter().write("failed");
	}

	public String loadRSMAssignSubTeam() {
		GameLobbyController controller = new GameLobbyController();
		empNameList = controller.getEmployeeNamesListByRole("R.S.M.");
		subTeamNameList = controller.getSubTeamList();
		return SUCCESS;
	}

	public void assignRSMSubTeam() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.assignRSMSubTam(subTeamName, rsmName, rsmTarget))
			servletResponse.getWriter().write("success");
		else
			servletResponse.getWriter().write("failed");
	}

	public void assignTSMSubTeam() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.assignTSMSubTam(subTeamName, rsmName, tsmName, tsmTarget))
			servletResponse.getWriter().write("success");
		else
			servletResponse.getWriter().write("failed");
	}

	public void assignSMSubTeam() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.assignSMSubTam(subTeamName, tsmName, smName, smTarget))
			servletResponse.getWriter().write("success");
		else
			servletResponse.getWriter().write("failed");
	}

	public void assignFASubTeam() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.assignFASubTam(subTeamName, smName, faName, faTarget))
			servletResponse.getWriter().write("success");
		else
			servletResponse.getWriter().write("failed");
	}

	public String loadTSMAssignSubTeam() {
		GameLobbyController controller = new GameLobbyController();
		empNameList = controller.getEmployeeNamesListByRole("T.S.M.");
		subTeamNameList = controller.getSubTeamList();

		return SUCCESS;
	}

	public String loadSMAssignSubTeam() {
		GameLobbyController controller = new GameLobbyController();
		empNameList = controller.getEmployeeNamesListByRole("SALES MANAGER");
		subTeamNameList = controller.getSubTeamList();
		return SUCCESS;
	}

	public String loadFAAssignSubTeam() {
		GameLobbyController controller = new GameLobbyController();
		empNameList = controller.getEmployeeNamesListByRole("FIELD ASSITANT");
		subTeamNameList = controller.getSubTeamList();

		return SUCCESS;
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

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	public String getTeamTarget() {
		return teamTarget;
	}

	public void setTeamTarget(String teamTarget) {
		this.teamTarget = teamTarget;
	}

	public List<String> getTeamsList() {
		return teamsList;
	}

	public void setTeamsList(List<String> teamsList) {
		this.teamsList = teamsList;
	}

	public List<String> getProductCategoryList() {
		return productCategoryList;
	}

	public void setProductCategoryList(List<String> productCategoryList) {
		this.productCategoryList = productCategoryList;
	}

	public String getSubTeamName() {
		return subTeamName;
	}

	public void setSubTeamName(String subTeamName) {
		this.subTeamName = subTeamName;
	}

	public String getProductCategory() {
		return productCategory;
	}

	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}

	public String getSubTeamTarget() {
		return subTeamTarget;
	}

	public void setSubTeamTarget(String subTeamTarget) {
		this.subTeamTarget = subTeamTarget;
	}

	public List<String> getSubTeamNameList() {
		return subTeamNameList;
	}

	public void setSubTeamNameList(List<String> subTeamNameList) {
		this.subTeamNameList = subTeamNameList;
	}

	public List<String> getEmpNameList() {
		return empNameList;
	}

	public void setEmpNameList(List<String> empNameList) {
		this.empNameList = empNameList;
	}

	public String getRsmName() {
		return rsmName;
	}

	public void setRsmName(String rsmName) {
		this.rsmName = rsmName;
	}

	public String getRsmTarget() {
		return rsmTarget;
	}

	public void setRsmTarget(String rsmTarget) {
		this.rsmTarget = rsmTarget;
	}

	public String getTsmName() {
		return tsmName;
	}

	public void setTsmName(String tsmName) {
		this.tsmName = tsmName;
	}

	public String getTsmTarget() {
		return tsmTarget;
	}

	public void setTsmTarget(String tsmTarget) {
		this.tsmTarget = tsmTarget;
	}

	public String getSmName() {
		return smName;
	}

	public void setSmName(String smName) {
		this.smName = smName;
	}

	public String getSmTarget() {
		return smTarget;
	}

	public void setSmTarget(String smTarget) {
		this.smTarget = smTarget;
	}

	public String getFaName() {
		return faName;
	}

	public void setFaName(String faName) {
		this.faName = faName;
	}

	public String getFaTarget() {
		return faTarget;
	}

	public void setFaTarget(String faTarget) {
		this.faTarget = faTarget;
	}

	public List<String> getYearList() {
		return yearList;
	}

	public void setYearList(List<String> yearList) {
		this.yearList = yearList;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getTargetYear() {
		return targetYear;
	}

	public void setTargetYear(String targetYear) {
		this.targetYear = targetYear;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public String getSourceLoc() {
		return sourceLoc;
	}

	public void setSourceLoc(String sourceLoc) {
		this.sourceLoc = sourceLoc;
	}

	public String getTargetLoc() {
		return targetLoc;
	}

	public void setTargetLoc(String targetLoc) {
		this.targetLoc = targetLoc;
	}

	public String getDynamicList() {
		return dynamicList;
	}

	public void setDynamicList(String dynamicList) {
		this.dynamicList = dynamicList;
	}
	public String getRetName() {
		return retName;
	}
	public void setRetName(String retName) {
		this.retName = retName;
	}
	public String getRetContact() {
		return retContact;
	}
	public void setRetContact(String retContact) {
		this.retContact = retContact;
	}
	public String getRetAddress() {
		return retAddress;
	}
	public void setRetAddress(String retAddress) {
		this.retAddress = retAddress;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public List<String> getEmployeeNames() {
		return employeeNames;
	}
	public void setEmployeeNames(List<String> employeeNames) {
		this.employeeNames = employeeNames;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getMonthYear() {
		return monthYear;
	}
	public void setMonthYear(String monthYear) {
		this.monthYear = monthYear;
	}
	public String getDocPictureContentType() {
		return docPictureContentType;
	}
	public void setDocPictureContentType(String docPictureContentType) {
		this.docPictureContentType = docPictureContentType;
	}
	public File getDocPicture() {
		return docPicture;
	}
	public void setDocPicture(File docPicture) {
		this.docPicture = docPicture;
	}
	public String getDocPictureFileName() {
		return docPictureFileName;
	}
	public void setDocPictureFileName(String docPictureFileName) {
		this.docPictureFileName = docPictureFileName;
	}
	public String getFirmName() {
		return firmName;
	}
	public void setFirmName(String firmName) {
		this.firmName = firmName;
	}

	public List<String> getTargetLocationList() {
		return targetLocationList;
	}

	public void setTargetLocationList(List<String> targetLocationList) {
		this.targetLocationList = targetLocationList;
	}

	public List<String> getSourceLocationList() {
		return sourceLocationList;
	}

	public void setSourceLocationList(List<String> sourceLocationList) {
		this.sourceLocationList = sourceLocationList;
	}

	public Map<Integer, String> getFieldValuesMap() {
		return fieldValuesMap;
	}

	public void setFieldValuesMap(Map<Integer, String> fieldValuesMap) {
		this.fieldValuesMap = fieldValuesMap;
	}

	public String getRetTehsil() {
		return retTehsil;
	}

	public void setRetTehsil(String retTehsil) {
		this.retTehsil = retTehsil;
	}

	public String getRetDistrict() {
		return retDistrict;
	}

	public void setRetDistrict(String retDistrict) {
		this.retDistrict = retDistrict;
	}
	public List<String> getItemNamesList() {
		return itemNamesList;
	}
	public void setItemNamesList(List<String> itemNamesList) {
		this.itemNamesList = itemNamesList;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	
	

}
