package com.stpl.pms.action.bo.pm;

//import java.io.File;
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.lang.reflect.Type;
//import java.net.URLEncoder;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Calendar;
//import java.util.HashMap;
//import java.util.Iterator;
//import java.util.LinkedHashMap;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpSession;
//
//import org.apache.commons.configuration.PropertiesConfiguration;
//import org.apache.commons.io.FilenameUtils;
//import org.apache.commons.lang.StringUtils;
//import org.apache.log4j.Logger;
//import org.hibernate.Session;
//import org.json.JSONArray;
//import org.json.JSONObject;
//
//import com.google.gson.Gson;
//import com.google.gson.GsonBuilder;
//import com.google.gson.reflect.TypeToken;
//import com.opensymphony.xwork2.ActionContext;
//import com.stpl.loyalty.common.Log;
//import com.stpl.pms.controller.cms.CmsController;
//import com.stpl.pms.controller.commonMethods.CommonMethodController;
//import com.stpl.pms.controller.langMgmt.LanguageMgmtController;
//import com.stpl.pms.controller.misc.MiscMgmtController;
//import com.stpl.pms.controller.pm.BoPlayerMgmtController;
//import com.stpl.pms.controller.pm.PlayerMgmtController;
//import com.stpl.pms.controller.reports.ReportsController;
//import com.stpl.pms.exception.PMSErrorCode;
//import com.stpl.pms.exception.PMSErrorMessage;
//import com.stpl.pms.exception.PMSException;
//import com.stpl.pms.hibernate.factory.HibernateSessionFactory;
//import com.stpl.pms.hibernate.mapping.DomainFieldsWithValueBean;
//import com.stpl.pms.hibernate.mapping.StDmAliasDeeplinkRep;
//import com.stpl.pms.hibernate.mapping.StGenAppVersionDetails;
//import com.stpl.pms.hibernate.mapping.StPmPlayerMaster;
//import com.stpl.pms.hibernate.mapping.StPmPlrRdmDocMaster;
//import com.stpl.pms.javabeans.DomainPropertyBean;
//import com.stpl.pms.javabeans.EmailTemplateBean;
//import com.stpl.pms.javabeans.LanguageBean;
//import com.stpl.pms.javabeans.PlayerDocumentMasterBean;
//import com.stpl.pms.javabeans.PlayerInfoBean;
//import com.stpl.pms.javabeans.PlrAppPushBoBean;
//import com.stpl.pms.javabeans.PlrMailContentBean;
//import com.stpl.pms.javabeans.PlrNotificationBean;
//import com.stpl.pms.javabeans.PlrSearchDataBean;
//import com.stpl.pms.javabeans.PlrSearchOptionBean;
//import com.stpl.pms.javabeans.PrivFunctionBean;
//import com.stpl.pms.javabeans.StPmPlrRdmDocMasterBean;
//import com.stpl.pms.javabeans.TemplateListBean;
//import com.stpl.pms.javabeans.TemplateMasterBean;
//import com.stpl.pms.service.rest.javabeans.TicketDetailBean;
import com.stpl.pms.struts.common.BaseActionSupport;
//import com.stpl.pms.utility.AWSWrapper;
//import com.stpl.pms.utility.MultipartUtility;
//import com.stpl.pms.utility.Utility;

public class PlayerMgmtAction extends BaseActionSupport {

}

/*
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger
			.getLogger(PlayerMgmtAction.class);
	private long playerId;
	private List searchPlrList = null;
	private String status = null;
	private String accountBalance = null;
	private String searchResultsAvailable = null;
	private String userName = null;
	private String firstName = null;
	private String lastName = null;
	private String compare = null;
	private String testStatus = null;
	private boolean error;
	private String addressVerified = null;
	private String ageVerified = null;
	private String taxationIdVerified = null;
	private Map<String, List<DomainFieldsWithValueBean>> moduleFieldList;
	private List<DomainFieldsWithValueBean> domainWiseFieldList;
	private List<DomainFieldsWithValueBean> spareFieldList;
	private Map<Short, List<DomainFieldsWithValueBean>> pageWiseFieldMap;
	private Map<String, List<DomainFieldsWithValueBean>> sectionWiseFieldMap;
	private String[] fieldDispName;
	private Short[] fieldSequenceNo;
	private Short[] pageNumber;
	private String[] fieldName;
	private String[] fieldType;
	private Integer[] fieldId;
	private String[] sectionName;
	private Map<Short, DomainPropertyBean> domainPropertyBeansMap;
	private Map<Short, String> domainIdMap;
	private ArrayList plrList;
	private HttpSession httpSession = null;
	private PropertiesConfiguration resource;
	private Integer fieldDispCode[];
	private Integer sectionNameCode[];
	private String regType;
	private PrivFunctionBean privFunctionBean;
	private PlayerDocumentMasterBean plrDocumentMaster;
	private File ageImageName;
	private String ageImageNameFileName;
	private String[] isPartOfMiniReg;
	private Short[] miniSeqNo;
	private int recordPerPage;
	private int paginationPage;
	private String verificationStatus;
	private long[] refundNTerPLrId;
	private String veriAction;
	private Long[] playerIdArr;
	private Map<Long, String> playerMap;
	private List<TemplateMasterBean> tempList;
	private String plrIdList;
	private String jsonObjVariableId;
	private String contentPath;
	private PlrSearchOptionBean searchedCriteria;
	private String languageStr;
	private PlrMailContentBean plrEmailBean;
	private String reportData;
	private String reportDataType;
	private String defaultContentPath;

	private String changeReq;
	private String currentData;
	private String newData;
	private PlayerInfoBean playerInfo;
	private PlayerInfoBean duplicatePlrInfo;
	private Long duplicatePlrId;
	private Long requestPlayerId;

	private String reference_name_code;
	private Integer date;
	private Integer month;
	private String user_name;
	private String sec_ques_id;
	private String sec_ans;
	private String title;
	private String first_name;
	private String last_name;
	private String house_num;
	private String address_line1;
	private String address_line2;
	private String city;
	private String gender;
	private String country_code;
	private String state_code;
	private String mobile_no;
	private String email_id;
	private String phone_num;
	private String postal_code;
	private String currency;
	private String date_of_birth;
	private Integer year;
	private String playerQues;
	private Long[] plrIds;
	private String reqData;
	private List<Object> dataList;
	private String uploadStartDate;
	private String uploadEndDate;
	private String sentOn;
	private String tempAvailable;
	private String nickName;
	private Map<String, List<StGenAppVersionDetails>> appVersionMap;
	private PlrNotificationBean plrNotificationBean;
	private PlrAppPushBoBean appPushBean;
	private String appType;
	private HashMap<String, List<StDmAliasDeeplinkRep>> deeplinkMap;
	private StPmPlayerMaster plrmaster;
	private List<TicketDetailBean> ticketDetailBeans;
	private String transactionId;
	private String pass;
	private StPmPlrRdmDocMasterBean plrBankDocumentMaster;
	private Long redeemAccId;
	public void validate() {
		try {
			resource = Utility.fetchGlobalProperties();
			String actionName = (String) ActionContext.getContext().getContextMap()
					.get(ActionContext.ACTION_NAME);
			if("st_pms_inbox_saveTemplateContent".equals(actionName)){
				if(searchedCriteria==null)
					searchedCriteria=new Gson().fromJson(request.getParameter("searchedCriteria"), PlrSearchOptionBean.class);
					setFieldErrors(new HashMap<String, List<String>>());
			}
			if("st_pms_inbox_saveTemplateContentJoomla".equals(actionName)){
				if(searchedCriteria==null)
					searchedCriteria=new Gson().fromJson(request.getParameter("searchedCriteria"), PlrSearchOptionBean.class);
					setFieldErrors(new HashMap<String, List<String>>());
			}
			if ("bo_pm_load_fieldlist".equals(actionName)) {

			} else if ("bo_pm_save_fieldlist".equals(actionName)) {
				if (pageNumber.length < 1) {
					addFieldError("",
							"Minimum One Page/Section required for registration page");
				}
			} else if ("st_bo_pm_changePlrEmailOrMobile_submit".equals(actionName)) {
				if (newData != null && !"".equals(newData.trim())) {
					String emailAddressPattern = "^[A-Za-z0-9](([_\\.\\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\\.\\-]?[a-zA-Z0-9]+){0,1})\\.([A-Za-z]{2,})$";
					if ("Mobile No".equals(changeReq)
							&& (newData.length() != 10 || !StringUtils
									.isNumeric(newData))) {
						addFieldError("newData", "Invalid mobile no.");
					} else if ("Email".equals(changeReq)
							&& !newData.matches(emailAddressPattern)) {
						addFieldError("newData", "Invalid email-id.");
					}
				} else {
					addFieldError("newData", "Please fill new " + changeReq);
				}
			}
			
			
		} catch (PMSException e) {
			e.printStackTrace();
		}catch (Exception be) {
			be.printStackTrace();
		}
	}

	public String managePage() {
		CommonMethodController controller = CommonMethodController
				.getInstance();
		try {
			regType = controller.getDmProperty(bydefaultSelectedDomain,
					"registrationType");
		} catch (PMSException pmse) {
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

	@SuppressWarnings("unchecked")
	public String fetchFieldList() {
		CommonMethodController controller = CommonMethodController
				.getInstance();
		httpSession = request.getSession();
		moduleFieldList = new HashMap<String, List<DomainFieldsWithValueBean>>();
		spareFieldList = new ArrayList<DomainFieldsWithValueBean>();
		pageWiseFieldMap = new LinkedHashMap<Short, List<DomainFieldsWithValueBean>>();
		sectionWiseFieldMap = new LinkedHashMap<String, List<DomainFieldsWithValueBean>>();

		try {
			resource = Utility.fetchGlobalProperties();
			Short actualDomainId = domainId;
			Map<String, String> domainIdMap = controller.getDmPropertyMap(
					domainId, "registrationType", "registrationPage");
			regType = domainIdMap.get("registrationType");
			String regPage = domainIdMap.get("registrationPage");
			BoPlayerMgmtController playerMgmtController = new BoPlayerMgmtController(
					privFunctionBean);
			if (regPage.equals("BYDEFAULT"))
				domainId = 1;
			domainWiseFieldList = (List<DomainFieldsWithValueBean>) httpSession
					.getAttribute("domainWiseFieldList");
			spareFieldList = (List<DomainFieldsWithValueBean>) httpSession
					.getAttribute("spareFieldList");
			if (domainWiseFieldList == null
					|| domainWiseFieldList.get(0).getDomainId() != domainId) {
				moduleFieldList = playerMgmtController.fetchFieldList(domainId);

				domainWiseFieldList = moduleFieldList.get("domainFields");
				domainWiseFieldList.get(0).setDomainId(domainId);
				httpSession.setAttribute("domainWiseFieldList",
						domainWiseFieldList);
				spareFieldList = moduleFieldList.get("spareFields");
				httpSession.setAttribute("spareFieldList", spareFieldList);
			} else if (request.getParameter("regType") != null
					&& !"".equals(request.getParameter("regType"))) {
				regType = request.getParameter("regType");
			}

			domainId = actualDomainId;
			String sectionNameCode = null;
			Short page = null;
			for (Iterator iterator = domainWiseFieldList.iterator(); iterator
					.hasNext();) {
				DomainFieldsWithValueBean type = (DomainFieldsWithValueBean) iterator
						.next();
				page = type.getPageSectionNo();
				if ("MULTIPAGE".equals(regType)) {
					if (pageWiseFieldMap.containsKey(page))
						pageWiseFieldMap.get(page).add(type);
					else {
						pageWiseFieldMap.put(page,
								new ArrayList<DomainFieldsWithValueBean>());
						pageWiseFieldMap.get(page).add(type);
					}
				} else {
					sectionNameCode = type.getSectionNameCode().toString();
					if (sectionWiseFieldMap.containsKey(sectionNameCode))
						sectionWiseFieldMap.get(sectionNameCode).add(type);
					else {
						sectionWiseFieldMap.put(sectionNameCode,
								new ArrayList<DomainFieldsWithValueBean>());
						sectionWiseFieldMap.get(sectionNameCode).add(type);
					}
				}
			}

		} catch (PMSException pmse) {
			pmse.printStackTrace();
			addActionError(pmse.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return "success";
	}

	@SuppressWarnings("unchecked")
	public void saveFieldList() {

		httpSession = request.getSession();
		BoPlayerMgmtController playerMgmtController = new BoPlayerMgmtController(
				privFunctionBean);
		List<DomainFieldsWithValueBean> list = new ArrayList<DomainFieldsWithValueBean>();
		DomainFieldsWithValueBean fieldMaster = new DomainFieldsWithValueBean();
		List<DomainFieldsWithValueBean> list1 = (List<DomainFieldsWithValueBean>) httpSession
				.getAttribute("domainWiseFieldList");
		CommonMethodController controller = CommonMethodController
				.getInstance();
		Integer returnedCode = null;
		boolean regTypeChanged = false;
		boolean fieldsChanged = false;
		int currentLocale = 1;
		int baseLangId = 1;
		try {

			if (!regType.equals(controller.getDmProperty(domainId,
					"registrationType"))) {
				regTypeChanged = true;
			}

			boolean change = false;
			int j = 0;
			for (int i = 0; i < pageNumber.length; i++) {

				fieldMaster = new DomainFieldsWithValueBean();
				fieldMaster.setPageSectionNo(pageNumber[i]);
				LanguageMgmtController languageMgmtController = new LanguageMgmtController();
				fieldDispName[i] = fieldDispName[i].trim();

				returnedCode = languageMgmtController.getDisplayCode(
						fieldDispName[i], baseLangId, currentLocale, domainId);
				if (!fieldDispCode[i].equals(returnedCode)) {
					fieldDispCode[i] = returnedCode;
					fieldsChanged = true;
				}

				fieldMaster.setFieldDispCode(fieldDispCode[i]);
				fieldMaster.setFieldName(fieldName[i]);
				fieldMaster.setFieldSequenceNo(fieldSequenceNo[i]);
				fieldMaster.setFieldId(fieldId[i]);
				fieldMaster.setIsMandatory(fieldType[i]);
				fieldMaster.setDomainId(domainId);
				fieldMaster.setIsPartOfMiniReg(isPartOfMiniReg[i]);
				fieldMaster.setMiniRegSeqNo(miniSeqNo[i]);

				if (fieldSequenceNo[i] == 1 && change == true)
					j++;
				else {
					change = true;
				}
				sectionName[j] = sectionName[j].trim();

				returnedCode = languageMgmtController.getDisplayCode(
						sectionName[j], baseLangId, currentLocale, domainId);
				if (sectionNameCode[j] == null
						|| !sectionNameCode[j].equals(returnedCode)) {
					sectionNameCode[j] = returnedCode;
					fieldsChanged = true;
				}

				fieldMaster.setSectionNameCode(sectionNameCode[j]);
				logger.info(fieldMaster.getFieldName());
				logger.info(sectionName[j]);
				list.add(fieldMaster);
			}
			if (!fieldsChanged) {
				if (list.size() != list1.size()) {
					fieldsChanged = true;
				} else {
					for (int i = 0; i < list.size(); i++) {
						if (list.get(i).compareTo(list1.get(i)) == 0) {
							fieldsChanged = true;
							break;
						}
					}
				}
			}

			if (regTypeChanged || fieldsChanged) {
				playerMgmtController.saveModuleFieldList(list, regType,
						fieldsChanged, userInfoBean.getUserId());
				httpSession.removeAttribute("domainWiseFieldList");
			}

			response.getWriter().write("SUCCESS");

		} catch (PMSException pmse) {
			pmse.printStackTrace();
			addActionError(pmse.getErrorMessage());
		} catch (IOException e) {
			e.printStackTrace();
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
		}
	}

	public String plrSearchForUploadDoc() {
		try {
			setDataList(new BoPlayerMgmtController().plrSearchForUploadDoc(domainId, aliasId,
					firstName, lastName, userName, status, uploadStartDate, uploadEndDate));
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some internal error.");
			return "exception";
		}
		return "dataTableAction";
	}
	public String redPlrSearchForUploadDoc() {
		
		try {
			setDataList(new BoPlayerMgmtController().redPlrSearchForUploadDoc(domainId, aliasId, playerId, userName,
					status, uploadStartDate, uploadEndDate));
		} catch (PMSException e) {
			logger.error(e.getMessage(), e);
			addActionError(e.getErrorMessage());
			return "exception";
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			addActionError("Some internal error.");
			return "exception";
		}
		return "dataTableAction";
	}

	public String uploadOrEditPlrDocument() {
		BoPlayerMgmtController playerMgmtController = new BoPlayerMgmtController();
		try {
			plrDocumentMaster = playerMgmtController
					.uploadOrEditPlrDocument(playerId);
			PlayerInfoBean playerInfoBean = new BoPlayerMgmtController().getPlayerInfo(plrDocumentMaster);
	        String domainName = CommonMethodController.getInstance().getDmProperty(playerInfoBean.getDomainId(), "domainName");
			defaultContentPath = CommonMethodController.getInstance()
					.fetchSystemProperties("COMMON_CONTENT_PATH");
			defaultContentPath = defaultContentPath+""+domainName+"/";
		} catch (PMSException e) {
			e.printStackTrace();
//			addActionError(e.getErrorMessage());
//			return "exception";
		}catch (Exception be) {
			be.printStackTrace();
//			addActionError("Some Internal Error!");
//			return "exception";
		}
		return SUCCESS;
	}
	public String uploadOrEditPlrBankDocument() {
		BoPlayerMgmtController playerMgmtController = new BoPlayerMgmtController();
		logger.info("-----------====||||UploadorEdit bank Document for redeem account Start||||====-------------------");

		try {
			plrBankDocumentMaster = playerMgmtController.getRdmBankDocDetail(playerId, redeemAccId);
			PlayerInfoBean playerInfoBean = new BoPlayerMgmtController().getPlayerInfo(plrBankDocumentMaster);
			String domainName = CommonMethodController.getInstance().getDmProperty(playerInfoBean.getDomainId(),
					"domainName");
			defaultContentPath = CommonMethodController.getInstance().fetchSystemProperties("COMMON_CONTENT_PATH");
			defaultContentPath = defaultContentPath + "" + domainName + "/";

		} catch (PMSException e) {
			logger.error(e.getMessage(), e);
		}
		logger.info("-----------====||||UploadorEdit bank Document for redeem account end||||====-------------------");
		return SUCCESS;
	}

	public String autoAgeVeriMenu() {
		CommonMethodController commonController = CommonMethodController
				.getInstance();
		try {
			bydefaultSelectedDomain = Short.valueOf(commonController
					.fetchSystemProperties("BYDEFAULT_SELECTED_DOMAIN"));
			domainIdMap = commonController.getDomainIdMap();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	public String saveOrUpdatePlrDoc() {
		try {
			if(plrDocumentMaster==null || plrDocumentMaster.getPlayerId()==null){
				throw new PMSException("Some internal Error");
			}
			StringBuffer fileNameBuffer = new StringBuffer(plrDocumentMaster.getPlayerId().toString());
			fileNameBuffer.append("_");
			String fileName;
			String fileNameAgeTemp = null;
			String fileNameAddTemp=null;
			String requestURL = CommonMethodController.getInstance().fetchSystemProperties("COMMON_CONTENT_PATH")+"imageupload";
//			MultipartUtility multipart = new MultipartUtility(requestURL);
			String response = "";
	        PlayerInfoBean playerInfoBean = new BoPlayerMgmtController().getPlayerInfo(plrDocumentMaster);
	        String domainName = CommonMethodController.getInstance().getDmProperty(playerInfoBean.getDomainId(), "domainName");
			if (plrDocumentMaster.getAgeImageFileName() != null && !("-1").equals(plrDocumentMaster.getAgeDocType())) {
				fileName = fileNameBuffer
						+ plrDocumentMaster.getAgeDocType()+"."
						+ FilenameUtils.getExtension(plrDocumentMaster
								.getAgeImageFileName());
				fileNameAgeTemp=fileName;
				Utility.saveOrUpdateContent(plrDocumentMaster.getAgeImage(),
						fileName, "playerDocument");
				if((plrDocumentMaster.getAgeImage()!=null && plrDocumentMaster.getAgeImage().length()==0)){
		        	throw new PMSException("Blank File Can't Be Uploaded");
		        }
				if(!requestURL.contains("amazonaws")){
					MultipartUtility multipart = new MultipartUtility(requestURL);
					multipart.addFormField("filePath", domainName+"/playerDocument");
					multipart.addFormField("fileName", fileName);
					if(plrDocumentMaster.getAgeImage()!=null)
						multipart.addFilePart("file", plrDocumentMaster.getAgeImage());
					response = multipart.finish();
					if(response.contains("Error"))
						throw new PMSException("Error in uploading file");
				}else {
					AWSWrapper.uploadObjectPublic(plrDocumentMaster.getAgeImage(), "commonContent/"+domainName+"/playerDocument/"+fileName, Utility.getBucket(requestURL),plrDocumentMaster.getAgeImageContentType());
				}
				
				plrDocumentMaster.setAgeDocPath(fileName);
			}
			
			if (plrDocumentMaster.getAgeImageFileName() != null  && plrDocumentMaster.getAgeImageBackSideFileName()!=null && !("-1").equals(plrDocumentMaster.getAgeDocType())) {
				fileName = fileNameBuffer
						+ plrDocumentMaster.getAgeDocType()+ "_BACKSIDE"+"."
						+ FilenameUtils.getExtension(plrDocumentMaster
								.getAgeImageBackSideFileName());
				Utility.saveOrUpdateContent(plrDocumentMaster.getAgeImage(),
						fileName, "playerDocument");
				if((plrDocumentMaster.getAgeImageBackSide()!=null && plrDocumentMaster.getAgeImageBackSide().length()==0)){
		        	throw new PMSException("Blank File Can't Be Uploaded");
		        }
				if(!requestURL.contains("amazonaws")){
					MultipartUtility multipart = new MultipartUtility(requestURL);
					multipart.addFormField("filePath", domainName+"/playerDocument");
					multipart.addFormField("fileName", fileName);
					if(plrDocumentMaster.getAgeImageBackSide()!=null)
						multipart.addFilePart("file", plrDocumentMaster.getAgeImageBackSide());
					response = multipart.finish();
					if(response.contains("Error"))
						throw new PMSException("Error in uploading file");
				}else {
					AWSWrapper.uploadObjectPublic(plrDocumentMaster.getAgeImageBackSide(), "commonContent/"+domainName+"/playerDocument/"+fileName, Utility.getBucket(requestURL),plrDocumentMaster.getAgeImageBackSideContentType());
				}
				
				plrDocumentMaster.setAgeDocPath(fileNameAgeTemp+","+fileName);
			}
			if (plrDocumentMaster.getAddImageFileName() != null && !("-1").equals(plrDocumentMaster.getAddDocType())) {
				fileName = fileNameBuffer
						+ plrDocumentMaster.getAddDocType()+"."
						+ FilenameUtils.getExtension(plrDocumentMaster
								.getAddImageFileName());
				fileNameAddTemp=fileName;
				Utility.saveOrUpdateContent(plrDocumentMaster.getAddImage(),
						fileName, "playerDocument");
				if((plrDocumentMaster.getAddImage()!=null && plrDocumentMaster.getAddImage().length()==0)){
		        	throw new PMSException("Blank File Can't Be Uploaded");
		        }
				if(!requestURL.contains("amazonaws")){
					MultipartUtility multipart = new MultipartUtility(requestURL);
					multipart = new MultipartUtility(requestURL);
					multipart.addFormField("filePath", domainName+"/playerDocument");
					multipart.addFormField("fileName", fileName);
					if(plrDocumentMaster.getAddImage()!=null)
						multipart.addFilePart("file", plrDocumentMaster.getAddImage());
					response = multipart.finish();
					if(response.contains("Error"))
						throw new PMSException("Error in uploading file");
				}else {
					AWSWrapper.uploadObjectPublic(plrDocumentMaster.getAddImage(), "commonContent/"+domainName+"/playerDocument/"+fileName, Utility.getBucket(requestURL),plrDocumentMaster.getAddImageContentType());
				}
				plrDocumentMaster.setAddDocPath(fileName);
			}
			if (plrDocumentMaster.getAddImageFileName() != null && plrDocumentMaster.getAddImageBackSideFileName()!=null && !("-1").equals(plrDocumentMaster.getAddDocType())) {
				fileName = fileNameBuffer
						+ plrDocumentMaster.getAddDocType()+ "_BACKSIDE"+"."
						+ FilenameUtils.getExtension(plrDocumentMaster
								.getAddImageBackSideFileName());
				Utility.saveOrUpdateContent(plrDocumentMaster.getAddImage(),
						fileName, "playerDocument");
				if((plrDocumentMaster.getAddImageBackSide()!=null && plrDocumentMaster.getAddImageBackSide().length()==0)){
		        	throw new PMSException("Blank File Can't Be Uploaded");
		        }
				if(!requestURL.contains("amazonaws")){
					MultipartUtility multipart = new MultipartUtility(requestURL);
					multipart = new MultipartUtility(requestURL);
					multipart.addFormField("filePath", domainName+"/playerDocument");
					multipart.addFormField("fileName", fileName);
					if(plrDocumentMaster.getAddImageBackSide()!=null)
						multipart.addFilePart("file", plrDocumentMaster.getAddImageBackSide());
					response = multipart.finish();
					if(response.contains("Error"))
						throw new PMSException("Error in uploading file");
				}else {
					AWSWrapper.uploadObjectPublic(plrDocumentMaster.getAddImageBackSide(), "commonContent/"+domainName+"/playerDocument/"+fileName, Utility.getBucket(requestURL),plrDocumentMaster.getAddImageBackSideContentType());
				}
				plrDocumentMaster.setAddDocPath(fileNameAddTemp+","+fileName);
			}
			if (plrDocumentMaster.getTaxIdImageFileName() != null && !("-1").equals(plrDocumentMaster.getTaxIdDocType())) {
				fileName = fileNameBuffer
						+ plrDocumentMaster.getTaxIdDocType()+"."
						+ FilenameUtils.getExtension(plrDocumentMaster
								.getTaxIdImageFileName());
				Utility.saveOrUpdateContent(plrDocumentMaster.getTaxIdImage(),
						fileName, "playerDocument");
				if((plrDocumentMaster.getTaxIdImage()!=null && plrDocumentMaster.getTaxIdImage().length()==0)){
		        	throw new PMSException("Blank File Can't Be Uploaded");
		        }
				if(!requestURL.contains("amazonaws")){
					MultipartUtility multipart = new MultipartUtility(requestURL);
					multipart = new MultipartUtility(requestURL);
					multipart.addFormField("filePath", domainName+"/playerDocument");
					multipart.addFormField("fileName", fileName);
					if(plrDocumentMaster.getTaxIdImage()!=null)
						multipart.addFilePart("file", plrDocumentMaster.getTaxIdImage());
					response = multipart.finish();
					if(response.contains("Error"))
						throw new PMSException("Error in uploading file");
				}else {
					AWSWrapper.uploadObjectPublic(plrDocumentMaster.getTaxIdImage(), "commonContent/"+domainName+"/playerDocument/"+fileName, Utility.getBucket(requestURL),plrDocumentMaster.getTaxIdImageContentType());
				}
				plrDocumentMaster.setTaxIdDocPath(fileName);
			}
			new BoPlayerMgmtController().saveOrUpdatePlrDoc(plrDocumentMaster);
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}catch (Exception be) {
			be.printStackTrace();
		}
		return SUCCESS;
	}
	public String saveOrUpdatePlrBankDoc(){
		logger.info("-------||||save or update player bank document start||||-------");
		logger.info("playerId:-" + plrBankDocumentMaster.getPlayerId() + "doctype:--"
				+ plrBankDocumentMaster.getBankIdDocType() + "," + plrBankDocumentMaster.getIdentityIdDocType());
		String response = "";
		try {
			if (plrBankDocumentMaster == null || plrBankDocumentMaster.getPlayerId() == null) {
				throw new PMSException("Some internal Error");
			}

			String requestURL = CommonMethodController.getInstance().fetchSystemProperties("COMMON_CONTENT_PATH")
					+ "imageupload";
			PlayerInfoBean playerInfoBean = new BoPlayerMgmtController().getPlayerInfo(plrBankDocumentMaster);
			String domainName = CommonMethodController.getInstance().getDmProperty(playerInfoBean.getDomainId(),
					"domainName");
			if (plrBankDocumentMaster.getBankIdImageFileName() != null) {

				String imageName = plrBankDocumentMaster.getPlayerId() + "_" + plrBankDocumentMaster.getRedeemAccId()
						+ "_" + plrBankDocumentMaster.getBankIdDocType() + "."
						+ FilenameUtils.getExtension(plrBankDocumentMaster.getBankIdImageFileName());
				if (plrBankDocumentMaster.getBankIdImage() != null
						&& plrBankDocumentMaster.getBankIdImage().length() == 0) {
					throw new PMSException("Blank File Can't Be Uploaded");
				}
				if (!requestURL.contains("amazonaws")) {
					MultipartUtility multipart = new MultipartUtility(requestURL);
					multipart.addFormField("filePath", domainName + "/playerDocument");
					multipart.addFormField("fileName", imageName);
					if (plrBankDocumentMaster.getBankIdImage() != null)
						multipart.addFilePart("file", plrBankDocumentMaster.getBankIdImage());
					response = multipart.finish();
					if (response.contains("Error"))
						throw new PMSException("Error in uploading file");
				} else {
					AWSWrapper.uploadObjectPublic(plrBankDocumentMaster.getBankIdImage(),
							"commonContent/" + domainName + "/playerDocument/" + imageName,
							Utility.getBucket(requestURL), plrBankDocumentMaster.getBankIdImageContentType());
				}
				logger.info("image name:-" + imageName);
				plrBankDocumentMaster.setBankIdPath(imageName);

			}
			if (plrBankDocumentMaster.getIdentityIdImageFileName() != null) {
				String imageName = plrBankDocumentMaster.getPlayerId() + "_" + plrBankDocumentMaster.getRedeemAccId()
						+ "_" + plrBankDocumentMaster.getIdentityIdDocType() + "."
						+ FilenameUtils.getExtension(plrBankDocumentMaster.getIdentityIdImageFileName());
				if (plrBankDocumentMaster.getIdentityIdImage() != null
						&& plrBankDocumentMaster.getIdentityIdImage().length() == 0) {
					throw new PMSException("Blank File Can't Be Uploaded");
				}
				if (!requestURL.contains("amazonaws")) {
					MultipartUtility multipart = new MultipartUtility(requestURL);
					multipart.addFormField("filePath", domainName + "/playerDocument");
					multipart.addFormField("fileName", imageName);
					if (plrBankDocumentMaster.getIdentityIdImage() != null)
						multipart.addFilePart("file", plrBankDocumentMaster.getIdentityIdImage());
					response = multipart.finish();
					if (response.contains("Error"))
						throw new PMSException("Error in uploading file");
				} else {
					AWSWrapper.uploadObjectPublic(plrBankDocumentMaster.getIdentityIdImage(),
							"commonContent/" + domainName + "/playerDocument/" + imageName,
							Utility.getBucket(requestURL), plrBankDocumentMaster.getIdentityIdImageContentType());
				}
				plrBankDocumentMaster.setIdentityIdPath(imageName);
				logger.info("image name:-" + imageName);
			}
			new BoPlayerMgmtController().saveOrUpdatePlrBankDoc(plrBankDocumentMaster);

		} catch (PMSException e) {
			addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
			logger.error(e.getMessage(), e);
			return ERROR;
		} catch (IOException e) {
			addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
			logger.error(e.getMessage(), e);
			return ERROR;
		} catch (Exception be) {
			addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
			logger.error(be.getMessage(), be);
			return ERROR;
		}
		logger.info("-------||||save or update player bank document end||||-------");

		return SUCCESS;
	}

	public String plrEmailDispatch() {
		logger
				.info("****************Back Office User Sent  mail to player start*******************");
		CommonMethodController controller = CommonMethodController
				.getInstance();
		try {
			if (domainId != 0) {
				languageList = new ArrayList<LanguageBean>(controller
						.fetchDmActiveLangMap(domainId).values());
				languageStr =new Utility().convertJSON( new ArrayList<LanguageBean>(controller
						.fetchDmActiveLangMap(domainId).values()));
				aliasMap = controller.fetchAliasMap(domainId);
				if (!(plrIdList == null || "".equals(plrIdList))) {
					Type type = new TypeToken<Map<Long, String>>() {
					}.getType();
					playerMap = new Gson().fromJson(plrIdList, type);
					playerIdArr = playerMap.keySet().toArray(new Long[0]);
				}
			}
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
		}
		logger
				.info("****************Back Office User Sent  mail to player end*******************");
		return SUCCESS;

	}
	
	@SuppressWarnings("rawtypes")
	public void getTemplateListOnAliasChange() {
		PrintWriter out = null;
		String jsonMap = null;
		Gson gson = new Gson();
	
		try{
			BoPlayerMgmtController playerMgmtController = new BoPlayerMgmtController();
			List<String> contentType = new ArrayList<String>();
			String value = playerMgmtController.fetchContentType(aliasId);
			contentType.add(value);
			Map<String,List> tempMap=new HashMap<String, List>();
			logger.info("-------Conetnt Type------"+value);
			if("PORTALCONTENT".equals(value)){
				tempList = playerMgmtController.fetchTemplate(domainId,aliasId,sentOn);
				List<TemplateMasterBean> tempList1 = new ArrayList<TemplateMasterBean>();
				if(tempList.size()>0){
					for(int i=0;i<tempList.size();i++){
						if(!tempList.get(i).getTemplateSubject().contains("#")){
							tempList1.add(tempList.get(i));
						}
					}
					tempMap.put("tempList", tempList1);
					tempMap.put("contentType", contentType);
				}else{
					String respMsg="No Template Available for Selected Alias!!";
					List<String> resp =new ArrayList<String>();
					resp.add(respMsg);
					tempMap.put("contentType", contentType);
					tempMap.put("respMsg", resp);
				}
			}else{
				tempMap.put("contentType", contentType);
			}
			jsonMap = gson.toJson(tempMap);
			out = response.getWriter();
			out.write(jsonMap);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	public void getTemplateList() {
		try {
			Gson gson = new Gson();
			BoPlayerMgmtController playerMgmtController = new BoPlayerMgmtController();
			String content_type = playerMgmtController.fetchContentType(aliasId);
			if (!("PORTALCONTENT".equals(content_type))) {
				String serviceUrl = null;
				if (aliasId != 0)
					serviceUrl = playerMgmtController.getServiceUrl(aliasId);
				if (serviceUrl != null) {
					String param = "emailType=" + sentOn;
					String sb = Utility.callUrl(serviceUrl, param);
					
					logger.info("Response: " + sb);
					gson = new Gson();
					EmailTemplateBean reqParameter = null;
					reqParameter = gson.fromJson(sb.toString(),
							EmailTemplateBean.class);
					PrintWriter out = null;
					String jsonMap = null;
					TemplateListBean templateBean = null;
					Map<String, List> tempMap = new HashMap<String, List>();
					List<TemplateListBean> tempList = new ArrayList<TemplateListBean>();
					if ("0".equals(reqParameter.getErrorCode())) {
						int i = 0;
						for (i = 0; i < reqParameter.getEmailTemplates().size(); i++) {
							templateBean = new TemplateListBean();
							templateBean.setId(reqParameter.getEmailTemplates()
									.get(i).getId());
							templateBean.setFrom(reqParameter
									.getEmailTemplates().get(i).getFrom());
							templateBean.setName(reqParameter
									.getEmailTemplates().get(i).getName());
							templateBean.setSubject(reqParameter
									.getEmailTemplates().get(i).getSubject()); 
						//	if(!("INTERNAL".equals(sentOn)))
								templateBean.setUrl(reqParameter.getEmailTemplates().get(i).getUrl());
							tempList.add(templateBean);
						}
						tempMap.put("tempList", tempList);
					} else{
						String respMsg=reqParameter.getRespMsg();
						List<String> resp =new ArrayList<String>();
						resp.add(respMsg);
						logger.info("respMsg:"+respMsg);
						tempMap.put("respMsg", resp);
					}
					jsonMap = gson.toJson(tempMap);
					out = response.getWriter();	
					out.write(jsonMap);
				}
			}

		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some internal error.");
			}
		}

	
	public String plrnotificationDispatch(){
		try {
			List<StDmAliasDeeplinkRep> deeplinkLsit =CommonMethodController.getInstance().getDeepLinkList(aliasId, appType);
			if(deeplinkLsit.size()==0)
				throw new PMSException(PMSErrorCode.GEN_OP_NOT_SUPPORTED, "No deeplinks configured for selected alias.");
			deeplinkMap=new HashMap<String, List<StDmAliasDeeplinkRep>>();
			if (!(plrIdList == null || "".equals(plrIdList))) {
				Type type = new TypeToken<Map<Long, String>>() {}.getType();
				playerMap = new Gson().fromJson(plrIdList, type);
				playerIdArr = playerMap.keySet().toArray(new Long[0]);
				for(StDmAliasDeeplinkRep deeplink:deeplinkLsit)
					if(getDeeplinkMap().containsKey(deeplink.getAppType()))
						getDeeplinkMap().get(deeplink.getAppType()).add(deeplink);
					else {
						ArrayList<StDmAliasDeeplinkRep> tempList= new ArrayList<StDmAliasDeeplinkRep>();
						tempList.add(deeplink);
						deeplinkMap.put(deeplink.getAppType(), tempList);
					}
			}
		}catch (Exception e) {
			e.printStackTrace();
			addActionError(e.getMessage());
			return "exception_nodecorate";
		}
		return SUCCESS;
	}
	
	
	public String sendNotification(){
		try{		
			if(plrNotificationBean.isSentToAll()) {
				searchedCriteria.setRedirect("SendNotification");
				playerIdArr = searchedPlayerIDs(new ReportsController()
								.searchPlayerData(searchedCriteria, 0, 0));
			}
			
			if(plrNotificationBean.getAppTypeList()!=null && plrNotificationBean.getDeeplinkList()!=null 
					&& plrNotificationBean.getAppTypeList().size()==plrNotificationBean.getDeeplinkList().size()){
				for (int i=0;i<plrNotificationBean.getDeeplinkList().size();i++){
					new BoPlayerMgmtController().sendNotification(playerIdArr,
							plrNotificationBean.getMessage(), plrNotificationBean.getDeeplinkList().get(i));
				}
			}else {
				addActionMessage("Inconsistent data from FrontEnd.");
				return ERROR;
			}
			else
				deepLink.put(plrNotificationBean.getAppTypeArr(), plrNotificationBean.getPageName());
			if(playerIdArr!=null && playerIdArr.length>0 )
				new BoPlayerMgmtController().sendNotification(aliasId,playerIdArr,
						"both".equals(plrNotificationBean.getAppTypeArr())?null:plrNotificationBean.getAppType(),
								plrNotificationBean.getMessage(),deepLink);
			else
				logger.info("NO Players to send message.");
		} catch (PMSException e) {	
			addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
			e.printStackTrace();
			return ERROR;
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}
	
	public String saveTemplateContentforJoomla(){
		BoPlayerMgmtController playerMgmtController = null;
		ReportsController reportsController = null;
		String encodeContent = null;
		try{
			reportsController = new ReportsController();
			int boUser = userInfoBean.getUserId();
			playerMgmtController = new BoPlayerMgmtController();
			String content_type=playerMgmtController.fetchContentType(plrEmailBean.getAliasId());
		//playerIdArr
			if(!"PORTALCONTENT".equals(content_type)){
				if (plrEmailBean.getSentToAll()) {
					if (reportDataType == null || "".equals(reportDataType)) {
						searchedCriteria.setRedirect("SendMail");
						playerIdArr = searchedPlayerIDs(reportsController
								.searchPlayerData(searchedCriteria, 0, 0));
	 				} else if (reportDataType != null && !"".equals(reportDataType)) {
						String procName = "";
						Gson data = new GsonBuilder().create();
						Type dataType = new TypeToken<Map<String, String>>() {
						}.getType();
						Map<String, String> misParamMap = data.fromJson(reportData,
								dataType);
						if (misParamMap.containsKey("proceName")) {
							procName = misParamMap.get("proceName");
							misParamMap.remove("proceName");
						} else{
							procName = reportDataType;
						}
						misParamMap = reportsController.getMisParamMap(misParamMap,
								procName);
						misParamMap.put("startIndex", "-1");
						misParamMap.put("recordTofetch", "-1");
						
						playerIdArr = getMisPlayerIds(reportsController
								.fetchReportsData(misParamMap, procName));
					}
				}
				
				if("internal".equals(plrEmailBean.getInt_ext_mail()[0])){
					if("manually".equals(plrEmailBean.getEmailType())){
						int []timeout = {5000,10000};
						encodeContent = "subject="+plrEmailBean.getSubject()+"&content="+URLEncoder.encode(plrEmailBean.getContent(), "UTF-8");
					//	encodeContent = URLEncoder.encode(plrEmailBean.getContent(), "UTF-8");
						
						String contentUrl = new CmsController().getURL(plrEmailBean.getAliasId(), "JOOMLA_MANUAL_TEMP_POST_DATA");
						if(contentUrl != null){
							tempAvailable = Utility.callUrl(contentUrl, encodeContent, timeout);
							JSONObject obj = new JSONObject(tempAvailable);
							JSONObject data = obj.getJSONObject("moduleData");
							JSONArray urlArray = data.getJSONArray("url");
							tempAvailable = (String)urlArray.get(0)+"#"+String.valueOf(data.get("id"));
						}
						else
							throw new PMSException("No Url Found for content save data");
					}
					String[] tempInfoArr = tempAvailable.split("#");
					plrEmailBean.setTempUrl(tempInfoArr[0]);
					plrEmailBean.setTempId(tempInfoArr[1]);
					//plrEmailBean.setFrom(tempInfoArr[2]);
					plrEmailBean.setContentType(content_type);
					playerMgmtController.saveTemplate(plrEmailBean, playerIdArr, boUser);
//					new BoPlayerMgmtControllerJMSProxy().saveTemplate(plrEmailBean, playerIdArr, boUser);
					
				}else if("external".equals(plrEmailBean.getInt_ext_mail()[0]) || "both".equals(plrEmailBean.getInt_ext_mail()[0])){
					String[] tempInfoArr = tempAvailable.split("#");
					plrEmailBean.setTempUrl(tempInfoArr[0]);
					plrEmailBean.setTempId(tempInfoArr[1]);
					plrEmailBean.setFrom(tempInfoArr[2]);
					playerMgmtController
					.saveTemplate(plrEmailBean, playerIdArr, boUser);
				}
			}
			
		}catch (PMSException pe) {
			addActionError(pe.getErrorMessage());
			return ERROR;
		} catch (Exception e) {
			addActionError("Some Internal Error occur.");
			e.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}

	public String saveTemplateContent() {
		String fullPath = null;
		String[] tempContent = null;
		String contentVal = "";
		String descPath = "";
		String descFileName = "";
//		String path = "";
		String templatePath = "";
		BoPlayerMgmtController playerMgmtController = null;
		CommonMethodController controller = CommonMethodController
				.getInstance();
		int boUser = userInfoBean.getUserId();
		String filename = null;
		String header = "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'><html xmlns='http://www.w3.org/1999/xhtml'><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /></head><body> ";
		String foot = "</body></html>";
		ReportsController reportsController = null;
		long dateDate = Calendar.getInstance().getTimeInMillis();
		try {
			reportsController = new ReportsController();
			String domainName = controller.getDmProperty(plrEmailBean
					.getDomainVal(), "domainName");
			String aliasName = controller.getDmAliasProperty(plrEmailBean.getAliasId(),"aliasName");
			playerMgmtController = new BoPlayerMgmtController();
			
			String content_type=playerMgmtController.fetchContentType(plrEmailBean.getAliasId());
			
				if (plrEmailBean.getDomainVal() == 1) {
					domainName = "BYDEFAULT";
				}
				String layout = controller.getDeviceLayout(plrEmailBean
						.getDomainVal(), "pc");
				descPath = domainName + "|" +aliasName + "|" +layout + "|" + "pc" + "|" + "LR"
							+ "|" + "player_inbox";
				if("PORTALCONTENT".equals(content_type)){
					if ("temp".equals(plrEmailBean.getEmailType())) {
						filename = playerMgmtController.fetchTemplateByName(
								plrEmailBean.getDomainVal(),plrEmailBean.getAliasId(), plrEmailBean.getSubject(),plrEmailBean.getInt_ext_mail()[0]);
						descFileName = filename + "_" + dateDate + ".jsp";
						templatePath = domainName
								+ "/"+aliasName
								+"/"
								+ layout
								+ "/"
								+ "pc"
								+ File.separator
								+ "LR"
								+ "/"
								+ (plrEmailBean.getPageType()).toLowerCase()
								+ "/"
								+ plrEmailBean.getLanguage();
						fullPath = templatePath;
					} else {
						filename = "mail"//plrEmailBean.getSubject().replaceAll("\\s+", "")
								+ "_" + boUser + "_" + dateDate + ".html";
						descFileName = "mail"//plrEmailBean.getSubject().replaceAll("\\s+", "")
								+ "_" + boUser + "_" + dateDate + ".html";
						templatePath = controller
								.fetchSystemProperties("DEFAULT_CONTENT_PATH")
								+ domainName;
						fullPath = templatePath + "/" +aliasName + "/" +layout + "/" + "pc" + "/"
								+ "LR" + "/" + "player_inbox";
					}
					if (plrEmailBean.getInt_ext_mail().length == 0) {
						addActionError("Please select an sent Type.");
						return ERROR;
					}
					plrEmailBean.setFileName(filename);
		//			path = fullPath + File.separator + filename;
					String fileContent = Utility.readFileContent(fullPath, filename);
					if ("temp".equals(plrEmailBean.getEmailType())) {
						Utility
								.saveOrUpdateContent(fileContent, descFileName,
										descPath);
					} else {
						tempContent = plrEmailBean.getContent().split("\n");
						for (int i = 0; i < tempContent.length; i++) {
							if (tempContent[i].length() > 0) {
								tempContent[i] = "<p style='color:#000; padding:4px;'>"
										+ tempContent[i] + "</p>";
								contentVal = contentVal + tempContent[i];
							}
						}
						contentVal = header + contentVal.replaceAll("\n", "<br/>")
								+ foot;
						Utility.saveOrUpdateContent(contentVal, descFileName, descPath);
					}
		
					if (plrEmailBean.getSentToAll()) {
						if (reportDataType == null || "".equals(reportDataType)) {
							searchedCriteria.setRedirect("SendMail");
							playerIdArr = searchedPlayerIDs(reportsController
									.searchPlayerData(searchedCriteria, 0, 0));
		 				} else if (reportDataType != null && !"".equals(reportDataType)) {
							String procName = "";
							Gson data = new GsonBuilder().create();
							Type dataType = new TypeToken<Map<String, String>>() {
							}.getType();
							Map<String, String> misParamMap = data.fromJson(reportData,
									dataType);
							if (misParamMap.containsKey("proceName")) {
								procName = misParamMap.get("proceName");
								misParamMap.remove("proceName");
							} else{
								procName = reportDataType;
							}
							misParamMap = reportsController.getMisParamMap(misParamMap,
									procName);
							misParamMap.put("startIndex", "-1");
							misParamMap.put("recordTofetch", "-1");
							playerIdArr = getMisPlayerIds(reportsController
									.fetchReportsData(misParamMap, procName));
						}
					}
					plrEmailBean.setFileName(descFileName);
					plrEmailBean.setContentType(content_type);
					playerMgmtController
							.saveTemplate(plrEmailBean, playerIdArr, boUser);
				}
			else{
				if ("manually".equals(plrEmailBean.getEmailType())) {
					filename = "mail"//plrEmailBean.getSubject().replaceAll("\\s+", "")
							+ "_" + boUser + "_" + dateDate + ".html";
					descFileName = "mail"//plrEmailBean.getSubject().replaceAll("\\s+", "")
							+ "_" + boUser + "_" + dateDate + ".html";
					templatePath = controller
							.fetchSystemProperties("DEFAULT_CONTENT_PATH")
							+ domainName;
					fullPath = templatePath + "/" +aliasName + "/" +layout + "/" + "pc" + "/"
							+ "LR" + "/" + "player_inbox";
				if (plrEmailBean.getInt_ext_mail().length == 0) {
					addActionError("Please select an sent Type.");
					return ERROR;
				}
				plrEmailBean.setFileName(filename);
				tempContent = plrEmailBean.getContent().split("\n");
				for (int i = 0; i < tempContent.length; i++) {
					if (tempContent[i].length() > 0) {
						tempContent[i] = "<p style='color:#000; padding:4px;'>"
								+ tempContent[i] + "</p>";
						contentVal = contentVal + tempContent[i];
					}
				}
				contentVal = header + contentVal.replaceAll("\n", "<br/>")
						+ foot;
				Utility.saveOrUpdateContent(contentVal, descFileName, descPath);
				
				if (plrEmailBean.getSentToAll()) {
					if (reportDataType == null || "".equals(reportDataType)) {
						searchedCriteria.setRedirect("SendMail");
						playerIdArr = searchedPlayerIDs(reportsController
								.searchPlayerData(searchedCriteria, 0, 0));
	 				} else if (reportDataType != null && !"".equals(reportDataType)) {
						String procName = "";
						Gson data = new GsonBuilder().create();
						Type dataType = new TypeToken<Map<String, String>>() {
						}.getType();
						Map<String, String> misParamMap = data.fromJson(reportData,
								dataType);
						if (misParamMap.containsKey("proceName")) {
							procName = misParamMap.get("proceName");
							misParamMap.remove("proceName");
						} else{
							procName = reportDataType;
						}
						misParamMap = reportsController.getMisParamMap(misParamMap,
								procName);
						playerIdArr = getMisPlayerIds(reportsController
								.fetchReportsData(misParamMap, procName));
					}
				}
				plrEmailBean.setFileName(descFileName);
				playerMgmtController
						.saveTemplate(plrEmailBean, playerIdArr, boUser);
				
				}
				else{
					if("internal".equals(plrEmailBean.getInt_ext_mail()[0])){
//						plrEmailBean.setTempId(tempAvailable);
						String[] tempInfoArr = tempAvailable.split("#");
						plrEmailBean.setTempUrl(tempInfoArr[0]);
						plrEmailBean.setTempId(tempInfoArr[1]);
						//plrEmailBean.setFrom(tempInfoArr[2]);
						plrEmailBean.setContentType(content_type);
						playerMgmtController
						.saveTemplate(plrEmailBean, playerIdArr, boUser);
					}else if("external".equals(plrEmailBean.getInt_ext_mail()[0]) || "both".equals(plrEmailBean.getInt_ext_mail()[0])){
						String[] tempInfoArr = tempAvailable.split("#");
						plrEmailBean.setTempUrl(tempInfoArr[0]);
						plrEmailBean.setTempId(tempInfoArr[1]);
						plrEmailBean.setFrom(tempInfoArr[2]);
						playerMgmtController
						.saveTemplate(plrEmailBean, playerIdArr, boUser);
					}else if("both".equals(plrEmailBean.getInt_ext_mail()[0])){
						String[] tempInfoArr = tempAvailable.split("#");
						plrEmailBean.setTempUrl(tempInfoArr[0]);
						plrEmailBean.setTempId(tempInfoArr[1]);
						plrEmailBean.setFrom(tempInfoArr[2]);
						plrEmailBean.setContentType(content_type);
						playerMgmtController
						.saveTemplate(plrEmailBean, playerIdArr, boUser);
					}
				}
			}
		} catch (PMSException pe) {
			addActionError(pe.getErrorMessage());
			return ERROR;
		} catch (Exception e) {
			addActionError("Some Internal Error occur.");
			e.printStackTrace();
			return ERROR;
		}
		return SUCCESS;

	}

	public String plrSearchForAutoVerification() {
		httpSession = request.getSession();
		BoPlayerMgmtController playerMgmtController = new BoPlayerMgmtController();
		try {
			plrList = playerMgmtController.plrSearchForAutoVerification(
					domainId, firstName, lastName, userName,
					verificationStatus, recordPerPage, paginationPage);

		} catch (PMSException e) {
			e.printStackTrace();
		}catch (Exception be) {
			be.printStackTrace();
		}
		return SUCCESS;
	}

	public String plrRefundProcessTerminate() {
		httpSession = request.getSession();
		BoPlayerMgmtController playerMgmtController = new BoPlayerMgmtController();
		try {
			playerMgmtController.plrRefundProcessTerminate(refundNTerPLrId,
					domainId);
			addActionMessage("Player(s) terminated and Withdrawal request(s) successfully Initiated.");
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}

	public String plrMannualVerifyCancelPlr() {
		
		httpSession = request.getSession();
		BoPlayerMgmtController playerMgmtController = new BoPlayerMgmtController();
		try {
			playerMgmtController.plrMannualVerifyCancelPlr(refundNTerPLrId,
					veriAction);
			if ("UNDER_AGE".equals(veriAction)) {
				addActionMessage("Player(s) verification status changed to Under Age.");
			} else if ("SELF_EXCLUDED".equals(veriAction)) {
				addActionMessage("Player(s) verification status changed to SELF EXCLUDED.");
			} else {
				addActionMessage("Player(s) verification status changed to Verified.");
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
		return SUCCESS;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Long[] searchedPlayerIDs(ArrayList playerData) {
		Long[] lngArray = null;
		int i = 0;
		try {
			List<PlrSearchDataBean> playerObject = (List<PlrSearchDataBean>) playerData
					.get(0);
			lngArray = new Long[playerObject.size()];
			for (PlrSearchDataBean plrDataList : playerObject) {
				lngArray[i] = plrDataList.getPlayerId();
				i++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lngArray;
	}

	public void checkDocUnqNoAvailability() {
		try {
			boolean result = new PlayerMgmtController()
					.checkDocUnqNoAvailability(domainId, plrDocumentMaster
							.getPlayerId(), plrDocumentMaster);
			if (result) {
				response.getWriter().write("<p>Available</P>");
			} else {
				response.getWriter().write("<p>Not Available</P>");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}catch (Exception be) {
			be.printStackTrace();
		}
	}
	public void checkBankDocUnqNoAvailability(){
		try{
			Boolean result =new PlayerMgmtController().checkBankDocUnqNoAvailability(domainId, 
					plrBankDocumentMaster.getPlayerId(), plrBankDocumentMaster);
			if (result) {
				response.getWriter().write("<p>Available</P>");
			} else {
				response.getWriter().write("<p>Not Available</P>");
			}
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}catch (Exception be) {
			logger.error(be.getMessage(), be);
		}
	}

	private Long[] getMisPlayerIds(List<String[]> reportData) {
		Long[] lngArray = null;
		int i = 0;
		try {
			lngArray = new Long[reportData.size()];
			for (String[] plrDataList : reportData) {
				lngArray[i] = Long.valueOf(plrDataList[0]).longValue();
				i++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lngArray;

	}

	public String changePlrEmailOrMobileSubmit() {
		logger.info("---change request for ---- " + changeReq
				+ "--new value is ---" + newData + "---Player ID---"
				+ requestPlayerId);
		PlayerMgmtController controller = new PlayerMgmtController();
		try {
			// if("".equals(Utility.sysProperties.get("PLAYER_INFO_UNIQUENESS")))
			if (newData != null && !"".equals(newData.trim())) {
				if (!currentData.equals(newData)) {
					playerInfo = controller.getPlayerInfoById(requestPlayerId);
					if ("VERIFICATION_PENDING".equals(playerInfo.getStatus())) {
						throw new PMSException(
								"Since player verification for email/mobile no is pending.You can not change player info before verification.");
					}
					if ("Mobile No".equals(changeReq)) {
						duplicatePlrInfo = controller.checkPlayerAvailability(
								null, null, newData, playerInfo.getDomainId(), false);
					} else if ("Email".equals(changeReq)) {
						duplicatePlrInfo = controller.checkPlayerAvailability(
								null, newData, null, playerInfo.getDomainId(), false);
					} else {
						addActionError("Invalid Request");
						return "exception_nodecorate";
					}
				} else {
					addActionError("Invalid Request");
					return "exception_nodecorate";
				}
			} else {
				addActionError("Invalid Request");
				return "exception_nodecorate";
			}
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception_nodecorate";
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("some internal error");
			return "exception_nodecorate";
		}
		return SUCCESS;
	}

	public String changePlrEmailOrMobileConfirm() {
		logger.info("---Confirm change request for ---- " + changeReq
				+ "--new value is ---" + newData + "-----requestPlayerId---"
				+ requestPlayerId + "--Duplicate Player ID--" + duplicatePlrId);
		PlayerMgmtController controller = new PlayerMgmtController();
		try {
			playerInfo = controller.getPlayerInfoById(requestPlayerId);
			controller.playerInfoChangeRequest(requestPlayerId, playerInfo.getDomainId(),
					duplicatePlrId, newData, changeReq);
			addActionMessage("Player information change request has been saved successfully.");
		} catch (PMSException e) {
			if(e.getErrorMessage().equals("Invalid Alias Name")){
				logger.error(e.getErrorMessage());
			}else{
				e.printStackTrace();
			}
			addActionError(e.getErrorMessage());
			return "exception_nodecorate";
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("some internal error");
			return "exception_nodecorate";
		}
		return SUCCESS;
	}

	public String loadPlrRegistrationFields() {
		PlayerMgmtController playerMgmtController = new PlayerMgmtController();
		try {
			if ("MINI".equals(status)) {
				domainWiseFieldList = playerMgmtController.fetchFieldList(
						domainId, "Y");
			} else {
				domainWiseFieldList = playerMgmtController.fetchFieldList(
						domainId, "N");
			}
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("some internal error");
		}
		return SUCCESS;
	}

	public void fieldIsUnique() throws IOException {
		String fieldName = null;
		String fieldValue = null;
		String result = null;
		boolean blocked = false;
		CommonMethodController controller = CommonMethodController
				.getInstance();
		PlayerMgmtController playerMgmtController = new PlayerMgmtController();
		try {
			Map<String, String> domainProp = controller.getDmPropertyMap(
					domainId, "blockedEmail", "blockedPhone");
			if (user_name != null) {
				fieldName = "user_name";
				fieldValue = user_name;
				result = "Not Available";
			} else if (email_id != null) {
				fieldName = "email_id";
				fieldValue = email_id;
				blocked = controller.checkBlockedEmailId(fieldValue, "SPECIFIC"
						.equals(domainProp.get("blockedEmail")) ? domainId
						: (short) 1);
				result = "Not Allowed";
			} else if (mobile_no != null) {
				fieldName = "mobile_no";
				fieldValue = mobile_no;
				blocked = controller.checkBlockedPhoneNo(fieldValue, "SPECIFIC"
						.equals(domainProp.get("blockedPhone")) ? domainId
						: (short) 1);
				result = "Not Allowed";
			}
			if (!blocked) {
				result = playerMgmtController.fieldIsUnique(fieldName,
						fieldValue, domainId);
			}
			if (!"Available".equals(result)) {
				result = "Not Available";
			}
			result = "<p>" + result + "</p>";
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.getWriter().write(result);
	}

	public String savePlrRegistration() {
		PlayerInfoBean playerRegistrationBean = new PlayerInfoBean();
		PlayerMgmtController playerMgmtController = new PlayerMgmtController();
		try {
			if (country_code == null && state_code != null) {
				country_code = state_code.split("-")[0];
			}
			playerRegistrationBean.setStatus(status);
			playerRegistrationBean.setAffiliateCode(0);
			playerRegistrationBean.setDomainId(domainId);
			playerRegistrationBean.setAliasId(aliasId);
			playerRegistrationBean.setRemoteAddress((request
					.getHeader("X-Real-IP") == null) ? request.getRemoteAddr()
					: request.getHeader("X-Real-IP"));
			playerRegistrationBean.setPlayerQues(playerQues);
			playerRegistrationBean.setLanguage("eng");
			playerRegistrationBean.setAddressLine1(address_line1);
			playerRegistrationBean.setAddressLine2(address_line2);
			playerRegistrationBean.setCity(city);
			playerRegistrationBean.setCommNews("N");
			playerRegistrationBean.setCommPromo("N");
			playerRegistrationBean.setCommSupport("N");
			playerRegistrationBean.setCommTechnical("N");
			playerRegistrationBean.setPostalCode(postal_code);
			playerRegistrationBean.setCountry("IN");
			playerRegistrationBean.setCountryId(105);
			if (year != null) {
				Calendar cal = Calendar.getInstance();
				cal.set(year, month, date);
				SimpleDateFormat formatter;
				formatter = new SimpleDateFormat(CommonMethodController
						.getInstance().fetchSystemProperties("DATE_FORMAT")
						.toString());
				date_of_birth = formatter.format(cal.getTime());
			}
			playerRegistrationBean.setDateOfBirth((date_of_birth));
			playerRegistrationBean.setEmailId(email_id);
			playerRegistrationBean.setFirstName(first_name);
			playerRegistrationBean.setGender((gender != null) ? gender
					.substring(0, 1) : null);
			playerRegistrationBean.setHouseNum(house_num);
			playerRegistrationBean.setLastName(last_name);
			if (currency != null && !"-1".equals(currency)) {
				playerRegistrationBean
						.setCurrencyId(Integer.parseInt(currency));
			}
			if (mobile_no != null && !"".equals(mobile_no)) {
				playerRegistrationBean.setMobileNo(Long.parseLong(mobile_no));
			}
			if (phone_num != null && !"".equals(phone_num)) {
				playerRegistrationBean.setPhoneNum(Long.parseLong(phone_num));
			}
			playerRegistrationBean.setCountryCode(country_code);
			playerRegistrationBean.setPromoOpt("N");
			if (reference_name_code != null
					&& !"-1".equals(reference_name_code)) {
				playerRegistrationBean.setReferenceId(Short
						.parseShort(reference_name_code));
			}
			playerRegistrationBean.setSecAns(sec_ans);
			if (sec_ques_id != null && !"-1".equals(sec_ques_id)) {
				playerRegistrationBean
						.setSecQuesId(Long.parseLong(sec_ques_id));
			}
			playerRegistrationBean.setStateCode(state_code);
			if(!StringUtils.isEmpty(title) && !"-1".equalsIgnoreCase(title)){
				playerRegistrationBean.setTitle(title);
			}
			playerRegistrationBean.setUserName(user_name);
			playerRegistrationBean.setReferSourceId(0L);
			playerRegistrationBean.setReferSource("NONE");
			playerRegistrationBean.setSubSourceId(0L);
			playerRegistrationBean.setDevice("PC");
			playerMgmtController.savePlrRegistration(playerRegistrationBean);

		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("some internal error");
			return "exception";
		}
		return SUCCESS;
	}

	public String updateInactivePlayer() {
		PlayerMgmtController playerMgmtController = new PlayerMgmtController();
		try {
			playerMgmtController.updateInactivePlayer(plrIds);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public void saveNickName(){
		logger.info("---saveNickName ---- " + nickName+"--userName ---" + userName );
		PlayerMgmtController playerMgmtController = new PlayerMgmtController();
		try{
			playerMgmtController.saveUpdateRummyNickName(domainName, userName, nickName);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public String prepareAppPushPanel() {
		try {
			if(plrIdList!=null && !"".equals(plrIdList)) {
				Type type = new TypeToken<Map<Long, String>>() {}.getType();
				playerMap = new Gson().fromJson(plrIdList, type);
				playerIdArr = playerMap.keySet().toArray(new Long[0]);
			}
			List<StGenAppVersionDetails> tempList=new MiscMgmtController().fetchAppVersionList(domainId, aliasId,null, "ACTIVE","BETA");
			appVersionMap = new HashMap<String, List<StGenAppVersionDetails>>();
			for(StGenAppVersionDetails appDetail : tempList ){
				if(appVersionMap.containsKey(appDetail.getOs()+" "+appDetail.getAppType()))
					appVersionMap.get(appDetail.getOs()+" "+appDetail.getAppType()).add(appDetail);
				else {
					List<StGenAppVersionDetails> list=new ArrayList<StGenAppVersionDetails>();
					list.add(appDetail);
					appVersionMap.put(appDetail.getOs()+" "+appDetail.getAppType(),list);
				}
			}
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception_nodecorate";
		}  catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error Occured.");
			return "exception_nodecorate";
		}
		return SUCCESS;
	}

	public String pushAppToSelectUsers() {
		try{		
			if(appPushBean.isSelectAll()){
				searchedCriteria.setRedirect("pushAppVersion");
				playerIdArr = searchedPlayerIDs(new ReportsController().searchPlayerData(searchedCriteria, 0, 0));
			}
			if(appPushBean.getVerIdArr()!=null && playerIdArr.length!=0) {
				new MiscMgmtController().pushAppToAll(appPushBean,playerIdArr);
			} else 
				throw new PMSException(PMSErrorCode.GEN_SOME_INTERNAL_ERROR,PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);	
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getMessage());
			return "exception";
		}catch (Exception e) {
			e.printStackTrace();
			addActionError(e.getMessage());
			return "exception";
		}
		return SUCCESS;
	}
	
	public String searchByMobile() {
		return SUCCESS;
		
	}
	public String fetchPlayerByMobile() {
		
		BoPlayerMgmtController boPlayerMgmtController= new BoPlayerMgmtController();
		try {
		plrmaster=boPlayerMgmtController.fetchPlayerByMobile(mobile_no,domainId);
	
		} catch (PMSException e) {
			addActionError(e.getErrorMessage());
			e.printStackTrace();
			return "exception_nodecorate";
		}
		finally {
			Session session=HibernateSessionFactory.getSession();
			session.close();
		}
		return SUCCESS;
	}
	
	public void fetchPlayerTickets() {
		BoPlayerMgmtController boPlayerMgmtController= new BoPlayerMgmtController();
		CommonMethodController cmncntrlr=CommonMethodController.getInstance();
		try {
		Map<Short,String> map=cmncntrlr.fetchAliasMap(domainId);
		aliasName=map.get(aliasId);
		ticketDetailBeans=boPlayerMgmtController.fetchPlayerTickets(playerId,aliasName);
		if (ticketDetailBeans.size() > 0) {
			response.getWriter().write(new Utility().convertJSON(ticketDetailBeans));
		} else
			response.getWriter().write("{}");
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		catch (PMSException e) {
			
			e.printStackTrace();
		}
		catch (Exception e) {
			
			e.printStackTrace();
		}
		finally {
			Session session=HibernateSessionFactory.getSession();
			session.close();
		}
	
		
	}
	
public String savepassword() {
		
		BoPlayerMgmtController boPlayerMgmtController= new BoPlayerMgmtController();
		try {
			String result =boPlayerMgmtController.savePassword(pass,requestPlayerId);
			
		} catch (PMSException e) {
			addActionError(e.getMessage());
			e.printStackTrace();
			return "exception";
		}
		finally {
			Session session=HibernateSessionFactory.getSession();
			session.close();
		}
		addActionMessage("Password Successfully Changed");
		return SUCCESS;
	}
	
public String reSendTicketSms() {
	
// write logic here to send sms
	
	addActionMessage("Sms Successfully Send");
	return SUCCESS;
}


public String trackTicket() {
	// logic here
	String txnId=transactionId;
	return SUCCESS;
}
public static void main(String a[]) {
	
	BoPlayerMgmtController boPlayerMgmtController= new BoPlayerMgmtController();
	try {
		//boPlayerMgmtController.fetchPlayerByMobile("9999323244");
		boPlayerMgmtController.savePassword("12345678");
	} catch (PMSException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
}
	public List getSearchPlrList() {
		return searchPlrList;
	}

	public void setSearchPlrList(List searchPlrList) {
		this.searchPlrList = searchPlrList;
	}

	public Map<String, List<DomainFieldsWithValueBean>> getModuleFieldList() {
		return moduleFieldList;
	}

	public void setModuleFieldList(
			Map<String, List<DomainFieldsWithValueBean>> moduleFieldList) {
		this.moduleFieldList = moduleFieldList;
	}

	public List<DomainFieldsWithValueBean> getDomainWiseFieldList() {
		return domainWiseFieldList;
	}

	public void setDomainWiseFieldList(
			List<DomainFieldsWithValueBean> domainWiseFieldList) {
		this.domainWiseFieldList = domainWiseFieldList;
	}

	public Map<Short, List<DomainFieldsWithValueBean>> getPageWiseFieldMap() {
		return pageWiseFieldMap;
	}

	public void setPageWiseFieldMap(
			Map<Short, List<DomainFieldsWithValueBean>> pageWiseFieldMap) {
		this.pageWiseFieldMap = pageWiseFieldMap;
	}

	public Map<String, List<DomainFieldsWithValueBean>> getSectionWiseFieldMap() {
		return sectionWiseFieldMap;
	}

	public void setSectionWiseFieldMap(
			Map<String, List<DomainFieldsWithValueBean>> sectionWiseFieldMap) {
		this.sectionWiseFieldMap = sectionWiseFieldMap;
	}

	public String[] getFieldDispName() {
		return fieldDispName;
	}

	public void setFieldDispName(String[] fieldDispName) {
		this.fieldDispName = fieldDispName;
	}

	public Short[] getFieldSequenceNo() {
		return fieldSequenceNo;
	}

	public void setFieldSequenceNo(Short[] fieldSequenceNo) {
		this.fieldSequenceNo = fieldSequenceNo;
	}

	public Short[] getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(Short[] pageNumber) {
		this.pageNumber = pageNumber;
	}

	public String[] getFieldName() {
		return fieldName;
	}

	public void setFieldName(String[] fieldName) {
		this.fieldName = fieldName;
	}

	public String[] getFieldType() {
		return fieldType;
	}

	public void setFieldType(String[] fieldType) {
		this.fieldType = fieldType;
	}

	public Integer[] getFieldId() {
		return fieldId;
	}

	public void setFieldId(Integer[] fieldId) {
		this.fieldId = fieldId;
	}

	public String[] getSectionName() {
		return sectionName;
	}

	public void setSectionName(String[] sectionName) {
		this.sectionName = sectionName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public long getPlayerId() {
		return playerId;
	}

	public void setPlayerId(long playerId) {
		this.playerId = playerId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
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

	public String getCompare() {
		return compare;
	}

	public void setCompare(String compare) {
		this.compare = compare;
	}

	public void setSearchResultsAvailable(String searchResultsAvailable) {
		this.searchResultsAvailable = searchResultsAvailable;
	}

	public String getSearchResultsAvailable() {
		return searchResultsAvailable;
	}

	public String getAccountBalance() {
		return accountBalance;
	}

	public void setAccountBalance(String accountBalance) {
		this.accountBalance = accountBalance;
	}

	public String getTestStatus() {
		return testStatus;
	}

	public void setTestStatus(String testStatus) {
		this.testStatus = testStatus;
	}

	public void setResource(PropertiesConfiguration resource) {
		this.resource = resource;
	}

	public PropertiesConfiguration getResource() {
		return resource;
	}

	public void setRegType(String regType) {
		this.regType = regType;
	}

	public String getRegType() {
		return regType;
	}

	public void setSpareFieldList(List<DomainFieldsWithValueBean> spareFieldList) {
		this.spareFieldList = spareFieldList;
	}

	public List<DomainFieldsWithValueBean> getSpareFieldList() {
		return spareFieldList;
	}

	public void setDomainPropertyBeansMap(
			Map<Short, DomainPropertyBean> domainPropertyBeansMap) {
		this.domainPropertyBeansMap = domainPropertyBeansMap;
	}

	public Map<Short, DomainPropertyBean> getDomainPropertyBeansMap() {
		return domainPropertyBeansMap;
	}

	public ArrayList getPlrList() {
		return plrList;
	}

	public void setPlrList(ArrayList plrList) {
		this.plrList = plrList;
	}

	public String getAddressVerified() {
		return addressVerified;
	}

	public String getAgeVerified() {
		return ageVerified;
	}

	public String getTaxationIdVerified() {
		return taxationIdVerified;
	}

	public void setAddressVerified(String addressVerified) {
		addressVerified.trim();
		this.addressVerified = addressVerified;
	}

	public void setAgeVerified(String ageVerified) {
		this.ageVerified = ageVerified;
	}

	public void setTaxationIdVerified(String taxationIdVerified) {
		this.taxationIdVerified = taxationIdVerified;
	}

	public PlayerDocumentMasterBean getPlrDocumentMaster() {
		return plrDocumentMaster;
	}

	public void setPlrDocumentMaster(PlayerDocumentMasterBean plrDocumentMaster) {
		this.plrDocumentMaster = plrDocumentMaster;
	}

	public void setAgeImageName(File ageImageName) {
		this.ageImageName = ageImageName;
	}

	public File getAgeImageName() {
		return ageImageName;
	}

	public String getAgeImageNameFileName() {
		return ageImageNameFileName;
	}

	public void setAgeImageNameFileName(String ageImageNameFileName) {
		this.ageImageNameFileName = ageImageNameFileName;
	}

	public void setIsPartOfMiniReg(String[] isPartOfMiniReg) {
		this.isPartOfMiniReg = isPartOfMiniReg;
	}

	public String[] getIsPartOfMiniReg() {
		return isPartOfMiniReg;
	}

	public int getRecordPerPage() {
		return recordPerPage;
	}

	public void setRecordPerPage(int recordPerPage) {
		this.recordPerPage = recordPerPage;
	}

	public int getPaginationPage() {
		return paginationPage;
	}

	public void setPaginationPage(int paginationPage) {
		this.paginationPage = paginationPage;
	}

	public void setVerificationStatus(String verificationStatus) {
		this.verificationStatus = verificationStatus;
	}

	public String getVerificationStatus() {
		return verificationStatus;
	}

	public void setRefundNTerPLrId(long[] refundNTerPLrId) {
		this.refundNTerPLrId = refundNTerPLrId;
	}

	public long[] getRefundNTerPLrId() {
		return refundNTerPLrId;
	}

	public void setVeriAction(String veriAction) {
		this.veriAction = veriAction;
	}

	public String getVeriAction() {
		return veriAction;
	}

	public Long[] getPlayerIdArr() {
		return playerIdArr;
	}

	public void setPlayerIdArr(Long[] playerIdArr) {
		this.playerIdArr = playerIdArr;
	}

	public Map<Long, String> getPlayerMap() {
		return playerMap;
	}

	public void setPlayerMap(Map<Long, String> playerMap) {
		this.playerMap = playerMap;
	}

	public List<TemplateMasterBean> getTempList() {
		return tempList;
	}

	public void setTempList(List<TemplateMasterBean> tempList) {
		this.tempList = tempList;
	}

	public String getPlrIdList() {
		return plrIdList;
	}

	public void setPlrIdList(String plrIdList) {
		this.plrIdList = plrIdList;
	}

	public String getJsonObjVariableId() {
		return jsonObjVariableId;
	}

	public void setJsonObjVariableId(String jsonObjVariableId) {
		this.jsonObjVariableId = jsonObjVariableId;
	}

	public String getContentPath() {
		return contentPath;
	}

	public void setContentPath(String contentPath) {
		this.contentPath = contentPath;
	}

	public PlrSearchOptionBean getSearchedCriteria() {
		return searchedCriteria;
	}

	public void setSearchedCriteria(String searchedCriteria) {
		Gson wdrData = new GsonBuilder().setDateFormat("dd/MM/yyyy HH:mm:ss")
				.create();
		this.searchedCriteria = wdrData.fromJson(searchedCriteria,
				PlrSearchOptionBean.class);
	}

	public void setDomainIdMap(Map<Short, String> domainIdMap) {
		this.domainIdMap = domainIdMap;
	}

	public Map<Short, String> getDomainIdMap() {
		return domainIdMap;
	}	

	public String getLanguageStr() {
		return languageStr;
	}

	public void setLanguageStr(String languageStr) {
		this.languageStr = languageStr;
	}

	public PlrMailContentBean getPlrEmailBean() {
		return plrEmailBean;
	}

	public void setPlrEmailBean(PlrMailContentBean plrEmailBean) {
		this.plrEmailBean = plrEmailBean;
	}

	public String getReportData() {
		return reportData;
	}

	public void setReportData(String reportData) {
		this.reportData = reportData;
	}

	public String getReportDataType() {
		return reportDataType;
	}

	public void setReportDataType(String reportDataType) {
		this.reportDataType = reportDataType;
	}

	public void setDefaultContentPath(String defaultContentPath) {
		this.defaultContentPath = defaultContentPath;
	}

	public String getDefaultContentPath() {
		return defaultContentPath;
	}

	public void setPlayerInfo(PlayerInfoBean playerInfo) {
		this.playerInfo = playerInfo;
	}

	public PlayerInfoBean getPlayerInfo() {
		return playerInfo;
	}

	public void setDuplicatePlrInfo(PlayerInfoBean duplicatePlrInfo) {
		this.duplicatePlrInfo = duplicatePlrInfo;
	}

	public PlayerInfoBean getDuplicatePlrInfo() {
		return duplicatePlrInfo;
	}

	public void setChangeReq(String changeReq) {
		this.changeReq = changeReq;
	}

	public String getChangeReq() {
		return changeReq;
	}

	public void setCurrentData(String currentData) {
		this.currentData = currentData;
	}

	public String getCurrentData() {
		return currentData;
	}

	public void setNewData(String newData) {
		this.newData = newData;
	}

	public String getNewData() {
		return newData;
	}

	public void setDuplicatePlrId(Long duplicatePlrId) {
		this.duplicatePlrId = duplicatePlrId;
	}

	public Long getDuplicatePlrId() {
		return duplicatePlrId;
	}

	public String getReference_name_code() {
		return reference_name_code;
	}

	public void setReference_name_code(String referenceNameCode) {
		reference_name_code = referenceNameCode;
	}

	public Integer getDate() {
		return date;
	}

	public void setDate(Integer date) {
		this.date = date;
	}

	public Integer getMonth() {
		return month;
	}

	public void setMonth(Integer month) {
		this.month = month;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String userName) {
		user_name = userName;
	}

	public String getSec_ques_id() {
		return sec_ques_id;
	}

	public void setSec_ques_id(String secQuesId) {
		sec_ques_id = secQuesId;
	}

	public String getSec_ans() {
		return sec_ans;
	}

	public void setSec_ans(String secAns) {
		sec_ans = secAns;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String firstName) {
		first_name = firstName;
	}

	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String lastName) {
		last_name = lastName;
	}

	public String getHouse_num() {
		return house_num;
	}

	public void setHouse_num(String houseNum) {
		house_num = houseNum;
	}

	public String getAddress_line1() {
		return address_line1;
	}

	public void setAddress_line1(String addressLine1) {
		address_line1 = addressLine1;
	}

	public String getAddress_line2() {
		return address_line2;
	}

	public void setAddress_line2(String addressLine2) {
		address_line2 = addressLine2;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getCountry_code() {
		return country_code;
	}

	public void setCountry_code(String countryCode) {
		country_code = countryCode;
	}

	public String getState_code() {
		return state_code;
	}

	public void setState_code(String stateCode) {
		state_code = stateCode;
	}

	public String getMobile_no() {
		return mobile_no;
	}

	public void setMobile_no(String mobileNo) {
		mobile_no = mobileNo;
	}

	public String getEmail_id() {
		return email_id;
	}

	public void setEmail_id(String emailId) {
		email_id = emailId;
	}

	public String getPhone_num() {
		return phone_num;
	}

	public void setPhone_num(String phoneNum) {
		phone_num = phoneNum;
	}

	public String getPostal_code() {
		return postal_code;
	}

	public void setPostal_code(String postalCode) {
		postal_code = postalCode;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public String getDate_of_birth() {
		return date_of_birth;
	}

	public void setDate_of_birth(String dateOfBirth) {
		date_of_birth = dateOfBirth;
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public String getPlayerQues() {
		return playerQues;
	}

	public void setPlayerQues(String playerQues) {
		this.playerQues = playerQues;
	}

	public void setSearchedCriteria(PlrSearchOptionBean searchedCriteria) {
		this.searchedCriteria = searchedCriteria;
	}

	public void setRequestPlayerId(Long requestPlayerId) {
		this.requestPlayerId = requestPlayerId;
	}

	public Long getRequestPlayerId() {
		return requestPlayerId;
	}

	public Short[] getMiniSeqNo() {
		return miniSeqNo;
	}

	public void setMiniSeqNo(Short[] miniSeqNo) {
		this.miniSeqNo = miniSeqNo;
	}

	public PrivFunctionBean getPrivFunctionBean() {
		return privFunctionBean;
	}

	public void setPrivFunctionBean(PrivFunctionBean privFunctionBean) {
		this.privFunctionBean = privFunctionBean;
	}

	public Integer[] getFieldDispCode() {
		return fieldDispCode;
	}

	public void setFieldDispCode(Integer[] fieldDispCode) {
		this.fieldDispCode = fieldDispCode;
	}

	public Integer[] getSectionNameCode() {
		return sectionNameCode;
	}

	public void setSectionNameCode(Integer[] sectionNameCode) {
		this.sectionNameCode = sectionNameCode;
	}

	public Long[] getPlrIds() {
		return plrIds;
	}

	public void setPlrIds(Long[] plrIds) {
		this.plrIds = plrIds;
	}

	public void setReqData(String reqData) {
		this.reqData = reqData;
	}

	public String getReqData() {
		return reqData;
	}

	public List<Object> getDataList() {
		return dataList;
	}

	public void setDataList(List<Object> dataList) {
		this.dataList = dataList;
	}

	public boolean isError() {
		return error;
	}

	public void setError(boolean error) {
		this.error = error;
	}

	public String getUploadStartDate() {
		return uploadStartDate;
	}

	public void setUploadStartDate(String uploadStartDate) {
		this.uploadStartDate = uploadStartDate;
	}

	public String getUploadEndDate() {
		return uploadEndDate;
	}

	public void setUploadEndDate(String uploadEndDate) {
		this.uploadEndDate = uploadEndDate;
	}

	public PlrNotificationBean getPlrNotificationBean() {
		return plrNotificationBean;
	}

	public void setPlrNotificationBean(PlrNotificationBean plrNotificationBean) {
		this.plrNotificationBean = plrNotificationBean;
	}
	
	public String getTempAvailable() {
		return tempAvailable;
	}

	public void setTempAvailable(String tempAvailable) {
		this.tempAvailable = tempAvailable;
	}

	public String getSentOn() {
		return sentOn;
	}

	public void setSentOn(String sentOn) {
		this.sentOn = sentOn;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public Map<String, List<StGenAppVersionDetails>> getAppVersionMap() {
		return appVersionMap;
	}

	public void setAppVersionMap(
			Map<String, List<StGenAppVersionDetails>> appVersionMap) {
		this.appVersionMap = appVersionMap;
	}

	public PlrAppPushBoBean getAppPushBean() {
		return appPushBean;
	}

	public void setAppPushBean(PlrAppPushBoBean appPushBean) {
		this.appPushBean = appPushBean;
	}
	
	public String getAppType() {
		return appType;
	}

	public void setAppType(String appType) {
		this.appType = appType;
	}

	public HashMap<String, List<StDmAliasDeeplinkRep>> getDeeplinkMap() {
		return deeplinkMap;
	}

	public void setDeeplinkMap(HashMap<String, List<StDmAliasDeeplinkRep>> deeplinkMap) {
		this.deeplinkMap = deeplinkMap;
	}
	
	public StPmPlayerMaster getPlrmaster() {
		return plrmaster;
	}

	public void setPlrmaster(StPmPlayerMaster plrmaster) {
		this.plrmaster = plrmaster;
	}

	public List<TicketDetailBean> getTicketDetailBeans() {
		return ticketDetailBeans;
	}

	public void setTicketDetailBeans(List<TicketDetailBean> ticketDetailBeans) {
		this.ticketDetailBeans = ticketDetailBeans;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	public StPmPlrRdmDocMasterBean getPlrBankDocumentMaster() {
		return plrBankDocumentMaster;
	}

	public void setPlrBankDocumentMaster(StPmPlrRdmDocMasterBean plrBankDocumentMaster) {
		this.plrBankDocumentMaster = plrBankDocumentMaster;
	}

	public Long getRedeemAccId() {
		return redeemAccId;
	}

	public void setRedeemAccId(Long redeemAccId) {
		this.redeemAccId = redeemAccId;
	}

	
	
	public static void main(String[] args) {
		
		try {
			Class clazz = BoPlayerMgmtController.class;
			Method method = clazz.getMethod("saveTemplate", PlrMailContentBean.class, Long[].class,int.class);
			method.getParameterTypes();
//			method.invoke(obj, args)
		} catch (NoSuchMethodException | SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
*/