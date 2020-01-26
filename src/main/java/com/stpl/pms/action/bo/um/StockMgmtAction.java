package com.stpl.pms.action.bo.um;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.javabeans.StockCatBean;
import com.stpl.pms.javabeans.StockGroupBean;
import com.stpl.pms.javabeans.UnitBean;
import com.stpl.pms.struts.common.BaseActionSupport;

public class StockMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private String stockName;
	private String stockUnder;
	private String quantityCheck;
	private String gstDetailCheck;
	private List<String> viewStockGroupList;
	private List<StockGroupBean> stockBeanList;
	private StockGroupBean stockBean;
	private int st_gp_id;
	private List<String> stockCatagoryList;
	private List<String> viewStockCatagoryList;
	private String stockCatName;
	private String stockUnderCatagory;
	private String stockCatagoryName;
	private List<StockCatBean> stockCatagoryBeanList;
	private StockCatBean stockCatagoryBean;
	private int st_ct_id;
	private List<String> stockItemCatList;
	private List<String> stockItemUnitList;
	// unit measure variables
	private List<String> UQCList;
	private String unitType;
	private String unitSymbol;
	private String formalName;
	private String UQC;
	private String decimalPlace;
	private List<String> viewunitMeasureList;
	private List<UnitBean> UnitBeanList;
	// compound unit

	private String compoundFirstUnit;
	private String compundConversion;
	private String compoundSecondUnit;

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub

		return SUCCESS;
	}

	public String editStockCatagory() {
		GameLobbyController controller = new GameLobbyController();
		stockCatagoryBean = controller.getStockCategoryBean(st_ct_id);
		return SUCCESS;
	}

	public String deleteStockCatagory() {
		GameLobbyController controller = new GameLobbyController();
		if (controller.deleteStockCatagory(stockCatagoryName))
			return SUCCESS;
		else
			return ERROR;
	}

	public String viewStockCatagoryResult() {
		GameLobbyController controller = new GameLobbyController();
		stockCatagoryBeanList = controller.getStockCatagoryDetails(stockCatagoryName);
		if (stockCatagoryBeanList != null)
			return SUCCESS;
		else
			return ERROR;
	}

	public String getAvailableStockGroup() {
		stockCatagoryList = new ArrayList<>();
		GameLobbyController controller = new GameLobbyController();
		stockCatagoryList.add("Primary");
		stockCatagoryList.addAll(controller.getAllStockGroup());
		return SUCCESS;
	}

	public String deleteStock() {
		GameLobbyController controller = new GameLobbyController();
		if (controller.deleteStockByName(stockName))
			return SUCCESS;
		else
			return ERROR;
	}

	public String editStockSave() {
		GameLobbyController controller = new GameLobbyController();
		if (controller.updateStockGroup(stockBean))
			return SUCCESS;
		else
			return SUCCESS;
	}

	public String editStockGroupResult() {
		GameLobbyController controller = new GameLobbyController();
		stockBean = controller.getStockBean(st_gp_id);
		return SUCCESS;
	}

	public String viewStockGroupResult() {
		GameLobbyController controller = new GameLobbyController();
		stockBeanList = controller.getStockGrpBeanList();
		if (stockBeanList != null)
			return SUCCESS;
		else
			return ERROR;
	}

	public String createStockGroup() {
		GameLobbyController controller = new GameLobbyController();
		if (controller.createNewStockGroup(stockName, stockUnder, quantityCheck, gstDetailCheck)) {
			return SUCCESS;
		}
		return ERROR;
	}

	public String viewStockGroup() {
		GameLobbyController controller = new GameLobbyController();
		viewStockGroupList = new ArrayList<String>();
		viewStockGroupList = controller.getAllStockGroup();
		return SUCCESS;
	}

	public String createStockCatagory() {
		GameLobbyController controller = new GameLobbyController();
		if (controller.createNewStockCatagory(stockCatName, stockUnderCatagory))
			return SUCCESS;
		else
			return ERROR;
	}

	public String viewStockCatagory() {
		GameLobbyController controller = new GameLobbyController();
		viewStockCatagoryList = new ArrayList<String>();
		viewStockCatagoryList = controller.getStockCatagoryNames();
		return SUCCESS;
	}

	public String viewCreateStockItemPage() {
		GameLobbyController controller = new GameLobbyController();
		stockItemCatList = controller.getAllStockCatagory();
		stockItemUnitList = controller.getAllStockItem();
		viewStockGroupList = new ArrayList<String>();
		viewStockGroupList = controller.getAllStockGroup();
		return SUCCESS;
	}

	public String viewUnitPage() {
		UQCList = new ArrayList();
		UQCList.add("Not Applicable");
		UQCList.add("BAG –BASS");
		UQCList.add("BAL- BALE");
		UQCList.add("BDL- BUNDLES ");
		UQCList.add("BKL- BUCKLES");
		UQCList.add("BOU- BILLION OF UNIT");
		UQCList.add("BOX – BOX");
		UQCList.add("BTL – BOTTLES");
		UQCList.add("BUN – BUNCHES");
		UQCList.add("CAN- CANS");
		UQCList.add("CBM – CUBIC METERS");
		UQCList.add("CCM – CUBIC CENTIMETERS");
		UQCList.add("CMS – CENTIMETERS");
		UQCList.add("CTN – CARTONS");
		UQCList.add("DOZ – DOZENS");
		UQCList.add("DRM – DRUMS");
		UQCList.add("GGK – GREAT GROSS ");
		UQCList.add("GMS – GRAMMES");
		UQCList.add("GRS- GROSS");
		UQCList.add("GYD- GROSS YARDS");
		UQCList.add("KGS – KILOGRAMS");
		UQCList.add("KLS – KILOLITRE");
		UQCList.add("KME – KILOMITRE");
		UQCList.add("MLT – MILILITRE");
		UQCList.add("MTR – METERS");
		UQCList.add("MTS – METRIC TON");
		UQCList.add("NOS – NUMBERS");
		UQCList.add("OTH – OTHERS");
		UQCList.add("PAC – PACKS");
		UQCList.add("PCS – PIECES");
		UQCList.add("PRS – PAIRS");
		UQCList.add("QTL – QUINTAL");
		UQCList.add("ROL – ROLLS");
		UQCList.add("SET – SETS");
		UQCList.add("SQF – SQUARE FEET");
		UQCList.add("SQM – SQUARE METERS");
		UQCList.add("SQY – SQUARE YARDS");
		UQCList.add("TBS – TABLETS");
		UQCList.add("TGM – TEN GROSS");
		UQCList.add("THD – THOUSANDS");
		UQCList.add("TON – TONNES");
		UQCList.add("TUB – TUBES");
		UQCList.add("UGS – US GALLONS");
		UQCList.add("UNT – UNITS");
		UQCList.add("YDS – YARDS ");
		viewunitMeasureList = new ArrayList<>();
		GameLobbyController controller = new GameLobbyController();
		viewunitMeasureList = controller.getUnitMeasureList();

		return SUCCESS;
	}

	public String viewUnitMeasure() {
		viewunitMeasureList = new ArrayList<>();
		GameLobbyController controller = new GameLobbyController();
		viewunitMeasureList = controller.getUnitMeasureList();
		return SUCCESS;
	}

	public String viewUnitMeasureResult() {
		GameLobbyController controller = new GameLobbyController();
		UnitBeanList = controller.getUnitMeasureBeanByName(unitSymbol);
		return SUCCESS;
	}

	public String createUnitPage() {
		GameLobbyController controller = new GameLobbyController();
		if (controller.createNewUnit(unitType, unitSymbol, formalName, UQC, decimalPlace, compoundFirstUnit,
				compundConversion, compoundSecondUnit))
			return SUCCESS;
		return ERROR;
	}

	public String deleteUnitMeasure() {
		GameLobbyController controller = new GameLobbyController();
		if (controller.deleteUnitMeasure(unitSymbol))
			return SUCCESS;
		else
			return ERROR;
	}

	public HttpServletRequest getServletRequest() {
		return servletRequest;
	}

	public void setServletRequest(HttpServletRequest servletRequest) {
		this.servletRequest = servletRequest;
	}

	public HttpServletResponse getServletResponse() {
		return servletResponse;
	}

	public void setServletResponse(HttpServletResponse servletResponse) {
		this.servletResponse = servletResponse;
	}

	public String getStockName() {
		return stockName;
	}

	public void setStockName(String stockName) {
		this.stockName = stockName;
	}

	public String getStockUnder() {
		return stockUnder;
	}

	public void setStockUnder(String stockUnder) {
		this.stockUnder = stockUnder;
	}

	public String getQuantityCheck() {
		return quantityCheck;
	}

	public void setQuantityCheck(String quantityCheck) {
		this.quantityCheck = quantityCheck;
	}

	public String getGstDetailCheck() {
		return gstDetailCheck;
	}

	public void setGstDetailCheck(String gstDetailCheck) {
		this.gstDetailCheck = gstDetailCheck;
	}

	public List<String> getViewStockGroupList() {
		return viewStockGroupList;
	}

	public void setViewStockGroupList(List<String> viewStockGroupList) {
		this.viewStockGroupList = viewStockGroupList;
	}

	public List<StockGroupBean> getStockBeanList() {
		return stockBeanList;
	}

	public void setStockBeanList(List<StockGroupBean> stockBeanList) {
		this.stockBeanList = stockBeanList;
	}

	public StockGroupBean getStockBean() {
		return stockBean;
	}

	public void setStockBean(StockGroupBean stockBean) {
		this.stockBean = stockBean;
	}

	public int getSt_gp_id() {
		return st_gp_id;
	}

	public void setSt_gp_id(int st_gp_id) {
		this.st_gp_id = st_gp_id;
	}

	public List<String> getStockCatagoryList() {
		return stockCatagoryList;
	}

	public void setStockCatagoryList(List<String> stockCatagoryList) {
		this.stockCatagoryList = stockCatagoryList;
	}

	public List<String> getViewStockCatagoryList() {
		return viewStockCatagoryList;
	}

	public void setViewStockCatagoryList(List<String> viewStockCatagoryList) {
		this.viewStockCatagoryList = viewStockCatagoryList;
	}

	public String getStockCatName() {
		return stockCatName;
	}

	public void setStockCatName(String stockCatName) {
		this.stockCatName = stockCatName;
	}

	public String getStockUnderCatagory() {
		return stockUnderCatagory;
	}

	public void setStockUnderCatagory(String stockUnderCatagory) {
		this.stockUnderCatagory = stockUnderCatagory;
	}

	public String getStockCatagoryName() {
		return stockCatagoryName;
	}

	public void setStockCatagoryName(String stockCatagoryName) {
		this.stockCatagoryName = stockCatagoryName;
	}

	public List<StockCatBean> getStockCatagoryBeanList() {
		return stockCatagoryBeanList;
	}

	public void setStockCatagoryBeanList(List<StockCatBean> stockCatagoryBeanList) {
		this.stockCatagoryBeanList = stockCatagoryBeanList;
	}

	public StockCatBean getStockCatagoryBean() {
		return stockCatagoryBean;
	}

	public void setStockCatagoryBean(StockCatBean stockCatagoryBean) {
		this.stockCatagoryBean = stockCatagoryBean;
	}

	public int getSt_ct_id() {
		return st_ct_id;
	}

	public void setSt_ct_id(int st_ct_id) {
		this.st_ct_id = st_ct_id;
	}

	public List<String> getStockItemCatList() {
		return stockItemCatList;
	}

	public void setStockItemCatList(List<String> stockItemCatList) {
		this.stockItemCatList = stockItemCatList;
	}

	public List<String> getStockItemUnitList() {
		return stockItemUnitList;
	}

	public void setStockItemUnitList(List<String> stockItemUnitList) {
		this.stockItemUnitList = stockItemUnitList;
	}

	public List<String> getUQCList() {
		return UQCList;
	}

	public void setUQCList(List<String> uQCList) {
		UQCList = uQCList;
	}

	public String getUnitType() {
		return unitType;
	}

	public void setUnitType(String unitType) {
		this.unitType = unitType;
	}

	public String getUnitSymbol() {
		return unitSymbol;
	}

	public void setUnitSymbol(String unitSymbol) {
		this.unitSymbol = unitSymbol;
	}

	public String getFormalName() {
		return formalName;
	}

	public void setFormalName(String formalName) {
		this.formalName = formalName;
	}

	public String getUQC() {
		return UQC;
	}

	public void setUQC(String uQC) {
		UQC = uQC;
	}

	public String getDecimalPlace() {
		return decimalPlace;
	}

	public void setDecimalPlace(String decimalPlace) {
		this.decimalPlace = decimalPlace;
	}

	public List<String> getViewunitMeasureList() {
		return viewunitMeasureList;
	}

	public void setViewunitMeasureList(List<String> viewunitMeasureList) {
		this.viewunitMeasureList = viewunitMeasureList;
	}

	public List<UnitBean> getUnitBeanList() {
		return UnitBeanList;
	}

	public void setUnitBeanList(List<UnitBean> unitBeanList) {
		UnitBeanList = unitBeanList;
	}

	public String getCompoundFirstUnit() {
		return compoundFirstUnit;
	}

	public void setCompoundFirstUnit(String compoundFirstUnit) {
		this.compoundFirstUnit = compoundFirstUnit;
	}

	public String getCompundConversion() {
		return compundConversion;
	}

	public void setCompundConversion(String compundConversion) {
		this.compundConversion = compundConversion;
	}

	public String getCompoundSecondUnit() {
		return compoundSecondUnit;
	}

	public void setCompoundSecondUnit(String compoundSecondUnit) {
		this.compoundSecondUnit = compoundSecondUnit;
	}

}
