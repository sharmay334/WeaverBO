package com.stpl.pms.action.bo.reports;

//import java.io.BufferedOutputStream;
//import java.io.IOException;
//import java.io.OutputStream;
//import java.io.PrintWriter;
//import java.lang.reflect.Type;
//import java.util.Calendar;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpSession;
//
//import org.apache.log4j.Logger;
//import org.apache.poi.xssf.streaming.SXSSFWorkbook;
//
//import com.google.gson.Gson;
//import com.google.gson.GsonBuilder;
//import com.google.gson.reflect.TypeToken;
//import com.opensymphony.xwork2.Action;
//import com.stpl.pms.controller.reports.IncomeTaxReportController;
//import com.stpl.pms.controller.reports.exportExcel.ReportToExcel;
//import com.stpl.pms.exception.PMSException;
//import com.stpl.pms.hibernate.mapping.StGenStateMaster;
import com.stpl.pms.struts.common.BaseActionSupport;
//import com.stpl.pms.utility.Utility;

/**
 * Created by stpl on 24/11/17.
 */
public class IncomeTaxReportAction extends BaseActionSupport {
}
 /*   private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(IncomeTaxReportAction.class);

    private String procName;
    private String reportData;
    Map<String, String> ParamMap = new HashMap<String, String>();
    private String redirect;
    private String startIndex;
    private String recordTofetch;
    private List<Object[]> resultList;
    private int resultSize;
    private String reportTypeName;
    private int count;
    private List<Object[]> dataListReqNotFound;
    private List<Object[]> dataListStatusUnmatched;
    private String jsonList;
    private List<StGenStateMaster> taxStateTypeList;

    public List<StGenStateMaster> getTaxStateTypeList() {
        return taxStateTypeList;
    }

    public void setTaxStateTypeList(List<StGenStateMaster> taxStateTypeList) {
        this.taxStateTypeList = taxStateTypeList;
    }

    public List<Object[]> getDataListReqNotFound() {
        return dataListReqNotFound;
    }

    public void setDataListReqNotFound(List<Object[]> dataListReqNotFound) {
        this.dataListReqNotFound = dataListReqNotFound;
    }

    public List<Object[]> getDataListStatusUnmatched() {
        return dataListStatusUnmatched;
    }

    public void setDataListStatusUnmatched(List<Object[]> dataListStatusUnmatched) {
        this.dataListStatusUnmatched = dataListStatusUnmatched;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public String getRecordTofetch() {
        return recordTofetch;
    }

    public void setRecordTofetch(String recordTofetch) {
        this.recordTofetch = recordTofetch;
    }

    public List<Object[]> getResultList() {
        return resultList;
    }

    public void setResultList(List<Object[]> resultList) {
        this.resultList = resultList;
    }

    public int getResultSize() {
        return resultSize;
    }

    public void setResultSize(int resultSize) {
        this.resultSize = resultSize;
    }

    public String getReportTypeName() {
        return reportTypeName;
    }

    public void setReportTypeName(String reportTypeName) {
        this.reportTypeName = reportTypeName;
    }

    public String getProcName() {
        return procName;
    }

    public void setProcName(String procName) {
        this.procName = procName;
    }

    public String getReportData() {
        return reportData;
    }

    public void setReportData(String reportData) {
        this.reportData = reportData;
    }

    public Map<String, String> getParamMap() {
        return ParamMap;
    }

    public void setParamMap(Map<String, String> paramMap) {
        ParamMap = paramMap;
    }

    public String getRedirect() {
        return redirect;
    }

    public void setRedirect(String redirect) {
        this.redirect = redirect;
    }

    public String getStartIndex() {
        return startIndex;
    }

    public void setStartIndex(String startIndex) {
        this.startIndex = startIndex;
    }
    public String getJsonList() {
        return jsonList;
    }

    public void setJsonList(String jsonList) {
        this.jsonList = jsonList;
    }

    @SuppressWarnings("unchecked")
    public String dataTableResult() {
        HttpSession session = request.getSession();
        if (count == 0) {
            resultList = (List<Object[]>) session.getAttribute("dataTableValue");
            if (resultList.size() == 101 || resultList.size() == 376)
                resultList.remove(resultList.size() - 1);
            session.removeAttribute("dataTableValue");
        }
        if (count == 1) {
            dataListReqNotFound = (List<Object[]>) session.getAttribute("ReqNoFound");
            session.removeAttribute("ReqNoFound");
        }
        if (count == 2) {
            dataListStatusUnmatched = (List<Object[]>) session.getAttribute("statusUnmatched");
            session.removeAttribute("statusUnmatched");
        }
        return SUCCESS;
    }

    public String fetchPlayerWiseReport() {
        logger.info("--Start Player Wise Income Tax Reports--");
        Gson data = new GsonBuilder().create();
        Type dataType = new TypeToken<Map<String, String>>() {
        }.getType();
        ParamMap = data.fromJson(reportData, dataType);
        IncomeTaxReportController controller = new IncomeTaxReportController();
        try {
            if (ParamMap.containsKey("proceName")) {
                procName = ParamMap.get("proceName");
                ParamMap.remove("proceName");
            }
            ParamMap = controller.getMisParamMap(ParamMap, procName);
            if (redirect != null && redirect.equals("Excel")) {
                exportExcelPlrWiseRep();
                return Action.NONE;
            }
            if (!(ParamMap.containsKey("startIndex"))) {
                ParamMap.put("startIndex", startIndex);
                ParamMap.put("recordTofetch", recordTofetch);
            }
            ParamMap=IncomeTaxReportController.ReportCondition(ParamMap);
            logger.info(ParamMap);

            resultList = controller.setTaxDetail(controller.fetchTaxReportsData(ParamMap, procName), ParamMap.get("startIndex"),ParamMap.get("fromDate"));
            logger.info(resultList);
            resultSize = resultList.size();
            request.setAttribute("responselength",resultList.size());
            request.setAttribute("IGST",controller.getGstRate());
            request.setAttribute("CGST",(controller.getGstRate()/2));
            request.setAttribute("SGST",(controller.getGstRate()/2));
            request.getSession().setAttribute("dataTableValue", resultList);
            new ReportsAction().domaiNameSet(ParamMap);
        } catch (PMSException e) {
            e.printStackTrace();
            addActionError(e.getErrorMessage());
            if (e.getErrorCode() != null && e.getErrorCode() == 507) {
                return "limitReportData";
            } else {
                return "exception_nodecorate";
            }
        }
        return procName;
    }

    public void exportExcelPlrWiseRep() {
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment; filename="
                 + "ITReport_" + Calendar.getInstance().getTimeInMillis() + ".xlsx");
        //OutputStream out = null;
        try {
            OutputStream out = new BufferedOutputStream(response.getOutputStream());
            ReportToExcel excel = new ReportToExcel();
            if (redirect == null) {
                Gson data = new GsonBuilder().create();
                Type dataType = new TypeToken<Map<String, String>>() {
                }.getType();
                reportData = reportData.replaceAll("=", "\":\"").replaceAll(", ", "\",\"");
                reportData = "{\"" + reportData.substring(1, reportData.length() - 1) + "\"}";
                ParamMap = data.fromJson(reportData, dataType);
            }

            SXSSFWorkbook wb = excel.plrTxnExcelReport(ParamMap, reportTypeName);
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

    public void fetchReportOnClick() throws IOException {
        logger.info("--Start Player IncomeTax Reports--");
        Gson data = new GsonBuilder().create();
        Type dataType = new TypeToken<Map<String, String>>() {
        }.getType();
        ParamMap = data.fromJson(reportData, dataType);
        IncomeTaxReportController controller = new IncomeTaxReportController();
        try {
            if (ParamMap.containsKey("proceName")) {
                procName = ParamMap.get("proceName");
                ParamMap.remove("proceName");
            }

            ParamMap = controller.getParamMap(ParamMap, procName);
            ParamMap=IncomeTaxReportController.ReportCondition(ParamMap);
            logger.info(ParamMap);
            resultList = controller.setTaxDetail(controller.fetchTaxReportsData(ParamMap, procName), ParamMap.get("startIndex"),ParamMap.get("fromDate"));
            resultSize = resultList.size();

            request.getSession().setAttribute("dataTableValue", resultList);
            request.setAttribute("IGST",controller.getGstRate());
            request.setAttribute("CGST",(controller.getGstRate()/2));
            request.setAttribute("SGST",(controller.getGstRate()/2));

            if (resultList.size() > 0) {
                response.getWriter().write(new Utility().convertJSON(resultList));
            } else
                response.getWriter().write("{}");
            new ReportsAction().domaiNameSet(ParamMap);
        } catch (PMSException e) {
            e.printStackTrace();
            addActionError(e.getErrorMessage());
        } catch (Exception be) {
            addActionError("Some internal error.");
            be.printStackTrace();
        }
    }

    public void getStateTaxReport() {

        PrintWriter out = null;
        String jsonMap = null;
        try {

                IncomeTaxReportController controller = new IncomeTaxReportController();
                Gson gson = new Gson();
                Map<String, List> map = new HashMap<String, List>();
                taxStateTypeList = controller.getStatesForTax();
                map.put("stateList", taxStateTypeList);
                jsonMap = gson.toJson(map);
                System.out.println(jsonMap);
                out = response.getWriter();
                out.write(jsonMap);


        }catch (PMSException e) {
            e.printStackTrace();
            addActionError(e.getErrorMessage());
        }catch (Exception e) {
            e.printStackTrace();
        }
    }


}*/