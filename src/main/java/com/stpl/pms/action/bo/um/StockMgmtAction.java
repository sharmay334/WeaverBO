package com.stpl.pms.action.bo.um;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.stpl.pms.commonJavabeans.ManufacturingBean;
import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.hibernate.factory.HibernateSessionFactory;
import com.stpl.pms.javabeans.StockCatBean;
import com.stpl.pms.javabeans.StockGroupBean;
import com.stpl.pms.javabeans.StockItemBean;
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
	private String unit_id;
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
	private List<String> goDownList;
	// unit measure variables
	private List<String> UQCList;
	private String unitType;
	private String unitSymbol;
	private String formalName;
	private String UQC;
	private String decimalPlace;
	private String hsn_sac;
	private List<String> viewunitMeasureList;
	private List<UnitBean> UnitBeanList;
	// compound unit

	private String compoundFirstUnit;
	private String compundConversion;
	private String compoundSecondUnit;

	// stock item creation

	private String stockItemName;
	private String stockUnderItem;
	private String stockItemCat;
	private String stockItemUnit;
	private String stockItemAlterUnit;
	private String funit;
	private String sunit;
	private String isbatches;
	private String dom;
	private String expDate;
	private String standRate;
	private String costTrack;
	private String isGst;
	private String alterGst;
	private String supplyType;
	private String dutyRate;

	// view unit item
	private List<String> stockItemsList;
	private String stockItemSelected;
	private List<StockItemBean> itemBean;
	private StockItemBean stockItemBean;
	private List<String> ledgerNamesList;
	// gst variables

	private String Itax;
	private String Ctax;
	private String Stax;
	private String cess;

	// stock opening balance

	private String itemGodown;
	private String itemBatch;
	private String mfg;
	private String exp;
	private String itemQty;
	private String rate;
	private String openingBalance;

	private String stockItemWholesaleUnit;
	private String fwunit;
	private String swunit;

	private ManufacturingBean manufacturingBean;

	@Override
	public String execute() throws Exception {

		return SUCCESS;
	}

	public String editUnitMeasure() {
		return SUCCESS;
	}

	public String createMaterialManufacturing() {
		GameLobbyController controller = new GameLobbyController();
		stockItemsList = controller.getAllStockItemsList();
		goDownList = controller.getAllGoDownList();
		setLedgerNamesList(controller.getLedgerNamesList());
		return SUCCESS;
	}

	public String createMaterialManufacturingResult() {
		GameLobbyController controller = new GameLobbyController();
		if (controller.createManufacturingRecord(manufacturingBean))
			return SUCCESS;
		else
			return ERROR;
	}

	public String tansferStockResult() {

		return SUCCESS;
	}

	public String createStockTransfer() {
		GameLobbyController controller = new GameLobbyController();
		stockItemsList = controller.getAllStockItemsList();
		goDownList = controller.getAllGoDownList();
		setLedgerNamesList(controller.getLedgerNamesList());

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
		goDownList = new ArrayList<>();
		goDownList = controller.getAllGoDownList();
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
		UQCList.add("LTR – LETER");
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
	

	public String createStockItemFirstStep() {
		GameLobbyController controller = new GameLobbyController();
		Session session = HibernateSessionFactory.getSession();
		Transaction transaction = session.beginTransaction();
		if (controller.itemCreationFirstStep(stockItemName, stockUnderItem, stockItemCat, stockItemUnit, isGst,
				alterGst, supplyType, dutyRate, stockItemAlterUnit, funit, sunit, isbatches, dom, expDate, standRate,
				costTrack, Itax, Ctax, Stax, cess, stockItemWholesaleUnit, fwunit, swunit, hsn_sac,session,transaction)) {
			if (controller.insert_st_rm_stock_item_godown_opening_blc(stockItemName, itemGodown, itemBatch, mfg, exp,
					itemQty, rate, openingBalance, stockItemUnit,session,transaction)) {
				transaction.commit();
				return SUCCESS;
			}
			else {
				transaction.rollback();
				return ERROR;
				
			}

		}
		else 
		{
			transaction.rollback();
			return ERROR;
		}
	}

	public String deleteStockItem() {

		GameLobbyController controller = new GameLobbyController();
		if (controller.deleteStockItem(stockItemSelected)) {
			return SUCCESS;
		}
		return ERROR;
	}

	public String viewStockItemPage() {
		stockItemsList = new ArrayList();
		GameLobbyController controller = new GameLobbyController();
		stockItemsList = controller.getAllStockItemsList();
		return SUCCESS;
	}

	public String viewStockItemPageResult() {
		GameLobbyController controller = new GameLobbyController();
		itemBean = controller.getStockItemBeanByName(stockItemSelected);
		return SUCCESS;
	}

	public String editStockItem() {
		GameLobbyController controller = new GameLobbyController();
		stockItemCatList = controller.getAllStockCatagory();
		stockItemUnitList = controller.getAllStockItem();
		viewStockGroupList = new ArrayList<String>();
		viewStockGroupList = controller.getAllStockGroup();
		stockItemBean = controller.getStockItemBeanById(unit_id);
		
		return SUCCESS;
	}

	public String editStockItemSave() {
		GameLobbyController controller = new GameLobbyController();
		if (controller.updateStockItemDetails(stockItemBean))
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

	public String getStockItemName() {
		return stockItemName;
	}

	public void setStockItemName(String stockItemName) {
		this.stockItemName = stockItemName;
	}

	public String getStockUnderItem() {
		return stockUnderItem;
	}

	public void setStockUnderItem(String stockUnderItem) {
		this.stockUnderItem = stockUnderItem;
	}

	public String getStockItemCat() {
		return stockItemCat;
	}

	public void setStockItemCat(String stockItemCat) {
		this.stockItemCat = stockItemCat;
	}

	public String getStockItemUnit() {
		return stockItemUnit;
	}

	public void setStockItemUnit(String stockItemUnit) {
		this.stockItemUnit = stockItemUnit;
	}

	public String getIsGst() {
		return isGst;
	}

	public void setIsGst(String isGst) {
		this.isGst = isGst;
	}

	public String getAlterGst() {
		return alterGst;
	}

	public void setAlterGst(String alterGst) {
		this.alterGst = alterGst;
	}

	public String getSupplyType() {
		return supplyType;
	}

	public void setSupplyType(String supplyType) {
		this.supplyType = supplyType;
	}

	public String getDutyRate() {
		return dutyRate;
	}

	public void setDutyRate(String dutyRate) {
		this.dutyRate = dutyRate;
	}

	public String getStockItemAlterUnit() {
		return stockItemAlterUnit;
	}

	public void setStockItemAlterUnit(String stockItemAlterUnit) {
		this.stockItemAlterUnit = stockItemAlterUnit;
	}

	public String getFunit() {
		return funit;
	}

	public void setFunit(String funit) {
		this.funit = funit;
	}

	public String getSunit() {
		return sunit;
	}

	public void setSunit(String sunit) {
		this.sunit = sunit;
	}

	public String getIsbatches() {
		return isbatches;
	}

	public void setIsbatches(String isbatches) {
		this.isbatches = isbatches;
	}

	public String getDom() {
		return dom;
	}

	public void setDom(String dom) {
		this.dom = dom;
	}

	public String getExpDate() {
		return expDate;
	}

	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}

	public String getStandRate() {
		return standRate;
	}

	public void setStandRate(String standRate) {
		this.standRate = standRate;
	}

	public String getCostTrack() {
		return costTrack;
	}

	public void setCostTrack(String costTrack) {
		this.costTrack = costTrack;
	}

	public List<String> getStockItemsList() {
		return stockItemsList;
	}

	public void setStockItemsList(List<String> stockItemsList) {
		this.stockItemsList = stockItemsList;
	}

	public String getStockItemSelected() {
		return stockItemSelected;
	}

	public void setStockItemSelected(String stockItemSelected) {
		this.stockItemSelected = stockItemSelected;
	}

	public List<StockItemBean> getItemBean() {
		return itemBean;
	}

	public void setItemBean(List<StockItemBean> itemBean) {
		this.itemBean = itemBean;
	}

	public String getItax() {
		return Itax;
	}

	public void setItax(String itax) {
		Itax = itax;
	}

	public String getCtax() {
		return Ctax;
	}

	public void setCtax(String ctax) {
		Ctax = ctax;
	}

	public String getStax() {
		return Stax;
	}

	public void setStax(String stax) {
		Stax = stax;
	}

	public String getCess() {
		return cess;
	}

	public void setCess(String cess) {
		this.cess = cess;
	}

	public List<String> getGoDownList() {
		return goDownList;
	}

	public void setGoDownList(List<String> goDownList) {
		this.goDownList = goDownList;
	}

	public String getItemGodown() {
		return itemGodown;
	}

	public void setItemGodown(String itemGodown) {
		this.itemGodown = itemGodown;
	}

	public String getItemBatch() {
		return itemBatch;
	}

	public void setItemBatch(String itemBatch) {
		this.itemBatch = itemBatch;
	}

	public String getMfg() {
		return mfg;
	}

	public void setMfg(String mfg) {
		this.mfg = mfg;
	}

	public String getExp() {
		return exp;
	}

	public void setExp(String exp) {
		this.exp = exp;
	}

	public String getItemQty() {
		return itemQty;
	}

	public void setItemQty(String itemQty) {
		this.itemQty = itemQty;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getOpeningBalance() {
		return openingBalance;
	}

	public void setOpeningBalance(String openingBalance) {
		this.openingBalance = openingBalance;
	}

	public String getUnit_id() {
		return unit_id;
	}

	public void setUnit_id(String unit_id) {
		this.unit_id = unit_id;
	}

	public StockItemBean getStockItemBean() {
		return stockItemBean;
	}

	public void setStockItemBean(StockItemBean stockItemBean) {
		this.stockItemBean = stockItemBean;
	}

	public String getStockItemWholesaleUnit() {
		return stockItemWholesaleUnit;
	}

	public void setStockItemWholesaleUnit(String stockItemWholesaleUnit) {
		this.stockItemWholesaleUnit = stockItemWholesaleUnit;
	}

	public String getFwunit() {
		return fwunit;
	}

	public void setFwunit(String fwunit) {
		this.fwunit = fwunit;
	}

	public String getSwunit() {
		return swunit;
	}

	public void setSwunit(String swunit) {
		this.swunit = swunit;
	}

	public String getHsn_sac() {
		return hsn_sac;
	}

	public void setHsn_sac(String hsn_sac) {
		this.hsn_sac = hsn_sac;
	}

	public List<String> getLedgerNamesList() {
		return ledgerNamesList;
	}

	public void setLedgerNamesList(List<String> ledgerNamesList) {
		this.ledgerNamesList = ledgerNamesList;
	}

	public ManufacturingBean getManufacturingBean() {
		return manufacturingBean;
	}

	public void setManufacturingBean(ManufacturingBean manufacturingBean) {
		this.manufacturingBean = manufacturingBean;
	}

}
