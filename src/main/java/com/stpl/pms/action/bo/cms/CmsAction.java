package com.stpl.pms.action.bo.cms;

//import java.io.BufferedReader;
//import java.io.File;
//import java.io.FileReader;
//import java.io.FileWriter;
//import java.io.IOException;
//import java.io.InputStreamReader;
//import java.io.PrintWriter;
//import java.lang.reflect.Type;
//import java.net.URL;
//import java.net.URLConnection;
//import java.net.URLDecoder;
//import java.util.ArrayList;
//import java.util.Calendar;
//import java.util.HashMap;
//import java.util.HashSet;
//import java.util.List;
//import java.util.Map;
//import java.util.Set;
//import java.util.regex.Matcher;
//import java.util.regex.Pattern;
//
//import javax.servlet.http.HttpSession;
//import javax.xml.registry.SaveException;
//
//import org.apache.commons.io.FilenameUtils;
//import org.apache.log4j.Logger;
//import org.json.simple.JSONArray;
//import org.json.simple.JSONObject;
//import org.json.simple.parser.JSONParser;
//import org.jsoup.Jsoup;
//import org.jsoup.nodes.Document;
//import org.jsoup.nodes.Element;
//import org.jsoup.select.Elements;
//
//import com.google.gson.Gson;
//import com.google.gson.GsonBuilder;
//import com.google.gson.reflect.TypeToken;
//import com.opensymphony.xwork2.ActionContext;
//import com.stpl.pms.controller.cms.CmsController;
//import com.stpl.pms.controller.commonMethods.CommonMethodController;
//import com.stpl.pms.controller.gatewaytocomm.CommunicationJob;
//import com.stpl.pms.exception.PMSException;
//import com.stpl.pms.hibernate.mapping.StCmsPlaceholderMaster;
//import com.stpl.pms.hibernate.mapping.StCmsPlrCriteriaMapping;
//import com.stpl.pms.hibernate.mapping.StDmDomainAliasNameMaster;
//import com.stpl.pms.javabeans.AddNewEventBean;
//import com.stpl.pms.javabeans.CMSWidgetBean;
//import com.stpl.pms.javabeans.CampaignBean;
//import com.stpl.pms.javabeans.CampaignDetailBean;
//import com.stpl.pms.javabeans.CssBean;
//import com.stpl.pms.javabeans.FixedPageDetailBean;
//import com.stpl.pms.javabeans.JoomlaClientLandingPageBean;
//import com.stpl.pms.javabeans.JoomlaContentBean;
//import com.stpl.pms.javabeans.JoomlaLandingPages;
//import com.stpl.pms.javabeans.JoomlaMenuBean;
//import com.stpl.pms.javabeans.JoomlaModuleBean;
//import com.stpl.pms.javabeans.LanguageBean;
//import com.stpl.pms.javabeans.MapNewEventBean;
//import com.stpl.pms.javabeans.PHContentMappingBean;
//import com.stpl.pms.javabeans.PlaceHolderBean;
//import com.stpl.pms.javabeans.PlaceHolderCriteriaBean;
//import com.stpl.pms.javabeans.PlaceHolderDetailBean;
//import com.stpl.pms.javabeans.PlaceHolderPageNameBean;
//import com.stpl.pms.javabeans.PlrCritMappingBean;
//import com.stpl.pms.javabeans.PortalPageLinkBean;
//import com.stpl.pms.javabeans.PortalUrlDetailBean;
//import com.stpl.pms.javabeans.PortalUrlTrackingBean;
//import com.stpl.pms.javabeans.SavePlayerInfo;
//import com.stpl.pms.javabeans.TemplateMasterBean;
//import com.stpl.pms.javabeans.UploadBannerBean;
//import com.stpl.pms.javabeans.UrlTagBean;
//import com.stpl.pms.javabeans.VariablesBean;
//import com.stpl.pms.javabeans.WidgetFieldBean;
import com.stpl.pms.struts.common.BaseActionSupport;
//import com.stpl.pms.utility.UserValidation;
//import com.stpl.pms.utility.Utility;

public class CmsAction extends BaseActionSupport {
}
/*
 * private static final Logger log = Logger.getLogger(CmsAction.class); private
 * static final String LOG_TAG =
 * "<<<<<<------:::: CMS ACTION CLASS ::::------>>>>>>" ; private static final
 * String
 * LOG_ERROR="<<<<<<------:::: CMS ACTION CLASS EXCEPTION OCCURED ::::------>>>>>>"
 * ; private static final long serialVersionUID = 1L; private String content;
 * 
 * private CmsController cmsController; private Object textAreaId; private
 * Integer language; private Integer currency; private List<VariablesBean>
 * variablesBeanList; private String variablesBeanStr; private
 * List<PortalPageLinkBean> pageLinkList; private String pageLinkStr; private
 * List<PortalPageLinkBean> submitUrlList; private String pageName; private
 * String pageMetaTag; private String pageTitle; private String pageKeyword;
 * private String pageDescription; private String graphicsType; private String
 * size; private String relatedTo; private String defaultGraphicsPath; private
 * String[] currencyList; private String campaignMap; private Integer
 * relatedCampaign; private String bannerContext; private String bannerName;
 * private String bannerType; private String bannerDescrip; private Integer
 * contentId; private PortalPageLinkBean pageDetailBean; private String
 * scriptFor; private Integer urlId; private String pageNameList; private String
 * placeHolderPages; private Map<String, Map<String, Map<Integer,
 * List<PlaceHolderDetailBean>>>> placeHolderDetailMap; private String pagePath;
 * private String contentPath; private List<File> graphicsPath = new
 * ArrayList<File>(); private List<String> graphicsPathContentType = new
 * ArrayList<String>(); private List<String> graphicsPathFileName = new
 * ArrayList<String>(); private String[] graphicsPathString; private String
 * isCommonCSS; private String isCustomCSS; private Integer specificCssId;
 * private Map<Integer, CssBean> domainCssMap; private String domainCssStr;
 * private Gson variablesBeanJson; private String pageType; private
 * List<StCmsPlaceholderMaster> stCmsPlaceHolderMasters; private
 * List<CMSWidgetBean> cmsBeans; private String cmsBeansStr; private Integer
 * contentHeight; private Integer contentWidth; private String[] phCode; private
 * Integer[] phHeight; private Integer[] phWidth; private String contentUrl;
 * private Integer[] phIds; private String contentIds; private String
 * contentType; private String[] phName; private File contentFile; private
 * String contentFileFileName; private String templateType; private String
 * isPreLogin; private String isPostLogin; private String device; private String
 * deviceOS; private String contentSize; private String fixedPageJson; private
 * String templateMod; private String campName; private String campType; private
 * String campDetailString; private Map<String, String> landingPageUrlDetail;
 * private Long campId; private CampaignBean campaignDetailBean; private
 * Map<Integer, String> landingPageDetail; private String landingPageDetailStr;
 * private String status; private String[] metaNames; private String[]
 * metaContents; private String[] linkHrefs; private String[] linkRels; private
 * String[] linkTypes; private String isLink; private String cssDetail; private
 * TemplateMasterBean tmpltBean; private String jsonObjVariableId; private
 * List<String> campParams; private String defaultContentPath; private
 * Map<Integer, String> landingPages; private String cssPath; private String
 * widgetType; private String widgetName; private Integer widgetId; private
 * String widgetContent; private List<WidgetFieldBean> fildsList; private String
 * fieldsStr; private String redirectUrl; private Map<Integer, CssBean>
 * specificCssMap; private String specificCssStr; private String editorCss;
 * private String specificCssPath; private File uploadZipCss; private String
 * uploadZipCssFileName; private String cssName; private String validationStyle;
 * private String cssId; private Map<Integer, String> editFetchCssMap; private
 * String dmCssMap; private String criteriaName; private PlaceHolderCriteriaBean
 * placeHolderCriteria; private String phCrit; private
 * List<PHContentMappingBean> phCtBean; private String pageUrl; private
 * UrlTagBean urlBean; private String pageTypeClient; private String
 * joomlaContent; private Map<Integer, String> phCritMap; private int menuId;
 * private Map <String, Map<Integer, String>> modulePosMap; private Map<String,
 * List<PlrCritMappingBean>> plrCritData; private List<PlrCritMappingBean>
 * critBean; private String menuTitle; private String aliascontentType; private
 * List<JoomlaLandingPages> joomlaCtBean; private Map<String,String>
 * reDirectPage; private AddNewEventBean addNewEvent; private MapNewEventBean
 * mapNewEvent; private SavePlayerInfo savePlrInfo; private SavePlayerInfo
 * savePromotionDetail;
 * 
 *//**
	 * Save Promotion details for player by using back office
	 * 
	 * @return
	 * @throws Exception
	 */
/*
 * public String savePromotionInfo() throws Exception { try { CommunicationJob
 * communicationJob = new CommunicationJob();
 * communicationJob.savePromotionInfo(savePromotionDetail); } catch (Exception
 * e){ log.error(LOG_TAG, e); } return SUCCESS; }
 * 
 *//**
	 * Save verified email and mobile numbers
	 * 
	 * @return
	 * @throws Exception,PMSException
	 */
/*
 * public String saveCommPlayerInfo() throws Exception { try { log.info(LOG_TAG+
 * " saveCommPlayerInfo"); CommunicationJob communicationJob = new
 * CommunicationJob(); communicationJob.saveCommPlayerInfo(savePlrInfo); }
 * catch(Exception e){ log.error(LOG_TAG, e); } return SUCCESS; }
 * 
 *//**
	 * Created on 30/04/2018 Map New Communication Event to existing players by
	 * using back office
	 */
/*
 * public String mapNewEventExitingPlr() throws Exception { try {
 * log.info(LOG_TAG + " mapNewEventExitingPlr"); CommunicationJob
 * communicationJob = new CommunicationJob();
 * communicationJob.mapNewEventExitingPlr(mapNewEvent); } catch (Exception e) {
 * log.error(LOG_ERROR, e); throw e; } return SUCCESS; }
 * 
 *//**
	 * Created on 24/4/2018 Add New Communication Event by using Back office
	 * 
	 * @throws PMSException
	 *//*
	 * public String saveNewEventComm() throws PMSException { try {
	 * log.info(LOG_TAG+" saveNewEventComm method"); cmsController = new
	 * CmsController();
	 * addNewEvent.setUserId((Long.valueOf(userInfoBean.getUserId())));
	 * cmsController.saveNewEventComm(addNewEvent); } catch(PMSException e){
	 * log.error(LOG_ERROR, e); throw new
	 * PMSException(e.getErrorCode(),e.getErrorMessage()); } return SUCCESS; }
	 * 
	 * public String getFixedPages() { cmsController = new CmsController(); Gson
	 * gson = new Gson(); try { fixedPageJson =
	 * gson.toJson(cmsController.getFixedPages()); } catch (Exception e) {
	 * e.printStackTrace(); } return SUCCESS; }
	 * 
	 * public void getFixedContentPageName() { Gson gson = new Gson();
	 * cmsController = new CmsController(); PrintWriter out = null; try { //
	 * Map<Integer, List<String>> result = ; fixedPageJson =
	 * gson.toJson(cmsController.getFixedPagesMap(device, aliasId)); out =
	 * response.getWriter(); out.write(fixedPageJson); } catch (Exception e) {
	 * e.printStackTrace(); } }
	 * 
	 * public void getDomainSpecificCss() { Gson gson = new Gson();
	 * cmsController = new CmsController(); PrintWriter out = null; try { out =
	 * response.getWriter();
	 * out.write(gson.toJson(cmsController.getAliasSpecificCss(aliasId))); }
	 * catch (Exception e) { e.printStackTrace(); } }
	 * 
	 * private String getContentPath(CommonMethodController controller, String
	 * domainName, String aliasName, String langType, String langCode) throws
	 * PMSException { StringBuilder filePath = new StringBuilder("");
	 * filePath.append(domainName); filePath.append("|");
	 * filePath.append(aliasName); filePath.append("|");
	 * filePath.append(controller.fetchAliasLayout(aliasId, device));
	 * filePath.append("|"); filePath.append(device.toLowerCase());
	 * filePath.append("|"); filePath.append(langType); filePath.append("|");
	 * filePath.append(pageType.toLowerCase()); filePath.append("|");
	 * filePath.append(langCode); return filePath.toString(); }
	 * 
	 * private String getStaticContentPath(CommonMethodController controller,
	 * String domainName, String aliasName, String pageLayout, String langType,
	 * String langCode) throws PMSException { StringBuilder filePath = new
	 * StringBuilder(""); filePath.append(domainName); filePath.append("|");
	 * filePath.append(aliasName); filePath.append("|");
	 * filePath.append(pageLayout); filePath.append("|");
	 * filePath.append(device.toLowerCase()); filePath.append("|");
	 * filePath.append(langType); filePath.append("|");
	 * filePath.append(pageType.toLowerCase()); filePath.append("|");
	 * filePath.append(langCode); return filePath.toString(); }
	 * 
	 * public String fetchFixedContent() { String params = null;
	 * CommonMethodController controller = CommonMethodController
	 * .getInstance(); try { if(!"SMS".contains(pageType)){
	 * StDmDomainAliasNameMaster aliasMaster = controller
	 * .getAliasMaster(aliasId); String domainName =
	 * aliasMaster.getDomainMaster().getDomainName(); String aliasName =
	 * aliasMaster.getAliasName(); if (pageType.contains("SMS") ||
	 * pageType.contains("EMAIL")) { if
	 * ("BYDEFAULT".equals(aliasMaster.getTemplate())) { aliasId = 1;
	 * aliasMaster = controller.getAliasMaster(aliasId); domainName =
	 * aliasMaster.getDomainMaster().getDomainName(); aliasName =
	 * aliasMaster.getAliasName();
	 * 
	 * } } else { if ("BYDEFAULT".equals(aliasMaster.getContentList())) {
	 * aliasId = 1; aliasMaster = controller.getAliasMaster(aliasId); domainName
	 * = aliasMaster.getDomainMaster().getDomainName(); aliasName =
	 * aliasMaster.getAliasName(); } } // String fileSeperater = File.separator;
	 * cssPath = controller.fetchSystemProperties("DEFAULT_CONTENT_PATH");
	 * StringBuilder portalPath = new StringBuilder(cssPath);
	 * portalPath.append(domainName); portalPath.append("/");
	 * portalPath.append(aliasName); portalPath.append("/");
	 * portalPath.append(controller.fetchAliasLayout(aliasId, device));
	 * portalPath.append("/"); portalPath.append(device.toLowerCase());
	 * portalPath.append("/"); portalPath.append("LR"); portalPath.append("/");
	 * portalPath.append(pageType.toLowerCase()); portalPath.append("/").append(
	 * controller.fetchLanguageMasterBean(language) .getLanguageBaseCode());
	 * portalPath.append("/") .append((pageType.contains("SMS") || pageType
	 * .contains("EMAIL")) ? templateType : contentPath); String str1 =
	 * Utility.callUrl(portalPath.toString(), params); String line = ""; if
	 * ("HOME_PAGE".equals(pageType) || "FOOTER".equals(pageType)) { HttpSession
	 * session = request.getSession(); line =
	 * str1.toString().replaceAll("<%@(?:.*)%>", "") .replace("<s:property",
	 * " s:property") .replace("></s:property>", " /s:property")
	 * .replaceAll("�", ""); Document dc = Jsoup.parse(line); Elements elements
	 * = dc.select("div[id$=widgetDiv]"); for (Element element : elements) {
	 * element.html(element.attr("widget_name")); }
	 * session.setAttribute("oldContentHead",
	 * dc.getElementsByTag("head").get(0).html()); content =
	 * dc.getElementsByTag("body").get(0).html(); } else { content =
	 * str1.toString(); } } else { content = new
	 * CmsController().fetchSMSContent(Integer.valueOf(templateType)); }
	 * 
	 * } catch (Exception e) { e.printStackTrace(); content = ""; return
	 * "exception_nodecorate"; } finally { pageLoadVariables(); } return
	 * SUCCESS; }
	 * 
	 * public String saveFixedContent() {
	 * 
	 * CommonMethodController controller = CommonMethodController
	 * .getInstance(); HttpSession session = request.getSession();
	 * FixedPageDetailBean pageDetailBean = new FixedPageDetailBean();
	 * cmsController = new CmsController(); List<PlaceHolderBean>
	 * placeHolderBeans = null; try { LanguageBean languageBean = controller
	 * .fetchLanguageMasterBean(language); StDmDomainAliasNameMaster aliasMaster
	 * = controller .getAliasMaster(aliasId); String domainName =
	 * aliasMaster.getDomainMaster().getDomainName(); String aliasName =
	 * aliasMaster.getAliasName(); String editFile = ((pageType.contains("SMS")
	 * || pageType .contains("EMAIL")) ? templateType : contentPath); if
	 * (!pageType.equals("SMS") && !pageType.equals("EMAIL")) {
	 * pageDetailBean.setContentId(Integer.parseInt(pageName)); if
	 * ("HOME_PAGE".equals(pageType)) { Document dc = Jsoup.parse(content);
	 * Elements elements = dc.select("div[id$=widgetDiv]"); for (Element element
	 * : elements) { Elements childEles = element .select("div[id$=widgetDiv]");
	 * if (childEles.size() > 1) { element.replaceWith(childEles.last()); }
	 * String widgetName = element.attr("widget_name"); String widgetType =
	 * element.attr("widget_type");
	 * element.html("<s:include value=\"/portalContent/" + domainName + "/" +
	 * aliasName + "/default/pc/LR/" + widgetType + "/eng/" + widgetName +
	 * ".jsp\"></s:include>"); } content =
	 * dc.getElementsByTag("body").get(0).html(); String str = (String) session
	 * .getAttribute("oldContentHead"); StringBuilder headTag = new
	 * StringBuilder(
	 * "<%@ page language=\"java\" import=\"java.util.*\" pageEncoding=\"UTF-8\"%>\n<%@taglib prefix=\"s\" uri=\"/struts-tags\"%>\n"
	 * ); headTag.append("<html><head>").append(str)
	 * .append("</head><body>").append(content) .append("</body></html>");
	 * content = headTag.toString(); } }
	 * 
	 * for struts tags
	 * 
	 * content = content.replace(" /s:property", "></s:property>"); content =
	 * content.replace(" s:property", "<s:property"); content =
	 * content.replace(">s:property", "><s:property");
	 * pageDetailBean.setDevice(device); pageDetailBean.setDomainId(domainId);
	 * pageDetailBean.setPageType(pageType);
	 * pageDetailBean.setTemplateType(templateType);
	 * pageDetailBean.setAliasId(aliasId); if (phHeight != null) {
	 * placeHolderBeans = new ArrayList<PlaceHolderBean>(); for (int k = 0; k <
	 * phHeight.length; k++) { PlaceHolderBean placeHolderBean = new
	 * PlaceHolderBean(); placeHolderBean.setHeight(phHeight[k]);
	 * placeHolderBean.setWidth(phWidth[k]); placeHolderBean.setName(phName[k]);
	 * placeHolderBean.setPlaceHolderCode(phCode[k]);
	 * placeHolderBean.setLanguageCode(languageBean .getLanguageBaseCode());
	 * placeHolderBeans.add(placeHolderBean); }
	 * pageDetailBean.setPlaceHolderBeans(placeHolderBeans); }
	 * if("SMS".equals(pageType)){ pageDetailBean.setContent(content); } else {
	 * Utility.saveOrUpdateContent( content, editFile,
	 * getContentPath(controller, domainName, aliasName, "LR",
	 * languageBean.getLanguageBaseCode())); }
	 * cmsController.editFixedContent(pageDetailBean, userInfoBean.getUserId());
	 * session.removeAttribute("oldContentHead"); }catch(PMSException pmse){
	 * log.error(pmse.getErrorMessage()); return ERROR; } catch (Exception e) {
	 * e.printStackTrace(); return ERROR; } return SUCCESS; }
	 * 
	 * public void fetchFixedTempletes() { cmsController = new CmsController();
	 * Gson gson = new Gson(); PrintWriter out; try { Map<String, List<String>>
	 * result = cmsController .fetchFixedTempletesMap(aliasId, templateMod);
	 * String templateMapJson = gson.toJson(result); out = response.getWriter();
	 * out.write(templateMapJson); } catch (Exception e) { e.printStackTrace();
	 * }
	 * 
	 * }
	 * 
	 * public String pageLoadGraphics() { cmsController = new CmsController();
	 * CommonMethodController controller = CommonMethodController
	 * .getInstance(); try { if (graphicsType != null) { device = "pc";
	 * Map<String, String> dmMap = controller.getDmPropertyMap( domainId,
	 * "languageId", "currencyId"); List<String> stringList =
	 * cmsController.getGraphicList(aliasId, size, currency, language,
	 * graphicsType, pageType); List<String> stringListNew = new
	 * ArrayList<String>(); graphicsPathString = new String[stringList.size()];
	 * // String fileSperator = File.separator; if (language == null || language
	 * == -1) language = Integer.valueOf(dmMap.get("languageId")); if (currency
	 * == null || currency == -1) currency =
	 * Integer.valueOf(dmMap.get("currencyId")); StDmDomainAliasNameMaster
	 * aliasMaster = controller .getAliasMaster(aliasId); String domainName =
	 * aliasMaster.getDomainMaster() .getDomainName(); String aliasName =
	 * aliasMaster.getAliasName(); String path = controller
	 * .fetchSystemProperties("DEFAULT_CONTENT_PATH") + domainName + "/" +
	 * aliasName + "/" + controller.fetchAliasLayout(aliasId, device) + "/" +
	 * device.toLowerCase() + "/" + "LR/" + graphicsType.toLowerCase() + "/" +
	 * controller.fetchLanguageMasterBean(language) .getLanguageBaseCode() + "/"
	 * + controller.fetchCurrencyMasterBean(currency) .getCurrCode() + "/"; //
	 * path = path.replace(fileSperator, "/"); for (String string : stringList)
	 * { string = path + string; stringListNew.add(string); } graphicsPathString
	 * = stringListNew.toArray(graphicsPathString); } } catch (PMSException e) {
	 * e.printStackTrace(); addActionError(e.getErrorMessage()); return
	 * "exception_nodecorate"; }catch (Exception be) {
	 * addActionError("Some internal error."); be.printStackTrace(); return
	 * "exception_nodecorate"; } return SUCCESS; }
	 * 
	 * public String pageLoadVariables() { cmsController = new CmsController();
	 * try { variablesBeanList = cmsController.getVariables(pageType);
	 * variablesBeanStr =new Utility().convertJSON(variablesBeanList); } catch
	 * (PMSException e) { e.printStackTrace();
	 * addActionError(e.getErrorMessage()); return "exception_nodecorate";
	 * }catch (Exception be) { addActionError("Some internal error.");
	 * be.printStackTrace(); return "exception_nodecorate"; } return SUCCESS; }
	 * 
	 * public String pageLoadLinks() { cmsController = new CmsController(); try
	 * { pageLinkList = cmsController.getPageURLs(aliasId, language, device);
	 * pageLinkStr=new Utility().convertJSON(pageLinkList); } catch
	 * (PMSException e) { e.printStackTrace();
	 * addActionError(e.getErrorMessage()); return "exception_nodecorate";
	 * }catch (Exception be) { addActionError("Some internal error.");
	 * be.printStackTrace(); return "exception_nodecorate"; } return SUCCESS;
	 * 
	 * }
	 * 
	 * public String pageLoadWidgets() { cmsController = new CmsController();
	 * try { cmsBeans = cmsController.getCMSWidgetBeanList(aliasId, widgetType,
	 * device);
	 * 
	 * cmsBeansStr =new Utility().convertJSON(cmsBeans);
	 * 
	 * } catch (PMSException e) { e.printStackTrace();
	 * addActionError(e.getErrorMessage()); return "exception_nodecorate";
	 * }catch (Exception be) { addActionError("Some internal error.");
	 * be.printStackTrace(); return "exception_nodecorate"; } return SUCCESS; }
	 * 
	 * public void checkPageAvailability() throws IOException { cmsController =
	 * new CmsController(); String result = null; try { if (pageName == null &&
	 * tmpltBean.getTemplateSubject() != null) { pageName =
	 * tmpltBean.getTemplateSubject() + "|T"; } result =
	 * cmsController.isPageNameAvail(aliasId, pageName, device, pageType); }
	 * catch (PMSException e) { e.printStackTrace(); result =
	 * e.getErrorMessage(); }catch (Exception be) { be.printStackTrace(); result
	 * = "Some Internal Error!"; } response.getWriter().write(result); }
	 * 
	 * public void checkURLAvailability() throws IOException { cmsController =
	 * new CmsController(); String result = null; try { result =
	 * cmsController.isUrlAvail(contentUrl, aliasId, device); } catch
	 * (PMSException e) { e.printStackTrace(); result = e.getErrorMessage();
	 * }catch (Exception be) { be.printStackTrace(); result =
	 * "Some Internal Error!"; } response.getWriter().write(result); }
	 * 
	 * public String addPage() { CommonMethodController controller =
	 * CommonMethodController .getInstance(); Map<Integer, String> varMap = new
	 * HashMap<Integer, String>();
	 * 
	 * try { if (!"".equals(jsonObjVariableId)) { Gson gson = new Gson(); Type
	 * type = new TypeToken<Map<Integer, String>>() { }.getType(); varMap =
	 * gson.fromJson(jsonObjVariableId, type); } cmsController = new
	 * CmsController(); PortalPageLinkBean portalPageLinkBean; pageLinkList =
	 * new ArrayList<PortalPageLinkBean>(); PlaceHolderBean placeHolderBean =
	 * null; List<PlaceHolderBean> placeHolderBeans = null; String phLangCode =
	 * null; String contentName = null; portalPageLinkBean = new
	 * PortalPageLinkBean(); portalPageLinkBean.setContentName(pageName);
	 * portalPageLinkBean.setDescription(pageDescription);
	 * portalPageLinkBean.setDomainId(domainId);
	 * portalPageLinkBean.setAliasId(aliasId);
	 * portalPageLinkBean.setPageType(pageType);
	 * portalPageLinkBean.setDevice(device); portalPageLinkBean.setUrl(pageUrl);
	 * if (pageType.equals("LANDING_PAGE")) { if ("PC".equals(device))
	 * portalPageLinkBean.setIsCommonCSS(isCommonCSS);
	 * portalPageLinkBean.setIsCustomCSS(isCustomCSS); portalPageLinkBean
	 * .setSpecificCssId(specificCssId.equals(-1) ? null : specificCssId);
	 * portalPageLinkBean.setIsPostLogin("N");
	 * portalPageLinkBean.setIsPreLogin("Y");
	 * portalPageLinkBean.setStatus(status); } phLangCode =
	 * controller.fetchLanguageMasterBean(language) .getLanguageBaseCode();
	 * portalPageLinkBean.setLanguage(language); contentName = pageName +
	 * ".jsp"; Document dc = Jsoup.parse(content); Elements elements =
	 * dc.select("div[id$=widgetDiv]"); StDmDomainAliasNameMaster aliasMas =
	 * CommonMethodController .getInstance().getAliasMaster(aliasId); String
	 * domainName = aliasMas.getDomainMaster().getDomainName(); String aliasName
	 * = aliasMas.getAliasName(); for (Element element : elements) { Elements
	 * childEles = element.select("div[id$=widgetDiv]"); if (childEles.size() >
	 * 1) { element.replaceWith(childEles.last()); } String widgetName =
	 * element.attr("widget_name"); String widgetType =
	 * element.attr("widget_type"); String layout =
	 * controller.fetchAliasLayout(aliasId, device.toLowerCase());
	 * element.html("<s:include value=\"/portalContent/" + domainName + "/" +
	 * aliasName + "/" + layout + "/" + device.toLowerCase() + "/LR/" +
	 * widgetType + "/eng/" + widgetName + ".jsp\"></s:include>"); } content =
	 * dc.getElementsByTag("body").get(0).html(); content =
	 * content.replace(" /s:property", "></s:property>"); content =
	 * content.replace(" s:property", "<s:property"); content =
	 * content.replace(">s:property", "><s:property");
	 * 
	 * Static/Landing Page
	 * 
	 * if (pageType.contains("PAGE")) { StringBuilder headTag = new
	 * StringBuilder(
	 * "<%@ page language=\"java\" import=\"java.util.*\" pageEncoding=\"UTF-8\"%>\n<%@taglib prefix=\"s\" uri=\"/struts-tags\"%>\n<html><head><title>"
	 * + pageTitle + "</title>"); if ("LANDING_PAGE".equals(pageType) &&
	 * specificCssPath != null && !"".equals(specificCssPath)) { headTag.
	 * append("<link href=\"<%= request.getParameter(\"cssServerPath\")%>" +
	 * specificCssPath + "\" rel=\"stylesheet\" type=\"text/css\"/>"); } if
	 * (metaContents != null && metaNames != null) for (int l = 0; l <
	 * metaContents.length; l++) { if (!"".equals(metaNames[l]))
	 * headTag.append("<meta name=\"") .append(metaNames[l])
	 * .append("\" content=\"") .append(metaContents[l]).append("\" />"); } if
	 * (linkHrefs != null) for (int l = 0; l < linkHrefs.length; l++) { if
	 * (!"".equals(linkHrefs[l])) headTag.append("<link href=\"")
	 * .append(linkHrefs[l]).append("\" rel=\"")
	 * .append(linkRels[l]).append("\" type=\"")
	 * .append(linkTypes[l]).append("\" />"); } headTag.append("</head><body>");
	 * headTag.append(content).append("</body></html>");
	 * Utility.saveOrUpdateContent( headTag.toString(), contentName,
	 * getContentPath(controller, domainName, aliasName, "LR", phLangCode));
	 * portalPageLinkBean.setUrl(contentUrl); if
	 * (!(pageType.equals("LANDING_PAGE"))) {
	 * portalPageLinkBean.setIsPostLogin(isPostLogin);
	 * portalPageLinkBean.setIsPreLogin(isPreLogin); }
	 * portalPageLinkBean.setIsLink(isLink); if (phHeight != null) {
	 * placeHolderBeans = new ArrayList<PlaceHolderBean>(); for (int k = 0; k <
	 * phHeight.length; k++) { if (phCode[k].contains("_" +
	 * portalPageLinkBean.getLanguage())) { placeHolderBean = new
	 * PlaceHolderBean(); placeHolderBean.setHeight(phHeight[k]);
	 * placeHolderBean.setWidth(phWidth[k]); placeHolderBean.setName(phName[k]);
	 * placeHolderBean.setPlaceHolderCode(phCode[k]);
	 * placeHolderBean.setLanguageCode(phLangCode);
	 * placeHolderBeans.add(placeHolderBean); } }
	 * portalPageLinkBean.setPlaceHolderBeans(placeHolderBeans); } } else if
	 * ("SMS".equals(pageType) || "EMAIL".equals(pageType)) {
	 * tmpltBean.setMode(pageType); portalPageLinkBean.setTmpBean(tmpltBean);
	 * StringBuilder headTag = new StringBuilder(
	 * "<%@ page language=\"java\" import=\"java.util.*\" pageEncoding=\"UTF-8\"%>\n<%@taglib prefix=\"s\" uri=\"/struts-tags\"%>\n<html><head><title>"
	 * + pageTitle + "</title>"); headTag.append("</head><body>");
	 * headTag.append(content).append("</body></html>"); String str[] =
	 * (varMap.containsKey((Integer) 0)) ? varMap.get( (Integer) 0).split("\\|")
	 * : new String[0]; String strStrutsTag = headTag.toString(); for (String
	 * string : str) { String rplceValue = string.split("\\:")[0]; String
	 * varCode = string.split("\\:")[1]; strStrutsTag =
	 * strStrutsTag.replace(rplceValue,
	 * "<s:property value=\"%{variableEmailMap." + varCode +
	 * "}\"></s:property>"); } Utility.saveOrUpdateContent( strStrutsTag,
	 * contentName, getContentPath(controller, domainName, aliasName, "LR",
	 * phLangCode)); Utility.saveOrUpdateContent(
	 * headTag.toString().replaceAll("<%@(?:.*)%>", ""), pageName + ".html",
	 * getContentPath(controller, domainName, aliasName, "LR", phLangCode));
	 * contentName = pageName; } else { contentHeight = new
	 * Integer(contentSize.split("X")[1]); contentWidth = new
	 * Integer(contentSize.split("X")[0]);
	 * portalPageLinkBean.setContentHeight(contentHeight);
	 * portalPageLinkBean.setContentWidth(contentWidth);
	 * 
	 * Place Holder Client
	 * 
	 * if (pageType.contains("CLIENT")) { contentName = pageName + "_" +
	 * Calendar.getInstance().getTimeInMillis() + "." +
	 * contentFileFileName.split("\\.")[1]; Utility.saveOrUpdateContent(
	 * contentFile, contentName, getStaticContentPath(controller, domainName,
	 * aliasName, "default", "LR", phLangCode)); } else {
	 * Utility.saveOrUpdateContent( content, contentName,
	 * getContentPath(controller, domainName, aliasName, "LR", phLangCode)); }
	 * 
	 * } portalPageLinkBean.setPath(contentName);
	 * pageLinkList.add(portalPageLinkBean); cmsController.addPage(pageLinkList,
	 * pageType, userInfoBean.getUserId()); } catch (Exception e) {
	 * e.printStackTrace(); return ERROR; } return SUCCESS; }
	 * 
	 * public String uploadBanner() {
	 * 
	 * cmsController = new CmsController(); CommonMethodController controller =
	 * CommonMethodController .getInstance(); UploadBannerBean bannerBean = new
	 * UploadBannerBean(); try { String staticPath = new String(
	 * controller.fetchSystemProperties("DEFAULT_CONTENT_PATH")) .toString();
	 * bannerBean.setDomainId(domainId); bannerBean.setBannerName(bannerName);
	 * bannerBean.setBannerDescrip(bannerDescrip);
	 * bannerBean.setBannerType(bannerType);
	 * bannerBean.setBannerContext(bannerContext);
	 * bannerBean.setRelatedCampaign(relatedCampaign);
	 * 
	 * File dir = new File(staticPath + "Banner"); if (!dir.exists()) {
	 * dir.mkdirs(); } File file = new File(dir, bannerName + ".html"); if
	 * (!file.exists()) { file.createNewFile(); } FileWriter out = new
	 * FileWriter(file); out.write(content); out.close();
	 * 
	 * bannerBean.setPath(staticPath + "Banner" + bannerName + ".html");
	 * 
	 * cmsController.uploadBanner(bannerBean); } catch (Exception e) {
	 * e.printStackTrace(); }
	 * 
	 * return SUCCESS;
	 * 
	 * }
	 * 
	 * public void getPages() { cmsController = new CmsController();
	 * List<PortalPageLinkBean> list = new ArrayList<PortalPageLinkBean>(); try
	 * { pageLinkList = cmsController.getContentBeanList(aliasId, pageType,
	 * language); if (pageLinkList.size() > 0) { if (device != null &&
	 * !device.equals("") && !device.equals("-1") && !pageType.equals("EMAIL"))
	 * { for (PortalPageLinkBean bean : pageLinkList) { if
	 * (bean.getDevice().equals(device)) { list.add(bean); } }
	 * list=removeUnPublishedData(pageType,list); } else { list =
	 * removeUnPublishedData(pageType,pageLinkList); }
	 * response.getWriter().write(new Utility().convertJSON(list)); } else
	 * response.getWriter().write("{}"); } catch (IOException e) {
	 * e.printStackTrace(); } catch (PMSException e) { e.printStackTrace();
	 * }catch (Exception be) { be.printStackTrace(); } }
	 * 
	 * public List<PortalPageLinkBean> removeUnPublishedData(String
	 * pageType,List<PortalPageLinkBean> pageLinkList){ List<PortalPageLinkBean>
	 * list = new ArrayList<PortalPageLinkBean>();
	 * 
	 * if(pageType.equals("LANDING_PAGE") || pageType.contains("PLACE_HOLDER")){
	 * for (PortalPageLinkBean bean : pageLinkList) {
	 * if(bean.getStatus().equals("PUBLISHED")) list.add(bean); } }else list =
	 * pageLinkList; return list; }
	 * 
	 * public String getPageDetails() { String params = null;
	 * List<PortalPageLinkBean> list = new ArrayList<PortalPageLinkBean>(); try
	 * { cmsController = new CmsController(); pageDetailBean =
	 * cmsController.getPageDetails(contentId, pageType); if
	 * ("PLACE_HOLDER_CLIENT".equals(pageType) && pageDetailBean != null &&
	 * pageDetailBean.getPath() != null) { String urlArray[] =
	 * pageDetailBean.getPath().split("\\|"); if (urlArray.length > 1) {
	 * if(urlArray[1].contains("khelplayRummy")) setPageTypeClient("Android");
	 * else if(urlArray[1].contains("khelplay")) setPageTypeClient("iOS"); else
	 * setPageTypeClient(cmsController.getPHClientPageType( aliasId, device,
	 * urlArray[1], language)); if(!(urlArray[1].contains("khelDeepLink"))){
	 * pageLinkList = cmsController.getContentBeanList(aliasId, pageTypeClient,
	 * language); if (pageLinkList.size() > 0) { for (PortalPageLinkBean bean :
	 * pageLinkList) { if (bean.getDevice().equals(device)) { list.add(bean); }
	 * } } setPageLinkList(list); }
	 * 
	 * setPageUrl((urlArray[1])); } } CommonMethodController controller =
	 * CommonMethodController .getInstance(); domainCssMap =
	 * cmsController.getAliasSpecificCss(aliasId); domainCssStr=new
	 * Utility().convertJSON(domainCssMap); StDmDomainAliasNameMaster aliasMas =
	 * controller .getAliasMaster(aliasId); String domainName =
	 * aliasMas.getDomainMaster().getDomainName(); String aliasName =
	 * aliasMas.getAliasName(); defaultContentPath = controller
	 * .fetchSystemProperties("DEFAULT_CONTENT_PATH"); editorCss = ""; if
	 * ("Y".equals(pageDetailBean.getIsCommonCSS())) { editorCss =
	 * defaultContentPath + "css/default/pc/LR/common.css,"; } if
	 * ("Y".equals(pageDetailBean.getIsCustomCSS())) { editorCss = editorCss +
	 * defaultContentPath + domainName + "/" + aliasName +
	 * "/default/pc/LR/css/custom.css,"; } if (pageDetailBean.getSpecificCssId()
	 * != null) { specificCssPath = domainCssMap != null ? domainCssMap.get(
	 * pageDetailBean.getSpecificCssId()).getCssPath() : null; editorCss =
	 * editorCss + defaultContentPath + domainName + "/" + aliasName +
	 * "/default/pc/LR/css/" + specificCssPath; } if (pageDetailBean != null &&
	 * !pageType.contains("CLIENT")) { if
	 * ("BYDEFAULT".equals(aliasMas.getContentList())) { aliasId = 1; aliasMas =
	 * controller.getAliasMaster(aliasId); domainName =
	 * aliasMas.getDomainMaster().getDomainName(); aliasName =
	 * aliasMas.getAliasName(); } StringBuilder portalPath = new StringBuilder(
	 * controller .fetchSystemProperties("DEFAULT_CONTENT_PATH"));
	 * portalPath.append(domainName); portalPath.append("/");
	 * portalPath.append(aliasName); portalPath.append("/");
	 * portalPath.append(controller.fetchAliasLayout(aliasId, device));
	 * portalPath.append("/"); portalPath.append(device.toLowerCase());
	 * portalPath.append("/"); portalPath.append("LR"); portalPath.append("/");
	 * portalPath.append(pageType.toLowerCase()); portalPath.append("/");
	 * portalPath.append(controller.fetchLanguageMasterBean(language)
	 * .getLanguageBaseCode()); portalPath.append("/");
	 * portalPath.append(pageDetailBean.getPath()); String str =
	 * Utility.callUrl(portalPath.toString(), params); String plainStr =
	 * str.toString().replaceAll("<%@(?:.*)%>", "") .replace("<s:property",
	 * " s:property") .replace("></s:property>", " /s:property") .replace("'",
	 * "\\'").replace("<script", "<!--<script") .replace("</script>",
	 * "</script>-->"); if (!"PLACE_HOLDER_WEB".equals(pageType)) { Document dc
	 * = Jsoup.parse(plainStr); Elements elements =
	 * dc.select("div[id$=widgetDiv]"); for (Element element : elements) {
	 * element.html(element.attr("widget_name")); }
	 * setPageTitle(dc.getElementsByTag("title").get(0).text() .replace("\n",
	 * "").replace("\\'", "'"));
	 * 
	 * Elements metaNL = dc.getElementsByTag("meta"); metaNames = new
	 * String[metaNL.size()]; metaContents = new String[metaNL.size()]; int tmp;
	 * for (tmp = 0; tmp < metaNL.size(); tmp++) { metaNames[tmp] =
	 * metaNL.get(tmp).attr("name"); metaContents[tmp] =
	 * metaNL.get(tmp).attr("content"); }
	 * 
	 * Elements linkNL = dc.getElementsByTag("link"); linkHrefs = new
	 * String[linkNL.size()]; linkRels = new String[linkNL.size()]; linkTypes =
	 * new String[linkNL.size()]; for (tmp = 0; tmp < linkNL.size(); tmp++) { if
	 * (!"stylesheet".equals(linkNL.get(tmp).attr("rel"))) { linkHrefs[tmp] =
	 * linkNL.get(tmp).attr("href"); linkRels[tmp] =
	 * linkNL.get(tmp).attr("rel"); linkTypes[tmp] =
	 * linkNL.get(tmp).attr("type"); } }
	 * 
	 * String str1 = dc.getElementsByTag("body").get(0).html();
	 * 
	 * pageDetailBean.setPageHTML(str1.replace("\n", "").replace( "\\'", "'"));
	 * } else { pageDetailBean.setPageHTML(plainStr.toString() .replace("\n",
	 * "").replace("\\'", "'")); } }
	 * 
	 * } catch (PMSException e) { e.printStackTrace(); } catch (Exception e) {
	 * e.printStackTrace(); } finally { pageLoadVariables(); }
	 * 
	 * return SUCCESS; }
	 * 
	 * public void editPageSave() throws IOException{
	 * 
	 * Map<Integer, String> varMap = new HashMap<Integer, String>(); if
	 * (!"".equals(jsonObjVariableId)) { Gson gson = new Gson(); Type type = new
	 * TypeToken<Map<Integer, String>>() { }.getType(); varMap =
	 * gson.fromJson(jsonObjVariableId, type); } CommonMethodController
	 * controller = CommonMethodController .getInstance(); cmsController = new
	 * CmsController();
	 * 
	 * try { PortalPageLinkBean portalPageLinkBean = new PortalPageLinkBean();
	 * // String domainName = controller.getDmProperty(domainId, //
	 * "domainName"); PlaceHolderBean placeHolderBean = null;
	 * List<PlaceHolderBean> placeHolderBeans = null; String phLangCode = null;
	 * portalPageLinkBean = new PortalPageLinkBean();
	 * portalPageLinkBean.setContentName(pageName);
	 * portalPageLinkBean.setDescription(pageDescription);
	 * portalPageLinkBean.setDomainId(domainId);
	 * portalPageLinkBean.setAliasId(aliasId);
	 * portalPageLinkBean.setPageType(pageType);
	 * portalPageLinkBean.setContentId(contentId);
	 * portalPageLinkBean.setDevice(device); portalPageLinkBean.setUrl(pageUrl);
	 * if (pageType.equals("LANDING_PAGE")) { if ("PC".equals(device))
	 * portalPageLinkBean.setIsCommonCSS(isCommonCSS);
	 * portalPageLinkBean.setIsCustomCSS(isCustomCSS); portalPageLinkBean
	 * .setSpecificCssId(specificCssId.equals(-1) ? null : specificCssId);
	 * portalPageLinkBean.setIsPreLogin("Y");
	 * portalPageLinkBean.setIsPostLogin("N");
	 * portalPageLinkBean.setStatus(status); } phLangCode =
	 * controller.fetchLanguageMasterBean(language) .getLanguageBaseCode();
	 * portalPageLinkBean.setLanguage(language); String contentName = null;
	 * StDmDomainAliasNameMaster aliasMas = CommonMethodController
	 * .getInstance().getAliasMaster(aliasId); String domainName =
	 * aliasMas.getDomainMaster().getDomainName(); String aliasName =
	 * aliasMas.getAliasName(); contentName = pageName + "." +
	 * (pageType.contains("CLIENT") ? FilenameUtils
	 * .getExtension(contentFileFileName) : "jsp"); Document dc =
	 * Jsoup.parse(content); Elements elements =
	 * dc.select("div[id$=widgetDiv]"); for (Element element : elements) {
	 * Elements childEles = element.select("div[id$=widgetDiv]"); if
	 * (childEles.size() > 1) { element.replaceWith(childEles.last()); } String
	 * widgetName = element.attr("widget_name"); String widgetType =
	 * element.attr("widget_type"); String layout =
	 * controller.getDeviceLayout(domainId, device.toLowerCase());
	 * element.html("<s:include value=\"/portalContent/" + domainName + "/" +
	 * aliasName + "/" + layout + "/" + device.toLowerCase() + "/LR/" +
	 * widgetType + "/eng/" + widgetName + ".jsp\"></s:include>"); } content =
	 * dc.getElementsByTag("body").get(0).html(); content =
	 * content.replace(" /s:property", "></s:property>"); content =
	 * content.replace(" s:property", "<s:property"); content =
	 * content.replace(">s:property", "><s:property"); content =
	 * content.replace("<!--<script", "<script"); content =
	 * content.replace("</script>-->", "</script>");
	 * 
	 * Static/Landing Page
	 * 
	 * if (pageType.contains("PAGE")) { StringBuilder headTag = new
	 * StringBuilder(
	 * "<%@ page language=\"java\" import=\"java.util.*\" pageEncoding=\"UTF-8\"%>\n<%@taglib prefix=\"s\" uri=\"/struts-tags\"%>\n<html><head><title>"
	 * + pageTitle + "</title>"); if ("LANDING_PAGE".equals(pageType) &&
	 * specificCssPath != null && !"".equals(specificCssPath)) { headTag.
	 * append("<link href=\"<%= request.getParameter(\"cssServerPath\")%>" +
	 * specificCssPath + "\" rel=\"stylesheet\" type=\"text/css\"/>"); } if
	 * (metaContents != null && metaNames != null) for (int l = 0; l <
	 * metaContents.length; l++) { if (!"".equals(metaNames[l]))
	 * headTag.append("<meta name=\"") .append(metaNames[l])
	 * .append("\" content=\"") .append(metaContents[l]).append("\" />"); } if
	 * (linkHrefs != null) for (int l = 0; l < linkHrefs.length; l++) { if
	 * (!"".equals(linkHrefs[l]) && !"stylesheet".equals(linkRels[l]))
	 * headTag.append("<link href=\"") .append(linkHrefs[l]).append("\" rel=\"")
	 * .append(linkRels[l]).append("\" type=\"")
	 * .append(linkTypes[l]).append("\" />"); } headTag.append("</head><body>");
	 * headTag.append(content).append("</body></html>");
	 * Utility.saveOrUpdateContent( headTag.toString(), contentName,
	 * getContentPath(controller, domainName, aliasName, "LR", phLangCode)); if
	 * (!(pageType.equals("LANDING_PAGE"))) {
	 * portalPageLinkBean.setIsPostLogin(isPostLogin);
	 * portalPageLinkBean.setIsPreLogin(isPreLogin); }
	 * portalPageLinkBean.setIsLink(isLink); if (phHeight != null) {
	 * placeHolderBeans = new ArrayList<PlaceHolderBean>(); for (int k = 0; k <
	 * phHeight.length; k++) { placeHolderBean = new PlaceHolderBean();
	 * placeHolderBean.setHeight(phHeight[k]);
	 * placeHolderBean.setWidth(phWidth[k]); placeHolderBean.setName(phName[k]);
	 * placeHolderBean.setPlaceHolderCode(phCode[k]);
	 * placeHolderBean.setLanguageCode(phLangCode);
	 * placeHolderBeans.add(placeHolderBean); }
	 * portalPageLinkBean.setPlaceHolderBeans(placeHolderBeans); } } else if
	 * ("SMS".equals(pageType) || "EMAIL".equals(pageType)) {
	 * tmpltBean.setMode(pageType); portalPageLinkBean.setTmpBean(tmpltBean);
	 * 
	 * StringBuilder headTag = new StringBuilder(
	 * "<%@ page language=\"java\" import=\"java.util.*\" pageEncoding=\"UTF-8\"%>\n<%@taglib prefix=\"s\" uri=\"/struts-tags\"%>\n<html><head><title>"
	 * + pageTitle + "</title>"); headTag.append("</head><body>");
	 * headTag.append(content).append("</body></html>"); String str[] =
	 * (varMap.containsKey((Integer) 0)) ? varMap.get( (Integer) 0).split("\\|")
	 * : new String[0]; String strStrutsTag = headTag.toString(); for (String
	 * string : str) { String rplceValue = string.split("\\:")[0]; String
	 * varCode = string.split("\\:")[1]; strStrutsTag =
	 * strStrutsTag.replace(rplceValue,
	 * "<s:property value=\"%{variableEmailMap." + varCode +
	 * "}\"></s:property>"); } Utility.saveOrUpdateContent( strStrutsTag,
	 * contentName, getContentPath(controller, domainName, aliasName, "LR",
	 * phLangCode)); Utility.saveOrUpdateContent(
	 * headTag.toString().replaceAll("<%@(?:.*)%>", ""), pageName + ".html",
	 * getContentPath(controller, domainName, aliasName, "LR", phLangCode));
	 * contentName = pageName; } else {
	 * portalPageLinkBean.setContentHeight(contentHeight);
	 * portalPageLinkBean.setContentWidth(contentWidth);
	 * portalPageLinkBean.setStatus(status);
	 * 
	 * Place Holder Client
	 * 
	 * String pagePath = null; if (pageType.contains("CLIENT")) { contentName =
	 * pageName + "_" + Calendar.getInstance().getTimeInMillis() + "." +
	 * FilenameUtils.getExtension(contentFileFileName); pagePath =
	 * getStaticContentPath(controller, domainName, aliasName, "default", "LR",
	 * phLangCode); } else { pagePath = getContentPath(controller, domainName,
	 * aliasName, "LR", phLangCode); } if (contentFile != null) {
	 * Utility.saveOrUpdateContent(contentFile, contentName, pagePath); } else
	 * if (content != null) { Utility.saveOrUpdateContent(content, contentName,
	 * pagePath); } else { response.getWriter().write(
	 * "Don't Have File/Content For Uploading"); } }
	 * 
	 * portalPageLinkBean.setPath(contentName);
	 * cmsController.editContentPageSave(portalPageLinkBean,
	 * userInfoBean.getUserId()); response.getWriter().write("SUCCESS"); } catch
	 * (Exception e) { e.printStackTrace();
	 * response.getWriter().write(e.getMessage()); } }
	 * 
	 * public void getPageNames() { cmsController = new CmsController(); Gson
	 * gson = new Gson(); PrintWriter out = null; try { out =
	 * response.getWriter(); List<PortalUrlDetailBean> result = cmsController
	 * .getPageNames(domainId); pageNameList = gson.toJson(result);
	 * out.write(pageNameList); } catch (Exception e) { e.printStackTrace(); }
	 * 
	 * }
	 * 
	 * public void getPixelGaContent() { cmsController = new CmsController();
	 * String path = null; PrintWriter out = null; BufferedReader input; try {
	 * out = response.getWriter(); PortalUrlTrackingBean portalUrlTrackingBean =
	 * new PortalUrlTrackingBean(); portalUrlTrackingBean.setDomainId(domainId);
	 * portalUrlTrackingBean.setScriptFor(scriptFor);
	 * portalUrlTrackingBean.seturlId(urlId); path =
	 * cmsController.getPixelGaPath(portalUrlTrackingBean); if (path != null) {
	 * CommonMethodController controller = CommonMethodController
	 * .getInstance(); input = new BufferedReader(new FileReader( controller
	 * .fetchSystemProperties("DEFAULT_CONTENT_PATH") + path)); String line =
	 * ""; String str1 = ""; if (input != null) { while ((line =
	 * input.readLine()) != null) { str1 = str1 + line; } input.close(); content
	 * = str1; } } else { content = ""; } out.write(content); } catch (Exception
	 * e) { e.printStackTrace(); out.write(e.getMessage()); }
	 * 
	 * }
	 * 
	 * public String saveScript() { cmsController = new CmsController();
	 * PortalUrlTrackingBean portalUrlTrackingBean = new
	 * PortalUrlTrackingBean(); CommonMethodController controller =
	 * CommonMethodController .getInstance(); try { String domainName =
	 * CommonMethodController.getInstance() .getDmProperty(domainId,
	 * "domainName"); portalUrlTrackingBean.setDomainId(domainId);
	 * portalUrlTrackingBean.seturlId(urlId);
	 * portalUrlTrackingBean.setScriptFor(scriptFor); File dir = new File(
	 * controller.fetchSystemProperties("DEFAULT_CONTENT_PATH") +
	 * "trackingScript/" + domainName); if (!dir.exists()) { dir.mkdirs(); }
	 * File file = new File(dir, scriptFor.replace(" ", "") + "_" + urlId +
	 * ".js"); if (!file.exists()) { file.createNewFile(); } FileWriter out =
	 * new FileWriter(file); out.write(content); out.close();
	 * 
	 * portalUrlTrackingBean.setJsPath("/trackingScript/" + domainName + "/" +
	 * scriptFor.replace(" ", "") + "_" + urlId + ".js"); } catch (Exception e)
	 * { e.printStackTrace(); addActionError("Some Internal Error!"); return
	 * "exception"; }
	 * 
	 * return SUCCESS;
	 * 
	 * }
	 * 
	 * public void fetchPlaceHolderPagesList() { Gson gson = new Gson();
	 * cmsController = new CmsController(); PrintWriter out = null; try {
	 * List<PlaceHolderPageNameBean> result = cmsController
	 * .fetchPHPageList(aliasId, device, pageType); placeHolderPages =
	 * gson.toJson(result); out = response.getWriter();
	 * out.write(placeHolderPages); } catch (Exception e) { e.printStackTrace();
	 * } }
	 * 
	 * public String fetchPlaceHolderDetails() { cmsController = new
	 * CmsController(); try { Map<Integer, String> phCritMap = cmsController
	 * .fetchPHCriterias(aliasId); reDirectPage=new HashMap<String, String>();
	 * if(device.equals("PC")){ List<JoomlaClientLandingPageBean>
	 * pageList=cmsController.fetchClientLandingPage(aliasId); for
	 * (JoomlaClientLandingPageBean joomlaClientLandingPageBean : pageList) {
	 * reDirectPage.put(joomlaClientLandingPageBean.getMenuname(),
	 * joomlaClientLandingPageBean.getPublicUrl().split(".com/")[1]); } }else
	 * if(device.equals("MOBILE")){ reDirectPage.put("Login",
	 * "khelplayRummy://khelDeepLink/login"); reDirectPage.put("Deposit",
	 * "khelplayRummy://khelDeepLink/deposit");
	 * reDirectPage.put("Refer A Friend",
	 * "khelplayRummy://khelDeepLink/referAFriend");
	 * 
	 * 
	 * } placeHolderDetailMap = cmsController.fetchPHDetails(aliasId, urlId,
	 * pageType,device, deviceOS, phCritMap); phCrit = new
	 * Gson().toJson(phCritMap); } catch (Exception e) { e.printStackTrace();
	 * return ERROR; }
	 * 
	 * return SUCCESS; }
	 * 
	 * public void fetchPlaceHolderPreview() { PrintWriter out = null;
	 * BufferedReader input; String previewData = ""; String str1 = "";
	 * CommonMethodController controller = CommonMethodController
	 * .getInstance(); try { String defaultPath =
	 * controller.fetchSystemProperties( "DEFAULT_CONTENT_PATH").toString(); out
	 * = response.getWriter(); input = new BufferedReader(new
	 * FileReader(defaultPath + "/" + pagePath)); String line = ""; if (input !=
	 * null) { while ((line = input.readLine()) != null) { str1 = str1 + line; }
	 * previewData = str1.replaceAll("&lt;", "<").replaceAll("&gt;", ">"); }
	 * input = new BufferedReader( new FileReader(defaultPath + contentPath));
	 * line = ""; str1 = ""; if (input != null) { while ((line =
	 * input.readLine()) != null) { str1 = str1 + line; } input.close();
	 * str1.replaceAll("&lt;", "<").replaceAll("&gt;", ">"); previewData =
	 * previewData.replace(phCode[0], str1); out.write(previewData); } } catch
	 * (Exception e) { log.error("Exception----" + e); out.write("error"); } }
	 * 
	 * public String submitPlaceHolder() { try { pageType =
	 * "STATIC_PAGE".equals(pageType) ? "STATIC" :
	 * "EXTERNAL_LOBBY".equals(pageType) ? "CLIENT" : pageType; new
	 * CmsController().savePlaceHolderMappingDetails(phCtBean, pageType); }
	 * catch (Exception e) { e.printStackTrace();
	 * addActionError("Some Internal Error!"); return "exception"; } return
	 * SUCCESS; }
	 * 
	 * public void fetchContentType() { try { response.getWriter().write(
	 * CommonMethodController.getInstance() .getAliasPropertyMap(aliasId,
	 * "contentType") .get("contentType")); } catch (Exception e) {
	 * e.printStackTrace(); } }
	 * 
	 * public void fetchLandingPageDetail() { try { CmsController cmsController
	 * = new CmsController(); String contentUrl = cmsController.getURL(aliasId,
	 * "LANDING_PAGE_URL"); if(contentUrl==null) { Map<Integer, String>
	 * landingPageDetail = new CmsController() .fetchLandingPageMap(aliasId,
	 * device); Gson gson = new Gson(); String landingPageDetailString =
	 * gson.toJson(landingPageDetail);
	 * response.getWriter().write(landingPageDetailString); } else { URL
	 * conatctURL = new URL(contentUrl); URLConnection myURLConn =
	 * conatctURL.openConnection(); myURLConn.connect(); BufferedReader
	 * BuffReader = new BufferedReader( new
	 * InputStreamReader(myURLConn.getInputStream())); StringBuilder stb = new
	 * StringBuilder(); String result = null; while ((result =
	 * BuffReader.readLine()) != null) { stb.append(result); }
	 * response.getWriter().write(stb.toString()); } } catch (IOException e) {
	 * e.printStackTrace(); } catch (Exception e) { e.printStackTrace(); } }
	 * 
	 * public String getLandingPageDetails() { if (domainId > 1) { try {
	 * CmsController cmsController = new CmsController(); landingPages =
	 * cmsController.fetchLandingPageMap(aliasId, "PC"); } catch (Exception e) {
	 * e.printStackTrace(); } } return SUCCESS; }
	 * 
	 * public String submitCampDetail() { try { CampaignBean camp = new
	 * CampaignBean(); camp.setDomainId(domainId); camp.setAliasId(aliasId);
	 * camp.setCampaignName(campName); camp.setCampaignType(campType);
	 * camp.setCampParams(campParams); camp.setDevice(device); Gson gson = new
	 * GsonBuilder().setDateFormat("dd/MM/yyyy hh:mm:ss") .create(); Type type =
	 * new TypeToken<List<CampaignDetailBean>>() { }.getType();
	 * List<CampaignDetailBean> campDetailList = gson.fromJson(
	 * campDetailString, type); camp.setCampDetailList(campDetailList);
	 * CmsController controller = new CmsController(); landingPageUrlDetail =
	 * controller.submitCampaignDetail(camp); if (!"PPC".equals(campType)) {
	 * return SUCCESS; } } catch (Exception e) { e.printStackTrace();
	 * addActionError("Some Internal Error!"); return "exception"; } return
	 * "LANDING_PAGE"; }
	 * 
	 * public void fetchCampNames() { CmsController cmsController = new
	 * CmsController(); Map<Long, String> campNames =
	 * cmsController.fetchCampNameMap(aliasId, campType, device); try { Gson
	 * gson = new Gson(); String campNamesString = gson.toJson(campNames);
	 * PrintWriter out = response.getWriter(); out.write(campNamesString); }
	 * catch (IOException e) { e.printStackTrace(); }catch (Exception be) {
	 * be.printStackTrace(); } }
	 * 
	 * public String submitEditCampDetail() { try{ CampaignBean camp = new
	 * CampaignBean(); camp.setDomainId(domainId); camp.setAliasId(aliasId);
	 * camp.setCampaignName(campName); camp.setCampaignType(campType);
	 * camp.setCampaignId(campId); camp.setCampParams(campParams);
	 * camp.setStatus(status); Gson gson = new
	 * GsonBuilder().setDateFormat("dd/MM/yyyy hh:mm:ss") .create(); Type type =
	 * new TypeToken<List<CampaignDetailBean>>() { }.getType();
	 * List<CampaignDetailBean> campDetailList = gson.fromJson(
	 * campDetailString, type); camp.setCampDetailList(campDetailList);
	 * CmsController controller = new CmsController(); landingPageUrlDetail =
	 * controller.submitEditCampaignDetail(camp); }catch(Exception ex){
	 * ex.printStackTrace(); addActionError(ex.getMessage()); return
	 * "exception"; } return SUCCESS; } public String fetchCampDetail() {
	 * CmsController cmsController = new CmsController(); try {
	 * campaignDetailBean = cmsController.fetchCampDetail(campId);
	 * aliascontentType =
	 * CommonMethodController.getInstance().getAliasPropertyMap(aliasId,
	 * "contentType").get("contentType");
	 * if("PortalContent".equalsIgnoreCase(aliascontentType)){ landingPageDetail
	 * = cmsController.fetchLandingPageMap(aliasId, device);
	 * landingPageDetailStr=new Utility().convertJSON(landingPageDetail); } else
	 * { String contentUrl = cmsController.getURL(aliasId, "LANDING_PAGE_URL");
	 * log.info("=================> url   "+ contentUrl); URL conatctURL = new
	 * URL(contentUrl); URLConnection myURLConn = conatctURL.openConnection();
	 * myURLConn.connect(); BufferedReader BuffReader = new BufferedReader( new
	 * InputStreamReader(myURLConn.getInputStream())); StringBuilder stb = new
	 * StringBuilder(); String result = null; while ((result =
	 * BuffReader.readLine()) != null) { stb.append(result); } JSONObject
	 * jsonObj = (JSONObject)new JSONParser().parse(stb.toString()); String
	 * errorCode = jsonObj.get("errorCode").toString();
	 * if("0".equals(errorCode)) { JSONArray jsonArr =
	 * (JSONArray)jsonObj.get("pages"); Type type = new
	 * TypeToken<List<JoomlaLandingPages>>() {}.getType(); joomlaCtBean = new
	 * Gson().fromJson(jsonArr.toString(), type); } } } catch (PMSException e) {
	 * e.printStackTrace(); return ERROR; } catch (Exception e) {
	 * e.printStackTrace(); return ERROR; } return SUCCESS; }
	 * 
	 * public String createStaticPage() { try { CommonMethodController
	 * controller = CommonMethodController .getInstance(); defaultContentPath =
	 * controller .fetchSystemProperties("DEFAULT_CONTENT_PATH"); }catch
	 * (PMSException e) { e.printStackTrace();
	 * addActionError(e.getErrorMessage()); return "exception"; } catch
	 * (Exception e) { e.printStackTrace(); addActionError(e.getMessage());
	 * return "exception"; } return SUCCESS; }
	 * 
	 * public void fetchCustomCSSDetail() { CommonMethodController controller =
	 * CommonMethodController .getInstance(); try { PrintWriter out =
	 * response.getWriter(); String defaultContentPath = controller
	 * .fetchSystemProperties("DEFAULT_CONTENT_PATH"); String customCSSpath =
	 * defaultContentPath + "css/" + controller.getDmProperty(domainId,
	 * "domainName") + "/" + device + "/custom.css"; BufferedReader input = new
	 * BufferedReader(new InputStreamReader( new
	 * URL(customCSSpath).openStream())); String line = ""; String str1 = ""; if
	 * (input != null) { while ((line = input.readLine()) != null) { str1 = str1
	 * + line; } input.close(); str1 = str1.replaceAll("&lt;",
	 * "<").replaceAll("&gt;", ">") .replaceAll("&nbsp;", "").replaceAll("<br>",
	 * ""); } out.write(str1); } catch (Exception e) { e.printStackTrace(); } }
	 * 
	 * public String submitCustomCSSDetail() { CommonMethodController controller
	 * = CommonMethodController .getInstance(); try { String
	 * staticContentDefaultPath = controller.fetchSystemProperties(
	 * "DEFAULT_CONTENT_PATH").toString(); String pagePath =
	 * staticContentDefaultPath + "css" + "|" +
	 * controller.getDmProperty(domainId, "domainName") + "|" + device; File dir
	 * = new File(pagePath); if (!dir.exists()) { dir.mkdirs(); } File file =
	 * new File(dir, "custom.css"); if (!file.exists()) { file.createNewFile();
	 * } FileWriter out = new FileWriter(file); out.write(cssDetail);
	 * out.close(); } catch (Exception e) { e.printStackTrace(); } return
	 * SUCCESS; }
	 * 
	 * public void validate() { try{ String actionName = (String)
	 * ActionContext.getContext().getContextMap()
	 * .get(ActionContext.ACTION_NAME); if
	 * ("st_pms_page_addPage".equals(actionName)) { if (pageName != null) if
	 * (!UserValidation.isAlphanumeric(pageName.trim(), false)) {
	 * addFieldError("pageName", "Page Name can be alphanumeric only."); }
	 * 
	 * if (pageType.contains("PAGE")) { if
	 * (!UserValidation.isValidURL(contentUrl.trim())) {
	 * addFieldError("contentUrl", "Page URL can be alphabetic only."); } } if
	 * (!pageType.contains("CLIENT")) if ("".equals(content.trim())) {
	 * addFieldError("content", "Page HTML is not found."); } } else if
	 * ("st_pms_page_editPageSave".equals(actionName)) { if (pageName != null)
	 * if (!UserValidation.isAlphanumeric(pageName.trim(), false)) {
	 * addFieldError("pageName", "Page Name can be alphanumeric only."); } if
	 * (!pageType.contains("CLIENT")) if ("".equals(content.trim())) {
	 * addFieldError("content", "Page HTML is not found."); } } }catch(Exception
	 * x){ x.printStackTrace(); } return;
	 * 
	 * }
	 * 
	 * public void showPreview(){ CommonMethodController controller =
	 * CommonMethodController .getInstance(); HttpSession session =
	 * request.getSession(); String fileName = ""; try { Map<String, String>
	 * propMap = controller.getDmPropertyMap(domainId, "domainName", "template",
	 * "contentList"); String contentType = propMap
	 * .get((pageType.contains("SMS") || pageType .contains("EMAIL")) ?
	 * "template" : "contentList"); if ("BYDEFAULT".equals(contentType)) {
	 * domainId = 1; domainName = controller.getDmProperty(domainId,
	 * "domainName"); } if (!pageType.equals("SMS") &&
	 * !pageType.equals("EMAIL")) { String str = (String)
	 * session.getAttribute("oldContentHead"); StringBuilder headTag = new
	 * StringBuilder(
	 * "<%@ page language=\"java\" import=\"java.util.*\" pageEncoding=\"UTF-8\"%>\n<%@taglib prefix=\"s\" uri=\"/struts-tags\"%>\n"
	 * ); headTag.append("<html><head><title>") .append(pageTitle == null ? "" :
	 * pageTitle) .append("</title>"); if ("LANDING_PAGE".equals(pageType) &&
	 * device.equals("PC")) { if (isCommonCSS.equals("Y")) { String
	 * commonCssPath = controller .fetchSystemProperties("DEFAULT_CONTENT_PATH")
	 * + "css/" + controller.getDeviceLayout(domainId, device) + "/" +
	 * device.toLowerCase() + "/" + "LR/common.css";
	 * headTag.append("<link href=").append(commonCssPath)
	 * .append(" rel='stylesheet' type='text/css'/>"); }
	 * 
	 * if(isCustomCSS.equals("Y")){ String customCssPath=controller
	 * .fetchSystemProperties("DEFAULT_CONTENT_PATH" )+propMap.get("domainName")
	 * +"/"+controller.getDeviceLayout(domainId,
	 * device)+"/"+device.toLowerCase()+"/LR/css/custom.css"; headTag
	 * .append("<link href=").append(customCssPath).append
	 * (" rel='stylesheet' type='text/css'/>"); }
	 * 
	 * } if ("LANDING_PAGE".equals(pageType) && specificCssPath != null) {
	 * headTag.
	 * append("<link href=\"<%= request.getParameter(\"cssServerPath\")%>" +
	 * specificCssPath + "\" rel='stylesheet' type='text/css'/>"); } if
	 * (metaContents != null && metaNames != null) for (int l = 0; l <
	 * metaContents.length; l++) {
	 * headTag.append("<meta name=\"").append(metaNames[l])
	 * .append("\" content=\"") .append(metaContents[l]).append("\" />"); } if
	 * (linkHrefs != null) for (int l = 0; l < linkHrefs.length; l++) {
	 * headTag.append("<link href=\"").append(linkHrefs[l])
	 * .append("\" rel=\"").append(linkRels[l])
	 * .append("\" type=\"").append(linkTypes[l]) .append("\" />"); }
	 * headTag.append((str == null) ? "" : str)
	 * .append("<script type=\"text/javascript\">$(window).bind('beforeunload', function(){var parentWin = window.opener;if(parentWin != null){parentWin.closePreview();}});</script></head><body>"
	 * ) .append(content).append("</body></html>"); content =
	 * headTag.toString(); fileName = "tmp_" +
	 * Calendar.getInstance().getTimeInMillis() + ".jsp"; } else { fileName =
	 * "tmp_" + Calendar.getInstance().getTimeInMillis() + ".html"; } if
	 * (session.getAttribute("cms-preview-name") != null) { String delfileName =
	 * (String) session .getAttribute("cms-preview-name"); Utility.callUrl(
	 * controller .fetchSystemProperties("DEFAULT_CONTENT_PATH") +
	 * "deleteTempFile", "domainName=" + propMap.get("domainName") + "/" +
	 * controller.getDeviceLayout(domainId, device) + "/" + device.toLowerCase()
	 * + "/LR/" + pageType.toLowerCase() + "&path=" + delfileName); }
	 * Utility.saveOrUpdateContent( content, fileName, propMap.get("domainName")
	 * + "|" + controller.getDeviceLayout(domainId, device) + "|" +
	 * device.toLowerCase() + "|LR|" + pageType.toLowerCase() + "|temp");
	 * session.setAttribute("cms-preview-name", fileName);
	 * response.getWriter().write(fileName); response.getWriter().write("~");
	 * response.getWriter().write(
	 * controller.fetchSystemProperties("DEFAULT_CONTENT_PATH"));
	 * response.getWriter().write("~"); response.getWriter().write(
	 * controller.getDeviceLayout(domainId, device) + "/" +
	 * device.toLowerCase()); response.getWriter().write("~");
	 * response.getWriter().write(pageType.toLowerCase()); } catch (Exception e)
	 * { e.printStackTrace(); } }
	 * 
	 * public void closePreview(){ try{ HttpSession session =
	 * request.getSession(); if (session.getAttribute("cms-preview-name") !=
	 * null) { String fileName = (String)
	 * session.getAttribute("cms-preview-name"); CommonMethodController
	 * controller = CommonMethodController .getInstance();
	 * StDmDomainAliasNameMaster aliasMaster = controller
	 * .getAliasMaster(aliasId); String domainName =
	 * aliasMaster.getDomainMaster().getDomainName(); String aliasName =
	 * aliasMaster.getAliasName(); Utility.callUrl(
	 * controller.fetchSystemProperties("DEFAULT_CONTENT_PATH") +
	 * "deleteTempFile", "domainName=" + domainName + "/" + aliasName + "/" +
	 * controller.fetchAliasLayout(aliasId, device) + "/" + device.toLowerCase()
	 * + "/LR/" + pageType.toLowerCase() + "&path=" + fileName);
	 * session.removeAttribute("cms-preview-name"); } }catch(Exception ex){
	 * ex.printStackTrace(); } }
	 * 
	 * public String saveWidget() { cmsController = new CmsController();
	 * CommonMethodController controller = CommonMethodController
	 * .getInstance(); CMSWidgetBean widgetBean = new CMSWidgetBean(); try {
	 * StDmDomainAliasNameMaster aliasMaster = controller
	 * .getAliasMaster(aliasId); String domainName =
	 * aliasMaster.getDomainMaster().getDomainName(); String aliasName =
	 * aliasMaster.getAliasName(); String fileSeperater = "|"; StringBuilder
	 * portalPath = new StringBuilder(""); portalPath.append(domainName);
	 * portalPath.append(fileSeperater); portalPath.append(aliasName);
	 * portalPath.append(fileSeperater);
	 * portalPath.append(controller.fetchAliasLayout(aliasId,
	 * device.toLowerCase())); portalPath.append(fileSeperater);
	 * portalPath.append(device.toLowerCase());
	 * portalPath.append(fileSeperater); portalPath.append("LR");
	 * portalPath.append(fileSeperater).append(widgetType.toLowerCase());
	 * portalPath.append(fileSeperater).append("eng");
	 * widgetBean.setDomainId(domainId); widgetBean.setAliasId(aliasId);
	 * widgetBean.setWidgetName(widgetName);
	 * widgetBean.setWidgetType(widgetType); widgetBean.setWidgetId(widgetId);
	 * widgetBean.setContentUrl(contentUrl); widgetBean.setWidgetPath(widgetName
	 * + ".jsp"); widgetBean.setCommonCss(isCommonCSS);
	 * widgetBean.setCustomCss(isCustomCSS); widgetBean.setDevice(device);
	 * widgetBean.setSpecificCss(specificCssId.equals(0) ? null :
	 * specificCssId); // PasswordPolicyBean passwordPolicyBean = //
	 * controller.fetchDomainWisePasswordValidation(domainId); // String
	 * passwordPolicy = // passwordPolicyBean.getPasswordExpression(); //
	 * passwordPolicy = passwordPolicy.replaceAll("\"", "&quot;"); widgetContent
	 * = widgetContent.replaceAll("%(?![0-9a-fA-F]{2})", "%25"); content =
	 * URLDecoder.decode(widgetContent, "UTF-8") .replace(" s:",
	 * "<s:").replace(" /s:", "></s:") .replace("&gt;", ">").replace("&lt;",
	 * "<"); if(content.indexOf("mobile_no_"+widgetName) != -1){ content =
	 * content.replaceAll("mobile_no_"+widgetName+'"', "
	 * mobile_no_"+widgetName+'"'+" maxlength="+"'10' "); } // Document dc =
	 * Jsoup.parse(content); // Elements elements = dc.select("[id=password]");
	 * // elements.attr("pattern", passwordPolicy); // content =
	 * dc.getElementsByTag("body").get(0).html(); if
	 * ("LOGIN_WIDGET".equals(widgetType)) { String loginAction =
	 * ("PC").equalsIgnoreCase(device) ? "/portal/login-error" :
	 * "/mobile/login-error"; content = (new StringBuilder( "<div id='" +
	 * widgetName + "_widgetDiv'><form id=\"LoginFrm_" + widgetName +
	 * "\" action=\"" + loginAction + "\" method=\"POST\" class=\"" +
	 * validationStyle +
	 * "\" novalidate=\"true\"> <s:token name=\"loginToken\"> </s:token>"))
	 * .append(content).append("</form></div>").toString(); } else if
	 * ("REGISTRATION_WIDGET".equals(widgetType)) { String regAction =
	 * ("PC").equalsIgnoreCase(device) ? "/portal/confirm-registration" :
	 * "/mobile/confirm-registration"; content = (new StringBuilder("<div id='"
	 * + widgetName + "_widgetDiv'><form id=\"regForm_" + widgetName +
	 * "\" action=\"" + regAction + "\" method=\"POST\" class=\"" +
	 * validationStyle + "\" novalidate=\"true\">")).append(content)
	 * .append("</form></div>").toString(); } else if
	 * ("FORGOT_PWD_WIDGET".equals(widgetType)) { // code added // for // forget
	 * // password // widget String fgpassAction =
	 * ("PC").equalsIgnoreCase(device) ? "/portal/password-send-success" :
	 * "/mobile/password-send-success"; content = (new StringBuilder(
	 * "<div id='" + widgetName +
	 * "_widgetDiv'><form id=\"forgotPasswordForm\" action=\"" + fgpassAction +
	 * "\" method=\"POST\" class=\"" + validationStyle +
	 * "\" novalidate=\"true\">"))
	 * .append(content).append("</form></div>").toString(); } StringBuilder
	 * headTag = new StringBuilder(
	 * "<%@ page language=\"java\" import=\"java.util.*\" pageEncoding=\"UTF-8\"%>\n<%@taglib prefix=\"s\" uri=\"/struts-tags\"%>\n"
	 * ); headTag.append(content); content = headTag.toString();
	 * Utility.saveOrUpdateContent(content, widgetName + ".jsp",
	 * portalPath.toString()); if (widgetId == null) {
	 * cmsController.saveWidgets(widgetBean); } else {
	 * cmsController.saveEditWidget(widgetBean); } } catch (Exception e) {
	 * e.printStackTrace(); return ERROR; } return "success"; }
	 * 
	 * public void checkWidgetNameAval() throws IOException{ cmsController = new
	 * CmsController(); String result = null; try { result =
	 * cmsController.isWidgetNameAvail(aliasId, widgetType, widgetName); } catch
	 * (PMSException e) { e.printStackTrace(); result = e.getErrorMessage(); }
	 * catch (Exception e) { e.printStackTrace(); result =
	 * "Some Internal Error"; } response.getWriter().write(result); }
	 * 
	 * public void getWidgetNames() { cmsController = new CmsController(); Gson
	 * gson = new Gson(); PrintWriter out = null; try { out =
	 * response.getWriter(); List<CMSWidgetBean> result =
	 * cmsController.getCMSWidgetBeanList( aliasId, widgetType, device); String
	 * widgetList = gson.toJson(result); out.write(widgetList); } catch
	 * (Exception e) { e.printStackTrace(); } }
	 * 
	 * public String loadWidgetContent() { cmsController = new CmsController();
	 * CommonMethodController controller = CommonMethodController
	 * .getInstance(); try { pageLinkList = cmsController.getPageURLs(aliasId,
	 * 1, device); specificCssMap = cmsController.getAliasSpecificCss(aliasId);
	 * specificCssStr=new Utility().convertJSON(specificCssMap);
	 * defaultContentPath = CommonMethodController.getInstance()
	 * .fetchSystemProperties("DEFAULT_CONTENT_PATH"); StDmDomainAliasNameMaster
	 * aliasMaster = controller .getAliasMaster(aliasId); String domainName =
	 * aliasMaster.getDomainMaster().getDomainName(); String aliasName =
	 * aliasMaster.getAliasName(); if (specificCssId != null) { editorCss =
	 * editorCss + defaultContentPath + domainName + "/" + aliasName +
	 * "/default/pc/LR/css/" + specificCssMap.get(specificCssId).getCssPath(); }
	 * StringBuilder portalPath = new StringBuilder("");
	 * portalPath.append(domainName); portalPath.append("|");
	 * portalPath.append(aliasName); portalPath.append("|");
	 * portalPath.append(controller.fetchAliasLayout(aliasId,
	 * device.toLowerCase())); portalPath.append("|");
	 * portalPath.append(device.toLowerCase()); portalPath.append("|");
	 * portalPath.append("LR");
	 * portalPath.append("|").append(widgetType.toLowerCase());
	 * portalPath.append("|").append("eng"); String str1 =
	 * Utility.readFileContent(portalPath.toString(), widgetName + ".jsp");
	 * Document dc = Jsoup.parse(str1); Elements elements = dc.select("form");
	 * validationStyle = elements.attr("class");
	 * 
	 * String widgetDiv = "<div id='" + widgetName + "_widgetDiv'>"; content =
	 * str1.toString().replaceAll("<%@(?:.*)%>", "") .replaceAll(widgetDiv,
	 * "").replaceAll("<form(.*?)>", "") .replaceAll("</form></div>", ""); ;
	 * 
	 * 
	 * content = str1.toString().replaceAll("<%@(?:.*)%>", "")
	 * .replaceAll("<form(.*?)>", "").replaceAll("</form>", ""); ;
	 * 
	 * String pattern = "<s:(.*?)+</s:[a-z]+>"; Pattern r =
	 * Pattern.compile(pattern); Matcher m = r.matcher(content); submitUrlList =
	 * cmsController.getSubmitURLs(aliasId, 1, device); fildsList =
	 * cmsController.fetchWidgetFieldBeanList(aliasId, widgetType);
	 * fieldsStr=new Utility().convertJSON(fildsList); while (m.find()) { String
	 * str = m.group(); dc = Jsoup.parse(str); Element element =
	 * dc.body().child(0); if ("redirectUrl".equals(element.attr("name"))) {
	 * setRedirectUrl(element.val()); } for (WidgetFieldBean fieldBean :
	 * fildsList) { if (str.contains(fieldBean.getFieldName())) { String val =
	 * null; if ("Text".equals(fieldBean.getFieldInputType()) ||
	 * "Password".equals(fieldBean .getFieldInputType())) { val =
	 * element.attr("placeholder"); } else if ("Select".equals(fieldBean
	 * .getFieldInputType())) { val = element.attr("headerValue"); } else { val
	 * = element.attr("value"); } content = content.replace( str, (new
	 * StringBuilder("{ ")) .append(val + ": " + fieldBean.getFieldName())
	 * .append("}").toString()); }
	 * 
	 * } } } catch (Exception e) { e.printStackTrace(); return
	 * "exception_nodecorate"; } return "success"; }
	 * 
	 * public String getWidgetDetails() { cmsController = new CmsController();
	 * try { pageLinkList = cmsController.getPageURLs(aliasId, 1, device);
	 * specificCssMap = cmsController.getAliasSpecificCss(aliasId);
	 * specificCssStr=new Utility().convertJSON(specificCssMap);
	 * defaultContentPath = CommonMethodController.getInstance()
	 * .fetchSystemProperties("DEFAULT_CONTENT_PATH"); // function added for
	 * submit url drop down at create and edit widget // page submitUrlList =
	 * cmsController.getSubmitURLs(aliasId, 1, device);
	 * 
	 * } catch (PMSException e) { e.printStackTrace();
	 * addActionError(e.getErrorMessage()); return "exception_nodecorate";
	 * }catch (Exception be) { addActionError("Some internal error.");
	 * be.printStackTrace(); return "exception_nodecorate"; } return SUCCESS; }
	 * 
	 * public String uploadCssZip() throws PMSException { CommonMethodController
	 * controller = CommonMethodController .getInstance(); cmsController = new
	 * CmsController(); try { String fileSeperater = File.separator;
	 * StringBuilder filePath = new StringBuilder(""); StDmDomainAliasNameMaster
	 * aliasMaster = controller .getAliasMaster(aliasId); String domainName =
	 * aliasMaster.getDomainMaster().getDomainName(); String aliasName =
	 * aliasMaster.getAliasName();
	 * filePath.append(domainName).append("|").append(aliasName)
	 * .append("|").append("default").append("|").append("pc")
	 * .append("|").append("LR").append("|").append("css");
	 * Utility.saveOrUpdateContentZip(uploadZipCss, uploadZipCssFileName,
	 * filePath.toString()); filePath.append("|").append(cssPath);
	 * defaultContentPath = controller
	 * .fetchSystemProperties("DEFAULT_CONTENT_PATH") +
	 * filePath.toString().replace("|", fileSeperater);
	 * cmsController.saveCssZipFile(cssName, cssPath, domainId, aliasId); }
	 * catch (Exception e) { e.printStackTrace(); return ERROR; } return
	 * SUCCESS; }
	 * 
	 * public void availabalCssZipName() throws IOException { cmsController =
	 * new CmsController(); response.getWriter()
	 * .write(cmsController.isCssZipNameAvail(cssName, aliasId) ?
	 * "<p>Not Available</p>" : "<p>Available</p>"); }
	 * 
	 * public String fetchEditCssZipName() throws PMSException { cmsController =
	 * new CmsController(); try { dmCssMap = new Gson().toJson(cmsController
	 * .fetchEditCssZipName(aliasId)); } catch (Exception e) {
	 * e.printStackTrace(); } return SUCCESS; }
	 * 
	 * public String editCssZip() { CommonMethodController controller =
	 * CommonMethodController .getInstance(); cmsController = new
	 * CmsController(); try { StDmDomainAliasNameMaster aliasMaster = controller
	 * .getAliasMaster(aliasId); String domainName =
	 * aliasMaster.getDomainMaster().getDomainName(); String aliasName =
	 * aliasMaster.getAliasName(); String fileSeperater = File.separator;
	 * StringBuilder filePath = new StringBuilder("");
	 * filePath.append(domainName).append("|").append(aliasName)
	 * .append("|").append("default").append("|").append("pc")
	 * .append("|").append("LR").append("|").append("css");
	 * Utility.saveOrUpdateContentZip(uploadZipCss, uploadZipCssFileName,
	 * filePath.toString()); filePath.append("|").append(cssPath);
	 * defaultContentPath = controller
	 * .fetchSystemProperties("DEFAULT_CONTENT_PATH") +
	 * filePath.toString().replace("|", fileSeperater); } catch (Exception e) {
	 * e.printStackTrace(); return ERROR; } return SUCCESS; }
	 * 
	 * public void pageLoadField() throws IOException { cmsController = new
	 * CmsController(); Gson gson = new Gson(); try { fildsList =
	 * cmsController.fetchWidgetFieldBeanList(aliasId, widgetType); PrintWriter
	 * out = response.getWriter(); out.write(gson.toJson(fildsList)); } catch
	 * (PMSException e) { e.printStackTrace(); }catch (Exception be) {
	 * be.printStackTrace(); } }
	 * 
	 * public String savePlaceHolderCriteria() { cmsController = new
	 * CmsController(); try { placeHolderCriteria.setCriteriaName(criteriaName);
	 * cmsController.saveOrUpdPHCriteria(placeHolderCriteria, domainId,
	 * aliasId); }catch (PMSException e) { e.printStackTrace();
	 * addActionError(e.getMessage()); return "exception"; } catch (Exception e)
	 * { e.printStackTrace(); addActionError("Some internal error!"); return
	 * "exception"; } return SUCCESS; }
	 * 
	 * public void availabalCriteria() { try { cmsController = new
	 * CmsController(); response.getWriter()
	 * .write(cmsController.availabalCriteria(criteriaName) ?
	 * "<p>Not Available</p>" : "<p>Available</p>"); } catch (Exception e) {
	 * e.printStackTrace(); } }
	 * 
	 * public void fetchDynamicPages() { try { response.getWriter().write( new
	 * Gson().toJson(new CmsController().fetchDynamicPageMap( aliasId,
	 * device))); } catch (Exception e) { e.printStackTrace(); } }
	 * 
	 * public String fetchMetaData() { try { urlBean = new
	 * CmsController().fetchMetaContent(aliasId, contentId); } catch (Exception
	 * e) { e.printStackTrace(); return "exception"; } return SUCCESS; }
	 * 
	 * public String saveMetaData() { try { new
	 * CmsController().saveMetaContent(aliasId, contentId, pageTitle,
	 * pageDescription, pageKeyword); } catch (Exception e) {
	 * e.printStackTrace(); return "exception"; } return SUCCESS; }
	 * 
	 * public void fetchPHCriName() { try { response.getWriter().write( new
	 * Gson().toJson(new CmsController() .fetchPHCriterias(aliasId))); } catch
	 * (Exception e) { e.printStackTrace(); } }
	 * 
	 * public String fetchCriteriaDetail() { try { placeHolderCriteria = new
	 * CmsController()
	 * .fetchCriteriaDetail(placeHolderCriteria.getPhCriteriaId());
	 * vipLevelBeanList = CommonMethodController.getInstance()
	 * .fetchDomainVipLevelList(domainId, "");
	 * placeHolderCriteria.setCampNames(new CmsController()
	 * .fetchCampNameMap(aliasId, "PPC", null)); } catch (Exception e) {
	 * e.printStackTrace(); addActionError("Some Internal Error!"); return
	 * "exception"; } return SUCCESS; }
	 * 
	 * public String editSavePlaceHolderCriteria(){ try { new
	 * CmsController().saveOrUpdPHCriteria(placeHolderCriteria, domainId,
	 * aliasId); } catch (Exception e) { e.printStackTrace();
	 * addActionError("Some Internal Error!"); return "exception"; } return
	 * SUCCESS; }
	 * 
	 * 
	 * public void getAliasTypeData(){
	 * 
	 * try { if(aliasId!=0)
	 * aliascontentType=CommonMethodController.getInstance()
	 * .getAliasPropertyMap(aliasId, "contentType") .get("contentType");
	 * if(!"PORTALCONTENT".equalsIgnoreCase(aliascontentType)){
	 * response.getWriter().write(new
	 * Gson().toJson(aliascontentType).toString()); }else if(domainId!=0){
	 * List<LanguageBean> languageList = new
	 * ArrayList<LanguageBean>(CommonMethodController.getInstance().
	 * fetchDmActiveLangMap(domainId).values()); response.getWriter().write(new
	 * Gson().toJson(languageList).toString()); } }catch (Exception e) {
	 * e.printStackTrace(); }
	 * 
	 * }
	 * 
	 * 
	 * public void getContentDetail(){ String contentUrl = null; try {
	 * if(aliasId!=0) if(pageType.equals("WEB")) contentUrl = new
	 * CmsController().getURL(aliasId,"PLR_CONTENT_URL"); if(contentUrl!=null) {
	 * URL conatctURL = new URL(contentUrl); URLConnection myURLConn =
	 * conatctURL.openConnection(); myURLConn.connect(); BufferedReader
	 * BuffReader = new BufferedReader( new
	 * InputStreamReader(myURLConn.getInputStream())); StringBuilder stb = new
	 * StringBuilder(); String result = null; while ((result =
	 * BuffReader.readLine()) != null) { stb.append(result); } String st =
	 * "{\"contentUrl\":\"" +contentUrl+"\",";
	 * response.getWriter().write(stb.toString().replaceFirst("[{]", st)); }
	 * }catch (Exception e) { e.printStackTrace(); } }
	 * 
	 * public String fetchContentMapping(){ try { JoomlaContentBean joomlaCtBean
	 * = new Gson().fromJson(joomlaContent, JoomlaContentBean.class);
	 * modulePosMap = new HashMap<String, Map<Integer,String>>();
	 * JoomlaModuleBean module[] = joomlaCtBean.getModules(); JoomlaMenuBean
	 * menu[] = joomlaCtBean.getMenus(); List<Integer> availModule = null; for
	 * (JoomlaMenuBean menuBean : menu) { if(menuId==menuBean.getId()) {
	 * availModule = menuBean.getAvailModules(); break; } } for
	 * (JoomlaModuleBean modulesBean : module) { if(availModule!=null &&
	 * availModule.contains(modulesBean.getId())) { Map<Integer, String>
	 * moduleMap = null; if(modulesBean.getPosition()!=null &&
	 * !"".equals(modulesBean.getPosition())) { if
	 * (modulePosMap.get(modulesBean.getPosition())!=null) { moduleMap =
	 * modulePosMap.get(modulesBean.getPosition()); } else { moduleMap = new
	 * HashMap<Integer, String>(); modulePosMap.put(modulesBean.getPosition(),
	 * moduleMap); } moduleMap.put(modulesBean.getId(), modulesBean.getTitle());
	 * } } } Set<String> keys = modulePosMap.keySet(); Set <String> set = new
	 * HashSet<String>(keys); CmsController cmsController = new CmsController();
	 * List<StCmsPlrCriteriaMapping> list =
	 * cmsController.fetchContentMapping(aliasId, menuId); plrCritData = new
	 * HashMap<String, List<PlrCritMappingBean>>(); for (StCmsPlrCriteriaMapping
	 * critMapping : list) { if(keys.contains(critMapping.getModulePosition()))
	 * { List <PlrCritMappingBean> plrMapping = null;
	 * if(plrCritData.get(critMapping.getModulePosition())!=null) { plrMapping =
	 * plrCritData.get(critMapping.getModulePosition()); } else { plrMapping =
	 * new ArrayList<PlrCritMappingBean>();
	 * plrCritData.put(critMapping.getModulePosition(), plrMapping); }
	 * PlrCritMappingBean mappBean = new PlrCritMappingBean(critMapping.getId(),
	 * critMapping.getModulePosition(), critMapping.getStatus(),
	 * critMapping.getModuleId(), critMapping.getModuleTitle(),
	 * critMapping.getMenuId(), critMapping.getPhCritId());
	 * plrMapping.add(mappBean);
	 * if(set.contains(critMapping.getModulePosition())) {
	 * set.remove(critMapping.getModulePosition()); } } } phCritMap =
	 * cmsController.fetchPHCriterias(aliasId); for (String position : set) {
	 * List <PlrCritMappingBean> plrMapping = null;
	 * if(plrCritData.get(position)!=null) { plrMapping =
	 * plrCritData.get(position); } else { plrMapping = new
	 * ArrayList<PlrCritMappingBean>(); plrCritData.put(position, plrMapping); }
	 * PlrCritMappingBean mappBean = new PlrCritMappingBean(0,position,
	 * "INACTIVE",null, null,null,null); plrMapping.add(mappBean); } } catch
	 * (Exception e) { e.printStackTrace();
	 * addActionError("Some Internal Error!"); return "exception"; } return
	 * SUCCESS; }
	 * 
	 * public String submitPhMapping() { try { new
	 * CmsController().submitPhMapping(aliasId,menuId, menuTitle,critBean); }
	 * catch (Exception e) { e.printStackTrace();
	 * addActionError("Some Internal Error!"); return "exception"; } return
	 * SUCCESS; }
	 * 
	 * public void setTextAreaId(Object textAreaId) { this.textAreaId =
	 * textAreaId; }
	 * 
	 * public Object getTextAreaId() { return textAreaId; }
	 * 
	 * public void setCampaignMap(String campaignMap) { this.campaignMap =
	 * campaignMap; }
	 * 
	 * public String getCampaignMap() { return campaignMap; }
	 * 
	 * public void setContentId(Integer contentId) { this.contentId = contentId;
	 * }
	 * 
	 * public Integer getContentId() { return contentId; }
	 * 
	 * public void setPageDetailBean(PortalPageLinkBean pageDetailBean) {
	 * this.pageDetailBean = pageDetailBean; }
	 * 
	 * public PortalPageLinkBean getPageDetailBean() { return pageDetailBean; }
	 * 
	 * public void setVariablesBeanJson(Gson variablesBeanJson) {
	 * this.variablesBeanJson = variablesBeanJson; }
	 * 
	 * public Gson getVariablesBeanJson() { return variablesBeanJson; }
	 * 
	 * public void setStCmsPlaceHolderMasters( List<StCmsPlaceholderMaster>
	 * stCmsPlaceHolderMasters) { this.stCmsPlaceHolderMasters =
	 * stCmsPlaceHolderMasters; }
	 * 
	 * public void setScriptFor(String scriptFor) { this.scriptFor = scriptFor;
	 * }
	 * 
	 * public String getScriptFor() { return scriptFor; }
	 * 
	 * public void setUrlId(Integer urlId) { this.urlId = urlId; }
	 * 
	 * public Integer getUrlId() { return urlId; }
	 * 
	 * public void setPlaceHolderPages(String placeHolderPages) {
	 * this.placeHolderPages = placeHolderPages; }
	 * 
	 * public String getPlaceHolderPages() { return placeHolderPages; }
	 * 
	 * public void setPlaceHolderDetailMap( Map<String, Map<String, Map<Integer,
	 * List<PlaceHolderDetailBean>>>> placeHolderDetailMap) {
	 * this.placeHolderDetailMap = placeHolderDetailMap; }
	 * 
	 * public Map<String, Map<String, Map<Integer,
	 * List<PlaceHolderDetailBean>>>> getPlaceHolderDetailMap() { return
	 * placeHolderDetailMap; }
	 * 
	 * public List<StCmsPlaceholderMaster> getStCmsPlaceHolderMasters() { return
	 * stCmsPlaceHolderMasters; }
	 * 
	 * public void setContentHeight(Integer contentHeight) { this.contentHeight
	 * = contentHeight; }
	 * 
	 * public Integer getContentHeight() { return contentHeight; }
	 * 
	 * public void setPagePath(String pagePath) { this.pagePath = pagePath; }
	 * 
	 * public String getPagePath() { return pagePath; }
	 * 
	 * public void setContentPath(String contentPath) { this.contentPath =
	 * contentPath; }
	 * 
	 * public String getContentPath() { return contentPath; }
	 * 
	 * public void setPhName(String[] phName) { this.phName = phName; }
	 * 
	 * public String[] getPhName() { return phName; }
	 * 
	 * public void setContentFile(File contentFile) { this.contentFile =
	 * contentFile; }
	 * 
	 * public File getContentFile() { return contentFile; }
	 * 
	 * public void setTemplateType(String templateType) { this.templateType =
	 * templateType; }
	 * 
	 * public String getTemplateType() { return templateType; }
	 * 
	 * public void setContentFileFileName(String contentFileFileName) {
	 * this.contentFileFileName = contentFileFileName; }
	 * 
	 * public String getContentFileFileName() { return contentFileFileName; }
	 * 
	 * public void setIsPreLogin(String isPreLogin) { this.isPreLogin =
	 * isPreLogin; }
	 * 
	 * public String getIsPreLogin() { return isPreLogin; }
	 * 
	 * public void setIsPostLogin(String isPostLogin) { this.isPostLogin =
	 * isPostLogin; }
	 * 
	 * public String getIsPostLogin() { return isPostLogin; }
	 * 
	 * public void setPageNameList(String pageNameList) { this.pageNameList =
	 * pageNameList; }
	 * 
	 * public String getPageNameList() { return pageNameList; }
	 * 
	 * public void setContentSize(String contentSize) { this.contentSize =
	 * contentSize; }
	 * 
	 * public String getContentSize() { return contentSize; }
	 * 
	 * public void setTemplateMod(String templateMod) { this.templateMod =
	 * templateMod; }
	 * 
	 * public String getTemplateMod() { return templateMod; }
	 * 
	 * public String getCampName() { return campName; }
	 * 
	 * public void setCampName(String campName) { this.campName = campName; }
	 * 
	 * public String getCampType() { return campType; }
	 * 
	 * public void setCampType(String campType) { this.campType = campType; }
	 * 
	 * public void setCampDetailString(String campDetailString) {
	 * this.campDetailString = campDetailString; }
	 * 
	 * public String getCampDetailString() { return campDetailString; }
	 * 
	 * public void setLandingPageUrlDetail(Map<String, String>
	 * landingPageUrlDetail) { this.landingPageUrlDetail = landingPageUrlDetail;
	 * }
	 * 
	 * public Map<String, String> getLandingPageUrlDetail() { return
	 * landingPageUrlDetail; }
	 * 
	 * public Long getCampId() { return campId; }
	 * 
	 * public void setCampId(Long campId) { this.campId = campId; }
	 * 
	 * public void setCampaignDetailBean(CampaignBean campaignDetailBean) {
	 * this.campaignDetailBean = campaignDetailBean; }
	 * 
	 * public CampaignBean getCampaignDetailBean() { return campaignDetailBean;
	 * }
	 * 
	 * public void setLandingPageDetail(Map<Integer, String> landingPageDetail)
	 * { this.landingPageDetail = landingPageDetail; }
	 * 
	 * public Map<Integer, String> getLandingPageDetail() { return
	 * landingPageDetail; }
	 * 
	 * public String getLandingPageDetailStr() { return landingPageDetailStr; }
	 * 
	 * public void setLandingPageDetailStr(String landingPageDetailStr) {
	 * this.landingPageDetailStr = landingPageDetailStr; }
	 * 
	 * public String getStatus() { return status; }
	 * 
	 * public void setStatus(String status) { this.status = status; }
	 * 
	 * public void setMetaNames(String[] metaNames) { this.metaNames =
	 * metaNames; }
	 * 
	 * public String[] getMetaNames() { return metaNames; }
	 * 
	 * public void setMetaContents(String[] metaContents) { this.metaContents =
	 * metaContents; }
	 * 
	 * public String[] getMetaContents() { return metaContents; }
	 * 
	 * public void setLinkHrefs(String[] linkHrefs) { this.linkHrefs =
	 * linkHrefs; }
	 * 
	 * public String[] getLinkHrefs() { return linkHrefs; }
	 * 
	 * public void setLinkRels(String[] linkRels) { this.linkRels = linkRels; }
	 * 
	 * public String[] getLinkRels() { return linkRels; }
	 * 
	 * public void setLinkTypes(String[] linkTypes) { this.linkTypes =
	 * linkTypes; }
	 * 
	 * public String[] getLinkTypes() { return linkTypes; }
	 * 
	 * public void setCmsBeans(List<CMSWidgetBean> cmsBeans) { this.cmsBeans =
	 * cmsBeans; }
	 * 
	 * public String getCmsBeansStr() { return cmsBeansStr; }
	 * 
	 * public void setCmsBeansStr(String cmsBeansStr) { this.cmsBeansStr =
	 * cmsBeansStr; }
	 * 
	 * public List<CMSWidgetBean> getCmsBeans() { return cmsBeans; }
	 * 
	 * public String getCssDetail() { return cssDetail; }
	 * 
	 * public void setCssDetail(String cssDetail) { this.cssDetail = cssDetail;
	 * }
	 * 
	 * public void setTmpltBean(TemplateMasterBean tmpltBean) { this.tmpltBean =
	 * tmpltBean; }
	 * 
	 * public TemplateMasterBean getTmpltBean() { return tmpltBean; }
	 * 
	 * public void setLanguage(Integer language) { this.language = language; }
	 * 
	 * public Integer getLanguage() { return language; }
	 * 
	 * public void setCampParams(List<String> campParams) { this.campParams =
	 * campParams; }
	 * 
	 * public List<String> getCampParams() { return campParams; }
	 * 
	 * public void setDefaultContentPath(String defaultContentPath) {
	 * this.defaultContentPath = defaultContentPath; }
	 * 
	 * public String getDefaultContentPath() { return defaultContentPath; }
	 * 
	 * public String getIsLink() { return isLink; }
	 * 
	 * public void setIsLink(String isLink) { this.isLink = isLink; }
	 * 
	 * public String getFixedPageJson() { return fixedPageJson; }
	 * 
	 * public void setFixedPageJson(String fixedPageJson) { this.fixedPageJson =
	 * fixedPageJson; }
	 * 
	 * public String getDevice() { return device; }
	 * 
	 * public void setDevice(String device) { this.device = device; }
	 * 
	 * public String getDeviceOS() { return deviceOS; }
	 * 
	 * public void setDeviceOS(String deviceOS) { this.deviceOS = deviceOS; }
	 * 
	 * public Integer[] getPhIds() { return phIds; }
	 * 
	 * public void setPhIds(Integer[] phIds) { this.phIds = phIds; }
	 * 
	 * public String getContentIds() { return contentIds; }
	 * 
	 * public void setContentIds(String contentIds) { this.contentIds =
	 * contentIds; }
	 * 
	 * public String getContentType() { return contentType; }
	 * 
	 * public void setContentType(String contentType) { this.contentType =
	 * contentType; }
	 * 
	 * public String getContentUrl() { return contentUrl; }
	 * 
	 * public void setContentUrl(String contentUrl) { this.contentUrl =
	 * contentUrl; }
	 * 
	 * public String[] getPhCode() { return phCode; }
	 * 
	 * public void setPhCode(String[] phCode) { this.phCode = phCode; }
	 * 
	 * public Integer[] getPhHeight() { return phHeight; }
	 * 
	 * public void setPhHeight(Integer[] phHeight) { this.phHeight = phHeight; }
	 * 
	 * public Integer[] getPhWidth() { return phWidth; }
	 * 
	 * public void setPhWidth(Integer[] phWidth) { this.phWidth = phWidth; }
	 * 
	 * public String getPageType() { return pageType; }
	 * 
	 * public Integer getContentWidth() { return contentWidth; }
	 * 
	 * public void setContentWidth(Integer contentWidth) { this.contentWidth =
	 * contentWidth; }
	 * 
	 * public void setPageType(String pageType) { this.pageType = pageType; }
	 * 
	 * public CmsController getCmsController() { return cmsController; }
	 * 
	 * public void setCmsController(CmsController cmsController) {
	 * this.cmsController = cmsController; }
	 * 
	 * public Integer getRelatedCampaign() { return relatedCampaign; }
	 * 
	 * public void setRelatedCampaign(Integer relatedCampaign) {
	 * this.relatedCampaign = relatedCampaign; }
	 * 
	 * public String getBannerContext() { return bannerContext; }
	 * 
	 * public void setBannerContext(String bannerContext) { this.bannerContext =
	 * bannerContext; }
	 * 
	 * public String getBannerName() { return bannerName; }
	 * 
	 * public void setBannerName(String bannerName) { this.bannerName =
	 * bannerName; }
	 * 
	 * public String getBannerType() { return bannerType; }
	 * 
	 * public void setBannerType(String bannerType) { this.bannerType =
	 * bannerType; }
	 * 
	 * public String getBannerDescrip() { return bannerDescrip; }
	 * 
	 * public void setBannerDescrip(String bannerDescrip) { this.bannerDescrip =
	 * bannerDescrip; }
	 * 
	 * public String getGraphicsType() { return graphicsType; }
	 * 
	 * public void setGraphicsType(String graphicsType) { this.graphicsType =
	 * graphicsType; }
	 * 
	 * public String getSize() { return size; }
	 * 
	 * public void setSize(String size) { this.size = size; }
	 * 
	 * public String getRelatedTo() { return relatedTo; }
	 * 
	 * public void setRelatedTo(String relatedTo) { this.relatedTo = relatedTo;
	 * }
	 * 
	 * public String getDefaultGraphicsPath() { return defaultGraphicsPath; }
	 * 
	 * public void setDefaultGraphicsPath(String defaultGraphicsPath) {
	 * this.defaultGraphicsPath = defaultGraphicsPath; }
	 * 
	 * public String[] getCurrencyList() { return currencyList; }
	 * 
	 * public void setCurrencyList(String[] currencyList) { this.currencyList =
	 * currencyList; }
	 * 
	 * public List<File> getGraphicsPath() { return graphicsPath; }
	 * 
	 * public void setGraphicsPath(List<File> graphicsPath) { this.graphicsPath
	 * = graphicsPath; }
	 * 
	 * public List<String> getGraphicsPathContentType() { return
	 * graphicsPathContentType; }
	 * 
	 * public void setGraphicsPathContentType(List<String>
	 * graphicsPathContentType) { this.graphicsPathContentType =
	 * graphicsPathContentType; }
	 * 
	 * public List<String> getGraphicsPathFileName() { return
	 * graphicsPathFileName; }
	 * 
	 * public void setGraphicsPathFileName(List<String> graphicsPathFileName) {
	 * this.graphicsPathFileName = graphicsPathFileName; }
	 * 
	 * public String[] getGraphicsPathString() { return graphicsPathString; }
	 * 
	 * public void setGraphicsPathString(String[] graphicsPathString) {
	 * this.graphicsPathString = graphicsPathString; }
	 * 
	 * public Integer getCurrency() { return currency; }
	 * 
	 * public void setCurrency(Integer currency) { this.currency = currency; }
	 * 
	 * public List<VariablesBean> getVariablesBeanList() { return
	 * variablesBeanList; }
	 * 
	 * public void setVariablesBeanList(List<VariablesBean> variablesBeanList) {
	 * this.variablesBeanList = variablesBeanList; }
	 * 
	 * public String getVariablesBeanStr() { return variablesBeanStr; }
	 * 
	 * public void setVariablesBeanStr(String variablesBeanStr) {
	 * this.variablesBeanStr = variablesBeanStr; }
	 * 
	 * public List<PortalPageLinkBean> getPageLinkList() { return pageLinkList;
	 * }
	 * 
	 * public void setPageLinkList(List<PortalPageLinkBean> pageLinkList) {
	 * this.pageLinkList = pageLinkList; }
	 * 
	 * public String getPageLinkStr() { return pageLinkStr; }
	 * 
	 * public void setPageLinkStr(String pageLinkStr) { this.pageLinkStr =
	 * pageLinkStr; }
	 * 
	 * public String getPageName() { return pageName; }
	 * 
	 * public void setPageName(String pageName) { this.pageName =
	 * pageName.split("\\.")[0]; }
	 * 
	 * public String getPageMetaTag() { return pageMetaTag; }
	 * 
	 * public void setPageMetaTag(String pageMetaTag) { this.pageMetaTag =
	 * pageMetaTag; }
	 * 
	 * public String getPageTitle() { return pageTitle; }
	 * 
	 * public String getIsCommonCSS() { return isCommonCSS; }
	 * 
	 * public void setIsCommonCSS(String isCommonCSS) { this.isCommonCSS =
	 * isCommonCSS; }
	 * 
	 * public String getIsCustomCSS() { return isCustomCSS; }
	 * 
	 * public void setIsCustomCSS(String isCustomCSS) { this.isCustomCSS =
	 * isCustomCSS; }
	 * 
	 * public void setPageTitle(String pageTitle) { this.pageTitle = pageTitle;
	 * }
	 * 
	 * public String getPageKeyword() { return pageKeyword; }
	 * 
	 * public void setPageKeyword(String pageKeyword) { this.pageKeyword =
	 * pageKeyword; }
	 * 
	 * public String getPageDescription() { return pageDescription; }
	 * 
	 * public void setPageDescription(String pageDescription) {
	 * this.pageDescription = pageDescription; }
	 * 
	 * public void setContent(String content) { this.content = content; }
	 * 
	 * public String getContent() { return content; }
	 * 
	 * public String getJsonObjVariableId() { return jsonObjVariableId; }
	 * 
	 * public void setJsonObjVariableId(String jsonObjVariableId) {
	 * this.jsonObjVariableId = jsonObjVariableId; }
	 * 
	 * public Map<Integer, String> getLandingPages() { return landingPages; }
	 * 
	 * public void setLandingPages(Map<Integer, String> landingPages) {
	 * this.landingPages = landingPages; }
	 * 
	 * public String getCssPath() { return cssPath; }
	 * 
	 * public void setCssPath(String cssPath) {
	 * 
	 * this.cssPath = cssPath; }
	 * 
	 * public String getSpecificCssPath() { return specificCssPath; }
	 * 
	 * public void setSpecificCssPath(String specificCssPath) {
	 * this.specificCssPath = specificCssPath; }
	 * 
	 * public Integer getSpecificCssId() { return specificCssId; }
	 * 
	 * public void setSpecificCssId(Integer specificCssId) { this.specificCssId
	 * = specificCssId; }
	 * 
	 * public Map<Integer, CssBean> getDomainCssMap() { return domainCssMap; }
	 * 
	 * public String getDomainCssStr() { return domainCssStr; }
	 * 
	 * public void setDomainCssStr(String domainCssStr) { this.domainCssStr =
	 * domainCssStr; }
	 * 
	 * public void setDomainCssMap(Map<Integer, CssBean> domainCssMap) {
	 * this.domainCssMap = domainCssMap; }
	 * 
	 * public String getWidgetType() { return widgetType; }
	 * 
	 * public void setWidgetType(String widgetType) { this.widgetType =
	 * widgetType; }
	 * 
	 * public String getWidgetName() { return widgetName; }
	 * 
	 * public void setWidgetName(String widgetName) { this.widgetName =
	 * widgetName; }
	 * 
	 * public Integer getWidgetId() { return widgetId; }
	 * 
	 * public void setWidgetId(Integer widgetId) { this.widgetId = widgetId; }
	 * 
	 * public String getWidgetContent() { return widgetContent; }
	 * 
	 * public void setWidgetContent(String widgetContent) { this.widgetContent =
	 * widgetContent; }
	 * 
	 * public List<WidgetFieldBean> getFildsList() { return fildsList; }
	 * 
	 * public void setFildsList(List<WidgetFieldBean> fildsList) {
	 * this.fildsList = fildsList; }
	 * 
	 * public String getFieldsStr() { return fieldsStr; }
	 * 
	 * public void setFieldsStr(String fieldsStr) { this.fieldsStr = fieldsStr;
	 * }
	 * 
	 * public String getRedirectUrl() { return redirectUrl; }
	 * 
	 * public void setRedirectUrl(String redirectUrl) { this.redirectUrl =
	 * redirectUrl; }
	 * 
	 * public Map<Integer, CssBean> getSpecificCssMap() { return specificCssMap;
	 * }
	 * 
	 * public void setSpecificCssMap(Map<Integer, CssBean> specificCssMap) {
	 * this.specificCssMap = specificCssMap; }
	 * 
	 * public String getSpecificCssStr() { return specificCssStr; }
	 * 
	 * public void setSpecificCssStr(String specificCssStr) {
	 * this.specificCssStr = specificCssStr; }
	 * 
	 * public String getEditorCss() { return editorCss; }
	 * 
	 * public void setEditorCss(String editorCss) { this.editorCss = editorCss;
	 * }
	 * 
	 * public File getUploadZipCss() { return uploadZipCss; }
	 * 
	 * public void setUploadZipCss(File uploadZipCss) { this.uploadZipCss =
	 * uploadZipCss; }
	 * 
	 * public String getUploadZipCssFileName() { return uploadZipCssFileName; }
	 * 
	 * public void setUploadZipCssFileName(String uploadZipCssFileName) {
	 * this.uploadZipCssFileName = uploadZipCssFileName; }
	 * 
	 * public String getCssName() { return cssName; }
	 * 
	 * public void setCssName(String cssName) { this.cssName = cssName; }
	 * 
	 * public String getValidationStyle() { return validationStyle; }
	 * 
	 * public void setValidationStyle(String validationStyle) {
	 * this.validationStyle = validationStyle; }
	 * 
	 * public Map<Integer, String> getEditFetchCssMap() { return
	 * editFetchCssMap; }
	 * 
	 * public void setEditFetchCssMap(Map<Integer, String> editFetchCssMap) {
	 * this.editFetchCssMap = editFetchCssMap; }
	 * 
	 * public String getDmCssMap() { return dmCssMap; }
	 * 
	 * public void setDmCssMap(String dmCssMap) { this.dmCssMap = dmCssMap; }
	 * 
	 * public String getCssId() { return cssId; }
	 * 
	 * public void setCssId(String cssId) { this.cssId = cssId; }
	 * 
	 * // getter and setter added for submit url list in widget page public
	 * List<PortalPageLinkBean> getSubmitUrlList() { return submitUrlList; }
	 * 
	 * public void setSubmitUrlList(List<PortalPageLinkBean> submitUrlList) {
	 * this.submitUrlList = submitUrlList; }
	 * 
	 * public PlaceHolderCriteriaBean getPlaceHolderCriteria() { return
	 * placeHolderCriteria; }
	 * 
	 * public void setPlaceHolderCriteria( PlaceHolderCriteriaBean
	 * placeHolderCriteria) { this.placeHolderCriteria = placeHolderCriteria; }
	 * 
	 * public String getCriteriaName() { return criteriaName; }
	 * 
	 * public void setCriteriaName(String criteriaName) { this.criteriaName =
	 * criteriaName; }
	 * 
	 * public String getPageUrl() { return pageUrl; }
	 * 
	 * public void setPageUrl(String pageUrl) { this.pageUrl = pageUrl; }
	 * 
	 * public String getPhCrit() { return phCrit; }
	 * 
	 * public void setPhCrit(String phCrit) { this.phCrit = phCrit; }
	 * 
	 * public List<PHContentMappingBean> getPhCtBean() { return phCtBean; }
	 * 
	 * public void setPhCtBean(List<PHContentMappingBean> phCtBean) {
	 * this.phCtBean = phCtBean; }
	 * 
	 * public UrlTagBean getUrlBean() { return urlBean; }
	 * 
	 * public void setUrlBean(UrlTagBean urlBean) { this.urlBean = urlBean; }
	 * 
	 * public String getPageTypeClient() { return pageTypeClient; }
	 * 
	 * public void setPageTypeClient(String pageTypeClient) {
	 * this.pageTypeClient = pageTypeClient; }
	 * 
	 * public Map<Integer, String> getPhCritMap() { return phCritMap; }
	 * 
	 * public void setPhCritMap(Map<Integer, String> phCritMap) { this.phCritMap
	 * = phCritMap; }
	 * 
	 * public int getMenuId() { return menuId; }
	 * 
	 * public void setMenuId(int menuId) { this.menuId = menuId; }
	 * 
	 * public Map <String, Map<Integer, String>> getModulePosMap() { return
	 * modulePosMap; }
	 * 
	 * public void setModulePosMap(Map <String, Map<Integer, String>>
	 * modulePosMap) { this.modulePosMap = modulePosMap; }
	 * 
	 * public Map<String, List<PlrCritMappingBean>> getPlrCritData() { return
	 * plrCritData; }
	 * 
	 * public void setPlrCritData(Map<String, List<PlrCritMappingBean>>
	 * plrCritData) { this.plrCritData = plrCritData; }
	 * 
	 * public List<PlrCritMappingBean> getCritBean() { return critBean; }
	 * 
	 * public void setCritBean(List<PlrCritMappingBean> critBean) {
	 * this.critBean = critBean; }
	 * 
	 * public String getMenuTitle() { return menuTitle; }
	 * 
	 * public void setMenuTitle(String menuTitle) { this.menuTitle = menuTitle;
	 * }
	 * 
	 * public String getJoomlaContent() { return joomlaContent; }
	 * 
	 * public void setJoomlaContent(String joomlaContent) { this.joomlaContent =
	 * joomlaContent; }
	 * 
	 * public String getAliascontentType() { return aliascontentType; }
	 * 
	 * public void setAliascontentType(String aliascontentType) {
	 * this.aliascontentType = aliascontentType; }
	 * 
	 * public List<JoomlaLandingPages> getJoomlaCtBean() { return joomlaCtBean;
	 * }
	 * 
	 * public void setJoomlaCtBean(List<JoomlaLandingPages> joomlaCtBean) {
	 * this.joomlaCtBean = joomlaCtBean; }
	 * 
	 * public Map<String, String> getReDirectPage() { return reDirectPage; }
	 * 
	 * public void setReDirectPage(Map<String, String> reDirectPage) {
	 * this.reDirectPage = reDirectPage; }
	 * 
	 * public AddNewEventBean getAddNewEvent() { return addNewEvent; }
	 * 
	 * public void setAddNewEvent(AddNewEventBean addNewEvent) {
	 * this.addNewEvent = addNewEvent; }
	 * 
	 * public MapNewEventBean getMapNewEvent() { return mapNewEvent; }
	 * 
	 * public void setMapNewEvent(MapNewEventBean mapNewEvent) {
	 * this.mapNewEvent = mapNewEvent; }
	 * 
	 * public SavePlayerInfo getSavePlrInfo() { return savePlrInfo; }
	 * 
	 * public void setSavePlrInfo(SavePlayerInfo savePlrInfo) { this.savePlrInfo
	 * = savePlrInfo; }
	 * 
	 * public SavePlayerInfo getSavePromotionDetail() { return
	 * savePromotionDetail; }
	 * 
	 * public void setSavePromotionDetail(SavePlayerInfo savePromotionDetail) {
	 * this.savePromotionDetail = savePromotionDetail; }
	 * 
	 * 
	 * }
	 */