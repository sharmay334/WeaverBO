package com.stpl.pms.action.bo.um;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.ArrayUtils;
import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.stpl.pms.controller.commonMethods.CommonMethodController;
import com.stpl.pms.controller.rm.RoleMgmtController;
import com.stpl.pms.controller.um.UserMgmtController;
import com.stpl.pms.exception.PMSException;
import com.stpl.pms.javabeans.DomainDetailsBean;
import com.stpl.pms.javabeans.UserDetailsBean;
import com.stpl.pms.javabeans.UserInfoBean;
import com.stpl.pms.javabeans.UserPrivBean;
import com.stpl.pms.struts.common.BaseActionSupport;
import com.stpl.pms.utility.AutoGenerate;
import com.stpl.pms.utility.UserValidation;

public class UserMgmtAction extends BaseActionSupport {
	private static final Logger log = Logger.getLogger(UserMgmtAction.class);
	private static final long serialVersionUID = 1L;
	Map<Integer, String> roleMap;
	private Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<String>>>>> rolePrivMap;
	private Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>> rolePriviledgeMap;
	private Set<String> serviceSet;
	private List<String> subUserList;
	private String email;
	private String firstName;
	private String lastName;
	private String lastnameedit;
	private String gender;
	private String phone;
	private String role;
	private String secAns;
	private String secQues;
	private String status;
	private String userName;
	private int[] mappingId;
	private int[] privCount;
	private String[] rolePrivRUMMY;
	private String[] rolePrivWEB;
	private String[] rolePrivHome;
	private String[] rolePrivCasino;
	private Set<String> tempUserList;
	private int roleId;
	private String type;
	private String end = null;
	private UserDetailsBean userDetailsBean;
	private int user_id;
	private short domainId;
	private String emailId;
	private String phoneNbr;
	private String roleName;
	private String[] roleServicePriv;
	private int[] servicePrivCount;

	private DomainDetailsBean domainDetailsBean;
	private Map<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>> servicePriviledgeMap = new TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>();
	private List<UserDetailsBean> userList;
	private Map<Integer, String> boUserMap;
	private Integer impersonateeId;
	@Override
	public String execute() {
		try {
		if (userInfoBean.getIsMasterRole().equalsIgnoreCase("N")
				|| userInfoBean.getIsRoleHeadUser().equalsIgnoreCase("N")) {
			return "unauthorize";
		}
//		PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
//		.getAttribute("ALLOWED_PRIV");
		RoleMgmtController roleMgmtController = new RoleMgmtController();
		
				roleMap = roleMgmtController.fetchRoles(userInfoBean.getUserType(), true,userInfoBean.getUserId());
		} catch (PMSException be) {
			addActionError(be.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		getRequest().getSession().setAttribute("roleMap", roleMap);
		return SUCCESS;
	}

	public void validate() {
		HttpSession session = getRequest().getSession();
				ResourceBundle bundle;
		if(session.getAttribute("localeValue")==null)
			bundle = ResourceBundle.getBundle("global",new Locale("en"));
		else
			 bundle = ResourceBundle.getBundle("global",new Locale(session.getAttribute("localeValue").toString()));
		
		try {
		String actionName = (String) ActionContext.getContext().getContextMap()
				.get(ActionContext.ACTION_NAME);
		
		if (actionName.equals("bo_um_editBoSubUserPriv_Save")) {
			if (rolePrivCasino ==null && rolePrivRUMMY == null && rolePrivHome == null ) {
				addFieldError("rolePriv", bundle.getString("global.um.priverr"));
			}
		}
		if (actionName.equals("bo_um_boUserReg_Save")
				|| actionName.equals("bo_um_addBoSubUser_Save")) {
			if (firstName.equals("") || firstName == null) {
				addFieldError("firstName", "Please enter the First name");
			}
			if (!(firstName.equals("") || firstName == null))
				if (!UserValidation.isAlphabetic(firstName, false)) {
					addFieldError("firstName",
							"Please enter the First name Correctly");
				}
			if (lastName.equals("") || lastName == null) {
				addFieldError("lastName", "Please enter the Last name");
			}
			if (!(lastName.equals("") || lastName == null))
				if (!UserValidation.isAlphabetic(lastName, false)) {
					addFieldError("lastName",
							"Please enter the Last name Correctly");
				}
			if (gender.equals("-1")) {
				addFieldError("gender", "Please Select Gender");
			}
			if (userName.equals("") || userName == null) {
				addFieldError("userName", "Please enter the Login name");
			}
			if (!(userName.equals("") || userName == null))
				if (!UserValidation.isAlphanumeric(userName, false)) {
					addFieldError("userName",
							"Please enter the Login name Correctly");
				}
			if (email.equals("") || email == null) {
				addFieldError("email", "Enter the email");

			}
			if (!(email.equals("") || email == null))
				if (!UserValidation.validateEmail(email)) {
					addFieldError("email", "Email is Invalid");
				}
			if (phone.equals("")) {
				addFieldError("phone", "Please enter a valid phone number");
			}
			if (actionName.equals("bo_um_boUserReg_Save")) {
				if (role.equals("-1")) {
					addFieldError("role", "Please Select Any role");
				}
			}
			if (secQues.equals("-1")) {
				addFieldError("secQues", "Please Select Any Security Question");
			}
			if (secAns.equals("") || secAns == null) {
				addFieldError("secAns", "Please Enter Security Answer");

			}
		}
		if (actionName.equals("bo_um_searchBoUser_Search")) {
			if (!userName.equals("")) {
				if (!UserValidation.isAlphabetic(userName, false)) {
					addFieldError("userName", "Please Enter a valid first Name");
				}
			}
			/*
			 * if(!(roleMap.containsValue(role) || role.equals("-1"))){
			 * addFieldError("role","Enter the valid Department"); }
			 */

		}
		if (actionName.equals("bo_um_searchBoUser_Save")) {
			if (email == null || email.equals("")) {
				addFieldError("emailId", "Please Enter the Email");
			} else {
				if (!UserValidation.validateEmail(email)) {
					addFieldError("emailId", "Please Enter the Valid Email");
				}
			}
			if (phoneNbr == null || phoneNbr.equals("")) {
				addFieldError("phoneNbr", "Please Enter the phone no.");
			}
			if (!phoneNbr.equals("")) {
				if (!UserValidation.isNumeric(phoneNbr, false)) {
					addFieldError("phoneNbr", "Please Enter valid phone no.");
				} else if (phoneNbr.length() != 10) {
					addFieldError("phoneNbr",
							"Please Enter the 10 digits phone no.");
				}
			}
			UserMgmtController service = new UserMgmtController();
//			PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
//					.getAttribute("ALLOWED_PRIV");
			
				userDetailsBean = service.showBOUserDetails(user_id, type);
			}
		}catch (PMSException e) {
				e.printStackTrace();
			}catch (Exception be) {
				be.printStackTrace();
			}
		}

	public void validateBOUsername(){
		UserMgmtController object1 = new UserMgmtController();
		try {
			boolean isAvailable = object1.checkUsernameAvailability(userName,userInfoBean.getDomainId());
			if (isAvailable) {
				String message = "Available";
				response.getWriter().write(
						"<valid><message><p >" + message
								+ "</p></message></valid>");
			} else {
				String message = "Not Available";
				response.getWriter().write(
						"<valid><message><p>" +message
								+ "</p></message></valid>");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return;
	}

	public void checkUserEmailIdAvailability(){
		UserMgmtController object1 = new UserMgmtController();
		try {
			String oldEmailId=request.getParameter("prevEmailId");
			boolean isAvailable = object1.checkUserEmailIdAvailability(email,userInfoBean.getDomainId());
			if(oldEmailId!=null){
				if(oldEmailId.equals(email))
					isAvailable=true;
			}
			if (isAvailable) {
				String message = "Available";
				response.getWriter().write(
						"<valid><message><p>" + message
								+ "</p></message></valid>");
			} else {
				String message = "Not Available";
				response.getWriter().write(
						"<valid><message><p>" + message
								+ "</p></message></valid>");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return;
	}

	public void checkUserEmailIdAvailabilityForDomain(){
		UserMgmtController object1 = new UserMgmtController();
		try {
			boolean isAvailable = object1.checkUserEmailIdAvailabilityForDomain(email,domainId,user_id);
			if (isAvailable) {
				String message = "Available";
				response.getWriter().write(
						"<valid><message><p>" + message
								+ "</p></message></valid>");
			} else {
				String message = "Not Available";
				response.getWriter().write(
						"<valid><message><p>" + message
								+ "</p></message></valid>");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return;
	}
	
	public String createUser() {
		String returnType = "ERROR";
		UserMgmtController service = new UserMgmtController();

		try {
			returnType = "SUCCESS";
			if (!service.checkUserEmailIdAvailability(email,userInfoBean.getDomainId())) {
				addFieldError("email", "Email Id Already Exists !!");
				execute();
				return INPUT;
			}
			returnType = service.createBoUser(userInfoBean, userName, status,
					secQues, secAns, firstName, lastName, gender, email, phone,
					role, "");
			if (CommonMethodController.getInstance().isRummyActive()) {
//				RummyAPI api = new RummyAPI();
//				api.createUser(userName, status, secQues, secAns, firstName, lastName, gender, email, phone, roleName,
//						userInfoBean.getUserName());
			}
		} catch (PMSException be) {
			addActionError(be.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		getRequest().getSession().setAttribute("USER_NAME", getUserName());
		
		if (returnType.equals("USER_ALREADY_EXIST")) {
			addFieldError("userName", "Please Enter another User Name");
			execute();
			log.info(roleMap);
			return INPUT;
		} else if (returnType.equals("SUCCESS")) {
			return SUCCESS;
		}

		addActionError("PLEASE ENTER USER NAME!!");
		return ERROR;

	}

	public void createGameServiceBOUser(UserInfoBean parentUserBean) {
		try {
			UserDetailsBean userBean = new UserDetailsBean();
			userBean.setFirstName(firstName);
			userBean.setLastName(lastName);
			userBean.setGender(gender);
			userBean.setUserName(userName);
			userBean.setPhoneNbr(phone);
			userBean.setEmailId(email);
			userBean.setSecQues(secQues);
			userBean.setSecAns(secAns);
			userBean.setStatus(status);
//			PrivFunctionBean privFunctionBean = (PrivFunctionBean) request.getAttribute("ALLOWED_PRIV");
//			Map<String, TreeMap<String, Integer>> activeServiceMap = service.fetchActiveServices("BO");
//			for (String entry : activeServiceMap.keySet()) {
//				String[] key = entry.split("#");
//				String serviceCode = key[0];
//			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void getParentRoleActivePriv(String parentUserName) {
//		RoleMgmtController service = new RoleMgmtController();
//		try {
//			PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
//					.getAttribute("ALLOWED_PRIV");
//
//			Map<String, TreeMap<String, Integer>> activeServiceMap = service.fetchActiveServices("BO", privFunctionBean);
//			for (Map.Entry<String, TreeMap<String, Integer>> entry : activeServiceMap
//					.entrySet()) {
//				String[] key = entry.getKey().split("#");
//				String serviceCode = key[0];
//			}
//
//		} catch (PMSException e) {
//			e.printStackTrace();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
	}

	public void createSubUserService(UserInfoBean parentUserBean,
			UserDetailsBean userDetails) {
		StringBuilder privGroup = null;
		String grpNameStr = null;
		int privIdFrm = 0;
		int privIdTo = 0;
		HashMap<Integer, String> privMap = new HashMap<Integer, String>();
		try{
		for (int i = 0; i < mappingId.length; i++) {
			if (servicePrivCount[i] != 0) {
				privGroup = new StringBuilder("");
				privIdTo = privIdTo + servicePrivCount[i];
				for (int j = privIdFrm; j < privIdTo; j++) {
					privGroup.append("'" + roleServicePriv[j] + "',");
					privIdFrm++;
				}
				grpNameStr = privGroup.substring(0, privGroup.length() - 1);
				privMap.put(mappingId[i], grpNameStr);
			}
		}
	}catch (Exception be) {
			be.printStackTrace();
		}
	}
//		RoleMgmtController service = new RoleMgmtController();

//		try {
//			PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
//					.getAttribute("ALLOWED_PRIV");
//
//			Map<String, TreeMap<String, Integer>> activeServiceMap = service
//					.fetchActiveServices("BO", privFunctionBean);
//			for (Map.Entry<String, TreeMap<String, Integer>> entry : activeServiceMap
//					.entrySet()) {
//				String[] key = entry.getKey().split("#");
//				String serviceCode = key[0];
//			}
//		} catch (PMSException e) {
//			e.printStackTrace();
//		}

	public void getSubUserServicePriv(String userName) {
//		RoleMgmtController service = new RoleMgmtController();
//		PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
//				.getAttribute("ALLOWED_PRIV");
//		try {
//			Map<String, TreeMap<String, Integer>> activeServiceMap = service
//					.fetchActiveServices("BO", privFunctionBean);
//			for (Map.Entry<String, TreeMap<String, Integer>> entry : activeServiceMap
//					.entrySet()) {
//				String[] key = entry.getKey().split("#");
//				String serviceCode = key[0];
//				String serviceDispName = key[1];
//			}
//
//		} catch (PMSException e) {
//			e.printStackTrace();
//		}
	}

	public void editSubUserServicePriv() {
		StringBuilder privGroup = null;
		String grpNameStr = null;
		int privIdFrm = 0;
		int privIdTo = 0;
		HashMap<Integer, String> privMap = new HashMap<Integer, String>();
		try{
		for (int i = 0; i < mappingId.length; i++) {
			if (servicePrivCount[i] != 0) {
				privGroup = new StringBuilder("");
				privIdTo = privIdTo + servicePrivCount[i];
				for (int j = privIdFrm; j < privIdTo; j++) {
					privGroup.append("'" + roleServicePriv[j] + "',");
					privIdFrm++;
				}
				grpNameStr = privGroup.substring(0, privGroup.length() - 1);
				privMap.put(mappingId[i], grpNameStr);
				}
			}
		}catch (Exception be) {
			be.printStackTrace();
		}
	}
//		RoleMgmtController service = new RoleMgmtController();
//		PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
//				.getAttribute("ALLOWED_PRIV");
//		try {
//			Map<String, TreeMap<String, Integer>> activeServiceMap = service
//					.fetchActiveServices("BO", privFunctionBean);
//			for (Map.Entry<String, TreeMap<String, Integer>> entry : activeServiceMap
//					.entrySet()) {
//				String[] key = entry.getKey().split("#");
//				String serviceCode = key[0];
//			}
//		} catch (PMSException e) {
//			e.printStackTrace();
//		}

	public void editBOUserServiceDetails(UserDetailsBean userDetailsBean) {
//		RoleMgmtController service = new RoleMgmtController();
//		PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
//				.getAttribute("ALLOWED_PRIV");
//
//		try {
//			Map<String, TreeMap<String, Integer>> activeServiceMap = service
//					.fetchActiveServices("BO", privFunctionBean);
//			for (String entry : activeServiceMap.keySet()) {
//				String[] key = entry.split("#");
//				String serviceCode = key[0];
//			}
//
//		} catch (PMSException e) {
//			e.printStackTrace();
//		}
	}

	public String newSubUserReg() {
		HttpSession session = getRequest().getSession();
		int orgId = userInfoBean.getUserId();
		int roleId = userInfoBean.getRoleId();
		String type = userInfoBean.getUserType();

		UserMgmtController service = new UserMgmtController();
//		PrivFunctionBean privFunctionBean = (PrivFunctionBean) request.getAttribute("ALLOWED_PRIV");
		boolean returnType;
		try {
			returnType = service.checkUsernameAvailability(getUserName().trim(),userInfoBean.getDomainId());
		
			
			if (!returnType) {
				addFieldError("userName", "User Name Already Exists !!");
				return INPUT;
			} 
			if (!service.checkUserEmailIdAvailability(getEmail(),userInfoBean.getDomainId())) {
				addFieldError("email", "Email Id Already Exists !!");
				return INPUT;
			}
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}

		RoleMgmtController roleMgmtHelper = new RoleMgmtController();

		// now get the priviledges list of head
		try {
			rolePrivMap = roleMgmtHelper.getHeadsGroupNames(userInfoBean
					.getUserId(), userInfoBean.getRoleId(), userInfoBean.getUserType(), userInfoBean.getDomainId());

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
			
			// FOR RUMMY
			/*if (CommonMethodController.getInstance().isRummyActive()) {
//				RummyAPI rummyAPI = new RummyAPI();
				TreeMap<String, TreeMap<String, TreeMap<String, List<String>>>> rummy = rummyAPI
						.createRoleMenu(userInfoBean.getUserName());

				if (rummy != null) {
					Set<String> keyset = rummy.keySet();

					for (String key : keyset) {
						rolePrivMap.get("Home").put(key, rummy.get(key));
					}
				}
			}*/
			
		log.info("Head Priv Map: " + rolePrivMap);
		// put user details in session
		UserDetailsBean usrdetBean = new UserDetailsBean();
		usrdetBean.setFirstName(getFirstName());
		usrdetBean.setLastName(getLastName());
		usrdetBean.setEmailId(getEmail());
		usrdetBean.setPhoneNbr(getPhone());
		usrdetBean.setUserName(getUserName());
		usrdetBean.setStatus(getStatus());
		usrdetBean.setSecQues(getSecQues());
		usrdetBean.setSecAns(getSecAns());
		usrdetBean.setOrgId(orgId);
		usrdetBean.setRoleId(roleId);
		usrdetBean.setOrgType(type);
		usrdetBean.setBoUserType(type);
		usrdetBean.setGender(gender);
		session.setAttribute("USER_DETAILS", usrdetBean);
		session.setAttribute("HEAD_PRIV_MAP", rolePrivMap);

		return SUCCESS;
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
	}

	public String assignSubUserPriviledges() {

		HttpSession session = getRequest().getSession();
		UserDetailsBean usrdetBean = (UserDetailsBean) session.getAttribute("USER_DETAILS");
		short roleId = Short.valueOf(userInfoBean.getRoleId()+"");
		UserMgmtController service = new UserMgmtController();
//		PrivFunctionBean privFunctionBean = (PrivFunctionBean) request.getAttribute("ALLOWED_PRIV");

		try {
			rolePrivWEB = (String[]) ArrayUtils.addAll(rolePrivCasino, rolePrivHome);
			if(privCount.length==1){
				if(rolePrivCasino !=null)
					privCount[0]=rolePrivCasino.length;
				if(rolePrivHome !=null)
					privCount[0]=rolePrivHome.length;
			}else{
				
				if(userInfoBean.getUserType().equals("DOMAIN")){
					if(null !=rolePrivCasino){
						privCount[0] = rolePrivCasino.length;
					}
					if(null !=rolePrivHome)
					{
						privCount[0]=rolePrivHome.length;
					}else if(null == rolePrivWEB){
						privCount[1]=0;
					}
					
				}else{
					if(null !=rolePrivCasino){
						privCount[0] = rolePrivCasino.length;
					}
					if(null !=rolePrivHome)
					{
						privCount[1]=rolePrivHome.length;
					}else if(null == rolePrivWEB){
						privCount[0]=0;
					}
				}
			}
			//domainId 0 For BO
			roleName = userInfoBean.getRoleName();
			short domainId = userInfoBean.getDomainId();
		service.assignGroups(userInfoBean.getUserId(), rolePrivWEB, roleId,
					usrdetBean, mappingId, privCount, "ipAddress",domainId);
			/*if (CommonMethodController.getInstance().isRummyActive()) {
				RummyAPI rummyAPI = new RummyAPI();
				String rolePriv = "";
				if (rolePrivRUMMY != null) {
					rolePriv = Arrays.asList(rolePrivRUMMY).toString().replace("[", "").replace("]", "")
							.replace(" ", "").replace(",", "-");
				}
				rummyAPI.createSubUser(userInfoBean.getUserName(), rolePriv, usrdetBean, roleName);
			}*/
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}

	public String fetchSubUserName() {
		if (userInfoBean.getIsRoleHeadUser().equalsIgnoreCase("N")) {
			return "unauthorize";
		}
		int roleId = userInfoBean.getRoleId();
	
		int userId = userInfoBean.getUserId();
		UserMgmtController service = new UserMgmtController();
//		PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
//				.getAttribute("ALLOWED_PRIV");

		try {
			subUserList = service.fetchSubUserName(roleId, userId);
			
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		getRequest().getSession().setAttribute("subUserList", subUserList);
		return SUCCESS;
	}
	
	@SuppressWarnings("rawtypes")
	public String fetchAllSubUsers()
	{

		if (userInfoBean.getIsRoleHeadUser().equalsIgnoreCase("N")) {
			return "unauthorize";
		}
		int roleId = userInfoBean.getRoleId();
		List<String> roleHeadUsers = new ArrayList<>();
		int userId = userInfoBean.getUserId();
		UserMgmtController service = new UserMgmtController();
//		PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
//				.getAttribute("ALLOWED_PRIV");

		try {
			subUserList = service.fetchSubUserName(roleId, userId);
			roleHeadUsers = service.fetchRoleHeadUsers(userId);
			subUserList.addAll(roleHeadUsers);
			tempUserList = new HashSet<>();
			tempUserList.addAll(subUserList);
			subUserList.clear();
			subUserList.addAll(tempUserList);
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		getRequest().getSession().setAttribute("subUserList", subUserList);
		return SUCCESS;
	
	}

	public String getSubUserPriviledges() {
		UserMgmtController service = new UserMgmtController();
//		PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
//				.getAttribute("ALLOWED_PRIV");
		
		try {
			setRolePriviledgeMap(service.getSubUserPriviledges(getUserName(),
					userInfoBean.getUserId(), userInfoBean.getUserType(),userInfoBean.getDomainId()));
			;
			// getSubUserServicePriv(getUserName());
			/*if (CommonMethodController.getInstance().isRummyActive()) {
//				RummyAPI api = new RummyAPI();
				TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>> rummyPrivMap = api
						.getSubUserPriv(getUserName(), userInfoBean.getUserName());

				if (rummyPrivMap != null) {
					Set<String> keyset = rummyPrivMap.keySet();
					for (String key : keyset) {
						rolePriviledgeMap.get("Home").put(key, rummyPrivMap.get(key));
					}
				}
			}*/
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception_nodecorate";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception_nodecorate";
		}
		serviceSet = new TreeSet<String>(getRolePriviledgeMap().keySet());
		for (String key : servicePriviledgeMap.keySet()) {
			if (!serviceSet.contains(key)) {
				serviceSet.add(key);
				TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>> interfaceMap = new TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>();
				for (String serKey : servicePriviledgeMap.get(key).keySet()) {
					interfaceMap.put(serKey, null);
				}
				getRolePriviledgeMap().put(key, interfaceMap);
			}
		}
		return SUCCESS;
	}



	public String editSubUserPriviledges() {
		HttpSession session = getRequest().getSession();
		UserMgmtController service = new UserMgmtController();
//		PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
//				.getAttribute("ALLOWED_PRIV");

		try {
			rolePrivWEB = (String[]) ArrayUtils.addAll(rolePrivCasino, rolePrivHome);
			if(privCount.length==1){
				if(rolePrivCasino !=null)
					privCount[0]=rolePrivCasino.length;
				if(rolePrivHome !=null)
					privCount[0]=rolePrivHome.length;
			}else{
				if(null !=rolePrivCasino){
					privCount[0] = rolePrivCasino.length;
				}
				if(null !=rolePrivHome)
				{
					privCount[0]=rolePrivHome.length;
				}else if(null == rolePrivWEB){
					privCount[1]=0;
				}
			}
			service.editSubUserPriviledges(getUserName(), rolePrivWEB, mappingId,
					privCount);
			/*
			if (CommonMethodController.getInstance().isRummyActive()) {
				String rolePriv = "";
				privCount[0] = 0;
				if (rolePrivRUMMY != null) {
					privCount[0] = rolePrivRUMMY.length;
					rolePriv = Arrays.asList(rolePrivRUMMY).toString().replace("[", "").replace("]", "")
							.replace(" ", "").replace(",", "-");
				}
				if(CommonMethodController.getInstance().fetchVendorInfo("rummyuser")!=null){
					RummyAPI rummyAPI = new RummyAPI();
					rummyAPI.editSubUserPriviledges(getUserName(), rolePriv);
				}
					
			}*/
			
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		session.setAttribute("USER_NAME", getUserName());
		return SUCCESS;
	}

	public String dispSearchBoUser() {
		if (userInfoBean.getIsRoleHeadUser().equalsIgnoreCase("N")) {
			return "unauthorize";
		}
		
		RoleMgmtController rmController = new RoleMgmtController();
//		PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
//				.getAttribute("ALLOWED_PRIV");

		try {
			userName ="";
			roleMap = rmController.fetchRoles(userInfoBean.getUserType(),
					false,userInfoBean.getUserId());
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}

	public String searchBoUsers(){
		UserMgmtController service = new UserMgmtController();
//		PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
//				.getAttribute("ALLOWED_PRIV");
		try{
		userList = service.searchBoUsers(userName,
				roleId, type, status, userInfoBean);
		return SUCCESS;
		}catch (PMSException be) {
			addActionError(be.getErrorMessage());
			be.printStackTrace();
			return "exception_nodecorate";
		}
		catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception_nodecorate";
		}
	}

	public String showBOUserDetails() {
		UserMgmtController service = new UserMgmtController();
//		PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
//				.getAttribute("ALLOWED_PRIV");

		try {
			userDetailsBean = service.showBOUserDetails(user_id, type);
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	public String searchAjax() {
		int endValue = 0;
		int startValue = 0;
		try{
		HttpSession session = getRequest().getSession();
		List<UserDetailsBean> ajaxList = (List<UserDetailsBean>) session
				.getAttribute("USER_LIST1");
		List<UserDetailsBean> ajaxSearchList = new ArrayList<UserDetailsBean>();
		log.info("end " + ajaxList);
		if (ajaxList != null) {
			if (getEnd() != null) {
				end = getEnd();
			} else {
				end = "first";
			}
			// log.info("end "+end);
			startValue = (Integer) session.getAttribute("startValueUserSearch");
			if (end.equals("first")) {
				startValue = 0;
				endValue = startValue + 10;

				if (endValue > ajaxList.size()) {
					endValue = ajaxList.size();
				}
			} else if (end.equals("Previous")) {
				startValue = startValue - 10;
				if (startValue < 10) {
					startValue = 0;
				}

				endValue = startValue + 10;
				if (endValue > ajaxList.size()) {
					endValue = ajaxList.size();
				}
			} else if (end.equals("Next")) {
				startValue = startValue + 10;
				endValue = startValue + 10;
				if (endValue > ajaxList.size()) {
					endValue = ajaxList.size();
				}
				if (startValue > ajaxList.size()) {
					startValue = ajaxList.size() - ajaxList.size() % 10;
				}
			} else if (end.equals("last")) {
				endValue = ajaxList.size();
				startValue = endValue - endValue % 10;

			}
			if (startValue == endValue) {
				startValue = endValue - 10;
			}
			for (int i = startValue; i < endValue; i++) {
				ajaxSearchList.add(ajaxList.get(i));
			}
			session.setAttribute("USER_LIST", ajaxSearchList);
			session.setAttribute("startValueUserSearch", startValue);
		}

		return SUCCESS;
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
	}

	public void resetPassBO(){
		//PrintWriter out = getResponse().getWriter();
		try{
		String autoPass = AutoGenerate.autoPassword();
		UserMgmtController service = new UserMgmtController();
//		PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
//				.getAttribute("ALLOWED_PRIV");

		service.resetPassBO(user_id, autoPass, emailId, userName, firstName,lastName);
		response.setContentType("text/html");
		}
		catch (PMSException be) {
			addActionError(be.getErrorMessage());
			be.printStackTrace();
		}
		catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
		}
		//out.write("Reset Succesfully");
		//out.print(true);
	}

	public String editBOUserDetails() {
		HttpSession session = getRequest().getSession();
		//if (status.equalsIgnoreCase("INACTIVE")
				//|| status.equalsIgnoreCase("TERMINATE")) {
//			ServletContext sc = ServletActionContext.getServletContext();
//			Map currentUserSessionMap = (Map) sc
//					.getAttribute("LOGGED_IN_USERS");
//			currentUserSessionMap.remove(userName);
		//}
		UserMgmtController service = new UserMgmtController();
//		PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
//				.getAttribute("ALLOWED_PRIV");

		try {
			service.editBOUserDetails(user_id, email, phoneNbr,lastnameedit, status, type,1.1);
			UserDetailsBean userDetailsBean = new UserDetailsBean();
			userDetailsBean.setUserName(userName);
			userDetailsBean.setLastName(lastnameedit);
			userDetailsBean.setPhoneNbr(phoneNbr);
			userDetailsBean.setEmailId(email);
			userDetailsBean.setStatus(status);
			// editBOUserServiceDetails(userDetailsBean);
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		lastName = userDetailsBean.getLastName();
		session.setAttribute("BO_USER_NAME", firstName.toUpperCase() + " "
				+ lastName.toUpperCase());
		return SUCCESS;
	}
	
	public String fetchDomainUserName() {
		if (userInfoBean.getDomainId()!=1) {
			return "unauthorize";
		}
		int roleId = 2;
		int userId = userInfoBean.getUserId();
		UserMgmtController service = new UserMgmtController();
		try {
			subUserList = service.fetchDomainUserName(roleId, userId);
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		getRequest().getSession().setAttribute("subUserList", subUserList);
		return SUCCESS;
	}

	public String getDomainUserPriviledges() {
		UserMgmtController service = new UserMgmtController();

		try {
			setRolePriviledgeMap(service.getDomainUserPriviledges(getUserName(),"Domain"));
			
			// getSubUserServicePriv(getUserName());
			/*if (CommonMethodController.getInstance().isRummyActive()) {
				RummyAPI api = new RummyAPI();
				TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>> rummyPrivMap = api
						.getSubUserPriv(getUserName(), userInfoBean.getUserName());

				if (rummyPrivMap != null) {
					Set<String> keyset = rummyPrivMap.keySet();
					for (String key : keyset) {
						rolePriviledgeMap.get("Home").put(key, rummyPrivMap.get(key));
					}
				}
			}*/
		serviceSet = new TreeSet<String>(getRolePriviledgeMap().keySet());
		for (String key : servicePriviledgeMap.keySet()) {
			if (!serviceSet.contains(key)) {
				serviceSet.add(key);
				TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>> interfaceMap = new TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>();
				for (String serKey : servicePriviledgeMap.get(key).keySet()) {
					interfaceMap.put(serKey, null);
				}
				getRolePriviledgeMap().put(key, interfaceMap);
			}
		}
		return SUCCESS;
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception_nodecorate";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception_nodecorate";
		}
	}

	

	public String editDomainUserPriviledges() {
		HttpSession session = getRequest().getSession();
		UserMgmtController service = new UserMgmtController();

		try {
			rolePrivWEB = (String[]) ArrayUtils.addAll(rolePrivCasino, rolePrivHome);
			if(privCount.length==1){
				if(rolePrivCasino !=null)
					privCount[0]=rolePrivCasino.length;
				if(rolePrivHome !=null)
					privCount[0]=rolePrivHome.length;
			}else{
				if(null !=rolePrivCasino){
					privCount[0] = rolePrivCasino.length;
				}
				if(null !=rolePrivHome)
				{
					privCount[0]=rolePrivHome.length;
				}else if(null == rolePrivWEB){
					privCount[1]=0;
				}
			}
			service.editDomainUserPriviledges(getUserName(), rolePrivWEB, mappingId,
					privCount,rolePrivRUMMY);
			/*if (CommonMethodController.getInstance().isRummyActive()) {
				String rolePriv = "";
				privCount[0] = 0;
				if (rolePrivRUMMY != null) {
					privCount[0] = rolePrivRUMMY.length;
					rolePriv = Arrays.asList(rolePrivRUMMY).toString().replace("[", "").replace("]", "")
							.replace(" ", "").replace(",", "-");
				}
				if(CommonMethodController.getInstance().fetchVendorInfo("rummyuser")!=null){
					RummyAPI rummyAPI = new RummyAPI();
					rummyAPI.editSubUserPriviledges(getUserName(), rolePriv);
				}
			}*/
			
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		session.setAttribute("USER_NAME", getUserName());
		return SUCCESS;
	}
	
	

	public String subUserRegistration() {
		if (userInfoBean.getIsRoleHeadUser().equalsIgnoreCase("N")) {
			return "unauthorize";
		}
		return SUCCESS;
	}


	public String getBoUserList() {
		try {
			CommonMethodController.getInstance().checkBoUserLogin(request.getSession().getId());
			 setBoUserMap(new UserMgmtController().getBoUserMap(userInfoBean.getUserId()));
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error!");
			return "exception";
		}
		return SUCCESS;
	}
	
	public void triggerImpersonation() throws IOException{
		try {
			if("ADMIN".equals(userInfoBean.getUserType())){
				HttpSession session=request.getSession();
				UserInfoBean impersonatee=new UserMgmtController().getImpersonatee(session.getId(),getImpersonateeId());
				session.setAttribute("impersionateeBean", impersonatee);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.getWriter().write("done");
	}
	
	public void quitImpersonation() throws IOException {
		try {
			HttpSession session=request.getSession();
			session.removeAttribute("impersionateeBean");
//			session.removeAttribute("actualInfoBean");
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.getWriter().write("done");
	}

	public String getPhoneNbr() {
		return phoneNbr;
	}

	public void setPhoneNbr(String phoneNbr) {
		this.phoneNbr = phoneNbr;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public Map<Integer, String> getRoleMap() {
		return roleMap;
	}

	public void setRoleMap(Map<Integer, String> roleMap) {
		this.roleMap = roleMap;
	}


	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getSecAns() {
		return secAns;
	}

	public void setSecAns(String secAns) {
		this.secAns = secAns;
	}

	public String getSecQues() {
		return secQues;
	}

	public void setSecQues(String secQues) {
		this.secQues = secQues;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Set<String> getServiceSet() {
		return serviceSet;
	}

	public void setServiceSet(Set<String> serviceSet) {
		this.serviceSet = serviceSet;
	}

	public Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<String>>>>> getRolePrivMap() {
		return rolePrivMap;
	}

	public void setRolePrivMap(
			Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<String>>>>> rolePrivMap) {
		this.rolePrivMap = rolePrivMap;
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

	

	public String[] getRolePrivRUMMY() {
		return rolePrivRUMMY;
	}

	public void setRolePrivRUMMY(String[] rolePrivRUMMY) {
		this.rolePrivRUMMY = rolePrivRUMMY;
	}

	public String[] getRolePrivWEB() {
		return rolePrivWEB;
	}

	public void setRolePrivWEB(String[] rolePrivWEB) {
		this.rolePrivWEB = rolePrivWEB;
	}

	public List<String> getSubUserList() {
		return subUserList;
	}

	public void setSubUserList(List<String> subUserList) {
		this.subUserList = subUserList;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public UserDetailsBean getUserDetailsBean() {
		return userDetailsBean;
	}

	public void setUserDetailsBean(UserDetailsBean userDetailsBean) {
		this.userDetailsBean = userDetailsBean;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int userId) {
		user_id = userId;
	}

	public void setDomainDetailsBean(DomainDetailsBean domainDetailsBean) {
		this.domainDetailsBean = domainDetailsBean;
	}

	public DomainDetailsBean getDomainDetailsBean() {
		return domainDetailsBean;
	}

	public void setServicePriviledgeMap(
			Map<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>> servicePriviledgeMap) {
		this.servicePriviledgeMap = servicePriviledgeMap;
	}

	public Map<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>> getServicePriviledgeMap() {
		return servicePriviledgeMap;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRoleName() {
		return roleName;
	}

	public String[] getRoleServicePriv() {
		return roleServicePriv;
	}

	public void setRoleServicePriv(String[] roleServicePriv) {
		this.roleServicePriv = roleServicePriv;
	}

	public int[] getServicePrivCount() {
		return servicePrivCount;
	}

	public void setServicePrivCount(int[] servicePrivCount) {
		this.servicePrivCount = servicePrivCount;
	}

	public void setRolePriviledgeMap(
			Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>> rolePriviledgeMap) {
		this.rolePriviledgeMap = rolePriviledgeMap;
	}

	public Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>> getRolePriviledgeMap() {
		return rolePriviledgeMap;
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

	public List<UserDetailsBean> getUserList() {
		return userList;
	}

	public void setUserList(List<UserDetailsBean> userList) {
		this.userList = userList;
	}
	public short getDomainId() {
		return domainId;
	}

	public void setDomainId(short domainId) {
		this.domainId = domainId;
	}

	public Map<Integer, String> getBoUserMap() {
		return boUserMap;
	}

	public void setBoUserMap(Map<Integer, String> boUserMap) {
		this.boUserMap = boUserMap;
	}

	public Integer getImpersonateeId() {
		return impersonateeId;
	}

	public void setImpersonateeId(Integer impersonateeId) {
		this.impersonateeId = impersonateeId;
	}

	public Set<String> getTempUserList() {
		return tempUserList;
	}

	public void setTempUserList(Set<String> tempUserList) {
		this.tempUserList = tempUserList;
	}

	public String getLastnameedit() {
		return lastnameedit;
	}

	public void setLastnameedit(String lastnameedit) {
		this.lastnameedit = lastnameedit;
	}

}
