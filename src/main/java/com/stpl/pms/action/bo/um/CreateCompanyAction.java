package com.stpl.pms.action.bo.um;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.controller.um.UserMgmtController;
import com.stpl.pms.hibernate.mapping.CreateCompany;
import com.stpl.pms.struts.common.BaseActionSupport;

public class CreateCompanyAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {

	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private Integer company_id;
	private String name;
	private String email;
	private String currentAddress;
	private String country;
	private String state;
	private String pincode;
	private String fyb;
	private String bbf;
	private String contactNo;
	private String gstNo;
	private String panNo;
	private String license;
	private String csln;
	private String cpln;
	private String cfln;
	private String cinRegNo;
	private String bankName;
	private String accountNo;
	private String accountNoConfirm;
	private String accHolderName;
	private String ifsc;
	private List<String> companyNameList;
	private List<CreateCompany> companies;
	private CreateCompany companyBean;
	private File companyLogo;
	private File signature;
	
	public File getCompanyLogo() {
		return companyLogo;
	}

	public void setCompanyLogo(File companyLogo) {
		this.companyLogo = companyLogo;
	}

	public File getSignature() {
		return signature;
	}

	public void setSignature(File signature) {
		this.signature = signature;
	}

	public String getLicense() {
		return license;
	}

	public void setLicense(String license) {
		this.license = license;
	}

	public String getCsln() {
		return csln;
	}

	public void setCsln(String csln) {
		this.csln = csln;
	}

	public String getCpln() {
		return cpln;
	}

	public void setCpln(String cpln) {
		this.cpln = cpln;
	}

	public String getCfln() {
		return cfln;
	}

	public void setCfln(String cfln) {
		this.cfln = cfln;
	}

	public String getCinRegNo() {
		return cinRegNo;
	}

	public void setCinRegNo(String cinRegNo) {
		this.cinRegNo = cinRegNo;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getAccountNo() {
		return accountNo;
	}

	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}

	public String getAccountNoConfirm() {
		return accountNoConfirm;
	}

	public void setAccountNoConfirm(String accountNoConfirm) {
		this.accountNoConfirm = accountNoConfirm;
	}

	public String getAccHolderName() {
		return accHolderName;
	}

	public void setAccHolderName(String accHolderName) {
		this.accHolderName = accHolderName;
	}

	public String getIfsc() {
		return ifsc;
	}

	public void setIfsc(String ifsc) {
		this.ifsc = ifsc;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCurrentAddress() {
		return currentAddress;
	}

	public void setCurrentAddress(String currentAddress) {
		this.currentAddress = currentAddress;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	public String getFyb() {
		return fyb;
	}

	public void setFyb(String fyb) {
		this.fyb = fyb;
	}

	public String getBbf() {
		return bbf;
	}

	public void setBbf(String bbf) {
		this.bbf = bbf;
	}

	public String getContactNo() {
		return contactNo;
	}

	public void setContactNo(String contactNo) {
		this.contactNo = contactNo;
	}

	public String getGstNo() {
		return gstNo;
	}

	public void setGstNo(String gstNo) {
		this.gstNo = gstNo;
	}

	public String getPanNo() {
		return panNo;
	}

	public void setPanNo(String panNo) {
		this.panNo = panNo;
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

	public String deleteCompany() {
		UserMgmtController service = new UserMgmtController();
		if (service.deleteCompany(name)) {
			return SUCCESS;
		}
		return ERROR;
	}

	public String getCompanyList() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		companyNameList = gameLobbyController.getCompanyNameList();
		return SUCCESS;
	}

	public String viewCompanyDetails() {
		GameLobbyController gameLobbyController = new GameLobbyController();
		companies = gameLobbyController.getCompanyNameList(name);
		return SUCCESS;
	}

	public String showCompanyDetails() {
		UserMgmtController service = new UserMgmtController();
		companyBean = service.showCompanyDetails(company_id);
		return SUCCESS;
	}

	public String editCompany() {
		// TODO Auto-generated method stub
		UserMgmtController service = new UserMgmtController();
		if (service.editCompany(companyBean)) {
			return SUCCESS;
		}
		return ERROR;
	}

	public String createCompany()  {
		// TODO Auto-generated method stub
		CreateCompany createCompany = new CreateCompany();
		try {
			createCompany.setAccHolderName(accHolderName);
			createCompany.setAccountNo(accountNo);
			createCompany.setBankName(bankName);
			createCompany.setBbf(bbf);
			createCompany.setCfln(cfln);
			createCompany.setCinRegNo(cinRegNo);
			createCompany.setContactNo(contactNo);
			createCompany.setCountry(country);
			createCompany.setCpln(cpln);
			createCompany.setCsln(csln);
			createCompany.setCurrentAddress(currentAddress);
			createCompany.setEmail(email);
			createCompany.setFyb(fyb);
			createCompany.setGstNo(gstNo);
			createCompany.setIfsc(ifsc);
			createCompany.setLicense(license);
			createCompany.setName(name);
			createCompany.setPanNo(panNo);
			createCompany.setPincode(pincode);
			createCompany.setState(state);
			String path = ServletActionContext.getServletContext().getRealPath(File.separator);
			path = path.substring(0,path.lastIndexOf(File.separator));
			path = path.substring(0,path.lastIndexOf(File.separator));
			path = path.substring(0,path.lastIndexOf(File.separator));
			path = path.substring(0,path.lastIndexOf(File.separator));
			path = path.substring(0,path.lastIndexOf(File.separator));
			path = path.concat(File.separator+"documents"+File.separator+name.trim().replaceAll(" ", "_")+File.separator);
			
			String signatureFilePath = path
					.concat("signature");
			File signatureDocFileToCreate = new File(signatureFilePath, "signature");
			FileUtils.copyFile(signature, signatureDocFileToCreate);// copying source file to new file
			
			String logoFilePath = path
					.concat("companyLogo");
			File logoDocFileToCreate = new File(logoFilePath, "companyLogo");
			FileUtils.copyFile(companyLogo, logoDocFileToCreate);// copying source file to new file
			createCompany.setCompanyLogo(companyLogo!=null?"done":"pending");
			createCompany.setSignature(signature!=null?"done":"pending");
			GameLobbyController gameLobbyController = new GameLobbyController();
			if (gameLobbyController.addNewCompany(createCompany))
				return SUCCESS;
			else
				return ERROR;	
		}catch(Exception e) {
			e.printStackTrace();
			return ERROR;
		}
		
	}

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return SUCCESS;
	}

	public List<String> getCompanyNameList() {
		return companyNameList;
	}

	public void setCompanyNameList(List<String> companyNameList) {
		this.companyNameList = companyNameList;
	}

	public List<CreateCompany> getCompanies() {
		return companies;
	}

	public void setCompanies(List<CreateCompany> companies) {
		this.companies = companies;
	}

	public Integer getCompany_id() {
		return company_id;
	}

	public void setCompany_id(Integer company_id) {
		this.company_id = company_id;
	}

	public CreateCompany getCompanyBean() {
		return companyBean;
	}

	public void setCompanyBean(CreateCompany companyBean) {
		this.companyBean = companyBean;
	}

}
