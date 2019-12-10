package com.stpl.pms.action.bo.loyalty;

//import java.io.IOException;
//import java.io.PrintWriter;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import com.google.gson.Gson;
//import com.stpl.gateway.toloyalty.GatewayToLoyalty;
//import com.stpl.loyalty.common.LoyaltyConst;
//import com.stpl.loyalty.common.Util;
//import com.stpl.loyalty.datamodel.CashReport;
//import com.stpl.loyalty.datamodel.GraceForm;
//import com.stpl.loyalty.datamodel.LedgerSearchForm;
//import com.stpl.loyalty.datamodel.LedgerSearchResponse;
//import com.stpl.loyalty.datamodel.LoyalPlayerMaster;
//import com.stpl.loyalty.datamodel.LoyaltyLedger;
//import com.stpl.loyalty.datamodel.LoyaltyTier;
//import com.stpl.loyalty.datamodel.MigPlayerTierHistory;
//import com.stpl.loyalty.datamodel.MigrationSummaryRequest;
//import com.stpl.loyalty.datamodel.MigrationSummaryResponse;
//import com.stpl.loyalty.datamodel.PlayerOverview;
//import com.stpl.loyalty.datamodel.PlayerSearchForm;
//import com.stpl.loyalty.datamodel.PointAddForm;
//import com.stpl.loyalty.enquiry.Exposure.Report;
//import com.stpl.loyalty.exception.LPException;
//import com.stpl.pms.controller.reports.exportExcel.ReportToExcel;
import com.stpl.pms.struts.common.BaseActionSupport;

public class LoyaltyBOAction extends BaseActionSupport {
}
/*
	private List<LoyaltyLedger> ledgerSearchList = new ArrayList<LoyaltyLedger>();
	private LedgerSearchForm ledgerSearchForm = new LedgerSearchForm(); 
	private PlayerSearchForm playerSearchForm = new PlayerSearchForm();
	private PointAddForm pointAddForm = new PointAddForm();
	private GraceForm graceForm = new GraceForm();
	private PlayerOverview playerOverview;
	private CashReport cashReport;
	private LoyaltyTier currentTier;
	private LoyaltyTier previousTier; 
	private LoyaltyTier nextTier;
	private Boolean floorTier;
	private Boolean topTier;
	private Boolean render = true;
	private String errorMessage;
	private MigrationSummaryRequest migrationSummaryRequest;
	private MigrationSummaryResponse migrationSummaryResponse;
	private Long sourceTier;
	private Long destTier;

	public String completeOverview() {
		return SUCCESS;
	}

	public String loyaltyLedger() {
		return SUCCESS;
	}

	public String loyaltyLedgerSearch() {
		try {
			LedgerSearchResponse ledgerSearchRespose = GatewayToLoyalty.getInstance().getLedgerList(ledgerSearchForm,0,1000);
			this.ledgerSearchList = ledgerSearchRespose.getList();
			request.getSession().setAttribute("form", ledgerSearchForm);
		} catch (LPException e) {
			e.printStackTrace();
			if(e.getResultcode() == LoyaltyConst.ResultType.PROGRAM_OFF){
				systemDown();
			}
			return ERROR;
		}catch (Exception be) {
			be.printStackTrace();
			addActionError("Some Internal Error!");
			return ERROR;
		}
		return SUCCESS;
	}

	public String loyaltyLedgerAjaxResultPage() {
		//		this.ledgerSearchForm = (LedgerSearchForm) request.getSession().getAttribute("form");
		System.out.println(ledgerSearchForm);
		return SUCCESS;
	}
	public void loyaltyLedgerSearchAjax() {
		Map<String, Object> data = new HashMap<String, Object>();
		PrintWriter out = null;
		Gson gson = new Gson();
		try {
			//			this.ledgerSearchForm = (LedgerSearchForm) request.getSession().getAttribute("form");
			//			request.getSession().getAttribute("")
			int start = Integer.parseInt(request.getParameter("start"));
			int limit = Integer.parseInt(request.getParameter("length"));
			String searchStr = request.getParameter("search[value]");
			//get the sort order
			Integer orderColumnIndex = Integer.parseInt(request.getParameter("order[0][column]"));
			String orderDir = request.getParameter("order[0][dir]");
			String orderColumn = request.getParameter("columns["+orderColumnIndex+"][name]");

			LedgerSearchResponse ledgerSearchRespose = GatewayToLoyalty.getInstance().getLedgerList(ledgerSearchForm,start,limit,orderColumn,orderDir,searchStr);


			this.ledgerSearchList = ledgerSearchRespose.getList();
			data.put("result", 0);
			data.put( "recordsTotal",ledgerSearchRespose.getTotalSize());
			data.put( "recordsFiltered",ledgerSearchRespose.getTotalSize());
			data.put("data",this.ledgerSearchList);
			out = response.getWriter();
		} catch (LPException e) {
			e.printStackTrace();
			if(e.getResultcode() == LoyaltyConst.ResultType.PROGRAM_OFF){
				systemDown();
			}
			//			return ERROR;
		} catch (IOException e) {
			e.printStackTrace();
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
		}
		out.write(gson.toJson(data));
		//		return SUCCESS;
	}

	public String loyaltyPlayerDetail() {
		return SUCCESS;
	}

	public String playerSearch() {

		try {
			if(playerSearchForm.getMasterId()!=null || playerSearchForm.getPlayerId()!=null) {
				LoyalPlayerMaster master = GatewayToLoyalty.getInstance().getPlayerDetail(playerSearchForm);
				playerSearchForm.setPlayerId(master.getPlayerId());
			}
			playerOverview = GatewayToLoyalty.getInstance().getLoyaltyWalletOverview(playerSearchForm.getPlayerId(),"deep");
			cashReport = GatewayToLoyalty.getInstance().showCash(playerSearchForm.getPlayerId());

			if(playerOverview!=null && playerOverview.getPlayer()!=null) {
				topTier=floorTier=true;
				currentTier = playerOverview.getPlayer().getTier();
				if(playerOverview.getMap().containsKey("next_tier")) {
					topTier = false;
					nextTier = (LoyaltyTier) playerOverview.getMap().get("next_tier");
				}

				if(playerOverview.getMap().containsKey("previous_tier")) {
					floorTier = false;
					previousTier = (LoyaltyTier) playerOverview.getMap().get("previous_tier");
				}
			}
			setRender(true);
			return SUCCESS;
		} catch (LPException e) {
			e.getMessage();
			if(e.getResultcode() == LoyaltyConst.ResultType.PROGRAM_OFF){
				systemDown();
			}
			return ERROR;
		}catch (Exception be) {
			be.printStackTrace();
			addActionError("Some Internal Error!");
			return ERROR;
		}
	}


	public void addPoints() {
		Map<String, Object> data = new HashMap<String, Object>();

		PrintWriter out = null;
		Gson gson = new Gson();
		try {
			GatewayToLoyalty.getInstance().addPointsByLoyaltyID(pointAddForm.getPlayerMasterId(), pointAddForm.getValue());
			data.put("result", 0);
			data.put("master_id",pointAddForm.getPlayerMasterId());
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
			data.put("result", 400);
		}catch (Exception e) {
			data.put("result", 400);
		}
		out.write(gson.toJson(data));
	}

	public void giveGrace() {
		Map<String, Object> data = new HashMap<String, Object>();

		PrintWriter out = null;
		Gson gson = new Gson();

		try {
			GatewayToLoyalty.getInstance().addGrace(graceForm);
			data.put("result", 0);
			//			data.put("player_id",playerOverview.getPlayer().getPlayerId());
			out = response.getWriter();
		} catch (Exception e) {
			e.printStackTrace();
			data.put("result", 400);
		}
		out.write(gson.toJson(data));
	}

	public void tierStats() {
		Map<String, Object> data = new HashMap<String, Object>();

		PrintWriter out = null;
		Gson gson = new Gson();

		try {

			List<Object> list = GatewayToLoyalty.getInstance().tierStat(); 
			data.put("list",list);
			data.put("result", 0);
			out = response.getWriter();
		} catch (LPException e) {
			e.printStackTrace();
			data.put("result", 400);
			if(e.getResultcode() == LoyaltyConst.ResultType.PROGRAM_OFF){
				systemDown();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}catch (Exception be) {
			be.printStackTrace();
		}
		out.write(gson.toJson(data));
	}

	public void exposure() {
		Map<String, Object> data = new HashMap<String, Object>();

		PrintWriter out = null;
		Gson gson = new Gson();

		try {
			Map<String, Report> report = GatewayToLoyalty.getInstance().exposure(); 
			data.put("report",report);
			data.put("result", 0);
			out = response.getWriter();
		} catch (LPException e) {
			e.printStackTrace();
			data.put("result", 400);
			if(e.getResultcode() == LoyaltyConst.ResultType.PROGRAM_OFF){
				systemDown();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}catch (Exception be) {
			be.printStackTrace();
		}
		out.write(gson.toJson(data));

	}

	public String migrationSummary() {
		try {
			if(migrationSummaryRequest.getToDate().after(migrationSummaryRequest.getFromDate()))
				this.setMigrationSummaryResponse(GatewayToLoyalty.getInstance().getMigrationSummary(migrationSummaryRequest));
		} catch (LPException e) {
			e.printStackTrace();
			addActionError(e.getMessage());
			return "exception_nodecorate";
		}
		return SUCCESS;
	}

	public void exportExcelMigrationRep() {
		response.setContentType("application/vnd.ms-excel");
		String reportTypeName="MigrationReport";
		//		response.setHeader("Content-Disposition", "attachment; filename="
		//				+ reportTypeName + "_" + Calendar.getInstance().getTimeInMillis() + ".xlsx");
		response.setHeader("Content-Disposition", "attachment; filename="
				+ reportTypeName + "_" + this.getFromDate()+" till "+this.getToDate() + ".xlsx");
		try {
			ReportToExcel excel = new ReportToExcel();
			this.setMigrationSummaryResponse(GatewayToLoyalty.getInstance().getMigrationSummary(migrationSummaryRequest));
			List<LoyalPlayerMaster> plrList=GatewayToLoyalty.getInstance().getMigPlayersDetail(migrationSummaryResponse.getLoyaltyIds(sourceTier, destTier));
			Map<Long,MigPlayerTierHistory> playerTierHistories = migrationSummaryResponse.getMigPlayerTierHistories(sourceTier, destTier);
			List<Object[]> data=new ArrayList<>();
			
			for(LoyalPlayerMaster plrMaster: plrList) {
				MigPlayerTierHistory history = playerTierHistories.get(plrMaster.getId());
				data.add(new Object[]{plrMaster.getPlayerId(),plrMaster.getUsername(),Util.getTierName(history.getSourceTier()),Util.getTierName(history.getDestTier())});
			
			}
			excel.playerExcelDownload(new String[]{"playerId","user_name","source tier","destination tier"}, data, "migrationReportSheet", "MigrationReport").write(
					response.getOutputStream());
			this.setMigrationSummaryResponse(GatewayToLoyalty.getInstance().getMigrationSummary(migrationSummaryRequest));
		} catch (IOException e) {
			e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getToDate(){
		return new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(migrationSummaryRequest.getToDate());
	}

	public String getFromDate(){
		return new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(migrationSummaryRequest.getFromDate());
	}

	public String getExcelBaseLink(){
		return "com/stpl/pms/action/bo/loyalty/bo_migrationExcel.action?migrationSummaryRequest.toDate="+getToDate()+"&migrationSummaryRequest.fromDate="+getFromDate();
	}
	public List<LoyaltyLedger> getLedgerSearchList() {
		return ledgerSearchList;
	}

	public void setLedgerSearchList(List<LoyaltyLedger> ledgerSearchList) {
		this.ledgerSearchList = ledgerSearchList;
	}

	public LedgerSearchForm getLedgerSearchForm() {
		return ledgerSearchForm;
	}

	public void setLedgerSearchForm(LedgerSearchForm ledgerSearchForm) {
		this.ledgerSearchForm = ledgerSearchForm;
	}

	public PlayerSearchForm getPlayerSearchForm() {
		return playerSearchForm;
	}

	public void setPlayerSearchForm(PlayerSearchForm playerSearchForm) {
		this.playerSearchForm = playerSearchForm;
	}

	public PlayerOverview getPlayerOverview() {
		return playerOverview;
	}

	public void setPlayerOverview(PlayerOverview playerOverview) {
		this.playerOverview = playerOverview;
	}

	public CashReport getCashReport() {
		return cashReport;
	}

	public void setCashReport(CashReport cashReport) {
		this.cashReport = cashReport;
	}
	public LoyaltyTier getCurrentTier() {
		return currentTier;
	}

	public void setCurrentTier(LoyaltyTier currentTier) {
		this.currentTier = currentTier;
	}

	public LoyaltyTier getPreviousTier() {
		return previousTier;
	}

	public void setPreviousTier(LoyaltyTier previousTier) {
		this.previousTier = previousTier;
	}

	public LoyaltyTier getNextTier() {
		return nextTier;
	}

	public void setNextTier(LoyaltyTier nextTier) {
		this.nextTier = nextTier;
	}

	public Boolean getFloorTier() {
		return floorTier;
	}

	public void setFloorTier(Boolean floorTier) {
		this.floorTier = floorTier;
	}

	public Boolean getTopTier() {
		return topTier;
	}

	public void setTopTier(Boolean topTier) {
		this.topTier = topTier;
	}

	public PointAddForm getPointAddForm() {
		return pointAddForm;
	}

	public void setPointAddForm(PointAddForm pointAddForm) {
		this.pointAddForm = pointAddForm;
	}

	public Boolean getRender() {
		return render;
	}

	public void setRender(Boolean render) {
		this.render = render;
	}	

	public void systemDown() {
		setRender(false);
		setErrorMessage("Loyalty system Error : Loyalty system is disabled. Please contact admin");
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}

	public GraceForm getGraceForm() {
		return graceForm;
	}

	public void setGraceForm(GraceForm graceForm) {
		this.graceForm = graceForm;
	}

	public MigrationSummaryResponse getMigrationSummaryResponse() {
		return migrationSummaryResponse;
	}

	public void setMigrationSummaryResponse(MigrationSummaryResponse migrationSummaryResponse) {
		this.migrationSummaryResponse = migrationSummaryResponse;
	}

	public MigrationSummaryRequest getMigrationSummaryRequest() {
		return migrationSummaryRequest;
	}

	public void setMigrationSummaryRequest(MigrationSummaryRequest migrationSummaryRequest) {
		this.migrationSummaryRequest = migrationSummaryRequest;
	}

	public Long getSourceTier() {
		return sourceTier;
	}

	public void setSourceTier(Long sourceTier) {
		this.sourceTier = sourceTier;
	}

	public Long getDestTier() {
		return destTier;
	}

	public void setDestTier(Long destTier) {
		this.destTier = destTier;
	}
}
*/