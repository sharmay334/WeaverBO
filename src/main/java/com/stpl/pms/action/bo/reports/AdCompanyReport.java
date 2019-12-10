package com.stpl.pms.action.bo.reports;
/*
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Type;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.opensymphony.xwork2.Action;
import com.stpl.pms.controller.misc.AffilateAdCompanyController;
import com.stpl.pms.controller.reports.exportExcel.ReportToExcel;*/
import com.stpl.pms.struts.common.BaseActionSupport;

public class AdCompanyReport extends BaseActionSupport{
}

/*	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger.getLogger(AdCompanyReport.class);
	
	private short domainId;
	private short aliasId;
	private String affiliateName;
	private String offerId;
	private Timestamp fromDate;
	private Timestamp toDate;
	private List<String[]> resultList;	
	private String startIndex;
	private String recordTofetch;
	private String reportData;
	private String redirect;
	
	public String checkAdCompany(){
		logger.info("--Inside checkAdCompany---");
		
		if(new AffilateAdCompanyController().checkAdCompanyName(userInfoBean.getRoleName()))
			affiliateName=userInfoBean.getRoleName();
		
		return SUCCESS;
	}
	
	public void getOfferIdForAffilateName(){
		logger.info("Call  getAffilateName Start");
		try{
			List <String> dataList =new AffilateAdCompanyController().
					searchAdCompanyOrderIdDomainAliasWise(aliasId, domainId,affiliateName);
			
			response.getWriter().write(
					new Gson().toJson(dataList));
		}catch (Exception e) {
			addActionError("Some internal error.");		
		}	
		logger.info("Call  getAffilateName End");
	}
	
	
	public String adCompanyReport() throws Exception{		
		
		Gson data = new GsonBuilder().create();
		Type dataType = new TypeToken<Map<String, String>>() {
		}.getType();
		Map<String, String> paramMap = data.fromJson(reportData, dataType);
		
		if (redirect != null && redirect.equals("Excel")) {
            exportExcelPlrWiseRep(paramMap);
            return Action.NONE;
        }
		
		paramMap.put("startIndex", startIndex);
		paramMap.put("recordTofetch", recordTofetch);
		logger.info(paramMap);
		resultList = new AffilateAdCompanyController().affilateReportData(paramMap,"AdCompany"); 
			
		request.getSession().setAttribute("dataTableValue", resultList);
		return SUCCESS;
	}
	
	 public void exportExcelPlrWiseRep(Map<String, String> paramMap) {
	        response.setContentType("application/vnd.ms-excel");
	        response.setHeader("Content-Disposition", "attachment; filename="
	                 + "AdCompany_" + Calendar.getInstance().getTimeInMillis() + ".xlsx");
	        	    	
	        //OutputStream out = null;
	        
	        try {
	            OutputStream out = new BufferedOutputStream(response.getOutputStream());
	            ReportToExcel excel = new ReportToExcel();
	         

	            SXSSFWorkbook wb = excel.plrTxnExcelReport(paramMap, "AdCompany");
	            wb.write(out);
	            out.flush();
	            out.close();
	            wb.dispose();
	        } catch (IOException e) {
	            e.printStackTrace();
	        } catch (Exception be) {
	            be.printStackTrace();
	        }

	    }	
	
	public short getDomainId() {
		return domainId;
	}
	public void setDomainId(short domainId) {
		this.domainId = domainId;
	}
	public short getAliasId() {
		return aliasId;
	}
	public void setAliasId(short aliasId) {
		this.aliasId = aliasId;
	}
	public String getAffiliateName() {
		return affiliateName;
	}
	public void setAffiliateName(String affiliateName) {
		this.affiliateName = affiliateName;
	}
	public String getOfferId() {
		return offerId;
	}
	public void setOfferId(String offerId) {
		this.offerId = offerId;
	}
	public Timestamp getFromDate() {
		return fromDate;
	}
	public void setFromDate(Timestamp fromDate) {
		this.fromDate = fromDate;
	}
	public Timestamp getToDate() {
		return toDate;
	}
	public void setToDate(Timestamp toDate) {
		this.toDate = toDate;
	}

	public List<String[]> getResultList() {
		return resultList;
	}

	public void setResultList(List<String[]> resultList) {
		this.resultList = resultList;
	}

	public String getReportData() {
		return reportData;
	}

	public void setReportData(String reportData) {
		this.reportData = reportData;
	}

	public String getStartIndex() {
		return startIndex;
	}

	public void setStartIndex(String startIndex) {
		this.startIndex = startIndex;
	}

	public String getRecordTofetch() {
		return recordTofetch;
	}

	public void setRecordTofetch(String recordTofetch) {
		this.recordTofetch = recordTofetch;
	}

	public String getRedirect() {
		return redirect;
	}

	public void setRedirect(String redirect) {
		this.redirect = redirect;
	}
	
	
	
}
*/