package com.stpl.pms.action.bo.um;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.URL;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.itextpdf.html2pdf.ConverterProperties;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.html2pdf.resolver.font.DefaultFontProvider;
import com.itextpdf.layout.font.FontProvider;
import com.stpl.pms.controller.gl.GameLobbyController;
import com.stpl.pms.hibernate.factory.HibernateSessionFactory;
import com.stpl.pms.hibernate.mapping.StDmDomainAliasNameMaster;
import com.stpl.pms.javabeans.ItemBean;
import com.stpl.pms.javabeans.VoucherBean;
import com.stpl.pms.struts.common.BaseActionSupport;
import com.stpl.pms.utility.SendSMS;

@SuppressWarnings("serial")
public class TMSalesMgmtAction extends BaseActionSupport implements ServletRequestAware, ServletResponseAware {
	private HttpServletRequest servletRequest;
	private HttpServletResponse servletResponse;
	private List<String> particularsList;
	private List<String> employeeUnderList;
	private List<String> partyAccName;
	private List<String> salesAccountList;
	private int salesNo;
	private String var;
	private List<String> salesStockItemList;
	private List<String> goDownList;
	private VoucherBean voucherBean;
	// create payment fields
	private String salesNoVoucher;
	private String referenceNo;
	private String employeeUnder;
	private String partyAcc;
	private String salesAccount;
	private String salesStockItems;
	private String amount;
	private String Qty;
	private String rate;
	private String currBalance;
	private String igstItem;
	private String igstItemAmt;
	private String unit;
	private String goDown;
	private String narration;
	private String hiddenBatchApplicable;
	private String hiddenBatchNumber;
	private String hiddenMfgDate;
	private String hiddenExpDate;
	private String hiddenExpAlert;
	private String hiddenExpAlertDate;
	private String hcrdr;
	private String totalAmt;
	private String partyName;
	private String paymentDate;
	private List<ItemBean> itemBeans;
	private String SOId;
	private String partyAccNameSO;
	private String orderNo;
	private String itemName;
	private String status;
	private String consignee;
	private String Dname;
	private String propName;
	private String contact;
	private String address;
	private String gstnNo;
	private String ddn;
	private String tn;
	private String des;
	private String billt;
	private String vn;
	private String transportFreight;
	private String activeVoucherNumber;
	private String partyOldBalance;
	private String checkOverDueRem;
	// sale order doc upload
	private File docPicture;
	private String docPictureContentType;
	private String docPictureFileName;

	private File docPictureDD;
	private String docPictureDDContentType;
	private String docPictureDDFileName;

	private File docPictureTB;
	private String docPictureTBContentType;
	private String docPictureTBFileName;
	private String superCashEligible;
	private String isLastApproval;
	private String rejectReason;
	private String localFrieght;
	private String loadUnloadCharge;
	private String loadUnloadCharge1;
	private String loadCharge;
	private String unloadCharge;

	public String convertToIndianCurrency(String num) {
		BigDecimal bd = new BigDecimal(num);
		long number = bd.longValue();
		long no = bd.longValue();
		int decimal = (int) (bd.remainder(BigDecimal.ONE).doubleValue() * 100);
		int digits_length = String.valueOf(no).length();
		int i = 0;
		ArrayList<String> str = new ArrayList<String>();
		HashMap<Integer, String> words = new HashMap<Integer, String>();
		words.put(0, "");
		words.put(1, "One");
		words.put(2, "Two");
		words.put(3, "Three");
		words.put(4, "Four");
		words.put(5, "Five");
		words.put(6, "Six");
		words.put(7, "Seven");
		words.put(8, "Eight");
		words.put(9, "Nine");
		words.put(10, "Ten");
		words.put(11, "Eleven");
		words.put(12, "Twelve");
		words.put(13, "Thirteen");
		words.put(14, "Fourteen");
		words.put(15, "Fifteen");
		words.put(16, "Sixteen");
		words.put(17, "Seventeen");
		words.put(18, "Eighteen");
		words.put(19, "Nineteen");
		words.put(20, "Twenty");
		words.put(30, "Thirty");
		words.put(40, "Forty");
		words.put(50, "Fifty");
		words.put(60, "Sixty");
		words.put(70, "Seventy");
		words.put(80, "Eighty");
		words.put(90, "Ninety");
		String digits[] = { "", "Hundred", "Thousand", "Lakh", "Crore" };
		while (i < digits_length) {
			int divider = (i == 2) ? 10 : 100;
			number = no % divider;
			no = no / divider;
			i += divider == 10 ? 1 : 2;
			if (number > 0) {
				int counter = str.size();
				String plural = (counter > 0 && number > 9) ? "s" : "";
				String tmp = (number < 21) ? words.get(Integer.valueOf((int) number)) + " " + digits[counter] + plural
						: words.get(Integer.valueOf((int) Math.floor(number / 10) * 10)) + " "
								+ words.get(Integer.valueOf((int) (number % 10))) + " " + digits[counter] + plural;
				str.add(tmp);
			} else {
				str.add("");
			}
		}

		Collections.reverse(str);
		String Rupees = String.join(" ", str).trim();

		String paise = (decimal) > 0
				? " And Paise " + words.get(Integer.valueOf((int) (decimal - decimal % 10))) + " "
						+ words.get(Integer.valueOf((int) (decimal % 10)))
				: "";
		return "Rupees " + Rupees + paise + " Only";
	}

	public void getAvgRateItem() throws IOException{
		GameLobbyController controller = new GameLobbyController();
		String avgRate = controller.getAvgItemRateByName(itemName);
		servletResponse.getWriter().write(""+avgRate);
		
	}
	public void generatePDFDocument() throws IOException{
		GameLobbyController controller = new GameLobbyController();
		StDmDomainAliasNameMaster aliasMaster = null;
		String itemString = "";
		String templaterStr = null;
		Map<String, String> emailContentMap = new HashMap<String, String>();
		String firmGSTN = controller.getFirmGSTN(partyAcc);
		String underEmp = controller.getUnderEmpNameOrderBySale(orderNo);
		String superCash="";
		boolean isSuperCash = controller.getIsSuperCashSaleOrder(orderNo);
		if(isSuperCash) {
			superCash = "(SuperCash)";
		}
		emailContentMap.put("BillToName", partyAcc);
		emailContentMap.put("BillToContact", controller.getPropContact(partyAcc));
		emailContentMap.put("TransportName", tn);
		emailContentMap.put("VehicleNumber", vn);
		emailContentMap.put("DeliveryLocation", des);
		emailContentMap.put("UnderEmp", underEmp);
		emailContentMap.put("DeliveryDate", paymentDate);
		emailContentMap.put("orderNumber", orderNo);
		emailContentMap.put("orderDate", paymentDate);
		emailContentMap.put("totalAmount", totalAmt);
		emailContentMap.put("BillToGSTN", firmGSTN != null ? firmGSTN : "");
		emailContentMap.put("totalAmountWords", convertToIndianCurrency(totalAmt));
		emailContentMap.put("supercash", superCash);
		BufferedReader br = null;
		try {
			String filePath = ServletActionContext.getServletContext().getRealPath("/");

			aliasMaster = controller.getAliasMaster();
			final String FONTS = aliasMaster.getPublicUrl() + "/KrutiDev.ttf";

			br = new BufferedReader(new InputStreamReader(
					new URL(aliasMaster.getPublicUrl() + "/approval_sale_bill_ofsuppy.html").openStream()));
			String line;
			StringBuffer template = new StringBuffer("");
			while ((line = br.readLine()) != null)
				template.append(line);
			templaterStr = template.toString();

			String[] breakItem = salesStockItems.split(",");
			String[] qtyItem = Qty.split(",");
			String[] priceItem = rate.split(",");
			String[] unitItem = unit.split(",");
			String[] amountItem = amount.split(",");
			String[] igstItemBreak = igstItem.split(",");
			String[] igstItemAmtBreak = igstItemAmt.split(",");
			int sno = 1;
			for (int i = 0; i < breakItem.length; i++) {
				if (breakItem[i] == null || breakItem[i].equals("-1") || breakItem[i].equals(" -1")
						|| breakItem[i].isEmpty())
					continue;
				String hsnCode = controller.getHSNCodeByItemName(breakItem[i].trim()) != null
						? controller.getHSNCodeByItemName(breakItem[i].trim())
						: "";
				List<String> bulkUnitNumber = controller.getBulkUnitNumberByItem(breakItem[i].trim());
				String name = "", bulkBag = "1";
				if (bulkUnitNumber != null && !bulkUnitNumber.isEmpty() && bulkUnitNumber.size() > 0)
					name = bulkUnitNumber.get(0) != null ? bulkUnitNumber.get(0) : "";
				if (bulkUnitNumber != null && !bulkUnitNumber.isEmpty() && bulkUnitNumber.size() > 0)
					bulkBag = bulkUnitNumber.get(1) != null ? bulkUnitNumber.get(1) : "1";
				Double tempSoln = Double.valueOf(qtyItem[i]) / Double.valueOf(bulkBag.isEmpty() ? "1" : bulkBag);
				Double gst = controller.getGSTByItemName(breakItem[i].trim());
				Double amountAfterGST = (Double.valueOf(amountItem[i]) * gst) / 100;
				emailContentMap.put("cgsttotalAmount", String.valueOf(amountAfterGST / 2));
				emailContentMap.put("sgsttotalAmount", String.valueOf(amountAfterGST / 2));
				
				itemString += "<tr><td id='company_billTo_contact_pdf'>" + sno
						+ "</td><td id='company_billTo_contact_pdf'>" + breakItem[i]
						+ "</td><td id='company_billTo_contact_pdf'>" + hsnCode
						+ "</td><td id='company_billTo_contact_pdf'>" + qtyItem[i]
						+ "</td><td id='company_billTo_contact_pdf'>₹ " + priceItem[i]
						+ "</td><td id='company_billTo_contact_pdf'>" + unitItem[i]
						+ "</td><td id='company_billTo_contact_pdf'>" + tempSoln + " " + name		
						+ "</td><td id='company_billTo_contact_pdf'>₹ "
						+ amountItem[i] + "</td><td id='company_billTo_contact_pdf'>" + igstItemBreak[i]
						+ "</td><td id='company_billTo_contact_pdf'>₹ " + igstItemAmtBreak[i] + "</td></tr>";
			}
			for (Map.Entry<String, String> entry : emailContentMap.entrySet())
				templaterStr = templaterStr.replaceAll("\\{\\s*" + entry.getKey() + "\\s*,\\s*fallback\\s*=\\}",
						entry.getValue() != null ? entry.getValue() : "");
		
			templaterStr = templaterStr.replaceAll("\\{\\s*" + "itemTableData" + "\\s*,\\s*fallback\\s*=\\}",
					itemString);
			ConverterProperties properties = new ConverterProperties();
			FontProvider fontProvider = new DefaultFontProvider();
			fontProvider.addDirectory(FONTS);
			properties.setFontProvider(fontProvider);
			HtmlConverter.convertToPdf(templaterStr,
					new FileOutputStream(filePath + "sale_order_" + orderNo + "_bill.pdf"));
			servletResponse.getWriter().write(aliasMaster.getPublicUrl() + "" + "sale_order_" + orderNo + "_bill.pdf");

		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			br.close();
		}

	}
	
	
	public void generateCreditNotePDFDocumentReport() throws IOException{
		GameLobbyController controller = new GameLobbyController();
		StDmDomainAliasNameMaster aliasMaster = null;
		String itemString = "";
		String templaterStr = null;
		Map<String, String> emailContentMap = new HashMap<String, String>();
		partyAcc = controller.getPartyAccountByVoucherCreditNote(salesNoVoucher);
		tn = controller.getTransportNameByVoucherCreditNote(salesNoVoucher);
		vn = controller.getVehicalNumberByVoucherCreditNote(salesNoVoucher);
		des = controller.getDestinationByVoucherCreditNote(salesNoVoucher);
		paymentDate = controller.getPaymentDateByVoucherCreditNote(salesNoVoucher);
		totalAmt = controller.getTotalAmountByVoucherCreditNote(salesNoVoucher);
		salesStockItems = controller.getSaleStockItemsByVoucherCreditNote(salesNoVoucher);
		Qty = controller.getSaleStockQtyByVoucherCreditNote(salesNoVoucher);
		rate = controller.getSaleStockQtyRateByVoucherCreditNote(salesNoVoucher);
		amount = controller.getSaleStockQtyAmtByVoucherCreditNote(salesNoVoucher);
		String underEmp = controller.getUnderEmpNameByCreditNote(salesNoVoucher);
		unit = "";
		igstItem = "";
		igstItemAmt = "";
		String orderNumber = controller.getOrderNumber(salesNoVoucher);
		String orderDate = controller.getOrderDate(orderNumber);
		String firmGSTN = controller.getFirmGSTN(partyAcc);
		emailContentMap.put("BillToName", partyAcc);
		emailContentMap.put("BillToContact", controller.getPropContact(partyAcc));
		emailContentMap.put("TransportName", tn);
		emailContentMap.put("VehicleNumber", vn);
		emailContentMap.put("DeliveryDate", controller.getCreditNoteDeliveryDate(salesNoVoucher));
		emailContentMap.put("DeliveryLocation", des);
		emailContentMap.put("UnderEmp", underEmp);
		emailContentMap.put("BillNumber", salesNoVoucher);
		emailContentMap.put("BillDate", paymentDate);
		emailContentMap.put("orderNumber", orderNumber);
		emailContentMap.put("orderDate", orderDate);
		emailContentMap.put("totalAmount", totalAmt);
		emailContentMap.put("BillToGSTN", firmGSTN);
		emailContentMap.put("totalAmountWords", convertToIndianCurrency(totalAmt));
		BufferedReader br =null;
		try {
			String filePath = ServletActionContext.getServletContext().getRealPath("/");

			aliasMaster = controller.getAliasMaster();
			final String FONTS = aliasMaster.getPublicUrl() + "/KrutiDev.ttf";

			br = new BufferedReader(new InputStreamReader(
					new URL(aliasMaster.getPublicUrl() + "/approval_cn_bill_generate_ledger_report.html")
							.openStream()));
			String line;
			StringBuffer template = new StringBuffer("");
			while ((line = br.readLine()) != null)
				template.append(line);
			templaterStr = template.toString();

			String[] breakItem = salesStockItems.split(",");
			String[] qtyItem = Qty.split(",");
			String[] priceItem = rate.split(",");
			//String[] unitItem = unit.split(",");
			String[] amountItem = amount.split(",");
			//String[] igstItemBreak = igstItem.split(",");
			//String[] igstItemAmtBreak = igstItemAmt.split(",");

			String batchNo = controller.getBatchNumberByCreditNoteNo(salesNoVoucher);
			String[] itemBatchBreak = batchNo.split(",");
			Double amountAfterGST = 0.0;
			
			int sno = 1;
			for (int i = 0; i < breakItem.length; i++) {
				if (breakItem[i] == null || breakItem[i].equals("-1") || breakItem[i].equals(" -1")
						|| breakItem[i].isEmpty())
					continue;
				String hsnCode = controller.getHSNCodeByItemName(breakItem[i].trim()) != null
						? controller.getHSNCodeByItemName(breakItem[i].trim())
						: "";
				List<String> mfgExp = controller.getMfgExpDateByItemName(breakItem[i].trim());
				String mfg = "";
				String exp = "";
				if (mfgExp != null && mfgExp.size() > 0 && !mfgExp.isEmpty()) {
					mfg = mfgExp.get(0) != null ? mfgExp.get(0) : "";
					exp = mfgExp.get(1) != null ? mfgExp.get(1) : "";
					mfg = mfg.replaceAll("00:00", "");
					exp = exp.replaceAll("00:00", "");

				}
				List<String> bulkUnitNumber = controller.getBulkUnitNumberByItem(breakItem[i].trim());
				String name = "", bulkBag = "1";
				if (bulkUnitNumber != null && !bulkUnitNumber.isEmpty() && bulkUnitNumber.size() > 0)
					name = bulkUnitNumber.get(0) != null ? bulkUnitNumber.get(0) : "";
				if (bulkUnitNumber != null && !bulkUnitNumber.isEmpty() && bulkUnitNumber.size() > 0)
					bulkBag = bulkUnitNumber.get(1) != null ? bulkUnitNumber.get(1) : "1";
				Double tempSoln = Double.valueOf(qtyItem[i]) / Double.valueOf(bulkBag.isEmpty() ? "1" : bulkBag);
				String itemUnit = controller.getItemUnitByName(breakItem[i].trim());
				Double gst = controller.getGSTByItemName(breakItem[i].trim());
				 amountAfterGST = amountAfterGST + (Double.valueOf(amountItem[i]) * gst) / 100;
				 Double tempAmountAfterGST = (Double.valueOf(amountItem[i]) * gst) / 100;
				itemString += "<tr><td id='company_billTo_contact_pdf'>" + sno
						+ "</td><td id='company_billTo_contact_pdf'>" + breakItem[i] + "<br>(" + itemBatchBreak[i]
						+ ")<br>(MFG-" + mfg + ",EXP-" + exp + ")</td><td id='company_billTo_contact_pdf'>" + hsnCode
						+ "</td><td id='company_billTo_contact_pdf'>" + qtyItem[i]
						+ "</td><td id='company_billTo_contact_pdf'>₹ " + priceItem[i]
						+ "</td><td id='company_billTo_contact_pdf'>" + itemUnit
						+ "</td><td id='company_billTo_contact_pdf'>" + tempSoln + " " + name
						+ "</td><td id='company_billTo_contact_pdf'>₹ " + amountItem[i]
						+ "</td><td id='company_billTo_contact_pdf'>" + gst+" %"
						+ "</td><td id='company_billTo_contact_pdf'>₹ " + tempAmountAfterGST + "</td></tr>";
				sno++;
			}
			emailContentMap.put("cgsttotalAmount", String.valueOf(amountAfterGST / 2));
			emailContentMap.put("sgsttotalAmount", String.valueOf(amountAfterGST / 2));
		

			for (Map.Entry<String, String> entry : emailContentMap.entrySet())
				templaterStr = templaterStr.replaceAll("\\{\\s*" + entry.getKey() + "\\s*,\\s*fallback\\s*=\\}",
						entry.getValue() != null ? entry.getValue() : "");

			templaterStr = templaterStr.replaceAll("\\{\\s*" + "itemTableData" + "\\s*,\\s*fallback\\s*=\\}",
					itemString);
			ConverterProperties properties = new ConverterProperties();
			FontProvider fontProvider = new DefaultFontProvider();
			fontProvider.addDirectory(FONTS);
			properties.setFontProvider(fontProvider);
			String temp = salesNoVoucher.replaceAll("/", "_");
			HtmlConverter.convertToPdf(templaterStr,
					new FileOutputStream(filePath + "credit_note_order_" + temp + "_bill.pdf"));
			servletResponse.getWriter().write(aliasMaster.getPublicUrl() + "" + "credit_note_order_" + temp + "_bill.pdf");

		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			br.close();
		}
	}

	public void generatePurchasePDFDocumentReport() throws IOException{
		

		GameLobbyController controller = new GameLobbyController();
		StDmDomainAliasNameMaster aliasMaster = null;
		String itemString = "";
		String templaterStr = null;
		Map<String, String> emailContentMap = new HashMap<String, String>();
		partyAcc = controller.getPartyAccountByVoucherPurchase(salesNoVoucher);
		tn = controller.getTransportNameByVoucherPurchase(salesNoVoucher);
		vn = controller.getVehicalNumberByVoucherPurchase(salesNoVoucher);
		des = controller.getDestinationByVoucherPurchase(salesNoVoucher);
		paymentDate = controller.getPaymentDateByVoucherPurchase(salesNoVoucher);
		totalAmt = controller.getTotalAmountByVoucherPurchase(salesNoVoucher);
		salesStockItems = controller.getSaleStockItemsByVoucherPurchase(salesNoVoucher);
		Qty = controller.getSaleStockQtyByVoucherPurchase(salesNoVoucher);
		rate = controller.getSaleStockQtyRateByVoucherPurchase(salesNoVoucher);
		amount = controller.getSaleStockQtyAmtByVoucherPurchase(salesNoVoucher);
		String underEmp = controller.getUnderEmpNameByPurchase(salesNoVoucher);
		unit = "";
		igstItem = "";
		igstItemAmt = "";
		String orderNumber = controller.getOrderNumberSuppInvoice(salesNoVoucher);
		String orderDate = paymentDate;//controller.getOrderDate(orderNumber);
		String firmGSTN = controller.getFirmGSTN(partyAcc);
		emailContentMap.put("BillToName", partyAcc);
		emailContentMap.put("BillToContact", controller.getPropContact(partyAcc));
		emailContentMap.put("TransportName", tn);
		emailContentMap.put("VehicleNumber", vn);
		emailContentMap.put("DeliveryDate", paymentDate);
		emailContentMap.put("DeliveryLocation", des);
		emailContentMap.put("UnderEmp", underEmp);
		emailContentMap.put("BillNumber", salesNoVoucher);
		emailContentMap.put("BillDate", paymentDate);
		emailContentMap.put("orderNumber", orderNumber);
		emailContentMap.put("orderDate", orderDate);
		emailContentMap.put("totalAmount", totalAmt);
		emailContentMap.put("BillToGSTN", firmGSTN);
		emailContentMap.put("totalAmountWords", convertToIndianCurrency(totalAmt));
		BufferedReader br = null;
		try {
			String filePath = ServletActionContext.getServletContext().getRealPath("/");

			aliasMaster = controller.getAliasMaster();
			final String FONTS = aliasMaster.getPublicUrl() + "/KrutiDev.ttf";

			br = new BufferedReader(new InputStreamReader(
					new URL(aliasMaster.getPublicUrl() + "/approval_purchase_bill_generate.html")
							.openStream()));
			String line;
			StringBuffer template = new StringBuffer("");
			while ((line = br.readLine()) != null)
				template.append(line);
			templaterStr = template.toString();

			String[] breakItem = salesStockItems.split(",");
			String[] qtyItem = Qty.split(",");
			String[] priceItem = rate.split(",");
			//String[] unitItem = unit.split(",");
			String[] amountItem = amount.split(",");
		//	String[] igstItemBreak = igstItem.split(",");
		//	String[] igstItemAmtBreak = igstItemAmt.split(",");

			String batchNo = controller.getBatchNumberByPurchase(salesNoVoucher);
			String[] itemBatchBreak = batchNo.split(",");
			Double amountAfterGST = 0.0;
			
			int sno = 1;
			for (int i = 0; i < breakItem.length; i++) {
				if (breakItem[i] == null || breakItem[i].equals("-1") || breakItem[i].equals(" -1")
						|| breakItem[i].isEmpty())
					continue;
				String hsnCode = controller.getHSNCodeByItemName(breakItem[i].trim()) != null
						? controller.getHSNCodeByItemName(breakItem[i].trim())
						: "";
				List<String> mfgExp = controller.getMfgExpDateByItemName(breakItem[i].trim());
				String mfg = "";
				String exp = "";
				if (mfgExp != null && mfgExp.size() > 0 && !mfgExp.isEmpty()) {
					mfg = mfgExp.get(0) != null ? mfgExp.get(0) : "";
					exp = mfgExp.get(1) != null ? mfgExp.get(1) : "";
					mfg = mfg.replaceAll("00:00", "");
					exp = exp.replaceAll("00:00", "");

				}
				List<String> bulkUnitNumber = controller.getBulkUnitNumberByItem(breakItem[i].trim());
				String name = "", bulkBag = "1";
				if (bulkUnitNumber != null && !bulkUnitNumber.isEmpty() && bulkUnitNumber.size() > 0)
					name = bulkUnitNumber.get(0) != null ? bulkUnitNumber.get(0) : "";
				if (bulkUnitNumber != null && !bulkUnitNumber.isEmpty() && bulkUnitNumber.size() > 0)
					bulkBag = bulkUnitNumber.get(1) != null ? bulkUnitNumber.get(1) : "1";
				Double tempSoln = Double.valueOf(qtyItem[i]) / Double.valueOf(bulkBag.isEmpty() ? "1" : bulkBag);
				String itemUnit = controller.getItemUnitByName(breakItem[i].trim());
				Double gst = controller.getGSTByItemName(breakItem[i].trim());
				 amountAfterGST = amountAfterGST + (Double.valueOf(amountItem[i]) * gst) / 100;
				 Double tempAmountAfterGST = (Double.valueOf(amountItem[i]) * gst) / 100;
				itemString += "<tr><td id='company_billTo_contact_pdf'>" + sno
						+ "</td><td id='company_billTo_contact_pdf'>" + breakItem[i] + "<br>(" + itemBatchBreak[i]
						+ ")<br>(MFG-" + mfg + ",EXP-" + exp + ")</td><td id='company_billTo_contact_pdf'>" + hsnCode
						+ "</td><td id='company_billTo_contact_pdf'>" + qtyItem[i]
						+ "</td><td id='company_billTo_contact_pdf'>₹ " + priceItem[i]
						+ "</td><td id='company_billTo_contact_pdf'>" + itemUnit
						+ "</td><td id='company_billTo_contact_pdf'>" + tempSoln + " " + name
						+ "</td><td id='company_billTo_contact_pdf'>₹ " + amountItem[i]
						+ "</td><td id='company_billTo_contact_pdf'>" + gst+" %"
						+ "</td><td id='company_billTo_contact_pdf'>₹ " + tempAmountAfterGST + "</td></tr>";
				sno++;
			}
			emailContentMap.put("cgsttotalAmount", String.valueOf(amountAfterGST / 2));
			emailContentMap.put("sgsttotalAmount", String.valueOf(amountAfterGST / 2));
		

			for (Map.Entry<String, String> entry : emailContentMap.entrySet())
				templaterStr = templaterStr.replaceAll("\\{\\s*" + entry.getKey() + "\\s*,\\s*fallback\\s*=\\}",
						entry.getValue() != null ? entry.getValue() : "");

			templaterStr = templaterStr.replaceAll("\\{\\s*" + "itemTableData" + "\\s*,\\s*fallback\\s*=\\}",
					itemString);
			ConverterProperties properties = new ConverterProperties();
			FontProvider fontProvider = new DefaultFontProvider();
			fontProvider.addDirectory(FONTS);
			properties.setFontProvider(fontProvider);
			String temp = salesNoVoucher.replaceAll("/", "_");
			HtmlConverter.convertToPdf(templaterStr,
					new FileOutputStream(filePath + "purchase_" + temp + "_bill.pdf"));
			servletResponse.getWriter().write(aliasMaster.getPublicUrl() + "" + "purchase_" + temp + "_bill.pdf");

		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			br.close();
		}
		
		
	}
	
	public void generateSalePDFDocumentReport() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		StDmDomainAliasNameMaster aliasMaster = null;
		String itemString = "";
		String templaterStr = null;
		Map<String, String> emailContentMap = new HashMap<String, String>();
		partyAcc = controller.getPartyAccountByVoucher(salesNoVoucher);
		tn = controller.getTransportNameByVoucher(salesNoVoucher);
		vn = controller.getVehicalNumberByVoucher(salesNoVoucher);
		des = controller.getDestinationByVoucher(salesNoVoucher);
		paymentDate = controller.getPaymentDateByVoucher(salesNoVoucher);
		totalAmt = controller.getTotalAmountByVoucher(salesNoVoucher);
		salesStockItems = controller.getSaleStockItemsByVoucher(salesNoVoucher);
		Qty = controller.getSaleStockQtyByVoucher(salesNoVoucher);
		rate = controller.getSaleStockQtyRateByVoucher(salesNoVoucher);
		amount = controller.getSaleStockQtyAmtByVoucher(salesNoVoucher);
		String underEmp = controller.getUnderEmpNameBySale(salesNoVoucher);
		boolean isSuperCash = controller.isSuperCashBill(salesNoVoucher);
		unit = "";
		igstItem = "";
		igstItemAmt = "";
		String orderNumber = controller.getOrderNumber(salesNoVoucher);
		String orderDate = controller.getOrderDate(orderNumber);
		String firmGSTN = controller.getFirmGSTN(partyAcc);
		String superCash="";
		if(isSuperCash) {
			superCash = "(SuperCash)";
		}
		emailContentMap.put("BillToName", partyAcc);
		emailContentMap.put("BillToContact", controller.getPropContact(partyAcc));
		emailContentMap.put("TransportName", tn);
		emailContentMap.put("VehicleNumber", vn);
		emailContentMap.put("DeliveryDate", controller.getSaleDeliveryDate(salesNoVoucher));
		emailContentMap.put("DeliveryLocation", des);
		emailContentMap.put("UnderEmp", underEmp);
		emailContentMap.put("BillNumber", salesNoVoucher);
		emailContentMap.put("BillDate", paymentDate);
		emailContentMap.put("orderNumber", orderNumber);
		emailContentMap.put("orderDate", orderDate);
		emailContentMap.put("totalAmount", totalAmt);
		emailContentMap.put("BillToGSTN", firmGSTN);
		emailContentMap.put("totalAmountWords", convertToIndianCurrency(totalAmt));
		emailContentMap.put("supercash", superCash);
		BufferedReader br = null;
		try {
			String filePath = ServletActionContext.getServletContext().getRealPath("/");

			aliasMaster = controller.getAliasMaster();
			final String FONTS = aliasMaster.getPublicUrl() + "/KrutiDev.ttf";

			br = new BufferedReader(new InputStreamReader(
					new URL(aliasMaster.getPublicUrl() + "/approval_sale_bill_generate_ledger_report.html")
							.openStream()));
			String line;
			StringBuffer template = new StringBuffer("");
			while ((line = br.readLine()) != null)
				template.append(line);
			templaterStr = template.toString();

			String[] breakItem = salesStockItems.split(",");
			String[] qtyItem = Qty.split(",");
			String[] priceItem = rate.split(",");
			//String[] unitItem = unit.split(",");
			String[] amountItem = amount.split(",");
			//String[] igstItemBreak = igstItem.split(",");
			//String[] igstItemAmtBreak = igstItemAmt.split(",");

			String batchNo = controller.getBatchNumberBySaleNo(salesNoVoucher);
			String[] itemBatchBreak = batchNo.split(",");
			Double amountAfterGST = 0.0;
			
			int sno = 1;
			for (int i = 0; i < breakItem.length; i++) {
				if (breakItem[i] == null || breakItem[i].equals("-1") || breakItem[i].equals(" -1")
						|| breakItem[i].isEmpty())
					continue;
				String hsnCode = controller.getHSNCodeByItemName(breakItem[i].trim()) != null
						? controller.getHSNCodeByItemName(breakItem[i].trim())
						: "";
				List<String> mfgExp = controller.getMfgExpDateByItemName(breakItem[i].trim());
				String mfg = "";
				String exp = "";
				if (mfgExp != null && mfgExp.size() > 0 && !mfgExp.isEmpty()) {
					mfg = mfgExp.get(0) != null ? mfgExp.get(0) : "";
					exp = mfgExp.get(1) != null ? mfgExp.get(1) : "";
					mfg = mfg.replaceAll("00:00", "");
					exp = exp.replaceAll("00:00", "");

				}
				List<String> bulkUnitNumber = controller.getBulkUnitNumberByItem(breakItem[i].trim());
				String name = "", bulkBag = "1";
				if (bulkUnitNumber != null && !bulkUnitNumber.isEmpty() && bulkUnitNumber.size() > 0)
					name = bulkUnitNumber.get(0) != null ? bulkUnitNumber.get(0) : "";
				if (bulkUnitNumber != null && !bulkUnitNumber.isEmpty() && bulkUnitNumber.size() > 0)
					bulkBag = bulkUnitNumber.get(1) != null ? bulkUnitNumber.get(1) : "1";
				Double tempSoln = Double.valueOf(qtyItem[i]) / Double.valueOf(bulkBag.isEmpty() ? "1" : bulkBag);
				String itemUnit = controller.getItemUnitByName(breakItem[i].trim());
				Double gst = controller.getGSTByItemName(breakItem[i].trim());
				 amountAfterGST = amountAfterGST + (Double.valueOf(amountItem[i]) * gst) / 100;
				 Double tempAmountAfterGST = (Double.valueOf(amountItem[i]) * gst) / 100;
				itemString += "<tr><td id='company_billTo_contact_pdf'>" + sno
						+ "</td><td id='company_billTo_contact_pdf'>" + breakItem[i] + "<br>(" + itemBatchBreak[i]
						+ ")<br>(MFG-" + mfg + ",EXP-" + exp + ")</td><td id='company_billTo_contact_pdf'>" + hsnCode
						+ "</td><td id='company_billTo_contact_pdf'>" + qtyItem[i]
						+ "</td><td id='company_billTo_contact_pdf'>₹ " + priceItem[i]
						+ "</td><td id='company_billTo_contact_pdf'>" + itemUnit
						+ "</td><td id='company_billTo_contact_pdf'>" + tempSoln + " " + name
						+ "</td><td id='company_billTo_contact_pdf'>₹ " + amountItem[i]
						+ "</td><td id='company_billTo_contact_pdf'>" + gst+" %"
						+ "</td><td id='company_billTo_contact_pdf'>₹ " + tempAmountAfterGST + "</td></tr>";
				sno++;
			}
			emailContentMap.put("cgsttotalAmount", String.valueOf(amountAfterGST / 2));
			emailContentMap.put("sgsttotalAmount", String.valueOf(amountAfterGST / 2));
		

			for (Map.Entry<String, String> entry : emailContentMap.entrySet())
				templaterStr = templaterStr.replaceAll("\\{\\s*" + entry.getKey() + "\\s*,\\s*fallback\\s*=\\}",
						entry.getValue() != null ? entry.getValue() : "");

			templaterStr = templaterStr.replaceAll("\\{\\s*" + "itemTableData" + "\\s*,\\s*fallback\\s*=\\}",
					itemString);
			ConverterProperties properties = new ConverterProperties();
			FontProvider fontProvider = new DefaultFontProvider();
			fontProvider.addDirectory(FONTS);
			properties.setFontProvider(fontProvider);
			String temp = salesNoVoucher.replaceAll("/", "_");
			HtmlConverter.convertToPdf(templaterStr,
					new FileOutputStream(filePath + "sale_order_" + temp + "_bill.pdf"));
			servletResponse.getWriter().write(aliasMaster.getPublicUrl() + "" + "sale_order_" + temp + "_bill.pdf");

		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			br.close();
		}

	}

	public void generateSalePDFDocument() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		StDmDomainAliasNameMaster aliasMaster = null;
		String itemString = "";
		String templaterStr = null;
		Map<String, String> emailContentMap = new HashMap<String, String>();
		String firmGSTN = controller.getFirmGSTN(partyAcc);
		boolean isSuperCash = controller.isSuperCashBill(salesNoVoucher);
		String superCash="";
		if(isSuperCash) {
			superCash = "(SuperCash)";
		}
		emailContentMap.put("BillToName", partyAcc);
		emailContentMap.put("BillToContact",
				controller.getPropContact(partyAcc) != null ? controller.getPropContact(partyAcc) : "");
		emailContentMap.put("TransportName", tn);
		emailContentMap.put("VehicleNumber", vn);
		emailContentMap.put("DeliveryDate", "");
		emailContentMap.put("DeliveryLocation", des);
		emailContentMap.put("DeliveryDate", "");
		emailContentMap.put("OrderNumber", salesNoVoucher);
		emailContentMap.put("OrderDate", paymentDate);
		emailContentMap.put("totalAmount", totalAmt);
		emailContentMap.put("BillToGSTN", firmGSTN != null ? firmGSTN : "");
		emailContentMap.put("totalAmountWords", convertToIndianCurrency(totalAmt));
		emailContentMap.put("supercash", superCash);
		BufferedReader br = null;
		try {
			String filePath = ServletActionContext.getServletContext().getRealPath("/");

			aliasMaster = controller.getAliasMaster();
			final String FONTS = aliasMaster.getPublicUrl() + "/KrutiDev.ttf";

			br = new BufferedReader(new InputStreamReader(
					new URL(aliasMaster.getPublicUrl() + "/approval_sale_bill_generate.html").openStream()));
			String line;
			StringBuffer template = new StringBuffer("");
			while ((line = br.readLine()) != null)
				template.append(line);
			templaterStr = template.toString();

			String[] breakItem = salesStockItems.split(",");
			String[] qtyItem = Qty.split(",");
			String[] priceItem = rate.split(",");
			String[] unitItem = unit.split(",");
			String[] amountItem = amount.split(",");
			//String[] igstItemBreak = igstItem.split(",");
			//String[] igstItemAmtBreak = igstItemAmt.split(",");
			String batchNo = controller.getBatchNumberBySaleNo(salesNoVoucher);
			String[] itemBatchBreak = batchNo.split(",");
			int sno = 1;
			for (int i = 0; i < breakItem.length; i++) {
				if (breakItem[i] != null && breakItem[i].trim().equals("-1"))
					continue;
				String hsnCode = controller.getHSNCodeByItemName(breakItem[i].trim()) != null
						? controller.getHSNCodeByItemName(breakItem[i].trim())
						: "";
				List<String> mfgExp = controller.getMfgExpDateByItemName(breakItem[i].trim());
				String mfg = "";
				String exp = "";
				if (mfgExp != null && mfgExp.size() > 0 && !mfgExp.isEmpty()) {
					mfg = mfgExp.get(0) != null ? mfgExp.get(0) : "";
					exp = mfgExp.get(1) != null ? mfgExp.get(1) : "";
					mfg = mfg.replaceAll("00:00", "");
					exp = exp.replaceAll("00:00", "");

				}
				List<String> bulkUnitNumber = controller.getBulkUnitNumberByItem(breakItem[i].trim());
				String name = "", bulkBag = "1";
				if (bulkUnitNumber != null && !bulkUnitNumber.isEmpty() && bulkUnitNumber.size() > 0)
					name = bulkUnitNumber.get(0) != null ? bulkUnitNumber.get(0) : "";
				if (bulkUnitNumber != null && !bulkUnitNumber.isEmpty() && bulkUnitNumber.size() > 0)
					bulkBag = bulkUnitNumber.get(1) != null ? bulkUnitNumber.get(1) : "1";
				Double tempSoln = Double.valueOf(qtyItem[i]) / Double.valueOf(bulkBag);
				Double gst = controller.getGSTByItemName(breakItem[i].trim());
				Double amountAfterGST = (Double.valueOf(amountItem[i]) * gst) / 100;
				emailContentMap.put("cgsttotalAmount", String.valueOf(amountAfterGST / 2));
				emailContentMap.put("sgsttotalAmount", String.valueOf(amountAfterGST / 2));
				itemString += "<tr><td id='company_billTo_contact_pdf'>" + sno
						+ "</td><td id='company_billTo_contact_pdf'>" + breakItem[i] + "<br>(" + itemBatchBreak[i]
						+ ")<br>(MFG-" + mfg + ",EXP-" + exp + ")</td><td id='company_billTo_contact_pdf'>" + hsnCode
						+ "</td><td id='company_billTo_contact_pdf'>" + qtyItem[i]
						+ "</td><td id='company_billTo_contact_pdf'>₹ " + priceItem[i]
						+ "</td><td id='company_billTo_contact_pdf'>" + unitItem[i]
						+ "</td><td id='company_billTo_contact_pdf'>" + tempSoln + " " + name
						+ "</td><td id='company_billTo_contact_pdf'>₹ " + amountItem[i]
						+ "</td><td id='company_billTo_contact_pdf'>" + gst
						+ "</td><td id='company_billTo_contact_pdf'>₹ " + amountAfterGST + "</td></tr>";

				sno++;
			}
			for (Map.Entry<String, String> entry : emailContentMap.entrySet())
				templaterStr = templaterStr.replaceAll("\\{\\s*" + entry.getKey() + "\\s*,\\s*fallback\\s*=\\}",
						entry.getValue() != null ? entry.getValue() : "");
			
			templaterStr = templaterStr.replaceAll("\\{\\s*" + "itemTableData" + "\\s*,\\s*fallback\\s*=\\}",
					itemString);
			ConverterProperties properties = new ConverterProperties();
			FontProvider fontProvider = new DefaultFontProvider();
			fontProvider.addDirectory(FONTS);
			properties.setFontProvider(fontProvider);
			String temp = salesNoVoucher.replaceAll("/", "_");
			HtmlConverter.convertToPdf(templaterStr,
					new FileOutputStream(filePath + "sale_order_" + temp + "_bill.pdf"));
			servletResponse.getWriter().write(aliasMaster.getPublicUrl() + "" + "sale_order_" + temp + "_bill.pdf");

		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			br.close();
		}

	}

	public void uploadDocument() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		boolean flag = false;
		Date today = new Date();
		DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
		df.setTimeZone(TimeZone.getTimeZone("Asia/Kolkata"));
		String date = df.format(today);
		String filePath = ServletActionContext.getServletContext().getRealPath("/");
		filePath = filePath.substring(0, filePath.lastIndexOf("default/"));
		File file = new File(filePath + "salesOrderTransaction/" + getUserInfoBean().getUserId());
		if (file.mkdir()) {
			filePath = filePath.concat("salesOrderTransaction/" + getUserInfoBean().getUserId());

			if (docPictureDDFileName != null && !docPictureDDFileName.isEmpty()) {
				docPictureDDFileName = salesNo + "_" + date + "_dd_" + docPictureDDFileName;
				File fileToCreateDD = new File(filePath, docPictureDDFileName);
				FileUtils.copyFile(docPictureDD, fileToCreateDD);// copying source file to new file
				flag = true;

			}
			if (docPictureTBFileName != null && !docPictureTBFileName.isEmpty()) {
				docPictureTBFileName = salesNo + "_" + date + "_billT_" + docPictureTBFileName;

				File fileToCreateTB = new File(filePath, docPictureTBFileName);
				FileUtils.copyFile(docPictureTB, fileToCreateTB);// copying source file to new file
				flag = true;
			}
		} else {
			filePath = filePath.concat("salesOrderTransaction/" + getUserInfoBean().getUserId());

			if (docPictureDDFileName != null && !docPictureDDFileName.isEmpty()) {
				docPictureDDFileName = salesNo + "_" + date + "_dd_" + docPictureDDFileName;
				File fileToCreateDD = new File(filePath, docPictureDDFileName);
				FileUtils.copyFile(docPictureDD, fileToCreateDD);// copying source file to new file
				flag = true;

			}
			if (docPictureTBFileName != null && !docPictureTBFileName.isEmpty()) {
				docPictureTBFileName = salesNo + "_" + date + "_billT_" + docPictureTBFileName;

				File fileToCreateTB = new File(filePath, docPictureTBFileName);
				FileUtils.copyFile(docPictureTB, fileToCreateTB);// copying source file to new file
				flag = true;
			}

		}
		if (flag == true) {
			String fileFullPathDD = filePath + "/" + docPictureDDFileName;
			String fileFullPathTB = filePath + "/" + docPictureTBFileName;

			controller.setDocumentPathSales(salesNoVoucher, fileFullPathDD, fileFullPathTB, activeVoucherNumber);

			servletResponse.getWriter().write("success");

		} else
			servletResponse.getWriter().write("failed");

		return;

	}

	public void uploadDocumentDispatchStage() throws IOException {

		GameLobbyController controller = new GameLobbyController();
		boolean flag = false;
		Date today = new Date();
		DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
		df.setTimeZone(TimeZone.getTimeZone("Asia/Kolkata"));
		String date = df.format(today);
		String filePath = ServletActionContext.getServletContext().getRealPath("/");
		filePath = filePath.substring(0, filePath.lastIndexOf("default/"));
		File file = new File(filePath + "salesOrderTransaction/" + getUserInfoBean().getUserId());
		if (file.mkdir()) {
			filePath = filePath.concat("salesOrderTransaction/" + getUserInfoBean().getUserId());

			if (docPictureDDFileName != null && !docPictureDDFileName.isEmpty()) {
				docPictureDDFileName = salesNo + "_" + date + "_dd_" + docPictureDDFileName;
				File fileToCreateDD = new File(filePath, docPictureDDFileName);
				FileUtils.copyFile(docPictureDD, fileToCreateDD);// copying source file to new file
				flag = true;

			}
			if (docPictureTBFileName != null && !docPictureTBFileName.isEmpty()) {
				docPictureTBFileName = salesNo + "_" + date + "_billT_" + docPictureTBFileName;

				File fileToCreateTB = new File(filePath, docPictureTBFileName);
				FileUtils.copyFile(docPictureTB, fileToCreateTB);// copying source file to new file
				flag = true;
			}
		} else {
			filePath = filePath.concat("salesOrderTransaction/" + getUserInfoBean().getUserId());

			if (docPictureDDFileName != null && !docPictureDDFileName.isEmpty()) {
				docPictureDDFileName = salesNo + "_" + date + "_dd_" + docPictureDDFileName;
				File fileToCreateDD = new File(filePath, docPictureDDFileName);
				FileUtils.copyFile(docPictureDD, fileToCreateDD);// copying source file to new file
				flag = true;

			}
			if (docPictureTBFileName != null && !docPictureTBFileName.isEmpty()) {
				docPictureTBFileName = salesNo + "_" + date + "_billT_" + docPictureTBFileName;

				File fileToCreateTB = new File(filePath, docPictureTBFileName);
				FileUtils.copyFile(docPictureTB, fileToCreateTB);// copying source file to new file
				flag = true;
			}

		}
		if (flag == true) {
			String fileFullPathDD = filePath + "/" + docPictureDDFileName;
			String fileFullPathTB = filePath + "/" + docPictureTBFileName;

			controller.setDocumentPathSalesOrder(userInfoBean.getUserId(), orderNo, fileFullPathDD, fileFullPathTB, tn,
					des, transportFreight, vn, loadUnloadCharge + "," + loadUnloadCharge1, localFrieght, ddn, billt);
			sendSmsAlertApprovalStage();
			servletResponse.getWriter().write("success");

		} else
			servletResponse.getWriter().write("failed");

		return;

	}

	public String loadEmpSaleOrder() {
		GameLobbyController controller = new GameLobbyController();
		String str = controller.fetchEmpSOData(0, SOId);
		String[] resArr = str.split("\\|");
		orderNo = resArr[0].trim();
		ItemBean bean = null;
		String[] itemArr = resArr[3].split(",");
		itemBeans = new ArrayList<ItemBean>();
		int id = 1;
		for (int i = 0; i < itemArr.length; i++) {

			if (resArr[3].split(",")[i].trim().equals("-1")) {

			} else {

				bean = new ItemBean();
				bean.setRowId(String.valueOf(id));
				bean.setItemName(resArr[3].split(",")[i].trim());
				bean.setItemQty(resArr[4].split(",")[i].trim());
				bean.setItemRate(resArr[5].split(",")[i].trim());
				bean.setItemAmount(resArr[6].split(",")[i].trim());
				itemBeans.add(bean);
				id++;
			}
		}
		partyAccNameSO = resArr[1].trim();
		totalAmt = resArr[8].trim();
		narration = resArr[7].trim();
		status = resArr[9].trim();
		Dname = resArr[10].trim();
		propName = resArr[11].trim();
		employeeUnder = controller.getEmpNameByOrder(orderNo);
		contact = resArr[12].trim();
		address = resArr[13].trim();
		gstnNo = resArr[14].trim();
		paymentDate = resArr[15].trim();
		docPictureFileName = resArr[16].trim();
		particularsList = new ArrayList<String>();
		salesStockItemList = new ArrayList<>();
		particularsList = controller.getaccountListForTxnPayment("", getUserInfoBean().getUserId());
		partyAccName = new ArrayList<>();
		partyAccName = controller.getaccountListForTxnPayment("", getUserInfoBean().getUserId());
		employeeUnderList = controller.getEmployeeNamesList();
		salesAccountList = controller.getaccountListForTxnPayment("sales acc", getUserInfoBean().getUserId());
		salesStockItemList = controller.getSalesStockItemList();

		return SUCCESS;
	}

	public String loadSalePageAlert() {

		GameLobbyController controller = new GameLobbyController();
		String str = controller.fetchEmpSOData(0, SOId);
		String[] resArr = str.split("\\|");
		orderNo = resArr[0].trim();
		String[] itemArr = resArr[3].split(",");
		ItemBean bean = null;
		itemBeans = new ArrayList<ItemBean>();
		int id = 1;
		for (int i = 0; i < itemArr.length; i++) {

			if (resArr[3].split(",")[i].trim().equals("-1")) {

			} else {

				bean = new ItemBean();
				bean.setRowId(String.valueOf(id));
				bean.setItemName(resArr[3].split(",")[i].trim());
				bean.setItemQty(resArr[4].split(",")[i].trim());
				bean.setItemRate(resArr[5].split(",")[i].trim());
				bean.setItemAmount(resArr[6].split(",")[i].trim());
				itemBeans.add(bean);
				id++;
			}
		}
		partyAccNameSO = resArr[1].trim();
		totalAmt = resArr[8].trim();
		narration = resArr[7].trim();
		Dname = resArr[10].trim();
		if (Dname.isEmpty())
			consignee = "No";
		else
			consignee = "Yes";
		propName = resArr[11].trim();
		contact = resArr[12].trim();
		status = resArr[9].trim();
		address = resArr[13].trim();
		gstnNo = resArr[14].trim();
		paymentDate = resArr[15].trim();
		employeeUnder = controller.getEmpNameByOrder(orderNo);
		docPictureFileName = resArr[16].trim();
		particularsList = new ArrayList<String>();
		salesStockItemList = new ArrayList<>();
		particularsList = controller.getaccountListForTxnPayment("", 1);
		partyAccName = new ArrayList<>();
		partyAccName = controller.getaccountListForTxnPayment("", 1);
		employeeUnderList = controller.getEmployeeNamesList();
		salesAccountList = controller.getaccountListForTxnPayment("sales acc", 1);
		salesStockItemList = controller.getSalesStockItemList();
		goDownList = new ArrayList<>();
		goDownList = controller.getAllGoDownList();
		salesNo = controller.getSalesNo();
		isLastApproval = controller.getIsLastApproval(SOId, "sales");
		rejectReason = resArr[17].trim();
		superCashEligible = resArr[18].trim();
		if(superCashEligible.equalsIgnoreCase("Yes")) {
			superCashEligible = "YES";
		}
		else {
			superCashEligible = "NO";
		}
		transportFreight = "0";
		localFrieght = "0";
		loadUnloadCharge = "0,0";
		loadCharge = "0";
		unloadCharge = "0";
		try {
			ddn = resArr[19].trim();
			tn = resArr[20].trim();
			des = resArr[21].trim();
			billt = resArr[22].trim();
			vn = resArr[23].trim();
			transportFreight = resArr[24].trim();
			localFrieght = resArr[25].trim();
			loadUnloadCharge = resArr[26].trim();

			docPictureDDFileName = resArr[27].trim();
			docPictureTBFileName = resArr[28].trim();
			if (!tn.isEmpty() && !ddn.isEmpty() && !status.equals("rejected")) {
				if (status.equals("pending"))
					status = "final approval";
			}
			String[] loadUnloadChargeArr = loadUnloadCharge.split(",");
			loadCharge = loadUnloadChargeArr[0];
			unloadCharge = loadUnloadChargeArr[1];
		} catch (Exception e) {

		}

		String checkIsVoucherActive = controller.getActiveVoucher("Sales");

		if (checkIsVoucherActive.equalsIgnoreCase("duplicate")) {
			return ERROR;
		}

		else {
			voucherBean = controller.getVoucherNumbering("Sales", checkIsVoucherActive);
			if (checkIsVoucherActive.equalsIgnoreCase("not found"))
				activeVoucherNumber = "0";
			else
				activeVoucherNumber = checkIsVoucherActive;
			if (voucherBean == null)
				salesNoVoucher = String.valueOf(controller.getSalesNo());
			else {

				if (voucherBean.getVoucherNumbering().equals("Manual")) {
					salesNoVoucher = String.valueOf(controller.getSalesNo());
				} else {
					if (voucherBean.getAdvanceNumbering().equals("Yes")) {
						int getMaxNumber = controller.getSaleVoucherNumber(activeVoucherNumber);
						if (getMaxNumber == 0) {
							salesNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix()
									+ String.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d",
											Integer.valueOf(voucherBean.getStartingNumber()));
						} else {
							getMaxNumber++;
							salesNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix() + String
									.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d", getMaxNumber);
							;

						}
					} else {
						salesNoVoucher = String.valueOf(controller.getSalesNo());
					}

				}

			}
		}
		return SUCCESS;
	}

	public void getUnits() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String unit = controller.getUnitByItemName(var);
		servletResponse.getWriter().write("" + unit);
		return;
	}

	public void getAlternateUnits() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String unit = controller.getAlternateUnitByItemName(var);
		servletResponse.getWriter().write("" + unit);
		return;
	}

	public void rejectSale() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.rejectSales(orderNo, rejectReason, userInfoBean.getUserId()))
			servletResponse.getWriter().write("success");
		else
			servletResponse.getWriter().write("error");
		return;
	}

	public void getPartyPeriodLimit() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		int partyId = controller.findLedgerIdByName(partyName);
		int creditPeriod = controller.getCreditPeriod(partyId);
		if (creditPeriod != -1) {

			SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
			Calendar c = Calendar.getInstance();
			TimeZone tz = TimeZone.getTimeZone("Asia/Kolkata");
			c.setTimeZone(tz);

			try {
				if (paymentDate != null && !paymentDate.isEmpty())
					c.setTime(sdf.parse(paymentDate));
				else {
					Date today = new Date();
					DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
					df.setTimeZone(TimeZone.getTimeZone("Asia/Kolkata"));
					String date = df.format(today);
					c.setTime(sdf.parse(date));
				}

			} catch (ParseException e) {
				e.printStackTrace();
			}

			// Number of Days to add
			c.add(Calendar.DAY_OF_MONTH, -creditPeriod);
			// Date after adding the days to the given date
			String dateBeforePeriod = sdf.format(c.getTime());

			List<String> billDetailsMap = controller.getBillDetails(partyId, "_sale", dateBeforePeriod);
			String result = "";
			if (billDetailsMap != null && !billDetailsMap.isEmpty()) {
				for (String st : billDetailsMap)
					result = result + st + ";";
				servletResponse.getWriter().write("" + result);
			} else {
				servletResponse.getWriter().write("skip");
			}

		} else {
			servletResponse.getWriter().write("skip");
		}
	}

	public String loadSalesPage() throws ParseException {
		GameLobbyController controller = new GameLobbyController();
		particularsList = new ArrayList<String>();
		salesStockItemList = new ArrayList<>();
		particularsList = controller.getaccountListForTxnPayment("", 1);
		partyAccName = new ArrayList<>();
		partyAccName = controller.getaccountListForTxnPayment("", 1);
		employeeUnderList = controller.getEmployeeNamesList();
		salesAccountList = controller.getaccountListForTxnPayment("sales acc", 1);
		salesStockItemList = controller.getSalesStockItemList();
		setSalesNo(controller.getSalesNo());
		String checkIsVoucherActive = controller.getActiveVoucher("Sales");

		if (checkIsVoucherActive.equalsIgnoreCase("duplicate")) {
			return ERROR;
		}

		else {
			voucherBean = controller.getVoucherNumbering("Sales", checkIsVoucherActive);
			if (checkIsVoucherActive.equalsIgnoreCase("not found"))
				activeVoucherNumber = "0";
			else
				activeVoucherNumber = checkIsVoucherActive;
			if (voucherBean == null)
				salesNoVoucher = String.valueOf(controller.getSalesNo());
			else {

				if (voucherBean.getVoucherNumbering().equals("Manual")) {
					salesNoVoucher = String.valueOf(controller.getSalesNo());
				} else {
					if (voucherBean.getAdvanceNumbering().equals("Yes")) {
						int getMaxNumber = controller.getSaleVoucherNumber(activeVoucherNumber);
						if (getMaxNumber == 0) {
							salesNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix()
									+ String.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d",
											Integer.valueOf(voucherBean.getStartingNumber()));
						} else {
							getMaxNumber++;
							salesNoVoucher = voucherBean.getPrefix() + voucherBean.getSuffix() + String
									.format("%0" + Integer.valueOf(voucherBean.getDecimalNumber()) + "d", getMaxNumber);
							;

						}
					} else {
						salesNoVoucher = String.valueOf(controller.getSalesNo());
					}

				}

			}
			goDownList = new ArrayList<>();
			goDownList = controller.getAllGoDownList();
			return SUCCESS;
		}

	}

	private boolean compareTwoDate(String endDate, String currentDate) throws ParseException {
		// TODO Auto-generated method stub
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy h:m");
		if (sdf.parse(currentDate).after(sdf.parse(endDate))) {
			return true;
		}

		return false;
	}

	public void createSales() throws Exception {
		GameLobbyController controller = new GameLobbyController();
		Transaction transaction = null;
		Session session = null;
		session = HibernateSessionFactory.getSession();
		transaction = session.beginTransaction();
		boolean isPartyBlock = controller.getPartyBlockStatus(partyAcc);
		if (isPartyBlock) {
			servletResponse.getWriter().write("block");
		} else {

			if (activeVoucherNumber.equals("0")) {
				if (controller.createTransactionSales(partyOldBalance, employeeUnder, partyAcc, salesAccount,
						salesStockItems, amount, Qty, rate, narration, salesNoVoucher, consignee, Dname, propName,
						contact, address, gstnNo, ddn, tn, des, billt, vn, transportFreight, paymentDate,
						activeVoucherNumber, totalAmt, goDown, hiddenBatchNumber, session, transaction)) {
					if (controller.updateTransactionPartyBalanceSale(partyAcc, totalAmt, hcrdr, session,
							transaction))
						if (controller.updateOrCreateStockSale(salesStockItems, goDown, Qty, unit, hiddenBatchNumber,
								hiddenMfgDate, hiddenExpDate, hiddenExpAlert, hiddenExpAlertDate, hiddenBatchApplicable,
								session, transaction))
							// update
							if (controller.insertNewBillSale(paymentDate, "Agst Ref", partyAcc, totalAmt,
									salesNoVoucher, session, transaction, superCashEligible, orderNo)) {
								transaction.commit();
								if (!orderNo.isEmpty() && orderNo != null) {
									if (controller.changeStatusSuccess(Integer.valueOf(orderNo),
											userInfoBean.getUserId(), salesNoVoucher)) {
										if (checkOverDueRem.equals("true")) {
											controller.changeAlertStatus(partyAcc, salesNoVoucher);
										}
										if (controller.allowAlert(partyAcc, "SMS"))
											sendSmsAlert();
										// generateSalePDFDocument();
										servletResponse.getWriter().write("success");
									}

								}

								else {
									if (checkOverDueRem.equals("true")) {
										controller.changeAlertStatus(partyAcc, salesNoVoucher);
									}
									if (controller.allowAlert(partyAcc, "SMS"))
										sendSmsAlert();
									// generateSalePDFDocument();
									servletResponse.getWriter().write("success");
								}

							}

				} else {
					transaction.rollback();
					servletResponse.getWriter().write("error");
				}
					
			} else {
				voucherBean = controller.getVoucherNumbering("Sales", activeVoucherNumber);
				boolean voucherDate = compareTwoDate(voucherBean.getEndDate(), paymentDate + " 00:00");
				boolean voucherDate1 = compareTwoDate(paymentDate + " 00:00", voucherBean.getStartDate());
				if (voucherDate == true || voucherDate1 == true) {

					servletResponse.getWriter().write("date");
				}

				else {
					if (controller.createTransactionSales(partyOldBalance, employeeUnder, partyAcc, salesAccount,
							salesStockItems, amount, Qty, rate, narration, salesNoVoucher, consignee, Dname, propName,
							contact, address, gstnNo, ddn, tn, des, billt, vn, transportFreight, paymentDate,
							activeVoucherNumber, totalAmt, goDown, hiddenBatchNumber, session, transaction)) {
						if (controller.updateTransactionPartyBalanceSale(partyAcc, totalAmt, hcrdr, session,
								transaction))
							if (controller.updateOrCreateStockSale(salesStockItems, goDown, Qty, unit,
									hiddenBatchNumber, hiddenMfgDate, hiddenExpDate, hiddenExpAlert, hiddenExpAlertDate,
									hiddenBatchApplicable, session, transaction))
								// update
								if (controller.insertNewBillSale(paymentDate, "Agst Ref", partyAcc, totalAmt,
										salesNoVoucher, session, transaction, superCashEligible, orderNo)) {
									transaction.commit();
									if (!orderNo.isEmpty() && orderNo != null) {
										if (controller.changeStatusSuccess(Integer.valueOf(orderNo),
												userInfoBean.getUserId(), salesNoVoucher)) {
											if (checkOverDueRem.equals("true")) {
												controller.changeAlertStatus(partyAcc, salesNoVoucher);
											}
											if (controller.allowAlert(partyAcc, "SMS"))
												sendSmsAlert();
											// generateSalePDFDocument();
											servletResponse.getWriter().write("success");
										}

									} else {
										if (checkOverDueRem.equals("true")) {
											controller.changeAlertStatus(partyAcc, salesNoVoucher);
										}
										if (controller.allowAlert(partyAcc, "SMS"))
											sendSmsAlert();
										// generateSalePDFDocument();
										servletResponse.getWriter().write("success");
									}

								}

					} else {
						transaction.rollback();
						servletResponse.getWriter().write("error");
					}
						
				}
			}
		}

		return;
	}

	private void sendSmsAlert() {
		GameLobbyController controller = new GameLobbyController();
		try {
			String getPropName = controller.getPropName(partyAcc);
			String mobile = controller.getPropContact(partyAcc);
			String getUnderEmpName = controller.getUnderEmpName(partyAcc);
			String getEmpMobile = controller.getUnderEmpMobile(partyAcc);
			String sms = "Dear " + getPropName + ",Prop " + partyAcc + ". Your Bill No-" + salesNoVoucher + " of AMT "
					+ totalAmt + " " + " Dated " + paymentDate + " has been generated. Your closing balance is "
					+ currBalance + " " + hcrdr
					+ ". Thank you for choosing us. Regards JAMIDARA SEEDS CORPORATION (Karnataka)";
			String smsEmp = "Dear " + getUnderEmpName + ", Your party " + getPropName + ",Prop " + partyAcc
					+ " Bill No-" + salesNoVoucher + " of AMT " + totalAmt + " " + " Dated " + paymentDate
					+ " has been generated. His closing balance is " + currBalance + " " + hcrdr
					+ ". Thank you for choosing us. Regards JAMIDARA SEEDS CORPORATION (Karnataka)";
			if (mobile != null && !mobile.isEmpty()) {
				SendSMS sendSMS = new SendSMS();
				sendSMS.setMobileNo("91" + mobile);
				sendSMS.setMsg(sms);
				Thread thread = new Thread(sendSMS);
				thread.setDaemon(true);
				thread.start();
			}

			if (getEmpMobile != null && !getEmpMobile.isEmpty()) {
				SendSMS sendSMS1 = new SendSMS();
				sendSMS1.setMobileNo("91" + getEmpMobile);
				sendSMS1.setMsg(smsEmp);
				Thread thread1 = new Thread(sendSMS1);
				thread1.setDaemon(true);
				thread1.start();
			}
		} catch (Exception e) {

		}
	}

	private void sendSmsAlertApprovalStage() {
		GameLobbyController controller = new GameLobbyController();
		try {
			Date today = new Date();
			DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
			df.setTimeZone(TimeZone.getTimeZone("Asia/Kolkata"));
			String date = df.format(today);

			String getPropName = controller.getPropName(partyAcc);
			String mobile = controller.getPropContact(partyAcc);
			String getUnderEmpName = controller.getUnderEmpName(partyAcc);
			String getEmpMobile = controller.getUnderEmpMobile(partyAcc);

			String smsEmp = "Dear " + getUnderEmpName + ", Your distributor " + partyAcc + ", Order No. " + orderNo
					+ " is successfully dispatched on " + date + " by Transport name " + tn + ", and Bill-T No. is "
					+ billt + ". Thank you for choosing us. Regards JAMIDARA SEEDS CORPORATION (Karnataka)";
			String smsParty = "Dear " + getPropName + ",Prop " + partyAcc + ". Your Order No. " + orderNo
					+ " is successfully dispatched on " + date + " by Transport name " + tn + ", Bill-T No. " + billt
					+ ". Thank you for choosing us. Regards JAMIDARA SEEDS CORPORATION (Karnataka)";
			if (mobile != null && !mobile.isEmpty()) {
				SendSMS sendSMS = new SendSMS();
				sendSMS.setMobileNo("91" + mobile);
				sendSMS.setMsg(smsParty);
				Thread thread = new Thread(sendSMS);
				thread.setDaemon(true);
				thread.start();
			}

			if (getEmpMobile != null && !getEmpMobile.isEmpty()) {
				SendSMS sendSMS1 = new SendSMS();
				sendSMS1.setMobileNo("91" + getEmpMobile);
				sendSMS1.setMsg(smsEmp);
				Thread thread1 = new Thread(sendSMS1);
				thread1.setDaemon(true);
				thread1.start();
			}
		} catch (Exception e) {

		}

	}

	public void rejectSales() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.rejectSalesOrder(Integer.valueOf(orderNo), userInfoBean.getUserId())) {
			servletResponse.getWriter().write("success");
		} else {
			servletResponse.getWriter().write("error");
		}
	}

	public void returnSale() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		if (controller.returnSalesOrder(orderNo, rejectReason, userInfoBean.getUserId())) {
			servletResponse.getWriter().write("success");
		} else {
			servletResponse.getWriter().write("error");
		}
	}

	public void getSecurity() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String amt = controller.getSecurity(partyAcc);
		if (amt.contains("null")) {
			servletResponse.getWriter().write("0");
		} else
			servletResponse.getWriter().write("" + amt);

	}

	public void checkSaleStatus() throws IOException {
		GameLobbyController controller = new GameLobbyController();
		String status = controller.checkSalesOrder(Integer.valueOf(orderNo));
		if (status == null) {
			servletResponse.getWriter().write("error");
		} else if (status.equalsIgnoreCase("pending")) {
			servletResponse.getWriter().write("pending");
		} else if (status.equalsIgnoreCase("accepted")) {
			servletResponse.getWriter().write("accept");
		} else if (status.equalsIgnoreCase("rejected")) {
			servletResponse.getWriter().write("reject");
		}

	}

	public void approveSale() throws IOException {

		GameLobbyController controller = new GameLobbyController();
		if (controller.approveSale(orderNo, userInfoBean.getUserId()))
			servletResponse.getWriter().write("success");
		else
			servletResponse.getWriter().write("error");
		return;

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

	public List<String> getEmployeeUnderList() {
		return employeeUnderList;
	}

	public void setEmployeeUnderList(List<String> employeeUnderList) {
		this.employeeUnderList = employeeUnderList;
	}

	public List<String> getParticularsList() {
		return particularsList;
	}

	public void setParticularsList(List<String> particularsList) {
		this.particularsList = particularsList;
	}

	public String getEmployeeUnder() {
		return employeeUnder;
	}

	public void setEmployeeUnder(String employeeUnder) {
		this.employeeUnder = employeeUnder;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getNarration() {
		return narration;
	}

	public void setNarration(String narration) {
		this.narration = narration;
	}

	public int getSalesNo() {
		return salesNo;
	}

	public void setSalesNo(int salesNo) {
		this.salesNo = salesNo;
	}

	public List<String> getPartyAccName() {
		return partyAccName;
	}

	public void setPartyAccName(List<String> partyAccName) {
		this.partyAccName = partyAccName;
	}

	public List<String> getSalesAccountList() {
		return salesAccountList;
	}

	public void setSalesAccountList(List<String> salesAccountList) {
		this.salesAccountList = salesAccountList;
	}

	public List<String> getSalesStockItemList() {
		return salesStockItemList;
	}

	public void setSalesStockItemList(List<String> salesStockItemList) {
		this.salesStockItemList = salesStockItemList;
	}

	public String getReferenceNo() {
		return referenceNo;
	}

	public void setReferenceNo(String referenceNo) {
		this.referenceNo = referenceNo;
	}

	public String getPartyAcc() {
		return partyAcc;
	}

	public void setPartyAcc(String partyAcc) {
		this.partyAcc = partyAcc;
	}

	public String getSalesAccount() {
		return salesAccount;
	}

	public void setSalesAccount(String salesAccount) {
		this.salesAccount = salesAccount;
	}

	public String getSalesStockItems() {
		return salesStockItems;
	}

	public void setSalesStockItems(String salesStockItems) {
		this.salesStockItems = salesStockItems;
	}

	public String getQty() {
		return Qty;
	}

	public void setQty(String qty) {
		Qty = qty;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getVar() {
		return var;
	}

	public void setVar(String var) {
		this.var = var;
	}

	public String getCurrBalance() {
		return currBalance;
	}

	public void setCurrBalance(String currBalance) {
		this.currBalance = currBalance;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getGoDown() {
		return goDown;
	}

	public void setGoDown(String goDown) {
		this.goDown = goDown;
	}

	public List<String> getGoDownList() {
		return goDownList;
	}

	public void setGoDownList(List<String> goDownList) {
		this.goDownList = goDownList;
	}

	public String getHiddenBatchNumber() {
		return hiddenBatchNumber;
	}

	public void setHiddenBatchNumber(String hiddenBatchNumber) {
		this.hiddenBatchNumber = hiddenBatchNumber;
	}

	public String getHiddenMfgDate() {
		return hiddenMfgDate;
	}

	public void setHiddenMfgDate(String hiddenMfgDate) {
		this.hiddenMfgDate = hiddenMfgDate;
	}

	public String getHiddenExpDate() {
		return hiddenExpDate;
	}

	public void setHiddenExpDate(String hiddenExpDate) {
		this.hiddenExpDate = hiddenExpDate;
	}

	public String getHiddenExpAlert() {
		return hiddenExpAlert;
	}

	public void setHiddenExpAlert(String hiddenExpAlert) {
		this.hiddenExpAlert = hiddenExpAlert;
	}

	public String getHiddenExpAlertDate() {
		return hiddenExpAlertDate;
	}

	public void setHiddenExpAlertDate(String hiddenExpAlertDate) {
		this.hiddenExpAlertDate = hiddenExpAlertDate;
	}

	public String getTotalAmt() {
		return totalAmt;
	}

	public void setTotalAmt(String totalAmt) {
		this.totalAmt = totalAmt;
	}

	public String getHcrdr() {
		return hcrdr;
	}

	public void setHcrdr(String hcrdr) {
		this.hcrdr = hcrdr;
	}

	public String getPartyName() {
		return partyName;
	}

	public void setPartyName(String partyName) {
		this.partyName = partyName;
	}

	public String getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}

	public String getSOId() {
		return SOId;
	}

	public void setSOId(String sOId) {
		SOId = sOId;
	}

	public String getPartyAccNameSO() {
		return partyAccNameSO;
	}

	public void setPartyAccNameSO(String partyAccNameSO) {
		this.partyAccNameSO = partyAccNameSO;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getSalesNoVoucher() {
		return salesNoVoucher;
	}

	public void setSalesNoVoucher(String salesNoVoucher) {
		this.salesNoVoucher = salesNoVoucher;
	}

	public VoucherBean getVoucherBean() {
		return voucherBean;
	}

	public void setVoucherBean(VoucherBean voucherBean) {
		this.voucherBean = voucherBean;
	}

	public List<ItemBean> getItemBeans() {
		return itemBeans;
	}

	public void setItemBeans(List<ItemBean> itemBeans) {
		this.itemBeans = itemBeans;
	}

	public String getHiddenBatchApplicable() {
		return hiddenBatchApplicable;
	}

	public void setHiddenBatchApplicable(String hiddenBatchApplicable) {
		this.hiddenBatchApplicable = hiddenBatchApplicable;
	}

	public String getConsignee() {
		return consignee;
	}

	public void setConsignee(String consignee) {
		this.consignee = consignee;
	}

	public String getDname() {
		return Dname;
	}

	public void setDname(String dname) {
		Dname = dname;
	}

	public String getPropName() {
		return propName;
	}

	public void setPropName(String propName) {
		this.propName = propName;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getGstnNo() {
		return gstnNo;
	}

	public void setGstnNo(String gstnNo) {
		this.gstnNo = gstnNo;
	}

	public String getDdn() {
		return ddn;
	}

	public void setDdn(String ddn) {
		this.ddn = ddn;
	}

	public String getTn() {
		return tn;
	}

	public void setTn(String tn) {
		this.tn = tn;
	}

	public String getDes() {
		return des;
	}

	public void setDes(String des) {
		this.des = des;
	}

	public String getBillt() {
		return billt;
	}

	public void setBillt(String billt) {
		this.billt = billt;
	}

	public String getVn() {
		return vn;
	}

	public void setVn(String vn) {
		this.vn = vn;
	}

	public String getTransportFreight() {
		return transportFreight;
	}

	public void setTransportFreight(String transportFreight) {
		this.transportFreight = transportFreight;
	}

	public String getActiveVoucherNumber() {
		return activeVoucherNumber;
	}

	public void setActiveVoucherNumber(String activeVoucherNumber) {
		this.activeVoucherNumber = activeVoucherNumber;
	}

	public File getDocPicture() {
		return docPicture;
	}

	public void setDocPicture(File docPicture) {
		this.docPicture = docPicture;
	}

	public String getDocPictureContentType() {
		return docPictureContentType;
	}

	public void setDocPictureContentType(String docPictureContentType) {
		this.docPictureContentType = docPictureContentType;
	}

	public String getDocPictureFileName() {
		return docPictureFileName;
	}

	public void setDocPictureFileName(String docPictureFileName) {
		this.docPictureFileName = docPictureFileName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public File getDocPictureDD() {
		return docPictureDD;
	}

	public void setDocPictureDD(File docPictureDD) {
		this.docPictureDD = docPictureDD;
	}

	public String getDocPictureDDContentType() {
		return docPictureDDContentType;
	}

	public void setDocPictureDDContentType(String docPictureDDContentType) {
		this.docPictureDDContentType = docPictureDDContentType;
	}

	public String getDocPictureDDFileName() {
		return docPictureDDFileName;
	}

	public void setDocPictureDDFileName(String docPictureDDFileName) {
		this.docPictureDDFileName = docPictureDDFileName;
	}

	public File getDocPictureTB() {
		return docPictureTB;
	}

	public void setDocPictureTB(File docPictureTB) {
		this.docPictureTB = docPictureTB;
	}

	public String getDocPictureTBContentType() {
		return docPictureTBContentType;
	}

	public void setDocPictureTBContentType(String docPictureTBContentType) {
		this.docPictureTBContentType = docPictureTBContentType;
	}

	public String getDocPictureTBFileName() {
		return docPictureTBFileName;
	}

	public void setDocPictureTBFileName(String docPictureTBFileName) {
		this.docPictureTBFileName = docPictureTBFileName;
	}

	public String getPartyOldBalance() {
		return partyOldBalance;
	}

	public void setPartyOldBalance(String partyOldBalance) {
		this.partyOldBalance = partyOldBalance;
	}

	public String getCheckOverDueRem() {
		return checkOverDueRem;
	}

	public void setCheckOverDueRem(String checkOverDueRem) {
		this.checkOverDueRem = checkOverDueRem;
	}

	public String getSuperCashEligible() {
		return superCashEligible;
	}

	public void setSuperCashEligible(String superCashEligible) {
		this.superCashEligible = superCashEligible;
	}

	public String getIsLastApproval() {
		return isLastApproval;
	}

	public void setIsLastApproval(String isLastApproval) {
		this.isLastApproval = isLastApproval;
	}

	public String getRejectReason() {
		return rejectReason;
	}

	public void setRejectReason(String rejectReason) {
		this.rejectReason = rejectReason;
	}

	public String getLocalFrieght() {
		return localFrieght;
	}

	public void setLocalFrieght(String localFrieght) {
		this.localFrieght = localFrieght;
	}

	public String getLoadUnloadCharge() {
		return loadUnloadCharge;
	}

	public void setLoadUnloadCharge(String loadUnloadCharge) {
		this.loadUnloadCharge = loadUnloadCharge;
	}

	public String getIgstItem() {
		return igstItem;
	}

	public void setIgstItem(String igstItem) {
		this.igstItem = igstItem;
	}

	public String getIgstItemAmt() {
		return igstItemAmt;
	}

	public void setIgstItemAmt(String igstItemAmt) {
		this.igstItemAmt = igstItemAmt;
	}

	public String getLoadCharge() {
		return loadCharge;
	}

	public void setLoadCharge(String loadCharge) {
		this.loadCharge = loadCharge;
	}

	public String getUnloadCharge() {
		return unloadCharge;
	}

	public void setUnloadCharge(String unloadCharge) {
		this.unloadCharge = unloadCharge;
	}

	public String getLoadUnloadCharge1() {
		return loadUnloadCharge1;
	}

	public void setLoadUnloadCharge1(String loadUnloadCharge1) {
		this.loadUnloadCharge1 = loadUnloadCharge1;
	}

}
