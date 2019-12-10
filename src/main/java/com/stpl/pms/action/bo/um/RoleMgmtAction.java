package com.stpl.pms.action.bo.um;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

import org.apache.commons.lang.ArrayUtils;
import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.stpl.pms.controller.rm.RoleMgmtController;
import com.stpl.pms.exception.PMSException;
import com.stpl.pms.javabeans.PrivilegeManagementBean;
import com.stpl.pms.javabeans.UserPrivBean;
import com.stpl.pms.struts.common.BaseActionSupport;
import com.stpl.pms.utility.UserValidation;

public class RoleMgmtAction extends BaseActionSupport {
	private static final Logger log = Logger.getLogger(RoleMgmtAction.class);

	private static final long serialVersionUID = 1L;

	Set<String> serviceSet = new TreeSet<String>();
	private Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<String>>>>> rolePrivMap = new TreeMap<String, TreeMap<String, TreeMap<String, TreeMap<String, List<String>>>>>();
	private Map<Integer, String> roleMap = new TreeMap<Integer, String>();
	private Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>> rolePriviledgeMap = new TreeMap<String, TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>>();
	private Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>> servicePriviledgeMap = new TreeMap<String, TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>>();
	// private Map<String,>
	private String roleName;
	private String roleDesc;
	private int[] mappingId;
	private int[] privCount;
	private String[] rolePrivWEB;
	private String[] rolePrivCasino;
	private String[] rolePrivHome;
	private String[] rolePriv;
	private String[] rolePrivRUMMY;
	private String[] roleServicePriv;
	private int[] servicePrivCount;
	private String actionDesc;
	private String actionName;
	private String checkLogin;

	private String fnName;

	private String groupNameCode;

	private String isDefault;

	private String isDefaultGroup;

	private String menuName;

	private String privNameCode;


	private String tier;

	private String relatedTo;
	private int roleId;
	
	public String getActionDesc() {
		return actionDesc;
	}

	public void setActionDesc(String actionDesc) {
		this.actionDesc = actionDesc;
	}

	public String getActionName() {
		return actionName;
	}

	public void setActionName(String actionName) {
		this.actionName = actionName;
	}

	public String getCheckLogin() {
		return checkLogin;
	}

	public void setCheckLogin(String checkLogin) {
		this.checkLogin = checkLogin;
	}

	public String getFnName() {
		return fnName;
	}

	public void setFnName(String fnName) {
		this.fnName = fnName;
	}

	
	public String getGroupNameCode() {
		return groupNameCode;
	}

	public void setGroupNameCode(String groupNameCode) {
		this.groupNameCode = groupNameCode;
	}

	public String getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}

	public String getIsDefaultGroup() {
		return isDefaultGroup;
	}

	public void setIsDefaultGroup(String isDefaultGroup) {
		this.isDefaultGroup = isDefaultGroup;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getPrivNameCode() {
		return privNameCode;
	}

	public void setPrivNameCode(String privNameCode) {
		this.privNameCode = privNameCode;
	}
	public String getTier() {
		return tier;
	}

	public void setTier(String tier) {
		this.tier = tier;
	}

	public String getRelatedTo() {
		return relatedTo;
	}

	public void setRelatedTo(String relatedTo) {
		this.relatedTo = relatedTo;
	}

	

	public Map<Integer, String> getRoleMap() {
		return roleMap;
	}

	public void setRoleMap(Map<Integer, String> roleMap) {
		this.roleMap = roleMap;
	}

	public String getRoleName() {
		return roleName;
	}

	public String[] getRolePrivWEB() {
		return rolePrivWEB;
	}

	public void setRolePrivWEB(String[] rolePrivWEB) {
		this.rolePrivWEB = rolePrivWEB;
	}

	public String[] getRolePrivRUMMY() {
		return rolePrivRUMMY;
	}

	public void setRolePrivRUMMY(String[] rolePrivRUMMY) {
		this.rolePrivRUMMY = rolePrivRUMMY;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRoleDesc() {
		return roleDesc;
	}

	public void setRoleDesc(String roleDesc) {
		this.roleDesc = roleDesc;
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

	public String[] getRolePriv() {
		return rolePriv;
	}

	public void setRolePriv(String[] rolePriv) {
		this.rolePriv = rolePriv;
	}

	public String createRoleMenu() {
		try {
			// session.setAttribute("http_serviceSet", serviceSet );
			if (userInfoBean.getIsMasterRole().equalsIgnoreCase("N")
					|| userInfoBean.getIsRoleHeadUser().equalsIgnoreCase("N")) {
				return "unauthorize";
			}
			log.info(rolePrivMap);
		/*	if (CommonMethodController.getInstance().fetchVendorInfo("rummyuser") != null) {
				RummyAPI rummyAPI = new RummyAPI();
				TreeMap<String, TreeMap<String, TreeMap<String, List<String>>>> rummy = rummyAPI
						.createRoleMenu(userInfoBean.getUserName());
				if (rummy != null) {
					Set<String> keyset = rummy.keySet();
					for (String key : keyset) {
						rolePrivMap.get("Home").put(key, rummy.get(key));
					}
				}
			}*/
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error!");
			return "exception";
		}
	}

	public String createRoleSave() {

		RoleMgmtController roleMgmtHelper = new RoleMgmtController();
		String result = "";
		try {
			roleMap = roleMgmtHelper.fetchRoles(0, roleName, 0);
			if (roleMap.size() > 0) {
				addFieldError("duplicateRoleName", "Role name not available");
				// addActionError(anErrorMessage)
				return "error";
			}
			rolePrivWEB = (String[]) ArrayUtils.addAll(rolePrivCasino, rolePrivHome);
			if (privCount.length == 1) {
				if (rolePrivCasino != null)
					privCount[0] = rolePrivCasino.length;
				if (rolePrivHome != null)
					privCount[0] = rolePrivHome.length;
			} else {
				if (userInfoBean.getRoleId() == 2) {
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
			result = roleMgmtHelper.createRole(roleName, roleDesc, userInfoBean.getUserType(), rolePrivWEB, mappingId,
					privCount, userInfoBean.getRoleId(), userInfoBean.getUserId());
			/*if (CommonMethodController.getInstance().fetchVendorInfo("rummyuser") != null) {
				RummyAPI rummyAPI = new RummyAPI();
				String rolePriv = "";
				if (null != rolePrivRUMMY) {
					rolePriv = Arrays.asList(rolePrivRUMMY).toString().replace("[", "").replace("]", "")
							.replace(" ", "").replace(",", "-");
				}
				rummyAPI.createRoleSave(roleName, roleDesc, userInfoBean.getUserType(), rolePriv,
						userInfoBean.getUserName());
			}*/

		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception";
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Exception occur");
			return "exception";
		}

		if (result.equals("error")) {
			addFieldError("duplicateRoleName", "Role name already exist!");
			return "error";
		}
		if (roleServicePriv != null) {
			// createRoleService();
		}
		return SUCCESS;
	}

	public String editRoleMenu() {
		try {
			if (userInfoBean.getIsMasterRole().equalsIgnoreCase("N")
					|| userInfoBean.getIsRoleHeadUser().equalsIgnoreCase("N")) {
				return "unauthorize";
			}
			return SUCCESS;
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
	}

	public String fetchRolePriv() {

		// PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
		// .getAttribute("ALLOWED_PRIV");

		RoleMgmtController roleMgmtController = new RoleMgmtController();
		try {
			setRolePriviledgeMap(roleMgmtController.fetchRolePriv(roleId, userInfoBean.getUserType(),
					userInfoBean.getRoleId(), userInfoBean.getUserId(), userInfoBean.getDomainId()));
			roleName = roleMap.get(roleId);
			/*if(CommonMethodController.getInstance().fetchVendorInfo("rummyuser")!=null){
				RummyAPI rummyAPI = new RummyAPI();
				TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>> rummyPrivMap = rummyAPI
						.editFetchRolePriv(roleName, userInfoBean.getUserType(), userInfoBean.getUserName());
				if (rummyPrivMap != null) {
					Set<String> keyset = rummyPrivMap.keySet();
					for (String key : keyset) {
						rolePriviledgeMap.get("Home").put(key, rummyPrivMap.get(key));
					}
				}
			}*/

			serviceSet = new TreeSet<String>(getRolePriviledgeMap().keySet());
			for (String key : getServicePriviledgeMap().keySet()) {
				if (!serviceSet.contains(key)) {
					serviceSet.add(key);
					TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>> interfaceMap = new TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>();
					for (String serKey : getServicePriviledgeMap().get(key).keySet()) {
						interfaceMap.put(serKey, null);
					}
					getRolePriviledgeMap().put(key, interfaceMap);
				}
			}
			return SUCCESS;
		} catch (PMSException be) {
			addActionError(be.getErrorMessage());
			return "exception_nodecorate";
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception_nodecorate";
		}

	}

	public String editRolePriv() {
		log.info(roleId);
		log.info(roleName);
		RoleMgmtController roleMgmtHelper = new RoleMgmtController();
		// PrivFunctionBean privFunctionBean = (PrivFunctionBean) request
		// .getAttribute("ALLOWED_PRIV");
		try {
			rolePrivWEB = (String[]) ArrayUtils.addAll(rolePrivCasino, rolePrivHome);
			if (privCount.length == 1) {
				if (rolePrivCasino != null)
					privCount[0] = rolePrivCasino.length;
				if (rolePrivHome != null)
					privCount[0] = rolePrivHome.length;
			} else {

				if (userInfoBean.getRoleId() == 2) {
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
			roleMgmtHelper.editRolePriv(roleId, rolePrivWEB, mappingId, privCount, userInfoBean.getRoleId(),
					userInfoBean.getUserType());
			/*if (CommonMethodController.getInstance().fetchVendorInfo("rummyuser") != null) {
				RummyAPI rummyAPI = new RummyAPI();
				String rolePriv = "";
				if (null != rolePrivRUMMY) {
					rolePriv = Arrays.asList(rolePrivRUMMY).toString().replace("[", "").replace("]", "")
							.replace(" ", "").replace(",", "-");
				}
				// .replace(",","");
				// rolePriv = rolePriv.replace("*","");
				rummyAPI.editRolePriv(roleName, rolePriv, userInfoBean.getUserName());
			}
*/
		} catch (PMSException be) {
			addActionError(be.getErrorMessage());
			return "exception_nodecorate";
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception_nodecorate";
		}
		if (roleServicePriv != null) {
			// editRoleService();
		}

		return SUCCESS;

	}

	public void getCreateRoleServicePriv(String parentUserName) {
		// RoleMgmtController service = new RoleMgmtController();
		// try {
		// Map<String, TreeMap<String, Integer>> activeServiceMap = service
		// .fetchActiveServices("BO");
		// for (Map.Entry<String, TreeMap<String, Integer>> entry :
		// activeServiceMap
		// .entrySet()) {
		// String[] key = entry.getKey().split("#");
		// String serviceCode = key[0];
		// String serviceDispName = key[1];
		// }
		//
		// } catch (PMSException e) {
		// e.printStackTrace();
		// } catch (Exception e) {
		// e.printStackTrace();
		// }
	}

	public void createRoleService() {
		try {
			StringBuilder privGroup = null;
			String grpNameStr = null;
			int privIdFrm = 0;
			int privIdTo = 0;
			HashMap<Integer, String> privMap = new HashMap<Integer, String>();
			for (int i = 0; i < mappingId.length; i++) {
				if (servicePrivCount[i] != 0) {
					privGroup = new StringBuilder("");
					privIdTo = privIdTo + servicePrivCount[i];
					for (int j = privIdFrm; j < privIdTo; j++) {
						privGroup.append("'" + roleServicePriv[j] + "',");
						privIdFrm++;
					}
					grpNameStr = privGroup.substring(0, privGroup.length() - 1);
					// activeMapIds = activeMapIds + mappingId[i] + ",";
					privMap.put(mappingId[i], grpNameStr);
				}
			}
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
		}

		// RoleMgmtController service = new RoleMgmtController();
		// try {
		// Map<String, TreeMap<String, Integer>> activeServiceMap = service
		// .fetchActiveServices("BO");
		// for (Map.Entry<String, TreeMap<String, Integer>> entry :
		// activeServiceMap
		// .entrySet()) {
		// String[] key = entry.getKey().split("#");
		// String serviceCode = key[0];
		// }
		//
		// } catch (PMSException e) {
		// e.printStackTrace();
		// }
	}

	public void getEditRoleServicePriv(String roleName) {
		// RoleMgmtController service = new RoleMgmtController();
		// try {
		// Map<String, TreeMap<String, Integer>> activeServiceMap =
		// service.fetchActiveServices("BO");
		// for (Map.Entry<String, TreeMap<String, Integer>> entry :
		// activeServiceMap
		// .entrySet()) {
		// String[] key = entry.getKey().split("#");
		// String serviceCode = key[0];
		// String serviceDispName = key[1];
		// }
		//
		// } catch (PMSException e) {
		// e.printStackTrace();
		// }
	}

	public void editRoleService() {
		StringBuilder privGroup = null;
		String grpNameStr = null;
		int privIdFrm = 0;
		int privIdTo = 0;
		HashMap<Integer, String> privMap = new HashMap<Integer, String>();
		try {
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

			// RoleMgmtController service = new RoleMgmtController();
			// PrivFunctionBean privFunctionBean = (PrivFunctionBean)
			// request.getAttribute("ALLOWED_PRIV");

			// try {
			// Map<String, TreeMap<String, Integer>> activeServiceMap = service
			// .fetchActiveServices("BO", privFunctionBean);
			// for (Map.Entry<String, TreeMap<String, Integer>> entry :
			// activeServiceMap
			// .entrySet()) {
			// String[] key = entry.getKey().split("#");
			// String serviceCode = key[0];
			// }
			//
			// } catch (PMSException e) {
			// e.printStackTrace();
			// }
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
		}
	}

	public void validate() {
		RoleMgmtController roleMgmtHelper = new RoleMgmtController();
		String message = null;
		String actionName = (String) ActionContext.getContext().getContextMap().get(ActionContext.ACTION_NAME);
		if (actionName.contains("create")) {
			try {

				setRolePrivMap(roleMgmtHelper.getHeadsGroupNames(userInfoBean.getUserId(), userInfoBean.getRoleId(),
						userInfoBean.getUserType(), userInfoBean.getDomainId()));
				// getCreateRoleServicePriv(userBean.getUserName());
				serviceSet = new TreeSet<String>(getRolePrivMap().keySet());
				for (String key : getServicePriviledgeMap().keySet()) {
					if (!serviceSet.contains(key)) {
						serviceSet.add(key);
						TreeMap<String, TreeMap<String, TreeMap<String, List<String>>>> interfaceMap = new TreeMap<String, TreeMap<String, TreeMap<String, List<String>>>>();
						for (String serKey : getServicePriviledgeMap().get(key).keySet()) {
							interfaceMap.put(serKey, null);
						}
						getRolePrivMap().put(key, interfaceMap);
					}
				}
			} catch (PMSException e) {
				e.printStackTrace();
			} catch (Exception be) {
				addActionError("Some internal error.");
				be.printStackTrace();
			}
		} else if (actionName.contains("edit")) {

			if (actionName.equals("bo_rm_edit_role_save")) {
				if (rolePrivCasino == null && rolePrivRUMMY == null && rolePrivHome == null) {
					addFieldError("rolePriv", "Please Check Atleast One Role Priviledge");
				}
				if (roleName.equals("-1")) {
					addFieldError("roleName", "Please Select a role name");
				}
			}

			try {
				roleMap = roleMgmtHelper.fetchRoles(userInfoBean.getRoleId(), userInfoBean.getUserType(),
						userInfoBean.getUserId());
			} catch (PMSException e) {
				e.printStackTrace();
			} catch (Exception be) {
				addActionError("Some internal error.");
				be.printStackTrace();
			}
		}

		if (actionName.equals("bo_rm_create_role_save")) {
			if (getRoleName() == null || getRoleName().equals("")) {
				message = "Please Enter the role name ";
				addFieldError("roleName", message);

			} else if (!UserValidation.isAlphanumeric(getRoleName(), false)) {
				message = "Please Enter the role name correctly";
				addFieldError("roleName", message);
			}
			if (request.getAttribute("roleDesc") == null || request.getAttribute("roleDesc").equals("")) {
				message = "Please Enter the role description ";
				addFieldError("roleDesc", message);

			} else if (!UserValidation.isAlphanumericCommaFullStop(getRoleDesc(), true)) {
				message = "Please Enter the role description correctly";
				addFieldError("roleDesc", message);
				try {
					createRoleMenu();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (rolePrivCasino == null && rolePrivRUMMY == null && rolePrivHome == null) {
				addFieldError("rolePriv", "Please Check Atleast One Role Priviledge");
			}

		}
		return;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public Set<String> getServiceSet() {
		return serviceSet;
	}

	public void setServiceSet(Set<String> serviceSet) {
		this.serviceSet = serviceSet;
	}

	public void setServicePrivCount(int[] servicePrivCount) {
		this.servicePrivCount = servicePrivCount;
	}

	public int[] getServicePrivCount() {
		return servicePrivCount;
	}

	public void setRoleServicePriv(String[] roleServicePriv) {
		this.roleServicePriv = roleServicePriv;
	}

	public String[] getRoleServicePriv() {
		return roleServicePriv;
	}

	public void setRolePrivMap(
			Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<String>>>>> rolePrivMap) {
		this.rolePrivMap = rolePrivMap;
	}

	public Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<String>>>>> getRolePrivMap() {
		return rolePrivMap;
	}

	public void setRolePriviledgeMap(
			Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>> rolePriviledgeMap) {
		this.rolePriviledgeMap = rolePriviledgeMap;
	}

	public Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>> getRolePriviledgeMap() {
		return rolePriviledgeMap;
	}

	public void setServicePriviledgeMap(
			Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>> servicePriviledgeMap) {
		this.servicePriviledgeMap = servicePriviledgeMap;
	}

	public Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>> getServicePriviledgeMap() {
		return servicePriviledgeMap;
	}

	public void checkRoleAvailability() throws PMSException {

		log.info(roleName);
		RoleMgmtController object1 = new RoleMgmtController();
		try {
			boolean isAvailable = new Boolean(object1.checkRoleAvailability(roleName, userInfoBean.getDomainId()));
			if (isAvailable) {
				String message = "Available";
				response.getWriter().write("<valid><message><p>" + message + "</p></message></valid>");
			} else {
				String message = "Not available";
				response.getWriter().write("<valid><message><p>" + message + "</p></message></valid>");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return;
	}

	public void assignPriv() throws PMSException {
		try {
			RoleMgmtController controller = new RoleMgmtController();
			controller.managePriv("BO");
			controller.managePriv("DOMAIN");
			response.getWriter().write("Default privileges assigned successfully!!!!!!");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
		}

	}

	public void setRolePrivCasino(String[] rolePrivCasino) {
		this.rolePrivCasino = rolePrivCasino;
	}

	public String[] getRolePrivCasino() {
		return rolePrivCasino;
	}

	public void setRolePrivHome(String[] rolePrivHome) {
		this.rolePrivHome = rolePrivHome;
	}

	public String[] getRolePrivHome() {
		return rolePrivHome;
	}



	public String addPrivilege() {

		try {
			PrivilegeManagementBean privMgmtBean = new PrivilegeManagementBean();
			privMgmtBean.setActionDesc(actionDesc);
			if (actionName !=null && actionName.length()!=0)
				privMgmtBean.setActionName(actionName);
			privMgmtBean.setCheckLogin(checkLogin);
			privMgmtBean.setFnName(fnName);
			if(groupNameCode != null && groupNameCode.length()!=0)
				privMgmtBean.setGroupNameCode(groupNameCode.trim());
			privMgmtBean.setIsDefault(isDefault);
			privMgmtBean.setIsDefaultGroup(isDefaultGroup);
			privMgmtBean.setPrivNameCode(privNameCode);
			privMgmtBean.setPrivStatus("ACTIVE");
			privMgmtBean.setActionStatus("ACTIVE");
			privMgmtBean.setTier(tier);
			privMgmtBean.setRelatedTo(relatedTo);
			new RoleMgmtController().addPrivilege(privMgmtBean);
			assignPriv();
		} catch (PMSException pmse) {
			pmse.printStackTrace();
			addActionError(pmse.getErrorMessage());
			return "error";
		} catch (Exception ex) {
			ex.printStackTrace();
			return "error";
		}
		return SUCCESS;
	}

	public String call()
	{
		return SUCCESS;
	}
}