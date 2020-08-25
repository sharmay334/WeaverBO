package com.stpl.pms.action.bo.um;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.commonJavabeans.EmployeeBean;
import com.stpl.pms.commonJavabeans.EmployeeExpenseBean;
import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.controller.rm.RoleMgmtController;
import com.stpl.pms.controller.um.UserMgmtController;
import com.stpl.pms.exception.PMSException;
import com.stpl.pms.javabeans.CountryBean;
import com.stpl.pms.javabeans.DomainDetailsBean;
import com.stpl.pms.javabeans.UserDetailsBean;
import com.stpl.pms.javabeans.UserPrivBean;
import com.stpl.pms.struts.common.BaseActionSupport;

public class HRMgmtAction extends BaseActionSupport {
	Map<Integer, String> roleMap;
	private String empName;
	private String empUserName;
	private String gender;
	private String email;
	private String phone;
	private String dob;
	private File photoDoc;
	private File oldSalarySlip;
	private File expCertificate;
	private File eduCertificate;
	private File panDoc;
	private File aadharDoc;
	private File voterDoc;
	private File drivingDoc;
	private File passbookDoc;
	private File addressDoc;
	private String approver;
	private String leaves;
	private String attendanceTime;
	private String attendanceSelfie;
	private String dailyAllowance;
	private String dailyAllowanceDoc;
	private String exCityAllowance;
	private String cityAllowance;
	private String travellingAllowance;
	private String weekDay;
	private String department;
	private String role;
	private String region;
	private String country;
	private String branch;
	private String doj;
	private String dol;
	private String authAmount;
	private String panNumber;
	private String aadharNumber;
	private String currentAddress;
	private String permanentAddress;
	private String state;
	private String city;
	private String pincode;
	private String status;
	private Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<String>>>>> rolePrivMap;
	private Set<String> serviceSet;
	private Map<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>> servicePriviledgeMap = new TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>();
	private String[] rolePrivWEB;
	private String[] rolePrivHome;
	private String[] rolePrivCasino;
	private int[] mappingId;
	private int[] privCount;
	private String roleName;

	// registration page variables

	private List<CountryBean> countryList;
	private List<String> branchList;
	private List<String> stateList;
	private List<String> cityList;
	private List<String> regionList;
	private List<String> roleList;
	private List<String> departmentList;
	private List<String> approverList;
	private List<String> attendanceTimeList;
	private EmployeeExpenseBean employeeExpenseBean;

	public String loadEmpExpensPage() {
		return SUCCESS;
	}

	public String uploadExpense() throws IOException {

		GameLobbyController controller = new GameLobbyController();
		employeeExpenseBean.setEmpId(getUserInfoBean().getUserId());
		String filePath = "";
		filePath = ServletActionContext.getServletContext().getRealPath("/");
		filePath = filePath.substring(0, filePath.lastIndexOf("default/"));
		File file = new File(filePath + "expenses/" + employeeExpenseBean.getEmpId());
		if (!employeeExpenseBean.getExpenseDate1().isEmpty() && !employeeExpenseBean.getAmount1().isEmpty()
				&& !employeeExpenseBean.getPicture1FileName().isEmpty()) {
			if (file.mkdir()) {

				String suffix[] = employeeExpenseBean.getExpenseDate1().split(" ");
				File file1 = new File(filePath + "expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
				if (file1.mkdir()) {
					filePath = filePath.concat("expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
					employeeExpenseBean.setPicture1FileName(
							"hotel_" + suffix[0] + "_" + employeeExpenseBean.getPicture1FileName());
					File fileToCreate = null;
					fileToCreate = new File(filePath, employeeExpenseBean.getPicture1FileName());
					FileUtils.copyFile(employeeExpenseBean.getPicture1(), fileToCreate);// copying source file to new
					employeeExpenseBean.setPicture1FileName(filePath+"/"+employeeExpenseBean.getPicture1FileName()); // file
				} else if (file1.exists()) {
					filePath = filePath.concat("expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
					employeeExpenseBean.setPicture1FileName(
							"hotel_" + suffix[0] + "_" + employeeExpenseBean.getPicture1FileName());
					File fileToCreate = null;
					fileToCreate = new File(filePath, employeeExpenseBean.getPicture1FileName());
					FileUtils.copyFile(employeeExpenseBean.getPicture1(), fileToCreate);// copying source file to new
					employeeExpenseBean.setPicture1FileName(filePath+"/"+employeeExpenseBean.getPicture1FileName());

				}
			} else if (file.exists()) {
				String suffix[] = employeeExpenseBean.getExpenseDate1().split(" ");
				File file1 = new File(filePath + "expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
				if (file1.mkdir()) {
					filePath = filePath.concat("expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
					employeeExpenseBean.setPicture1FileName(
							"hotel_" + suffix[0] + "_" + employeeExpenseBean.getPicture1FileName());
					File fileToCreate = null;
					fileToCreate = new File(filePath, employeeExpenseBean.getPicture1FileName());
					FileUtils.copyFile(employeeExpenseBean.getPicture1(), fileToCreate);// copying source file to new
					employeeExpenseBean.setPicture1FileName(filePath+"/"+employeeExpenseBean.getPicture1FileName()); // file
				} else if (file1.exists()) {
					filePath = filePath.concat("expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
					employeeExpenseBean.setPicture1FileName(
							"hotel_" + suffix[0] + "_" + employeeExpenseBean.getPicture1FileName());
					File fileToCreate = null;
					fileToCreate = new File(filePath, employeeExpenseBean.getPicture1FileName());
					FileUtils.copyFile(employeeExpenseBean.getPicture1(), fileToCreate);// copying source file to new
					employeeExpenseBean.setPicture1FileName(filePath+"/"+employeeExpenseBean.getPicture1FileName());

				}

			}

		}

		filePath = "";
		filePath = ServletActionContext.getServletContext().getRealPath("/");
		filePath = filePath.substring(0, filePath.lastIndexOf("default/"));
		if (!employeeExpenseBean.getExpenseDate2().isEmpty() && !employeeExpenseBean.getAmount2().isEmpty()
				&& !employeeExpenseBean.getPicture2FileName().isEmpty()) {
			if (file.mkdir()) {

				String suffix[] = employeeExpenseBean.getExpenseDate2().split(" ");
				File file1 = new File(filePath + "expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
				if (file1.mkdir()) {
					filePath = filePath.concat("expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
					employeeExpenseBean.setPicture2FileName(
							"bus_train_toll_" + suffix[0] + "_" + employeeExpenseBean.getPicture2FileName());
					File fileToCreate = null;
					fileToCreate = new File(filePath, employeeExpenseBean.getPicture2FileName());
					FileUtils.copyFile(employeeExpenseBean.getPicture2(), fileToCreate);// copying source file to new
					employeeExpenseBean.setPicture2FileName(filePath+"/"+employeeExpenseBean.getPicture2FileName()); // file
				} else if (file1.exists()) {
					filePath = filePath.concat("expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
					employeeExpenseBean.setPicture2FileName(
							"bus_train_toll_" + suffix[0] + "_" + employeeExpenseBean.getPicture2FileName());
					File fileToCreate = null;
					fileToCreate = new File(filePath, employeeExpenseBean.getPicture2FileName());
					FileUtils.copyFile(employeeExpenseBean.getPicture2(), fileToCreate);// copying source file to new
					employeeExpenseBean.setPicture2FileName(filePath+"/"+employeeExpenseBean.getPicture2FileName());

				}
			} else if (file.exists()) {
				String suffix[] = employeeExpenseBean.getExpenseDate2().split(" ");
				File file1 = new File(filePath + "expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
				if (file1.mkdir()) {
					filePath = filePath.concat("expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
					employeeExpenseBean.setPicture2FileName(
							"bus_train_toll_" + suffix[0] + "_" + employeeExpenseBean.getPicture2FileName());
					File fileToCreate = null;
					fileToCreate = new File(filePath, employeeExpenseBean.getPicture2FileName());
					FileUtils.copyFile(employeeExpenseBean.getPicture2(), fileToCreate);// copying source file to new
					employeeExpenseBean.setPicture2FileName(filePath+"/"+employeeExpenseBean.getPicture2FileName()); // file
				} else if (file1.exists()) {
					filePath = filePath.concat("expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
					employeeExpenseBean.setPicture2FileName(
							"bus_train_toll_" + suffix[0] + "_" + employeeExpenseBean.getPicture2FileName());
					File fileToCreate = null;
					fileToCreate = new File(filePath, employeeExpenseBean.getPicture2FileName());
					FileUtils.copyFile(employeeExpenseBean.getPicture2(), fileToCreate);// copying source file to new
					employeeExpenseBean.setPicture2FileName(filePath+"/"+employeeExpenseBean.getPicture2FileName());

				}

			}

		}
		filePath = "";
		filePath = ServletActionContext.getServletContext().getRealPath("/");
		filePath = filePath.substring(0, filePath.lastIndexOf("default/"));

		if (!employeeExpenseBean.getExpenseDate3().isEmpty() && !employeeExpenseBean.getAmount3().isEmpty()
				&& !employeeExpenseBean.getPicture3FileName().isEmpty()) {
			if (file.mkdir()) {

				String suffix[] = employeeExpenseBean.getExpenseDate3().split(" ");
				File file1 = new File(filePath + "expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
				if (file1.mkdir()) {
					filePath = filePath.concat("expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
					employeeExpenseBean.setPicture3FileName(
							"pet_deisel_" + suffix[0] + "_" + employeeExpenseBean.getPicture3FileName());
					File fileToCreate = null;
					fileToCreate = new File(filePath, employeeExpenseBean.getPicture3FileName());
					FileUtils.copyFile(employeeExpenseBean.getPicture3(), fileToCreate);// copying source file to new
					employeeExpenseBean.setPicture3FileName(filePath+"/"+employeeExpenseBean.getPicture3FileName()); // file
				} else if (file1.exists()) {
					filePath = filePath.concat("expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
					employeeExpenseBean.setPicture3FileName(
							"pet_deisel_" + suffix[0] + "_" + employeeExpenseBean.getPicture3FileName());
					File fileToCreate = null;
					fileToCreate = new File(filePath, employeeExpenseBean.getPicture3FileName());
					FileUtils.copyFile(employeeExpenseBean.getPicture3(), fileToCreate);// copying source file to new
					employeeExpenseBean.setPicture3FileName(filePath+"/"+employeeExpenseBean.getPicture3FileName());

				}
			} else if (file.exists()) {
				String suffix[] = employeeExpenseBean.getExpenseDate3().split(" ");
				File file1 = new File(filePath + "expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
				if (file1.mkdir()) {
					filePath = filePath.concat("expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
					employeeExpenseBean.setPicture3FileName(
							"pet_deisel_" + suffix[0] + "_" + employeeExpenseBean.getPicture3FileName());
					File fileToCreate = null;
					fileToCreate = new File(filePath, employeeExpenseBean.getPicture3FileName());
					FileUtils.copyFile(employeeExpenseBean.getPicture3(), fileToCreate);// copying source file to new
					employeeExpenseBean.setPicture3FileName(filePath+"/"+employeeExpenseBean.getPicture3FileName()); // file
				} else if (file1.exists()) {
					filePath = filePath.concat("expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
					employeeExpenseBean.setPicture3FileName(
							"pet_deisel_" + suffix[0] + "_" + employeeExpenseBean.getPicture3FileName());
					File fileToCreate = null;
					fileToCreate = new File(filePath, employeeExpenseBean.getPicture3FileName());
					FileUtils.copyFile(employeeExpenseBean.getPicture3(), fileToCreate);// copying source file to new
					employeeExpenseBean.setPicture3FileName(filePath+"/"+employeeExpenseBean.getPicture3FileName());

				}

			}

		}
		filePath = "";
		filePath = ServletActionContext.getServletContext().getRealPath("/");
		filePath = filePath.substring(0, filePath.lastIndexOf("default/"));

		if (!employeeExpenseBean.getExpenseDate4().isEmpty() && !employeeExpenseBean.getAmount4().isEmpty()
				&& !employeeExpenseBean.getPicture4FileName().isEmpty()) {
			if (file.mkdir()) {

				String suffix[] = employeeExpenseBean.getExpenseDate4().split(" ");
				File file1 = new File(filePath + "expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
				if (file1.mkdir()) {
					filePath = filePath.concat("expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
					employeeExpenseBean.setPicture4FileName(
							"other_" + suffix[0] + "_" + employeeExpenseBean.getPicture4FileName());
					File fileToCreate = null;
					fileToCreate = new File(filePath, employeeExpenseBean.getPicture4FileName());
					FileUtils.copyFile(employeeExpenseBean.getPicture4(), fileToCreate);// copying source file to new
					employeeExpenseBean.setPicture4FileName(filePath+"/"+employeeExpenseBean.getPicture4FileName()); // file
				} else if (file1.exists()) {
					filePath = filePath.concat("expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
					employeeExpenseBean.setPicture4FileName(
							"other_" + suffix[0] + "_" + employeeExpenseBean.getPicture4FileName());
					File fileToCreate = null;
					fileToCreate = new File(filePath, employeeExpenseBean.getPicture4FileName());
					FileUtils.copyFile(employeeExpenseBean.getPicture4(), fileToCreate);// copying source file to new
					employeeExpenseBean.setPicture4FileName(filePath+"/"+employeeExpenseBean.getPicture4FileName());

				}
			} else if (file.exists()) {
				String suffix[] = employeeExpenseBean.getExpenseDate4().split(" ");
				File file1 = new File(filePath + "expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
				if (file1.mkdir()) {
					filePath = filePath.concat("expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
					employeeExpenseBean.setPicture4FileName(
							"other_" + suffix[0] + "_" + employeeExpenseBean.getPicture4FileName());
					File fileToCreate = null;
					fileToCreate = new File(filePath, employeeExpenseBean.getPicture4FileName());
					FileUtils.copyFile(employeeExpenseBean.getPicture4(), fileToCreate);// copying source file to new
					employeeExpenseBean.setPicture4FileName(filePath+"/"+employeeExpenseBean.getPicture4FileName()); // file
				} else if (file1.exists()) {
					filePath = filePath.concat("expenses/" + employeeExpenseBean.getEmpId() + "/" + suffix[0]);
					employeeExpenseBean.setPicture4FileName(
							"other_" + suffix[0] + "_" + employeeExpenseBean.getPicture4FileName());
					File fileToCreate = null;
					fileToCreate = new File(filePath, employeeExpenseBean.getPicture4FileName());
					FileUtils.copyFile(employeeExpenseBean.getPicture4(), fileToCreate);// copying source file to new
					employeeExpenseBean.setPicture4FileName(filePath+"/"+employeeExpenseBean.getPicture4FileName());

				}

			}

		}
		if (controller.insertOrUpdateExpenses(employeeExpenseBean))
			return SUCCESS;
		else
			return ERROR;
	}

	public String newSubUserReg() {
		HttpSession session = getRequest().getSession();
		int orgId = userInfoBean.getUserId();
		int roleId = userInfoBean.getRoleId();
		String type = userInfoBean.getUserType();

		UserMgmtController service = new UserMgmtController();
		// PrivFunctionBean privFunctionBean = (PrivFunctionBean)
		// request.getAttribute("ALLOWED_PRIV");

		boolean returnType;
		try {
			if (!callDocumentsUpload()) {
				addActionError("Error in file upload!");
				return "exception";
			}

			returnType = service.checkUsernameAvailability(getEmpUserName(), userInfoBean.getDomainId());

			if (!returnType) {
				addFieldError("userName", "User Name Already Exists !!");
				return INPUT;
			}
			if (!service.checkUserEmailIdAvailability(getEmail(), userInfoBean.getDomainId())) {
				addFieldError("email", "Email Id Already Exists !!");
				return INPUT;
			}
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}

		RoleMgmtController roleMgmtHelper = new RoleMgmtController();

		// now get the priviledges list of head
		try {
			rolePrivMap = roleMgmtHelper.getHeadsGroupNames(userInfoBean.getUserId(), userInfoBean.getRoleId(),
					userInfoBean.getUserType(), userInfoBean.getDomainId());

			// getParentRoleActivePriv(userBean.getUserName());

			serviceSet = new TreeSet<String>(rolePrivMap.keySet());
			for (String key : servicePriviledgeMap.keySet()) {
				if (!serviceSet.contains(key)) {
					serviceSet.add(key);
					TreeMap<String, TreeMap<String, TreeMap<String, List<String>>>> interfaceMap = new TreeMap<String, TreeMap<String, TreeMap<String, List<String>>>>();
					for (String serKey : servicePriviledgeMap.get(key).keySet()) {
						interfaceMap.put(serKey, null);
					}
					rolePrivMap.put(key, interfaceMap);
				}
			}

			// put user details in session
			UserDetailsBean usrdetBean = new UserDetailsBean();
			usrdetBean.setFirstName(getEmpName());
			usrdetBean.setLastName(getEmpName());
			usrdetBean.setEmailId(getEmail());
			usrdetBean.setPhoneNbr(getPhone());
			usrdetBean.setSecQues("");
			usrdetBean.setSecAns("");
			usrdetBean.setUserName(getEmpUserName());
			usrdetBean.setStatus(getStatus());
			usrdetBean.setOrgId(orgId);
			usrdetBean.setRoleId(roleId);
			usrdetBean.setOrgType(type);
			usrdetBean.setBoUserType(type);
			usrdetBean.setGender(gender);
			usrdetBean.setDob(dob);
			usrdetBean.setPanNumber(panNumber);
			usrdetBean.setAadharNumber(aadharNumber);
			usrdetBean.setBranch(branch);
			usrdetBean.setCurrentAddress(currentAddress);
			usrdetBean.setPermanentAddress(permanentAddress);
			usrdetBean.setDoj(doj);
			usrdetBean.setDol(dol);
			usrdetBean.setCountry(country);
			usrdetBean.setState(state);
			usrdetBean.setPincode(pincode);
			usrdetBean.setCity(city);
			usrdetBean.setPhoto_doc(photoDoc != null ? status : "pending");
			usrdetBean.setOldSalarySlip(oldSalarySlip != null ? status : "pending");
			usrdetBean.setExpCertificate(expCertificate != null ? status : "pending");
			usrdetBean.setEduCertificate(eduCertificate != null ? status : "pending");
			usrdetBean.setPanDoc(panDoc != null ? status : "pending");
			usrdetBean.setAddressDoc(addressDoc != null ? status : "pending");
			usrdetBean.setVoterDoc(voterDoc != null ? status : "pending");
			usrdetBean.setDrivingDoc(drivingDoc != null ? status : "pending");
			usrdetBean.setPassbookDoc(passbookDoc != null ? status : "pending");
			usrdetBean.setAddressDoc(addressDoc != null ? status : "pending");
			usrdetBean.setDepartment(department);
			usrdetBean.setRole(role);
			usrdetBean.setRegion(region);
			usrdetBean.setWeekDay(weekDay);
			usrdetBean.setTravellingAllowance(travellingAllowance);
			usrdetBean.setCityAllowance(cityAllowance);
			usrdetBean.setExCityAllowance(exCityAllowance);
			usrdetBean.setDailyAllowance(dailyAllowance);
			usrdetBean.setDailyAllowanceDoc(dailyAllowanceDoc);
			usrdetBean.setAttendanceSelfie(attendanceSelfie);
			usrdetBean.setAttendanceTime(attendanceTime);
			usrdetBean.setLeaves(leaves);
			usrdetBean.setAuthAmount(authAmount);
			usrdetBean.setApprover(approver);
			session.setAttribute("USER_DETAILS", usrdetBean);
			session.setAttribute("HEAD_PRIV_MAP", rolePrivMap);

			return SUCCESS;
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception";
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
	}

	public boolean callDocumentsUpload() {
		try {
			String path = ServletActionContext.getServletContext().getRealPath(File.separator);
			path = path.substring(0, path.lastIndexOf("default/"));
			path = path.concat(File.separator + "documents" + File.separator + empUserName + File.separator);

			String photo_docFilePath = path.concat("photoDoc");
			File photo_docFileToCreate = new File(photo_docFilePath, "photoDoc");
			FileUtils.copyFile(photoDoc, photo_docFileToCreate);// copying source file to new file

			String addressDocFilePath = path.concat("addressDoc");
			File addressDocFileToCreate = new File(addressDocFilePath, "addressDoc");
			if (addressDoc != null)
				FileUtils.copyFile(addressDoc, addressDocFileToCreate);// copying source file to new file

			String oldSalarySlipFilePath = path.concat("oldSalarySlip");
			File oldSalarySlipFileToCreate = new File(oldSalarySlipFilePath, "oldSalarySlip");
			if (oldSalarySlip != null)
				FileUtils.copyFile(oldSalarySlip, oldSalarySlipFileToCreate);// copying source file to new file

			String expCertificateFilePath = path.concat("expCertificate");
			File expCertificateFileToCreate = new File(expCertificateFilePath, "expCertificate");
			if (expCertificate != null)
				FileUtils.copyFile(expCertificate, expCertificateFileToCreate);// copying source file to new file

			String eduCertificateFilePath = path.concat("eduCertificate");
			File eduCertificateFileToCreate = new File(eduCertificateFilePath, "eduCertificate");
			if (eduCertificate != null)
				FileUtils.copyFile(eduCertificate, eduCertificateFileToCreate);// copying source file to new file

			String panDocFilePath = path.concat("panDoc");
			File panDocFileToCreate = new File(panDocFilePath, "panDoc");
			if (panDoc != null)
				FileUtils.copyFile(panDoc, panDocFileToCreate);// copying source file to new file

			String aadharDocFilePath = path.concat("aadharDoc");
			File aadharDocFileToCreate = new File(aadharDocFilePath, "aadharDoc");
			if (aadharDoc != null)
				FileUtils.copyFile(aadharDoc, aadharDocFileToCreate);// copying source file to new file

			String voterDocFilePath = path.concat("voterDoc");
			File voterDocFileToCreate = new File(voterDocFilePath, "voterDoc");
			if (voterDoc != null)
				FileUtils.copyFile(voterDoc, voterDocFileToCreate);// copying source file to new file

			String drivingDocFilePath = path.concat("drivingDoc");
			File drivingDocFileToCreate = new File(drivingDocFilePath, "drivingDoc");
			if (drivingDoc != null)
				FileUtils.copyFile(drivingDoc, drivingDocFileToCreate);// copying source file to new file

			String passbookDocFilePath = path.concat("passbookDoc");
			File passbookDocFileToCreate = new File(passbookDocFilePath, "passbookDoc");
			if (passbookDoc != null)
				FileUtils.copyFile(passbookDoc, passbookDocFileToCreate);// copying source file to new file

		} catch (Exception e) {
			e.printStackTrace();

			return false; // bypass the file upload temporary
		}
		return true;
	}

	public String assignSubUserPriviledges() {

		HttpSession session = getRequest().getSession();
		UserDetailsBean usrdetBean = (UserDetailsBean) session.getAttribute("USER_DETAILS");
		short roleId = Short.valueOf(userInfoBean.getRoleId() + "");
		UserMgmtController service = new UserMgmtController();
		// PrivFunctionBean privFunctionBean = (PrivFunctionBean)
		// request.getAttribute("ALLOWED_PRIV");

		try {
			rolePrivWEB = (String[]) ArrayUtils.addAll(rolePrivCasino, rolePrivHome);
			if (privCount.length == 1) {
				if (rolePrivCasino != null)
					privCount[0] = rolePrivCasino.length;
				if (rolePrivHome != null)
					privCount[0] = rolePrivHome.length;
			} else {

				if (userInfoBean.getUserType().equals("DOMAIN")) {
					if (null != rolePrivCasino) {
						privCount[0] = rolePrivCasino.length;
					}
					if (null != rolePrivHome) {
						privCount[0] = rolePrivHome.length;
					} else if (null == rolePrivWEB) {
						privCount[1] = 0;
					}

				} else {
					if (null != rolePrivCasino) {
						privCount[0] = rolePrivCasino.length;
					}
					if (null != rolePrivHome) {
						privCount[1] = rolePrivHome.length;
					} else if (null == rolePrivWEB) {
						privCount[0] = 0;
					}
				}
			}
			// domainId 0 For BO
			roleName = userInfoBean.getRoleName();
			short domainId = userInfoBean.getDomainId();
			service.assignGroups(userInfoBean.getUserId(), rolePrivWEB, roleId, usrdetBean, mappingId, privCount,
					"ipAddress", domainId);
			/*
			 * if (CommonMethodController.getInstance().isRummyActive()) { RummyAPI rummyAPI
			 * = new RummyAPI(); String rolePriv = ""; if (rolePrivRUMMY != null) { rolePriv
			 * = Arrays.asList(rolePrivRUMMY).toString().replace("[", "").replace("]", "")
			 * .replace(" ", "").replace(",", "-"); }
			 * rummyAPI.createSubUser(userInfoBean.getUserName(), rolePriv, usrdetBean,
			 * roleName); }
			 */
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception";
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		GameLobbyController controller = new GameLobbyController();
		try {
			if (userInfoBean.getIsMasterRole().equalsIgnoreCase("N")
					|| userInfoBean.getIsRoleHeadUser().equalsIgnoreCase("N")) {
				return "unauthorize";
			}
			// PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
			// .getAttribute("ALLOWED_PRIV");
			RoleMgmtController roleMgmtController = new RoleMgmtController();

			roleMap = roleMgmtController.fetchRoles(userInfoBean.getUserType(), true, userInfoBean.getUserId());
			countryList = controller.getCountryList();
			branchList = controller.getDynamicFieldList("branch");
			stateList = controller.getStateList();
			cityList = controller.getCityList();
			regionList = controller.getDynamicFieldList("region");
			roleList = controller.getDynamicFieldList("role");
			departmentList = controller.getDynamicFieldList("department");
			approverList = controller.getApproverList();
			attendanceTimeList = controller.getDynamicFieldList("Attendance Time");
		} catch (PMSException be) {
			addActionError(be.getErrorMessage());
			return "exception";
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		getRequest().getSession().setAttribute("roleMap", roleMap);
		return SUCCESS;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getEmpUserName() {
		return empUserName;
	}

	public void setEmpUserName(String empUserName) {
		this.empUserName = empUserName;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

	public File getPhotoDoc() {
		return photoDoc;
	}

	public void setPhotoDoc(File photoDoc) {
		this.photoDoc = photoDoc;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getBranch() {
		return branch;
	}

	public void setBranch(String branch) {
		this.branch = branch;
	}

	public String getDoj() {
		return doj;
	}

	public void setDoj(String doj) {
		this.doj = doj;
	}

	public String getDol() {
		return dol;
	}

	public void setDol(String dol) {
		this.dol = dol;
	}

	public String getPanNumber() {
		return panNumber;
	}

	public void setPanNumber(String panNumber) {
		this.panNumber = panNumber;
	}

	public String getAadharNumber() {
		return aadharNumber;
	}

	public void setAadharNumber(String aadharNumber) {
		this.aadharNumber = aadharNumber;
	}

	public String getCurrentAddress() {
		return currentAddress;
	}

	public void setCurrentAddress(String currentAddress) {
		this.currentAddress = currentAddress;
	}

	public String getPermanentAddress() {
		return permanentAddress;
	}

	public void setPermanentAddress(String permanentAddress) {
		this.permanentAddress = permanentAddress;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Map<Integer, String> getRoleMap() {
		return roleMap;
	}

	public void setRoleMap(Map<Integer, String> roleMap) {
		this.roleMap = roleMap;
	}

	public Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<String>>>>> getRolePrivMap() {
		return rolePrivMap;
	}

	public void setRolePrivMap(
			Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<String>>>>> rolePrivMap) {
		this.rolePrivMap = rolePrivMap;
	}

	public Set<String> getServiceSet() {
		return serviceSet;
	}

	public void setServiceSet(Set<String> serviceSet) {
		this.serviceSet = serviceSet;
	}

	public Map<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>> getServicePriviledgeMap() {
		return servicePriviledgeMap;
	}

	public void setServicePriviledgeMap(
			Map<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>> servicePriviledgeMap) {
		this.servicePriviledgeMap = servicePriviledgeMap;
	}

	public String[] getRolePrivWEB() {
		return rolePrivWEB;
	}

	public void setRolePrivWEB(String[] rolePrivWEB) {
		this.rolePrivWEB = rolePrivWEB;
	}

	public String[] getRolePrivHome() {
		return rolePrivHome;
	}

	public void setRolePrivHome(String[] rolePrivHome) {
		this.rolePrivHome = rolePrivHome;
	}

	public String[] getRolePrivCasino() {
		return rolePrivCasino;
	}

	public void setRolePrivCasino(String[] rolePrivCasino) {
		this.rolePrivCasino = rolePrivCasino;
	}

	public int[] getMappingId() {
		return mappingId;
	}

	public void setMappingId(int[] mappingId) {
		this.mappingId = mappingId;
	}

	public int[] getPrivCount() {
		return privCount;
	}

	public void setPrivCount(int[] privCount) {
		this.privCount = privCount;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public List<String> getBranchList() {
		return branchList;
	}

	public void setBranchList(List<String> branchList) {
		this.branchList = branchList;
	}

	public List<CountryBean> getCountryList() {
		return countryList;
	}

	public void setCountryList(List<CountryBean> countryList) {
		this.countryList = countryList;
	}

	public List<String> getStateList() {
		return stateList;
	}

	public void setStateList(List<String> stateList) {
		this.stateList = stateList;
	}

	public List<String> getCityList() {
		return cityList;
	}

	public void setCityList(List<String> cityList) {
		this.cityList = cityList;
	}

	public List<String> getRegionList() {
		return regionList;
	}

	public void setRegionList(List<String> regionList) {
		this.regionList = regionList;
	}

	public List<String> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<String> roleList) {
		this.roleList = roleList;
	}

	public List<String> getDepartmentList() {
		return departmentList;
	}

	public void setDepartmentList(List<String> departmentList) {
		this.departmentList = departmentList;
	}

	public List<String> getApproverList() {
		return approverList;
	}

	public void setApproverList(List<String> approverList) {
		this.approverList = approverList;
	}

	public List<String> getAttendanceTimeList() {
		return attendanceTimeList;
	}

	public void setAttendanceTimeList(List<String> attendanceTimeList) {
		this.attendanceTimeList = attendanceTimeList;
	}

	public File getOldSalarySlip() {
		return oldSalarySlip;
	}

	public void setOldSalarySlip(File oldSalarySlip) {
		this.oldSalarySlip = oldSalarySlip;
	}

	public File getExpCertificate() {
		return expCertificate;
	}

	public void setExpCertificate(File expCertificate) {
		this.expCertificate = expCertificate;
	}

	public File getEduCertificate() {
		return eduCertificate;
	}

	public void setEduCertificate(File eduCertificate) {
		this.eduCertificate = eduCertificate;
	}

	public File getPanDoc() {
		return panDoc;
	}

	public void setPanDoc(File panDoc) {
		this.panDoc = panDoc;
	}

	public File getAadharDoc() {
		return aadharDoc;
	}

	public void setAadharDoc(File aadharDoc) {
		this.aadharDoc = aadharDoc;
	}

	public File getVoterDoc() {
		return voterDoc;
	}

	public void setVoterDoc(File voterDoc) {
		this.voterDoc = voterDoc;
	}

	public File getDrivingDoc() {
		return drivingDoc;
	}

	public void setDrivingDoc(File drivingDoc) {
		this.drivingDoc = drivingDoc;
	}

	public File getPassbookDoc() {
		return passbookDoc;
	}

	public void setPassbookDoc(File passbookDoc) {
		this.passbookDoc = passbookDoc;
	}

	public File getAddressDoc() {
		return addressDoc;
	}

	public void setAddressDoc(File addressDoc) {
		this.addressDoc = addressDoc;
	}

	public String getApprover() {
		return approver;
	}

	public void setApprover(String approver) {
		this.approver = approver;
	}

	public String getLeaves() {
		return leaves;
	}

	public void setLeaves(String leaves) {
		this.leaves = leaves;
	}

	public String getAttendanceTime() {
		return attendanceTime;
	}

	public void setAttendanceTime(String attendanceTime) {
		this.attendanceTime = attendanceTime;
	}

	public String getAttendanceSelfie() {
		return attendanceSelfie;
	}

	public void setAttendanceSelfie(String attendanceSelfie) {
		this.attendanceSelfie = attendanceSelfie;
	}

	public String getDailyAllowance() {
		return dailyAllowance;
	}

	public void setDailyAllowance(String dailyAllowance) {
		this.dailyAllowance = dailyAllowance;
	}

	public String getDailyAllowanceDoc() {
		return dailyAllowanceDoc;
	}

	public void setDailyAllowanceDoc(String dailyAllowanceDoc) {
		this.dailyAllowanceDoc = dailyAllowanceDoc;
	}

	public String getExCityAllowance() {
		return exCityAllowance;
	}

	public void setExCityAllowance(String exCityAllowance) {
		this.exCityAllowance = exCityAllowance;
	}

	public String getCityAllowance() {
		return cityAllowance;
	}

	public void setCityAllowance(String cityAllowance) {
		this.cityAllowance = cityAllowance;
	}

	public String getTravellingAllowance() {
		return travellingAllowance;
	}

	public void setTravellingAllowance(String travellingAllowance) {
		this.travellingAllowance = travellingAllowance;
	}

	public String getWeekDay() {
		return weekDay;
	}

	public void setWeekDay(String weekDay) {
		this.weekDay = weekDay;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getAuthAmount() {
		return authAmount;
	}

	public void setAuthAmount(String authAmount) {
		this.authAmount = authAmount;
	}

	public EmployeeExpenseBean getEmployeeExpenseBean() {
		return employeeExpenseBean;
	}

	public void setEmployeeExpenseBean(EmployeeExpenseBean employeeExpenseBean) {
		this.employeeExpenseBean = employeeExpenseBean;
	}

}
