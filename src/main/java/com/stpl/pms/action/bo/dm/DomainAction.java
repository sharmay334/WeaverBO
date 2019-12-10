package com.stpl.pms.action.bo.dm;

//import java.io.File;
//import java.io.PrintWriter;
//import java.lang.reflect.Type;
//import java.util.ArrayList;
//import java.util.Arrays;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//import java.util.Set;
//import java.util.TreeMap;
//
//import javax.servlet.http.HttpSession;
//
//import org.apache.commons.configuration.PropertiesConfiguration;
//import org.apache.commons.lang.ArrayUtils;
//import org.apache.log4j.Logger;
//
//import com.google.gson.Gson;
//import com.google.gson.GsonBuilder;
//import com.google.gson.reflect.TypeToken;
//import com.opensymphony.xwork2.ActionContext;
//import com.stpl.pms.api.bo.rummyAPI.RummyAPI;
//import com.stpl.pms.controller.commonMethods.CommonMethodController;
//import com.stpl.pms.controller.dm.DomainMgmtController;
//import com.stpl.pms.controller.langMgmt.LanguageMgmtController;
//import com.stpl.pms.controller.um.UserMgmtController;
//import com.stpl.pms.exception.PMSException;
//import com.stpl.pms.hibernate.mapping.StDmDomainAliasNameMaster;
//import com.stpl.pms.hibernate.mapping.StGenSmsEmailProviderMaster;
//import com.stpl.pms.hibernate.mapping.StGenVerificationSourceMaster;
//import com.stpl.pms.javabeans.AliasPropertyBean;
//import com.stpl.pms.javabeans.CountryBean;
//import com.stpl.pms.javabeans.CountryStateBean;
//import com.stpl.pms.javabeans.CurrencyBean;
//import com.stpl.pms.javabeans.DeviceMasterBean;
//import com.stpl.pms.javabeans.DomainPropertyBean;
//import com.stpl.pms.javabeans.LanguageBean;
//import com.stpl.pms.javabeans.LocDevMappingBean;
//import com.stpl.pms.javabeans.LocationMaster;
//import com.stpl.pms.javabeans.MenuContentBean;
//import com.stpl.pms.javabeans.MenuDataBean;
//import com.stpl.pms.javabeans.PortalMenuBean;
//import com.stpl.pms.javabeans.ReferenceInfoBean;
//import com.stpl.pms.javabeans.ReferenceListBean;
//import com.stpl.pms.javabeans.SecurityQuesInfoBean;
//import com.stpl.pms.javabeans.UserDetailsBean;
//import com.stpl.pms.javabeans.UserPrivBean;
import com.stpl.pms.struts.common.BaseActionSupport;
//import com.stpl.pms.utility.UserValidation;
//import com.stpl.pms.utility.Utility;

public class DomainAction extends BaseActionSupport {
}
/*	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(DomainAction.class);
	private DomainPropertyBean domainBean;
	private UserDetailsBean userDetailBean;
	private Map<Integer, String> passwordPolicyMap;
	private Map<String, CountryBean> countryMap;
	private String countryStr;
	private Map<Integer, CurrencyBean> currencyMap;
	private Map<Short, String> serviceMap;
	private HashMap<Integer, LanguageBean> languageMap;
	private Map<Short, StGenVerificationSourceMaster> autoVerificationSourceMap;
	
	private File domainLogo;
	private String domainLogoContentType;
	private String domainLogoFileName;
	
	
	*//****//*
	private PropertiesConfiguration resource;
	private List<ReferenceInfoBean> referenceFieldList;
	private String label1;
	private String label2;
	private String label3;
	private String refNmae;
	private String label1Type;
	private String label2Type;
	private String label3Type;
	private List<ReferenceListBean> addReferenceFieldList = new ArrayList<ReferenceListBean>();
	private String[] label1Values;
	private String[] label2Values;
	private String[] label3Values;
	private String[] checkbox1;
	private String[] checkbox2;
	private String[] checkbox3;
	private String[] refId;
	private Integer refIndex;
	private List<SecurityQuesInfoBean> secQuesList;
	
	private String[] country;
	private String[] state;
	private PortalMenuBean menuData;
    private String menu;
	private String contentMap;
	private String jsonList;
	private String menuString;
	private String device;
	private Map<Integer, CurrencyBean> dmActiveCurrMap;
	private Map<Integer, LanguageBean> dmActiveLangMap;
	private Map<String, String> domainCheckList;
	private Map<String, String> activeReportsList;
	private String newActiveReportList;
	private File uploadCss;
	private Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>> rolePriviledgeMap = new TreeMap<String, TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>>();
	private int[] mappingId;
	private int[] privCount;
	private String[] rolePrivRUMMY;
	private String[] rolePrivWEB;
	private String[] rolePrivHome;
	private String[] rolePrivCasino;
	private AliasPropertyBean aliasBean;
	private List<StGenSmsEmailProviderMaster> emailList;
	private String emailOrderStr;
	private List<LocationMaster> locMaster;
	private List<DeviceMasterBean> devMaster;
	private LocationMaster locMas;
	private DeviceMasterBean devMas;
	private LocDevMappingBean locDevMap;
	private Integer locId[];
	private Integer devId[];
	private Integer devMapId[];
	private String status;
	private  List<LocDevMappingBean> devMapping;
	private List<Object> devLocList;
	private String providerType;
	
	public String domainRegMenu() {
		try {
			Map<String, Object> maps = new DomainMgmtController().fetchDomainRegistrationMaps();
			fetchCommonRegistrationData(maps);
			//
			
			UserMgmtController service = new UserMgmtController();
			setRolePriviledgeMap(service.getDomainPriviledges("Domain" ));
			
			
			
			if(service.checkRummyServiceAvailable("Domain")){
				if(CommonMethodController.getInstance().fetchVendorInfo("rummyuser")!=null){
					RummyAPI rummyAPI = new RummyAPI();
					TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>> rummyPrivMap = rummyAPI.domainRolePriv("Domain", userInfoBean
							.getUserType(), userInfoBean.getUserName());
					if(rummyPrivMap!=null){
						Set<String> keyset = rummyPrivMap.keySet();
						for (String key : keyset) {
							rolePriviledgeMap.get("Home").put(key, rummyPrivMap.get(key));
						}
					  }		
					}
				}
			
			//			
			
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error!");
			return "exception";
		}
		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	private void fetchCommonRegistrationData(Map<String, Object> maps) throws PMSException {
		Utility utility=new Utility();
		passwordPolicyMap = (Map<Integer, String>) maps.get("policyMap");
		countryMap=(Map<String, CountryBean>) maps.get("countryMap");
		countryStr = utility.convertJSON(countryMap);
		serviceMap = (Map<Short, String>) maps.get("serviceMap");
		languageMap = (HashMap<Integer, LanguageBean>) maps.get("langMap");
		currencyMap = CommonMethodController.getInstance().fetchCurrencyMasterMap();
		autoVerificationSourceMap = (Map<Short, StGenVerificationSourceMaster>) maps.get("autoVeriPropMap");
	}
	
	public void checkDomainNameAvailability() {
		DomainMgmtController controller = new DomainMgmtController();
		try {
			response.getWriter().write(
					controller.checkDomainNameAvailability(domainBean
							.getDomainName()) ? "<p>Available</p>" : "<p>Not Available</p>");
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void validateDomainUsername() {
		UserMgmtController cont = new UserMgmtController();
		try {
			response.getWriter().write(
					cont.checkUsernameAvailability(userDetailBean.getUserName(),userInfoBean.getDomainId()) ? "<p>available</p>" : "<p>Not Available</p>");
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error");
		}
		
	}
	public void validateDomainUserEmail() {
		UserMgmtController cont = new UserMgmtController();
		try {
			response.getWriter().write(
					cont.checkUserEmailIdAvailability(userDetailBean.getEmailId(),userInfoBean.getDomainId()) ? "<p>available</p>" : "<p>Not Available</p>");
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error");
		}
		
	}
	public String domainRegSave() {
		try {
			log.info("--domainRegistration data----"+domainBean);
			log.info("----domain user data---"+userDetailBean);
			
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
			
			domainBean.setLoginThroughEmail(domainBean.getLoginThroughEmail().equals("false")?"NO":"YES");
			domainBean.setLoginThroughFconnect(domainBean.getLoginThroughFconnect().equals("false")?"NO":"YES");
			domainBean.setLoginThroughMobileNo(domainBean.getLoginThroughMobileNo().equals("false")?"NO":"YES");
			domainBean.setLoginThroughUsername(domainBean.getLoginThroughUsername().equals("false")?"NO":"YES");
			
			if (domainLogoContentType.startsWith("image")) {
					domainLogoFileName = domainBean.getDomainName()+"_logo."+domainLogoContentType.split("/")[1];
					domainBean.setDomainLogo(domainLogoFileName);
					Utility.saveOrUpdateContent(domainLogo, domainLogoFileName,domainBean.getDomainName());
					Utility.callUrl(CommonMethodController.getInstance().fetchSystemProperties("DEFAULT_CONTENT_PATH")+"copyFiles", "domainName="+domainBean.getDomainName()+"&path=");
					DomainMgmtController controller = new DomainMgmtController();
					controller.domainRegSave(domainBean,userInfoBean, userDetailBean, userInfoBean.getUserId(),rolePrivWEB,mappingId, privCount,rolePrivRUMMY);
					
			if (CommonMethodController.getInstance().fetchVendorInfo("rummyuser") != null) {
				RummyAPI rummyAPI = new RummyAPI();
				String rolePriv = "";
				if (rolePrivRUMMY != null) {
					rolePriv = Arrays.asList(rolePrivRUMMY).toString().replace("[", "").replace("]", "")
							.replace(" ", "").replace(",", "-");
				}
				rummyAPI.createDomainUser(userInfoBean.getUserName(), rolePriv, userDetailBean,
						domainBean.getDomainName(), "Domain");
			}
					
					
				} else{
					addFieldError("Image"," Image Type is not Accepted");
					return INPUT;
				}
		} catch (PMSException be) {
			addActionError(be.getErrorMessage());
			return "exception";
		} catch(Exception e){
			e.printStackTrace();
			addActionError("Some Internal Error!");
			return "exception";
		}
		return SUCCESS;
	}
	
	public String domainEditFetch() {
		try {
			DomainMgmtController domainController = new DomainMgmtController();
			CommonMethodController controller = CommonMethodController.getInstance();
			if(domainBean != null)
				domainId = domainBean.getDomainId();
			dmActiveCurrMap = controller.fetchActiveDmCurrMap(domainId);
			dmActiveLangMap = controller.fetchDmActiveLangMap(domainId);
			domainBean = domainController.fetchDomainProperties(domainId);
			Map<String, Object> maps = domainController.fetchDomainRegistrationMaps();
			fetchCommonRegistrationData(maps);
		} catch (PMSException be) {
			addActionError(be.getErrorMessage());
			be.printStackTrace();
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}
	public String domainEditSave() {
		try {
			log.info("--domain data----"+domainBean);
			log.info("----domain user data---"+userDetailBean);
			
			domainBean.setLoginThroughEmail(domainBean.getLoginThroughEmail().equals("false")?"NO":"YES");
			domainBean.setLoginThroughFconnect(domainBean.getLoginThroughFconnect().equals("false")?"NO":"YES");
			domainBean.setLoginThroughMobileNo(domainBean.getLoginThroughMobileNo().equals("false")?"NO":"YES");
			domainBean.setLoginThroughUsername(domainBean.getLoginThroughUsername().equals("false")?"NO":"YES");
			if (domainLogoContentType!= null) {
				if(domainLogoContentType.startsWith("image")){
				domainLogoFileName = domainBean.getDomainName() + "_logo."
						+ domainLogoContentType.split("/")[1];
				domainBean.setDomainLogo(domainLogoFileName);
				Utility.saveOrUpdateContent(domainLogo, domainLogoFileName,domainBean.getDomainName());
				Utility.callUrl(CommonMethodController.getInstance().fetchSystemProperties("DEFAULT_CONTENT_PATH")+"copyFiles", "domainName="+domainBean.getDomainName()+"&path=");
				} else {
					addFieldError("Image"," Image Type is not Accepted");
					return INPUT;
				}
			}
			DomainMgmtController controller = new DomainMgmtController();
			controller.getdomainEditSave(domainBean, userInfoBean.getUserId());
		} catch (PMSException be) {
			be.printStackTrace();
			addActionError(be.getErrorMessage());
			return "exception";
		} catch(Exception e){
			addActionError("Some internal error.");
			e.printStackTrace();
			return "exception";
		}
		
		return SUCCESS;
	}
	
	
	
	public String getDomainNameList() {
		CommonMethodController controller = CommonMethodController.getInstance();
		try {
			domainMap = controller.getDomainIdMap();
		}  catch (PMSException pmse) {
			pmse.printStackTrace();
			addActionError(pmse.getErrorMessage());
			return "exception";
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error");
			return "exception";
		}
		
		return SUCCESS;
	}
	
	
	public String fetchReferenceFieldList() {
		HttpSession httpSession = request.getSession(true);
		DomainMgmtController domainMgmtController = new DomainMgmtController();
		try {
			resource = Utility.fetchGlobalProperties();
			referenceFieldList = domainMgmtController
					.loadReferenceList(domainId);
			
			httpSession.setAttribute("referenceFieldList", referenceFieldList);
			httpSession.setAttribute("addReferenceFieldList", addReferenceFieldList);
		} catch (PMSException pmse) {
			//logger.info("exception occured");
			pmse.printStackTrace();
			addActionError(pmse.getErrorMessage());
			return "exception";
		}catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error");
			return "exception";
		}
		
		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	public String editReference() {
		try{
			HttpSession httpSession = request.getSession();
			resource = Utility.fetchGlobalProperties();
			Integer id = Integer.parseInt(request.getParameter("refIndex"));
			referenceFieldList = (List<ReferenceInfoBean>) httpSession
					.getAttribute("referenceFieldList");
			ReferenceInfoBean referenceInfo = referenceFieldList.get(id);
			request.setAttribute("referenceInfo", referenceInfo);
		}catch (PMSException e) {
			e.printStackTrace();
			return ERROR;
		}catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
		
		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	public void addToReferralsList() {
		HttpSession httpSession = request.getSession();
		try {
			referenceFieldList = (List<ReferenceInfoBean>) httpSession
					.getAttribute("referenceFieldList");
			int index = 0;
			resource = Utility.fetchGlobalProperties();
			ReferenceListBean referenceListBean = new ReferenceListBean();
			referenceListBean.setReferenceName(refNmae);
			if (label1 != null && !label1.equals("")) {
				referenceListBean.setRefTxtLabel1(label1);
				referenceListBean.setRefTxtLabel1Type(label1Type);
				if (label1Type.equals("List")) {
					for (String string : label1Values) {
						if (!string.equals("") && string != null) {
							referenceListBean.getLabelInfoBean1().setLabelname(
									label1);
							referenceListBean.getLabelInfoBean1()
									.getValueList().add(string);
							if (Arrays.asList(checkbox1).contains("" + index)) {
								referenceListBean.getLabelInfoBean1()
										.getStatusList().add("ACTIVE");
							} else {
								referenceListBean.getLabelInfoBean1()
										.getStatusList().add("INACTIVE");
							}
						}
						index++;
					}
				}
			} else {
				referenceListBean.setRefTxtLabel1Type("");

			}
			if (label2 != null && !label2.equals("")) {
				referenceListBean.setRefTxtLabel2(label2);
				referenceListBean.setRefTxtLabel2Type(label2Type);
				index = 0;
				if (label2Type.equals("List")) {
					for (String string : label2Values) {
						if (!string.equals("") && string != null) {
							referenceListBean.getLabelInfoBean2().setLabelname(
									label2);
							referenceListBean.getLabelInfoBean2()
									.getValueList().add(string);
							if (Arrays.asList(checkbox2).contains("" + index)) {
								referenceListBean.getLabelInfoBean2()
										.getStatusList().add("ACTIVE");
							} else {
								referenceListBean.getLabelInfoBean2()
										.getStatusList().add("INACTIVE");
							}
						}
						index++;
					}
				}
			} else {
				referenceListBean.setRefTxtLabel2Type("");

			}
			if (label3 != null && !label3.equals("")) {
				referenceListBean.setRefTxtLabel3(label3);
				referenceListBean.setRefTxtLabel3Type(label3Type);
				index = 0;
				if (label3Type.equals("List")) {
					for (String string : label3Values) {
						if (!string.equals("") && string != null) {
							referenceListBean.getLabelInfoBean3().setLabelname(
									label3);
							referenceListBean.getLabelInfoBean3()
									.getValueList().add(string);
							if (Arrays.asList(checkbox3).contains("" + index)) {
								referenceListBean.getLabelInfoBean3()
										.getStatusList().add("ACTIVE");
							} else {
								referenceListBean.getLabelInfoBean3()
										.getStatusList().add("INACTIVE");
							}
						}
						index++;
					}
				}
			} else {
				referenceListBean.setRefTxtLabel3Type("");

			}
			addReferenceFieldList = (List<ReferenceListBean>) httpSession
					.getAttribute("addReferenceFieldList");
			addReferenceFieldList.add(referenceListBean);
			httpSession.setAttribute("addReferenceFieldList",
					addReferenceFieldList);
		} catch (PMSException e) {
			return;
		}catch (Exception e) {
				e.printStackTrace();
				return;
			}
			return;
		}
		

	@SuppressWarnings("unchecked")
	public void removeFromReferralsList(){
		try{
		HttpSession httpSession = request.getSession(true);
		Integer id = Integer.parseInt(request.getParameter("refIndex"));
		referenceFieldList = (List<ReferenceInfoBean>) httpSession
				.getAttribute("referenceFieldList");
		addReferenceFieldList = (List<ReferenceListBean>) httpSession
		.getAttribute("addReferenceFieldList");
		Integer length = referenceFieldList.size();
		addReferenceFieldList.remove(id-length);
		httpSession.setAttribute("addReferenceFieldList", addReferenceFieldList);
		}catch (Exception be) {
			be.printStackTrace();
		}

	}
	

	@SuppressWarnings("unchecked")
	public void editToReferralsList() {
		try{
		HttpSession httpSession = request.getSession();
		referenceFieldList = (List<ReferenceInfoBean>) httpSession
				.getAttribute("referenceFieldList");
		LanguageMgmtController languageMgmtController = new LanguageMgmtController();
		if ( label1Type!= null && !label1Type.equals("-1")) {
			if(referenceFieldList.get(refIndex).getRefTxtLabel1() == null || referenceFieldList.get(refIndex).getRefTxtLabel1().equals("")){
				int referenceCode = languageMgmtController.getDisplayCode(label1, 1,
						1, domainId);
				referenceFieldList.get(refIndex).setRefTxtLabel1(referenceCode);
			}
			referenceFieldList.get(refIndex).setRefTxtLabel1Type(label1Type);
			if (label1Type.equals("List")) {
				int length = 0;
                if(label1Values!=null){
               	 length = referenceFieldList.get(refIndex).getLabelInfoBean1()
						.getStatusList().size() + label1Values.length;
                }else{
               	 length = referenceFieldList.get(refIndex).getLabelInfoBean1()
						.getStatusList().size();
                }
                int j = 0;
				for (int i = 0; i < length; i++) {
					if (Arrays.asList(checkbox1).contains(""+i)) {
						if(i<referenceFieldList.get(refIndex).getLabelInfoBean1()
								.getStatusList().size()){
						referenceFieldList.get(refIndex).getLabelInfoBean1()
								.getStatusList().set(i, "ACTIVE");
						}else{
							if(label1Values != null && !label1Values[j].equals(""))
							{
							referenceFieldList.get(refIndex).getLabelInfoBean1()
								.getValueList().add(label1Values[j]);
							referenceFieldList.get(refIndex).getLabelInfoBean1()
							.getStatusList().add("ACTIVE");
							}
							j++;
						}
					} else {
						if (i < referenceFieldList.get(refIndex)
								.getLabelInfoBean1().getStatusList().size()) {
							referenceFieldList.get(refIndex)
									.getLabelInfoBean1().getStatusList().set(i,
											"INACTIVE");
						} else {
							if (label1Values != null && !label1Values[j].equals("")) {
								referenceFieldList.get(refIndex).getLabelInfoBean1().getValueList()
										.add(label1Values[j]);
								referenceFieldList.get(refIndex).getLabelInfoBean1().getStatusList().add("INACTIVE");
							}
							j++;
						}
						
					}

				}
			}
		}
		if (label2Type!= null && !label2Type.equals("")) {
			if(referenceFieldList.get(refIndex).getRefTxtLabel2()==null || referenceFieldList.get(refIndex).getRefTxtLabel2().equals("")){
				int referenceCode = languageMgmtController.getDisplayCode(label2, 1,
						1, domainId);
				referenceFieldList.get(refIndex).setRefTxtLabel2(referenceCode);
			}
			referenceFieldList.get(refIndex).setRefTxtLabel2Type(label2Type);
			if (label2Type.equals("List")) {
                 int length = 0;
                 if(label2Values!=null){
                	 length = referenceFieldList.get(refIndex).getLabelInfoBean2()
						.getStatusList().size() + label2Values.length;
                 }else{
                	 length = referenceFieldList.get(refIndex).getLabelInfoBean2()
						.getStatusList().size();
                 }
                 int j =0;
				for (int i = 0; i < length; i++) {
					if (Arrays.asList(checkbox2).contains(""+i)) {
						if(i<referenceFieldList.get(refIndex).getLabelInfoBean2()
								.getStatusList().size()){
						referenceFieldList.get(refIndex).getLabelInfoBean2()
								.getStatusList().set(i, "ACTIVE");
						} else {
							if (label2Values != null
									&& !label2Values[j].equals("")) {
								referenceFieldList.get(refIndex)
										.getLabelInfoBean2().getValueList()
										.add(label2Values[j]);
								referenceFieldList.get(refIndex)
										.getLabelInfoBean2().getStatusList()
										.add("ACTIVE");
							}
							j++;
						}
					} else {
						if(i<referenceFieldList.get(refIndex).getLabelInfoBean2()
								.getStatusList().size()){
							referenceFieldList.get(refIndex)
							.getLabelInfoBean2().getStatusList().set(i,
									"INACTIVE");
						}else{
						if (label2Values != null && !label2Values[j].equals("")) {
							referenceFieldList.get(refIndex)
									.getLabelInfoBean2().getValueList().add(
											label2Values[j]);
							referenceFieldList.get(refIndex)
									.getLabelInfoBean2().getStatusList().add("INACTIVE");
						}
						j++;
					}
						
					}
				}
			}
		}
		if (label3Type!= null && !label3Type.equals("-1")) {
			if(referenceFieldList.get(refIndex).getRefTxtLabel3()==null || referenceFieldList.get(refIndex).getRefTxtLabel3().equals("")){
				int referenceCode = languageMgmtController.getDisplayCode(label3, 1,
						1, domainId);
				referenceFieldList.get(refIndex).setRefTxtLabel3(referenceCode);
			}
			referenceFieldList.get(refIndex).setRefTxtLabel3Type(label3Type);
			if (label3Type.equals("List")) {
				int length = 0;
                if(label3Values!=null){
               	 length = referenceFieldList.get(refIndex).getLabelInfoBean3()
						.getStatusList().size() + label3Values.length;
                }else{
               	 length = referenceFieldList.get(refIndex).getLabelInfoBean3()
						.getStatusList().size();
                }
                int j =0;
				for (int i = 0; i < length; i++) {
					if (Arrays.asList(checkbox3).contains(""+i)) {
						if(i<referenceFieldList.get(refIndex).getLabelInfoBean3()
								.getStatusList().size()){
						referenceFieldList.get(refIndex).getLabelInfoBean3()
								.getStatusList().set(i, "ACTIVE");
						}else{
							if(label3Values != null && !label3Values[j].equals(""))
							{
							referenceFieldList.get(refIndex).getLabelInfoBean3()
								.getValueList().add(label3Values[j]);
							referenceFieldList.get(refIndex).getLabelInfoBean3()
							.getStatusList().add("ACTIVE");
						}
							j++;
					  }
					} else{
						if(i<referenceFieldList.get(refIndex).getLabelInfoBean3()
								.getStatusList().size()){
							referenceFieldList.get(refIndex).getLabelInfoBean3()
							.getStatusList().set(i,"INACTIVE");
						}else{
						if(label3Values != null && !label3Values[j].equals("")){
						referenceFieldList.get(refIndex).getLabelInfoBean3()
							.getValueList().add(label3Values[j]);
						referenceFieldList.get(refIndex).getLabelInfoBean3()
								.getStatusList().add("INACTIVE");
						}
						j++;
					}
						
					}
						
				}
			}
		}

		httpSession.setAttribute("referenceFieldList", referenceFieldList);
	}
	
	catch(PMSException ex){
		ex.printStackTrace();
	}
	catch(Exception ex){
		ex.printStackTrace();
	}
}
	@SuppressWarnings("unchecked")
	public String saveReferralsList() {
		LanguageMgmtController languageMgmtController = new LanguageMgmtController();
		DomainMgmtController domainMgmtController = new DomainMgmtController();
		HttpSession httpSession = null;
		try {
		httpSession = request.getSession();
		referenceFieldList = (List<ReferenceInfoBean>) httpSession
				.getAttribute("referenceFieldList");
		addReferenceFieldList = (List<ReferenceListBean>) httpSession
				.getAttribute("addReferenceFieldList");
		for (int i = 0; i < addReferenceFieldList.size(); i++) {
			ReferenceInfoBean referenceInfoBean = new ReferenceInfoBean();
			ReferenceListBean listBean = addReferenceFieldList.get(i);
			int refNameCode = languageMgmtController.getDisplayCode(listBean
					.getReferenceName(), 1, 1, domainId);
			referenceInfoBean.setReferenceName(refNameCode);
			referenceInfoBean.setDisplayName(listBean.getReferenceName());
			if (listBean.getRefTxtLabel1()!= null && !listBean.getRefTxtLabel1().equals("")
					) {

				int label1Code = languageMgmtController.getDisplayCode(listBean
						.getRefTxtLabel1(), 1, 1, domainId);
				referenceInfoBean.setRefTxtLabel1(label1Code);
				referenceInfoBean.setRefTxtLabel1Type(listBean
						.getRefTxtLabel1Type());
			}
			if (listBean.getRefTxtLabel2()!= null && !listBean.getRefTxtLabel2().equals("")
					) {
				int label2Code = languageMgmtController.getDisplayCode(listBean
						.getRefTxtLabel2(), 1, 1, domainId);
				referenceInfoBean.setRefTxtLabel2(label2Code);
				referenceInfoBean.setRefTxtLabel2Type(listBean
						.getRefTxtLabel2Type());
			}
			if (listBean.getRefTxtLabel3() != null && !listBean.getRefTxtLabel3().equals("") ) {
				int label3Code = languageMgmtController.getDisplayCode(listBean
						.getRefTxtLabel3(), 1, 1, domainId);
				referenceInfoBean.setRefTxtLabel3(label3Code);
				referenceInfoBean.setRefTxtLabel3Type(listBean
						.getRefTxtLabel3Type());
			}
			if (listBean.getRefTxtLabel1()!=null && listBean.getRefTxtLabel1Type().equals("List")) {
				for(int j =0;j<listBean.getLabelInfoBean1().getValueList().size();j++){
					String string = listBean.getLabelInfoBean1().getValueList().get(j);
					if ( string!= null && !string.equals("")) {
						referenceInfoBean.getLabelInfoBean1().setLabelname(
								listBean.getRefTxtLabel1());
						referenceInfoBean.getLabelInfoBean1().getValueList()
								.add(string);
						referenceInfoBean.getLabelInfoBean1()
						.getStatusList().add(listBean.getLabelInfoBean1().getStatusList().get(j));
					}
				}
			}
			if (listBean.getRefTxtLabel2()!=null && listBean.getRefTxtLabel2Type().equals("List")) {
				for(int j =0;j<listBean.getLabelInfoBean2().getValueList().size();j++){
					String string = listBean.getLabelInfoBean2().getValueList().get(j);
					if (string!= null && !string.equals("") ) {
						referenceInfoBean.getLabelInfoBean2().setLabelname(
								listBean.getRefTxtLabel2());
						referenceInfoBean.getLabelInfoBean2().getValueList()
								.add(string);
						referenceInfoBean.getLabelInfoBean2()
						.getStatusList().add(listBean.getLabelInfoBean2().getStatusList().get(j));
					}
				}
			}
			if (listBean.getRefTxtLabel3()!= null && listBean.getRefTxtLabel3Type().equals("List")) {
				for(int j =0;j<listBean.getLabelInfoBean3().getValueList().size();j++){
					String string = listBean.getLabelInfoBean3().getValueList().get(j);
					if (string!= null && !string.equals("")  ) {
						referenceInfoBean.getLabelInfoBean3().setLabelname(
								listBean.getRefTxtLabel3());
						referenceInfoBean.getLabelInfoBean3().getValueList()
								.add(string);
						referenceInfoBean.getLabelInfoBean3()
						.getStatusList().add(listBean.getLabelInfoBean3().getStatusList().get(j));
					}
				}
			}
			referenceFieldList.add(referenceInfoBean);
		}
		for (int i = 0; i < referenceFieldList.size(); i++) {
			if (Arrays.asList(refId).contains("" + i)) {
				referenceFieldList.get(i).setStatus("ACTIVE");
			} else
				referenceFieldList.get(i).setStatus("INACTIVE");
		}
		
			domainMgmtController.setReferralList(domainId, referenceFieldList, userInfoBean.getUserId());
		} catch (PMSException pmse) {
			// logger.info("exception occured");
			pmse.printStackTrace();
			addActionError(pmse.getErrorMessage());
			return "exception";
		}
		catch(Exception ex){
			ex.printStackTrace();
			addActionError("Some Internal Error");
			return "exception";
		}
		httpSession.removeAttribute("referenceFieldList");
		httpSession.removeAttribute("addReferenceFieldList");
		return SUCCESS;
	}

	public String loadSecQueList() {
		Gson gson = new Gson();
		DomainMgmtController domainMgmtController = new DomainMgmtController();
		
		try {
			resource = Utility.fetchGlobalProperties();
			secQuesList = new ArrayList<SecurityQuesInfoBean>();
			secQuesList = domainMgmtController.fetchSecQues(domainId);
			jsonList = gson.toJson(secQuesList);
			log.info(jsonList);
		} catch (PMSException pmse) {
			addActionError(pmse.getErrorMessage());
			pmse.printStackTrace();
			return "exception";
		}catch (Exception be) {
			addActionError("Some Internal Error!");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;

	}

	public String saveSecQues() {
		Gson gson = new Gson();
		LanguageMgmtController languageMgmtController = new LanguageMgmtController();
		secQuesList = new ArrayList<SecurityQuesInfoBean>();
		try {
			Type type = new TypeToken<List<SecurityQuesInfoBean>>() {}.getType();
			secQuesList = gson.fromJson(jsonList, type);
			for (int i = 0; i < secQuesList.size(); i++) {
				SecurityQuesInfoBean securityQuesInfoBean = new SecurityQuesInfoBean();
				securityQuesInfoBean = secQuesList.get(i);
				if(securityQuesInfoBean.getSecQues()==0){
					int secQuesCode = languageMgmtController.getDisplayCode(securityQuesInfoBean
							.getDisplayName(), 1, 1, domainId);
					securityQuesInfoBean.setSecQues(secQuesCode);
				}
				if (Arrays.asList(refId).contains("" + i)) {
					securityQuesInfoBean.setStatus("ACTIVE");
				} else {
					securityQuesInfoBean.setStatus("INACTIVE");
				}
			}
			DomainMgmtController domainMgmtController = new DomainMgmtController();
			
				domainMgmtController.setSecQuesList(domainId, secQuesList, userInfoBean.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error!");
			return "exception";
		}
		return SUCCESS;

	}
	
	public String getCountries() {
		List<CountryBean> countryStateBean;
		DomainMgmtController domainMgmtController = new DomainMgmtController();
		try{
			countryStateBean = domainMgmtController.fetchDomainCountryList(domainId);
			request.setAttribute("countryStateBean", countryStateBean);
		}catch (PMSException pmse) {
		//	logger.info("exception occured");
			pmse.printStackTrace();
			addActionError(pmse.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}

	public String blockCountryStateSave(){
		DomainMgmtController domainMgmtController = new DomainMgmtController();
		CountryStateBean countryStateBean = new CountryStateBean();
		countryStateBean.setCountryCode(country);
		countryStateBean.setStateCode(state);
		try{
			domainMgmtController.setAllowedCountryState(domainId,countryStateBean,userInfoBean.getUserId());
		}catch (PMSException pmse) {
		//	logger.info("exception occured");
			pmse.printStackTrace();
			addActionError(pmse.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		
		return SUCCESS;
	}
	
	public String getContentNameMap() {
		DomainMgmtController domainController = new DomainMgmtController();
		Gson gson = new Gson();
		try{
			Map<String,List<MenuContentBean>> menuContentBeanMap = domainController.getPortalContentMap(aliasId,device);
			contentMap = gson.toJson(menuContentBeanMap);
		}
		catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String submitMenuDetail() throws PMSException{
		try {
		log.info(menuString);
		Gson gson = new Gson();
		MenuDataBean menuDataBean = gson.fromJson(menuString, MenuDataBean.class);
		log.info(menuDataBean);
		DomainMgmtController domainController = new DomainMgmtController();
		LanguageMgmtController langController = new LanguageMgmtController();
		menuDataBean.setDisplayCode(langController.getDisplayCode(menuDataBean.getDisplayName(), 1, 1, domainId));
		if(menuDataBean.getSubMenuList()!=null){
			  for (int i = 0; i < menuDataBean.getSubMenuList().size(); i++) {
				menuDataBean.getSubMenuList().get(i).setDisplayCode(langController.getDisplayCode(menuDataBean.getSubMenuList().get(i).getDisplayName(), 1, 1, domainId));
					 if(menuDataBean.getSubMenuList().get(i).getSubMenuList()!=null){
						for (int j = 0; j < menuDataBean.getSubMenuList().get(i).getSubMenuList().size(); j++) {
							 menuDataBean.getSubMenuList().get(i).getSubMenuList().get(j).setDisplayCode(langController.getDisplayCode(menuDataBean.getSubMenuList().get(i).getSubMenuList().get(j).getDisplayName(), 1, 1, domainId));
						}
				  }
			 }
		}
		
			domainController.submitAddMenuDetail(menuDataBean,getDomainId(),aliasId,getDevice().trim(), userInfoBean.getUserId());
			CommonMethodController.getInstance().invalidateCache("MenuMasterViewCache");
		}catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}

	
	public String fetchMenuList() {
		PrintWriter out = null;
		Gson gson = new Gson();
		try {
			DomainMgmtController domainController = new DomainMgmtController();
			List<PortalMenuBean> menuBeanList = domainController.fetchMenuBeanList(aliasId, device);
			Type type = new TypeToken<List<PortalMenuBean>>() {}.getType();
			menuString = gson.toJson(menuBeanList, type);
			if (menu != null) {
				for (PortalMenuBean menuBean : menuBeanList) {
					if (menuBean.getMenuDisplayName().trim().equals(menu.trim())) {
						menuData = new PortalMenuBean();
						menuData.setMenuId(menuBean.getMenuId());
						menuData.setContentName(menuBean.getContentName());
						menuData.setContentType(menuBean.getContentType());
//						menuData.setIsPreLogin(menuBean.getIsPreLogin());
						menuData.setMenuBeanList(menuBean.getMenuBeanList());
						menuData.setMenuDisplayName(menuBean.getMenuDisplayName());
						menuData.setStatus(menuBean.getStatus());
						menuData.setHighLightOpt("INACTIVE");

					}
				}
				Map<String,List<MenuContentBean>> menuContentBeanMap = domainController.getPortalContentMap(aliasId,device);
				contentMap = gson.toJson(menuContentBeanMap);
			}else{
				out = response.getWriter();
				out.write(menuString);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return INPUT;
		}
		if (menu != null) {
			return SUCCESS;
		} else
			return NONE;
	}
	
	
	public String fetchMenuListByMenuId() {
		PrintWriter out = null;
		Gson gson = new Gson();
		try {
			DomainMgmtController domainController = new DomainMgmtController();
			List<PortalMenuBean> menuBeanList = domainController.fetchMenuBeanList(aliasId, device);
			Type type = new TypeToken<List<PortalMenuBean>>() {}.getType();
			menuString = gson.toJson(menuBeanList, type);
			if (menu != null) {
				for (PortalMenuBean menuBean : menuBeanList) {
					if (menuBean.getMenuId()== Integer.parseInt(menu)) {
						menuData = new PortalMenuBean();
						menuData.setMenuId(menuBean.getMenuId());
						menuData.setContentName(menuBean.getContentName());
						menuData.setContentType(menuBean.getContentType());
//						menuData.setIsPreLogin(menuBean.getIsPreLogin());
						menuData.setMenuBeanList(menuBean.getMenuBeanList());
						menuData.setMenuDisplayName(menuBean.getMenuDisplayName());
						menuData.setStatus(menuBean.getStatus());
						menuData.setHighLightOpt("INACTIVE");

					}
				}
				Map<String,List<MenuContentBean>> menuContentBeanMap = domainController.getPortalContentMap(aliasId,device);
				contentMap = gson.toJson(menuContentBeanMap);
			}else{
				out = response.getWriter();
				out.write(menuString);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return INPUT;
		}
		if (menu != null) {
			return SUCCESS;
		} else
			return NONE;
	}
	
	public String saveEditMenuDetail(){
		Gson gson = new Gson();
		String menuDisplay="";
		try{
			MenuDataBean menuDataBean = gson.fromJson(menuString, MenuDataBean.class);
			DomainMgmtController domainController = new DomainMgmtController();
			LanguageMgmtController langController = new LanguageMgmtController();
			menuDataBean.setDisplayCode(langController.getDisplayCode(menuDataBean.getDisplayName(), 1, 1, domainId));
			if(menuDataBean.getSubMenuList()!=null){
				  for (int i = 0; i < menuDataBean.getSubMenuList().size(); i++) {
					  menuDisplay=menuDataBean.getSubMenuList().get(i).getDisplayName();
					menuDataBean.getSubMenuList().get(i).setDisplayCode(langController.getDisplayCode(menuDataBean.getSubMenuList().get(i).getDisplayName(), 1, 1, domainId));
						 if(menuDataBean.getSubMenuList().get(i).getSubMenuList()!=null){
							for (int j = 0; j < menuDataBean.getSubMenuList().get(i).getSubMenuList().size(); j++) {
								 menuDisplay=menuDataBean.getSubMenuList().get(i).getSubMenuList().get(j).getDisplayName();
								 menuDataBean.getSubMenuList().get(i).getSubMenuList().get(j).setDisplayCode(langController.getDisplayCode(menuDataBean.getSubMenuList().get(i).getSubMenuList().get(j).getDisplayName(), 1, 1, domainId));
							}
					  }
				 }
			}
			domainController.submitEditMenu(menuDataBean,getDomainId(),aliasId,getDevice().trim(), userInfoBean.getUserId());
			CommonMethodController.getInstance().invalidateCache("MenuMasterViewCache");
		}
		catch (Exception e) {
			addActionError("'"+menuDisplay+"' menu name is not available.");
			e.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}
	
	@SuppressWarnings("unchecked")
	public void checkReferenceName(){
		HttpSession httpSession = request.getSession();
		referenceFieldList = (List<ReferenceInfoBean>) httpSession.getAttribute("referenceFieldList");
		addReferenceFieldList = (List<ReferenceListBean>) httpSession.getAttribute("addReferenceFieldList");
		boolean chkRefNameDao = true;
		try {
			for (ReferenceInfoBean infoBean : referenceFieldList) {
				if(infoBean.getDisplayName().equals(refNmae)){
					chkRefNameDao = false;
					break;
				}
			}
			if(addReferenceFieldList!=null && chkRefNameDao){
				for (ReferenceListBean listBean : addReferenceFieldList) {
					if(listBean.getReferenceName().equals(refNmae)){
						chkRefNameDao = false;
						break;
					}
				}
			}
			if(!chkRefNameDao){
				response.getWriter().write("Reference Name not available.");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public String domainCheckList() {
		DomainMgmtController domainMgmtController = new DomainMgmtController();
		try {
			if (domainId != 0) {
				domainCheckList = domainMgmtController.showCheckList(domainId);
			}
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception_nodecorate";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception_nodecorate";
		}
		return SUCCESS;

	}

	public String activeReportsList() {
		DomainMgmtController controller = new DomainMgmtController();
		try {
			if (domainId > 0) {
				activeReportsList = controller.activeReportsList(domainId);
			}
		} catch (PMSException be) {
			addActionError(be.getErrorMessage());
			be.printStackTrace();
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}

	public String activeReportListsave() {
		try {
			Map<String, String> activeMap = null;
			Gson data = new GsonBuilder().create();
			Type dataType = new TypeToken<Map<String, String>>() {
			}.getType();
			activeMap = data.fromJson(newActiveReportList, dataType);
			DomainMgmtController controller = new DomainMgmtController();
			if (domainId > 0)
				controller.activeReportListSave(domainId, activeMap);
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

	
	public String uploadCssSave(){
		try{
			StDmDomainAliasNameMaster aliasMaster = CommonMethodController.getInstance().getAliasMaster(aliasId);
			String domainName = aliasMaster.getDomainMaster().getDomainName();
			String aliasName = aliasMaster.getAliasName();
			String filePath = domainName+"|"+aliasName+"|default|pc|LR|css";
			Utility.saveOrUpdateContent(uploadCss,"custom.css", filePath);
		}catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error!");
			return "exception_nodecorate";
		}
		return SUCCESS;
	}
	
	public String fetchLocations(){
		try {
			locMaster = new DomainMgmtController().fetchLocations(domainId);
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error!");
			return "exception";
		}
		return SUCCESS;
	}
	
	public String fetchDevices(){
		try {
			devMaster = new DomainMgmtController().fetchAllDevices(aliasId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String updateLocation(){
		try {
			new DomainMgmtController().updateLocation(locMas);
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error!");
			return "exception";
		}
		return SUCCESS;
	}
	
	public String updateDevices(){
		try {
			new DomainMgmtController().updateDevices(devMas,aliasId);
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error!");
			return "exception";
		}
		return SUCCESS;
	}
	
	public String updLocStatus() {
		try {
			new DomainMgmtController().updLocStatus(locId, status);
			return SUCCESS;
		} catch (PMSException e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String updDevMapStatus() {
		try {
			new DomainMgmtController().updDevMapStatus(devMapId, status);
			return SUCCESS;
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			e.printStackTrace();
			return ERROR;
		}
	}

	public void deleteMapping() {
		try {
			new DomainMgmtController().updDevMapStatus(devMapId, "DELETED");
			response.getWriter().write("SUCCESS");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			e.printStackTrace();
		}
	}
	
	public String fetchLocDevMapping() throws PMSException {
		try {
			DomainMgmtController cont = new DomainMgmtController();
			devMapping = cont.fetchLocDevMapping(aliasId);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	public String updDeviceStatus() {
		try {
			new DomainMgmtController().updDeviceStatus(devId, status);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
		
	public String updSaveDevMapping(){
		try {
			new DomainMgmtController().updSaveDevMapping(locDevMap, userInfoBean.getUserId());
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}
		
	public void validate() {
		try {
			String actionName = (String) ActionContext.getContext()
					.getContextMap().get(ActionContext.ACTION_NAME);
			if (actionName.equalsIgnoreCase("bo_dm_boDomainReg_Save")) {
				if (domainBean.getDomainName().equals("")) {
					addFieldError("domainName", "Domain Name must to be Fill");
				}
				if ("".equals(userDetailBean.getFirstName())
						|| userDetailBean.getFirstName() == null) {
					addFieldError("firstName", "Please enter the First name");
				} else if (!UserValidation.isAlphabetic(userDetailBean
						.getFirstName(), false)) {
					addFieldError("firstName",
							"Please enter the First name Correctly");
				}
				if ("".equals(userDetailBean.getLastName())
						|| userDetailBean.getLastName() == null) {
					addFieldError("lastName", "Please enter the Last name");
				} else if (!UserValidation.isAlphabetic(userDetailBean
						.getLastName(), false)) {
					addFieldError("lastName",
							"Please enter the Last name Correctly");
				}
				if ("-1".equals(userDetailBean.getGender())) {
					addFieldError("gender", "Please Select Gender");
				}
				if ("".equals(userDetailBean.getUserName())
						|| userDetailBean.getUserName() == null) {
					addFieldError("userName", "Please enter the Login name");
				} else if (!UserValidation.isAlphanumeric(userDetailBean
						.getUserName(), false)) {
					addFieldError("userName",
							"Please enter the user name Correctly");
				}
				if ("".equals(userDetailBean.getEmailId())
						|| userDetailBean.getEmailId() == null) {
					addFieldError("email", "Enter the email");

				} else if (!UserValidation.validateEmail(userDetailBean
						.getEmailId())) {
					addFieldError("email", "Email is Invalid");
				}
				if (userDetailBean.getPhoneNbr().equals("")) {
					addFieldError("phone", "Please enter a valid phone number");
				}
				if ("-1".equals(userDetailBean.getSecQues())) {
					addFieldError("secQues",
							"Please Select Any Security Question");
				}
				if ("".equals(userDetailBean.getSecAns())
						|| userDetailBean.getSecAns() == null) {
					addFieldError("secAns", "Please Enter Security Answer");

				}

			}
			if (actionName.equalsIgnoreCase("bo_dm_boDomainReg_Save")
					|| actionName.equalsIgnoreCase("bo_dm_boDomainEdit_Save")) {
				if ("".equals(domainBean.getDomainOwner())) {
					addFieldError("ownerName", "Owner Name must to  be Fill");
				}
				if ("".equals(domainBean.getAddress())) {
					addFieldError("address", "Address Name must to be Fill.");
				}
				if ("-1".equalsIgnoreCase(domainBean.getCountryCode())) {
					addFieldError("country", "Contry will be selected");
				}
				if ("-1".equalsIgnoreCase(domainBean.getStateCode())) {
					addFieldError("state", "State will be selected");
				}
				if ("".equalsIgnoreCase(domainBean.getContactPersonName())) {
					addFieldError("person",
							"Contact Person Name must to be Fill.");
				} else if (!UserValidation.isAlphabetic(domainBean
						.getContactPersonName(), true)) {
					addFieldError("person",
							"Please enter the Contact Person Name Correctly");

				}

				if (domainBean.getOwnerContactNo() == null) {
					addFieldError("mobile", "Phone Number must to be Fill.");
				}

				if (domainBean.getLoginThroughEmail().equals("false")
						&& domainBean.getLoginThroughFconnect().equals("false")
						&& domainBean.getLoginThroughMobileNo().equals("false")
						&& domainBean.getLoginThroughUsername().equals("false")) {
					addFieldError("LoginAllowThrough",
							"Please Check the Login Allow Through");
				}
				if ("-1".equals(domainBean.getPlrPassword())) {
					addFieldError("plrPassword", "Please Enter Player Password");

				}
				
				if (domainBean.getCurrency().size() <=0 || domainBean.getCurrencyId()<=0) {
					addFieldError("currency", "Please Check the Currency ");
				}
				if (domainBean.getLanguage().size() <=0 || domainBean.getLanguageId() <= 0) {
					addFieldError("language", "Please Check the Language ");
				}	
				
				if ("".equals(domainBean.getLayoutPc())) {
					addFieldError("pcLayout",
							"Please select the Layout for PC ");
				}
				if ("".equals(domainBean.getPcDomainAlias().get(0))) {
					addFieldError("pcDomainAlias",
							"Please Fill the Domain Alias for PC ");
				}

				if ("".equals(domainBean.getLayoutMobile())) {
					addFieldError("mobileLayout",
							"Please select the Layout for Mobile ");
				}
				if ("".equals(domainBean.getMobileDomainAlias().get(0))) {
					addFieldError("mobileDomainAlias",
							"Please Fill the Domain Alias for Mobile ");
				}

				if (domainBean.getLayoutTab() == "") {
					addFieldError("tabLayout",
							"Please select the Layout for Tab ");
				}
				if ("".equals(domainBean.getTabDomainAlias().get(0))) {
					addFieldError("tabDomainAlias",
							"Please Fill the Domain Alias for Tab ");
				}

				if (domainBean.getServiceId() == -1) {
					addFieldError("service",
							"Please select the default service  ");
				}
				if (domainBean.getGameTryBeforeLogin() == null) {
					addFieldError("gameTry",
							"Please select the Game Try Before Login");
				}
				if (domainBean.getBonusWrCarryFwd() == null) {
					addFieldError("bonusWrCarryFwd",
							"Please select the Bonus Wagering Carry Forword");
				}
			}
			if (actionName.equalsIgnoreCase("bo_dm_boDomainReg_Save")) {
				if (getFieldErrors().size() > 0) {
					Map<String, Object> maps = new DomainMgmtController()
							.fetchDomainRegistrationMaps();
					fetchCommonRegistrationData(maps);
				}
			}
			if(actionName.equalsIgnoreCase("st_dm_uploadCss_Save")){
				if(uploadCss!=null){
					double bytes = uploadCss.length();
					if(bytes<=0.0)
						addFieldError("fileSize", "File doesn't contains any data or File is Empty");
				}
			}
			if(actionName.equalsIgnoreCase("st_dm_uploadCss_Save")){
				if (getFieldErrors().size() > 0) {
					getDomainNameList();
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void checkAliasNameAvailability() {
		DomainMgmtController controller = new DomainMgmtController();
		try {
			response.getWriter().write(
					controller.checkAliasNameAvailability(aliasName) ? "<p>Available</p>" : "<p>Not Available</p>");
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String saveAlias() {
		DomainMgmtController controller = new DomainMgmtController();
		try {
			controller.saveAlias(aliasName, aliasBean);			
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String searchSmsEmailProvider() {
		DomainMgmtController controller = new DomainMgmtController();
		try {
			emailList = controller.searchSmsEmailProviderOptions(domainId, aliasId,getProviderType());
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception_nodecorate";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception_nodecorate";
		}
		return SUCCESS;
	}
	
	public String updateEmailProviderOrder() {
		Map<String, String> emailProviderOrder = null;
		Type type = new TypeToken<Map<String, String>>() {
		}.getType();
		emailProviderOrder = new Gson().fromJson(emailOrderStr, type);

		DomainMgmtController controller = new DomainMgmtController();
		try {
			if (userInfoBean != null) {
				controller.updateEmailProviderOrder(emailProviderOrder, userInfoBean);
			} else {
				return "SESSION_TIME_OUT";
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
		return SUCCESS;
	}
	
	public void checkUniqueMAC() {
		try {
			if(devMas!=null && devMas.getDeviceMacAddress()!=null && !"".equals(devMas.getDeviceMacAddress())){
				if(!new DomainMgmtController().checkUniqueMAC(devMas.getDeviceMacAddress(),devMas.getDeviceId()==null?0:devMas.getDeviceId()))
					response.getWriter().write("<p>MAC Address not available!</p>");
				else {
					response.getWriter().write("<p>MAC Address Available</p>");
				}
			}else 
				response.getWriter().write("<p>Please input a valid MAC Address!</p>");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void checkUniqueDevName() {
		try {
			if(devMas!=null && devMas.getDeviceName()!=null && !"".equals(devMas.getDeviceName())){
				if(!new DomainMgmtController().checkUniqueDevName(aliasId,devMas.getDeviceName(),devMas.getDeviceId()==null?0:devMas.getDeviceId()))
					response.getWriter().write("<p>Device name not available!</p>");
				else {
					response.getWriter().write("<p>Device name available</p>");
				}
			}else 
				response.getWriter().write("<p>Please input a valid device name</p>");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void checkUniqueLocName() {
		try {
			if(locMas!=null && locMas.getLocationName()!=null && !"".equals(locMas.getLocationName())){
				if(!new DomainMgmtController().checkUniqueLocName(locMas.getLocationName(),locMas.getLocationId()==null?0:locMas.getLocationId()))
					response.getWriter().write("<p>Location name not available!</p>");
				else {
					response.getWriter().write("<p>Location name available</p>");
				}
			}else 
				response.getWriter().write("<p>Please input a valid location name</p>");
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
	
	public void fetchActiveDeviceLocation(){
		try{
			Map<String, Object> resp=new DomainMgmtController().fetchActiveDeviceLocation(domainId,aliasId);
			response.getWriter().write(new Gson().toJson(resp));
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getEmailOrderStr() {
		return emailOrderStr;
	}

	public void setEmailOrderStr(String emailOrderStr) {
		this.emailOrderStr = emailOrderStr;
	}

	public List<StGenSmsEmailProviderMaster> getEmailList() {
		return emailList;
	}

	public void setEmailList(List<StGenSmsEmailProviderMaster> emailList) {
		this.emailList = emailList;
	}

	public void setDomainBean(DomainPropertyBean domainBean) {
		this.domainBean = domainBean;
	}

	public DomainPropertyBean getDomainBean() {
		return domainBean;
	}

	public void setUserDetailBean(UserDetailsBean userDetailBean) {
		this.userDetailBean = userDetailBean;
	}

	public UserDetailsBean getUserDetailBean() {
		return userDetailBean;
	}

	public void setPasswordPolicyMap(Map<Integer, String> passwordPolicyMap) {
		this.passwordPolicyMap = passwordPolicyMap;
	}

	public Map<Integer, String> getPasswordPolicyMap() {
		return passwordPolicyMap;
	}	

	public Map<String, CountryBean> getCountryMap() {
		return countryMap;
	}

	public void setCountryMap(Map<String, CountryBean> countryMap) {
		this.countryMap = countryMap;
	}

	public String getCountryStr() {
		return countryStr;
	}

	public void setCountryStr(String countryStr) {
		this.countryStr = countryStr;
	}

	public void setCurrencyMap(Map<Integer, CurrencyBean> currencyMap) {
		this.currencyMap = currencyMap;
	}

	public Map<Integer, CurrencyBean> getCurrencyMap() {
		return currencyMap;
	}

	public void setServiceMap(Map<Short, String> serviceMap) {
		this.serviceMap = serviceMap;
	}

	public Map<Short, String> getServiceMap() {
		return serviceMap;
	}

	public void setLanguageMap(HashMap<Integer, LanguageBean> languageMap) {
		this.languageMap = languageMap;
	}

	public HashMap<Integer, LanguageBean> getLanguageMap() {
		return languageMap;
	}

	public void setDomainLogo(File domainLogo) {
		this.domainLogo = domainLogo;
	}

	public File getDomainLogo() {
		return domainLogo;
	}

	public void setDomainLogoContentType(String domainLogoContentType) {
		this.domainLogoContentType = domainLogoContentType;
	}

	public String getDomainLogoContentType() {
		return domainLogoContentType;
	}

	public void setDomainLogoFileName(String domainLogoFileName) {
		this.domainLogoFileName = domainLogoFileName;
	}

	public String getDomainLogoFileName() {
		return domainLogoFileName;
	}

	public PropertiesConfiguration getResource() {
		return resource;
	}

	public void setResource(PropertiesConfiguration resource) {
		this.resource = resource;
	}

	public List<ReferenceInfoBean> getReferenceFieldList() {
		return referenceFieldList;
	}

	public void setReferenceFieldList(List<ReferenceInfoBean> referenceFieldList) {
		this.referenceFieldList = referenceFieldList;
	}

	public String getLabel1() {
		return label1;
	}

	public void setLabel1(String label1) {
		this.label1 = label1;
	}

	public String getLabel2() {
		return label2;
	}

	public void setLabel2(String label2) {
		this.label2 = label2;
	}

	public String getLabel3() {
		return label3;
	}

	public void setLabel3(String label3) {
		this.label3 = label3;
	}

	public String getRefNmae() {
		return refNmae;
	}

	public void setRefNmae(String refNmae) {
		this.refNmae = refNmae;
	}

	public String getLabel1Type() {
		return label1Type;
	}

	public void setLabel1Type(String label1Type) {
		this.label1Type = label1Type;
	}

	public String getLabel2Type() {
		return label2Type;
	}

	public void setLabel2Type(String label2Type) {
		this.label2Type = label2Type;
	}

	public String getLabel3Type() {
		return label3Type;
	}

	public void setLabel3Type(String label3Type) {
		this.label3Type = label3Type;
	}

	public List<ReferenceListBean> getAddReferenceFieldList() {
		return addReferenceFieldList;
	}

	public void setAddReferenceFieldList(
			List<ReferenceListBean> addReferenceFieldList) {
		this.addReferenceFieldList = addReferenceFieldList;
	}

	public String[] getLabel1Values() {
		return label1Values;
	}

	public void setLabel1Values(String[] label1Values) {
		this.label1Values = label1Values;
	}

	public String[] getLabel2Values() {
		return label2Values;
	}

	public void setLabel2Values(String[] label2Values) {
		this.label2Values = label2Values;
	}

	public String[] getLabel3Values() {
		return label3Values;
	}

	public void setLabel3Values(String[] label3Values) {
		this.label3Values = label3Values;
	}

	public String[] getCheckbox1() {
		return checkbox1;
	}

	public void setCheckbox1(String[] checkbox1) {
		this.checkbox1 = checkbox1;
	}

	public String[] getCheckbox2() {
		return checkbox2;
	}

	public void setCheckbox2(String[] checkbox2) {
		this.checkbox2 = checkbox2;
	}

	public String[] getCheckbox3() {
		return checkbox3;
	}

	public void setCheckbox3(String[] checkbox3) {
		this.checkbox3 = checkbox3;
	}

	public String[] getRefId() {
		return refId;
	}

	public void setRefId(String[] refId) {
		this.refId = refId;
	}

	public Integer getRefIndex() {
		return refIndex;
	}

	public void setRefIndex(Integer refIndex) {
		this.refIndex = refIndex;
	}

	public List<SecurityQuesInfoBean> getSecQuesList() {
		return secQuesList;
	}

	public void setSecQuesList(List<SecurityQuesInfoBean> secQuesList) {
		this.secQuesList = secQuesList;
	}

	public String[] getCountry() {
		return country;
	}

	public void setCountry(String[] country) {
		this.country = country;
	}

	public String[] getState() {
		return state;
	}

	public void setState(String[] state) {
		this.state = state;
	}

	public PortalMenuBean getMenuData() {
		return menuData;
	}

	public void setMenuData(PortalMenuBean menuData) {
		this.menuData = menuData;
	}

	public String getMenu() {
		return menu;
	}

	public void setMenu(String menu) {
		this.menu = menu;
	}

	public String getContentMap() {
		return contentMap;
	}

	public void setContentMap(String contentMap) {
		this.contentMap = contentMap;
	}

	public String getJsonList() {
		return jsonList;
	}

	public void setJsonList(String jsonList) {
		this.jsonList = jsonList;
	}

	public String getMenuString() {
		return menuString;
	}

	public void setMenuString(String menuString) {
		this.menuString = menuString;
	}

	public String getDevice() {
		return device;
	}

	public void setDevice(String device) {
		this.device = device;
	}

	public void setAutoVerificationSourceMap(
			Map<Short, StGenVerificationSourceMaster> autoVerificationSourceMap) {
		this.autoVerificationSourceMap = autoVerificationSourceMap;
	}

	public Map<Short, StGenVerificationSourceMaster> getAutoVerificationSourceMap() {
		return autoVerificationSourceMap;
	}

	public void setDmActiveCurrMap(Map<Integer, CurrencyBean> dmActiveCurrMap) {
		this.dmActiveCurrMap = dmActiveCurrMap;
	}

	public Map<Integer, CurrencyBean> getDmActiveCurrMap() {
		return dmActiveCurrMap;
	}

	public Map<Integer, LanguageBean> getDmActiveLangMap() {
		return dmActiveLangMap;
	}

	public void setDmActiveLangMap(Map<Integer, LanguageBean> dmActiveLangMap) {
		this.dmActiveLangMap = dmActiveLangMap;
	}

	public void setDomainCheckList(Map<String, String> domainCheckList) {
		this.domainCheckList = domainCheckList;
	}

	public Map<String, String> getDomainCheckList() {
		return domainCheckList;
	}

	public Map<String, String> getActiveReportsList() {
		return activeReportsList;
	}

	public void setActiveReportsList(Map<String, String> activeReportsList) {
		this.activeReportsList = activeReportsList;
	}

	public String getNewActiveReportList() {
		return newActiveReportList;
	}

	public void setNewActiveReportList(String newActiveReportList) {
		this.newActiveReportList = newActiveReportList;
	}
	public File getUploadCss() {
		return uploadCss;
	}
	
	public void setUploadCss(File uploadCss) {
		this.uploadCss = uploadCss;
	}

	public Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>> getRolePriviledgeMap() {
		return rolePriviledgeMap;
	}

	public void setRolePriviledgeMap(
			Map<String, TreeMap<String, TreeMap<String, TreeMap<String, List<UserPrivBean>>>>> rolePriviledgeMap) {
		this.rolePriviledgeMap = rolePriviledgeMap;
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

	public AliasPropertyBean getAliasBean() {
		return aliasBean;
	}

	public void setAliasBean(AliasPropertyBean aliasBean) {
		this.aliasBean = aliasBean;
	}

	public List<LocationMaster> getLocMaster() {
		return locMaster;
	}

	public void setLocMaster(List<LocationMaster> locMaster) {
		this.locMaster = locMaster;
	}

	public LocationMaster getLocMas() {
		return locMas;
	}

	public void setLocMas(LocationMaster locMas) {
		this.locMas = locMas;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer[] getLocId() {
		return locId;
	}

	public void setLocId(Integer[] locId) {
		this.locId = locId;
	}

	public List<DeviceMasterBean> getDevMaster() {
		return devMaster;
	}

	public void setDevMaster(List<DeviceMasterBean> devMaster) {
		this.devMaster = devMaster;
	}

	public Integer[] getDevId() {
		return devId;
	}

	public void setDevId(Integer[] devId) {
		this.devId = devId;
	}

	public DeviceMasterBean getDevMas() {
		return devMas;
	}

	public void setDevMas(DeviceMasterBean devMas) {
		this.devMas = devMas;
	}

	public List<LocDevMappingBean> getDevMapping() {
		return devMapping;
	}

	public void setDevMapping(List<LocDevMappingBean> devMapping) {
		this.devMapping = devMapping;
	}

	public Integer[] getDevMapId() {
		return devMapId;
	}

	public void setDevMapId(Integer[] devMapId) {
		this.devMapId = devMapId;
	}

	public List<Object> getDevLocList() {
		return devLocList;
	}

	public void setDevLocList(List<Object> devLocList) {
		this.devLocList = devLocList;
	}

	public LocDevMappingBean getLocDevMap() {
		return locDevMap;
	}

	public void setLocDevMap(LocDevMappingBean locDevMap) {
		this.locDevMap = locDevMap;
	}

	public String getProviderType() {
		return providerType;
	}

	public void setProviderType(String providerType) {
		this.providerType = providerType;
	}
}*/