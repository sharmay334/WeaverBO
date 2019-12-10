package com.stpl.pms.action.bo.cashier;

//import java.io.BufferedOutputStream;
//import java.io.ByteArrayInputStream;
//import java.io.File;
//import java.io.IOException;
//import java.io.InputStream;
//import java.io.OutputStream;
//import java.io.PrintWriter;
//import java.lang.reflect.Type;
//import java.sql.Timestamp;
//import java.text.ParseException;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Calendar;
//import java.util.Date;
//import java.util.HashMap;
//import java.util.Iterator;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpSession;
//import javax.xml.bind.JAXBContext;
//import javax.xml.bind.Unmarshaller;
//
//import org.apache.commons.beanutils.BeanUtils;
//import org.apache.commons.lang.WordUtils;
//import org.apache.log4j.Logger;
//import org.apache.poi.xssf.streaming.SXSSFWorkbook;
//
//import com.google.gson.Gson;
//import com.google.gson.GsonBuilder;
//import com.google.gson.reflect.TypeToken;
//import com.stpl.gateway.toloyalty.GatewayToLoyalty;
//import com.stpl.loyalty.common.Log;
//import com.stpl.pms.commonJavabeans.DepositRequestBean;
//import com.stpl.pms.controller.cashier.BOCashierController;
//import com.stpl.pms.controller.cashier.CashierController;
//import com.stpl.pms.controller.commonMethods.CommonMethodController;
//import com.stpl.pms.controller.reports.exportExcel.ReportToExcel;
//import com.stpl.pms.exception.PMSErrorMessage;
//import com.stpl.pms.exception.PMSException;
//import com.stpl.pms.hibernate.mapping.StCshPaySubMaster;
//import com.stpl.pms.hibernate.mapping.StCshPaymentTypeMaster;
//import com.stpl.pms.hibernate.mapping.StCshPlrDepositRequest;
//import com.stpl.pms.hibernate.mapping.StRmVendorMaster;
//import com.stpl.pms.hibernate.mapping.StTxnWagerMaster;
//import com.stpl.pms.javabeans.CountryBean;
//import com.stpl.pms.javabeans.CurrencyBean;
//import com.stpl.pms.javabeans.PODMProcessingChargeBean;
//import com.stpl.pms.javabeans.PayOptBean;
//import com.stpl.pms.javabeans.PaySubTypeBean;
//import com.stpl.pms.javabeans.PaySubTypes;
//import com.stpl.pms.javabeans.PaymentOptionTypeBean;
//import com.stpl.pms.javabeans.PaymentProviderBean;
//import com.stpl.pms.javabeans.PaymentTypeBean;
//import com.stpl.pms.javabeans.PaymentTypeContentBean;
//import com.stpl.pms.javabeans.PlayerInfoBean;
//import com.stpl.pms.javabeans.PlayerPaymentCorrection;
//import com.stpl.pms.javabeans.PlrFraudReqBean;
//import com.stpl.pms.javabeans.PlrRedeemAccBankInfoBean;
//import com.stpl.pms.javabeans.TxnSearchBean;
//import com.stpl.pms.javabeans.UnclaimedTxnBean;
//import com.stpl.pms.javabeans.VipLevelMasterBean;
//import com.stpl.pms.javabeans.WithdrawalTxnBean;
import com.stpl.pms.struts.common.BaseActionSupport;
//import com.stpl.pms.utility.Utility;

public class CashierAction extends BaseActionSupport {
}
/*	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger.getLogger(CashierAction.class);
	protected static final String BULK_PAYMENT_CORRECTION_RUNNING = "bulkPlrPaymentCorrectionRunning";

	private int countryId;
	private int currencyId;
	private String txnType;
	private int vipLevelId;
	private Map<Integer, PaymentOptionTypeBean> pomMap;
	private Map<Long, PODMProcessingChargeBean> podmProcessingChargeMap;
	private List<PODMProcessingChargeBean> podmProcessingChargeBean;
	private String podmProcessingChargeStr;
	private long[] pomId;
	private short[] priorityOrder;
	private TxnSearchBean txnSearchBean;
	private Map<Long, WithdrawalTxnBean> wdrTxnMap;
	private String wdrTxnStr;
	private Map<Long, DepositRequestBean> depositReqMap;
	private long[]txnIds;
	private String wdrStatus;
	private String withdrawalJsonData;
	private String processedWithdrawalJsonData;
	private String depositJsonData;
	private String contentJsonData;
	private String paymentTypeCode;
	private boolean generateExcel;
	private Map<Integer, PaymentTypeBean>offlinePayTypeMap;
	private Map<Integer, PaymentTypeContentBean>payTypeContentMap;
	private long[]requestIds;
	
	private Map<Integer, String> paymentProviderMap;
	private File pgSettlementReport;
	private String providerName;
	private Integer providerId;
	private String pgSettlementReportFileName;
	private File settlementSheet;
	private File pokerSettlement;
	private String pokerSettlementFileName;
	private String settlementSheetFileName;
	


	private File paytmSettlement;
	private String paytmSettlementFileName;
	private String correctionList;
	
	private String deploymentDate;
	
	private String settlementType;
	private String firstName;
	private String lastName;
	private String userName;
	private List<PlayerInfoBean> plrList;
	private PlayerPaymentCorrection payCorrection;
	private PlrFraudReqBean plrFraudReqBean;
	private Map<Short, List<VipLevelMasterBean>> vipLevelMap;
	private Map<Integer, CurrencyBean> currencyMap;
	private List<VipLevelMasterBean> domainVipList;
	private List<Integer> vipList;
	private List<PlrRedeemAccBankInfoBean> redAccList;
	private long playerId;
	private long[] redAccIds;
	private String status;
	private String actionMessage;
	private Timestamp fromDate;
	private Timestamp toDate;
	private String device;
	private List<Object> resultList;
	private String reason;
	private String downloadParam;
	private long tableId;
	private String subWalletTime;
	private double amt;
	private long requestId;
	private long redeemAccIdEdit;
	private String beneficiaryName;
	private String accNum;
	private Integer subtypeId;
	private String branchLocation;
	private String branchCity;
	private String branchAddress;
	private String ifscCode;
	private String micrCode;
	
	private Map<String,Integer> bankMap;
	private PlrRedeemAccBankInfoBean redAccBankBean;
	private String bankCode;
	private String provider;
	private Map<String,Short> gameServiceMap;
	private Short gameServiceId;
	private String gameServiceCode;
	private Timestamp wagerFromDate;
	private Timestamp wagerToDate;
	private List<StTxnWagerMaster> wagerList;
	private List<StCshPaymentTypeMaster> payTypeMasterList;
	private List<StCshPaySubMaster> paySubTypesList;
	private PaySubTypeBean paySubType;
	private Map<Integer,String> countryMap;
	private Map<Long, String> procChargMap;
	private PayOptBean payOptBean;
	private Integer paymentTypeId;
	private List<Long> tids;
	private String playerList;
	private int startSubwalletId;
	private String previousFlag; 
	private String isLastPage;
	private String displaySize;
	List<UnclaimedTxnBean> unclaimedRecords;
	private UnclaimedTxnBean unclaimedTxn;
	private short domainId;
	private String correctionType;
	private String withdrawableImpact;
	
	public String getDomainNameList() {
		CommonMethodController controller = CommonMethodController.getInstance();
		try {
			domainMap = controller.getDomainIdMap();
		}  catch (PMSException pmse) {
			pmse.printStackTrace();
			addActionError(pmse.getErrorMessage());
			return "exception";
		}
		
		return SUCCESS;
	}
	

	{
		SimpleDateFormat sdfSource = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdfDestination =new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		Date date;
		try {
			date = sdfSource.parse(CommonMethodController.getInstance().fetchSystemProperties("DEPLOYE_DATE"));
			deploymentDate = sdfDestination.format(date);
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public String podmSetupMenu() {
		logger.info("--Show PODM Setup Menu--");
		CommonMethodController controller = CommonMethodController.getInstance();
		try {
			domainMap = controller.getDomainIdMap();
		}  catch (PMSException pmse) {
			pmse.printStackTrace();
			addActionError(pmse.getErrorMessage());
			return "exception";
		}
		return SUCCESS;
	}

	
	public void reQueryEBS(){
		logger.info("--reQuery Starts-");
		InputStream is = null;
		JAXBContext jaxContext = null;
		Unmarshaller un = null;
		 OutputReQueryEbs output = null;
		try {
			BOCashierController controller = new BOCashierController();
			CashierController con = new CashierController();
			List<StCshPlrDepositRequest> depReq = controller.getDepositRequesData(requestId);
			
			if(depReq != null && depReq.size()==1){
				String param = controller.getEBSParamData(requestId);
				logger.info("---Request to EBS---"+param);
				int []timeout = {5000,10000};
				String respData = Utility.callUrl("https://api.secure.ebs.in/api/status", param.toString(),timeout);
				logger.info("--response from EBS--"+respData);
            	 
				if (respData.indexOf("Exceeded 90 days from the date of transaction") >= 0) {
					 response.getWriter().write(new Utility().convertJSON("Exceeded 90 days from the date of transaction."));
				}else if(respData.indexOf("No Records Found") >= 0) {
					 response.getWriter().write(new Utility().convertJSON("No Record Found"));
				}
				else{
					 is = new ByteArrayInputStream(respData.getBytes("UTF-8"));
					 jaxContext = JAXBContext.newInstance(OutputReQueryEbs.class);
		             un = jaxContext.createUnmarshaller();
		             output = (OutputReQueryEbs) un.unmarshal(is);
		            if("Captured".equals(output.getStatus())  && depReq.get(0).getPayOptDomMapping()
							.getProcessingChargeMas() != null){
		            	 con.updateEbsResponse(requestId,output);
		            	 con.updateDepositRequest(requestId,depReq);
		            	 boolean isFirstDeposit = depReq.get(0).getPlrMaster()
			     					.getPlayerWallet().getTotalDeposit() == 0.0;
			            	 if (isFirstDeposit) {
			     				con.updateFirstDepositDate(depReq.get(0));
			     			}
		            	  if("Y".equals(depReq.get(0).getPlrMaster().getPhoneVerified())){
		            		  con.sendSms(depReq);
            	 }
		            	 response.getWriter().write(new Utility().convertJSON("success"));
		             }else if("AuthFailed".equals(output.getStatus())){
		            	 response.getWriter().write(new Utility().convertJSON("fail"));
		             }
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	
	public void reQueryAtom(){
		logger.info("--reQuery Starts-");
		InputStream is = null;
		JAXBContext jaxContext = null;
		Unmarshaller un = null;
		OutputReQueryAtom output = null;
		try {
			BOCashierController controller = new BOCashierController();
			CashierController con = new CashierController();
			List<StCshPlrDepositRequest> depReq = controller.getDepositRequesData(requestId);
			if(depReq != null && depReq.size()==1){
				String param = controller.getAtomParamData(requestId);
				logger.info("---Request to ATOM---"+param);
				int []timeout = {5000,10000};
				String respData = Utility.callUrl("https://payment.atomtech.in/paynetz/vfts", param.toString(),timeout);
				logger.info("--response from ATOM--"+respData);
				
				is = new ByteArrayInputStream(respData.getBytes("UTF-8"));
				 jaxContext = JAXBContext.newInstance(OutputReQueryAtom.class);
	             un = jaxContext.createUnmarshaller();
	             output = (OutputReQueryAtom) un.unmarshal(is);
	            if("SUCCESS".equals(output.getVerified())  && depReq.get(0).getPayOptDomMapping()
						.getProcessingChargeMas() != null){
	            	 con.updateAtomResponse(requestId,output);
	            	 con.updateDepositRequest(requestId,depReq);
	            	 boolean isFirstDeposit = depReq.get(0).getPlrMaster()
	     					.getPlayerWallet().getTotalDeposit() == 0.0;
	            	 if (isFirstDeposit) {
	     				con.updateFirstDepositDate(depReq.get(0));
	     			}
	            	  if("Y".equals(depReq.get(0).getPlrMaster().getPhoneVerified())){
	            		  con.sendSms(depReq);
            	 }
	            	 response.getWriter().write(new Utility().convertJSON("success"));
	            	// addActionMessage("Requery made and system has been updated according to the payment gateway response.");
	             }else if("FAILED".equals(output.getVerified())){
	            	 response.getWriter().write(new Utility().convertJSON("fail"));
	             }else if("NODATA".equals(output.getVerified())){
	            	 response.getWriter().write(new Utility().convertJSON("No Record Found"));
	             }
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	public void reQueryCashFree(){
		logger.info("--reQuery Starts-");
		try {
			BOCashierController controller = new BOCashierController();
			CashierController con = new CashierController();
			List<StCshPlrDepositRequest> depReq = controller.getDepositRequesData(requestId);
			if(depReq != null && depReq.size()==1){
				String param = controller.getCashFreeParamData(requestId);
				logger.info("---Request to CashFree---"+param);
				int []timeout = {5000,10000};
				String respData = Utility.callUrl("https://api.gocashfree.com/api/v1/order/info/status", param.toString(),timeout);
				logger.info("--response from CashFree--"+respData);
				if (respData.indexOf("PAID") >= 0) {
					//OutputRequeryCashfree output = new Gson().fromJson(respData, OutputRequeryCashfree.class);
					con.updateCashFreeResponse(requestId);
	            	 con.updateDepositRequest(requestId,depReq);
	            	 boolean isFirstDeposit = depReq.get(0).getPlrMaster()
	     					.getPlayerWallet().getTotalDeposit() == 0.0;
	            	 if (isFirstDeposit) {
	     				con.updateFirstDepositDate(depReq.get(0));
	     			}
	            	  if("Y".equals(depReq.get(0).getPlrMaster().getPhoneVerified())){
	            		  con.sendSms(depReq);
           	 }
	            	 response.getWriter().write(new Utility().convertJSON("success"));
					
				}else if(respData.indexOf("ACTIVE") >= 0) {
					 response.getWriter().write(new Utility().convertJSON("Payment for the order has not completed yet."));
				}
				else if(respData.indexOf("FAILED") >= 0) {
					 response.getWriter().write(new Utility().convertJSON("No Record Found"));
				}
			
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	public String podmSetupSearch() {
		logger.info("--Show PODM Setup Search--");
		try {
			BOCashierController controller = new BOCashierController();
			pomMap = controller.searchPaymentOptions(domainId,aliasId, countryId,
					currencyId, vipLevelId, txnType,device);
			domainVipList = CommonMethodController.getInstance().fetchDomainVipLevelList(domainId,"");
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

	public String podmSetupSave() {
		logger.info("--Show PODM Setup Save--");
		try {
			BOCashierController controller = new BOCashierController();
			List<PaymentProviderBean> pomProviderList = new ArrayList<PaymentProviderBean>();
			PaymentProviderBean pomBean;
			if (vipList==null || vipList.size()==0) {
				throw new PMSException("Please select atleast one vip level");
			}
			if (pomId!=null) {
				for (int i = 0; i < pomId.length; i++) {
					pomBean = new PaymentProviderBean();
					pomBean.setPomId(pomId[i]);
					pomBean.setPriorityOrder(priorityOrder[i]);
					pomProviderList.add(pomBean);
				}
			}
			
			controller.savePaymentOptions(domainId,aliasId, countryId, currencyId,
					vipList, txnType, pomProviderList, userInfoBean.getUserId(),device);
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}
		catch(Exception ex){
			ex.printStackTrace();
			addActionError("Some Internal Error");
			return "exception";
		}
		return SUCCESS;
	}
	
	public String podProcessChargeMenu() {
		logger.info("--Search Payment Option Domain Wise Processing Charge--");
		CommonMethodController controller = CommonMethodController.getInstance();
		try {
			domainMap = controller.getDomainIdMap();
		}  catch (PMSException pmse) {
			pmse.printStackTrace();
			addActionError(pmse.getErrorMessage());
			return "exception";
		}
		return SUCCESS;
	}

	public String podProcessChargeSearch() {
		logger
				.info("--Search Payment Option Domain Wise Processing Charge Start--");
		try {
			BOCashierController controller = new BOCashierController();
			pomMap = new HashMap<Integer, PaymentOptionTypeBean>();
			podmProcessingChargeMap = new HashMap<Long, PODMProcessingChargeBean>();
			controller.podProcessChargeSearch(domainId, countryId, currencyId,
					vipLevelId, txnType, pomMap, podmProcessingChargeMap,device);
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

	public String podProcessChargeSave() {
		BOCashierController controller = new BOCashierController();

		try {
			Gson wdrData = new GsonBuilder().create();
			Type wdrMapType = new TypeToken<List<PODMProcessingChargeBean>>() {
			}.getType();
			podmProcessingChargeBean = wdrData.fromJson(
					podmProcessingChargeStr, wdrMapType);
			controller.podProcessChargeSave(podmProcessingChargeBean, userInfoBean.getUserId());
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

	public String initWithdrawalMenu() {
		wdrStatus = "PENDING";
		return SUCCESS;
	}

	public String processWithdrawalMenu() {
		wdrStatus = "INITIATED";
		return SUCCESS;
	}

	public void getWithdrawalPayType() {
		logger.info("--Get Withdrawal Payment Type--");
		BOCashierController controller = new BOCashierController();
		try {
			pomMap = controller.searchPaymentOptions(domainId, aliasId,countryId,
					currencyId, vipLevelId, "WITHDRAWAL",device);
			PrintWriter out = response.getWriter();
			if (pomMap.size() > 0) {
				response.setContentType("application/json");
				out.write(new Utility().convertJSON(pomMap));
				return;
			}
			out.write("error");
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}catch (Exception be) {
			be.printStackTrace();
		}

	}

	public String withdrawalSearch() {
		logger.info("--Search Withdrawal--");
		BOCashierController controller = new BOCashierController();
		CommonMethodController commonMethodController = CommonMethodController.getInstance();
		try {
			txnSearchBean.setStatus(wdrStatus);
			currencyMap = commonMethodController.fetchActiveDmCurrMap(txnSearchBean.getDomainId());
			wdrTxnMap = controller.searchWithdrawalTxn(txnSearchBean);
			
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception_nodecorate";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception_nodecorate";
		}
		return "PENDING".equals(wdrStatus) ? "initiate" : "INITIATED"
				.equals(wdrStatus) ? "process":"PROCESSED"
					.equals(wdrStatus) ? "settlement"  : "exception_nodecorate";
	}

	public String unclaimedRecordsSearch() {
		logger.info("--Unclaimed Records  Transaction--");
		try {
			unclaimedRecords = new CashierController().unclaimedRecordsSearch(txnSearchBean);
		} catch (PMSException e) {
			logger.error("LOG_TAG", e);
		} catch (Exception be) {
			logger.error("LOG_TAG", be);
		}
		return txnSearchBean.getTxnStatus();
	}
	
	public String initWithdrawalSave() {
		logger.info("--Initiate Withdrawal--");
		try {
			BOCashierController.updatePlayerWithdrawal(txnIds, "INITIATED",reason);
		} catch (PMSException e) {
			logger.error(e.getErrorMessage());
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		actionMessage=" Withdrawal Request Updated Successfully..";
		return SUCCESS;
	}

	public String cancelWithdrawalSubmit() {
		logger.info("--Cancel Withdrawal by Form Submit--");
		BOCashierController controller = new BOCashierController();
		try {
			controller.cancelPlayerWithdrawal(txnIds, "CANCEL_BY_BO",reason);
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		actionMessage=" Withdrawal Request Cancelled Successfully..";
		return SUCCESS;

	}

	public void cancelWithdrawalAjax() {
		logger.info("--Cancel Withdrawal by AJAX--");
		BOCashierController controller = new BOCashierController();
		PrintWriter writer = null;
		String ajaxResp = SUCCESS;
		try {
			writer = response.getWriter();
			controller.cancelPlayerWithdrawal(txnIds, "CANCEL_BY_BO",reason);
		} catch (PMSException e) {
			e.printStackTrace();
			ajaxResp = e.getErrorMessage();
		} catch (IOException e) {
			e.printStackTrace();
			ajaxResp = "Some internal error!!";
		}catch (Exception be) {
			ajaxResp = "Some internal error.";
			be.printStackTrace();
		} finally {
			if (writer != null)
				writer.write(ajaxResp);
		}

	}

	public String processWithdrawalSave() {
		logger.info("--Process Withdrawal--");
		BOCashierController controller = new BOCashierController();
		CommonMethodController commonMethodController = CommonMethodController.getInstance();
		try {
			Gson wdrData = new GsonBuilder().setDateFormat("dd/MM/yyyy")
					.create();
			Type wdrMapType = new TypeToken<HashMap<Long, WithdrawalTxnBean>>() {
			}.getType();
			wdrTxnMap = wdrData.fromJson(withdrawalJsonData, wdrMapType);
			providerName=providerName!=null? providerName.split(",")[0]:"";
            if ("CASH_PAYMENT".equals(paymentTypeCode)  && !"WARI".contains(providerName)) {
                controller.processPlayerCashPaymentWithdrawal(wdrTxnMap,reason);
            }else if ("MOBILE_MONEY".equals(paymentTypeCode)) {
                controller.processPlayerMobileMoneyWithdrawal(wdrTxnMap,reason);
            } else {
				controller.processPlayerWithdrawal(wdrTxnMap,reason);
			}
			generateExcel = "BANK_TRANS".equals(paymentTypeCode);
			if(generateExcel){
				currencyMap = commonMethodController.fetchActiveDmCurrMap(domainId);
			}
			wdrTxnStr=new Utility().convertJSON(wdrTxnMap);
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		actionMessage =" Withdrawal Request Updated Successfully..";
		return SUCCESS;
	}

	public void initiatedWithdrawalExportExcel()  {
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition",
				"attachment; filename= Initiated_bank_withdrawal_" + Calendar.getInstance().getTimeInMillis()
						+ ".xlsx");
		try {
			ReportToExcel excel = new ReportToExcel();
			BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
			String reportTitle = null;
			String sheetName="Initiated Withdrawal Report Sheet";
			BOCashierController controller = new BOCashierController();
			if (String.valueOf(txnSearchBean.getDomainId()).equals("0")) {
				reportTitle = "Initiated Withdrawal Report for All Domain From "
						+ txnSearchBean.getFromDate() + " To "
						+ txnSearchBean.getToDate();
			} else {
				CommonMethodController commCont = CommonMethodController.getInstance();
				String domainName = commCont.getDmProperty(txnSearchBean.getDomainId(), "domainName");
				reportTitle = "Initiated Withdrawal Report For Domain: "+domainName+ " From "
						+ txnSearchBean.getFromDate() + " To "
						+ txnSearchBean.getToDate();
			}
			
			txnSearchBean.setStatus(wdrStatus);
			List<Object[]> resultList = new ArrayList<Object[]>();
			wdrTxnMap = controller.searchWithdrawalTxn(txnSearchBean);
			String reportHeader[] = null;
			String valueArray[] = null;
			if("BANK_TRANS".equals(txnSearchBean.getPaymentTypeCode())){
			 reportHeader = new String[] { "Txn ID", "Date",
					"User Name", "Beneficiary Name", "A/C No",
					"Bank Name", "IFSC Code",
					"Processed Amount", "Balance","Withdrawable Balance" };
			}else if ("CHEQUE_TRANS".equals(txnSearchBean.getPaymentTypeCode())){
				reportHeader = new String[] { "Txn ID", "Date",
						"User Name", "Beneficiary Name","Cheque No","Cheque Date",
						"Processed Amount", "Balance","Withdrawable Balance" };
			}else{
				reportHeader = new String[] { "Txn ID", "Date",
						"User Name", "Beneficiary Name",
						"Processed Amount", "Balance","Withdrawable Balance" };
			}
			CommonMethodController commonMethodController = CommonMethodController.getInstance();
			currencyMap = commonMethodController.fetchActiveDmCurrMap(txnSearchBean.getDomainId());
			SimpleDateFormat sd = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			for (Long key: wdrTxnMap.keySet()) {
				if("BANK_TRANS".equals(txnSearchBean.getPaymentTypeCode())){
					valueArray = new String[]{String.valueOf(wdrTxnMap.get(key).getTransactionId()),String.valueOf(sd.format(wdrTxnMap.get(key).getTransactionDate())),
						String.valueOf(wdrTxnMap.get(key).getUserName()),String.valueOf(wdrTxnMap.get(key).getBankRedAcc().getAccHolderName()),String.valueOf(wdrTxnMap.get(key).getBankRedAcc().getAccNum()),
						String.valueOf(wdrTxnMap.get(key).getBankRedAcc().getBankName()),String.valueOf(wdrTxnMap.get(key).getBankRedAcc().getIfscCode()),
						String.valueOf(Utility.roundingNumber(wdrTxnMap.get(key).getToAmount())+" "+currencyMap.get(txnSearchBean.getCurrencyId()).getCurrCode()),String.valueOf(Utility.roundingNumber(wdrTxnMap.get(key).getWalletInfo().getCashBal())+" "+currencyMap.get(txnSearchBean.getCurrencyId()).getCurrCode()),
						String.valueOf(Utility.roundingNumber(wdrTxnMap.get(key).getWalletInfo().getWithdrawableBal())+" "+currencyMap.get(txnSearchBean.getCurrencyId()).getCurrCode())};
						resultList.add(valueArray);
				}else if("CHEQUE_TRANS".equals(txnSearchBean.getPaymentTypeCode())){
					valueArray = new String[]{String.valueOf(wdrTxnMap.get(key).getTransactionId()),String.valueOf(sd.format(wdrTxnMap.get(key).getTransactionDate())),
							String.valueOf(wdrTxnMap.get(key).getUserName()),String.valueOf(wdrTxnMap.get(key).getFirstName()+" "+wdrTxnMap.get(key).getLastName()),"","",
							String.valueOf(Utility.roundingNumber(wdrTxnMap.get(key).getToAmount())+" "+currencyMap.get(txnSearchBean.getCurrencyId()).getCurrCode()),String.valueOf(Utility.roundingNumber(wdrTxnMap.get(key).getWalletInfo().getCashBal())+" "+currencyMap.get(txnSearchBean.getCurrencyId()).getCurrCode()),
							String.valueOf(Utility.roundingNumber(wdrTxnMap.get(key).getWalletInfo().getWithdrawableBal())+" "+currencyMap.get(txnSearchBean.getCurrencyId()).getCurrCode())};resultList.add(valueArray);	
				}else{
					valueArray = new String[]{String.valueOf(wdrTxnMap.get(key).getTransactionId()),String.valueOf(sd.format(wdrTxnMap.get(key).getTransactionDate())),
							String.valueOf(wdrTxnMap.get(key).getUserName()),String.valueOf(wdrTxnMap.get(key).getFirstName()+" "+wdrTxnMap.get(key).getLastName()),
							String.valueOf(Utility.roundingNumber(wdrTxnMap.get(key).getToAmount())+" "+currencyMap.get(txnSearchBean.getCurrencyId()).getCurrCode()),String.valueOf(Utility.roundingNumber(wdrTxnMap.get(key).getWalletInfo().getCashBal())+" "+currencyMap.get(txnSearchBean.getCurrencyId()).getCurrCode()),
							String.valueOf(Utility.roundingNumber(wdrTxnMap.get(key).getWalletInfo().getWithdrawableBal())+" "+currencyMap.get(txnSearchBean.getCurrencyId()).getCurrCode())};
							resultList.add(valueArray);	
				}
			}
			SXSSFWorkbook wb = excel.playerExcelDownload(reportHeader, resultList, sheetName, reportTitle); 
			wb.write(out);
			out.flush();
		    out.close();
		    wb.dispose();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			// response.getOutputStream().write(("<table>"+excelData+"</table>").getBytes());
			writer.println(withdrawalJsonData);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	public void processedWithdrawalExportExcel() {
		
		Map<Long, WithdrawalTxnBean> wdrTxnMap = new Gson().fromJson(processedWithdrawalJsonData, new TypeToken<HashMap<Long, WithdrawalTxnBean>>() {}.getType());
		Map<Long, WithdrawalTxnBean> wdrTxnMapHdfc = new HashMap<Long, WithdrawalTxnBean>();
		Map<Long, WithdrawalTxnBean> wdrTxnMapNonHdfc = new HashMap<Long, WithdrawalTxnBean>();
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		SimpleDateFormat sdf1 = new SimpleDateFormat("MMMdd");
		  Iterator<Long> it1 = wdrTxnMap.keySet().iterator();
	        while(it1.hasNext()){
	            Long key = it1.next();
	            if(wdrTxnMap.get(key).getSubtypeId()==73)
	            	wdrTxnMapHdfc.put(key, wdrTxnMap.get(key));
	            else
	            	wdrTxnMapNonHdfc.put(key, wdrTxnMap.get(key));
	        }
		if("excel".equals(downloadParam)){
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition",
					"attachment; filename= Processed_bank_withdrawal_" + Calendar.getInstance().getTimeInMillis()
							+ ".xlsx");
			try {
				ReportToExcel excel = new ReportToExcel();
				BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
				String reportTitle = null;
				String sheetName="Initiated Withdrawal Report Sheet";
				
				List<Object[]> resultList = new ArrayList<Object[]>();
				
				String reportHeader[] = null;
				String valueArray[] = null;
				
				 reportHeader = new String[] { "Sr No", "Beneficiary Name",
						"Beneficiary A/C No", "Beneficiary Bank Name", "Beneficiary Bank address",
						"RTGS / NEFT IFSC CODE", "Withdrawal Amount"};
				 
				 CommonMethodController commCont = CommonMethodController.getInstance();
				 String domainName = commCont.getDmProperty(domainId, "domainName");
				 reportTitle = "Processed Withdrawal Report For Domain: "+domainName;
				 CommonMethodController commonMethodController = CommonMethodController.getInstance();
			     currencyMap = commonMethodController.fetchActiveDmCurrMap(domainId);
				 int serno = 1;
			    for (Long key: wdrTxnMap.keySet()) {
					valueArray = new String[]{String.valueOf(serno),
							String.valueOf(wdrTxnMap.get(key).getBankRedAcc().getAccHolderName()),String.valueOf(wdrTxnMap.get(key).getBankRedAcc().getAccNum()),
							String.valueOf(wdrTxnMap.get(key).getBankRedAcc().getBankName()),String.valueOf(wdrTxnMap.get(key).getBankRedAcc().getBranchAddress()),String.valueOf(wdrTxnMap.get(key).getBankRedAcc().getIfscCode()),
							String.valueOf(Utility.roundingNumber(wdrTxnMap.get(key).getToAmount())+" ("+currencyMap.get(wdrTxnMap.get(key).getToCurrencyId()).getCurrCode()+")")
						};
						resultList.add(valueArray);
						serno++;
				}
				SXSSFWorkbook wb = excel.playerExcelDownload(reportHeader, resultList, sheetName, reportTitle); 
				wb.write(out);
				out.flush();
			    out.close();
			    wb.dispose();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(("csvHdfc".equals(downloadParam)) || ("csvNonHdfc".equals(downloadParam))){
			response.setContentType("text/csv");
			String outputResult = "";
		            
			if("csvHdfc".equals(downloadParam)){
				response.setHeader("Content-Disposition", "attachment; filename= Processed_bank_withdrawal_HDFC" + Calendar.getInstance().getTimeInMillis()
					+ ".csv");
				for (Long key: wdrTxnMapHdfc.keySet()) {
					outputResult = outputResult+"I,"+String.valueOf(wdrTxnMapHdfc.get(key).getBankRedAcc().getAccNum())+","+String.valueOf(wdrTxnMapHdfc.get(key).getBankRedAcc().getAccNum())+","+(int)wdrTxnMapHdfc.get(key).getAmount()+","+String.valueOf(wdrTxnMapHdfc.get(key).getBankRedAcc().getAccHolderName())+",,,,,,,,,"+String.valueOf(wdrTxnMapHdfc.get(key).getUserName()+" "+sdf1.format(wdrTxnMapHdfc.get(key).getTransactionDate()))+",,,,,,,,,"+String.valueOf(sdf.format(new Date()))+",,"+String.valueOf(wdrTxnMapHdfc.get(key).getBankRedAcc().getIfscCode())+","+String.valueOf(wdrTxnMapHdfc.get(key).getBankRedAcc().getBankName())+","+String.valueOf(wdrTxnMapHdfc.get(key).getBankRedAcc().getBranchCity())+",\n";
				}
			}
		    else if("csvNonHdfc".equals(downloadParam)){
		    	response.setHeader("Content-Disposition", "attachment; filename= Processed_bank_withdrawal_Non_HDFC" + Calendar.getInstance().getTimeInMillis()
					+ ".csv");
		    	for (Long key: wdrTxnMapNonHdfc.keySet()) {
					outputResult = outputResult+"N,,"+String.valueOf(wdrTxnMapNonHdfc.get(key).getBankRedAcc().getAccNum())+","+(int)wdrTxnMapNonHdfc.get(key).getAmount()+","+String.valueOf(wdrTxnMapNonHdfc.get(key).getBankRedAcc().getAccHolderName())+",,,,,,,,,"+String.valueOf(wdrTxnMapNonHdfc.get(key).getUserName()+" "+sdf1.format(wdrTxnMapNonHdfc.get(key).getTransactionDate()))+",,,,,,,,,"+String.valueOf(sdf.format(new Date()))+",,"+String.valueOf(wdrTxnMapNonHdfc.get(key).getBankRedAcc().getIfscCode())+","+String.valueOf(wdrTxnMapNonHdfc.get(key).getBankRedAcc().getBankName())+","+String.valueOf(wdrTxnMapNonHdfc.get(key).getBankRedAcc().getBranchCity())+",\n";
				}
		    }
		    try
		    {
		        OutputStream outputStream = response.getOutputStream();
		        outputStream.write(outputResult.getBytes());
		        outputStream.flush();
		        outputStream.close();
		    }
		    catch(Exception e)
		    {
		       e.printStackTrace();
		    }
		}
		else if(("excelHdfc".equals(downloadParam)) || ("excelNonHdfc".equals(downloadParam))){
			
			String sheetName = null;
			response.setContentType("application/vnd.ms-excel");
			try {
				ReportToExcel excel = new ReportToExcel();
				BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
				String reportTitle = null;
				List<Object[]> resultList = new ArrayList<Object[]>();
				String reportHeader[] = null;
				String valueArray[] = null;
				CommonMethodController commCont = CommonMethodController.getInstance();
				 String domainName = commCont.getDmProperty(domainId, "domainName");
				reportTitle = "Processed Withdrawal Report For Domain: "+domainName;
				if("excelHdfc".equals(downloadParam)){
						response.setHeader("Content-Disposition",
						"attachment; filename= Processed_bank_withdrawal_HDFC" + Calendar.getInstance().getTimeInMillis()
								+ ".xlsx");
						 sheetName="Processed Withdrawal Report Sheet For HDFC";
						 reportHeader = new String[] { "Transaction Type (N<200000, R>200000)", "Beneficiary Code",
									"Beneficiary Account Number", "Instrument Amount", "Beneficiary Name",
									"Drawee Location", "Print Location","Bene Address 1","Bene Address 2","Bene Address 3","Bene Address 4","Bene Address 5",
									"Instruction Reference Number","Customer Reference Number (Narration) ","Payment details 1","Payment details 2",
									"Payment details 3","Payment details 4","Payment details 5","Payment details 6","Payment details 7","Cheque Number","Transaction date dd/mm/yyyy",
									"MICR Number","Bene  IFS Code","Bene Bank Name","Bene Bank Branch Name","Beneficiary email id"};
						 
						
						for (Long key: wdrTxnMapHdfc.keySet()) {
							valueArray = new String[]{"I",
								String.valueOf(wdrTxnMapHdfc.get(key).getBankRedAcc().getAccNum()),String.valueOf(wdrTxnMapHdfc.get(key).getBankRedAcc().getAccNum()),
								String.valueOf(wdrTxnMapHdfc.get(key).getAmount()),String.valueOf(wdrTxnMapHdfc.get(key).getBankRedAcc().getAccHolderName()),
								" "," "," "," "," "," "," "," ",String.valueOf(wdrTxnMapHdfc.get(key).getUserName()+" "+sdf1.format(wdrTxnMapHdfc.get(key).getTransactionDate())),
								" "," "," "," "," "," "," "," ",String.valueOf(sdf.format(new Date()))," ",String.valueOf(wdrTxnMapHdfc.get(key).getBankRedAcc().getIfscCode()),
								String.valueOf(wdrTxnMapHdfc.get(key).getBankRedAcc().getBankName()),String.valueOf(wdrTxnMapHdfc.get(key).getBankRedAcc().getBranchCity())," "
								};
								resultList.add(valueArray);
						}
						
				}else if ("excelNonHdfc".equals(downloadParam)){
						response.setHeader("Content-Disposition",
							"attachment; filename= Processed_bank_withdrawal_Non_HDFC" + Calendar.getInstance().getTimeInMillis()
									+ ".xlsx");
						 sheetName="Processed Withdrawal Report Sheet Non HDFC";
						 reportHeader = new String[] { "Transaction Type (N<200000, R>200000)", "Beneficiary Code",
									"Beneficiary Account Number", "Instrument Amount", "Beneficiary Name",
									"Drawee 	Location", "Print Location","Bene Address 1","Bene Address 2","Bene Address 3","Bene Address 4","Bene Address 5",
									"Instruction Reference Number","Customer Reference Number (Narration) ","Payment details 1","Payment details 2",
									"Payment details 3","Payment details 4","Payment details 5","Payment details 6","Payment details 7","Cheque Number","Transaction date dd/mm/yyyy",
									"MICR Number","Bene  IFS Code","Bene Bank Name","Bene Bank Branch Name","Beneficiary email id"};
						 
						
						for (Long key: wdrTxnMapNonHdfc.keySet()) {
							valueArray = new String[]{"N",
								" ",String.valueOf(wdrTxnMapNonHdfc.get(key).getBankRedAcc().getAccNum()),
								String.valueOf(wdrTxnMapNonHdfc.get(key).getAmount()),String.valueOf(wdrTxnMapNonHdfc.get(key).getBankRedAcc().getAccHolderName()),
								" "," "," "," "," "," "," "," ",String.valueOf(wdrTxnMapNonHdfc.get(key).getUserName()+" "+sdf1.format(wdrTxnMapNonHdfc.get(key).getTransactionDate())),
								" "," "," "," "," "," "," "," ",String.valueOf(sdf.format(new Date()))," ",String.valueOf(wdrTxnMapNonHdfc.get(key).getBankRedAcc().getIfscCode()),
								String.valueOf(wdrTxnMapNonHdfc.get(key).getBankRedAcc().getBankName()),String.valueOf(wdrTxnMapNonHdfc.get(key).getBankRedAcc().getBranchCity())," "
								};
								resultList.add(valueArray);
						}
				}
			SXSSFWorkbook wb = excel.playerExcelDownload(reportHeader, resultList, sheetName, reportTitle); 
			wb.write(out);
			out.flush();
		    out.close();
		    wb.dispose();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public String withdrawalSettlementMenu() {
		wdrStatus = "PROCESSED";
		return SUCCESS;
	}
	
	public String withdrawalSettlement() {
		logger.info("--Withdrawal Settlement start--");
		BOCashierController controller = new BOCashierController();
		Gson wdrData = new GsonBuilder().setDateFormat("dd/MM/yyyy HH:mm:ss").create();
		Type wdrMapType = new TypeToken<HashMap<Long, WithdrawalTxnBean>>() {
									}.getType();
		wdrTxnMap = wdrData.fromJson(withdrawalJsonData, wdrMapType);
		try {
			controller.withdrawalSettlement(wdrTxnMap, settlementType,reason);
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		actionMessage=" Withdrawal Request Updated Successfully..";
		return SUCCESS;
	}
	
	@SuppressWarnings("rawtypes")
	public void processDepositMenu() {
		logger.info("--processDepositMenu--");
		BOCashierController controller = new BOCashierController();
		CommonMethodController commonMethodController = CommonMethodController.getInstance();
		Gson gson = new Gson();
		PrintWriter out = null;
		try {
			offlinePayTypeMap = controller.getOfflinePaymentTypes("DEPOSIT",domainId,device);
			Map<Integer,CurrencyBean> currencyList = commonMethodController.fetchActiveDmCurrMap(domainId);
			Map<String, Map> jsonMap = new HashMap<String, Map>();
			jsonMap.put("offlinePayTypeMap", offlinePayTypeMap);
			jsonMap.put("currencyList", currencyList);
			String payTypeJsonMap = gson.toJson(jsonMap);
			out = response.getWriter();
			out.write(payTypeJsonMap);
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
		} 
		catch (Exception e) {
			e.printStackTrace();
		} 
	}
	
	public String depositSearch() {
		logger.info("--Search Deposits--");
		BOCashierController controller = new BOCashierController();
		CommonMethodController commonMethodController = CommonMethodController.getInstance();
		try {
			txnSearchBean.setStatus("INITIATED");
			depositReqMap = controller.searchDepositRequests(txnSearchBean);
			currencyMap = commonMethodController.fetchActiveDmCurrMap(domainId);
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
	public String processDepositSave(){
		logger.info("--Process Deposit--");
		BOCashierController controller = new BOCashierController();
		try {
			Gson depositData = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
			Type depositReqType = new TypeToken<HashMap<Long, DepositRequestBean>>() {}.getType();
			depositReqMap = depositData.fromJson(depositJsonData, depositReqType);
			controller.processPlayerDeposit(depositReqMap,device);
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		addActionMessage(" Deposit Request Updated Successfully..");
		return SUCCESS;
	}
	public String cancelDepositSubmit(){
		logger.info("--Cancel Deposit by Form Submit--");
		BOCashierController controller = new BOCashierController();
		try {
			controller.cancelPlayerDeposit(requestIds,"CANCEL_BY_BO","SETTLED_BY_BO");
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		addActionMessage(" Deposit Request Cancelled Successfully..");
		return SUCCESS;
	}

	public String depositRequestSettlement() {
		logger.info("--depositRequestSettlement--");
		Settlement Types 
			CANCEL_BY_BO ---- If request not found in PG report and BO wants to settle it by cancel request
			REVERSED_TO_PLR ---- If request found in PG report and BO wants to settle it by reverse to player
			CREDIT_MISSING_REQUEST ----- If request not found in PG report and plr a/c is debit and  BO wants to settle it by credit to plr portal a/c
			CREDIT_PENDING_REQUEST  ---- If request found in PG report but plr wallet not updated  and BO wants to settle it by credit to player
		
		BOCashierController controller = new BOCashierController();
		try {
			controller.depositRequestSettlement(requestIds, settlementType, providerName,userInfoBean.getUserId());
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception_nodecorate";
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception_nodecorate";
		}
		addActionMessage(" Deposit Request Updated Successfully..");
		return SUCCESS;
	}

	public String fetchPayTypeContent(){
		logger.info("-----Inside uploadPaymentTypeContentMenu -----");
		BOCashierController controller = new BOCashierController();
		try {
			if (txnType == null || "-1".equals(txnType) || domainId <=0) 
				throw new PMSException("Please select all mendatory fields");
			CommonMethodController commCont = CommonMethodController.getInstance();
			String domainName = commCont.getDmProperty(domainId, "domainName");
			String fileSeperater = "/";
			StringBuilder contentPath = new StringBuilder(commCont.fetchSystemProperties("DEFAULT_CONTENT_PATH"));
			contentPath.append(domainName).append(fileSeperater).append(
					commCont.getDeviceLayout(domainId, device))
					.append(fileSeperater).append(device.toLowerCase()).append(
							fileSeperater).append("LR").append(fileSeperater)
					.append("cashier").append(fileSeperater).append(txnType).append(fileSeperater);
			payTypeContentMap = controller.fetchPayTypeContent(txnType, domainId,device,contentPath.toString());
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception_nodecorate";
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception_nodecorate";
		}
		return SUCCESS;
	}

	public String uploadPayTypeContent() {
		logger.info("--Upload Content--");
		BOCashierController controller = new BOCashierController();
		CommonMethodController commonMethodController = CommonMethodController.getInstance();
		try {
			Gson contentData = new GsonBuilder().create();
			Type payTypeContent = new TypeToken<HashMap<Integer, PaymentTypeContentBean>>() {
			}.getType();
			payTypeContentMap = contentData.fromJson(contentJsonData,
					payTypeContent);
			String domainName = commonMethodController.getDmProperty(domainId, "domainName");
			StringBuilder contentPath = new StringBuilder("");
			contentPath.append(domainName).append("|").append(
					commonMethodController.getDeviceLayout(domainId, device))
					.append("|").append(device.toLowerCase()).append(
							"|").append("LR").append("|")
					.append("cashier").append("|").append(txnType);
			
			controller.uploadPaymentTypeContent(payTypeContentMap, domainId,
					txnType,device, contentPath.toString());
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception_nodecorate";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception_nodecorate";
		}
		addActionMessage(" Payment Type Content Saved Successfully..");
		return SUCCESS;
	}
	
	public String uploadPGSettlementReportMenu() {
		logger.info("--uploadPGSettlementReportMenu--");
		BOCashierController controller = new BOCashierController();
		try {
			paymentProviderMap = controller.fetchPaymentProvider();
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception e) {
			e.printStackTrace();
			addActionError("Some internal error.");
			return "exception";
		}
		return SUCCESS;
	}
	
	public String uploadPGSettlementReport() {
		logger.info("--uploadPGSettlementReport--");
		BOCashierController controller = new BOCashierController();
		try {
			 controller.uploadPGSettlementReport(pgSettlementReport,pgSettlementReportFileName,providerName);
			 addActionMessage("Settlement report uploaded successfully");
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception e) {
			e.printStackTrace();
			addActionError("Some internal error.");
			return "exception";
		}
		return SUCCESS;
	}
	
	public String uploadPokerSetSave(){
		logger.info("---uploadPokerSettlementReport--");
		BOCashierController controller = new BOCashierController();
		try{
			controller.uploadPokerSetSave(domainId,pokerSettlement,pokerSettlementFileName,providerName);
			addActionMessage("Settlement Report uploaded successfuly");
		}catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error.");
			return "exception";
		}
		return SUCCESS;
	}
	public String uploadPaytmSetSave(){
		logger.info("---uploadPaytmSettlementReport--");
		BOCashierController controller = new BOCashierController();
		try{
			controller.uploadPaytmSetSave(domainId,paytmSettlement,paytmSettlementFileName,providerName);
			addActionMessage("Settlement Report uploaded successfuly");
		}catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error.");
			return "exception";
		}
		return SUCCESS;
	}
	public String plrSearchForPayCorrection() {
		logger.info("--plrSearchForPayCorrection--");
		BOCashierController controller = new BOCashierController();
		CommonMethodController commonMethodController =  CommonMethodController.getInstance();
		try {
			plrList = controller.plrSearchForPayCorrection(domainId, firstName, lastName,
					userName);
			domainMap = commonMethodController.getDomainIdMap();
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception_nodecorate";
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some internal error.");
			return "exception_nodecorate";
		}
		return SUCCESS;
	}

	public void getPaymentCorrectionData() throws IOException{
		logger.info("--getPaymentCorrectionData--");
		BOCashierController controller = new BOCashierController();
		PrintWriter out = null;
		Gson gson = new Gson();
		out = response.getWriter();
		 Map<String,Object> dataMap = new HashMap<>();
		try {
			if(System.getProperties().containsKey(BULK_PAYMENT_CORRECTION_RUNNING)){
				dataMap.put("status", 400);
				dataMap.put("message", "Previous request is under process, Please try after sometime");
			}else if(settlementSheet==null){
				dataMap.put("status", 400);
				dataMap.put("message", "File not selected");
			}else{
				dataMap = controller.getPaymentCorrectionData(settlementSheet,settlementSheetFileName,payCorrection.getCorrectionType());
				addActionMessage("Settlement report uploaded successfully");
				dataMap.put("status", 200);
				dataMap.put("message", "Settlement report uploaded successfully");
			}
		} catch(PMSException e){
			e.printStackTrace();
			dataMap.put("status", 400);
			if (e.getErrorCode() != null && e.getErrorCode()==304) {
				dataMap.put("message", "Invalid file. usage: header column should be Player Id(Integer),Settlement Amount(Decimal/Integer),Reason(String)");
			}else{
				dataMap.put("message", e.getMessage().replace("POI","We"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			dataMap.put("status", 400);
			dataMap.put("message", "Invalid file.");
		}
		out.write(gson.toJson(dataMap));
		
	}
	
	public String plrPaymentCorrection() {
		logger.info("--plrPaymentCorrection--");
		BOCashierController controller = new BOCashierController();
		try {
			 controller.plrPaymentCorrection(payCorrection,userInfoBean.getUserId());
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some internal error.");
			return "exception";
		}
		 addActionMessage("Player payment corrected successfully");
		return SUCCESS;
	}
	
	
	public void bulkPlrPaymentCorrection() throws IOException, InterruptedException{
		logger.info("--bulkPlrPaymentCorrection--");
		
		PrintWriter out = response.getWriter();
		Map<String,Object> result = new HashMap<>();
		Gson googleJson = new Gson();
		
		if(!System.getProperties().containsKey(BULK_PAYMENT_CORRECTION_RUNNING)){
			Thread job = new Thread(new PaymentCorrectionJob(correctionList, payCorrection.getDomainId(),payCorrection.getAliasId(), userInfoBean.getUserId(), payCorrection.getCorrectionType(), payCorrection.getWithdrawableImpact()));
			job.start();
			result.put("message","Request submitted, please refer payment correction report");
		}else{
			result.put("message","Previous request is under process, Please try after sometime");
		}
		
		out.write(googleJson.toJson(result));
		logger.info("--bulkPlrPaymentCorrection--");
	}
	
	public String plrPaymentCorrectionMenu() { 

		CommonMethodController commonMethodController = CommonMethodController.getInstance();
		try {
			domainMap = commonMethodController.getDomainIdMap();
			bydefaultSelectedDomain = Integer.parseInt(commonMethodController
					.fetchSystemProperties("BYDEFAULT_SELECTED_DOMAIN"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String getPlrFraudReport() {
		logger.info("--getPlrFraudReport--");
		
		BOCashierController controller = new BOCashierController();
		try {
			plrFraudReqBean =  controller.getPlrFraudReport(plrFraudReqBean,domainId);
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
	
	public String redeemAccApprovalSearch() {
		logger.info("--redeemAccApprovalSearch--");
		BOCashierController controller = new BOCashierController();
		try {
			redAccList = controller.redeemAccApprovalSearch(domainId,userName,"BANK_TRANS");
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception_nodecorate";
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some internal error.");
			return "exception_nodecorate";
		}
		return SUCCESS;
	}
	public String redeemAccApprovalSave() {
		logger.info("--redeemAccApprovalSearch--");
		try {
			logger.info("---redeemAccountIds---"+redAccIds.toString()+"----new status---"+status);
			BOCashierController controller = new BOCashierController();
			if (redAccIds.length>0) {
				controller.updateRedeemAccounts(redAccIds,status);
			}else{
				throw new PMSException("Please select at least one redeem account to change status.");
			}
			
			addActionMessage("Redeem account status changed successfully.");
		}  catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception_nodecorate";
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some internal error.");
			return "exception_nodecorate";
		}
		return SUCCESS;
	}
	
	
	public String fetchBankListBankTrans(){
		logger.info("--fetchBankListBankTrans--");
		try {
			BOCashierController controller = new BOCashierController();
			bankMap=controller.fetchBankListBankTrans();			
		}catch (Exception e) {
			e.printStackTrace();
			addActionError("Some internal error.");
			return "exception_nodecorate";
		}
		return SUCCESS;
		
	}
	
	public String updatePlrRedeemAcc(){
		
		try {
			new BOCashierController().updatePlrRedeemAcc(aliasId,domainId,redAccBankBean,userInfoBean.getUserName(),bankCode);
		}catch (Exception e) {
			e.printStackTrace();
			addActionError(e.getMessage());
			return "error";
		}
		return SUCCESS;
	}
	
	
	public void getActiveSubWalletBatch(){
		logger.info("---------------getActiveSubWalletBatch- Weaver-Action--start----------");
				
		try{
			Gson gson = new Gson();
			PrintWriter out = response.getWriter();
			Map<String, String> batchMap=new BOCashierController().activeSubWalletBatch(domainId, fromDate, toDate);
			out = response.getWriter();
			String  batchMapStr = gson.toJson(batchMap);
			out.write(batchMapStr);
		}catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
		} 
		catch (Exception e) {
			e.printStackTrace();
		} 
		
	}
	
	
	public String getReconsileList(){
		
		logger.info("---------------getReconsileList--Action--start----------");
		try {
			HttpSession session = request.getSession();
			resultList =	new BOCashierController().getSubWalletReconsileList(request.getParameter("subWalletIds"));
			session.setAttribute("dataTableValue", resultList);
		}catch (Exception e) {
			e.printStackTrace();
			addActionError("Some internal error.");
			return "exception_nodecorate";
		}	
		return SUCCESS;
	}	
	
	
	public String uploadPokerSettlementMenu(){
		CommonMethodController controller = CommonMethodController.getInstance();
		try {
			domainMap = controller.getDomainIdMap();
		}  catch (PMSException pmse) {
			pmse.printStackTrace();
			addActionError(pmse.getErrorMessage());
			return "exception";
		}	catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}	
		
		return SUCCESS;
	}
	public String uploadPaytmSettlementMenu(){
		CommonMethodController controller = CommonMethodController.getInstance();
		try {
			domainMap = controller.getDomainIdMap();
		}  catch (PMSException pmse) {
			pmse.printStackTrace();
			addActionError(pmse.getErrorMessage());
			return "exception";
		}	catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}	
		
		return SUCCESS;
	}
	public void subwalletRecSave() throws IOException{
		PlayerPaymentCorrection payCorrection;
		BOCashierController controller = new BOCashierController();
		try{
			payCorrection = new PlayerPaymentCorrection(playerId, domainId, amt, "CREDIT", reason, "NO");
			controller.subWalletPayCorrSave(payCorrection,tableId,subWalletTime,userInfoBean.getUserId(),aliasId);
			response.getWriter().write(new Utility().convertJSON("success"));
		}catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write(new Utility().convertJSON("exception"));
		}
		//return SUCCESS;
	}
	
	public void getGameVendors() throws IOException {
		try {
			gameServiceMap=new HashMap<String, Short>();
			List<StRmVendorMaster> gameServiceList= CommonMethodController.getInstance().getActiveGameMap(aliasId);
			for (StRmVendorMaster vendor : gameServiceList) 
				gameServiceMap.put(vendor.getDefaultGameGroup(), vendor.getVendorId());
			response.getWriter().write(new Gson().toJson(gameServiceMap));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getServiceWagerList() {
		try {
			String source="com.stpl.pms.hibernate.mapping.StTxnPlrWagerMaster"+WordUtils.capitalize(gameServiceCode.toLowerCase().replace('_', ' ')).replace(" ", "")+gameServiceId;
			wagerList=new BOCashierController().getServiceWagerList(source, domainId, aliasId,wagerFromDate,wagerToDate, status);
		} catch (Exception e) {
			e.printStackTrace();
			return "exception_nodecorate";
		}
		return SUCCESS;
	}
	
	public String createPaySubTypeMenu() {
		try {
			setPayTypeMasterList(new BOCashierController().fetchAllPaymentTypeMaster());
		} catch (Exception e) {
			e.printStackTrace();
			addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
			return "exception";
		}
		return SUCCESS;
	}

	public String getPaySubTypes() {
		try {
			setPaySubTypesList(new BOCashierController().getPaySubTypes(paymentTypeCode, null));
			if(getPaySubTypesList()!=null && getPaySubTypesList().size()>0)
				try {
					BeanUtils.getProperty(getPaySubTypesList().get(0), "countryId");
					countryMap=new HashMap<Integer, String>();
					for(CountryBean cb: CommonMethodController.getInstance().fetchActiveCountryList((short)1))
						countryMap.put(cb.getCountryId(), cb.getName());
				} catch ( Exception e) {
					logger.info("-----ActiveCountryList not reqiuired-----");
				}
		} catch (Exception e) {
			e.printStackTrace();
			addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
			return "exception_nodecorate";
		}
		return SUCCESS;
	}

	public String createNewSubType() {
		try {
			new BOCashierController().addOrEditSubType(paySubType);
		} catch (Exception e) {
			e.printStackTrace();
			addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
			return "exception";
		}
		return SUCCESS;
	}
	
	public void editSubType() throws IOException {
		try {
			new BOCashierController().addOrEditSubType(paySubType);
			response.getWriter().write("success");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("error");
		}
	}
	
	public String payTypeChngStatus() {
		try {
			paySubType.setTypeCode(paymentTypeCode);
			new BOCashierController().updateMultiSubTypeStatus(paySubType);
		} catch (Exception e) {
			e.printStackTrace();
			addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
			return "exception";
		}
		return SUCCESS;
	}
	
	public String createpodmMapSubTypeMenu() {
		try {
			BOCashierController bocsh=new BOCashierController();
			setPaymentProviderMap(bocsh.fetchAllProviderMap());
			setPayTypeMasterList(bocsh.fetchAllPaymentTypeMaster());
			procChargMap=new BOCashierController().getProcChargMap();
		} catch (Exception e) {
			e.printStackTrace();
			addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
			return "exception";
		}
		return SUCCESS;
	}
	
	public void getPaySubTypeSelector() throws IOException {
		try {
			HashMap<Integer, String> paySubTypeMap=new HashMap<Integer, String>();
			for(StCshPaySubMaster subType:new BOCashierController().getPaySubTypes(null, paymentTypeId))
				paySubTypeMap.put(subType.getSubTypeId(), BeanUtils.
						getProperty(subType, PaySubTypes.valueOf(subType.getPaymentType()).getDispProperty()));
			response.getWriter().write(new Gson().toJson(paySubTypeMap));
		} catch (Exception e) {
			e.printStackTrace();
		}
	} 
	
	public String savePODMSetup() {
		try {
			payOptBean.setCreatedBy((long)userInfoBean.getUserId());
			payOptBean.setLastUpdatedBy((long)userInfoBean.getUserId());
			payOptBean.setStatus("INACTIVE");
			new BOCashierController().savePODMSetup(payOptBean);
		} catch (Exception e) {
			e.printStackTrace();
			addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
			return "exception";
		}
		return SUCCESS;
	}

	public String resolveWagerStatus(){
		try {
			BOCashierController.resolveWagerStatus(gameServiceId,tids);
		} catch (Exception e) {
			e.printStackTrace();
			addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
			return "exception";
		}
		return SUCCESS;
	}

	public String updatePlayerLedger(){
		try {
			Log.info("list of player-------------"+playerList);
			new CashierController().updatePlayerLedger(fromDate, toDate, domainId,playerList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String backOfficeDeposit(){
		
		try {
			
			new CashierController().depositFromBO(domainId, userName, amt,userInfoBean);
			actionMessage="Player's deposit successfully.";
		} catch (Exception e) {
			e.printStackTrace();
			addActionError(e.getMessage());
			return "exception";
		}
		return SUCCESS;
	}

	public void claimAmount() {
		Map<String, Object> data = new HashMap<>();
		PrintWriter out = null;
		Gson gson = new Gson();
		try {
			// deposit call
			out=response.getWriter();
			long transactionId = new CashierController().depositFromBO(unclaimedTxn.getDomainId(),
					unclaimedTxn.getMobileNumber(), unclaimedTxn.getAmount());
			actionMessage = "Player's deposit successful.";
			// setting status "CLAIMED" in st_csh_unclaimed_deposits_bceid table
			// setting status "DONE" in st_csh_tp_txn_records
			new CashierController().updateUnclaimedDepositStatus(unclaimedTxn, transactionId);
			data.put("result", 0);
		}catch(PMSException e) {
			e.printStackTrace();
			data.put("result", 401);
		}catch (IOException e) {
			e.printStackTrace();
			data.put("result", 400);
		}catch (Exception e) {
			data.put("result", 400);
		}finally {
			out.write(gson.toJson(data));
		}
	}

	public int getCountryId() {
		return countryId;
	}

	public void setCountryId(int countryId) {
		this.countryId = countryId;
	}

	public int getCurrencyId() {
		return currencyId;
	}

	public void setCurrencyId(int currencyId) {
		this.currencyId = currencyId;
	}

	public String getTxnType() {
		return txnType;
	}

	public void setTxnType(String txnType) {
		this.txnType = txnType;
	}

	public void setPomMap(Map<Integer, PaymentOptionTypeBean> pomMap) {
		this.pomMap = pomMap;
	}

	public Map<Integer, PaymentOptionTypeBean> getPomMap() {
		return pomMap;
	}

	public void setPomId(long[] pomId) {
		this.pomId = pomId;
	}

	public long[] getPomId() {
		return pomId;
	}

	public void setPriorityOrder(short[] priorityOrder) {
		this.priorityOrder = priorityOrder;
	}

	public short[] getPriorityOrder() {
		return priorityOrder;
	}

	public void setWdrTxnMap(Map<Long, WithdrawalTxnBean> wdrTxnMap) {
		this.wdrTxnMap = wdrTxnMap;
	}

	public Map<Long, WithdrawalTxnBean> getWdrTxnMap() {
		return wdrTxnMap;
	}	

	public String getWdrTxnStr() {
		return wdrTxnStr;
	}


	public void setWdrTxnStr(String wdrTxnStr) {
		this.wdrTxnStr = wdrTxnStr;
	}
	
	public void setTxnIds(long[] txnIds) {
		this.txnIds = txnIds;
	}

	public long[] getTxnIds() {
		return txnIds;
	}

	public void setWdrStatus(String wdrStatus) {
		this.wdrStatus = wdrStatus;
	}

	public String getWdrStatus() {
		return wdrStatus;
	}

	public void setWithdrawalJsonData(String withdrawalJsonData) {
		this.withdrawalJsonData = withdrawalJsonData;
	}

	public String getWithdrawalJsonData() {
		return withdrawalJsonData;
	}

	public void setPaymentTypeCode(String paymentTypeCode) {
		this.paymentTypeCode = paymentTypeCode;
	}

	public String getPaymentTypeCode() {
		return paymentTypeCode;
	}

	public void setGenerateExcel(boolean generateExcel) {
		this.generateExcel = generateExcel;
	}

	public boolean isGenerateExcel() {
		return generateExcel;
	}

	public void setTxnSearchBean(TxnSearchBean txnSearchBean) {
		this.txnSearchBean = txnSearchBean;
	}

	public TxnSearchBean getTxnSearchBean() {
		return txnSearchBean;
	}

	public void setOfflinePayTypeMap(Map<Integer, PaymentTypeBean> offlinePayTypeMap) {
		this.offlinePayTypeMap = offlinePayTypeMap;
	}

	public Map<Integer, PaymentTypeBean> getOfflinePayTypeMap() {
		return offlinePayTypeMap;
	}

	public void setDepositReqMap(Map<Long, DepositRequestBean> depositReqMap) {
		this.depositReqMap = depositReqMap;
	}

	public Map<Long, DepositRequestBean> getDepositReqMap() {
		return depositReqMap;
	}

	public void setDepositJsonData(String depositJsonData) {
		this.depositJsonData = depositJsonData;
	}

	public String getDepositJsonData() {
		return depositJsonData;
	}

	public void setRequestIds(long[] requestIds) {
		this.requestIds = requestIds;
	}

	public long[] getRequestIds() {
		return requestIds;
	}

	public void setPayTypeContentMap(Map<Integer, PaymentTypeContentBean> payTypeContentMap) {
		this.payTypeContentMap = payTypeContentMap;
	}

	public Map<Integer, PaymentTypeContentBean> getPayTypeContentMap() {
		return payTypeContentMap;
	}

	public void setContentJsonData(String contentJsonData) {
		this.contentJsonData = contentJsonData;
	}

	public String getContentJsonData() {
		return contentJsonData;
	}
	
	public void setVipLevelId(int vipLevelId) {
		this.vipLevelId = vipLevelId;
	}

	public int getVipLevelId() {
		return vipLevelId;
	}

	public Map<Long, PODMProcessingChargeBean> getPodmProcessingChargeMap() {
		return podmProcessingChargeMap;
	}

	public void setPodmProcessingChargeMap(
			Map<Long, PODMProcessingChargeBean> podmProcessingChargeMap) {
		this.podmProcessingChargeMap = podmProcessingChargeMap;
	}

	public void setPodmProcessingChargeBean(
			List<PODMProcessingChargeBean> podmProcessingChargeBean) {
		this.podmProcessingChargeBean = podmProcessingChargeBean;
	}

	public List<PODMProcessingChargeBean> getPodmProcessingChargeBean() {
		return podmProcessingChargeBean;
	}

	public void setPodmProcessingChargeStr(String podmProcessingChargeStr) {
		this.podmProcessingChargeStr = podmProcessingChargeStr;
	}

	public String getPodmProcessingChargeStr() {
		return podmProcessingChargeStr;
	}

	public void setPaymentProviderMap(Map<Integer, String> paymentProviderMap) {
		this.paymentProviderMap = paymentProviderMap;
	}

	public Map<Integer, String> getPaymentProviderMap() {
		return paymentProviderMap;
	}

	public void setProviderName(String providerName) {
		this.providerName = providerName;
	}

	public String getProviderName() {
		return providerName;
	}

	public void setPgSettlementReportFileName(String pgSettlementReportFileName) {
		this.pgSettlementReportFileName = pgSettlementReportFileName;
	}

	public String getPgSettlementReportFileName() {
		return pgSettlementReportFileName;
	}

	public void setPgSettlementReport(File pgSettlementReport) {
		this.pgSettlementReport = pgSettlementReport;
	}

	public File getPgSettlementReport() {
		return pgSettlementReport;
	}

	public void setSettlementType(String settlementType) {
		this.settlementType = settlementType;
	}

	public String getSettlementType() {
		return settlementType;
	}

	public void setDeploymentDate(String deploymentDate) {
		this.deploymentDate = deploymentDate;
	}

	public String getDeploymentDate() {
		return deploymentDate;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserName() {
		return userName;
	}

	public void setPlrList(List<PlayerInfoBean> plrList) {
		this.plrList = plrList;
	}

	public List<PlayerInfoBean> getPlrList() {
		return plrList;
	}

	public void setPayCorrection(PlayerPaymentCorrection payCorrection) {
		this.payCorrection = payCorrection;
	}

	public PlayerPaymentCorrection getPayCorrection() {
		return payCorrection;
	}

	public void setPlrFraudReqBean(PlrFraudReqBean plrFraudReqBean) {
		this.plrFraudReqBean = plrFraudReqBean;
	}

	public PlrFraudReqBean getPlrFraudReqBean() {
		return plrFraudReqBean;
	}

	public void setVipList(List<Integer> vipList) {
		this.vipList = vipList;
	}

	public List<Integer> getVipList() {
		return vipList;
	}

	public void setVipLevelMap(Map<Short, List<VipLevelMasterBean>> vipLevelMap) {
		this.vipLevelMap = vipLevelMap;
	}

	public Map<Short, List<VipLevelMasterBean>> getVipLevelMap() {
		return vipLevelMap;
	}

	public void setDomainMap(Map<Short,String> domainMap) {
		this.domainMap = domainMap;
	}

	public Map<Integer, CurrencyBean> getCurrencyMap() {
		return currencyMap;
	}

	public void setDomainVipList(List<VipLevelMasterBean> domainVipList) {
		this.domainVipList = domainVipList;
	}

	public List<VipLevelMasterBean> getDomainVipList() {
		return domainVipList;
	}

	public void setRedAccList(List<PlrRedeemAccBankInfoBean> redAccList) {
		this.redAccList = redAccList;
	}

	public List<PlrRedeemAccBankInfoBean> getRedAccList() {
		return redAccList;
	}

	public void setPlayerId(long playerId) {
		this.playerId = playerId;
	}

	public long getPlayerId() {
		return playerId;
	}

	public void setRedAccIds(long[] redAccIds) {
		this.redAccIds = redAccIds;
	}

	public long[] getRedAccIds() {
		return redAccIds;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getActionMessage() {
		return actionMessage;
	}

	public void setActionMessage(String actionMessage) {
		this.actionMessage = actionMessage;
	}

	public String getStatus() {
		return status;
	}

	public void setDevice(String device) {
		this.device = device;
	}

	public String getDevice() {
		return device;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
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

	public List<Object> getResultList() {
		return resultList;
	}

	public void setResultList(List<Object> resultList) {
		this.resultList = resultList;
	}

	public String getProcessedWithdrawalJsonData() {
		return processedWithdrawalJsonData;
	}

	public void setProcessedWithdrawalJsonData(
			String processedWithdrawalJsonData) {
		this.processedWithdrawalJsonData = processedWithdrawalJsonData;
	}
	public String getDownloadParam() {
		return downloadParam;
	}

	public void setDownloadParam(String downloadParam) {
		this.downloadParam = downloadParam;
	}

	public File getPokerSettlement() {
		return pokerSettlement;
	}

	public void setPokerSettlement(File pokerSettlement) {
		this.pokerSettlement = pokerSettlement;
	}

	public String getPokerSettlementFileName() {
		return pokerSettlementFileName;
	}

	public void setPokerSettlementFileName(String pokerSettlementFileName) {
		this.pokerSettlementFileName = pokerSettlementFileName;
	}
	
	public long getTableId() {
		return tableId;
	}

	public void setTableId(long tableId) {
		this.tableId = tableId;
	}

	public String getSubWalletTime() {
		return subWalletTime;
	}

	public void setSubWalletTime(String subWalletTime) {
		this.subWalletTime = subWalletTime;
	}

	public double getAmt() {
		return amt;
	}

	public void setAmt(double amt) {
		this.amt = amt;
	}



	public String getProvider() {
		return provider;
	}




	public void setProvider(String provider) {
		this.provider = provider;
	}




	public long getRequestId() {
		return requestId;
	}

	public Integer getPaymentTypeId() {
		return paymentTypeId;
	}



	public void setRequestId(long requestId) {
		this.requestId = requestId;
	}


	public long getRedeemAccIdEdit() {
		return redeemAccIdEdit;
	}


	public void setRedeemAccIdEdit(long redeemAccIdEdit) {
		this.redeemAccIdEdit = redeemAccIdEdit;
	}


	public String getBeneficiaryName() {
		return beneficiaryName;
	}


	public void setBeneficiaryName(String beneficiaryName) {
		this.beneficiaryName = beneficiaryName;
	}


	public PlrRedeemAccBankInfoBean getRedAccBankBean() {
		return redAccBankBean;
	}


	public void setRedAccBankBean(PlrRedeemAccBankInfoBean redAccBankBean) {
		this.redAccBankBean = redAccBankBean;
	}


	public Map<String, Integer> getBankMap() {
		return bankMap;
	}


	public void setBankMap(Map<String, Integer> bankMap) {
		this.bankMap = bankMap;
	}


	public String getBankCode() {
		return bankCode;
	}


	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}


	public File getPaytmSettlement() {
		return paytmSettlement;
	}


	public void setPaytmSettlement(File paytmSettlement) {
		this.paytmSettlement = paytmSettlement;
	}


	public String getPaytmSettlementFileName() {
		return paytmSettlementFileName;
	}


	public void setPaytmSettlementFileName(String paytmSettlementFileName) {
		this.paytmSettlementFileName = paytmSettlementFileName;
	}


	public Integer getProviderId() {
		return providerId;
	}


	public void setProviderId(Integer providerId) {
		this.providerId = providerId;
	}


	public Map<String, Short> getGameServiceMap() {
		return gameServiceMap;
	}


	public void setGameServiceMap(Map<String, Short> gameServiceMap) {
		this.gameServiceMap = gameServiceMap;
	}


	public Short getGameServiceId() {
		return gameServiceId;
	}


	public void setGameServiceId(Short gameServiceId) {
		this.gameServiceId = gameServiceId;
	}


	public String getGameServiceCode() {
		return gameServiceCode;
	}


	public void setGameServiceCode(String gameServiceCode) {
		this.gameServiceCode = gameServiceCode;
	}


	public Timestamp getWagerFromDate() {
		return wagerFromDate;
	}


	public void setWagerFromDate(Timestamp wagerFromDate) {
		this.wagerFromDate = wagerFromDate;
	}


	public Timestamp getWagerToDate() {
		return wagerToDate;
	}


	public void setWagerToDate(Timestamp wagerToDate) {
		this.wagerToDate = wagerToDate;
	}


	public List<StTxnWagerMaster> getWagerList() {
		return wagerList;
	}


	public void setWagerList(List<StTxnWagerMaster> wagerList) {
		this.wagerList = wagerList;
	}


	public List<StCshPaymentTypeMaster> getPayTypeMasterList() {
		return payTypeMasterList;
	}


	public void setPayTypeMasterList(List<StCshPaymentTypeMaster> payTypeMasterList) {
		this.payTypeMasterList = payTypeMasterList;
	}


	public List<StCshPaySubMaster> getPaySubTypesList() {
		return paySubTypesList;
	}


	public void setPaySubTypesList(List<StCshPaySubMaster> paySubTypesList) {
		this.paySubTypesList = paySubTypesList;
	}


	public PaySubTypeBean getPaySubType() {
		return paySubType;
	}


	public void setPaySubType(PaySubTypeBean paySubType) {
		this.paySubType = paySubType;
	}


	public Map<Integer, String> getCountryMap() {
		return countryMap;
	}


	public void setCountryMap(Map<Integer, String> countryMap) {
		this.countryMap = countryMap;
	}


	public Map<Long, String> getProcChargMap() {
		return procChargMap;
	}


	public void setProcChargMap(Map<Long, String> procChargMap) {
		this.procChargMap = procChargMap;
	}


	public PayOptBean getPayOptBean() {
		return payOptBean;
	}


	public void setPayOptBean(PayOptBean payOptBean) {
		this.payOptBean = payOptBean;
	}

	public void setPaymentTypeId(Integer paymentTypeId) {
		this.paymentTypeId = paymentTypeId;
	}



	public String getAccNum() {
		return accNum;
	}


	public void setAccNum(String accNum) {
		this.accNum = accNum;
	}


	public Integer getSubtypeId() {
		return subtypeId;
	}


	public void setSubtypeId(Integer subtypeId) {
		this.subtypeId = subtypeId;
	}


	public String getBranchLocation() {
		return branchLocation;
	}


	public void setBranchLocation(String branchLocation) {
		this.branchLocation = branchLocation.trim();
	}


	public String getBranchCity() {
		return branchCity;
	}


	public void setBranchCity(String branchCity) {
		this.branchCity = branchCity;
	}


	public String getBranchAddress() {
		return branchAddress;
	}


	public void setBranchAddress(String branchAddress) {
		this.branchAddress = branchAddress.trim();
	}


	public String getIfscCode() {
		return ifscCode;
	}


	public void setIfscCode(String ifscCode) {
		this.ifscCode = ifscCode;
	}


	public String getMicrCode() {
		return micrCode;
	}


	public void setMicrCode(String micrCode) {
		this.micrCode = micrCode;
	}


	public void setCurrencyMap(Map<Integer, CurrencyBean> currencyMap) {
		this.currencyMap = currencyMap;
	}
	
	public List<Long> getTids() {
		return tids;
	}

	public void setTids(List<Long> tids) {
		this.tids = tids;
	}


	public short getAliasId() {
		return aliasId;
	}


	public void setAliasId(short aliasId) {
		this.aliasId = aliasId;
	}


	public String getPlayerList() {
		return playerList;
	}


	public void setPlayerList(String playerList) {
		this.playerList = playerList;
	}


	public int getStartSubwalletId() {
		return startSubwalletId;
	}


	public void setStartSubwalletId(int startSubwalletId) {
		this.startSubwalletId = startSubwalletId;
	}


	public File getSettlementSheet() {
		return settlementSheet;
	}


	public void setSettlementSheet(File settlementSheet) {
		this.settlementSheet = settlementSheet;
	}
	
	public String getSettlementSheetFileName() {
		return settlementSheetFileName;
	}


	public void setSettlementSheetFileName(String settlementSheetFileName) {
		this.settlementSheetFileName = settlementSheetFileName;
	}

	public String getCorrectionList() {
		return correctionList;
	}


	public void setCorrectionList(String correctionList) {
		this.correctionList = correctionList;
	}
	
	public String getPreviousFlag() {
		return previousFlag;
	}


	public void setPreviousFlag(String previousFlag) {
		this.previousFlag = previousFlag;
	}


	public String getIsLastPage() {
		return isLastPage;
	}


	public void setIsLastPage(String isLastPage) {
		this.isLastPage = isLastPage;
	}


	public String getDisplaySize() {
		return displaySize;
	}


	public void setDisplaySize(String displaySize) {
		this.displaySize = displaySize;
	}

	public Map<Short, String> getAliasMap() {
		return aliasMap;
	}


	public void setAliasMap(Map<Short, String> aliasMap) {
		this.aliasMap = aliasMap;
	}


	public List<UnclaimedTxnBean> getUnclaimedRecords() {
		return unclaimedRecords;
	}


	public void setUnclaimedRecords(List<UnclaimedTxnBean> unclaimedRecords) {
		this.unclaimedRecords = unclaimedRecords;
	}


	public UnclaimedTxnBean getUnclaimedTxn() {
		return unclaimedTxn;
	}


	public void setUnclaimedTxn(UnclaimedTxnBean unclaimedTxn) {
		this.unclaimedTxn = unclaimedTxn;
	}

	
}

 */