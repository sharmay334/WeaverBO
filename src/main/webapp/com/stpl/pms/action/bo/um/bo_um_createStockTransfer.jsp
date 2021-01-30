<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>Stock Transfer</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<SCRIPT type="text/javascript"
	src="<%=path%>/com/stpl/pms/action/bo/um/js/um.js"></SCRIPT>

<script>
	/* 	$(document).ready(function() {
	 $('#payTransaction').dataTable();
	 }); */
	$(document).ready(function() {
		
		$("#accordion").accordion( {
			collapsible : true,
			clearStyle : true,
			heightStyle: "content",
			header : 'div[class*="accordianHeader"]',
			icons : {
				header : "plus1",
				headerSelected : "minus1"
			},
			active : false
		});
		
		$("#accordion1").accordion( {
			collapsible : true,
			clearStyle : true,
			heightStyle: "content",
			header : 'div[class*="accordianHeader"]',
			icons : {
				header : "plus1",
				headerSelected : "minus1"
			},
			active : false
		});
		$("#accordion2").accordion( {
			collapsible : true,
			clearStyle : true,
			heightStyle: "content",
			header : 'div[class*="accordianHeader"]',
			icons : {
				header : "plus1",
				headerSelected : "minus1"
			},
			active : false
		});
		$("#accordion3").accordion( {
			collapsible : true,
			clearStyle : true,
			heightStyle: "content",
			header : 'div[class*="accordianHeader"]',
			icons : {
				header : "plus1",
				headerSelected : "minus1"
			},
			active : false
		});
		
		$("#mfg").datetimepicker({
			dateFormat : 'dd-mm-yy',
			showSecond : false,
			showMinute : false,
			showHour : false,
			changeYear : true,
			changeMonth : true,
			minDate : '01-01-1930',
			onSelect : function(selectedDate) {
				if (selectedDate != "") {
					$("#mfg").datepicker("option", "minDate", selectedDate);
				} else {
					var date = new Date().getDate();
					$(function() {
						$("#mfg").datepicker({
							dateFormat : 'dd-mm-yy'
						}).datepicker("setDate", date);
					});
				}
			}
		});

		$("#exp").datetimepicker({
			dateFormat : 'dd-mm-yy',
			showSecond : false,
			showMinute : false,
			showHour : false,
			changeYear : true,
			changeMonth : true,
			minDate : '01-01-1930',
			onSelect : function(selectedDate) {
				if (selectedDate != "") {
					$("#exp").datepicker("option", "minDate", selectedDate);
				} else {
					var date = new Date().getDate();
					$(function() {
						$("#exp").datepicker({
							dateFormat : 'dd-mm-yy'
						}).datepicker("setDate", date);
					});
				}
			}
		});

	});
	
	 function calAmount(id) {
			var res = id.match(/\d/g);
			var qty = Number(document.getElementById('componentItemQty' + res).value);
			var rate = Number(document.getElementById('componentItemRate' + res).value);
			qty = qty.toFixed(2);
			rate = rate.toFixed(2);
			document.getElementById('componentItemAmt' + res).value = Number(qty) * Number(rate);
	}

	 function calAmount1(id) {
			var res = id.match(/\d/g);
			var qty = Number(document.getElementById('scrapItemQty' + res).value);
			var rate = Number(document.getElementById('scrapItemrate' + res).value);
			qty = qty.toFixed(2);
			rate = rate.toFixed(2);
			document.getElementById('scrapItemAmt' + res).value = Number(qty) * Number(rate);
	}
	
	 function getUnitByItemComponent(id) {
			
			var myurl1="<%=basePath%>";
			
				myurl = myurl1+"/com/stpl/pms/action/bo/um/bo_um_tm_get_sales.action?var="
					+ document.getElementById(id).value;
			var res = id.match(/\d/g);
			$.ajax({
				type : "GET",
				async: false,
				url : myurl,
				success : function(itr) {
					document.getElementById('componentItemUnit' + res).value = ''+itr;
					
				},

				error : function(itr) {

				}
			});
				
		}
	 function getUnitByItemScrap(id) {
			
			var myurl1="<%=basePath%>";

		myurl = myurl1
				+ "/com/stpl/pms/action/bo/um/bo_um_tm_get_sales.action?var="
				+ document.getElementById(id).value;
		var res = id.match(/\d/g);
		$
				.ajax({
					type : "GET",
					async : false,
					url : myurl,
					success : function(itr) {
						document.getElementById('scrapItemUnit' + res).value = ''
								+ itr;

					},

					error : function(itr) {

					}
				});

	}
	 function showGodownQty(id){
			
			var myurl = "<%=basePath%>";
			var res = id.match(/\d/g);
			var itemName = document.getElementById('componentitemName'+res).value;
			myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_availableQtyPuchase.action?goDown="
					+ document.getElementById('componentitemGodown'+res).value+"&itemName="+itemName;
			var res = id.match(/\d/g);
			$.ajax({
				type : "GET",
				url : myurl,
				success : function(itr) {
					
					document.getElementById('componentAvailableQty' + res).value = itr;
					
				},

				error : function(itr) {

				}
			});
		} function showGodownQtyScrap(id){
			
			var myurl = "<%=basePath%>";
			var res = id.match(/\d/g);
			var itemName = document.getElementById('scrapitemName'+res).value;
			myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_availableQtyPuchase.action?goDown="
					+ document.getElementById('scrapitemGodown'+res).value+"&itemName="+itemName;
			var res = id.match(/\d/g);
			$.ajax({
				type : "GET",
				url : myurl,
				success : function(itr) {
					
					document.getElementById('scrapAvailableQty' + res).value = itr;
					
				},

				error : function(itr) {

				}
			});
		}
	 
</script>
</head>
<body>
	<div class="clear2"></div>
	<h2>
		Transfer of Materials
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Stock Transfer</h4>
		</div>
		<s:form
			action="/com/stpl/pms/action/bo/um/bo_um_create_stock_transfer.action"
			id="searchUserFrm" theme="simple" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">

						<div class="labelDiv">
							<label>Transfer Date</label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:textfield id="mfg" name="mfg" placeholder="Date"
								cssClass="dateField" theme="myTheme" readonly="true"
								applyscript="true" cssStyle="width:50%" />
							<div id="paymentDate_error" class="fieldError">
								<s:fielderror>
									<s:param>paymentDate</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>

										<div id="accordion" class="UIaccordian">
						<div id="tabs-1" style="width: 100%">
							<div class="accordianHeader" style="width: 95%;">
								<h3>Source (Consumption)</h3>
								<!--<span class="minus1" id="min"></span>
							-->
							</div>

							<div class="accordian_content" id="accordian_content1"
								style="display: block; padding-top: 8px; padding-bottom: 8px; margin-top: 0px; border: 1px #AAAAAA solid; width: 92%;">
								<div
									style="width: 98%; height: auto; margin: 0 auto; margin-top: 18px; font-size: 12px; border: 0px #c2c2c2 solid">

									<table width="100%" cellspacing="0" align="center"
										id="payTransactionTable" class="transactionTable">
										<thead>
											<tr>

												<th style="text-align: center;" nowrap="nowrap">Name of
													Item</th>
												<th style="text-align: center;" nowrap="nowrap">Godown</th>
											    <th style="text-align: center;" nowrap="nowrap">Available Qty</th>
												<th style="text-align: center;" nowrap="nowrap">Qty.</th>
												<th style="text-align: center;" nowrap="nowrap">Unit</th>
												<th style="text-align: center;" nowrap="nowrap">Rate</th>
												<th style="text-align: center;" nowrap="nowrap">Amount</th>

											</tr>
										</thead>
										<tbody>
											<s:iterator begin="1" end="6" status="data">
												<tr id="rowId<s:property value="#data.count"/>">
													<td style="text-align: center;" nowrap="nowrap"><s:select
															headerKey="-1" headerValue="Please Select"
															name="componentitemName"
															id="%{'componentitemName' + #data.count}"
															list="stockItemsList" cssClass="select1" theme="myTheme"
															cssStyle="width:120px;"
															onchange="getUnitByItemComponent(this.id)" /></td>
													<td style="text-align: center;" nowrap="nowrap"><s:select
															headerKey="-1" headerValue="Please Select"
															name="componentitemGodown"
															id="%{'componentitemGodown' + #data.count}"
															list="goDownList" cssClass="select1" onchange="showGodownQty(this.id)" theme="myTheme"
															cssStyle="width:120px;" /></td>
													<td style="text-align: center;" nowrap="nowrap"><ss:textfield
															maxlength="100" name="componentAvailableQty" value="0" id="%{'componentAvailableQty' + #data.count}"
																theme="myTheme" pattern="^[0-9.]*$" readOnly="true" cssStyle="width:50%">
																	</ss:textfield></td>		
													<td style="text-align: center;" nowrap="nowrap"><ss:textfield
															maxlength="100" name="componentItemQty" value="0"
															id="%{'componentItemQty' + #data.count}" theme="myTheme"
															onfocusout="calAmount(this.id)" pattern="^[0-9.]*$"
															cssStyle="width:50%">
														</ss:textfield></td>
													<td style="text-align: center;" nowrap="nowrap"><ss:textfield
															maxlength="100" name="componentItemUnit" value=""
															id="%{'componentItemUnit' + #data.count}" theme="myTheme"
															readOnly="true" cssStyle="width:50%">
														</ss:textfield></td>
													<td style="text-align: center;" nowrap="nowrap"><ss:textfield
															maxlength="100" name="componentItemRate" value="0"
															id="%{'componentItemRate' + #data.count}" theme="myTheme"
															onfocusout="calAmount(this.id)" pattern="^[0-9.]*$"
															cssStyle="width:50%">
														</ss:textfield></td>
													<td style="text-align: center;" nowrap="nowrap"><ss:textfield
															maxlength="100" name="componentItemAmt" value="0"
															id="%{'componentItemAmt' + #data.count}" theme="myTheme"
															readOnly="true" cssStyle="width:50%">
														</ss:textfield></td>

												</tr>

											</s:iterator>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>

					<div id="accordion1" class="UIaccordian">
						<div id="tabs-1" style="width: 100%">
							<div class="accordianHeader" style="width: 95%;">
								<h3>Destination (production)</h3>
								<!--<span class="minus1" id="min"></span>
							-->
							</div>

							<div class="accordian_content" id="accordian_content2"
								style="display: block; padding-top: 8px; padding-bottom: 8px; margin-top: 0px; border: 1px #AAAAAA solid; width: 92%;">
								<div
									style="width: 98%; height: auto; margin: 0 auto; margin-top: 18px; font-size: 12px; border: 0px #c2c2c2 solid">

									<table width="100%" cellspacing="0" align="center"
										id="payTransactionTable2" class="transactionTable">
										<thead>
											<tr>

												<th style="text-align: center;" nowrap="nowrap">Name of
													Item</th>
												<th style="text-align: center;" nowrap="nowrap">Godown</th>
												 <th style="text-align: center;" nowrap="nowrap">Available Qty</th>
												<th style="text-align: center;" nowrap="nowrap">Qty.</th>
												<th style="text-align: center;" nowrap="nowrap">Unit</th>
												<th style="text-align: center;" nowrap="nowrap">Rate.</th>
												<th style="text-align: center;" nowrap="nowrap">Amount</th>

											</tr>
										</thead>
										<tbody>
											<s:iterator begin="1" end="8" status="data">
												<tr id="rowId<s:property value="#data.count"/>">
													<td style="text-align: center;" nowrap="nowrap"><s:select
															headerKey="-1" headerValue="Please Select"
															name="scrapitemName"
															id="%{'scrapitemName' + #data.count}"
															list="stockItemsList" cssClass="select1" theme="myTheme"
															cssStyle="width:120px;"
															onchange="getUnitByItemScrap(this.id)" /></td>
													<td style="text-align: center;" nowrap="nowrap"><s:select
															headerKey="-1" headerValue="Please Select"
															name="scrapitemGodown"
															id="%{'scrapitemGodown' + #data.count}" list="goDownList"
															cssClass="select1" theme="myTheme"
															cssStyle="width:120px;" onchange="showGodownQtyScrap(this.id)" /></td>
													<td style="text-align: center;" nowrap="nowrap"><ss:textfield
															maxlength="100" name="scrapAvailableQty" value="0" id="%{'scrapAvailableQty' + #data.count}"
																theme="myTheme" pattern="^[0-9.]*$" readOnly="true" cssStyle="width:50%">
																	</ss:textfield></td>			
													<td style="text-align: center;" nowrap="nowrap"><ss:textfield
															maxlength="100" name="scrapItemQty" value="0"
															id="%{'scrapItemQty' + #data.count}" theme="myTheme"
															pattern="^[0-9.]*$" onfocusout="calAmount1(this.id)" cssStyle="width:50%">
														</ss:textfield></td>
													<td style="text-align: center;" nowrap="nowrap"><ss:textfield
															maxlength="100" name="scrapItemUnit" value=""
															id="%{'scrapItemUnit' + #data.count}" theme="myTheme"
															readOnly="true" cssStyle="width:50%">
														</ss:textfield></td>
													<td style="text-align: center;" nowrap="nowrap"><ss:textfield
															maxlength="100" name="scrapItemrate" value="0"
															id="%{'scrapItemrate' + #data.count}" theme="myTheme"
															pattern="^[0-9.]*$" onfocusout="calAmount1(this.id)" cssStyle="width:50%">
														</ss:textfield></td>
													<td style="text-align: center;" nowrap="nowrap"><ss:textfield
															maxlength="100" name="scrapItemAmt" value="0"
															id="%{'scrapItemAmt' + #data.count}" theme="myTheme"
															readOnly="true" cssStyle="width:50%">
														</ss:textfield></td>

												</tr>

											</s:iterator>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>

					<div id="accordion2" class="UIaccordian">
						<div id="tabs-1" style="width: 100%">
							<div class="accordianHeader" style="width: 95%;">
								<h3>Other Cost Component</h3>
								<!--<span class="minus1" id="min"></span>
							-->
							</div>

							<div class="accordian_content" id="accordian_content3"
								style="display: block; padding-top: 8px; padding-bottom: 8px; margin-top: 0px; border: 1px #AAAAAA solid; width: 92%;">
								<div
									style="width: 98%; height: auto; margin: 0 auto; margin-top: 18px; font-size: 12px; border: 0px #c2c2c2 solid">

									<table width="100%" cellspacing="0" align="center"
										id="payTransactionTable3" class="transactionTable">
										<thead>
											<tr>

												<th style="text-align: center;" nowrap="nowrap">Cost
													Type</th>
												<th style="text-align: center;" nowrap="nowrap">Amount</th>

											</tr>
										</thead>
										<tbody>
											<s:iterator begin="1" end="10" status="data">
												<tr id="rowId<s:property value="#data.count"/>">
													<td style="text-align: center;" nowrap="nowrap"><s:select
															headerKey="-1" headerValue="Please Select"
															name="costComponentitemName"
															id="%{'costComponentitemName' + #data.count}"
															list="ledgerNamesList" cssClass="select1" theme="myTheme"
															cssStyle="width:120px;" /></td>

													<td style="text-align: center;" nowrap="nowrap"><ss:textfield
															maxlength="100" name="costComponentItemAmt" value="0"
															id="%{'costComponentItemAmt' + #data.count}"
															theme="myTheme" cssStyle="width:50%">
														</ss:textfield></td>

												</tr>

											</s:iterator>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>


					<div id="accordion3" class="UIaccordian">
						<div id="tabs-1" style="width: 100%">
							<div class="accordianHeader" style="width: 95%;">
								<h3>Transportation Cost</h3>
								<!--<span class="minus1" id="min"></span>
							-->
							</div>

							<div class="accordian_content" id="accordian_content4"
								style="display: block; padding-top: 8px; padding-bottom: 8px; margin-top: 0px; border: 1px #AAAAAA solid; width: 92%;">
								<div
									style="width: 98%; height: auto; margin: 0 auto; margin-top: 18px; font-size: 12px; border: 0px #c2c2c2 solid">

									<table width="100%" cellspacing="0" align="center"
										class="transactionTable">
										<thead>
											<tr>
												<th style="text-align: center;" nowrap="nowrap">Dispatch
													Doc No</th>
												<th style="text-align: center;" nowrap="nowrap">Transport
													Name</th>
												<th style="text-align: center;" nowrap="nowrap">Destination</th>
											</tr>
										</thead>
										<tbody>

											<tr>

												<td style="text-align: center;" nowrap="nowrap"><s:textfield
														name="ddn" id="ddn" value="%{ddn}" theme="myTheme"
														cssStyle="width:40%" /></td>

												<td style="text-align: center;" nowrap="nowrap"><s:textfield
														name="tn" id="tn" value="%{tn}" theme="myTheme"
														cssStyle="width:50%" /></td>

												<td style="text-align: center;" nowrap="nowrap"><s:textfield
														name="des" id="des" value="%{des}" theme="myTheme"
														cssStyle="width:50%" /></td>

											</tr>

										</tbody>
									</table>
									

									<table width="100%" cellspacing="0" align="center"
										class="transactionTable">
										<thead>
											<tr>
												<th style="text-align: center;" nowrap="nowrap">Bill-T
													No.</th>
												<th style="text-align: center;" nowrap="nowrap">Vehical
													No.</th>
												<th style="text-align: center;" nowrap="nowrap">Transport
													Freight</th>
											</tr>
										</thead>
										<tbody>

											<tr>

												<td style="text-align: center;" nowrap="nowrap"><s:textfield
														name="billt" id="billt" theme="myTheme"
														cssStyle="width:40%" value="%{billt}" /></td>

												<td style="text-align: center;" nowrap="nowrap"><s:textfield
														name="vn" id="vn" value="%{vn}" theme="myTheme"
														cssStyle="width:50%" /></td>

												<td style="text-align: center;" nowrap="nowrap"><s:textfield
														name="transportFreight" id="transportFreight"
														value="%{transportFreight}" theme="myTheme"
														pattern="^[0-9.]*$" cssStyle="width:50%" /></td>

											</tr>

										</tbody>
									</table>
									
									<table width="100%" cellspacing="0" align="center"
										class="transactionTable">
										<thead>
											<tr>
												<th style="text-align: center;" nowrap="nowrap">Local
													Freight</th>
												<th style="text-align: center;" nowrap="nowrap">Load -
													Unload Freight</th>
											</tr>
										</thead>
										<tbody>

											<tr>


												<td style="text-align: center;" nowrap="nowrap"><s:textfield
														name="localFrieght" id="localFrieght"
														value="%{localFrieght}" theme="myTheme"
														pattern="^[0-9.]*$" cssStyle="width:50%" /></td>

												<td style="text-align: center;" nowrap="nowrap"><s:textfield
														name="loadUnloadCharge" id="loadUnloadCharge"
														value="%{loadUnloadCharge}" theme="myTheme"
														pattern="^[0-9.]*$" cssStyle="width:50%" /></td>

											</tr>

										</tbody>
									</table>

								</div>
							</div>
						</div>
					</div>

				</s:if>


			</div>

			<div class="box_footer" align="right">
				<input type="submit" value='Create' align="left"
					style="margin-left: 0px" class="button" />
			</div>
		</s:form>
	</div>
	<div id="searchDiv"></div>
	<br />
	<br />
</body>
</html>
