package com.stpl.pms.action.bo.graphics;

//import java.io.File;
//import java.util.ArrayList;
//import java.util.Calendar;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import com.stpl.pms.controller.commonMethods.CommonMethodController;
//import com.stpl.pms.controller.graphics.GraphicsMgmtController;
//import com.stpl.pms.exception.PMSException;
//import com.stpl.pms.hibernate.mapping.StDmDomainAliasNameMaster;
//import com.stpl.pms.hibernate.mapping.StGenVariableMaster;
//import com.stpl.pms.javabeans.CurrencyBean;
//import com.stpl.pms.javabeans.GraphicsMasterBean;
//import com.stpl.pms.javabeans.LanguageBean;
//import com.stpl.pms.javabeans.PortalPageLinkBean;
import com.stpl.pms.struts.common.BaseActionSupport;
//import com.stpl.pms.utility.Utility;

public class GraphicsAction extends BaseActionSupport{
}
	/*
	private static final long serialVersionUID = 1L;
	private short domainId;
	private String graphicsType;
	private String graphicSize;
	private String relatedTo;
	private List<Integer> languageList;
	private List<Integer> currencyList;
	private List<File> graphicsPath;
	private List<String> graphicsPathContentType;
	private List<String> graphicsPathFileName;
	private List<String> graphicsPathString;
	private String[] graphicsPathStringNew;
	private String textAreaId;
	private String currency;
	private List<StGenVariableMaster> variablesBeanList;
	private List<PortalPageLinkBean> pageLinkList;
	private String pageName;
	private String pageMetaTag;
	private String pageTitle;
	private String pageKeyword;
	private String pageDescription;
	private String[] pageHTML;
	private Map<String, String> graphicsUrlDetail;
	
	public List<Integer> getLanguageList() {
		return languageList;
	}

	public void setLanguageList(List<Integer> languageList) {
		this.languageList = languageList;
	}

	public List<Integer> getCurrencyList() {
		return currencyList;
	}

	public void setCurrencyList(List<Integer> currencyList) {
		this.currencyList = currencyList;
	}

	public List<String> getGraphicsPathString() {
		return graphicsPathString;
	}

	public void setGraphicsPathString(List<String> graphicsPathString) {
		this.graphicsPathString = graphicsPathString;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public String getPageName() {
		return pageName;
	}

	public void setPageName(String pageName) {
		this.pageName = pageName;
	}

	public String getPageMetaTag() {
		return pageMetaTag;
	}

	public void setPageMetaTag(String pageMetaTag) {
		this.pageMetaTag = pageMetaTag;
	}

	public String getPageTitle() {
		return pageTitle;
	}

	public void setPageTitle(String pageTitle) {
		this.pageTitle = pageTitle;
	}

	public String getPageKeyword() {
		return pageKeyword;
	}

	public void setPageKeyword(String pageKeyword) {
		this.pageKeyword = pageKeyword;
	}

	public String getPageDescription() {
		return pageDescription;
	}

	public void setPageDescription(String pageDescription) {
		this.pageDescription = pageDescription;
	}

	public String[] getPageHTML() {
		return pageHTML;
	}

	public void setPageHTML(String[] pageHTML) {
		this.pageHTML = pageHTML;
	}

	public short getDomainId() {
		return domainId;
	}

	public void setDomainId(short domainId) {
		this.domainId = domainId;
	}

	public String getRelatedTo() {
		return relatedTo;
	}

	public void setRelatedTo(String relatedTo) {
		this.relatedTo = relatedTo;
	}
	
	public void setGraphicsType(String graphicsType) {
		this.graphicsType = graphicsType;
	}

	public String getGraphicsType() {
		return graphicsType;
	} 
	
	private String getStaticContentPath(CommonMethodController controller, String langType, String langCode, Short aliasId) throws PMSException {
		StringBuilder filePath = new StringBuilder("");
		StDmDomainAliasNameMaster aliasMaster = controller.getAliasMaster(aliasId);
		String domainName = aliasMaster.getDomainMaster().getDomainName();
		String aliasName = aliasMaster.getAliasName();
		filePath.append(domainName);
		filePath.append("|");
		filePath.append(aliasName);
		filePath.append("|");
		filePath.append(controller.fetchAliasLayout(aliasId,"pc"));
		filePath.append("|");
		filePath.append("pc");
		filePath.append("|");
		filePath.append(langType);
		filePath.append("|");
		filePath.append(graphicsType.toLowerCase());
		filePath.append("|");
		filePath.append(langCode);
		return filePath.toString();
	}
	public String uploadGraphics(){
		CommonMethodController controller = CommonMethodController.getInstance();
		GraphicsMasterBean graphicsBean = new GraphicsMasterBean();
		graphicsBean.setDomainId(domainId);
		graphicsBean.setAliasId(aliasId);
		graphicsBean.setGraphicsType(graphicsType);
		graphicsBean.setSize(graphicSize);
		graphicsBean.setRelatedTo(relatedTo);
		graphicsBean.setCurrency(currencyList);
		String result = null;
		String defaultPath=null;
		List<String> uploadContentList = new ArrayList<String>();
		try {
			Map<String, String> propMap = controller.getDmPropertyMap(domainId,"languageId","currencyId");
			if(languageList == null){
				languageList = new ArrayList<Integer>();
			}
			languageList.add(0, Integer.parseInt(propMap.get("languageId")));
			if(currencyList == null) {
				currencyList = new ArrayList<Integer>();
			}
			currencyList.add(0, Integer.parseInt(propMap.get("currencyId")));
			graphicsPathString = new ArrayList<String>();
			CurrencyBean curBean = controller.fetchCurrencyMasterBean( Integer.parseInt(propMap.get("currencyId")));
			LanguageBean langBean = controller.fetchLanguageMasterBean(Integer.parseInt(propMap.get("languageId")));
			String filePath=getStaticContentPath(controller, "LR", langBean.getLanguageBaseCode(), aliasId)+"|"+curBean.getCurrCode();
			defaultPath = controller.fetchSystemProperties("DEFAULT_CONTENT_PATH")+(filePath.replace('|', '/'));
			graphicsUrlDetail = new HashMap<String, String>();
			for (int i = 0; i < graphicsPath.size(); i++) {
				File uploadedFile = graphicsPath.get(i);
				String fileName = graphicsPathFileName.get(i).replaceAll("\\s","");
				int indexNew = fileName.lastIndexOf('.');
				String fileNameNew = fileName.substring(0, indexNew)+Calendar.getInstance().getTimeInMillis()+fileName.substring(indexNew, fileName.length());
				
				Utility.saveOrUpdateContent(uploadedFile,fileNameNew,filePath );
				graphicsPathString.add(fileNameNew);
				graphicsUrlDetail.put(fileName, defaultPath+'/'+fileNameNew);
			}
			graphicsBean.setGraphicsPath(graphicsPathString);
			graphicsBean.setLanguage(languageList);
			graphicsBean.setCurrency(currencyList);
			GraphicsMgmtController graphicsController = new GraphicsMgmtController();
			result = graphicsController.uploadGraphics(graphicsBean);
			if("success".equals(result)) {
				graphicsController.addUploadContent(uploadContentList);
				return SUCCESS;
			}
		} 
		catch (PMSException e) {
    		e.printStackTrace();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return ERROR;
	}
	
	public void setTextAreaId(String textAreaId) {
		this.textAreaId = textAreaId;
	}

	public String getTextAreaId() {
		return textAreaId;
	}

	public void setVariablesBeanList(List<StGenVariableMaster> variablesBeanList) {
		this.variablesBeanList = variablesBeanList;
	}

	public List<StGenVariableMaster> getVariablesBeanList() {
		return variablesBeanList;
	}

	public void setPageLinkList(List<PortalPageLinkBean> pageLinkList) {
		this.pageLinkList = pageLinkList;
	}

	public List<PortalPageLinkBean> getPageLinkList() {
		return pageLinkList;
	}

	public List<File> getGraphicsPath() {
		return graphicsPath;
	}

	public void setGraphicsPath(List<File> graphicsPath) {
		this.graphicsPath = graphicsPath;
	}

	public List<String> getGraphicsPathContentType() {
		return graphicsPathContentType;
	}

	public void setGraphicsPathContentType(List<String> graphicsPathContentType) {
		this.graphicsPathContentType = graphicsPathContentType;
	}

	public List<String> getGraphicsPathFileName() {
		return graphicsPathFileName;
	}

	public void setGraphicsPathFileName(List<String> graphicsPathFileName) {
		this.graphicsPathFileName = graphicsPathFileName;
	}

	public void setGraphicsPathStringNew(String[] graphicsPathStringNew) {
		this.graphicsPathStringNew = graphicsPathStringNew;
	}

	public String[] getGraphicsPathStringNew() {
		return graphicsPathStringNew;
	}

	public void setGraphicSize(String graphicSize) {
		this.graphicSize = graphicSize;
	}

	public String getGraphicSize() {
		return graphicSize;
	}
	public Map<String, String> getGraphicsUrlDetail() {
		return graphicsUrlDetail;
	}
	public void setGraphicsUrlDetail(Map<String, String> graphicsUrlDetail) {
		this.graphicsUrlDetail = graphicsUrlDetail;
	}
}*/