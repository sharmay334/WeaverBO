package com.stpl.pms.action.bo.reports;

/*
import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.GradientPaint;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Paint;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

import org.apache.log4j.Logger;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartRenderingInfo;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.entity.StandardEntityCollection;
import org.jfree.chart.labels.ItemLabelAnchor;
import org.jfree.chart.labels.ItemLabelPosition;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.renderer.category.StackedBarRenderer;
import org.jfree.chart.renderer.category.StandardBarPainter;
import org.jfree.chart.renderer.xy.XYItemRenderer;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.time.Day;
import org.jfree.data.time.Hour;
import org.jfree.data.time.TimeSeries;
import org.jfree.data.time.TimeSeriesCollection;
import org.jfree.ui.RectangleInsets;
import org.jfree.ui.TextAnchor;

import com.google.gson.Gson;
import com.stpl.pms.controller.commonMethods.CommonMethodController;
import com.stpl.pms.controller.reports.ReportsController;
import com.stpl.pms.exception.PMSErrorMessage;
import com.stpl.pms.exception.PMSException;

import com.stpl.pms.utility.Utility;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

*/
import com.stpl.pms.struts.common.BaseActionSupport;
public class ReportChart extends BaseActionSupport{
}
	/*
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger.getLogger(ReportChart.class);
	private Map<String, String> paramMap = new HashMap<String, String>() ;
	private String contentPath;
	private String chartName;
	private Short graphDomainId;
	private String selectDomainName;
	private List<String> graphList;
	private List<String> gameList;
	private String vendorCode;
    static class CustomBarRenderer extends BarRenderer {

		private static final long serialVersionUID = 1L;
		private Paint colors[];

		public Paint getItemPaint(int i, int j) {
			return colors[j % colors.length];
		}

		public CustomBarRenderer(Paint apaint[]) {
			colors = apaint;
		}
	}

	public void generateNewChartabc(){
//		newGeneratePieChart();
	}
	
	public String getImagePath() throws PMSException{
//		CommonMethodController commonMethodController = CommonMethodController.getInstance();
//		if("DOMAIN".equals(userInfoBean.getUserType()))
//			domainName= commonMethodController.getDmProperty(userInfoBean.getDomainId(),
//						"domainName");
//		contentPath =  CommonMethodController.getInstance().fetchSystemProperties("COMMON_CONTENT_PATH");
//		domainMap = CommonMethodController.getInstance().getDomainIdMap();
//		return SUCCESS;
	}
	
	public void generatePieChart() {
		try {
			logger.info("--generatePieChart--");
			short graphMasterDomainId;			
			CommonMethodController commonMethodController = CommonMethodController.getInstance();
			if (userInfoBean != null
					&& "DOMAIN".equals(userInfoBean.getUserType())) {
				paramMap.put("domainId", userInfoBean.getDomainId().toString());
				paramMap.put("reportCurrency",
						commonMethodController.getDmProperty(userInfoBean
								.getDomainId(), "currencyId"));
				graphMasterDomainId=userInfoBean.getDomainId();
				selectDomainName = commonMethodController.getDmProperty(userInfoBean.getDomainId(),
						"domainName");
				
			} else if(userInfoBean != null  && "BO".equals(userInfoBean.getUserType()) && graphDomainId!=null ){
				paramMap.put("domainId", graphDomainId.toString());
				paramMap.put("reportCurrency",
						commonMethodController.getDmProperty(graphDomainId, "currencyId"));
				graphMasterDomainId=graphDomainId;
				selectDomainName = commonMethodController.getDmProperty(graphDomainId,
						"domainName");
			}else {
				paramMap.put("domainId", "0");
				paramMap.put("reportCurrency", commonMethodController
						.fetchSystemProperties("NATIVE_CURRENCY"));
				graphMasterDomainId=1;
				selectDomainName="All";
			}
			ReportsController repController = new ReportsController();
			Object[] obj = repController.getGraphUpdateTime(chartName,graphMasterDomainId).get(0);
			if ((Calendar.getInstance().getTimeInMillis() - ((Timestamp)(obj[1])).getTime()) / 60000 >= (Long)(obj[0])) {
				callChart(chartName);
				repController.updateGraphTime(chartName,graphMasterDomainId);
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void callChart (String chartName){
		if("getTotalRegDayWise".equals(chartName)) {
		 	stackedBarChartDemo(chartName, "getTotalRegDayWise",
					"Daily New Registration", "No. Of Registration", "Day");
		} else if("getTotalDepAmtDayWise".equals(chartName)) {
			 barChart(chartName, "getTotalDepAmtDayWise",
					 "Daily Deposits ", "Amount", "Day", 301, 200);
		} else if("getTotalWithDrawDayWise".equals(chartName)) {
			 barChart(chartName, "getTotalWithDrawDayWise",
					 "Daily WithDrawal Request", "Amount", "Day", 301, 200);
		} else if("getTotalRummyWagerDayWise".equals(chartName)) {
			barChart(chartName, "getTotalRummyWagerDayWise",
					 "Daily Rummy Wager", "Amount", "Day", 301, 200);
		} else if("getTotalPokerWagerDayWise".equals(chartName)) {
			barChart(chartName, "getTotalPokerWagerDayWise",
					 "Daily Poker Wager", "Amount", "Day", 301, 200);
		} else if("getTotalDepRequestStatus".equals(chartName)) {
			 stackedBarChartDemo(chartName,
					 "getTotalDepRequestStatus", "Daily Deposit Request Status",
					 "No. of Req", "Day");
		} else if("getTotalBonusDayWise".equals(chartName)) {
			 stackedBarChartDemo(chartName, "getTotalBonusDayWise",
					 "Daily Bonus Status", "Amount", "Day");
		} else if("getRummyWagerDayWise".equals(chartName)) {
			lineChart(chartName, "getRummyWagerDayWise",
					"Rummy Wager Day Wise", "Amount", "Time", 620,250);
		} else if("getSLEWagerDayWise".equals(chartName)) {
			lineChart(chartName, "getSLEWagerDayWise",
					"SLE Wager Day Wise", "Amount", "Time", 620,250);
		} else if("getSGEWagerDayWise".equals(chartName)) {
			lineChart(chartName, "getSGEWagerDayWise",
					"SGE Wager Day Wise", "Amount", "Time", 620,250);
		} else if("getIGEWagerDayWise".equals(chartName)) {
			lineChart(chartName, "getIGEWagerDayWise",
					"IGE Wager Day Wise", "Amount", "Time", 620,250);
		} else if("getDGEWagerDayWise".equals(chartName)) {
			lineChart(chartName, "getDGEWagerDayWise",
					"DGE Wager Day Wise", "Amount", "Time", 620,250);
		} else if("getRUMMYWagerDayWise".equals(chartName)) {
			lineChart(chartName, "getRUMMYWagerDayWise",
					"RUMMY Wager Day Wise", "Amount", "Time", 620,250);
		} else if("getPOKERWagerDayWise".equals(chartName)) {
			lineChart(chartName, "getPOKERWagerDayWise",
					"POKER Wager Day Wise", "Amount", "Time", 620,250);
		} else if("getSBSWagerDayWise".equals(chartName)) {
			lineChart(chartName, "getSBSWagerDayWise",
					"SBS Wager Day Wise", "Amount", "Time", 620,250);
		} else if("getRummyWagerHourWise".equals(chartName)) {
			lineChart(chartName, "getRummyWagerHourWise",
					"Rummy Wager Hour Wise", "Amount", "Time", 942,300);
		} else if("getTotalNgrIgeDayWise".equals(chartName)) {
			barChart(chartName, "getTotalNgrIgeDayWise",
					 "Daily IGE NGR", "Amount", "Day", 301, 200);
		} else if("getTotalNgrSlotDayWise".equals(chartName)) {
			barChart(chartName, "getTotalNgrSlotDayWise",
					 "Daily SLOT NGR", "Amount", "Day", 301, 200);
		} else if("getTotalNgrDayWise".equals(chartName)) {
			barChart(chartName, "getTotalNgrDayWise",
					 "Total Daily  NGR", "Amount", "Day", 301, 200);
		}   
		
	}

	private static Paint[] createPaint() {
		Paint apaint[] = new Paint[2];
		apaint[0] = new GradientPaint(0.0F, 0.0F, new Color(134, 181, 69),
				0.0F, 0.0F, new Color(134, 181, 69));
		apaint[1] = new GradientPaint(0.0F, 0.0F, new Color(105, 151, 236),
				0.0F, 0.0F, new Color(105, 151, 236));
		return apaint;
	}

	
	
	public void newGeneratePieChart(){
		try {
			logger.info("--generatePieChart--"+chartName);
			short graphMasterDomainId;			
			CommonMethodController commonMethodController = CommonMethodController.getInstance();
			if (userInfoBean != null
					&& "DOMAIN".equals(userInfoBean.getUserType())) {
				paramMap.put("domainId", userInfoBean.getDomainId().toString());
				paramMap.put("reportCurrency",
						commonMethodController.getDmProperty(userInfoBean
								.getDomainId(), "currencyId"));
				graphMasterDomainId=userInfoBean.getDomainId();
				selectDomainName = commonMethodController.getDmProperty(userInfoBean.getDomainId(),
						"domainName");
				
			} else if(userInfoBean != null  && "BO".equals(userInfoBean.getUserType()) && graphDomainId!=null ){
				paramMap.put("domainId", graphDomainId.toString());
				paramMap.put("reportCurrency",
						commonMethodController.getDmProperty(graphDomainId, "currencyId"));
				graphMasterDomainId=graphDomainId;
				selectDomainName = commonMethodController.getDmProperty(graphDomainId,
						"domainName");
			}else {
				paramMap.put("domainId", "0");
				paramMap.put("reportCurrency", commonMethodController
						.fetchSystemProperties("NATIVE_CURRENCY"));
				graphMasterDomainId=1;
				selectDomainName="All";
			}
			ReportsController repController = new ReportsController();
			repController.getGraphUpdateTime(chartName,graphMasterDomainId).get(0);
				newCallChart(graphMasterDomainId);
				repController.updateGraphTime(chartName,graphMasterDomainId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	public String getChartData(String typeChart, short graphMasterDomainId){
		String data = null;
		ReportsController repController = null;
		int refreshtime = 1;
		try{
			repController = new ReportsController();
			refreshtime = repController.getGraphRefreshTime(chartName,graphMasterDomainId);
		}catch(Exception e){
			e.printStackTrace();
		}
		Cache cache = CacheManager.getInstance().getCache("graphCache");
		cache.remove(("getTotalRummyRakeDayWise"+graphDomainId));
		cache.remove(("getWagerAndWinningGameWise"+graphDomainId));
		
		if(cache.get(chartName+graphDomainId)==null){
			
			switch (typeChart) {
			case "BarChart":
				data = newBarChart(chartName,chartName);
				break;
			case "LineChart":
				data = newLineChart(chartName,chartName);
				break;
			case "StackedBarChart":
				data = newStackedBarChart(chartName,chartName);
				break;	
			}
			
			Element e = new Element(chartName+graphDomainId,data);
			e.setTimeToLive(refreshtime*60);
			cache.put(e);
		}else{
			data = (String)cache.get(chartName+graphDomainId).getObjectValue();
		}
		
		return data;
	}
	
	
	public void newCallChart(short graphMasterDomainId){
		PrintWriter out = null;
		Gson gson = new Gson();
		String data = null;
		try {
			out = response.getWriter();
		}catch (IOException e) {
			e.printStackTrace();
		}catch (Exception be) {
			be.printStackTrace();
		}
		if(chartName.equals("getTotalNgrDayWise") || chartName.equals("getTotalDepAmtDayWise") || chartName.equals("getTotalRummyWagerDayWise") || chartName.equals("getTotalWithDrawDayWise") ||
				chartName.equals("getTotalPokerWagerDayWise") || chartName.equals("getTotalNgrIgeDayWise") || chartName.equals("getTotalNgrSlotDayWise")
				|| chartName.equals("getTotalRummyRakeDayWise")){
			data = getChartData("BarChart", graphMasterDomainId);
		}
		else if(chartName.equals("getRummyWagerHourWise") || chartName.equals("getRummyWagerDayWise") || chartName.equals("getSLEWagerDayWise") || chartName.equals("getSGEWagerDayWise") || chartName.equals("getIGEWagerDayWise") || chartName.equals("getDGEWagerDayWise")
				|| chartName.equals("getRUMMYWagerDayWise") || chartName.equals("getPOKERWagerDayWise") || chartName.equals("getSBSWagerDayWise")){
			data = getChartData("LineChart", graphMasterDomainId);
		}
		else if(chartName.equals("getTotalRegDayWise") || chartName.equals("getTotalDepRequestStatus") || chartName.equals("getTotalBonusDayWise") ||
				chartName.equals("getWagerAndWinningGameWise") || chartName.equals("getSBSWagerAndWinning") || chartName.equals("getSLEWagerAndWinning")|| chartName.equals("getSGEWagerAndWinning")|| chartName.equals("getDGEWagerAndWinning")|| chartName.equals("getIGEWagerAndWinning")
				|| chartName.equals("getRUMMYWagerAndWinning") || chartName.equals("getPOKERWagerAndWinning") || chartName.equals("getSBSWagerAndWinning")){
			data = getChartData("StackedBarChart", graphMasterDomainId);
		}
		out.write(data);
	}
	
	
	public String newStackedBarChart(String chartName, String proceName){
		
		Gson gson = new Gson();
		String jsonString = null;
		DefaultCategoryDataset dataSet = new DefaultCategoryDataset();
		ReportsController controller = new ReportsController();
		Map<String , List<String>> resultMap= new HashMap<String, List<String>>();
		Map<String ,String[]> finalMap= new LinkedHashMap<String, String[]>();
		try {
			if(proceName.equals("getWagerAndWinningGameWise") || proceName.equals("getSBSWagerAndWinning") || proceName.equals("getSLEWagerAndWinning")|| chartName.equals("getSGEWagerAndWinning")|| chartName.equals("getDGEWagerAndWinning") || chartName.equals("getIGEWagerAndWinning")
					|| chartName.equals("getRUMMYWagerAndWinning") || chartName.equals("getPOKERWagerAndWinning")){
				if(proceName.equals("getWagerAndWinningGameWise"))
					paramMap.put("gameType", "DGE_14");
				String sysDate="";
				List<String> defaultData =new ArrayList<>();
				defaultData.add("0");
				defaultData.add("0");
				for(int i=0;i<=6;i++){
					sysDate=Utility.getServerDate(-(i),0,0,"YYYY-MM-dd");
					resultMap.put(sysDate, defaultData);
				}
			}
			
			List<String[]> resultList = controller.fetchReportsData(paramMap,
					proceName);
			if (!resultList.isEmpty()) {
				for (String[] strArr : resultList) {
						if (proceName.equals("getTotalBonusDayWise")) {
							List<String> str=new ArrayList<String>();
							str.add(strArr[0]);
							str.add(strArr[1]);
							resultMap.put(strArr[2], str);
						}else if (proceName.equals("getWagerAndWinningGameWise")) {  // only for DGE
							
							if(resultMap.containsKey(strArr[0])){
								List<String> str=new ArrayList<String>();
								str.add(strArr[1]);
								str.add(strArr[2]);
								resultMap.put(strArr[0], str);
							}
						}else if(proceName.equals("getSBSWagerAndWinning")){
							
							if(resultMap.containsKey(strArr[0])){
								List<String> str=new ArrayList<String>();
								str.add(strArr[1]);
								str.add(strArr[2]);
								resultMap.put(strArr[0], str);
								package com.stpl.pms.action.bo.reports;

								import java.awt.BasicStroke;

								public class ReportChart extends BaseActionSupport{

									private static final long serialVersionUID = 1L;
									private static final Logger logger = Logger.getLogger(ReportChart.class);
									private Map<String, String> paramMap = new HashMap<String, String>() ;
									private String contentPath;
									private String chartName;
									private Short graphDomainId;
									private String selectDomainName;
									private List<String> graphList;
									private List<String> gameList;
									private String vendorCode;
								    static class CustomBarRenderer extends BarRenderer {

										private static final long serialVersionUID = 1L;
										private Paint colors[];

										public Paint getItemPaint(int i, int j) {
											return colors[j % colors.length];
										}

										public CustomBarRenderer(Paint apaint[]) {
											colors = apaint;
										}
									}

									public void generateNewChartabc(){
//										newGeneratePieChart();
									}
									
									public String getImagePath() throws PMSException{
//										CommonMethodController commonMethodController = CommonMethodController.getInstance();
//										if("DOMAIN".equals(userInfoBean.getUserType()))
//											domainName= commonMethodController.getDmProperty(userInfoBean.getDomainId(),
//														"domainName");
//										contentPath =  CommonMethodController.getInstance().fetchSystemProperties("COMMON_CONTENT_PATH");
//										domainMap = CommonMethodController.getInstance().getDomainIdMap();
//										return SUCCESS;
									}
									
									public void generatePieChart() {
										try {
											logger.info("--generatePieChart--");
											short graphMasterDomainId;			
											CommonMethodController commonMethodController = CommonMethodController.getInstance();
											if (userInfoBean != null
													&& "DOMAIN".equals(userInfoBean.getUserType())) {
												paramMap.put("domainId", userInfoBean.getDomainId().toString());
												paramMap.put("reportCurrency",
														commonMethodController.getDmProperty(userInfoBean
																.getDomainId(), "currencyId"));
												graphMasterDomainId=userInfoBean.getDomainId();
												selectDomainName = commonMethodController.getDmProperty(userInfoBean.getDomainId(),
														"domainName");
												
											} else if(userInfoBean != null  && "BO".equals(userInfoBean.getUserType()) && graphDomainId!=null ){
												paramMap.put("domainId", graphDomainId.toString());
												paramMap.put("reportCurrency",
														commonMethodController.getDmProperty(graphDomainId, "currencyId"));
												graphMasterDomainId=graphDomainId;
												selectDomainName = commonMethodController.getDmProperty(graphDomainId,
														"domainName");
											}else {
												paramMap.put("domainId", "0");
												paramMap.put("reportCurrency", commonMethodController
														.fetchSystemProperties("NATIVE_CURRENCY"));
												graphMasterDomainId=1;
												selectDomainName="All";
											}
											ReportsController repController = new ReportsController();
											Object[] obj = repController.getGraphUpdateTime(chartName,graphMasterDomainId).get(0);
											if ((Calendar.getInstance().getTimeInMillis() - ((Timestamp)(obj[1])).getTime()) / 60000 >= (Long)(obj[0])) {
												callChart(chartName);
												repController.updateGraphTime(chartName,graphMasterDomainId);
											} 
										} catch (Exception e) {
											e.printStackTrace();
										}
									}

									public void callChart (String chartName){
										if("getTotalRegDayWise".equals(chartName)) {
										 	stackedBarChartDemo(chartName, "getTotalRegDayWise",
													"Daily New Registration", "No. Of Registration", "Day");
										} else if("getTotalDepAmtDayWise".equals(chartName)) {
											 barChart(chartName, "getTotalDepAmtDayWise",
													 "Daily Deposits ", "Amount", "Day", 301, 200);
										} else if("getTotalWithDrawDayWise".equals(chartName)) {
											 barChart(chartName, "getTotalWithDrawDayWise",
													 "Daily WithDrawal Request", "Amount", "Day", 301, 200);
										} else if("getTotalRummyWagerDayWise".equals(chartName)) {
											barChart(chartName, "getTotalRummyWagerDayWise",
													 "Daily Rummy Wager", "Amount", "Day", 301, 200);
										} else if("getTotalPokerWagerDayWise".equals(chartName)) {
											barChart(chartName, "getTotalPokerWagerDayWise",
													 "Daily Poker Wager", "Amount", "Day", 301, 200);
										} else if("getTotalDepRequestStatus".equals(chartName)) {
											 stackedBarChartDemo(chartName,
													 "getTotalDepRequestStatus", "Daily Deposit Request Status",
													 "No. of Req", "Day");
										} else if("getTotalBonusDayWise".equals(chartName)) {
											 stackedBarChartDemo(chartName, "getTotalBonusDayWise",
													 "Daily Bonus Status", "Amount", "Day");
										} else if("getRummyWagerDayWise".equals(chartName)) {
											lineChart(chartName, "getRummyWagerDayWise",
													"Rummy Wager Day Wise", "Amount", "Time", 620,250);
										} else if("getSLEWagerDayWise".equals(chartName)) {
											lineChart(chartName, "getSLEWagerDayWise",
													"SLE Wager Day Wise", "Amount", "Time", 620,250);
										} else if("getSGEWagerDayWise".equals(chartName)) {
											lineChart(chartName, "getSGEWagerDayWise",
													"SGE Wager Day Wise", "Amount", "Time", 620,250);
										} else if("getIGEWagerDayWise".equals(chartName)) {
											lineChart(chartName, "getIGEWagerDayWise",
													"IGE Wager Day Wise", "Amount", "Time", 620,250);
										} else if("getDGEWagerDayWise".equals(chartName)) {
											lineChart(chartName, "getDGEWagerDayWise",
													"DGE Wager Day Wise", "Amount", "Time", 620,250);
										} else if("getRUMMYWagerDayWise".equals(chartName)) {
											lineChart(chartName, "getRUMMYWagerDayWise",
													"RUMMY Wager Day Wise", "Amount", "Time", 620,250);
										} else if("getPOKERWagerDayWise".equals(chartName)) {
											lineChart(chartName, "getPOKERWagerDayWise",
													"POKER Wager Day Wise", "Amount", "Time", 620,250);
										} else if("getSBSWagerDayWise".equals(chartName)) {
											lineChart(chartName, "getSBSWagerDayWise",
													"SBS Wager Day Wise", "Amount", "Time", 620,250);
										} else if("getRummyWagerHourWise".equals(chartName)) {
											lineChart(chartName, "getRummyWagerHourWise",
													"Rummy Wager Hour Wise", "Amount", "Time", 942,300);
										} else if("getTotalNgrIgeDayWise".equals(chartName)) {
											barChart(chartName, "getTotalNgrIgeDayWise",
													 "Daily IGE NGR", "Amount", "Day", 301, 200);
										} else if("getTotalNgrSlotDayWise".equals(chartName)) {
											barChart(chartName, "getTotalNgrSlotDayWise",
													 "Daily SLOT NGR", "Amount", "Day", 301, 200);
										} else if("getTotalNgrDayWise".equals(chartName)) {
											barChart(chartName, "getTotalNgrDayWise",
													 "Total Daily  NGR", "Amount", "Day", 301, 200);
										}   
										
									}

									private static Paint[] createPaint() {
										Paint apaint[] = new Paint[2];
										apaint[0] = new GradientPaint(0.0F, 0.0F, new Color(134, 181, 69),
												0.0F, 0.0F, new Color(134, 181, 69));
										apaint[1] = new GradientPaint(0.0F, 0.0F, new Color(105, 151, 236),
												0.0F, 0.0F, new Color(105, 151, 236));
										return apaint;
									}

									
									
									public void newGeneratePieChart(){
										try {
											logger.info("--generatePieChart--"+chartName);
											short graphMasterDomainId;			
											CommonMethodController commonMethodController = CommonMethodController.getInstance();
											if (userInfoBean != null
													&& "DOMAIN".equals(userInfoBean.getUserType())) {
												paramMap.put("domainId", userInfoBean.getDomainId().toString());
												paramMap.put("reportCurrency",
														commonMethodController.getDmProperty(userInfoBean
																.getDomainId(), "currencyId"));
												graphMasterDomainId=userInfoBean.getDomainId();
												selectDomainName = commonMethodController.getDmProperty(userInfoBean.getDomainId(),
														"domainName");
												
											} else if(userInfoBean != null  && "BO".equals(userInfoBean.getUserType()) && graphDomainId!=null ){
												paramMap.put("domainId", graphDomainId.toString());
												paramMap.put("reportCurrency",
														commonMethodController.getDmProperty(graphDomainId, "currencyId"));
												graphMasterDomainId=graphDomainId;
												selectDomainName = commonMethodController.getDmProperty(graphDomainId,
														"domainName");
											}else {
												paramMap.put("domainId", "0");
												paramMap.put("reportCurrency", commonMethodController
														.fetchSystemProperties("NATIVE_CURRENCY"));
												graphMasterDomainId=1;
												selectDomainName="All";
											}
											ReportsController repController = new ReportsController();
											repController.getGraphUpdateTime(chartName,graphMasterDomainId).get(0);
												newCallChart(graphMasterDomainId);
												repController.updateGraphTime(chartName,graphMasterDomainId);
										} catch (Exception e) {
											e.printStackTrace();
										}
										
									}
									
									
									public String getChartData(String typeChart, short graphMasterDomainId){
										String data = null;
										ReportsController repController = null;
										int refreshtime = 1;
										try{
											repController = new ReportsController();
											refreshtime = repController.getGraphRefreshTime(chartName,graphMasterDomainId);
										}catch(Exception e){
											e.printStackTrace();
										}
										Cache cache = CacheManager.getInstance().getCache("graphCache");
										cache.remove(("getTotalRummyRakeDayWise"+graphDomainId));
										cache.remove(("getWagerAndWinningGameWise"+graphDomainId));
										
										if(cache.get(chartName+graphDomainId)==null){
											
											switch (typeChart) {
											case "BarChart":
												data = newBarChart(chartName,chartName);
												break;
											case "LineChart":
												data = newLineChart(chartName,chartName);
												break;
											case "StackedBarChart":
												data = newStackedBarChart(chartName,chartName);
												break;	
											}
											
											Element e = new Element(chartName+graphDomainId,data);
											e.setTimeToLive(refreshtime*60);
											cache.put(e);
										}else{
											data = (String)cache.get(chartName+graphDomainId).getObjectValue();
										}
										
										return data;
									}
									
									
									public void newCallChart(short graphMasterDomainId){
										PrintWriter out = null;
										Gson gson = new Gson();
										String data = null;
										try {
											out = response.getWriter();
										}catch (IOException e) {
											e.printStackTrace();
										}catch (Exception be) {
											be.printStackTrace();
										}
										if(chartName.equals("getTotalNgrDayWise") || chartName.equals("getTotalDepAmtDayWise") || chartName.equals("getTotalRummyWagerDayWise") || chartName.equals("getTotalWithDrawDayWise") ||
												chartName.equals("getTotalPokerWagerDayWise") || chartName.equals("getTotalNgrIgeDayWise") || chartName.equals("getTotalNgrSlotDayWise")
												|| chartName.equals("getTotalRummyRakeDayWise")){
											data = getChartData("BarChart", graphMasterDomainId);
										}
										else if(chartName.equals("getRummyWagerHourWise") || chartName.equals("getRummyWagerDayWise") || chartName.equals("getSLEWagerDayWise") || chartName.equals("getSGEWagerDayWise") || chartName.equals("getIGEWagerDayWise") || chartName.equals("getDGEWagerDayWise")
												|| chartName.equals("getRUMMYWagerDayWise") || chartName.equals("getPOKERWagerDayWise") || chartName.equals("getSBSWagerDayWise")){
											data = getChartData("LineChart", graphMasterDomainId);
										}
										else if(chartName.equals("getTotalRegDayWise") || chartName.equals("getTotalDepRequestStatus") || chartName.equals("getTotalBonusDayWise") ||
												chartName.equals("getWagerAndWinningGameWise") || chartName.equals("getSBSWagerAndWinning") || chartName.equals("getSLEWagerAndWinning")|| chartName.equals("getSGEWagerAndWinning")|| chartName.equals("getDGEWagerAndWinning")|| chartName.equals("getIGEWagerAndWinning")
												|| chartName.equals("getRUMMYWagerAndWinning") || chartName.equals("getPOKERWagerAndWinning") || chartName.equals("getSBSWagerAndWinning")){
											data = getChartData("StackedBarChart", graphMasterDomainId);
										}
										out.write(data);
									}
									
									
									public String newStackedBarChart(String chartName, String proceName){
										
										Gson gson = new Gson();
										String jsonString = null;
										DefaultCategoryDataset dataSet = new DefaultCategoryDataset();
										ReportsController controller = new ReportsController();
										Map<String , List<String>> resultMap= new HashMap<String, List<String>>();
										Map<String ,String[]> finalMap= new LinkedHashMap<String, String[]>();
										try {
											if(proceName.equals("getWagerAndWinningGameWise") || proceName.equals("getSBSWagerAndWinning") || proceName.equals("getSLEWagerAndWinning")|| chartName.equals("getSGEWagerAndWinning")|| chartName.equals("getDGEWagerAndWinning") || chartName.equals("getIGEWagerAndWinning")
													|| chartName.equals("getRUMMYWagerAndWinning") || chartName.equals("getPOKERWagerAndWinning")){
												if(proceName.equals("getWagerAndWinningGameWise"))
													paramMap.put("gameType", "DGE_14");
												String sysDate="";
												List<String> defaultData =new ArrayList<>();
												defaultData.add("0");
												defaultData.add("0");
												for(int i=0;i<=6;i++){
													sysDate=Utility.getServerDate(-(i),0,0,"YYYY-MM-dd");
													resultMap.put(sysDate, defaultData);
												}
											}
											
											List<String[]> resultList = controller.fetchReportsData(paramMap,
													proceName);
											if (!resultList.isEmpty()) {
												for (String[] strArr : resultList) {
														if (proceName.equals("getTotalBonusDayWise")) {
															List<String> str=new ArrayList<String>();
															str.add(strArr[0]);
															str.add(strArr[1]);
															resultMap.put(strArr[2], str);
														}else if (proceName.equals("getWagerAndWinningGameWise")) {  // only for DGE
															
															if(resultMap.containsKey(strArr[0])){
																List<String> str=new ArrayList<String>();
																str.add(strArr[1]);
																str.add(strArr[2]);
																resultMap.put(strArr[0], str);
															}
														}else if(proceName.equals("getSBSWagerAndWinning")){
															
															if(resultMap.containsKey(strArr[0])){
																List<String> str=new ArrayList<String>();
																str.add(strArr[1]);
																str.add(strArr[2]);
																resultMap.put(strArr[0], str);
															}
																						
														}else if(proceName.equals("getSLEWagerAndWinning")){
															
															if(resultMap.containsKey(strArr[0])){
																List<String> str=new ArrayList<String>();
																str.add(strArr[1]);
																str.add(strArr[2]);
																resultMap.put(strArr[0], str);
															}
																						
														}else if(proceName.equals("getSGEWagerAndWinning")){
															
															if(resultMap.containsKey(strArr[0])){
																List<String> str=new ArrayList<String>();
																str.add(strArr[1]);
																str.add(strArr[2]);
																resultMap.put(strArr[0], str);
															}
																						
														}else if(proceName.equals("getRUMMYWagerAndWinning")){
															
															if(resultMap.containsKey(strArr[0])){
																List<String> str=new ArrayList<String>();
																str.add(strArr[1]);
																str.add(strArr[2]);
																resultMap.put(strArr[0], str);
															}
																						
														}else if(proceName.equals("getPOKERWagerAndWinning")){
															
															if(resultMap.containsKey(strArr[0])){
																List<String> str=new ArrayList<String>();
																str.add(strArr[1]);
																str.add(strArr[2]);
																resultMap.put(strArr[0], str);
															}
																						
														}else if(proceName.equals("getDGEWagerAndWinning")){
															
															if(resultMap.containsKey(strArr[0])){
																List<String> str=new ArrayList<String>();
																str.add(strArr[1]);
																str.add(strArr[2]);
																resultMap.put(strArr[0], str);
															}
																						
														}else if(proceName.equals("getIGEWagerAndWinning")){
															
															if(resultMap.containsKey(strArr[0])){
																List<String> str=new ArrayList<String>();
																str.add(strArr[1]);
																str.add(strArr[2]);
																resultMap.put(strArr[0], str);
															}
																						
														} else if(proceName.equals("getTotalRegDayWise")) {
															String str[]= {strArr[0],strArr[1],strArr[2],strArr[3], strArr[4]};
															finalMap.put(strArr[5],str);
														} else {
															 String str[]= {strArr[0],strArr[1],strArr[2],strArr[3]};
															 finalMap.put(strArr[4],str);
														}
												}
												if (proceName.equals("getTotalBonusDayWise")) {
													stackData(resultMap,chartName, dataSet);
												} else if (proceName.equals("getTotalGameWagerDayWise")) {
													stackDataGame(finalMap,chartName, dataSet);
												} else if(proceName.equals("getTotalRegDayWise")){
													stackMapDReg(finalMap,chartName, dataSet);
												} else if(proceName.equals("getWagerAndWinningGameWise")){
													stackData(resultMap,chartName, dataSet);
												} else if(proceName.equals("getSBSWagerAndWinning")){
													stackData(resultMap,chartName, dataSet);
												} else if(proceName.equals("getSLEWagerAndWinning")){
													stackData(resultMap,chartName, dataSet);
												} else if(proceName.equals("getRUMMYWagerAndWinning")){
													stackData(resultMap,chartName, dataSet);
												}  else if(proceName.equals("getPOKERWagerAndWinning")){
													stackData(resultMap,chartName, dataSet);
												}  else if(proceName.equals("getSGEWagerAndWinning")){
													stackData(resultMap,chartName, dataSet);
												} else if(proceName.equals("getDGEWagerAndWinning")){
													stackData(resultMap,chartName, dataSet);
												} else if(proceName.equals("getIGEWagerAndWinning")){
													stackData(resultMap,chartName, dataSet);
												} else{
													stackDataMap(finalMap,chartName, dataSet);
												}
											}
											} catch (Exception e) {
											e.printStackTrace();
											}
											jsonString = gson.toJson(dataSet);
											return jsonString;
											
									}
									
									
									public String newLineChart(String chartName, String proceName){
										
										Gson gson = new Gson();
										String jsonString = null;
										ReportsController controller = new ReportsController();
										Map<String, String[]> finalMap = new LinkedHashMap<String, String[]>();
										TimeSeriesCollection dataset = new TimeSeriesCollection();
										List<String[]> resultList = null;
										
										
										
										Date dateobj = new Date();
										DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
										ArrayList<String> arrdate = new ArrayList<String>();
										for(int i=0;i<4;i++){
											String date = df.format(dateobj);
											arrdate.add(date);
											Calendar cal = Calendar.getInstance();
										    cal.setTime(dateobj);
										    cal.add(Calendar.DAY_OF_MONTH, -1);
										    dateobj = cal.getTime();
											
										}
										
										try {
											resultList = controller.fetchReportsData(paramMap, proceName);
											
											for(int i=0;i<resultList.size();i++)
											{
												String[] arr = resultList.get(i);
												if(arrdate.contains(arr[0])){
													arrdate.remove(arrdate.indexOf(arr[0]));
												}
											}
											for(int i=0; i<arrdate.size(); i++){
												
												String y[] = new String[25];
												Arrays.fill(y, "0");
												y[0] = arrdate.get(i);
												resultList.add(y);
											}
											
											
											Collections.sort(resultList,new Comparator<String[]>() {
									            public int compare(String[] strings, String[] otherStrings) {
									                return otherStrings[0].compareTo(strings[0]);
									            }
									        });
											} catch (Exception e) {
												e.printStackTrace();
											}
											jsonString = gson.toJson(resultList);
											return jsonString;
									}
									
									public String newBarChart(String chartName, String proceName){

										//JFreeChart chart;
										String jsonString = null;
										Gson gson = new Gson();
										DefaultCategoryDataset dataSet = new DefaultCategoryDataset();
										ReportsController controller = new ReportsController();
										Map<String , List<String>> resultMap= new HashMap<>();
										List<String> dateList = new ArrayList<>();
										
										try {
											List<String[]> resultList = controller.fetchReportsData(paramMap,
													proceName);
											if (!resultList.isEmpty()) {
												if("getTotalNgrDayWise".equals(proceName)) {
													String sysDate = "";
													List<String> defaultData = new ArrayList<>();
													defaultData.add("0");
													for (int i = 1; i <= 7; i++) {
														sysDate = Utility.getServerDate(-(i), 0, 0, "YYYY-MM-dd");
														resultMap.put(sysDate, defaultData);
													}
												
													for(String[] strArr : resultList) {
														List<String> str=new ArrayList<>();
														str.add(strArr[1]);
														resultMap.put(strArr[0], str);
													}
													stackDataNgr(resultMap,chartName, dataSet);
												}else {
													for (String[] strArr : resultList) {
														    dateList.add(strArr[0]);
														    dateList.add(strArr[1]);
														    dateList.add(strArr[2]);
														    dateList.add(strArr[3]);
														    dateList.add(strArr[4]);
														    dateList.add(strArr[5]);
														    dateList.add(strArr[6]);
													}
													setDataInList(dateList, dataSet,chartName);
												
												}
											}
											
											
											
										} catch (Exception e) {
											e.printStackTrace();
										}
										jsonString = gson.toJson(dataSet);
										return jsonString;
									}
									
									public void barChart(String chartName, String proceName, String headerName,
											String verHeading, String horHeading,int width, int height ) {
										JFreeChart chart;
										DefaultCategoryDataset dataSet = new DefaultCategoryDataset();
										ReportsController controller = new ReportsController();
										List<String> dateList = new ArrayList<String>();
										try {
											List<String[]> resultList = controller.fetchReportsData(paramMap,
													proceName);
											double count = 0;
											double currMonth = 0;
											double lastMonth = 0;
											if (resultList.size() != 0) {
												for (String[] strArr : resultList) {
													    dateList.add(strArr[0]);
													    dateList.add(strArr[1]);
													    dateList.add(strArr[2]);
													    dateList.add(strArr[3]);
													    dateList.add(strArr[4]);
													    dateList.add(strArr[5]);
													    dateList.add(strArr[6]);
														count = count + Double.valueOf(strArr[7].equals("--")?"0":strArr[7]);
														currMonth  += Double.valueOf(strArr[8].equals("--")?"0":strArr[8]);
														lastMonth += Double.valueOf(strArr[9].equals("--")?"0":strArr[9]);
												}
												setDataInList(dateList, dataSet,chartName);
											}
											NumberFormat number = NumberFormat.getNumberInstance(Locale.US);
											chart = ChartFactory.createBarChart3D(headerName, null, verHeading,
													dataSet, PlotOrientation.VERTICAL, false, true, false);

											TextTitle texttitle = chart.getTitle();
											texttitle.setFont(new Font("Arial", Font.BOLD, 15));
											texttitle.setBorder(0.5D, 0.5D, 0.5D, 0.5D);
											texttitle.setPaint(new Color(51, 51, 51));
											texttitle.setBackgroundPaint(new GradientPaint(0.0F, 0.0F,
													new Color(230, 230, 230), 350.0F, 0.0F, new Color(230, 230,
															230)));
											texttitle.setExpandToFitSpace(true);
											texttitle.setPadding(5, 5, 5, 5);
											chart.setBackgroundPaint(new GradientPaint(0.0F, 0.0F, new Color(
													242, 242, 242), 350F, 0.0F, new Color(242, 242, 242)));
											chart.setBorderPaint(new Color(187, 187, 197));
											chart.setBorderStroke(new BasicStroke(1.0F));
											chart.setBorderVisible(true);
											CategoryPlot categoryplot = (CategoryPlot) chart.getPlot();
											categoryplot.setNoDataMessage("NO DATA!");
											categoryplot.setBackgroundPaint(null);
											categoryplot.setInsets(new RectangleInsets(10D, 5D, 5D, 5D));
											categoryplot.setOutlinePaint(new Color(221, 221, 221));
											categoryplot.setDomainGridlinePaint(new Color(221, 221, 221));
											categoryplot.setDomainGridlineStroke(new BasicStroke(1.0F));
											categoryplot.setDomainGridlinesVisible(true);
											categoryplot.setRangeGridlinePaint(new Color(221, 221, 221));
											categoryplot.setRangeGridlineStroke(new BasicStroke(1.0F));
											NumberAxis numberaxis = (NumberAxis) categoryplot.getRangeAxis();
											CategoryAxis domainAxis = categoryplot.getDomainAxis();
											domainAxis.setTickLabelFont(new Font("Arial", Font.PLAIN,8));
											domainAxis.setLabelFont(new Font("Arial", Font.PLAIN, 8));
											numberaxis.setTickLabelFont(new Font("Arial", Font.PLAIN, 10));
											numberaxis.setLabelFont(new Font("Arial", Font.PLAIN, 10));

											Paint apaint[] = createPaint();
											CustomBarRenderer custombarrenderer = new CustomBarRenderer(apaint);
											custombarrenderer.setDrawBarOutline(false);
											custombarrenderer
													.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
											custombarrenderer.setBaseItemLabelsVisible(true);
											custombarrenderer.setItemLabelAnchorOffset(5D);
											custombarrenderer.setShadowVisible(false);
											custombarrenderer.setBarPainter(new StandardBarPainter());
											custombarrenderer.setMaximumBarWidth(0.200000000000000000D);
											custombarrenderer.setBasePositiveItemLabelPosition(new ItemLabelPosition(ItemLabelAnchor.CENTER, TextAnchor.CENTER, TextAnchor.CENTER, (3*Math.PI)/2));

											numberaxis
													.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
											numberaxis.setTickMarkPaint(Color.black);
											numberaxis.setLowerMargin(0.14999999999999999D);
											numberaxis.setUpperMargin(0.14999999999999999D);
											categoryplot.setRenderer(custombarrenderer);
											String currTime = String.valueOf(Calendar.getInstance().getTimeInMillis());
											saveImageFile(chartName+currTime, chart, width, height, true);
											String dirPath = System.getProperty("jboss.home.url").split(":")[1]+"bin/WeaverFiles/"+chartName+currTime+".png";
											BufferedImage bufferedImage = new BufferedImage(width, (height+51),BufferedImage.TYPE_INT_RGB);
											Graphics2D graphic = (Graphics2D)bufferedImage.createGraphics();
											Image  img = new ImageIcon(dirPath).getImage();
											graphic.drawImage(img, 0, 0, null);
											graphic.setStroke(new BasicStroke(1));
											int x = 0;
											for (int i=0; i<3; i++) {
												graphic.setColor(new Color(230, 230, 230));
												graphic.fillRect(x,height,100,25);
												graphic.setColor(new Color(187, 187, 197));
												graphic.drawRect(x,height, 100,25);
												graphic.setColor(new Color(255, 255, 255));
												graphic.fillRect(x,(height+25),100,25);
												graphic.setColor(new Color(187, 187, 197));
												graphic.drawRect(x,(height+25), 100,25);
										    	x=x+100;
											}
										    String[] value = {"Current Month", number.format((int)currMonth),"Last Month",number.format((int)lastMonth), "Total",
													 number.format((int)count) };
										    graphic.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
										            RenderingHints.VALUE_ANTIALIAS_ON); 
										    x = 0;
											for (int i = 0; i < value.length; i++) {
												graphic.setColor(new Color(0, 0, 0));
												graphic.setFont(new Font("Bitstream Vera Sans", Font.PLAIN, 11));
												drawCenteredString(value[i], 100, 25, x, height, graphic);
												graphic.setColor(new Color(106, 106, 106));
												drawCenteredString(value[++i], 100, 25, x, (height+25), graphic);
												x = x + 100;
											}
											graphic.dispose();
										    saveImageFile(bufferedImage, chartName, dirPath);
										} catch (Exception e) {
											e.printStackTrace();
										}
									}
									
									private void drawCenteredString(String s, int w, int h, int wi, int hi, Graphics2D graphic) {
										    FontMetrics fm = graphic.getFontMetrics();
										    int x = (w - fm.stringWidth(s)) / 2;
										    int y = (fm.getAscent() + (h - (fm.getAscent() + fm.getDescent())) / 2);
										    graphic.drawString(s, wi+x, hi+y);
										  }
									
									 private void saveImageFile(BufferedImage bufferedImage, String chartName, String dirPath) throws IOException, PMSException {
											final File file1 = new File(dirPath);
											ImageIO.write(bufferedImage, "png", file1);			
											Utility.saveOrUpdateGraphContent(file1, chartName+".png", selectDomainName+"/boImage");
											file1.delete();
										}

									 public void setDataInList(List<String> dateList,DefaultCategoryDataset dataSet,String chartName) {
										SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
										for(int i=6; i>=0;i--){
											Calendar c = Calendar.getInstance();
											c.setTime(new Date());
											c.add(Calendar.DATE, -i);
										    String newDate= sdf.format(c.getTime());
										    String result= dateList.get(i);
										    String[] dateArr = newDate.split("-");
										    if(result!=null) {
												dataSet.setValue(Double.valueOf(result.equals("--")?"0":result),
														chartName, dateArr[2] + "/" + dateArr[1]);
										    }else{
												dataSet.setValue(0D, chartName, dateArr[2] + "/"
														+ dateArr[1]);
										    }
										}
									}

									private void lineChart(String chartName, String proceName,
											String headerName, String verHeading, String horHeading, int width, int height) {
										ReportsController controller = new ReportsController();
										Map<String, String[]> finalMap = new LinkedHashMap<String, String[]>();
										TimeSeriesCollection dataset = new TimeSeriesCollection();
										List<String[]> resultList = null;
										try {
											resultList = controller.fetchReportsData(paramMap, proceName);
											if (resultList.size() != 0) {
												for (String[] strArr : resultList) {
													String str[] = { strArr[1], strArr[2], strArr[3],
															strArr[4], strArr[5], strArr[6], strArr[7],
															strArr[8], strArr[9], strArr[10], strArr[11],
															strArr[12], strArr[13], strArr[14], strArr[15],
															strArr[16], strArr[17], strArr[18], strArr[19],
															strArr[20], strArr[21], strArr[22], strArr[23],
															strArr[24] };
													finalMap.put(strArr[0], str);
												}
											}
											lineStackData(finalMap, dataset);
											JFreeChart chart = ChartFactory.createTimeSeriesChart(headerName,
													null, verHeading, dataset, true, true, false);
											TextTitle texttitle = chart.getTitle();
											texttitle.setFont(new Font("Arial", Font.BOLD, 15));
											texttitle.setBorder(0.5D, 0.5D, 0.5D, 0.5D);
											texttitle.setPaint(new Color(51, 51, 51));
											texttitle.setBackgroundPaint(new GradientPaint(0.0F, 0.0F,
													new Color(230, 230, 230), 350.0F, 0.0F, new Color(230, 230,
															230)));
											texttitle.setExpandToFitSpace(true);
											texttitle.setPadding(5, 5, 5, 5);
											chart.setBackgroundPaint(new GradientPaint(0.0F, 0.0F, new Color(
													242, 242, 242), 350F, 0.0F, new Color(242, 242, 242)));
											chart.setBorderPaint(new Color(187, 187, 197));
											chart.setBorderStroke(new BasicStroke(1.0F));
											chart.setBorderVisible(true);
											XYPlot categoryplot = (XYPlot) chart.getPlot();
											XYItemRenderer xyRender = categoryplot.getRenderer();
											
											xyRender.setSeriesPaint(0, Color.ORANGE);
											xyRender.setSeriesPaint(1, Color.pink);
											xyRender.setSeriesPaint(2, Color.MAGENTA);
											xyRender.setSeriesPaint(3, Color.BLACK);
											
									
											xyRender.setSeriesStroke(0, new BasicStroke(1.5f));
											xyRender.setSeriesStroke(1, new BasicStroke(1.5f));
											xyRender.setSeriesStroke(2, new BasicStroke(1.5f));
											xyRender.setSeriesStroke(3, new BasicStroke(3));
											
											
											categoryplot.mapDatasetToRangeAxis(0,0);
											categoryplot.setNoDataMessage("NO DATA!");
											categoryplot.setBackgroundPaint(null);
											categoryplot.setOutlinePaint(new Color(221, 221, 221));
											categoryplot.setDomainGridlinePaint(new Color(221, 221, 221));
											categoryplot.setDomainGridlineStroke(new BasicStroke(1.0F));
											categoryplot.setDomainGridlinesVisible(true);
											categoryplot.setRangeGridlinePaint(new Color(221, 221, 221));
											categoryplot.setRangeGridlineStroke(new BasicStroke(1.0F));
											NumberAxis numberaxis = (NumberAxis) categoryplot.getRangeAxis();
											numberaxis.setAutoRangeIncludesZero(true);
											ValueAxis domainAxis = categoryplot.getDomainAxis();
											
											domainAxis.setTickLabelFont(new Font("Arial", Font.PLAIN, 8));
											domainAxis.setLabelFont(new Font("Arial", Font.PLAIN, 8));
											numberaxis.setTickLabelFont(new Font("Arial", Font.PLAIN, 10));
											numberaxis.setLabelFont(new Font("Arial", Font.PLAIN, 10));
											chart.getLegend().setItemFont(new Font("Arial", Font.PLAIN, 9));
											numberaxis.setLowerMargin(0.14999999999999999D);
											numberaxis.setUpperMargin(0.14999999999999999D);
											saveImageFile(chartName, chart, width, height, false);
										} catch (Exception e) {
											e.printStackTrace();
										}
									}
									
									public void lineStackData(Map<String, String[]> resultMap,TimeSeriesCollection dataset) {
										SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
										TimeSeries series = null;
										Calendar cal = Calendar.getInstance();
										cal.setTime(new Date());
										String currDate = sdf.format(cal.getTime());
										int currHour = cal.get(Calendar.HOUR_OF_DAY);
										for (int i = 3; i >=0; i--) {
											Calendar c = Calendar.getInstance();
											c.setTime(new Date());
											c.add(Calendar.DATE, -i);
											String newDate = sdf.format(c.getTime());
											String[] result = resultMap.get(newDate);
											series = new TimeSeries(newDate);
											Hour hour = new Hour(0, new Day());
											if (result != null) {
												series.add(hour, 0D);
												if (currDate.equals(newDate)) {
													for (int j = 0; j < result.length; j++) {
														hour = (Hour) hour.next();
														if (hour.getHour()!=0 && currHour >= hour.getHour())
															series.add(hour, Double.valueOf(result[j]));
														else
															series.add(hour, null);
													}
												} else {
													for (int j = 0; j < result.length; j++) {
														hour = (Hour) hour.next();
														series.add(hour, Double.valueOf(result[j]));
													}
												}
											} else {
												for (int j = 0; j < 24; j++) {
													hour = (Hour) hour.next();
													series.add(hour, 0D);
												}
											}
											dataset.addSeries(series);
										}
									}
									
									private void stackedBarChartDemo(String chartName, String proceName,
											String headerName, String verHeading, String horHeading) {
										DefaultCategoryDataset dataSet = new DefaultCategoryDataset();
										ReportsController controller = new ReportsController();
										Map<String , List<String>> resultMap= new HashMap<String, List<String>>();
										Map<String ,String[]> finalMap= new LinkedHashMap<String, String[]>();
										try {
											List<String[]> resultList = controller.fetchReportsData(paramMap,
													proceName);
											if (resultList.size() != 0) {
												for (String[] strArr : resultList) {
														if (proceName.equals("getTotalBonusDayWise")) {
															List<String> str=new ArrayList<String>();
															str.add(strArr[0]);
															str.add(strArr[1]);
															resultMap.put(strArr[2], str);
														} else if(proceName.equals("getTotalRegDayWise")) {
															String str[]= {strArr[0],strArr[1],strArr[2],strArr[3], strArr[4]};
															finalMap.put(strArr[5],str);
														} else {
															 String str[]= {strArr[0],strArr[1],strArr[2],strArr[3]};
															 finalMap.put(strArr[4],str);
														}
												}
												if (proceName.equals("getTotalBonusDayWise")) {
													stackData(resultMap,chartName, dataSet);
												} else if (proceName.equals("getTotalGameWagerDayWise")) {
													stackDataGame(finalMap,chartName, dataSet);
												} else if(proceName.equals("getTotalRegDayWise")){
													stackMapDReg(finalMap,chartName, dataSet);
												} else{
													stackDataMap(finalMap,chartName, dataSet);
												}
											}
											JFreeChart chart = ChartFactory.createBarChart3D(headerName, null,
													verHeading, dataSet, PlotOrientation.VERTICAL, true, true,
													false);
											CategoryPlot categoryplot = (CategoryPlot) chart.getPlot();
											TextTitle texttitle = chart.getTitle();
											texttitle.setFont(new Font("Arial", Font.BOLD, 15));
											texttitle.setBorder(0.5D, 0.5D, 0.5D, 0.5D);
											texttitle.setPaint(new Color(51, 51, 51));
											texttitle.setBackgroundPaint(new GradientPaint(0.0F, 0.0F,
													new Color(230, 230, 230), 350.0F, 0.0F, new Color(230, 230,
															230)));
											texttitle.setExpandToFitSpace(true);
											texttitle.setPadding(5, 5, 5, 5);
											chart.setBackgroundPaint(new GradientPaint(0.0F, 0.0F, new Color(
													242, 242, 242), 350F, 0.0F, new Color(242, 242, 242)));
											chart.setBorderPaint(new Color(187, 187, 197));
											chart.setBorderStroke(new BasicStroke(1.0F));
											chart.setBorderVisible(true);
											categoryplot.setNoDataMessage("NO DATA!");
											categoryplot.setBackgroundPaint(null);
											categoryplot.setOutlinePaint(new Color(221, 221, 221));
											categoryplot.setDomainGridlinePaint(new Color(221, 221, 221));
											categoryplot.setDomainGridlineStroke(new BasicStroke(1.0F));
											categoryplot.setDomainGridlinesVisible(true);
											categoryplot.setRangeGridlinePaint(new Color(221, 221, 221));
											categoryplot.setRangeGridlineStroke(new BasicStroke(1.0F));
											NumberAxis numberaxis = (NumberAxis) categoryplot.getRangeAxis();
											CategoryAxis domainAxis = categoryplot.getDomainAxis();
											domainAxis.setTickLabelFont(new Font("Arial", Font.PLAIN, 8));
											domainAxis.setLabelFont(new Font("Arial", Font.PLAIN, 8));
											numberaxis.setTickLabelFont(new Font("Arial", Font.PLAIN, 10));
											numberaxis.setLabelFont(new Font("Arial", Font.PLAIN, 10));
											chart.getLegend().setItemFont(new Font("Arial", Font.PLAIN, 9));
											ExtendedStackedBarRenderer custombarrenderer = new ExtendedStackedBarRenderer();
											paintColor(custombarrenderer);
											custombarrenderer.setDrawBarOutline(false);
											custombarrenderer.setBaseItemLabelsVisible(true);
											custombarrenderer
													.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
											custombarrenderer.setShadowVisible(false);
											custombarrenderer.setBarPainter(new StandardBarPainter());
											custombarrenderer.setMaximumBarWidth(0.150000000000000000D);
											numberaxis
													.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
											numberaxis.setTickMarkPaint(Color.black);
											categoryplot.setRenderer(custombarrenderer);
											numberaxis.setLowerMargin(0.14999999999999999D);
											numberaxis.setUpperMargin(0.14999999999999999D);
											saveImageFile(chartName, chart, 300, 250, false);
										} catch (Exception e) {
											e.printStackTrace();
										}
									}
								   private void stackDataGame(Map<String, String[]> resultMap,String chartName,DefaultCategoryDataset dataSet) {
									    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
										for(int i=6; i>=0;i--){
											Calendar c = Calendar.getInstance();
											c.setTime(new Date());
											c.add(Calendar.DATE, -i);
										    String newDate= sdf.format(c.getTime());
										    String[] result=resultMap.get(newDate);
										    String[] dateArr = newDate.split("-");
										    if(result!=null)
										    {
										    	    dataSet.setValue(Double.valueOf(result[0]),
											    	    		"SGE", dateArr[2] + "/" + dateArr[1]);
											    	dataSet.setValue(Double.valueOf(result[1]),
											    	    		"IGE", dateArr[2] + "/" + dateArr[1]);
											    	 dataSet.setValue(Double.valueOf(result[2]),
											    	    		"SHERIFF", dateArr[2] + "/" + dateArr[1]);
											    	 dataSet.setValue(Double.valueOf(result[3]),
											    	    		"BSG", dateArr[2] + "/" + dateArr[1]);
										       
										    } else {
												dataSet.setValue(0D, "SGE", dateArr[2] + "/" + dateArr[1]);
												dataSet.setValue(0D, "IGE", dateArr[2] + "/" + dateArr[1]);
												dataSet.setValue(0D, "SHERIFF", dateArr[2] + "/" + dateArr[1]);
												dataSet.setValue(0D, "BSG", dateArr[2] + "/" + dateArr[1]);

											}
										}

									}

									public void stackData(Map<String, List<String>> resultMap,
											String chartName, DefaultCategoryDataset dataSet) {

										SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

										for (int i = 6; i >= 0; i--) {
											Calendar c = Calendar.getInstance();
											c.setTime(new Date());
											c.add(Calendar.DATE, -i);
											String newDate = sdf.format(c.getTime());
											List<String> result = resultMap.get(newDate);
											String[] dateArr = newDate.split("-");
											if (result != null) {
												dataSet.setValue(Double.valueOf(result.get(0)),
														"Total Bonus", dateArr[2] + "/" + dateArr[1]);
												dataSet.setValue(Double.valueOf(result.get(1)),
														"Convert to Cash", dateArr[2] + "/" + dateArr[1]);
											} else {
												dataSet.setValue(0D, "Total Bonus", dateArr[2] + "/"
														+ dateArr[1]);
												dataSet.setValue(0D, "Convert to Cash", dateArr[2] + "/"
														+ dateArr[1]);
											}
										}

									}
									
									public void stackDataNgr(Map<String, List<String>> resultMap,
											String chartName, DefaultCategoryDataset dataSet) {

										SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

										for (int i = 7; i >= 1; i--) {
											Calendar c = Calendar.getInstance();
											c.setTime(new Date());
											c.add(Calendar.DATE, -i);
											String newDate = sdf.format(c.getTime());
											List<String> result = resultMap.get(newDate);
											String[] dateArr = newDate.split("-");
											if (result != null) {
												dataSet.setValue(Double.valueOf(result.get(0)),
														"Total Ngr", dateArr[2] + "/" + dateArr[1]);
											} else {
												dataSet.setValue(0D, "Total Ngr", dateArr[2] + "/"
														+ dateArr[1]);
											}
										}

									}

									public void stackMapDReg(Map<String, String[]> resultMap, String chartName,
											DefaultCategoryDataset dataSet) {
										SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
										for (int i = 6; i >= 0; i--) {
											Calendar c = Calendar.getInstance();
											c.setTime(new Date());
											c.add(Calendar.DATE, -i);
											String newDate = sdf.format(c.getTime());
											String[] result = resultMap.get(newDate);
											String[] dateArr = newDate.split("-");
											if (result != null) {
												dataSet.setValue(Double.valueOf(result[0]), "DIRECT",
														dateArr[2] + "/" + dateArr[1]);
												dataSet.setValue(Double.valueOf(result[1]), "PPC",
														dateArr[2] + "/" + dateArr[1]);
												dataSet.setValue(Double.valueOf(result[2]), "REFER FRIEND",
														dateArr[2] + "/" + dateArr[1]);
												dataSet.setValue(Double.valueOf(result[3]), "OLA", dateArr[2]
														+ "/" + dateArr[1]);
												dataSet.setValue(Double.valueOf(result[4]), "AFFILIATE", dateArr[2]
														+ "/" + dateArr[1]);
												
											} else {
												dataSet.setValue(0D, "DIRECT", dateArr[2] + "/" + dateArr[1]);
												dataSet
														.setValue(0D, "PPC", dateArr[2] + "/"
																+ dateArr[1]);
												dataSet.setValue(0D, "REFER FRIEND", dateArr[2] + "/" + dateArr[1]);
												dataSet.setValue(0D, "OLA", dateArr[2] + "/" + dateArr[1]);
												dataSet.setValue(0D, "AFFILIATE", dateArr[2] + "/" + dateArr[1]);
											}
										}
									}
									
									public void stackDataMap(Map<String, String[]> resultMap, String chartName,
											DefaultCategoryDataset dataSet) {
										SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
										for (int i = 6; i >= 0; i--) {
											Calendar c = Calendar.getInstance();
											c.setTime(new Date());
											c.add(Calendar.DATE, -i);
											String newDate = sdf.format(c.getTime());
											String[] result = resultMap.get(newDate);
											String[] dateArr = newDate.split("-");
											if (result != null) {
												dataSet.setValue(Double.valueOf(result[0]), "PENDING",
														dateArr[2] + "/" + dateArr[1]);
												dataSet.setValue(Double.valueOf(result[1]), "INITIATED",
														dateArr[2] + "/" + dateArr[1]);
												dataSet.setValue(Double.valueOf(result[2]), "FAILED",
														dateArr[2] + "/" + dateArr[1]);
												dataSet.setValue(Double.valueOf(result[3]), "DONE", dateArr[2]
														+ "/" + dateArr[1]);

											} else {
												dataSet.setValue(0D, "PENDING", dateArr[2] + "/" + dateArr[1]);
												dataSet
														.setValue(0D, "INITIATED", dateArr[2] + "/"
																+ dateArr[1]);
												dataSet.setValue(0D, "FAILED", dateArr[2] + "/" + dateArr[1]);
												dataSet.setValue(0D, "DONE", dateArr[2] + "/" + dateArr[1]);
											}
										}

									}

									public static void paintColor(StackedBarRenderer custombarrenderer) {
										Paint p1 = new GradientPaint(0.0f, 0.0f, new Color(63, 124, 236), 0.0f,
												0.0f, new Color(63, 124, 236));
										custombarrenderer.setSeriesPaint(4, p1);

										Paint p2 = new GradientPaint(0.0f, 0.0f, new Color(136, 193, 56), 0.0f,
												0.0f, new Color(136, 193, 56));
										custombarrenderer.setSeriesPaint(3, p2);

										Paint p3 = new GradientPaint(0.0f, 0.0f, new Color(240, 218, 28), 0.0f,
												0.0f, new Color(240, 218, 28));
										custombarrenderer.setSeriesPaint(1, p3);

										Paint p4 = new GradientPaint(0.0f, 0.0f, new Color(85, 227, 253), 0.0f,
												0.0f, new Color(85, 227, 253));
										custombarrenderer.setSeriesPaint(0, p4);
										Paint p5 = new GradientPaint(0.0f, 0.0f, new Color(252, 94, 94), 0.0f,
												0.0f, new Color(252, 94, 94));
										custombarrenderer.setSeriesPaint(2, p5);
									}

									private void saveImageFile(String chartName, JFreeChart chart, int width, int height, boolean isTemp) throws IOException, PMSException {
										final ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
										chartName=chartName+".png";
										final File file1 = new File("WeaverFiles/"+ chartName);
										ChartUtilities.saveChartAsPNG(file1, chart, width, height, info);
										
										if(!isTemp) {			
											Utility.saveOrUpdateGraphContent(file1, chartName, selectDomainName+"/boImage");
											file1.delete();
										}
									}
									
									public String getActiveGraphList() {
										try {
											graphList = new ReportsController().getActiveGraphNames(domainId);
										} catch (Exception e) {
											addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
										}
										return SUCCESS;
									}
									
									public String getActiveGameWiseGraphList() {
										try {
									   		gameList = new ReportsController().getActiveGraphNames(domainId);
										} catch (Exception e) {
											addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
										}
										return SUCCESS;
									}
									// private void pieChart(String chartName, String proceName, String
									// headerName,
									// String verHeading, String horHeading) {
									// JFreeChart chart;
									// ReportsController controller = new ReportsController();
									// try {
									// List<String[]> resultList = controller.fetchReportsData(paramMap,
									// proceName);
									// chart = ChartFactory.createPieChart(
									// headerName, // chart title
									// createPieDataset(resultList), // data
									// true, // include legend
									// true,
									// false
									// );
									//
									// final PiePlot plot = (PiePlot) chart.getPlot();
									//		        
									// TextTitle texttitle = chart.getTitle();
									// texttitle.setFont(new Font("Arial", Font.BOLD, 15));
									// texttitle.setBorder(0.5D, 0.5D, 0.5D, 0.5D);
									// texttitle.setPaint(new Color(51, 51, 51));
									// texttitle.setBackgroundPaint(new GradientPaint(0.0F, 0.0F,
									// new Color(230, 230, 230), 350.0F, 0.0F, new Color(230, 230,
									// 230)));
									// texttitle.setExpandToFitSpace(true);
									// texttitle.setPadding(5, 5, 5, 5);
									// chart.setBackgroundPaint(new GradientPaint(0.0F, 0.0F, new Color(
									// 242, 242, 242), 350F, 0.0F, new Color(242, 242, 242)));
									// chart.setBorderPaint(new Color(187, 187, 197));
									// chart.setBorderStroke(new BasicStroke(1.0F));
									// chart.setBorderVisible(true);
									// plot.setNoDataMessage("NO DATA!");
									// plot.setBackgroundPaint(null);
									// plot.setInsets(new RectangleInsets(10D, 5D, 5D, 5D));
									// plot.setOutlinePaint(new Color(221, 221, 221));
									// plot.setCircular(false);
									// plot.setStartAngle(290);
									// plot.setDirection(Rotation.CLOCKWISE);
									// plot.setForegroundAlpha(0.5f);
									// plot.setLabelGap(0.02);
									// plot.setLabelGenerator(new StandardPieSectionLabelGenerator());
									//		        
									// String userHome = System.getProperty("jboss.server.home.dir");
									// final ChartRenderingInfo info = new ChartRenderingInfo(
									// new StandardEntityCollection());
									// final File file1 = new File(userHome +
									// "/deploy"+request.getContextPath()+".war/images/"
									// + chartName + ".png");
									// ChartUtilities.saveChartAsPNG(file1, chart, 300, 250, info);
									// }catch (Exception e) {
									// }
									//		
									// }

									// private PieDataset createPieDataset(List<String[]> resultList) {
									//	        
									// final DefaultPieDataset result = new DefaultPieDataset();
									// for (String[] strings : resultList) {
									// result.setValue(strings[2], new Double(strings[0]));
									// }
									// /*
									// * Testing Purpose
									// 
									// // result.setValue("SGE", new Double(11245));
									// // result.setValue("SHERIFF", new Double(11245));
									// // result.setValue("BSG", new Double(11245));
									// return result;
									//	        
									// }

									public String getContentPath() {
										return contentPath;
									}

									public void setContentPath(String contentPath) {
										this.contentPath = contentPath;
									}

									public String getChartName() {
										return chartName;
									}

									public void setChartName(String chartName) {
										this.chartName = chartName;
									}

									public Short getGraphDomainId() {
										return graphDomainId;
									}

									public void setGraphDomainId(Short graphDomainId) {
										this.graphDomainId = graphDomainId;
									}

									public List<String> getGraphList() {
										return graphList;
									}

									public void setGraphList(List<String> graphList) {
										this.graphList = graphList;
									}
									public List<String> getGameList() {
										return gameList;
									}

									public void setGameList(List<String> gameList) {
										this.gameList = gameList;
									}

									public String getVendorCode() {
										return vendorCode;
									}

									public void setVendorCode(String vendorCode) {
										this.vendorCode = vendorCode;
									}
								}
		}
														
						}else if(proceName.equals("getSLEWagerAndWinning")){
							
							if(resultMap.containsKey(strArr[0])){
								List<String> str=new ArrayList<String>();
								str.add(strArr[1]);
								str.add(strArr[2]);
								resultMap.put(strArr[0], str);
							}
														
						}else if(proceName.equals("getSGEWagerAndWinning")){
							
							if(resultMap.containsKey(strArr[0])){
								List<String> str=new ArrayList<String>();
								str.add(strArr[1]);
								str.add(strArr[2]);
								resultMap.put(strArr[0], str);
							}
														
						}else if(proceName.equals("getRUMMYWagerAndWinning")){
							
							if(resultMap.containsKey(strArr[0])){
								List<String> str=new ArrayList<String>();
								str.add(strArr[1]);
								str.add(strArr[2]);
								resultMap.put(strArr[0], str);
							}
														
						}else if(proceName.equals("getPOKERWagerAndWinning")){
							
							if(resultMap.containsKey(strArr[0])){
								List<String> str=new ArrayList<String>();
								str.add(strArr[1]);
								str.add(strArr[2]);
								resultMap.put(strArr[0], str);
							}
														
						}else if(proceName.equals("getDGEWagerAndWinning")){
							
							if(resultMap.containsKey(strArr[0])){
								List<String> str=new ArrayList<String>();
								str.add(strArr[1]);
								str.add(strArr[2]);
								resultMap.put(strArr[0], str);
							}
														
						}else if(proceName.equals("getIGEWagerAndWinning")){
							
							if(resultMap.containsKey(strArr[0])){
								List<String> str=new ArrayList<String>();
								str.add(strArr[1]);
								str.add(strArr[2]);
								resultMap.put(strArr[0], str);
							}
														
						} else if(proceName.equals("getTotalRegDayWise")) {
							String str[]= {strArr[0],strArr[1],strArr[2],strArr[3], strArr[4]};
							finalMap.put(strArr[5],str);
						} else {
							 String str[]= {strArr[0],strArr[1],strArr[2],strArr[3]};
							 finalMap.put(strArr[4],str);
						}
				}
				if (proceName.equals("getTotalBonusDayWise")) {
					stackData(resultMap,chartName, dataSet);
				} else if (proceName.equals("getTotalGameWagerDayWise")) {
					stackDataGame(finalMap,chartName, dataSet);
				} else if(proceName.equals("getTotalRegDayWise")){
					stackMapDReg(finalMap,chartName, dataSet);
				} else if(proceName.equals("getWagerAndWinningGameWise")){
					stackData(resultMap,chartName, dataSet);
				} else if(proceName.equals("getSBSWagerAndWinning")){
					stackData(resultMap,chartName, dataSet);
				} else if(proceName.equals("getSLEWagerAndWinning")){
					stackData(resultMap,chartName, dataSet);
				} else if(proceName.equals("getRUMMYWagerAndWinning")){
					stackData(resultMap,chartName, dataSet);
				}  else if(proceName.equals("getPOKERWagerAndWinning")){
					stackData(resultMap,chartName, dataSet);
				}  else if(proceName.equals("getSGEWagerAndWinning")){
					stackData(resultMap,chartName, dataSet);
				} else if(proceName.equals("getDGEWagerAndWinning")){
					stackData(resultMap,chartName, dataSet);
				} else if(proceName.equals("getIGEWagerAndWinning")){
					stackData(resultMap,chartName, dataSet);
				} else{
					stackDataMap(finalMap,chartName, dataSet);
				}
			}
			} catch (Exception e) {
			e.printStackTrace();
			}
			jsonString = gson.toJson(dataSet);
			return jsonString;
			
	}
	
	
	public String newLineChart(String chartName, String proceName){
		
		Gson gson = new Gson();
		String jsonString = null;
		ReportsController controller = new ReportsController();
		Map<String, String[]> finalMap = new LinkedHashMap<String, String[]>();
		TimeSeriesCollection dataset = new TimeSeriesCollection();
		List<String[]> resultList = null;
		
		
		
		Date dateobj = new Date();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		ArrayList<String> arrdate = new ArrayList<String>();
		for(int i=0;i<4;i++){
			String date = df.format(dateobj);
			arrdate.add(date);
			Calendar cal = Calendar.getInstance();
		    cal.setTime(dateobj);
		    cal.add(Calendar.DAY_OF_MONTH, -1);
		    dateobj = cal.getTime();
			
		}
		
		try {
			resultList = controller.fetchReportsData(paramMap, proceName);
			
			for(int i=0;i<resultList.size();i++)
			{
				String[] arr = resultList.get(i);
				if(arrdate.contains(arr[0])){
					arrdate.remove(arrdate.indexOf(arr[0]));
				}
			}
			for(int i=0; i<arrdate.size(); i++){
				
				String y[] = new String[25];
				Arrays.fill(y, "0");
				y[0] = arrdate.get(i);
				resultList.add(y);
			}
			
			
			Collections.sort(resultList,new Comparator<String[]>() {
	            public int compare(String[] strings, String[] otherStrings) {
	                return otherStrings[0].compareTo(strings[0]);
	            }
	        });
			} catch (Exception e) {
				e.printStackTrace();
			}
			jsonString = gson.toJson(resultList);
			return jsonString;
	}
	
	public String newBarChart(String chartName, String proceName){

		//JFreeChart chart;
		String jsonString = null;
		Gson gson = new Gson();
		DefaultCategoryDataset dataSet = new DefaultCategoryDataset();
		ReportsController controller = new ReportsController();
		Map<String , List<String>> resultMap= new HashMap<>();
		List<String> dateList = new ArrayList<>();
		
		try {
			List<String[]> resultList = controller.fetchReportsData(paramMap,
					proceName);
			if (!resultList.isEmpty()) {
				if("getTotalNgrDayWise".equals(proceName)) {
					String sysDate = "";
					List<String> defaultData = new ArrayList<>();
					defaultData.add("0");
					for (int i = 1; i <= 7; i++) {
						sysDate = Utility.getServerDate(-(i), 0, 0, "YYYY-MM-dd");
						resultMap.put(sysDate, defaultData);
					}
				
					for(String[] strArr : resultList) {
						List<String> str=new ArrayList<>();
						str.add(strArr[1]);
						resultMap.put(strArr[0], str);
					}
					stackDataNgr(resultMap,chartName, dataSet);
				}else {
					for (String[] strArr : resultList) {
						    dateList.add(strArr[0]);
						    dateList.add(strArr[1]);
						    dateList.add(strArr[2]);
						    dateList.add(strArr[3]);
						    dateList.add(strArr[4]);
						    dateList.add(strArr[5]);
						    dateList.add(strArr[6]);
					}
					setDataInList(dateList, dataSet,chartName);
				
				}
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		jsonString = gson.toJson(dataSet);
		return jsonString;
	}
	
	public void barChart(String chartName, String proceName, String headerName,
			String verHeading, String horHeading,int width, int height ) {
		JFreeChart chart;
		DefaultCategoryDataset dataSet = new DefaultCategoryDataset();
		ReportsController controller = new ReportsController();
		List<String> dateList = new ArrayList<String>();
		try {
			List<String[]> resultList = controller.fetchReportsData(paramMap,
					proceName);
			double count = 0;
			double currMonth = 0;
			double lastMonth = 0;
			if (resultList.size() != 0) {
				for (String[] strArr : resultList) {
					    dateList.add(strArr[0]);
					    dateList.add(strArr[1]);
					    dateList.add(strArr[2]);
					    dateList.add(strArr[3]);
					    dateList.add(strArr[4]);
					    dateList.add(strArr[5]);
					    dateList.add(strArr[6]);
						count = count + Double.valueOf(strArr[7].equals("--")?"0":strArr[7]);
						currMonth  += Double.valueOf(strArr[8].equals("--")?"0":strArr[8]);
						lastMonth += Double.valueOf(strArr[9].equals("--")?"0":strArr[9]);
				}
				setDataInList(dateList, dataSet,chartName);
			}
			NumberFormat number = NumberFormat.getNumberInstance(Locale.US);
			chart = ChartFactory.createBarChart3D(headerName, null, verHeading,
					dataSet, PlotOrientation.VERTICAL, false, true, false);

			TextTitle texttitle = chart.getTitle();
			texttitle.setFont(new Font("Arial", Font.BOLD, 15));
			texttitle.setBorder(0.5D, 0.5D, 0.5D, 0.5D);
			texttitle.setPaint(new Color(51, 51, 51));
			texttitle.setBackgroundPaint(new GradientPaint(0.0F, 0.0F,
					new Color(230, 230, 230), 350.0F, 0.0F, new Color(230, 230,
							230)));
			texttitle.setExpandToFitSpace(true);
			texttitle.setPadding(5, 5, 5, 5);
			chart.setBackgroundPaint(new GradientPaint(0.0F, 0.0F, new Color(
					242, 242, 242), 350F, 0.0F, new Color(242, 242, 242)));
			chart.setBorderPaint(new Color(187, 187, 197));
			chart.setBorderStroke(new BasicStroke(1.0F));
			chart.setBorderVisible(true);
			CategoryPlot categoryplot = (CategoryPlot) chart.getPlot();
			categoryplot.setNoDataMessage("NO DATA!");
			categoryplot.setBackgroundPaint(null);
			categoryplot.setInsets(new RectangleInsets(10D, 5D, 5D, 5D));
			categoryplot.setOutlinePaint(new Color(221, 221, 221));
			categoryplot.setDomainGridlinePaint(new Color(221, 221, 221));
			categoryplot.setDomainGridlineStroke(new BasicStroke(1.0F));
			categoryplot.setDomainGridlinesVisible(true);
			categoryplot.setRangeGridlinePaint(new Color(221, 221, 221));
			categoryplot.setRangeGridlineStroke(new BasicStroke(1.0F));
			NumberAxis numberaxis = (NumberAxis) categoryplot.getRangeAxis();
			CategoryAxis domainAxis = categoryplot.getDomainAxis();
			domainAxis.setTickLabelFont(new Font("Arial", Font.PLAIN,8));
			domainAxis.setLabelFont(new Font("Arial", Font.PLAIN, 8));
			numberaxis.setTickLabelFont(new Font("Arial", Font.PLAIN, 10));
			numberaxis.setLabelFont(new Font("Arial", Font.PLAIN, 10));

			Paint apaint[] = createPaint();
			CustomBarRenderer custombarrenderer = new CustomBarRenderer(apaint);
			custombarrenderer.setDrawBarOutline(false);
			custombarrenderer
					.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
			custombarrenderer.setBaseItemLabelsVisible(true);
			custombarrenderer.setItemLabelAnchorOffset(5D);
			custombarrenderer.setShadowVisible(false);
			custombarrenderer.setBarPainter(new StandardBarPainter());
			custombarrenderer.setMaximumBarWidth(0.200000000000000000D);
			custombarrenderer.setBasePositiveItemLabelPosition(new ItemLabelPosition(ItemLabelAnchor.CENTER, TextAnchor.CENTER, TextAnchor.CENTER, (3*Math.PI)/2));

			numberaxis
					.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
			numberaxis.setTickMarkPaint(Color.black);
			numberaxis.setLowerMargin(0.14999999999999999D);
			numberaxis.setUpperMargin(0.14999999999999999D);
			categoryplot.setRenderer(custombarrenderer);
			String currTime = String.valueOf(Calendar.getInstance().getTimeInMillis());
			saveImageFile(chartName+currTime, chart, width, height, true);
			String dirPath = System.getProperty("jboss.home.url").split(":")[1]+"bin/WeaverFiles/"+chartName+currTime+".png";
			BufferedImage bufferedImage = new BufferedImage(width, (height+51),BufferedImage.TYPE_INT_RGB);
			Graphics2D graphic = (Graphics2D)bufferedImage.createGraphics();
			Image  img = new ImageIcon(dirPath).getImage();
			graphic.drawImage(img, 0, 0, null);
			graphic.setStroke(new BasicStroke(1));
			int x = 0;
			for (int i=0; i<3; i++) {
				graphic.setColor(new Color(230, 230, 230));
				graphic.fillRect(x,height,100,25);
				graphic.setColor(new Color(187, 187, 197));
				graphic.drawRect(x,height, 100,25);
				graphic.setColor(new Color(255, 255, 255));
				graphic.fillRect(x,(height+25),100,25);
				graphic.setColor(new Color(187, 187, 197));
				graphic.drawRect(x,(height+25), 100,25);
		    	x=x+100;
			}
		    String[] value = {"Current Month", number.format((int)currMonth),"Last Month",number.format((int)lastMonth), "Total",
					 number.format((int)count) };
		    graphic.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
		            RenderingHints.VALUE_ANTIALIAS_ON); 
		    x = 0;
			for (int i = 0; i < value.length; i++) {
				graphic.setColor(new Color(0, 0, 0));
				graphic.setFont(new Font("Bitstream Vera Sans", Font.PLAIN, 11));
				drawCenteredString(value[i], 100, 25, x, height, graphic);
				graphic.setColor(new Color(106, 106, 106));
				drawCenteredString(value[++i], 100, 25, x, (height+25), graphic);
				x = x + 100;
			}
			graphic.dispose();
		    saveImageFile(bufferedImage, chartName, dirPath);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void drawCenteredString(String s, int w, int h, int wi, int hi, Graphics2D graphic) {
		    FontMetrics fm = graphic.getFontMetrics();
		    int x = (w - fm.stringWidth(s)) / 2;
		    int y = (fm.getAscent() + (h - (fm.getAscent() + fm.getDescent())) / 2);
		    graphic.drawString(s, wi+x, hi+y);
		  }
	
	 private void saveImageFile(BufferedImage bufferedImage, String chartName, String dirPath) throws IOException, PMSException {
			final File file1 = new File(dirPath);
			ImageIO.write(bufferedImage, "png", file1);			
			Utility.saveOrUpdateGraphContent(file1, chartName+".png", selectDomainName+"/boImage");
			file1.delete();
		}

	 public void setDataInList(List<String> dateList,DefaultCategoryDataset dataSet,String chartName) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		for(int i=6; i>=0;i--){
			Calendar c = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.DATE, -i);
		    String newDate= sdf.format(c.getTime());
		    String result= dateList.get(i);
		    String[] dateArr = newDate.split("-");
		    if(result!=null) {
				dataSet.setValue(Double.valueOf(result.equals("--")?"0":result),
						chartName, dateArr[2] + "/" + dateArr[1]);
		    }else{
				dataSet.setValue(0D, chartName, dateArr[2] + "/"
						+ dateArr[1]);
		    }
		}
	}

	private void lineChart(String chartName, String proceName,
			String headerName, String verHeading, String horHeading, int width, int height) {
		ReportsController controller = new ReportsController();
		Map<String, String[]> finalMap = new LinkedHashMap<String, String[]>();
		TimeSeriesCollection dataset = new TimeSeriesCollection();
		List<String[]> resultList = null;
		try {
			resultList = controller.fetchReportsData(paramMap, proceName);
			if (resultList.size() != 0) {
				for (String[] strArr : resultList) {
					String str[] = { strArr[1], strArr[2], strArr[3],
							strArr[4], strArr[5], strArr[6], strArr[7],
							strArr[8], strArr[9], strArr[10], strArr[11],
							strArr[12], strArr[13], strArr[14], strArr[15],
							strArr[16], strArr[17], strArr[18], strArr[19],
							strArr[20], strArr[21], strArr[22], strArr[23],
							strArr[24] };
					finalMap.put(strArr[0], str);
				}
			}
			lineStackData(finalMap, dataset);
			JFreeChart chart = ChartFactory.createTimeSeriesChart(headerName,
					null, verHeading, dataset, true, true, false);
			TextTitle texttitle = chart.getTitle();
			texttitle.setFont(new Font("Arial", Font.BOLD, 15));
			texttitle.setBorder(0.5D, 0.5D, 0.5D, 0.5D);
			texttitle.setPaint(new Color(51, 51, 51));
			texttitle.setBackgroundPaint(new GradientPaint(0.0F, 0.0F,
					new Color(230, 230, 230), 350.0F, 0.0F, new Color(230, 230,
							230)));
			texttitle.setExpandToFitSpace(true);
			texttitle.setPadding(5, 5, 5, 5);
			chart.setBackgroundPaint(new GradientPaint(0.0F, 0.0F, new Color(
					242, 242, 242), 350F, 0.0F, new Color(242, 242, 242)));
			chart.setBorderPaint(new Color(187, 187, 197));
			chart.setBorderStroke(new BasicStroke(1.0F));
			chart.setBorderVisible(true);
			XYPlot categoryplot = (XYPlot) chart.getPlot();
			XYItemRenderer xyRender = categoryplot.getRenderer();
			
			xyRender.setSeriesPaint(0, Color.ORANGE);
			xyRender.setSeriesPaint(1, Color.pink);
			xyRender.setSeriesPaint(2, Color.MAGENTA);
			xyRender.setSeriesPaint(3, Color.BLACK);
			
	
			xyRender.setSeriesStroke(0, new BasicStroke(1.5f));
			xyRender.setSeriesStroke(1, new BasicStroke(1.5f));
			xyRender.setSeriesStroke(2, new BasicStroke(1.5f));
			xyRender.setSeriesStroke(3, new BasicStroke(3));
			
			
			categoryplot.mapDatasetToRangeAxis(0,0);
			categoryplot.setNoDataMessage("NO DATA!");
			categoryplot.setBackgroundPaint(null);
			categoryplot.setOutlinePaint(new Color(221, 221, 221));
			categoryplot.setDomainGridlinePaint(new Color(221, 221, 221));
			categoryplot.setDomainGridlineStroke(new BasicStroke(1.0F));
			categoryplot.setDomainGridlinesVisible(true);
			categoryplot.setRangeGridlinePaint(new Color(221, 221, 221));
			categoryplot.setRangeGridlineStroke(new BasicStroke(1.0F));
			NumberAxis numberaxis = (NumberAxis) categoryplot.getRangeAxis();
			numberaxis.setAutoRangeIncludesZero(true);
			ValueAxis domainAxis = categoryplot.getDomainAxis();
			
			domainAxis.setTickLabelFont(new Font("Arial", Font.PLAIN, 8));
			domainAxis.setLabelFont(new Font("Arial", Font.PLAIN, 8));
			numberaxis.setTickLabelFont(new Font("Arial", Font.PLAIN, 10));
			numberaxis.setLabelFont(new Font("Arial", Font.PLAIN, 10));
			chart.getLegend().setItemFont(new Font("Arial", Font.PLAIN, 9));
			numberaxis.setLowerMargin(0.14999999999999999D);
			numberaxis.setUpperMargin(0.14999999999999999D);
			saveImageFile(chartName, chart, width, height, false);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void lineStackData(Map<String, String[]> resultMap,TimeSeriesCollection dataset) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		TimeSeries series = null;
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		String currDate = sdf.format(cal.getTime());
		int currHour = cal.get(Calendar.HOUR_OF_DAY);
		for (int i = 3; i >=0; i--) {
			Calendar c = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.DATE, -i);
			String newDate = sdf.format(c.getTime());
			String[] result = resultMap.get(newDate);
			series = new TimeSeries(newDate);
			Hour hour = new Hour(0, new Day());
			if (result != null) {
				series.add(hour, 0D);
				if (currDate.equals(newDate)) {
					for (int j = 0; j < result.length; j++) {
						hour = (Hour) hour.next();
						if (hour.getHour()!=0 && currHour >= hour.getHour())
							series.add(hour, Double.valueOf(result[j]));
						else
							series.add(hour, null);
					}
				} else {
					for (int j = 0; j < result.length; j++) {
						hour = (Hour) hour.next();
						series.add(hour, Double.valueOf(result[j]));
					}
				}
			} else {
				for (int j = 0; j < 24; j++) {
					hour = (Hour) hour.next();
					series.add(hour, 0D);
				}
			}
			dataset.addSeries(series);
		}
	}
	
	private void stackedBarChartDemo(String chartName, String proceName,
			String headerName, String verHeading, String horHeading) {
		DefaultCategoryDataset dataSet = new DefaultCategoryDataset();
		ReportsController controller = new ReportsController();
		Map<String , List<String>> resultMap= new HashMap<String, List<String>>();
		Map<String ,String[]> finalMap= new LinkedHashMap<String, String[]>();
		try {
			List<String[]> resultList = controller.fetchReportsData(paramMap,
					proceName);
			if (resultList.size() != 0) {
				for (String[] strArr : resultList) {
						if (proceName.equals("getTotalBonusDayWise")) {
							List<String> str=new ArrayList<String>();
							str.add(strArr[0]);
							str.add(strArr[1]);
							resultMap.put(strArr[2], str);
						} else if(proceName.equals("getTotalRegDayWise")) {
							String str[]= {strArr[0],strArr[1],strArr[2],strArr[3], strArr[4]};
							finalMap.put(strArr[5],str);
						} else {
							 String str[]= {strArr[0],strArr[1],strArr[2],strArr[3]};
							 finalMap.put(strArr[4],str);
						}
				}
				if (proceName.equals("getTotalBonusDayWise")) {
					stackData(resultMap,chartName, dataSet);
				} else if (proceName.equals("getTotalGameWagerDayWise")) {
					stackDataGame(finalMap,chartName, dataSet);
				} else if(proceName.equals("getTotalRegDayWise")){
					stackMapDReg(finalMap,chartName, dataSet);
				} else{
					stackDataMap(finalMap,chartName, dataSet);
				}
			}
			JFreeChart chart = ChartFactory.createBarChart3D(headerName, null,
					verHeading, dataSet, PlotOrientation.VERTICAL, true, true,
					false);
			CategoryPlot categoryplot = (CategoryPlot) chart.getPlot();
			TextTitle texttitle = chart.getTitle();
			texttitle.setFont(new Font("Arial", Font.BOLD, 15));
			texttitle.setBorder(0.5D, 0.5D, 0.5D, 0.5D);
			texttitle.setPaint(new Color(51, 51, 51));
			texttitle.setBackgroundPaint(new GradientPaint(0.0F, 0.0F,
					new Color(230, 230, 230), 350.0F, 0.0F, new Color(230, 230,
							230)));
			texttitle.setExpandToFitSpace(true);
			texttitle.setPadding(5, 5, 5, 5);
			chart.setBackgroundPaint(new GradientPaint(0.0F, 0.0F, new Color(
					242, 242, 242), 350F, 0.0F, new Color(242, 242, 242)));
			chart.setBorderPaint(new Color(187, 187, 197));
			chart.setBorderStroke(new BasicStroke(1.0F));
			chart.setBorderVisible(true);
			categoryplot.setNoDataMessage("NO DATA!");
			categoryplot.setBackgroundPaint(null);
			categoryplot.setOutlinePaint(new Color(221, 221, 221));
			categoryplot.setDomainGridlinePaint(new Color(221, 221, 221));
			categoryplot.setDomainGridlineStroke(new BasicStroke(1.0F));
			categoryplot.setDomainGridlinesVisible(true);
			categoryplot.setRangeGridlinePaint(new Color(221, 221, 221));
			categoryplot.setRangeGridlineStroke(new BasicStroke(1.0F));
			NumberAxis numberaxis = (NumberAxis) categoryplot.getRangeAxis();
			CategoryAxis domainAxis = categoryplot.getDomainAxis();
			domainAxis.setTickLabelFont(new Font("Arial", Font.PLAIN, 8));
			domainAxis.setLabelFont(new Font("Arial", Font.PLAIN, 8));
			numberaxis.setTickLabelFont(new Font("Arial", Font.PLAIN, 10));
			numberaxis.setLabelFont(new Font("Arial", Font.PLAIN, 10));
			chart.getLegend().setItemFont(new Font("Arial", Font.PLAIN, 9));
			ExtendedStackedBarRenderer custombarrenderer = new ExtendedStackedBarRenderer();
			paintColor(custombarrenderer);
			custombarrenderer.setDrawBarOutline(false);
			custombarrenderer.setBaseItemLabelsVisible(true);
			custombarrenderer
					.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
			custombarrenderer.setShadowVisible(false);
			custombarrenderer.setBarPainter(new StandardBarPainter());
			custombarrenderer.setMaximumBarWidth(0.150000000000000000D);
			numberaxis
					.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
			numberaxis.setTickMarkPaint(Color.black);
			categoryplot.setRenderer(custombarrenderer);
			numberaxis.setLowerMargin(0.14999999999999999D);
			numberaxis.setUpperMargin(0.14999999999999999D);
			saveImageFile(chartName, chart, 300, 250, false);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
   private void stackDataGame(Map<String, String[]> resultMap,String chartName,DefaultCategoryDataset dataSet) {
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		for(int i=6; i>=0;i--){
			Calendar c = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.DATE, -i);
		    String newDate= sdf.format(c.getTime());
		    String[] result=resultMap.get(newDate);
		    String[] dateArr = newDate.split("-");
		    if(result!=null)
		    {
		    	    dataSet.setValue(Double.valueOf(result[0]),
			    	    		"SGE", dateArr[2] + "/" + dateArr[1]);
			    	dataSet.setValue(Double.valueOf(result[1]),
			    	    		"IGE", dateArr[2] + "/" + dateArr[1]);
			    	 dataSet.setValue(Double.valueOf(result[2]),
			    	    		"SHERIFF", dateArr[2] + "/" + dateArr[1]);
			    	 dataSet.setValue(Double.valueOf(result[3]),
			    	    		"BSG", dateArr[2] + "/" + dateArr[1]);
		       
		    } else {
				dataSet.setValue(0D, "SGE", dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(0D, "IGE", dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(0D, "SHERIFF", dateArr[2] + "/" + dateArr[1]);
				dataSet.spackage com.stpl.pms.action.bo.reports;

import java.awt.BasicStroke;

public class ReportChart extends BaseActionSupport{

	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger.getLogger(ReportChart.class);
	private Map<String, String> paramMap = new HashMap<String, String>() ;
	private String contentPath;
	private String chartName;
	private Short graphDomainId;
	private String selectDomainName;
	private List<String> graphList;
	private List<String> gameList;
	private String vendorCode;
    static class CustomBarRenderer extends BarRenderer {

		private static final long serialVersionUID = 1L;
		private Paint colors[];

		public Paint getItemPaint(int i, int j) {
			return colors[j % colors.length];
		}

		public CustomBarRenderer(Paint apaint[]) {
			colors = apaint;
		}
	}

	public void generateNewChartabc(){
//		newGeneratePieChart();
	}
	
	public String getImagePath() throws PMSException{
//		CommonMethodController commonMethodController = CommonMethodController.getInstance();
//		if("DOMAIN".equals(userInfoBean.getUserType()))
//			domainName= commonMethodController.getDmProperty(userInfoBean.getDomainId(),
//						"domainName");
//		contentPath =  CommonMethodController.getInstance().fetchSystemProperties("COMMON_CONTENT_PATH");
//		domainMap = CommonMethodController.getInstance().getDomainIdMap();
//		return SUCCESS;
	}
	
	public void generatePieChart() {
		try {
			logger.info("--generatePieChart--");
			short graphMasterDomainId;			
			CommonMethodController commonMethodController = CommonMethodController.getInstance();
			if (userInfoBean != null
					&& "DOMAIN".equals(userInfoBean.getUserType())) {
				paramMap.put("domainId", userInfoBean.getDomainId().toString());
				paramMap.put("reportCurrency",
						commonMethodController.getDmProperty(userInfoBean
								.getDomainId(), "currencyId"));
				graphMasterDomainId=userInfoBean.getDomainId();
				selectDomainName = commonMethodController.getDmProperty(userInfoBean.getDomainId(),
						"domainName");
				
			} else if(userInfoBean != null  && "BO".equals(userInfoBean.getUserType()) && graphDomainId!=null ){
				paramMap.put("domainId", graphDomainId.toString());
				paramMap.put("reportCurrency",
						commonMethodController.getDmProperty(graphDomainId, "currencyId"));
				graphMasterDomainId=graphDomainId;
				selectDomainName = commonMethodController.getDmProperty(graphDomainId,
						"domainName");
			}else {
				paramMap.put("domainId", "0");
				paramMap.put("reportCurrency", commonMethodController
						.fetchSystemProperties("NATIVE_CURRENCY"));
				graphMasterDomainId=1;
				selectDomainName="All";
			}
			ReportsController repController = new ReportsController();
			Object[] obj = repController.getGraphUpdateTime(chartName,graphMasterDomainId).get(0);
			if ((Calendar.getInstance().getTimeInMillis() - ((Timestamp)(obj[1])).getTime()) / 60000 >= (Long)(obj[0])) {
				callChart(chartName);
				repController.updateGraphTime(chartName,graphMasterDomainId);
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void callChart (String chartName){
		if("getTotalRegDayWise".equals(chartName)) {
		 	stackedBarChartDemo(chartName, "getTotalRegDayWise",
					"Daily New Registration", "No. Of Registration", "Day");
		} else if("getTotalDepAmtDayWise".equals(chartName)) {
			 barChart(chartName, "getTotalDepAmtDayWise",
					 "Daily Deposits ", "Amount", "Day", 301, 200);
		} else if("getTotalWithDrawDayWise".equals(chartName)) {
			 barChart(chartName, "getTotalWithDrawDayWise",
					 "Daily WithDrawal Request", "Amount", "Day", 301, 200);
		} else if("getTotalRummyWagerDayWise".equals(chartName)) {
			barChart(chartName, "getTotalRummyWagerDayWise",
					 "Daily Rummy Wager", "Amount", "Day", 301, 200);
		} else if("getTotalPokerWagerDayWise".equals(chartName)) {
			barChart(chartName, "getTotalPokerWagerDayWise",
					 "Daily Poker Wager", "Amount", "Day", 301, 200);
		} else if("getTotalDepRequestStatus".equals(chartName)) {
			 stackedBarChartDemo(chartName,
					 "getTotalDepRequestStatus", "Daily Deposit Request Status",
					 "No. of Req", "Day");
		} else if("getTotalBonusDayWise".equals(chartName)) {
			 stackedBarChartDemo(chartName, "getTotalBonusDayWise",
					 "Daily Bonus Status", "Amount", "Day");
		} else if("getRummyWagerDayWise".equals(chartName)) {
			lineChart(chartName, "getRummyWagerDayWise",
					"Rummy Wager Day Wise", "Amount", "Time", 620,250);
		} else if("getSLEWagerDayWise".equals(chartName)) {
			lineChart(chartName, "getSLEWagerDayWise",
					"SLE Wager Day Wise", "Amount", "Time", 620,250);
		} else if("getSGEWagerDayWise".equals(chartName)) {
			lineChart(chartName, "getSGEWagerDayWise",
					"SGE Wager Day Wise", "Amount", "Time", 620,250);
		} else if("getIGEWagerDayWise".equals(chartName)) {
			lineChart(chartName, "getIGEWagerDayWise",
					"IGE Wager Day Wise", "Amount", "Time", 620,250);
		} else if("getDGEWagerDayWise".equals(chartName)) {
			lineChart(chartName, "getDGEWagerDayWise",
					"DGE Wager Day Wise", "Amount", "Time", 620,250);
		} else if("getRUMMYWagerDayWise".equals(chartName)) {
			lineChart(chartName, "getRUMMYWagerDayWise",
					"RUMMY Wager Day Wise", "Amount", "Time", 620,250);
		} else if("getPOKERWagerDayWise".equals(chartName)) {
			lineChart(chartName, "getPOKERWagerDayWise",
					"POKER Wager Day Wise", "Amount", "Time", 620,250);
		} else if("getSBSWagerDayWise".equals(chartName)) {
			lineChart(chartName, "getSBSWagerDayWise",
					"SBS Wager Day Wise", "Amount", "Time", 620,250);
		} else if("getRummyWagerHourWise".equals(chartName)) {
			lineChart(chartName, "getRummyWagerHourWise",
					"Rummy Wager Hour Wise", "Amount", "Time", 942,300);
		} else if("getTotalNgrIgeDayWise".equals(chartName)) {
			barChart(chartName, "getTotalNgrIgeDayWise",
					 "Daily IGE NGR", "Amount", "Day", 301, 200);
		} else if("getTotalNgrSlotDayWise".equals(chartName)) {
			barChart(chartName, "getTotalNgrSlotDayWise",
					 "Daily SLOT NGR", "Amount", "Day", 301, 200);
		} else if("getTotalNgrDayWise".equals(chartName)) {
			barChart(chartName, "getTotalNgrDayWise",
					 "Total Daily  NGR", "Amount", "Day", 301, 200);
		}   
		
	}

	private static Paint[] createPaint() {
		Paint apaint[] = new Paint[2];
		apaint[0] = new GradientPaint(0.0F, 0.0F, new Color(134, 181, 69),
				0.0F, 0.0F, new Color(134, 181, 69));
		apaint[1] = new GradientPaint(0.0F, 0.0F, new Color(105, 151, 236),
				0.0F, 0.0F, new Color(105, 151, 236));
		return apaint;
	}

	
	
	public void newGeneratePieChart(){
		try {
			logger.info("--generatePieChart--"+chartName);
			short graphMasterDomainId;			
			CommonMethodController commonMethodController = CommonMethodController.getInstance();
			if (userInfoBean != null
					&& "DOMAIN".equals(userInfoBean.getUserType())) {
				paramMap.put("domainId", userInfoBean.getDomainId().toString());
				paramMap.put("reportCurrency",
						commonMethodController.getDmProperty(userInfoBean
								.getDomainId(), "currencyId"));
				graphMasterDomainId=userInfoBean.getDomainId();
				selectDomainName = commonMethodController.getDmProperty(userInfoBean.getDomainId(),
						"domainName");
				
			} else if(userInfoBean != null  && "BO".equals(userInfoBean.getUserType()) && graphDomainId!=null ){
				paramMap.put("domainId", graphDomainId.toString());
				paramMap.put("reportCurrency",
						commonMethodController.getDmProperty(graphDomainId, "currencyId"));
				graphMasterDomainId=graphDomainId;
				selectDomainName = commonMethodController.getDmProperty(graphDomainId,
						"domainName");
			}else {
				paramMap.put("domainId", "0");
				paramMap.put("reportCurrency", commonMethodController
						.fetchSystemProperties("NATIVE_CURRENCY"));
				graphMasterDomainId=1;
				selectDomainName="All";
			}
			ReportsController repController = new ReportsController();
			repController.getGraphUpdateTime(chartName,graphMasterDomainId).get(0);
				newCallChart(graphMasterDomainId);
				repController.updateGraphTime(chartName,graphMasterDomainId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	public String getChartData(String typeChart, short graphMasterDomainId){
		String data = null;
		ReportsController repController = null;
		int refreshtime = 1;
		try{
			repController = new ReportsController();
			refreshtime = repController.getGraphRefreshTime(chartName,graphMasterDomainId);
		}catch(Exception e){
			e.printStackTrace();
		}
		Cache cache = CacheManager.getInstance().getCache("graphCache");
		cache.remove(("getTotalRummyRakeDayWise"+graphDomainId));
		cache.remove(("getWagerAndWinningGameWise"+graphDomainId));
		
		if(cache.get(chartName+graphDomainId)==null){
			
			switch (typeChart) {
			case "BarChart":
				data = newBarChart(chartName,chartName);
				break;
			case "LineChart":
				data = newLineChart(chartName,chartName);
				break;
			case "StackedBarChart":
				data = newStackedBarChart(chartName,chartName);
				break;	
			}
			
			Element e = new Element(chartName+graphDomainId,data);
			e.setTimeToLive(refreshtime*60);
			cache.put(e);
		}else{
			data = (String)cache.get(chartName+graphDomainId).getObjectValue();
		}
		
		return data;
	}
	
	
	public void newCallChart(short graphMasterDomainId){
		PrintWriter out = null;
		Gson gson = new Gson();
		String data = null;
		try {
			out = response.getWriter();
		}catch (IOException e) {
			e.printStackTrace();
		}catch (Exception be) {
			be.printStackTrace();
		}
		if(chartName.equals("getTotalNgrDayWise") || chartName.equals("getTotalDepAmtDayWise") || chartName.equals("getTotalRummyWagerDayWise") || chartName.equals("getTotalWithDrawDayWise") ||
				chartName.equals("getTotalPokerWagerDayWise") || chartName.equals("getTotalNgrIgeDayWise") || chartName.equals("getTotalNgrSlotDayWise")
				|| chartName.equals("getTotalRummyRakeDayWise")){
			data = getChartData("BarChart", graphMasterDomainId);
		}
		else if(chartName.equals("getRummyWagerHourWise") || chartName.equals("getRummyWagerDayWise") || chartName.equals("getSLEWagerDayWise") || chartName.equals("getSGEWagerDayWise") || chartName.equals("getIGEWagerDayWise") || chartName.equals("getDGEWagerDayWise")
				|| chartName.equals("getRUMMYWagerDayWise") || chartName.equals("getPOKERWagerDayWise") || chartName.equals("getSBSWagerDayWise")){
			data = getChartData("LineChart", graphMasterDomainId);
		}
		else if(chartName.equals("getTotalRegDayWise") || chartName.equals("getTotalDepRequestStatus") || chartName.equals("getTotalBonusDayWise") ||
				chartName.equals("getWagerAndWinningGameWise") || chartName.equals("getSBSWagerAndWinning") || chartName.equals("getSLEWagerAndWinning")|| chartName.equals("getSGEWagerAndWinning")|| chartName.equals("getDGEWagerAndWinning")|| chartName.equals("getIGEWagerAndWinning")
				|| chartName.equals("getRUMMYWagerAndWinning") || chartName.equals("getPOKERWagerAndWinning") || chartName.equals("getSBSWagerAndWinning")){
			data = getChartData("StackedBarChart", graphMasterDomainId);
		}
		out.write(data);
	}
	
	
	public String newStackedBarChart(String chartName, String proceName){
		
		Gson gson = new Gson();
		String jsonString = null;
		DefaultCategoryDataset dataSet = new DefaultCategoryDataset();
		ReportsController controller = new ReportsController();
		Map<String , List<String>> resultMap= new HashMap<String, List<String>>();
		Map<String ,String[]> finalMap= new LinkedHashMap<String, String[]>();
		try {
			if(proceName.equals("getWagerAndWinningGameWise") || proceName.equals("getSBSWagerAndWinning") || proceName.equals("getSLEWagerAndWinning")|| chartName.equals("getSGEWagerAndWinning")|| chartName.equals("getDGEWagerAndWinning") || chartName.equals("getIGEWagerAndWinning")
					|| chartName.equals("getRUMMYWagerAndWinning") || chartName.equals("getPOKERWagerAndWinning")){
				if(proceName.equals("getWagerAndWinningGameWise"))
					paramMap.put("gameType", "DGE_14");
				String sysDate="";
				List<String> defaultData =new ArrayList<>();
				defaultData.add("0");
				defaultData.add("0");
				for(int i=0;i<=6;i++){
					sysDate=Utility.getServerDate(-(i),0,0,"YYYY-MM-dd");
					resultMap.put(sysDate, defaultData);
				}
			}
			
			List<String[]> resultList = controller.fetchReportsData(paramMap,
					proceName);
			if (!resultList.isEmpty()) {
				for (String[] strArr : resultList) {
						if (proceName.equals("getTotalBonusDayWise")) {
							List<String> str=new ArrayList<String>();
							str.add(strArr[0]);
							str.add(strArr[1]);
							resultMap.put(strArr[2], str);
						}else if (proceName.equals("getWagerAndWinningGameWise")) {  // only for DGE
							
							if(resultMap.containsKey(strArr[0])){
								List<String> str=new ArrayList<String>();
								str.add(strArr[1]);
								str.add(strArr[2]);
								resultMap.put(strArr[0], str);
							}
						}else if(proceName.equals("getSBSWagerAndWinning")){
							
							if(resultMap.containsKey(strArr[0])){
								List<String> str=new ArrayList<String>();
								str.add(strArr[1]);
								str.add(strArr[2]);
								resultMap.put(strArr[0], str);
							}
														
						}else if(proceName.equals("getSLEWagerAndWinning")){
							
							if(resultMap.containsKey(strArr[0])){
								List<String> str=new ArrayList<String>();
								str.add(strArr[1]);
								str.add(strArr[2]);
								resultMap.put(strArr[0], str);
							}
														
						}else if(proceName.equals("getSGEWagerAndWinning")){
							
							if(resultMap.containsKey(strArr[0])){
								List<String> str=new ArrayList<String>();
								str.add(strArr[1]);
								str.add(strArr[2]);
								resultMap.put(strArr[0], str);
							}
														
						}else if(proceName.equals("getRUMMYWagerAndWinning")){
							
							if(resultMap.containsKey(strArr[0])){
								List<String> str=new ArrayList<String>();
								str.add(strArr[1]);
								str.add(strArr[2]);
								resultMap.put(strArr[0], str);
							}
														
						}else if(proceName.equals("getPOKERWagerAndWinning")){
							
							if(resultMap.containsKey(strArr[0])){
								List<String> str=new ArrayList<String>();
								str.add(strArr[1]);
								str.add(strArr[2]);
								resultMap.put(strArr[0], str);
							}
														
						}else if(proceName.equals("getDGEWagerAndWinning")){
							
							if(resultMap.containsKey(strArr[0])){
								List<String> str=new ArrayList<String>();
								str.add(strArr[1]);
								str.add(strArr[2]);
								resultMap.put(strArr[0], str);
							}
														
						}else if(proceName.equals("getIGEWagerAndWinning")){
							
							if(resultMap.containsKey(strArr[0])){
								List<String> str=new ArrayList<String>();
								str.add(strArr[1]);
								str.add(strArr[2]);
								resultMap.put(strArr[0], str);
							}
														
						} else if(proceName.equals("getTotalRegDayWise")) {
							String str[]= {strArr[0],strArr[1],strArr[2],strArr[3], strArr[4]};
							finalMap.put(strArr[5],str);
						} else {
							 String str[]= {strArr[0],strArr[1],strArr[2],strArr[3]};
							 finalMap.put(strArr[4],str);
						}
				}
				if (proceName.equals("getTotalBonusDayWise")) {
					stackData(resultMap,chartName, dataSet);
				} else if (proceName.equals("getTotalGameWagerDayWise")) {
					stackDataGame(finalMap,chartName, dataSet);
				} else if(proceName.equals("getTotalRegDayWise")){
					stackMapDReg(finalMap,chartName, dataSet);
				} else if(proceName.equals("getWagerAndWinningGameWise")){
					stackData(resultMap,chartName, dataSet);
				} else if(proceName.equals("getSBSWagerAndWinning")){
					stackData(resultMap,chartName, dataSet);
				} else if(proceName.equals("getSLEWagerAndWinning")){
					stackData(resultMap,chartName, dataSet);
				} else if(proceName.equals("getRUMMYWagerAndWinning")){
					stackData(resultMap,chartName, dataSet);
				}  else if(proceName.equals("getPOKERWagerAndWinning")){
					stackData(resultMap,chartName, dataSet);
				}  else if(proceName.equals("getSGEWagerAndWinning")){
					stackData(resultMap,chartName, dataSet);
				} else if(proceName.equals("getDGEWagerAndWinning")){
					stackData(resultMap,chartName, dataSet);
				} else if(proceName.equals("getIGEWagerAndWinning")){
					stackData(resultMap,chartName, dataSet);
				} else{
					stackDataMap(finalMap,chartName, dataSet);
				}
			}
			} catch (Exception e) {
			e.printStackTrace();
			}
			jsonString = gson.toJson(dataSet);
			return jsonString;
			
	}
	
	
	public String newLineChart(String chartName, String proceName){
		
		Gson gson = new Gson();
		String jsonString = null;
		ReportsController controller = new ReportsController();
		Map<String, String[]> finalMap = new LinkedHashMap<String, String[]>();
		TimeSeriesCollection dataset = new TimeSeriesCollection();
		List<String[]> resultList = null;
		
		
		
		Date dateobj = new Date();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		ArrayList<String> arrdate = new ArrayList<String>();
		for(int i=0;i<4;i++){
			String date = df.format(dateobj);
			arrdate.add(date);
			Calendar cal = Calendar.getInstance();
		    cal.setTime(dateobj);
		    cal.add(Calendar.DAY_OF_MONTH, -1);
		    dateobj = cal.getTime();
			
		}
		
		try {
			resultList = controller.fetchReportsData(paramMap, proceName);
			
			for(int i=0;i<resultList.size();i++)
			{
				String[] arr = resultList.get(i);
				if(arrdate.contains(arr[0])){
					arrdate.remove(arrdate.indexOf(arr[0]));
				}
			}
			for(int i=0; i<arrdate.size(); i++){
				
				String y[] = new String[25];
				Arrays.fill(y, "0");
				y[0] = arrdate.get(i);
				resultList.add(y);
			}
			
			
			Collections.sort(resultList,new Comparator<String[]>() {
	            public int compare(String[] strings, String[] otherStrings) {
	                return otherStrings[0].compareTo(strings[0]);
	            }
	        });
			} catch (Exception e) {
				e.printStackTrace();
			}
			jsonString = gson.toJson(resultList);
			return jsonString;
	}
	
	public String newBarChart(String chartName, String proceName){

		//JFreeChart chart;
		String jsonString = null;
		Gson gson = new Gson();
		DefaultCategoryDataset dataSet = new DefaultCategoryDataset();
		ReportsController controller = new ReportsController();
		Map<String , List<String>> resultMap= new HashMap<>();
		List<String> dateList = new ArrayList<>();
		
		try {
			List<String[]> resultList = controller.fetchReportsData(paramMap,
					proceName);
			if (!resultList.isEmpty()) {
				if("getTotalNgrDayWise".equals(proceName)) {
					String sysDate = "";
					List<String> defaultData = new ArrayList<>();
					defaultData.add("0");
					for (int i = 1; i <= 7; i++) {
						sysDate = Utility.getServerDate(-(i), 0, 0, "YYYY-MM-dd");
						resultMap.put(sysDate, defaultData);
					}
				
					for(String[] strArr : resultList) {
						List<String> str=new ArrayList<>();
						str.add(strArr[1]);
						resultMap.put(strArr[0], str);
					}
					stackDataNgr(resultMap,chartName, dataSet);
				}else {
					for (String[] strArr : resultList) {
						    dateList.add(strArr[0]);
						    dateList.add(strArr[1]);
						    dateList.add(strArr[2]);
						    dateList.add(strArr[3]);
						    dateList.add(strArr[4]);
						    dateList.add(strArr[5]);
						    dateList.add(strArr[6]);
					}
					setDataInList(dateList, dataSet,chartName);
				
				}
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		jsonString = gson.toJson(dataSet);
		return jsonString;
	}
	
	public void barChart(String chartName, String proceName, String headerName,
			String verHeading, String horHeading,int width, int height ) {
		JFreeChart chart;
		DefaultCategoryDataset dataSet = new DefaultCategoryDataset();
		ReportsController controller = new ReportsController();
		List<String> dateList = new ArrayList<String>();
		try {
			List<String[]> resultList = controller.fetchReportsData(paramMap,
					proceName);
			double count = 0;
			double currMonth = 0;
			double lastMonth = 0;
			if (resultList.size() != 0) {
				for (String[] strArr : resultList) {
					    dateList.add(strArr[0]);
					    dateList.add(strArr[1]);
					    dateList.add(strArr[2]);
					    dateList.add(strArr[3]);
					    dateList.add(strArr[4]);
					    dateList.add(strArr[5]);
					    dateList.add(strArr[6]);
						count = count + Double.valueOf(strArr[7].equals("--")?"0":strArr[7]);
						currMonth  += Double.valueOf(strArr[8].equals("--")?"0":strArr[8]);
						lastMonth += Double.valueOf(strArr[9].equals("--")?"0":strArr[9]);
				}
				setDataInList(dateList, dataSet,chartName);
			}
			NumberFormat number = NumberFormat.getNumberInstance(Locale.US);
			chart = ChartFactory.createBarChart3D(headerName, null, verHeading,
					dataSet, PlotOrientation.VERTICAL, false, true, false);

			TextTitle texttitle = chart.getTitle();
			texttitle.setFont(new Font("Arial", Font.BOLD, 15));
			texttitle.setBorder(0.5D, 0.5D, 0.5D, 0.5D);
			texttitle.setPaint(new Color(51, 51, 51));
			texttitle.setBackgroundPaint(new GradientPaint(0.0F, 0.0F,
					new Color(230, 230, 230), 350.0F, 0.0F, new Color(230, 230,
							230)));
			texttitle.setExpandToFitSpace(true);
			texttitle.setPadding(5, 5, 5, 5);
			chart.setBackgroundPaint(new GradientPaint(0.0F, 0.0F, new Color(
					242, 242, 242), 350F, 0.0F, new Color(242, 242, 242)));
			chart.setBorderPaint(new Color(187, 187, 197));
			chart.setBorderStroke(new BasicStroke(1.0F));
			chart.setBorderVisible(true);
			CategoryPlot categoryplot = (CategoryPlot) chart.getPlot();
			categoryplot.setNoDataMessage("NO DATA!");
			categoryplot.setBackgroundPaint(null);
			categoryplot.setInsets(new RectangleInsets(10D, 5D, 5D, 5D));
			categoryplot.setOutlinePaint(new Color(221, 221, 221));
			categoryplot.setDomainGridlinePaint(new Color(221, 221, 221));
			categoryplot.setDomainGridlineStroke(new BasicStroke(1.0F));
			categoryplot.setDomainGridlinesVisible(true);
			categoryplot.setRangeGridlinePaint(new Color(221, 221, 221));
			categoryplot.setRangeGridlineStroke(new BasicStroke(1.0F));
			NumberAxis numberaxis = (NumberAxis) categoryplot.getRangeAxis();
			CategoryAxis domainAxis = categoryplot.getDomainAxis();
			domainAxis.setTickLabelFont(new Font("Arial", Font.PLAIN,8));
			domainAxis.setLabelFont(new Font("Arial", Font.PLAIN, 8));
			numberaxis.setTickLabelFont(new Font("Arial", Font.PLAIN, 10));
			numberaxis.setLabelFont(new Font("Arial", Font.PLAIN, 10));

			Paint apaint[] = createPaint();
			CustomBarRenderer custombarrenderer = new CustomBarRenderer(apaint);
			custombarrenderer.setDrawBarOutline(false);
			custombarrenderer
					.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
			custombarrenderer.setBaseItemLabelsVisible(true);
			custombarrenderer.setItemLabelAnchorOffset(5D);
			custombarrenderer.setShadowVisible(false);
			custombarrenderer.setBarPainter(new StandardBarPainter());
			custombarrenderer.setMaximumBarWidth(0.200000000000000000D);
			custombarrenderer.setBasePositiveItemLabelPosition(new ItemLabelPosition(ItemLabelAnchor.CENTER, TextAnchor.CENTER, TextAnchor.CENTER, (3*Math.PI)/2));

			numberaxis
					.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
			numberaxis.setTickMarkPaint(Color.black);
			numberaxis.setLowerMargin(0.14999999999999999D);
			numberaxis.setUpperMargin(0.14999999999999999D);
			categoryplot.setRenderer(custombarrenderer);
			String currTime = String.valueOf(Calendar.getInstance().getTimeInMillis());
			saveImageFile(chartName+currTime, chart, width, height, true);
			String dirPath = System.getProperty("jboss.home.url").split(":")[1]+"bin/WeaverFiles/"+chartName+currTime+".png";
			BufferedImage bufferedImage = new BufferedImage(width, (height+51),BufferedImage.TYPE_INT_RGB);
			Graphics2D graphic = (Graphics2D)bufferedImage.createGraphics();
			Image  img = new ImageIcon(dirPath).getImage();
			graphic.drawImage(img, 0, 0, null);
			graphic.setStroke(new BasicStroke(1));
			int x = 0;
			for (int i=0; i<3; i++) {
				graphic.setColor(new Color(230, 230, 230));
				graphic.fillRect(x,height,100,25);
				graphic.setColor(new Color(187, 187, 197));
				graphic.drawRect(x,height, 100,25);
				graphic.setColor(new Color(255, 255, 255));
				graphic.fillRect(x,(height+25),100,25);
				graphic.setColor(new Color(187, 187, 197));
				graphic.drawRect(x,(height+25), 100,25);
		    	x=x+100;
			}
		    String[] value = {"Current Month", number.format((int)currMonth),"Last Month",number.format((int)lastMonth), "Total",
					 number.format((int)count) };
		    graphic.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
		            RenderingHints.VALUE_ANTIALIAS_ON); 
		    x = 0;
			for (int i = 0; i < value.length; i++) {
				graphic.setColor(new Color(0, 0, 0));
				graphic.setFont(new Font("Bitstream Vera Sans", Font.PLAIN, 11));
				drawCenteredString(value[i], 100, 25, x, height, graphic);
				graphic.setColor(new Color(106, 106, 106));
				drawCenteredString(value[++i], 100, 25, x, (height+25), graphic);
				x = x + 100;
			}
			graphic.dispose();
		    saveImageFile(bufferedImage, chartName, dirPath);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void drawCenteredString(String s, int w, int h, int wi, int hi, Graphics2D graphic) {
		    FontMetrics fm = graphic.getFontMetrics();
		    int x = (w - fm.stringWidth(s)) / 2;
		    int y = (fm.getAscent() + (h - (fm.getAscent() + fm.getDescent())) / 2);
		    graphic.drawString(s, wi+x, hi+y);
		  }
	
	 private void saveImageFile(BufferedImage bufferedImage, String chartName, String dirPath) throws IOException, PMSException {
			final File file1 = new File(dirPath);
			ImageIO.write(bufferedImage, "png", file1);			
			Utility.saveOrUpdateGraphContent(file1, chartName+".png", selectDomainName+"/boImage");
			file1.delete();
		}

	 public void setDataInList(List<String> dateList,DefaultCategoryDataset dataSet,String chartName) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		for(int i=6; i>=0;i--){
			Calendar c = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.DATE, -i);
		    String newDate= sdf.format(c.getTime());
		    String result= dateList.get(i);
		    String[] dateArr = newDate.split("-");
		    if(result!=null) {
				dataSet.setValue(Double.valueOf(result.equals("--")?"0":result),
						chartName, dateArr[2] + "/" + dateArr[1]);
		    }else{
				dataSet.setValue(0D, chartName, dateArr[2] + "/"
						+ dateArr[1]);
		    }
		}
	}

	private void lineChart(String chartName, String proceName,
			String headerName, String verHeading, String horHeading, int width, int height) {
		ReportsController controller = new ReportsController();
		Map<String, String[]> finalMap = new LinkedHashMap<String, String[]>();
		TimeSeriesCollection dataset = new TimeSeriesCollection();
		List<String[]> resultList = null;
		try {
			resultList = controller.fetchReportsData(paramMap, proceName);
			if (resultList.size() != 0) {
				for (String[] strArr : resultList) {
					String str[] = { strArr[1], strArr[2], strArr[3],
							strArr[4], strArr[5], strArr[6], strArr[7],
							strArr[8], strArr[9], strArr[10], strArr[11],
							strArr[12], strArr[13], strArr[14], strArr[15],
							strArr[16], strArr[17], strArr[18], strArr[19],
							strArr[20], strArr[21], strArr[22], strArr[23],
							strArr[24] };
					finalMap.put(strArr[0], str);
				}
			}
			lineStackData(finalMap, dataset);
			JFreeChart chart = ChartFactory.createTimeSeriesChart(headerName,
					null, verHeading, dataset, true, true, false);
			TextTitle texttitle = chart.getTitle();
			texttitle.setFont(new Font("Arial", Font.BOLD, 15));
			texttitle.setBorder(0.5D, 0.5D, 0.5D, 0.5D);
			texttitle.setPaint(new Color(51, 51, 51));
			texttitle.setBackgroundPaint(new GradientPaint(0.0F, 0.0F,
					new Color(230, 230, 230), 350.0F, 0.0F, new Color(230, 230,
							230)));
			texttitle.setExpandToFitSpace(true);
			texttitle.setPadding(5, 5, 5, 5);
			chart.setBackgroundPaint(new GradientPaint(0.0F, 0.0F, new Color(
					242, 242, 242), 350F, 0.0F, new Color(242, 242, 242)));
			chart.setBorderPaint(new Color(187, 187, 197));
			chart.setBorderStroke(new BasicStroke(1.0F));
			chart.setBorderVisible(true);
			XYPlot categoryplot = (XYPlot) chart.getPlot();
			XYItemRenderer xyRender = categoryplot.getRenderer();
			
			xyRender.setSeriesPaint(0, Color.ORANGE);
			xyRender.setSeriesPaint(1, Color.pink);
			xyRender.setSeriesPaint(2, Color.MAGENTA);
			xyRender.setSeriesPaint(3, Color.BLACK);
			
	
			xyRender.setSeriesStroke(0, new BasicStroke(1.5f));
			xyRender.setSeriesStroke(1, new BasicStroke(1.5f));
			xyRender.setSeriesStroke(2, new BasicStroke(1.5f));
			xyRender.setSeriesStroke(3, new BasicStroke(3));
			
			
			categoryplot.mapDatasetToRangeAxis(0,0);
			categoryplot.setNoDataMessage("NO DATA!");
			categoryplot.setBackgroundPaint(null);
			categoryplot.setOutlinePaint(new Color(221, 221, 221));
			categoryplot.setDomainGridlinePaint(new Color(221, 221, 221));
			categoryplot.setDomainGridlineStroke(new BasicStroke(1.0F));
			categoryplot.setDomainGridlinesVisible(true);
			categoryplot.setRangeGridlinePaint(new Color(221, 221, 221));
			categoryplot.setRangeGridlineStroke(new BasicStroke(1.0F));
			NumberAxis numberaxis = (NumberAxis) categoryplot.getRangeAxis();
			numberaxis.setAutoRangeIncludesZero(true);
			ValueAxis domainAxis = categoryplot.getDomainAxis();
			
			domainAxis.setTickLabelFont(new Font("Arial", Font.PLAIN, 8));
			domainAxis.setLabelFont(new Font("Arial", Font.PLAIN, 8));
			numberaxis.setTickLabelFont(new Font("Arial", Font.PLAIN, 10));
			numberaxis.setLabelFont(new Font("Arial", Font.PLAIN, 10));
			chart.getLegend().setItemFont(new Font("Arial", Font.PLAIN, 9));
			numberaxis.setLowerMargin(0.14999999999999999D);
			numberaxis.setUpperMargin(0.14999999999999999D);
			saveImageFile(chartName, chart, width, height, false);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void lineStackData(Map<String, String[]> resultMap,TimeSeriesCollection dataset) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		TimeSeries series = null;
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		String currDate = sdf.format(cal.getTime());
		int currHour = cal.get(Calendar.HOUR_OF_DAY);
		for (int i = 3; i >=0; i--) {
			Calendar c = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.DATE, -i);
			String newDate = sdf.format(c.getTime());
			String[] result = resultMap.get(newDate);
			series = new TimeSeries(newDate);
			Hour hour = new Hour(0, new Day());
			if (result != null) {
				series.add(hour, 0D);
				if (currDate.equals(newDate)) {
					for (int j = 0; j < result.length; j++) {
						hour = (Hour) hour.next();
						if (hour.getHour()!=0 && currHour >= hour.getHour())
							series.add(hour, Double.valueOf(result[j]));
						else
							series.add(hour, null);
					}
				} else {
					for (int j = 0; j < result.length; j++) {
						hour = (Hour) hour.next();
						series.add(hour, Double.valueOf(result[j]));
					}
				}
			} else {
				for (int j = 0; j < 24; j++) {
					hour = (Hour) hour.next();
					series.add(hour, 0D);
				}
			}
			dataset.addSeries(series);
		}
	}
	
	private void stackedBarChartDemo(String chartName, String proceName,
			String headerName, String verHeading, String horHeading) {
		DefaultCategoryDataset dataSet = new DefaultCategoryDataset();
		ReportsController controller = new ReportsController();
		Map<String , List<String>> resultMap= new HashMap<String, List<String>>();
		Map<String ,String[]> finalMap= new LinkedHashMap<String, String[]>();
		try {
			List<String[]> resultList = controller.fetchReportsData(paramMap,
					proceName);
			if (resultList.size() != 0) {
				for (String[] strArr : resultList) {
						if (proceName.equals("getTotalBonusDayWise")) {
							List<String> str=new ArrayList<String>();
							str.add(strArr[0]);
							str.add(strArr[1]);
							resultMap.put(strArr[2], str);
						} else if(proceName.equals("getTotalRegDayWise")) {
							String str[]= {strArr[0],strArr[1],strArr[2],strArr[3], strArr[4]};
							finalMap.put(strArr[5],str);
						} else {
							 String str[]= {strArr[0],strArr[1],strArr[2],strArr[3]};
							 finalMap.put(strArr[4],str);
						}
				}
				if (proceName.equals("getTotalBonusDayWise")) {
					stackData(resultMap,chartName, dataSet);
				} else if (proceName.equals("getTotalGameWagerDayWise")) {
					stackDataGame(finalMap,chartName, dataSet);
				} else if(proceName.equals("getTotalRegDayWise")){
					stackMapDReg(finalMap,chartName, dataSet);
				} else{
					stackDataMap(finalMap,chartName, dataSet);
				}
			}
			JFreeChart chart = ChartFactory.createBarChart3D(headerName, null,
					verHeading, dataSet, PlotOrientation.VERTICAL, true, true,
					false);
			CategoryPlot categoryplot = (CategoryPlot) chart.getPlot();
			TextTitle texttitle = chart.getTitle();
			texttitle.setFont(new Font("Arial", Font.BOLD, 15));
			texttitle.setBorder(0.5D, 0.5D, 0.5D, 0.5D);
			texttitle.setPaint(new Color(51, 51, 51));
			texttitle.setBackgroundPaint(new GradientPaint(0.0F, 0.0F,
					new Color(230, 230, 230), 350.0F, 0.0F, new Color(230, 230,
							230)));
			texttitle.setExpandToFitSpace(true);
			texttitle.setPadding(5, 5, 5, 5);
			chart.setBackgroundPaint(new GradientPaint(0.0F, 0.0F, new Color(
					242, 242, 242), 350F, 0.0F, new Color(242, 242, 242)));
			chart.setBorderPaint(new Color(187, 187, 197));
			chart.setBorderStroke(new BasicStroke(1.0F));
			chart.setBorderVisible(true);
			categoryplot.setNoDataMessage("NO DATA!");
			categoryplot.setBackgroundPaint(null);
			categoryplot.setOutlinePaint(new Color(221, 221, 221));
			categoryplot.setDomainGridlinePaint(new Color(221, 221, 221));
			categoryplot.setDomainGridlineStroke(new BasicStroke(1.0F));
			categoryplot.setDomainGridlinesVisible(true);
			categoryplot.setRangeGridlinePaint(new Color(221, 221, 221));
			categoryplot.setRangeGridlineStroke(new BasicStroke(1.0F));
			NumberAxis numberaxis = (NumberAxis) categoryplot.getRangeAxis();
			CategoryAxis domainAxis = categoryplot.getDomainAxis();
			domainAxis.setTickLabelFont(new Font("Arial", Font.PLAIN, 8));
			domainAxis.setLabelFont(new Font("Arial", Font.PLAIN, 8));
			numberaxis.setTickLabelFont(new Font("Arial", Font.PLAIN, 10));
			numberaxis.setLabelFont(new Font("Arial", Font.PLAIN, 10));
			chart.getLegend().setItemFont(new Font("Arial", Font.PLAIN, 9));
			ExtendedStackedBarRenderer custombarrenderer = new ExtendedStackedBarRenderer();
			paintColor(custombarrenderer);
			custombarrenderer.setDrawBarOutline(false);
			custombarrenderer.setBaseItemLabelsVisible(true);
			custombarrenderer
					.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
			custombarrenderer.setShadowVisible(false);
			custombarrenderer.setBarPainter(new StandardBarPainter());
			custombarrenderer.setMaximumBarWidth(0.150000000000000000D);
			numberaxis
					.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
			numberaxis.setTickMarkPaint(Color.black);
			categoryplot.setRenderer(custombarrenderer);
			numberaxis.setLowerMargin(0.14999999999999999D);
			numberaxis.setUpperMargin(0.14999999999999999D);
			saveImageFile(chartName, chart, 300, 250, false);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
   private void stackDataGame(Map<String, String[]> resultMap,String chartName,DefaultCategoryDataset dataSet) {
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		for(int i=6; i>=0;i--){
			Calendar c = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.DATE, -i);
		    String newDate= sdf.format(c.getTime());
		    String[] result=resultMap.get(newDate);
		    String[] dateArr = newDate.split("-");
		    if(result!=null)
		    {
		    	    dataSet.setValue(Double.valueOf(result[0]),
			    	    		"SGE", dateArr[2] + "/" + dateArr[1]);
			    	dataSet.setValue(Double.valueOf(result[1]),
			    	    		"IGE", dateArr[2] + "/" + dateArr[1]);
			    	 dataSet.setValue(Double.valueOf(result[2]),
			    	    		"SHERIFF", dateArr[2] + "/" + dateArr[1]);
			    	 dataSet.setValue(Double.valueOf(result[3]),
			    	    		"BSG", dateArr[2] + "/" + dateArr[1]);
		       
		    } else {
				dataSet.setValue(0D, "SGE", dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(0D, "IGE", dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(0D, "SHERIFF", dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(0D, "BSG", dateArr[2] + "/" + dateArr[1]);

			}
		}

	}

	public void stackData(Map<String, List<String>> resultMap,
			String chartName, DefaultCategoryDataset dataSet) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		for (int i = 6; i >= 0; i--) {
			Calendar c = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.DATE, -i);
			String newDate = sdf.format(c.getTime());
			List<String> result = resultMap.get(newDate);
			String[] dateArr = newDate.split("-");
			if (result != null) {
				dataSet.setValue(Double.valueOf(result.get(0)),
						"Total Bonus", dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(Double.valueOf(result.get(1)),
						"Convert to Cash", dateArr[2] + "/" + dateArr[1]);
			} else {
				dataSet.setValue(0D, "Total Bonus", dateArr[2] + "/"
						+ dateArr[1]);
				dataSet.setValue(0D, "Convert to Cash", dateArr[2] + "/"
						+ dateArr[1]);
			}
		}

	}
	
	public void stackDataNgr(Map<String, List<String>> resultMap,
			String chartName, DefaultCategoryDataset dataSet) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		for (int i = 7; i >= 1; i--) {
			Calendar c = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.DATE, -i);
			String newDate = sdf.format(c.getTime());
			List<String> result = resultMap.get(newDate);
			String[] dateArr = newDate.split("-");
			if (result != null) {
				dataSet.setValue(Double.valueOf(result.get(0)),
						"Total Ngr", dateArr[2] + "/" + dateArr[1]);
			} else {
				dataSet.setValue(0D, "Total Ngr", dateArr[2] + "/"
						+ dateArr[1]);
			}
		}

	}

	public void stackMapDReg(Map<String, String[]> resultMap, String chartName,
			DefaultCategoryDataset dataSet) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		for (int i = 6; i >= 0; i--) {
			Calendar c = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.DATE, -i);
			String newDate = sdf.format(c.getTime());
			String[] result = resultMap.get(newDate);
			String[] dateArr = newDate.split("-");
			if (result != null) {
				dataSet.setValue(Double.valueOf(result[0]), "DIRECT",
						dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(Double.valueOf(result[1]), "PPC",
						dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(Double.valueOf(result[2]), "REFER FRIEND",
						dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(Double.valueOf(result[3]), "OLA", dateArr[2]
						+ "/" + dateArr[1]);
				dataSet.setValue(Double.valueOf(result[4]), "AFFILIATE", dateArr[2]
						+ "/" + dateArr[1]);
				
			} else {
				dataSet.setValue(0D, "DIRECT", dateArr[2] + "/" + dateArr[1]);
				dataSet
						.setValue(0D, "PPC", dateArr[2] + "/"
								+ dateArr[1]);
				dataSet.setValue(0D, "REFER FRIEND", dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(0D, "OLA", dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(0D, "AFFILIATE", dateArr[2] + "/" + dateArr[1]);
			}
		}
	}
	
	public void stackDataMap(Map<String, String[]> resultMap, String chartName,
			DefaultCategoryDataset dataSet) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		for (int i = 6; i >= 0; i--) {
			Calendar c = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.DATE, -i);
			String newDate = sdf.format(c.getTime());
			String[] result = resultMap.get(newDate);
			String[] dateArr = newDate.split("-");
			if (result != null) {
				dataSet.setValue(Double.valueOf(result[0]), "PENDING",
						dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(Double.valueOf(result[1]), "INITIATED",
						dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(Double.valueOf(result[2]), "FAILED",
						dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(Double.valueOf(result[3]), "DONE", dateArr[2]
						+ "/" + dateArr[1]);

			} else {
				dataSet.setValue(0D, "PENDING", dateArr[2] + "/" + dateArr[1]);
				dataSet
						.setValue(0D, "INITIATED", dateArr[2] + "/"
								+ dateArr[1]);
				dataSet.setValue(0D, "FAILED", dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(0D, "DONE", dateArr[2] + "/" + dateArr[1]);
			}
		}

	}

	public static void paintColor(StackedBarRenderer custombarrenderer) {
		Paint p1 = new GradientPaint(0.0f, 0.0f, new Color(63, 124, 236), 0.0f,
				0.0f, new Color(63, 124, 236));
		custombarrenderer.setSeriesPaint(4, p1);

		Paint p2 = new GradientPaint(0.0f, 0.0f, new Color(136, 193, 56), 0.0f,
				0.0f, new Color(136, 193, 56));
		custombarrenderer.setSeriesPaint(3, p2);

		Paint p3 = new GradientPaint(0.0f, 0.0f, new Color(240, 218, 28), 0.0f,
				0.0f, new Color(240, 218, 28));
		custombarrenderer.setSeriesPaint(1, p3);

		Paint p4 = new GradientPaint(0.0f, 0.0f, new Color(85, 227, 253), 0.0f,
				0.0f, new Color(85, 227, 253));
		custombarrenderer.setSeriesPaint(0, p4);
		Paint p5 = new GradientPaint(0.0f, 0.0f, new Color(252, 94, 94), 0.0f,
				0.0f, new Color(252, 94, 94));
		custombarrenderer.setSeriesPaint(2, p5);
	}

	private void saveImageFile(String chartName, JFreeChart chart, int width, int height, boolean isTemp) throws IOException, PMSException {
		final ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
		chartName=chartName+".png";
		final File file1 = new File("WeaverFiles/"+ chartName);
		ChartUtilities.saveChartAsPNG(file1, chart, width, height, info);
		
		if(!isTemp) {			
			Utility.saveOrUpdateGraphContent(file1, chartName, selectDomainName+"/boImage");
			file1.delete();
		}
	}
	
	public String getActiveGraphList() {
		try {
			graphList = new ReportsController().getActiveGraphNames(domainId);
		} catch (Exception e) {
			addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
		}
		return SUCCESS;
	}
	
	public String getActiveGameWiseGraphList() {
		try {
	   		gameList = new ReportsController().getActiveGraphNames(domainId);
		} catch (Exception e) {
			addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
		}
		return SUCCESS;
	}
	// private void pieChart(String chartName, String proceName, String
	// headerName,
	// String verHeading, String horHeading) {
	// JFreeChart chart;
	// ReportsController controller = new ReportsController();
	// try {
	// List<String[]> resultList = controller.fetchReportsData(paramMap,
	// proceName);
	// chart = ChartFactory.createPieChart(
	// headerName, // chart title
	// createPieDataset(resultList), // data
	// true, // include legend
	// true,
	// false
	// );
	//
	// final PiePlot plot = (PiePlot) chart.getPlot();
	//		        
	// TextTitle texttitle = chart.getTitle();
	// texttitle.setFont(new Font("Arial", Font.BOLD, 15));
	// texttitle.setBorder(0.5D, 0.5D, 0.5D, 0.5D);
	// texttitle.setPaint(new Color(51, 51, 51));
	// texttitle.setBackgroundPaint(new GradientPaint(0.0F, 0.0F,
	// new Color(230, 230, 230), 350.0F, 0.0F, new Color(230, 230,
	// 230)));
	// texttitle.setExpandToFitSpace(true);
	// texttitle.setPadding(5, 5, 5, 5);
	// chart.setBackgroundPaint(new GradientPaint(0.0F, 0.0F, new Color(
	// 242, 242, 242), 350F, 0.0F, new Color(242, 242, 242)));
	// chart.setBorderPaint(new Color(187, 187, 197));
	// chart.setBorderStroke(new BasicStroke(1.0F));
	// chart.setBorderVisible(true);
	// plot.setNoDataMessage("NO DATA!");
	// plot.setBackgroundPaint(null);
	// plot.setInsets(new RectangleInsets(10D, 5D, 5D, 5D));
	// plot.setOutlinePaint(new Color(221, 221, 221));
	// plot.setCircular(false);
	// plot.setStartAngle(290);
	// plot.setDirection(Rotation.CLOCKWISE);
	// plot.setForegroundAlpha(0.5f);
	// plot.setLabelGap(0.02);
	// plot.setLabelGenerator(new StandardPieSectionLabelGenerator());
	//		        
	// String userHome = System.getProperty("jboss.server.home.dir");
	// final ChartRenderingInfo info = new ChartRenderingInfo(
	// new StandardEntityCollection());
	// final File file1 = new File(userHome +
	// "/deploy"+request.getContextPath()+".war/images/"
	// + chartName + ".png");
	// ChartUtilities.saveChartAsPNG(file1, chart, 300, 250, info);
	// }catch (Exception e) {
	// }
	//		
	// }

	// private PieDataset createPieDataset(List<String[]> resultList) {
	//	        
	// final DefaultPieDataset result = new DefaultPieDataset();
	// for (String[] strings : resultList) {
	// result.setValue(strings[2], new Double(strings[0]));
	// }
	// /*
	// * Testing Purpose
	// 
	// // result.setValue("SGE", new Double(11245));
	// // result.setValue("SHERIFF", new Double(11245));
	// // result.setValue("BSG", new Double(11245));
	// return result;
	//	        
	// }

	public String getContentPath() {
		return contentPath;
	}

	public void setContentPath(String contentPath) {
		this.contentPath = contentPath;
	}

	public String getChartName() {
		return chartName;
	}

	public void setChartName(String chartName) {
		this.chartName = chartName;
	}

	public Short getGraphDomainId() {
		return graphDomainId;
	}

	public void setGraphDomainId(Short graphDomainId) {
		this.graphDomainId = graphDomainId;
	}

	public List<String> getGraphList() {
		return graphList;
	}

	public void setGraphList(List<String> graphList) {
		this.graphList = graphList;
	}
	public List<String> getGameList() {
		return gameList;
	}

	public void setGameList(List<String> gameList) {
		this.gameList = gameList;
	}

	public String getVendorCode() {
		return vendorCode;
	}

	public void setVendorCode(String vendorCode) {
		this.vendorCode = vendorCode;
	}
}
etValue(0D, "BSG", dateArr[2] + "/" + dateArr[1]);

			}
		}

	}

	public void stackData(Map<String, List<String>> resultMap,
			String chartName, DefaultCategoryDataset dataSet) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		for (int i = 6; i >= 0; i--) {
			Calendar c = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.DATE, -i);
			String newDate = sdf.format(c.getTime());
			List<String> result = resultMap.get(newDate);
			String[] dateArr = newDate.split("-");
			if (result != null) {
				dataSet.setValue(Double.valueOf(result.get(0)),
						"Total Bonus", dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(Double.valueOf(result.get(1)),
						"Convert to Cash", dateArr[2] + "/" + dateArr[1]);
			} else {
				dataSet.setValue(0D, "Total Bonus", dateArr[2] + "/"
						+ dateArr[1]);
				dataSet.setValue(0D, "Convert to Cash", dateArr[2] + "/"
						+ dateArr[1]);
			}
		}

	}
	
	public void stackDataNgr(Map<String, List<String>> resultMap,
			String chartName, DefaultCategoryDataset dataSet) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		for (int i = 7; i >= 1; i--) {
			Calendar c = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.DATE, -i);
			String newDate = sdf.format(c.getTime());
			List<String> result = resultMap.get(newDate);
			String[] dateArr = newDate.split("-");
			if (result != null) {
				dataSet.setValue(Double.valueOf(result.get(0)),
						"Total Ngr", dateArr[2] + "/" + dateArr[1]);
			} else {
				dataSet.setValue(0D, "Total Ngr", dateArr[2] + "/"
						+ dateArr[1]);
			}
		}

	}

	public void stackMapDReg(Map<String, String[]> resultMap, String chartName,
			DefaultCategoryDataset dataSet) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		for (int i = 6; i >= 0; i--) {
			Calendar c = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.DATE, -i);
			String newDate = sdf.format(c.getTime());
			String[] result = resultMap.get(newDate);
			String[] dateArr = newDate.split("-");
			if (result != null) {
				dataSet.setValue(Double.valueOf(result[0]), "DIRECT",
						dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(Double.valueOf(result[1]), "PPC",
						dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(Double.valueOf(result[2]), "REFER FRIEND",
						dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(Double.valueOf(result[3]), "OLA", dateArr[2]
						+ "/" + dateArr[1]);
				dataSet.setValue(Double.valueOf(result[4]), "AFFILIATE", dateArr[2]
						+ "/" + dateArr[1]);
				
			} else {
				dataSet.setValue(0D, "DIRECT", dateArr[2] + "/" + dateArr[1]);
				dataSet
						.setValue(0D, "PPC", dateArr[2] + "/"
								+ dateArr[1]);
				dataSet.setValue(0D, "REFER FRIEND", dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(0D, "OLA", dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(0D, "AFFILIATE", dateArr[2] + "/" + dateArr[1]);
			}
		}
	}
	
	public void stackDataMap(Map<String, String[]> resultMap, String chartName,
			DefaultCategoryDataset dataSet) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		for (int i = 6; i >= 0; i--) {
			Calendar c = Calendar.getInstance();
			c.setTime(new Date());
			c.add(Calendar.DATE, -i);
			String newDate = sdf.format(c.getTime());
			String[] result = resultMap.get(newDate);
			String[] dateArr = newDate.split("-");
			if (result != null) {
				dataSet.setValue(Double.valueOf(result[0]), "PENDING",
						dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(Double.valueOf(result[1]), "INITIATED",
						dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(Double.valueOf(result[2]), "FAILED",
						dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(Double.valueOf(result[3]), "DONE", dateArr[2]
						+ "/" + dateArr[1]);

			} else {
				dataSet.setValue(0D, "PENDING", dateArr[2] + "/" + dateArr[1]);
				dataSet
						.setValue(0D, "INITIATED", dateArr[2] + "/"
								+ dateArr[1]);
				dataSet.setValue(0D, "FAILED", dateArr[2] + "/" + dateArr[1]);
				dataSet.setValue(0D, "DONE", dateArr[2] + "/" + dateArr[1]);
			}
		}

	}

	public static void paintColor(StackedBarRenderer custombarrenderer) {
		Paint p1 = new GradientPaint(0.0f, 0.0f, new Color(63, 124, 236), 0.0f,
				0.0f, new Color(63, 124, 236));
		custombarrenderer.setSeriesPaint(4, p1);

		Paint p2 = new GradientPaint(0.0f, 0.0f, new Color(136, 193, 56), 0.0f,
				0.0f, new Color(136, 193, 56));
		custombarrenderer.setSeriesPaint(3, p2);

		Paint p3 = new GradientPaint(0.0f, 0.0f, new Color(240, 218, 28), 0.0f,
				0.0f, new Color(240, 218, 28));
		custombarrenderer.setSeriesPaint(1, p3);

		Paint p4 = new GradientPaint(0.0f, 0.0f, new Color(85, 227, 253), 0.0f,
				0.0f, new Color(85, 227, 253));
		custombarrenderer.setSeriesPaint(0, p4);
		Paint p5 = new GradientPaint(0.0f, 0.0f, new Color(252, 94, 94), 0.0f,
				0.0f, new Color(252, 94, 94));
		custombarrenderer.setSeriesPaint(2, p5);
	}

	private void saveImageFile(String chartName, JFreeChart chart, int width, int height, boolean isTemp) throws IOException, PMSException {
		final ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
		chartName=chartName+".png";
		final File file1 = new File("WeaverFiles/"+ chartName);
		ChartUtilities.saveChartAsPNG(file1, chart, width, height, info);
		
		if(!isTemp) {			
			Utility.saveOrUpdateGraphContent(file1, chartName, selectDomainName+"/boImage");
			file1.delete();
		}
	}
	
	public String getActiveGraphList() {
		try {
			graphList = new ReportsController().getActiveGraphNames(domainId);
		} catch (Exception e) {
			addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
		}
		return SUCCESS;
	}
	
	public String getActiveGameWiseGraphList() {
		try {
	   		gameList = new ReportsController().getActiveGraphNames(domainId);
		} catch (Exception e) {
			addActionError(PMSErrorMessage.GEN_SOME_INTERNAL_ERROR);
		}
		return SUCCESS;
	}
	// private void pieChart(String chartName, String proceName, String
	// headerName,
	// String verHeading, String horHeading) {
	// JFreeChart chart;
	// ReportsController controller = new ReportsController();
	// try {
	// List<String[]> resultList = controller.fetchReportsData(paramMap,
	// proceName);
	// chart = ChartFactory.createPieChart(
	// headerName, // chart title
	// createPieDataset(resultList), // data
	// true, // include legend
	// true,
	// false
	// );
	//
	// final PiePlot plot = (PiePlot) chart.getPlot();
	//		        
	// TextTitle texttitle = chart.getTitle();
	// texttitle.setFont(new Font("Arial", Font.BOLD, 15));
	// texttitle.setBorder(0.5D, 0.5D, 0.5D, 0.5D);
	// texttitle.setPaint(new Color(51, 51, 51));
	// texttitle.setBackgroundPaint(new GradientPaint(0.0F, 0.0F,
	// new Color(230, 230, 230), 350.0F, 0.0F, new Color(230, 230,
	// 230)));
	// texttitle.setExpandToFitSpace(true);
	// texttitle.setPadding(5, 5, 5, 5);
	// chart.setBackgroundPaint(new GradientPaint(0.0F, 0.0F, new Color(
	// 242, 242, 242), 350F, 0.0F, new Color(242, 242, 242)));
	// chart.setBorderPaint(new Color(187, 187, 197));
	// chart.setBorderStroke(new BasicStroke(1.0F));
	// chart.setBorderVisible(true);
	// plot.setNoDataMessage("NO DATA!");
	// plot.setBackgroundPaint(null);
	// plot.setInsets(new RectangleInsets(10D, 5D, 5D, 5D));
	// plot.setOutlinePaint(new Color(221, 221, 221));
	// plot.setCircular(false);
	// plot.setStartAngle(290);
	// plot.setDirection(Rotation.CLOCKWISE);
	// plot.setForegroundAlpha(0.5f);
	// plot.setLabelGap(0.02);
	// plot.setLabelGenerator(new StandardPieSectionLabelGenerator());
	//		        
	// String userHome = System.getProperty("jboss.server.home.dir");
	// final ChartRenderingInfo info = new ChartRenderingInfo(
	// new StandardEntityCollection());
	// final File file1 = new File(userHome +
	// "/deploy"+request.getContextPath()+".war/images/"
	// + chartName + ".png");
	// ChartUtilities.saveChartAsPNG(file1, chart, 300, 250, info);
	// }catch (Exception e) {
	// }
	//		
	// }

	// private PieDataset createPieDataset(List<String[]> resultList) {
	//	        
	// final DefaultPieDataset result = new DefaultPieDataset();
	// for (String[] strings : resultList) {
	// result.setValue(strings[2], new Double(strings[0]));
	// }
	// /*
	// * Testing Purpose
	// 
	// // result.setValue("SGE", new Double(11245));
	// // result.setValue("SHERIFF", new Double(11245));
	// // result.setValue("BSG", new Double(11245));
	// return result;
	//	        
	// }

	public String getContentPath() {
		return contentPath;
	}

	public void setContentPath(String contentPath) {
		this.contentPath = contentPath;
	}

	public String getChartName() {
		return chartName;
	}

	public void setChartName(String chartName) {
		this.chartName = chartName;
	}

	public Short getGraphDomainId() {
		return graphDomainId;
	}

	public void setGraphDomainId(Short graphDomainId) {
		this.graphDomainId = graphDomainId;
	}

	public List<String> getGraphList() {
		return graphList;
	}

	public void setGraphList(List<String> graphList) {
		this.graphList = graphList;
	}
	public List<String> getGameList() {
		return gameList;
	}

	public void setGameList(List<String> gameList) {
		this.gameList = gameList;
	}

	public String getVendorCode() {
		return vendorCode;
	}

	public void setVendorCode(String vendorCode) {
		this.vendorCode = vendorCode;
	}

*/