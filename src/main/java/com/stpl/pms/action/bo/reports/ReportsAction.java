package com.stpl.pms.action.bo.reports;

//import java.io.BufferedOutputStream;
//import java.io.IOException;
//import java.io.OutputStream;
//import java.io.PrintWriter;
//import java.lang.reflect.Type;
//import java.net.URLEncoder;
//import java.sql.Timestamp;
//import java.text.DateFormat;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Calendar;
//import java.util.Date;
//import java.util.HashMap;
//import java.util.HashSet;
//import java.util.Iterator;
//import java.util.LinkedHashMap;
//import java.util.List;
//import java.util.Map;
//import java.util.Map.Entry;
//import java.util.Set;
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
//import com.stpl.pms.controller.analytical.AnalyticalController;
//import com.stpl.pms.controller.cashier.BOCashierController;
//import com.stpl.pms.controller.cms.CmsController;
//import com.stpl.pms.controller.commonMethods.CommonMethodController;
//import com.stpl.pms.controller.pm.PlayerMgmtController;
//import com.stpl.pms.controller.reports.ReportsController;
//import com.stpl.pms.controller.reports.exportExcel.ReportToExcel;
//import com.stpl.pms.controller.reports.gst.StateWiseGstReport;
//import com.stpl.pms.daoImpl.reports.ReportsDaoImpl;
//import com.stpl.pms.exception.PMSException;
//import com.stpl.pms.hibernate.mapping.StPmPlayerInboxMaster;
//import com.stpl.pms.hibernate.mapping.StPmPlayerMaster;
//import com.stpl.pms.hibernate.mapping.StRpBoMisAccountReportMaster;
//import com.stpl.pms.hibernate.mapping.StTxnPlrDepositMaster;
//import com.stpl.pms.hibernate.mapping.StTxnPlrWalletMaster;
//import com.stpl.pms.hibernate.mapping.StTxnPlrWithdrawalMaster;
//import com.stpl.pms.hibernate.mapping.TxnSettlementReportBean;
//import com.stpl.pms.javabeans.CurrencyBean;
//import com.stpl.pms.javabeans.PlayerDetailInfoBean;
//import com.stpl.pms.javabeans.PlayerInfoBean;
//import com.stpl.pms.javabeans.PlrSearchOptionBean;
//import com.stpl.pms.javabeans.PokerSettlementReportBean;
//import com.stpl.pms.javabeans.StPmPlayerLoginDetailsBean;
//import com.stpl.pms.javabeans.ThirdPartyWagerBean;
import com.stpl.pms.struts.common.BaseActionSupport;
//import com.stpl.pms.uaparser.Client;
//import com.stpl.pms.uaparser.Parser;
//import com.stpl.pms.utility.Utility;

public class ReportsAction extends BaseActionSupport {
}
	/*
	 * private static final long serialVersionUID = 1L; private static final
	 * Logger logger = Logger.getLogger(ReportsAction.class);
	 * 
	 * private PlrSearchOptionBean plrOpt; private ArrayList plrList; private
	 * PlayerDetailInfoBean plrDetailBean; private StPmPlayerMaster plrInfo;
	 * private String reportData; private String procName; private
	 * List<String[]> resultList; private int resultSize; private Map
	 * reportResult; private String reportType; private Set tnxStatus; private
	 * String headerName; private String playerId; private String
	 * reportTypeName; private int providerId; private Timestamp fromDate;
	 * private Timestamp toDate; private Map<Integer, String>
	 * paymentProviderMap; private String leftTopHeading; private ArrayList
	 * plrreportBean; private String emailId; private String userName; private
	 * int recordPerPage; private int paginationPage; private Timestamp
	 * fromLastTrans; private Timestamp toLastTrans; private Timestamp
	 * fromBonusTrans; private Timestamp toBonusTrans; private String
	 * txnPlayerId; private String bonusName; private String campType; private
	 * String campId; private String subCampId; private String massage; private
	 * List<StRpBoMisAccountReportMaster> misReportTypeList; Map<String, String>
	 * misParamMap = new HashMap<String, String>() ; private String redirect;
	 * private List<String> paramList; private String referSource; private
	 * String defaultCounry; private int nativeCurrencyId; private Map<Integer,
	 * CurrencyBean> currencyMap; private int reportCurrency; private String
	 * openDeco; private String[] headerArray; private String avgTotalSucc;
	 * private List<Object[]> dataListReqNotFound; private List<Object[]>
	 * dataListStatusUnmatched; private int count; private String jsonList;
	 * private Map <Short,String> aliasIdMap; private String providerName;
	 * private List<PokerSettlementReportBean> pokerSettlementSearchList;
	 * private String correctionJsonData; private short alias; private String
	 * pokerSettlstatus; private String paytmSettlstatus; private String
	 * domainId1; private String fromDateBonus; private String toDateBonus;
	 * private String toDateTxn; private String fromDateTxn; private String
	 * startIndex; private String recordTofetch; private String campName;
	 * private String subCampName; private String reportFlag;
	 * 
	 * 
	 * 
	 * private enum proceEnum { SaleAndCommissionDueReport,
	 * CampWiseRevenuReport, CampRevenueReport, indiaBetPlayerWagerReport,
	 * indiaBetPlayerReport, zapakPlayerDepositReport, zapakPlayerReport,
	 * playerPayCorrectionReport, getPlayerTransactionReports,
	 * getDepositDetailPG, getWithdrawalDetailPG, getDepositDetailPT,
	 * getWithdrawalDetailPT, getDepositDetailMix, getWithdrawalDetailMix,
	 * getPlayerDepositReport, getPlrDepReportWithStatus,
	 * getWithDrawalTxnReport, StCmsCampTracking, StCmsReferFriendTracking,
	 * getWithDrawalProcessedTxnReport, getBonusDetailReport,
	 * getBonusAnalysisReport, getBonusPlrDetailReport,
	 * stCmsCampPlayerRegReport, stCmsCampPlayerDepReport,
	 * stCmsReferFriendPlrRegReport, stCmsReferFriendPlrDepReport,
	 * getPlrWithDrawalReportWithStatus,
	 * mobileAppDownloadDetail,getAppsFlyerAndroidReportData,
	 * getAppsFlyerIosReportData,stCmsCampAppDownReport,
	 * stCmsCampPlayerWiseDepReport, campRevReferFrndReport,
	 * campRevReferFrndPlrReport ,StCmsReferFriendInvitedTracking,
	 * StCmsReferFriendVisitedTracking,LocationWiseWagerAndWinning,
	 * deviceWiseWagerAndWinning,plrWiseWagerWinningFromTablet,StateWiseReport,
	 * AliasWiseWagerAndWinning,MgmtReport,StateWiseRakeForAlias }
	 * 
	 * 
	 * @SuppressWarnings("unchecked") public String playerSearchRep() throws
	 * IOException { logger.info("--Start Player Search Report--");
	 * ReportsController controller = new ReportsController(); try { if
	 * (plrOpt.getRedirect().equalsIgnoreCase("Search")) { if (recordPerPage >
	 * 0) { if(paginationPage==0) paginationPage=1;
	 * setPlrList(controller.searchPlayerData(plrOpt, recordPerPage,
	 * paginationPage)); setAliasIdMap((Map<Short, String>)plrList.get(4)); }
	 * else { setPlrList(controller.searchPlayerData(plrOpt, 100, 1));
	 * setAliasIdMap((Map<Short, String>)plrList.get(4)); } } else if
	 * (plrOpt.getRedirect().equalsIgnoreCase("Excel")) { List<Object[]>
	 * PlayerData =controller.searchPlayerData(plrOpt, recordPerPage,
	 * paginationPage); playerExcelDownload(PlayerData); return Action.NONE; } }
	 * catch (PMSException e) { e.printStackTrace();
	 * addActionError(e.getErrorMessage()); if(e.getErrorCode()==507){ return
	 * "limitReportData"; }else{ return "exception_nodecorate"; } } return
	 * SUCCESS; } /*@SuppressWarnings("unchecked") public String
	 * dowloadPlayerSearchExcel() throws IOException{
	 * logger.info("--Start Player Search Report--"); ReportsController
	 * controller = new ReportsController(); try {
	 * 
	 * List<Object[]> PlayerData =
	 * controller.searchPlayerData(plrOpt,recordPerPage, paginationPage);
	 * playerExcelDownload(PlayerData); //playerSearchRep();
	 * 
	 * } catch (PMSException e) { e.printStackTrace();
	 * addActionError(e.getErrorMessage()); if(e.getErrorCode()==507){ return
	 * "limitReportData"; }else{ return "exception_nodecorate"; } } return
	 * SUCCESS; }
	 

	public void playerDetailsEdit() {
		logger.info("--Start Player Edit info--");
		String msg = null;
		domainId = Short.parseShort(request.getParameter("domainId1"));
		try {
			PlayerMgmtController plrController = new PlayerMgmtController();
			PlayerInfoBean plrInfoBean = plrController
					.getPlayerInfoById(Long.valueOf(request.getParameter("playerId1").toString()));
			if (request.getParameter("dob") != null && !"".equals(request.getParameter("dob"))) {
				plrInfoBean.setDateOfBirth(request.getParameter("dob"));
			}
			if (request.getParameter("fName").toString() != null
					&& !"".equals(request.getParameter("fName").toString())) {
				plrInfoBean.setFirstName(request.getParameter("fName").toString());
			}
			if ((String) request.getParameter("lName") != null && !"".equals((String) request.getParameter("lName"))) {
				plrInfoBean.setLastName((String) request.getParameter("lName"));
			}
			if ((String) request.getParameter("title") != null && !"".equals((String) request.getParameter("title"))) {
				plrInfoBean.setTitle((String) request.getParameter("title"));
			}
			if ((String) request.getParameter("gender") != null
					&& !"".equals((String) request.getParameter("gender"))) {
				plrInfoBean.setGender((String) request.getParameter("gender"));
			}
			if ((String) request.getParameter("phoneVerified") != null
					&& !"".equals((String) request.getParameter("phoneVerified"))
					&& !"-1".equals(request.getParameter("phoneVerified"))) {
				plrInfoBean.setPhoneVerified((String) request.getParameter("phoneVerified"));
			}
			if ((String) request.getParameter("emailVerified") != null
					&& !"".equals((String) request.getParameter("emailVerified"))
					&& !"-1".equals(request.getParameter("emailVerified"))) {
				plrInfoBean.setEmailVerified((String) request.getParameter("emailVerified"));
			}

			if (request.getParameter("houseNum") != null && !"".equals(request.getParameter("houseNum"))) {
				plrInfoBean.setHouseNum(request.getParameter("houseNum"));
			}
			if ((String) request.getParameter("add1") != null && !"".equals((String) request.getParameter("add1"))) {
				plrInfoBean.setAddressLine1((String) request.getParameter("add1"));
			}
			if ((String) request.getParameter("add2") != null && !"".equals((String) request.getParameter("add2"))) {
				plrInfoBean.setAddressLine2((String) request.getParameter("add2"));
			}

			if (request.getParameter("plrCity") != null && !"".equals(request.getParameter("plrCity"))) {
				plrInfoBean.setCity(request.getParameter("plrCity"));
			}
			if (request.getParameter("plrPostalCode") != null && !"".equals(request.getParameter("plrPostalCode"))) {
				plrInfoBean.setPostalCode(request.getParameter("plrPostalCode"));
			}
			if (request.getParameter("plrCountry") != null && !"".equals(request.getParameter("plrCountry"))
					&& !"-1".equals(request.getParameter("plrCountry"))) {
				plrInfoBean.setCountryId(Integer.parseInt(request.getParameter("plrCountry")));
			}
			if (request.getParameter("plrState") != null && !"".equals(request.getParameter("plrState"))
					&& !"-1".equals(request.getParameter("plrState"))) {
				plrInfoBean.setStateId(Integer.parseInt(request.getParameter("plrState")));
			}
			if (request.getParameter("profileStatus") != null && !"".equals(request.getParameter("profileStatus"))
					&& !"-1".equals(request.getParameter("profileStatus"))) {
				plrInfoBean.setStatus(request.getParameter("profileStatus"));
			}
			if (request.getParameter("commPromo") != null && !"".equals(request.getParameter("commPromo"))
					&& !"-1".equals(request.getParameter("commPromo"))) {
				plrInfoBean.setCommPromo(request.getParameter("commPromo"));
			}
			plrController.changePlayerInfo(plrInfoBean, "BACKOFFICE");

			ReportsController controller = new ReportsController();
			String status = null, reason = null;
			if ((String) request.getParameter("reason") != null
					&& !"".equals((String) request.getParameter("reason"))) {
				reason = (String) request.getParameter("reason");
			}
			if (request.getParameter("regStatus1") != null && !"".equals(request.getParameter("regStatus1"))
					&& !"-1".equals(request.getParameter("regStatus1"))) {
				status = request.getParameter("regStatus1");
			}
			msg = controller.plrPersonalDataEdit(plrInfoBean.getPlayerId(), status, reason);
			if (msg.equalsIgnoreCase("SUCCESS")) {
				response.getWriter().write("success");

				new AnalyticalController(plrInfoBean.getDomainId(), plrInfoBean.getAliasId()).verifiedByBO(
						plrInfoBean.getDomainId(), plrInfoBean.getAliasId(), "" + plrInfoBean.getPlayerId(),
						request.getParameter("emailVerified"), request.getParameter("phoneVerified"));

			} else if (msg.equalsIgnoreCase("ERROR")) {
				response.getWriter().write("error");
			}
			// else if (msg.equalsIgnoreCase("email")) {
			// response.getWriter().write("email");
			// } else if (msg.equalsIgnoreCase("mobileno")) {
			// response.getWriter().write("mobileno");
			// }
			logger.info("----------------reportsAction End ------------");
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();

		}

	}

	public String playerDetailsRep() {
		logger.info("--Start Player Details --");
		ReportsController controller = new ReportsController();
		try {
			plrDetailBean = controller.searchPlayerDetails(playerId);
			if ("true".equalsIgnoreCase(openDeco))
				request.getSession().setAttribute("decoratorName", "mainpage");
			else
				request.getSession().setAttribute("decoratorName", "blankDeco");
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception_nodecorate";
		}
		return SUCCESS;
	}

	public void getLoginDetails() {
		logger.info("--Start Login Details --");
		ReportsController controller = new ReportsController();
		try {
			List<StPmPlayerLoginDetailsBean> loginDetailList = controller.getLoginDetailList(playerId);
			if (loginDetailList.size() > 0) {
				response.getWriter().write(new Utility().convertJSON(loginDetailList));
			} else
				response.getWriter().write("{}");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (Exception be) {
			be.printStackTrace();
		}
	}

	public void getWalletDetails() {
		logger.info("--Start Wallet Details --");
		ReportsController controller = new ReportsController();
		try {
			StTxnPlrWalletMaster walletDetailList = controller.getWalletDetailList(playerId,
					Short.parseShort(domainId1));
			if (walletDetailList != null) {
				response.getWriter().write(new Utility().convertJSON(walletDetailList));
			} else
				response.getWriter().write("{}");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (Exception be) {
			be.printStackTrace();
		}
	}

	public void getRakeAmount() {
		logger.info("--Start Rake Amount --");
		ReportsController controller = new ReportsController();
		try {
			Double rake = controller.getRakeAmount(playerId);
			if (rake == null)
				rake = 0.0;
			response.getWriter().write(rake.toString());
		} catch (IOException e) {
			e.printStackTrace();
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (Exception be) {
			be.printStackTrace();
		}

	}

	public void getdepositDetails() {
		logger.info("--Start Deporsit Details --");
		ReportsController controller = new ReportsController();
		try {
			List<StTxnPlrDepositMaster> depositDetailList = controller.getDepositDetailList(playerId);
			if (depositDetailList.size() > 0) {
				response.getWriter().write(new Utility().convertJSON(depositDetailList));
			} else
				response.getWriter().write("{}");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (Exception be) {
			be.printStackTrace();
		}
	}

	public void getThirdPartyTxnDetails() {
		logger.info("--Start Third Party Transaction--");
		ArrayList<Object> dateNdata = new ArrayList<Object>();
		try {
			List<ThirdPartyWagerBean> thirdPartyTxnList = null;
			if (playerId != null) {
				DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
				String direction = null;
				Timestamp from = null;
				Timestamp to = null;
				if (fromDateTxn != null && toDateTxn != null) {
					DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
					Date fromDate = df.parse(fromDateTxn.substring(0, 10) + " " + fromDateTxn.substring(11));
					Date toDate = df.parse(toDateTxn.substring(0, 10) + " " + toDateTxn.substring(11));
					from = new java.sql.Timestamp(fromDate.getTime());
					to = new java.sql.Timestamp(toDate.getTime());
					direction = "full";
				} else {
					Calendar cal = Calendar.getInstance();
					cal.add(Calendar.DATE, -15);
					from = new Timestamp(cal.getTimeInMillis());
					to = new Timestamp(System.currentTimeMillis());
					direction = "view";
				}
				thirdPartyTxnList = new ReportsController().getThirdPartyTxnList(Long.parseLong(playerId), from, to,
						null, null, direction);
				dateNdata.add(dateFormat.format(from));
				dateNdata.add(dateFormat.format(to));
				if (thirdPartyTxnList.size() > 0)
					dateNdata.add(thirdPartyTxnList);
				if (dateNdata.size() > 0) {
					response.getWriter().write(new Utility().convertJSON(dateNdata));
				} else
					response.getWriter().write("{}");
			} else
				throw new PMSException("PlayerId can't be null!");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (Exception be) {
			be.printStackTrace();
		}
	}


	 * public void getWeaverEcoNetSaleRecord() {
	 * logger.info("--Start WeaverEcoNetSaleRecord Request--");
	 * ArrayList<Object> dateNdata = new ArrayList<Object>(); try {
	 * System.out.println(reportData); List<WeaverEcoNetSaleBean>
	 * weaverEcoSaleRcord = null; Timestamp from = null; Timestamp to = null;
	 * DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss"); Date
	 * fromDate = df.parse(fromDateTxn.substring(0, 10) + " " +
	 * fromDateTxn.substring(11)); Date toDate = df.parse(toDateTxn.substring(0,
	 * 10) + " " + toDateTxn.substring(11)); from = new
	 * java.sql.Timestamp(fromDate.getTime()); to = new
	 * java.sql.Timestamp(toDate.getTime());
	 * 
	 * weaverEcoSaleRcord = new
	 * ReportsController().plrWeaverEconetSaleRecord(domainId, aliasId, from,
	 * to); if (weaverEcoSaleRcord.size() > 0) response.getWriter().write(new
	 * Utility().convertJSON(dateNdata)); else response.getWriter().write("{}");
	 * } catch (IOException e) { e.printStackTrace(); } catch (PMSException e) {
	 * e.printStackTrace(); } catch (Exception be) { be.printStackTrace(); }
	 * logger.info("--End WeaverEcoNetSaleRecord Request--"); }
	 

	public void getwithDetails() {
		logger.info("--Start Deporsit Details --");
		ReportsController controller = new ReportsController();
		try {
			List<StTxnPlrWithdrawalMaster> depositDetailList = controller.getWithDetailList(playerId);
			if (depositDetailList.size() > 0) {
				response.getWriter().write(new Utility().convertJSON(depositDetailList));
			} else
				response.getWriter().write("{}");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (Exception be) {
			be.printStackTrace();
		}
	}

	public void getInboxDetails() {
		logger.info("--Start Inbox Details --");
		ReportsController controller = new ReportsController();
		try {
			List<StPmPlayerInboxMaster> inboxDetailList = controller.getInboxDetailList(playerId,
					Short.parseShort(domainId1));
			if (inboxDetailList.size() > 0) {
				response.getWriter().write(new Utility().convertJSON(inboxDetailList));
			} else
				response.getWriter().write("{}");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (Exception be) {
			be.printStackTrace();
		}
	}

	public void getTxnDetails() {
		logger.info("--Start Txn Details --");
		ReportsController controller = new ReportsController();
		try {
			ArrayList txnDetailList = controller.getTxnDetailList(playerId);
			if (txnDetailList.size() > 0) {
				response.getWriter().write(new Utility().convertJSON(txnDetailList));
			} else
				response.getWriter().write("{}");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (Exception be) {
			be.printStackTrace();
		}
	}

	public void getBonusDetails() {
		logger.info("--Start Bonus Details --");
		ReportsController controller = new ReportsController();
		try {
			ArrayList bunusDetailList = controller.getBonusDetailList(playerId);
			if (bunusDetailList.size() > 0) {
				response.getWriter().write(new Utility().convertJSON(bunusDetailList));
			} else
				response.getWriter().write("{}");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (Exception be) {
			be.printStackTrace();
		}
	}

	public void getBonusDetailFull() {
		logger.info("--Start Bonus Details --");
		ReportsController controller = new ReportsController();
		try {
			ArrayList bunusDetailList = controller.getBonusDetailFullList(playerId, fromDateBonus, toDateBonus);
			if (bunusDetailList.size() > 0) {
				response.getWriter().write(new Utility().convertJSON(bunusDetailList));
			} else
				response.getWriter().write("{}");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (Exception be) {
			be.printStackTrace();
		}
	}

	public void getTxnDetailFull() {
		logger.info("--Start Bonus Details --");
		ReportsController controller = new ReportsController();
		try {
			ArrayList txnDetailList = controller.getTxnDetailFullList(playerId, fromDateTxn, toDateTxn);
			if (txnDetailList.size() > 0) {
				response.getWriter().write(new Utility().convertJSON(txnDetailList));
			} else
				response.getWriter().write("{}");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (Exception be) {
			be.printStackTrace();
		}
	}

	public void getVipDetails() {
		logger.info("--Start Vip Details --");
		ReportsController controller = new ReportsController();
		try {
			List<PlayerDetailInfoBean> vipDetailList = controller.getVipDetailList(playerId);
			if (vipDetailList.size() > 0) {
				response.getWriter().write(new Utility().convertJSON(vipDetailList));
			} else
				response.getWriter().write("{}");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (Exception be) {
			be.printStackTrace();
		}
	}

	public void getCampaignDetails() {
		logger.info("--Start Campaign Details --");
		ReportsController controller = new ReportsController();
		try {
			List<String> data = controller.getCampaignDetails(playerId);
			if (data.size() > 0) {
				response.getWriter().write(new Utility().convertJSON(data));
			} else
				response.getWriter().write("{}");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (Exception be) {
			be.printStackTrace();
		}
	}

	public String fetchSearchReport() {
		HttpSession session = request.getSession();
		logger.info("--Start Player transaction Reports--");
		Gson data = new GsonBuilder().create();
		Type dataType = new TypeToken<Map<String, String>>() {
		}.getType();
		Map<String, String> paramMap = data.fromJson(reportData, dataType);
		logger.info(paramMap);
		if (paramMap.get("campType") != null) {
			if ("REFER_FRIEND".equals(paramMap.get("campType")) && paramMap.size() != 10)
				procName = "StCmsReferFriendTracking";
		}
		ReportsController controller = new ReportsController();
		if ("getPlrDepReportWithStatus".equals(procName) || "getPlrWithDrawalReportWithStatus".equals(procName))
			paramMap = controller.getMisParamMap(paramMap, procName);

		logger.info(paramMap);
		if (procName.equals("zapakPlayerDepositReport") || procName.equals("indiaBetPlayerWagerReport")) {
			String[] dt = (paramMap.get("month")).split("/");
			paramMap.put("fromDate", dt[1] + "-" + dt[0] + "-01 00:00:00");
			paramMap.put("toDate", dt[1] + "-" + dt[0] + "-31 23:59:59");
			paramMap.remove("month");
		}
		if (procName.equals("SaleAndCommissionDueReport")) {
			paramMap.put("startIndex", "-1");
			paramMap.put("recordTofetch", "-1");
		}
		if (paramMap.get("deviceType") != null) {
			if ("ANDROID".equals(paramMap.get("deviceType"))) {
				procName = "getAppsFlyerAndroidReportData";
			}
			if ("IOS".equals(paramMap.get("deviceType"))) {
				procName = "getAppsFlyerIosReportData";
			}
		}

		try {
			if (procName.equals("stCmsCampPlayerRegReport") || procName.equals("stCmsCampPlayerDepReport")) {
				CmsController cmsController = new CmsController();
				if (!paramMap.get("campId").trim().equals("0"))
					paramList = cmsController.getCampaignParams(Long.valueOf(paramMap.get("campId").trim()));
				else {
					paramList = new ArrayList<String>();
					paramList.add("utm_source");
					paramList.add("utm_medium");
					paramList.add("utm_term");
					paramList.add("utm_content");
					paramList.add("utm_campaign");
				}
				String paramVal = "";
				for (int i = 0; i < paramList.size(); i++) {
					paramVal = paramVal + ",value" + (i + 1);
				}
				paramMap.put("paramVal", paramVal);
			}
			if (procName.equals("getAppsFlyerAndroidReportData") || procName.equals("getAppsFlyerIosReportData")
					|| procName.equals("mobileAppDownloadDetail") || procName.equals("getBonusDetailReport")
					|| procName.equals("getBonusAnalysisReport") || procName.equals("playerPayCorrectionReport")
					|| procName.equals("CampRevenueReport") || "campRevReferFrndReport".equals(procName)
					|| procName.equals("getPlrDepReportWithStatus")
					|| procName.equals("getPlrWithDrawalReportWithStatus") || procName.equals("StCmsCampTracking")
					|| procName.equals("StateWiseReport") || procName.equals("MgmtReport")) {
				paramMap.put("startIndex", startIndex);
				if ("StCmsCampTracking".equals(procName) && paramMap.get("campType").equals("PPC"))
					paramMap.put("recordTofetch", String.valueOf(Integer.valueOf(recordTofetch) - 1));
				else
					paramMap.put("recordTofetch", recordTofetch);
			} else if (procName.equals("StCmsReferFriendInvitedTracking")
					|| procName.equals("AliasWiseWagerAndWinning")) {
				paramMap.put("startIndex", "0");
				paramMap.put("recordTofetch", "101");
			}
			if ((procName.equals("getPlayerTransactionReports") || procName.equals("getBonusDetailReport")
					|| procName.equals("getBonusAnalysisReport") || procName.equals("getPlrWithDrawalReportWithStatus")
					|| procName.equals("CampRevenueReport") || procName.equals("campRevReferFrndReport")
					|| procName.equals("getBonusPlrDetailReport") || procName.equals("StateWiseReport"))
					&& !(paramMap.containsKey("aliasId"))) {
				paramMap.put("aliasId", "-1");
			}

			if (procName.equals("AliasWiseWagerAndWinning")) {
				if (!(paramMap.containsKey("aliasId")))
					paramMap.put("aliasId", "-1");
				/*
				 * if(!(paramMap.containsKey("RUMMY_2")))
				 * paramMap.put("RUMMY_2", "N");
				 * if(!(paramMap.containsKey("POKER_12")))
				 * paramMap.put("POKER_12", "N");
				
				if (!(paramMap.containsKey("dateWise")))
					paramMap.put("dateWise", "N");
				if (!(paramMap.containsKey("playerWise")))
					paramMap.put("playerWise", "N");

			}

			resultList = controller.fetchReportsData(paramMap, procName);
			if ("StCmsCampTracking".equals(procName) && resultList.size() != 0
					&& paramMap.get("campType").equals("PPC")) {
				int resultSize = resultList.size();
				int index = 0;
				int sum_of_total_visitor = 0, sum_of_unique_visitor = 0, sum_of_total_registered = 0,
						sum_of_email_verified = 0, sum_of_total_deposited = 0, sum_of_total_download_click = 0;
				for (String[] results : resultList) {
					if (resultSize == 100 && index == 99)
						continue;
					if (!results[4].equals("--"))
						sum_of_total_visitor = sum_of_total_visitor + Integer.parseInt(results[4]);
					if (!results[5].equals("--"))
						sum_of_unique_visitor = sum_of_unique_visitor + Integer.parseInt(results[5]);
					if (!results[8].equals("--"))
						sum_of_total_registered = sum_of_total_registered + Integer.parseInt(results[8]);
					if (!results[9].equals("--"))
						sum_of_email_verified = sum_of_email_verified + Integer.parseInt(results[9]);
					if (!results[12].equals("--"))
						sum_of_total_deposited = sum_of_total_deposited + Integer.parseInt(results[12]);
					if (!results[15].equals("--"))
						sum_of_total_download_click = sum_of_total_download_click + Integer.parseInt(results[15]);
					index++;

				}
				String total[] = { "0", "0", "<b>" + "ALL" + "</b>", "<b>" + "ALL" + "</b>",
						sum_of_total_visitor > 0 ? String.valueOf(sum_of_total_visitor) : "--",
						sum_of_unique_visitor > 0 ? String.valueOf(sum_of_unique_visitor) : "--", "0", "0",
						sum_of_total_registered > 0 ? String.valueOf(sum_of_total_registered) : "--",
						sum_of_email_verified > 0 ? String.valueOf(sum_of_email_verified) : "--", "0", "0",
						sum_of_total_deposited > 0 ? String.valueOf(sum_of_total_deposited) : "--", "0", "0",
						sum_of_total_download_click > 0 ? String.valueOf(sum_of_total_download_click) : "--" };

				resultList.add(0, total);
			}

			if ("getBonusPlrDetailReport".equals(procName)) {
				bonusName = paramMap.get("bonusCode");
			} else if ("stCmsCampPlayerRegReport".equals(procName) || "stCmsCampPlayerDepReport".equals(procName)
					|| "stCmsReferFriendPlrRegReport".equals(procName)
					|| "stCmsReferFriendPlrDepReport".equals(procName)
					|| "StCmsReferFriendInvitedTracking".equals(procName)
					|| "StCmsReferFriendVisitedTracking".equals(procName)) {
				campType = paramMap.get("campType");
				campId = paramMap.get("campId");
				subCampId = paramMap.get("subCampId");
			} else if ("CampWiseRevenuReport".equals(procName)) {
				campName = paramMap.get("camName");
				subCampName = paramMap.get("subCamName");
			} else {
				domaiNameSet(paramMap);
			}
			proceEnum req = proceEnum.valueOf(procName);
			List<String> list = new ArrayList<String>();
			switch (req) {
			case getPlayerTransactionReports:
				controller.getTransactionData(resultList);
				break;
			case getDepositDetailPG:
				leftTopHeading = "Date";
				list = controller.getProviderList("DEPOSIT", Short.parseShort(paramMap.get("domainId").trim()));

				reportResult = depositWithDrawReportMap(resultList, "getDepositDetail",
						list.toArray(new String[list.size()]));
				break;
			case getWithdrawalDetailPG:
				leftTopHeading = "Date";
				list = controller.getProviderList("WITHDRAWAL", Short.parseShort(paramMap.get("domainId").trim()));
				reportResult = depositWithDrawReportMap(resultList, "getWithdrawalDetail",
						list.toArray(new String[list.size()]));
				break;
			case getDepositDetailPT:
				leftTopHeading = "Date";
				list = controller.getPaymentTypeList("DEPOSIT", Short.parseShort(paramMap.get("domainId").trim()));
				reportResult = depositWithDrawReportMap(resultList, "getDepositDetail",
						list.toArray(new String[list.size()]));
				break;
			case getWithdrawalDetailPT:
				leftTopHeading = "Date";
				list = controller.getPaymentTypeList("WITHDRAWAL", Short.parseShort(paramMap.get("domainId").trim()));
				reportResult = depositWithDrawReportMap(resultList, "getWithdrawalDetail",
						list.toArray(new String[list.size()]));
				break;
			case getDepositDetailMix:
				leftTopHeading = "GateWay/Provider";
				reportResult = depositWithDrawMixReportMap(resultList, "getDepositDetail");
				break;
			case getWithdrawalDetailMix:
				leftTopHeading = "GateWay/Provider";
				reportResult = depositWithDrawMixReportMap(resultList, "getWithdrawalDetail");
				break;
			case getWithDrawalTxnReport:
				reportResult = playerWithdrawalStatusReportMap(resultList, "getWithDrawalTxnReport");
				break;
			case getPlayerDepositReport:
				reportResult = playerDepositReportMap(resultList);
				break;
			case getPlrDepReportWithStatus:
				tnxStatus = playerTransactionStatus(resultList);
				break;
			case getPlrWithDrawalReportWithStatus:
				tnxStatus = playerTransactionStatus(resultList);
				break;
			case getWithDrawalProcessedTxnReport:
				reportResult = wDProcessedTxnReport(resultList, paramMap);
				break;
			case mobileAppDownloadDetail:
			case stCmsCampAppDownReport:
				reportType = paramMap.get("reportType");
				if (reportType == null)
					reportType = "CampAppDownReport";
				session.setAttribute("dataTableValue", controller.mobileAppParseUA(resultList));
				break;
			case stCmsCampPlayerWiseDepReport:
				session.setAttribute("dataTableValue", controller.parseReportUA(resultList));
				break;
			case getBonusDetailReport:
			case getBonusAnalysisReport:
			case getBonusPlrDetailReport:
			case playerPayCorrectionReport:
			case zapakPlayerReport:
			case zapakPlayerDepositReport:
			case indiaBetPlayerReport:
			case indiaBetPlayerWagerReport:
			case CampRevenueReport:
			case StCmsCampTracking:
			case stCmsCampPlayerRegReport:
			case stCmsCampPlayerDepReport:
			case stCmsReferFriendPlrRegReport:
			case getAppsFlyerAndroidReportData:
			case getAppsFlyerIosReportData:
			case stCmsReferFriendPlrDepReport:
			case StCmsReferFriendInvitedTracking:
			case StCmsReferFriendVisitedTracking:
			case campRevReferFrndReport:
			case campRevReferFrndPlrReport:
			case LocationWiseWagerAndWinning:
			case deviceWiseWagerAndWinning:
			case StateWiseReport:
			case AliasWiseWagerAndWinning:
			case MgmtReport:
			case SaleAndCommissionDueReport:
			case plrWiseWagerWinningFromTablet:
				session.setAttribute("dataTableValue", resultList);
				break;
			case CampWiseRevenuReport:
				reportData = URLEncoder.encode(reportData, "UTF-8");
				session.setAttribute("dataTableValue", resultList);
				break;
			case StateWiseRakeForAlias:
				session.setAttribute("dataTableValue", new StateWiseGstReport().getStateWaiseGSTRakeReports(resultList,
						paramMap.get("fromDate"), paramMap.get("toDate")));
				break;
			}

		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			if (e.getErrorCode() == 507) {
				return "limitReportData";
			} else {
				return "exception_nodecorate";
			}
		} catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error!");
			return "exception";
		}
		if (procName.equals("StateWiseReport")) {
			if ("firstDep".equals(paramMap.get("whatToGet")))
				procName = "StateWiseFirstDep";
			else if ("totalWager".equals(paramMap.get("whatToGet")))
				procName = "StateWiseTotalWager";
			else if ("registration".equals(paramMap.get("whatToGet")))
				procName = "StateWiseRegistration";
			else if ("totalDeposit".equals(paramMap.get("whatToGet")))
				procName = "StateWiseTotalDeposit";

		}
		if (procName.equals("AliasWiseWagerAndWinning")) {
			if ("N".equals(paramMap.get("dateWise")))
				procName = "playerWiseDisplay";
			if ("N".equals(paramMap.get("playerWise")))
				procName = "dateWiseDisplay";
			if ("all".equals(paramMap.get("gameType")) && "N".equals(paramMap.get("playerWise")))
				procName = "allWagerAndWinning";
			if ("all".equals(paramMap.get("gameType")) && "N".equals(paramMap.get("dateWise")))
				procName = "allPlayerWagerAndWinning";

		}
		return procName;
	}

	public String fetchMisReport() {
		logger.info("--Start Player MIS transaction Reports--");
		Gson data = new GsonBuilder().create();
		Type dataType = new TypeToken<Map<String, String>>() {
		}.getType();
		misParamMap = data.fromJson(reportData, dataType);
		ReportsController controller = new ReportsController();
		try {
			if (misParamMap.containsKey("proceName")) {
				procName = misParamMap.get("proceName");
				misParamMap.remove("proceName");
			}
			misParamMap = controller.getMisParamMap(misParamMap, procName);
			if (redirect != null && redirect.equals("Excel")) {
				exportMISExcelPlrTxnRep();
				return Action.NONE;
			}
			if (!(misParamMap.containsKey("startIndex"))) {
				misParamMap.put("startIndex", startIndex);
				misParamMap.put("recordTofetch", recordTofetch);
			}
			logger.info(misParamMap);
			resultList = controller.fetchReportsData(misParamMap, procName);
			resultSize = resultList.size();
			if ("MisRegsitrationReport".equals(procName) || "MisPlrLoginData".equals(procName)) {
				request.getSession().setAttribute("dataTableValue", controller.parseReportUA(resultList));
			} else if ("MisPlrLoginReport".equals(procName)) {
				for (String[] str : resultList) {
					String versionMeta = str[str.length - 1];
					String[] deviceMeta = versionMeta.split("#&%");
					if (deviceMeta.length == 3) {
						str[str.length - 1] = Utility.getDeviceType(deviceMeta);
					}
				}
				request.getSession().setAttribute("dataTableValue", resultList);
			} else {
				request.getSession().setAttribute("dataTableValue", resultList);
			}
			domaiNameSet(misParamMap);
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

	public void fetchMisReportOnClick() throws IOException {
		logger.info("--Start Player MIS transaction Reports--");
		Gson data = new GsonBuilder().create();
		Type dataType = new TypeToken<Map<String, String>>() {
		}.getType();
		misParamMap = data.fromJson(reportData, dataType);
		ReportsController controller = new ReportsController();
		try {
			if (misParamMap.containsKey("proceName")) {
				procName = misParamMap.get("proceName");
				misParamMap.remove("proceName");
			} else {
				if (misParamMap.get("deviceType") != null) {
					if ("ANDROID".equals(misParamMap.get("deviceType"))) {
						procName = "getAppsFlyerAndroidReportData";
					}
					if ("IOS".equals(misParamMap.get("deviceType"))) {
						procName = "getAppsFlyerIosReportData";
					}
				} else {
					if ("msgSend".equals(misParamMap.get("reportType"))
							|| "appDownLoad".equals(misParamMap.get("reportType"))) {
						procName = "mobileAppDownloadDetail";
					}
				}
			}
			misParamMap = controller.getMisParamMap(misParamMap, procName);
			if ("getBonusPlrDetailReport".equals(procName)) {
				misParamMap.remove("procNamegetBonusDetailReport");
				misParamMap.remove("proceName");
			} else if (procName.equals("stCmsCampPlayerRegReport") || procName.equals("stCmsCampPlayerDepReport")) {
				CmsController cmsController = new CmsController();
				if (!misParamMap.get("campId").trim().equals("0"))
					paramList = cmsController.getCampaignParams(Long.valueOf(misParamMap.get("campId").trim()));
				else {
					paramList = new ArrayList<String>();
					paramList.add("utm_source");
					paramList.add("utm_medium");
					paramList.add("utm_term");
					paramList.add("utm_content");
					paramList.add("utm_campaign");
				}

				String paramVal = "";
				for (int i = 0; i < paramList.size(); i++) {
					paramVal = paramVal + ",value" + (i + 1);
				}
				misParamMap.put("paramVal", paramVal);
			} else if (!("stCmsCampAppDownReport".equals(procName) || "StCmsReferFriendInvitedTracking".equals(procName)
					|| "StCmsReferFriendVisitedTracking".equals(procName)
					|| "stCmsReferFriendPlrRegReport".equals(procName)
					|| "stCmsReferFriendPlrDepReport".equals(procName) || "CampWiseRevenuReport".equals(procName)
					|| "campRevReferFrndPlrReport".equals(procName))) {
				misParamMap.put("startIndex", startIndex);
				if ("StCmsCampTracking".equals(procName) && misParamMap.get("campType").equals("PPC"))
					misParamMap.put("recordTofetch", String.valueOf(Integer.valueOf(recordTofetch) - 1));
				else
					misParamMap.put("recordTofetch", recordTofetch);
			}
			logger.info(misParamMap);
			if ("StCmsReferFriendInvitedTracking".equals(procName) || "StCmsReferFriendVisitedTracking".equals(procName)
					|| "stCmsReferFriendPlrRegReport".equals(procName)
					|| "stCmsReferFriendPlrDepReport".equals(procName)) {
				misParamMap.put("device", misParamMap.get("deviceType"));
				misParamMap.remove("deviceType");

			}
			if ((procName.equals("getBonusPlrDetailReport") || procName.equals("getBonusAnalysisReport")
					|| procName.equals("getPlrWithDrawalReportWithStatus") || procName.equals("CampRevenueReport")
					|| procName.equals("campRevReferFrndReport") || procName.equals("getBonusDetailReport"))
					&& !(misParamMap.containsKey("aliasId"))) {
				misParamMap.put("aliasId", "-1");
			}

			if (procName.equals("AliasWiseWagerAndWinning")) {
				if (!(misParamMap.containsKey("aliasId")))
					misParamMap.put("aliasId", "-1");
				if (!(misParamMap.containsKey("dateWise")))
					misParamMap.put("dateWise", "N");
				if (!(misParamMap.containsKey("playerWise")))
					misParamMap.put("playerWise", "N");

			}

			resultList = controller.fetchReportsData(misParamMap, procName);
			resultSize = resultList.size();
			if ("StCmsCampTracking".equals(procName) && resultSize != 0 && misParamMap.get("campType").equals("PPC")) {
				int sum_of_total_visitor = 0, sum_of_unique_visitor = 0, sum_of_total_registered = 0,
						sum_of_email_verified = 0, sum_of_total_deposited = 0, sum_of_total_download_click = 0;
				int index = 0;
				for (String[] results : resultList) {
					if (resultSize == 100 && index == 99)
						continue;
					if (!results[4].equals("--"))
						sum_of_total_visitor = sum_of_total_visitor + Integer.parseInt(results[4]);
					if (!results[5].equals("--"))
						sum_of_unique_visitor = sum_of_unique_visitor + Integer.parseInt(results[5]);
					if (!results[8].equals("--"))
						sum_of_total_registered = sum_of_total_registered + Integer.parseInt(results[8]);
					if (!results[9].equals("--"))
						sum_of_email_verified = sum_of_email_verified + Integer.parseInt(results[9]);
					if (!results[12].equals("--"))
						sum_of_total_deposited = sum_of_total_deposited + Integer.parseInt(results[12]);
					if (!results[15].equals("--"))
						sum_of_total_download_click = sum_of_total_download_click + Integer.parseInt(results[15]);
					index++;

				}
				String total[] = { "0", "0", "<b>" + "ALL" + "</b>", "<b>" + "ALL" + "</b>",
						sum_of_total_visitor > 0 ? String.valueOf(sum_of_total_visitor) : "--",
						sum_of_unique_visitor > 0 ? String.valueOf(sum_of_unique_visitor) : "--", "0", "0",
						sum_of_total_registered > 0 ? String.valueOf(sum_of_total_registered) : "--",
						sum_of_email_verified > 0 ? String.valueOf(sum_of_email_verified) : "--", "0", "0",
						sum_of_total_deposited > 0 ? String.valueOf(sum_of_total_deposited) : "--", "0", "0",
						sum_of_total_download_click > 0 ? String.valueOf(sum_of_total_download_click) : "--" };

				resultList.add(0, total);
			}
			if ("MisRegsitrationReport".equals(procName) || "MisPlrLoginData".equals(procName)
					|| "getPlrDepReportWithStatus".equals(procName)
					|| "getPlrWithDrawalReportWithStatus".endsWith(procName)) {
				request.getSession().setAttribute("dataTableValue", controller.parseReportUA(resultList));
			} else if ("MisPlrLoginReport".equals(procName)) {
				for (String[] str : resultList) {
					String versionMeta = str[str.length - 1];
					String[] deviceMeta = versionMeta.split("#&%");
					if (deviceMeta.length == 3) {
						str[str.length - 1] = Utility.getDeviceType(deviceMeta);
					}
				}
				request.getSession().setAttribute("dataTableValue", resultList);
			} else {
				if ("mobileAppDownloadDetail".equals(procName) || "stCmsCampAppDownReport".equals(procName))
					request.getSession().setAttribute("dataTableValue", controller.mobileAppParseUA(resultList));
				else
					request.getSession().setAttribute("dataTableValue", resultList);
			}

			if (resultList.size() > 0) {
				response.getWriter().write(new Utility().convertJSON(resultList));
			} else
				response.getWriter().write("{}");
			domaiNameSet(misParamMap);
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
		}
	}

	public void domaiNameSet(Map<String, String> paramMap) {
		try {
			if (!paramMap.get("domainId").equals("0"))
				domainName = CommonMethodController.getInstance()
						.getDmProperty(Short.valueOf(paramMap.get("domainId").trim()), "domainName");
			else
				domainName = "All";
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void aliasNameSet(Map<String, String> paramMap) {
		try {
			if (!paramMap.get("aliasId").equals("0"))
				aliasName = CommonMethodController.getInstance()
						.getDmAliasProperty(Short.valueOf(paramMap.get("aliasId").trim()), "aliasName");
			else
				aliasName = "All";
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void exportExcelPlrTxnRep() {
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition",
				"attachment; filename=" + reportTypeName + "_" + Calendar.getInstance().getTimeInMillis() + ".xlsx");
		try {
			ReportToExcel excel = new ReportToExcel();
			Gson data = new GsonBuilder().create();
			Type dataType = new TypeToken<Map<String, String>>() {
			}.getType();
			Map<String, String> paramMap = data.fromJson(reportData, dataType);
			if (reportTypeName.equals("zapakPlayerDepositReport")
					|| reportTypeName.equals("indiaBetPlayerWagerReport")) {
				String[] dt = (paramMap.get("month")).split("/");
				paramMap.put("fromDate", dt[1] + "-" + dt[0] + "-01 00:00:00");
				paramMap.put("toDate", dt[1] + "-" + dt[0] + "-31 23:59:59");
				paramMap.remove("month");
			}
			if (reportTypeName.equals("stCmsCampPlayerRegReport")
					|| reportTypeName.equals("stCmsCampPlayerDepReport")) {
				paramMap.put("recordTofetch", recordTofetch);
			}
			excel.plrTxnExcelReport(paramMap, reportTypeName).write(response.getOutputStream());
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void exportMISExcelPlrTxnRep() {
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition",
				"attachment; filename=" + reportTypeName + "_" + Calendar.getInstance().getTimeInMillis() + ".xlsx");
		// OutputStream out = null;
		try {
			OutputStream out = new BufferedOutputStream(response.getOutputStream());
			ReportToExcel excel = new ReportToExcel();
			if (redirect == null) {
				Gson data = new GsonBuilder().create();
				Type dataType = new TypeToken<Map<String, String>>() {
				}.getType();
				reportData = reportData.replaceAll("=", "\":\"").replaceAll(", ", "\",\"");
				reportData = "{\"" + reportData.substring(1, reportData.length() - 1) + "\"}";
				misParamMap = data.fromJson(reportData, dataType);
			}

			SXSSFWorkbook wb = excel.plrTxnExcelReport(misParamMap, reportTypeName);
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

	private void withDrawRepForDatatable(Map<String, Map<String, String[]>> map, int totalColumn, String reportName) {
		try {
			List<String[]> list = new ArrayList<String[]>();
			String[] value = null;
			for (Entry<String, Map<String, String[]>> entry : map.entrySet()) {
				int i = 0, j = 0;
				if (totalColumn > 0) {
					float totalAmt = 0.0f;
					int totalPlr = 0;
					value = new String[totalColumn];
					value[i] = entry.getKey();
					if (map.get(value[i]) != (null)) {
						if ("wDProcessedTxn".equals(reportName)) {
							i += 2;
						} else {
							j = totalColumn - 3;
						}
						for (Entry<String, String[]> innerEntry : entry.getValue().entrySet()) {
							value[++i] = innerEntry.getValue()[0];
							totalAmt += Float.parseFloat(value[i]);
							value[++i] = innerEntry.getValue()[1];
							totalPlr += Integer.parseInt(value[i]);
						}
						value[++j] = String.valueOf(totalAmt);
						value[++j] = String.valueOf(totalPlr);
					}
				}
				list.add(value);
			}
			request.getSession().setAttribute("dataTableValue", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private Map depositWithDrawReportMap(List<String[]> resultList, String procName, String[] headerArray) {
		this.headerArray = headerArray;
		setReportType(procName);
		Map<String, Map<String, String[]>> map = new LinkedHashMap<String, Map<String, String[]>>();
		Map<String, String[]> reportMap = new LinkedHashMap<String, String[]>();
		for (String status : headerArray) {
			reportMap.put(status, new String[] { "0", "0" });
		}
		String[] strArray = null;
		Map<String, String[]> provMap = null;
		for (String[] str : resultList) {
			if (map.containsKey(str[0])) {
				provMap = map.get(str[0]);
			} else {
				provMap = new LinkedHashMap<String, String[]>(reportMap);
				map.put(str[0], provMap);
			}
			strArray = new String[] { "0", "0" };
			strArray[0] = str[2];
			strArray[1] = str[3];
			provMap.put(str[1], strArray);
		}
		withDrawRepForDatatable(map, (headerArray.length * 2 + 3), "depositWithDrawReport");
		return map;
	}

	private Map depositWithDrawMixReportMap(List<String[]> resultList, String procName) {
		Map<String, Map<String, String[]>> map = new LinkedHashMap<String, Map<String, String[]>>();
		Map<String, String[]> reportMap = null;
		setReportType(procName);
		String[] strArray = null;
		for (String[] str : resultList) {
			strArray = new String[2];
			if (map.containsKey(str[0])) {
				reportMap = map.get(str[0]);
			} else {
				reportMap = new LinkedHashMap<String, String[]>();
				map.put(str[0], reportMap);
			}
			strArray[0] = str[2];
			strArray[1] = str[3];
			reportMap.put(str[1], strArray);
		}
		return map;
	}

	private Map playerWithdrawalStatusReportMap(List<String[]> resultList, String procName) {
		setReportType(procName);
		Map<String, Map<String, String[]>> map = new LinkedHashMap<String, Map<String, String[]>>();

		Map<String, String[]> reportMap = new LinkedHashMap<String, String[]>();
		headerArray = new String[] { "REDM_ACC_UNAPPROVED", "PENDING", "INITIATED", "PROCESSED", "DONE", "CANCEL_BY_BO",
				"CANCEL_BY_PLAYER", "CANCEL_ON_FALIURE" };

		for (String status : headerArray) {
			reportMap.put(status, new String[] { "0", "0" });
		}

		String[] strArray = null;
		Map<String, String[]> provMap = null;
		for (String[] str : resultList) {
			if (map.containsKey(str[0])) {
				provMap = map.get(str[0]);
			} else {
				provMap = new LinkedHashMap<String, String[]>(reportMap);
				map.put(str[0], provMap);
			}
			strArray = new String[] { "0", "0" };
			strArray[0] = str[2];
			strArray[1] = str[3];
			provMap.put(str[1], strArray);
		}
		withDrawRepForDatatable(map, (headerArray.length * 2 + 3), "WithdrawalStatusReport");
		return map;
	}

	@SuppressWarnings("rawtypes")
	private Map playerDepositReportMap(List<String[]> resultList) {
		Map<String, Map<String, String[]>> map = new LinkedHashMap<String, Map<String, String[]>>();
		Map<String, String[]> reportMap = new LinkedHashMap<String, String[]>();
		headerArray = new String[] { "INITIATED", "PENDING", "PROCESSED", "CANCELLED", "FAILED", "DONE", "CANCEL_BY_BO",
				"DONE_BY_BO" };

		for (String status : headerArray) {
			reportMap.put(status, new String[] { "0", "0", "0", "0" });
		}

		String[] strArray = null;
		Map<String, String[]> provMap = null;
		for (String[] str : resultList) {
			if (map.containsKey(str[0])) {
				provMap = map.get(str[0]);
			} else {
				provMap = new LinkedHashMap<String, String[]>(reportMap);
				map.put(str[0], provMap);
			}
			strArray = new String[] { "0", "0", "0", "0" };
			strArray[0] = str[2];
			strArray[1] = str[3];
			strArray[2] = str[4];
			strArray[3] = str[5];
			provMap.put(str[1], strArray);
		}
		plrDepRepForDatatable(map, (headerArray.length * 2 + 5));
		return map;
	}

	@SuppressWarnings("rawtypes")
	private Map plrEcoNetWeaverSaleDataMap(List<String[]> resultList) {
		Map<String, Map<String, String[]>> map = new LinkedHashMap<String, Map<String, String[]>>();
		Map<String, String[]> reportMap = new LinkedHashMap<String, String[]>();
		headerArray = new String[] { "AIRTIME_SALES", "WEAVER_SALES", "" };

		for (String status : headerArray) {
			reportMap.put(status, new String[] { "0", "0", "0", "0" });
		}

		String[] strArray = null;
		Map<String, String[]> provMap = null;
		for (String[] str : resultList) {
			if (map.containsKey(str[0])) {
				provMap = map.get(str[0]);
			} else {
				provMap = new LinkedHashMap<String, String[]>(reportMap);
				map.put(str[0], provMap);
			}
			strArray = new String[] { "0", "0", "0", "0" };
			strArray[0] = str[2];
			strArray[1] = str[3];
			strArray[2] = str[4];
			strArray[3] = str[5];
			provMap.put(str[1], strArray);
		}
		plrDepRepForDatatable(map, (headerArray.length * 2 + 5));
		return map;
	}

	@SuppressWarnings("rawtypes")
	private Map plrDepRepForDatatable(Map<String, Map<String, String[]>> map, int totalColumns) {
		float totalSuccess = 0.0f, totalReq = 0.0f;
		List<String[]> list = new ArrayList<String[]>();
		String[] value = null;
		for (Entry<String, Map<String, String[]>> entry : map.entrySet()) {
			int i = 0;
			if (totalColumns > 0) {
				float totalAmt = 0.0f, sRate = 0.0f, respRequestCount = 0.0f, respRequest = 0.0f, aTime = 0.0f;
				int totalPlr = 0;
				value = new String[totalColumns];
				value[i] = entry.getKey();
				for (Entry<String, String[]> innerEntry : entry.getValue().entrySet()) {
					value[++i] = innerEntry.getValue()[0];
					totalAmt += Float.parseFloat(value[i]);
					value[++i] = innerEntry.getValue()[1];
					respRequestCount = Integer.parseInt(value[i]);
					totalPlr += respRequestCount;
					sRate += Float.parseFloat(innerEntry.getValue()[2]);
					if (Float.parseFloat(innerEntry.getValue()[3]) > 0)
						respRequest += respRequestCount;
					aTime += Float.parseFloat(innerEntry.getValue()[3]);
				}
				value[++i] = String.valueOf(totalAmt);
				value[++i] = String.valueOf(totalPlr);
				if (totalPlr != 0) {
					value[++i] = (sRate == 0) ? "0.00" : (Utility.roundingNumber((sRate / totalPlr) * 100) + " %");
					value[++i] = (aTime == 0) ? "0.00" : (Utility.roundingNumber(aTime / respRequest));
				}
				totalSuccess += sRate;
				totalReq += totalPlr;
			}
			list.add(value);
		}
		avgTotalSucc = (totalSuccess == 0.00 ? "0.00" : Utility.roundingNumber((totalSuccess / totalReq) * 100) + " %");
		request.getSession().setAttribute("dataTableValue", list);
		return map;
	}

	private Set playerTransactionStatus(List<String[]> resultList) throws PMSException {
		Set<String> status = new HashSet<String>();
		ReportsController controller = new ReportsController();
		for (String[] str : resultList) {
			status.add(str[str.length - 3]);
		}
		try {
			request.getSession().setAttribute("dataTableValue", controller.parseReportUA(resultList));
		} catch (PMSException e) {
			e.printStackTrace();
			throw new PMSException(e.getErrorCode(), e.getErrorMessage());
		}
		return status;
	}

	private Map<String, Map<String, String[]>> wDProcessedTxnReport(List<String[]> resultList,
			Map<String, String> paramMap) {
		Map<String, Map<String, String[]>> map = new LinkedHashMap<String, Map<String, String[]>>();
		Map<String, String[]> reportMap = null;
		String[] stringArray = null;
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		try {
			int diffInDays = (int) ((new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(paramMap.get("toDate")).getTime()
					- new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(paramMap.get("fromDate")).getTime())
					/ (1000 * 60 * 60 * 24));
			for (int i = 0; i <= diffInDays; i++) {
				Calendar c = Calendar.getInstance();
				c.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(paramMap.get("toDate")));
				c.add(Calendar.DATE, -i);
				String newDate = sdf.format(c.getTime());
				map.put(newDate, null);
			}

			for (String[] str : resultList) {
				stringArray = new String[2];
				if (map.get(str[0]) != null) {
					reportMap = map.get(str[0]);
					if (reportMap.containsKey(str[1])) {
						String[] value = reportMap.get(str[1]);
						stringArray[0] = String.valueOf(Double.valueOf(value[0]) + Double.valueOf(str[2]));
						stringArray[1] = String.valueOf(Integer.valueOf(value[1]) + Integer.valueOf(str[3]));
					} else {
						String[] value = reportMap.get("All");
						stringArray[0] = String.valueOf(Double.valueOf(value[0]) + Double.valueOf(str[2]));
						stringArray[1] = String.valueOf(Integer.valueOf(value[1]) + Integer.valueOf(str[3]));
					}
				} else {
					reportMap = new LinkedHashMap<String, String[]>();
					String[] blankValue = new String[] { "0.0", "0" };
					for (int i = 0; i < 4; i++) {
						Calendar c = Calendar.getInstance();
						c.setTime(new SimpleDateFormat("dd/MM/yyyy").parse(str[0]));
						c.add(Calendar.DATE, -i);
						String newDate = sdf.format(c.getTime());
						reportMap.put(newDate, blankValue);
					}
					reportMap.put("All", blankValue);
					map.put(str[0], reportMap);
					stringArray[0] = str[2];
					stringArray[1] = str[3];
				}
				if (reportMap.containsKey(str[1])) {
					reportMap.put(str[1], stringArray);
				} else {
					reportMap.put("All", stringArray);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// System.out.println(map);
		withDrawRepForDatatable(map, 13, "wDProcessedTxn");
		return map;
	}

	public void playerPasswordChange() {
		logger.info("--Start Player Password Change --");
		ReportsController controller = new ReportsController();
		try {
			int boUserId = userInfoBean.getUserId();
			controller.playerPasswordChange(playerId, domainId, emailId, userName, boUserId);
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			// return "exception_nodecorate";
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
		}
		// return SUCCESS;
	}

	public String pgSettlementReportMenu() {
		logger.info("--pgSettlementReportMenu--");
		BOCashierController controller = new BOCashierController();
		try {
			paymentProviderMap = controller.fetchPaymentProvider();
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

	public String pgSettlementReport() {
		logger.info("--pgSettlementReport--");
		Object[] value = null;
		SimpleDateFormat sd = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		ReportsController controller = new ReportsController();
		Map<String, List<TxnSettlementReportBean>> map;
		CommonMethodController commonMethodController = CommonMethodController.getInstance();
		try {
			map = controller.fetchPgSettlementReport(providerId, fromDate, toDate);
			nativeCurrencyId = Integer.parseInt(commonMethodController.fetchSystemProperties("NATIVE_CURRENCY"));
			domainMap = commonMethodController.getDomainIdMap();
			currencyMap = commonMethodController.fetchCurrencyMasterMap();
			reportResult = map;
			if (reportResult != null) {
				List<TxnSettlementReportBean> txnReportBean = map.get("REQUEST_NOT_FOUND");
				List<Object[]> reqNotFound = new ArrayList<Object[]>();
				for (TxnSettlementReportBean txnBean : txnReportBean) {
					value = new Object[8];
					value[0] = txnBean.getRequestId();
					value[1] = txnBean.getPlayerId();
					value[2] = txnBean.getUserName();
					value[3] = domainMap.get(txnBean.getDomainId());
					value[4] = com.stpl.pms.utility.Utility.roundingNumber(txnBean.getFromAmount()) + " "
							+ currencyMap.get(txnBean.getFromCurrencyId()).getCurrCode();
					value[5] = sd.format(txnBean.getRequestTime());
					value[6] = txnBean.getReqStatus();
					value[7] = txnBean.getSettlementStatus();
					reqNotFound.add(value);
				}
				request.getSession().setAttribute("ReqNoFound", reqNotFound);

				txnReportBean = map.get("STATUS_UNMATCHED");
				List<Object[]> statusUnmatched = new ArrayList<Object[]>();
				for (TxnSettlementReportBean txnBean : txnReportBean) {
					value = new Object[11];
					value[0] = txnBean.getRequestId();
					value[1] = txnBean.getPlayerId();
					value[2] = txnBean.getUserName();
					value[3] = domainMap.get(txnBean.getDomainId());
					value[4] = com.stpl.pms.utility.Utility.roundingNumber(txnBean.getFromAmount()) + " "
							+ currencyMap.get(txnBean.getFromCurrencyId()).getCurrCode();
					value[5] = sd.format(txnBean.getRequestTime());
					value[6] = txnBean.getReqStatus();
					value[7] = txnBean.getMerchantRequestId();
					value[8] = com.stpl.pms.utility.Utility.roundingNumber(txnBean.getTransactionAmount());
					value[9] = txnBean.getTransactionDate();
					value[10] = txnBean.getPgRefNo();
					statusUnmatched.add(value);
				}
				request.getSession().setAttribute("statusUnmatched", statusUnmatched);
			}
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

	public String playerFullTxn() {
		logger.info("--playerFullTxn--");
		ReportsController controller = new ReportsController();
		try {
			plrreportBean = controller.playerFullTxn(txnPlayerId, fromLastTrans, toLastTrans);
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}

	public String playerBonusDetail() {
		logger.info("--playerBonusDetail--");
		ReportsController controller = new ReportsController();
		try {
			plrreportBean = controller.playerBonusDetail(txnPlayerId, fromBonusTrans, toBonusTrans);
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}

	public String getMisReportType() {
		logger.info("--Mis report Menu--");
		ReportsController controller = new ReportsController();
		CommonMethodController commonMethodController = CommonMethodController.getInstance();
		try {
			misReportTypeList = controller.getMisReportType(bydefaultSelectedDomain, (short) -1);
			defaultCounry = commonMethodController.fetchSystemProperties("BYDEFAULT_SELECTED_COUNTRY");
			genMisReportTypeList();
		} catch (PMSException e) {
			e.printStackTrace();
			return ERROR;
		} catch (Exception be) {
			be.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}

	private List<StRpBoMisAccountReportMaster> genMisReportTypeList() {
		List<StRpBoMisAccountReportMaster> remove = new ArrayList<StRpBoMisAccountReportMaster>();
		StRpBoMisAccountReportMaster o = null;
		for (Iterator<StRpBoMisAccountReportMaster> i = misReportTypeList.iterator(); i.hasNext();) {
			o = i.next();
			if (!(actionPrivFunctionMap.containsKey(o.getReportName()))) {
				remove.add(o);
			}
		}
		if (remove.size() != 0)
			misReportTypeList.removeAll(remove);
		return misReportTypeList;
	}

	public void getAccountReportTypeChange() {
		reportFlag = "ACCOUNT";
		getMisReportTypeOnChnage();
	}

	public void getMisReportTypeOnChnage() {
		PrintWriter out = null;
		String jsonMap = null;
		try {
			if (jsonList != null && !"".equals(jsonList)) {
				ReportsController controller = new ReportsController();
				Gson gson = new Gson();
				Map<String, List> map = new HashMap<String, List>();
				Type dataType = new TypeToken<List<String>>() {
				}.getType();
				List<String> list = gson.fromJson(jsonList, dataType);
				if (list.contains("misReportList")) {
					misReportTypeList = controller.getMisReportType(domainId, alias, reportFlag);
					genMisReportTypeList();
					map.put("misReportList", misReportTypeList);
				}
				jsonMap = gson.toJson(map);
				out = response.getWriter();
				out.write(jsonMap);
			}
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String fetchSysProperty() {
		CommonMethodController commonMethodController = CommonMethodController.getInstance();
		try {
			defaultCounry = commonMethodController.fetchSystemProperties("BYDEFAULT_SELECTED_COUNTRY");
			if (userInfoBean != null) {
				reportCurrency = Integer.parseInt("DOMAIN".equals(userInfoBean.getUserType())
						? commonMethodController.getDmProperty(userInfoBean.getDomainId(), "currencyId")
						: commonMethodController.fetchSystemProperties("NATIVE_CURRENCY"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	private void playerExcelDownload(List<Object[]> playerData) {
		logger.info("--playerExcelDownload--");
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition",
				"attachment; filename=" + "PlayerSearchReport_" + Calendar.getInstance().getTimeInMillis() + ".xlsx");
		int index = 0;
		try {
			Set<Short> aliasIdSet = new HashSet<Short>();
			Map<Short, String> aliasIdNameMap1 = new HashMap<Short, String>();
			for (Object[] objArr : playerData) {
				if (objArr[19] != null)
					aliasIdSet.add((Short) objArr[19]);
			}
			ReportsDaoImpl daoImpl = new ReportsDaoImpl();
			aliasIdNameMap1 = daoImpl.getAliasIdNameMap(aliasIdSet);

			ReportToExcel excel = new ReportToExcel();
			BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
			String[] reportHeader = { "Player Id", "Domain Id", "Name", "Email Id", "Mobile No", "User Name",
					"Profile Status", "DOB", "Gender", " Registration Date", " Practice Balance", "Refer Source Id",
					"Reg. Refer Source", "Total Balance", " Cash Balance", " Bonus Balance", "Registraion Ip",
					"Reg. Device", "Registered Alias", "Deposit Refer Source", "Poker Nickname", "Rummy Nickname",
					"Promo Mail", "Player Status", "Player 2X", "Browser", "OS", "Device", };
			String sheetName = "Player Search Report Sheet";
			String reportName = "Player Search Report Excel Sheet";
			Object[] result = null;
			List<Object[]> resultList = new ArrayList<Object[]>();
			Client client = null;
			Parser parser = new Parser();
			for (Object[] objArr : playerData) {
				index = 0;
				int length = objArr.length;
				result = new Object[length + 1];
				for (int i = 0; i < length; i++) {
					if (objArr[i] != null && i != length - 1) {
						if (i == 2) {
							if (objArr[i + 1] != null)
								result[index] = objArr[i] + " " + objArr[i + 1];
							else
								result[index] = objArr[i];
						} else if (i == 3 || i == 20)
							continue;
						else if (i == 19)
							result[18] = aliasIdNameMap1.get(objArr[19]);
						else
							result[index] = objArr[i];
					} else if (i == length - 1) {
						client = parser.parse(String.valueOf(objArr[i]));
						result[index++] = client.userAgent != null ? client.userAgent.family : "--";
						result[index++] = client.os != null ? client.os.family : "--";
						result[index] = client.device != null ? client.device.family : "--";
					} else {
						result[index] = "--";
						if (i == 3)
							continue;
					}
					++index;
				}
				resultList.add(result);
			}
			SXSSFWorkbook wb = excel.playerExcelDownload(reportHeader, resultList, sheetName, reportName);
			wb.write(out);
			out.flush();
			out.close();
			wb.dispose();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String playerSearchMenu() {
		logger.info("--Player Search Menu--");
		ReportsController controller = new ReportsController();
		CommonMethodController commonMethodController = CommonMethodController.getInstance();
		short aliasId = -1;
		try {
			Utility utility = new Utility();
			defaultCounry = commonMethodController.fetchSystemProperties("BYDEFAULT_SELECTED_COUNTRY");
			referSource = utility.convertJSON(controller.getPlayerSearchMenu(bydefaultSelectedDomain, aliasId));
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
		return SUCCESS;
	}

	public void getRSOnDomainChnage() {
		PrintWriter out = null;
		String jsonMap = null;
		try {
			if (jsonList != null && !"".equals(jsonList)) {
				Utility utility = new Utility();
				ReportsController controller = new ReportsController();
				Gson gson = new Gson();
				Map<String, String> map = new HashMap<String, String>();
				Type dataType = new TypeToken<List<String>>() {
				}.getType();
				List<String> list = gson.fromJson(jsonList, dataType);
				if (list.contains("referSourceList")) {
					referSource = utility.convertJSON(controller.getPlayerSearchMenu(domainId, alias));
					map.put("referSourceList", referSource);
				}
				jsonMap = gson.toJson(map);
				out = response.getWriter();
				out.write(jsonMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@SuppressWarnings("unchecked")
	public String dataTableResult() {
		HttpSession session = request.getSession();
		if (count == 0) {
			resultList = (List<String[]>) session.getAttribute("dataTableValue");
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

	@SuppressWarnings("unchecked")
	public String dataTableResultMis() {
		HttpSession session = request.getSession();
		if (count == 0) {
			resultList = (List<String[]>) session.getAttribute("dataTableValue");
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

	public String reportPokerSettMenu() {
		CommonMethodController controller = CommonMethodController.getInstance();
		try {
			domainMap = controller.getDomainIdMap();
		} catch (PMSException pmse) {
			pmse.printStackTrace();
			addActionError(pmse.getErrorMessage());
			return "exception";
		} catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}

		return SUCCESS;
	}

	public String pokerSettReportSearch() {
		logger.info("--pokerSettReportSearch--");
		ReportsController controller = new ReportsController();
		try {
			pokerSettlementSearchList = controller.pokerSettlementReportSearch(domainId, fromDate, toDate, providerName,
					pokerSettlstatus);
		} catch (Exception e) {
			e.printStackTrace();
			return "exception_nodecorate";
		}
		return SUCCESS;
	}

	public String plrPayCorrectionPokerSave() {
		logger.info("--plrPayCorrectionPokerSave--");
		ReportsController controller = new ReportsController();
		try {
			Gson correctionData = new GsonBuilder().create();
			Type correctionReqType = new TypeToken<HashMap<Long, PokerSettlementReportBean>>() {
			}.getType();
			Map<Long, PokerSettlementReportBean> depositReqMap = correctionData.fromJson(correctionJsonData,
					correctionReqType);
			controller.pokerPlrPaymentCorrection(domainId, userInfoBean.getUserId(), depositReqMap);
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

	public String getLastDaysSummaryData() {
		new ReportsController().getLastDaysSummaryData();
		return SUCCESS;
	}

	public void setPlrOpt(PlrSearchOptionBean plrOpt) {
		this.plrOpt = plrOpt;
	}

	public PlrSearchOptionBean getPlrOpt() {
		return plrOpt;
	}

	public void setPlrList(ArrayList plrList) {
		this.plrList = plrList;
	}

	public ArrayList getPlrList() {
		return plrList;
	}

	public String getReportData() {
		return reportData;
	}

	public void setReportData(String reportData) {
		this.reportData = reportData;
	}

	public String getProcName() {
		return procName;
	}

	public void setProcName(String procName) {
		this.procName = procName;
	}

	public List<String[]> getResultList() {
		return resultList;
	}

	public void setResultList(List<String[]> resultList) {
		this.resultList = resultList;
	}

	public void setReportResult(Map reportResult) {
		this.reportResult = reportResult;
	}

	public Map getReportResult() {
		return reportResult;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	public String getReportType() {
		return reportType;
	}

	public Set getTnxStatus() {
		return tnxStatus;
	}

	public void setTnxStatus(Set tnxStatus) {
		this.tnxStatus = tnxStatus;
	}

	public String getHeaderName() {
		return headerName;
	}

	public void setHeaderName(String headerName) {
		this.headerName = headerName;
	}

	public String getPlayerId() {
		return playerId;
	}

	public void setPlayerId(String playerId) {
		this.playerId = playerId;
	}

	public void setPlrDetailBean(PlayerDetailInfoBean plrDetailBean) {
		this.plrDetailBean = plrDetailBean;
	}

	public PlayerDetailInfoBean getPlrDetailBean() {
		return plrDetailBean;
	}

	public StPmPlayerMaster getPlrInfo() {
		return plrInfo;
	}

	public void setPlrInfo(StPmPlayerMaster plrInfo) {
		this.plrInfo = plrInfo;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public int getProviderId() {
		return providerId;
	}

	public void setProviderId(int providerId) {
		this.providerId = providerId;
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

	public void setPaymentProviderMap(Map<Integer, String> paymentProviderMap) {
		this.paymentProviderMap = paymentProviderMap;
	}

	public Map<Integer, String> getPaymentProviderMap() {
		return paymentProviderMap;
	}

	public String getReportTypeName() {
		return reportTypeName;
	}

	public void setReportTypeName(String reportTypeName) {
		this.reportTypeName = reportTypeName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public ArrayList getPlrreportBean() {
		return plrreportBean;
	}

	public void setLeftTopHeading(String leftTopHeading) {
		this.leftTopHeading = leftTopHeading;
	}

	public String getLeftTopHeading() {
		return leftTopHeading;
	}

	public void setPlrreportBean(ArrayList plrreportBean) {
		this.plrreportBean = plrreportBean;
	}

	public String getBonusName() {
		return bonusName;
	}

	public void setBonusName(String bonusName) {
		this.bonusName = bonusName;
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

	public Timestamp getFromLastTrans() {
		return fromLastTrans;
	}

	public void setFromLastTrans(Timestamp fromLastTrans) {
		this.fromLastTrans = fromLastTrans;
	}

	public Timestamp getToLastTrans() {
		return toLastTrans;
	}

	public void setToLastTrans(Timestamp toLastTrans) {
		this.toLastTrans = toLastTrans;
	}

	public String getTxnPlayerId() {
		return txnPlayerId;
	}

	public void setTxnPlayerId(String txnPlayerId) {
		this.txnPlayerId = txnPlayerId;
	}

	public void setCampType(String campType) {
		this.campType = campType;
	}

	public String getCampType() {
		return campType;
	}

	public Timestamp getFromBonusTrans() {
		return fromBonusTrans;
	}

	public void setFromBonusTrans(Timestamp fromBonusTrans) {
		this.fromBonusTrans = fromBonusTrans;
	}

	public Timestamp getToBonusTrans() {
		return toBonusTrans;
	}

	public void setToBonusTrans(Timestamp toBonusTrans) {
		this.toBonusTrans = toBonusTrans;
	}

	public List<StRpBoMisAccountReportMaster> getMisReportTypeList() {
		return misReportTypeList;
	}

	public void setMisReportTypeList(List<StRpBoMisAccountReportMaster> misReportTypeList) {
		this.misReportTypeList = misReportTypeList;
	}

	public Map<String, String> getMisParamMap() {
		return misParamMap;
	}

	public void setMisParamMap(Map<String, String> misParamMap) {
		this.misParamMap = misParamMap;
	}

	public String getMassage() {
		return massage;
	}

	public void setMassage(String massage) {
		this.massage = massage;
	}

	public String getRedirect() {
		return redirect;
	}

	public void setRedirect(String redirect) {
		this.redirect = redirect;
	}

	public void setDefaultCounry(String defaultCounry) {
		this.defaultCounry = defaultCounry;
	}

	public String getDefaultCounry() {
		return defaultCounry;
	}

	public void setNativeCurrencyId(int nativeCurrencyId) {
		this.nativeCurrencyId = nativeCurrencyId;
	}

	public int getNativeCurrencyId() {
		return nativeCurrencyId;
	}

	public void setCurrencyMap(Map<Integer, CurrencyBean> currencyMap) {
		this.currencyMap = currencyMap;
	}

	public Map<Integer, CurrencyBean> getCurrencyMap() {
		return currencyMap;
	}

	public void setParamList(List<String> paramList) {
		this.paramList = paramList;
	}

	public List<String> getParamList() {
		return paramList;
	}

	public String getReferSource() {
		return referSource;
	}

	public void setReferSource(String referSource) {
		this.referSource = referSource;
	}

	public void setReportCurrency(int reportCurrency) {
		this.reportCurrency = reportCurrency;
	}

	public int getReportCurrency() {
		return reportCurrency;
	}

	public String getOpenDeco() {
		return openDeco;
	}

	public void setOpenDeco(String openDeco) {
		this.openDeco = openDeco;
	}

	public String[] getHeaderArray() {
		return headerArray;
	}

	public void setHeaderArray(String[] headerArray) {
		this.headerArray = headerArray;
	}

	public String getAvgTotalSucc() {
		return avgTotalSucc;
	}

	public void setAvgTotalSucc(String avgTotalSucc) {
		this.avgTotalSucc = avgTotalSucc;
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

	public void setJsonList(String jsonList) {
		this.jsonList = jsonList;
	}

	public String getJsonList() {
		return jsonList;
	}

	public Map<Short, String> getAliasIdMap() {
		return aliasIdMap;
	}

	public void setAliasIdMap(Map<Short, String> aliasIdMap) {
		this.aliasIdMap = aliasIdMap;
	}

	public String getProviderName() {
		return providerName;
	}

	public void setProviderName(String providerName) {
		this.providerName = providerName;
	}

	public List<PokerSettlementReportBean> getPokerSettlementSearchList() {
		return pokerSettlementSearchList;
	}

	public void setPokerSettlementSearchList(List<PokerSettlementReportBean> pokerSettlementSearchList) {
		this.pokerSettlementSearchList = pokerSettlementSearchList;
	}

	public String getCorrectionJsonData() {
		return correctionJsonData;
	}

	public void setCorrectionJsonData(String correctionJsonData) {
		this.correctionJsonData = correctionJsonData;
	}

	public short getAlias() {
		return alias;
	}

	public void setAlias(short alias) {
		this.alias = alias;
	}

	public String getDomainId1() {
		return domainId1;
	}

	public void setDomainId1(String domainId1) {
		this.domainId1 = domainId1;
	}

	public String getToDateBonus() {
		return toDateBonus;
	}

	public void setToDateBonus(String toDateBonus) {
		this.toDateBonus = toDateBonus;
	}

	public String getFromDateBonus() {
		return fromDateBonus;
	}

	public void setFromDateBonus(String fromDateBonus) {
		this.fromDateBonus = fromDateBonus;
	}

	public String getToDateTxn() {
		return toDateTxn;
	}

	public void setToDateTxn(String toDateTxn) {
		this.toDateTxn = toDateTxn;
	}

	public String getFromDateTxn() {
		return fromDateTxn;
	}

	public void setFromDateTxn(String fromDateTxn) {
		this.fromDateTxn = fromDateTxn;
	}

	public String getPokerSettlstatus() {
		return pokerSettlstatus;
	}

	public void setPokerSettlstatus(String pokerSettlstatus) {
		this.pokerSettlstatus = pokerSettlstatus;
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

	public int getResultSize() {
		return resultSize;
	}

	public void setResultSize(int resultSize) {
		this.resultSize = resultSize;
	}

	public String getPaytmSettlstatus() {
		return paytmSettlstatus;
	}

	public void setPaytmSettlstatus(String paytmSettlstatus) {
		this.paytmSettlstatus = paytmSettlstatus;
	}

	public String getCampId() {
		return campId;
	}

	public void setCampId(String campId) {
		this.campId = campId;
	}

	public String getSubCampId() {
		return subCampId;
	}

	public void setSubCampId(String subCampId) {
		this.subCampId = subCampId;
	}

	public String getCampName() {
		return campName;
	}

	public void setCampName(String campName) {
		this.campName = campName;
	}

	public String getSubCampName() {
		return subCampName;
	}

	public void setSubCampName(String subCampName) {
		this.subCampName = subCampName;
	}

}*/