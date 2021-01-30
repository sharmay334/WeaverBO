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

<title>Create Stock Item</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
    <SCRIPT type="text/javascript" src="<%=path %>/com/stpl/pms/action/bo/um/js/um.js"></SCRIPT>

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
			alterFinalCosts();
		}
	 function alterFinalCosts(){
		 var amount = 0;
		 var Qty = Number(document.getElementById('manufacturingQty').value);
		 for(var consumption=1;consumption<7;consumption++){
			 
			 amount  = Number(amount) + Number(document.getElementById('componentItemAmt'+consumption).value);
		 }
			var scrapAmount = 0;
		 for(var scrap=1;scrap<9;scrap++){
			 
			 scrapAmount  = Number(scrapAmount) + Number(document.getElementById('scrapItemAmt'+scrap).value);
		 }
		 var costOfComAmt = 0;
 		for(var comp=1;comp<11;comp++){
			 
 			costOfComAmt  = Number(costOfComAmt) + Number(document.getElementById('costComponentItemAmt'+comp).value);
		 }
		 
		 amount = amount.toFixed(2);
		 Qty = Qty.toFixed(2);
		 document.getElementById('effectiveCost').value = amount;
		 document.getElementById('allocationPrimaryItem').value = (amount - scrapAmount)+costOfComAmt;
		 amount = (amount - scrapAmount)+costOfComAmt;
		 var effRate =  Number(amount/Qty);
		 effRate = effRate.toFixed(2);
		 document.getElementById('totalAdditionalCost').value = costOfComAmt;
		 document.getElementById('effectiveRatePrimaryItem').value = effRate+'/'+document.getElementById('manufacturingQtyUnitHidden').value;
		 document.getElementById('effectiveQtyPrimaryItem').value = Qty;
		 
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
	 function getUnitItem(id) {
			
			var myurl1="<%=basePath%>";
			
				myurl = myurl1+"/com/stpl/pms/action/bo/um/bo_um_tm_get_sales.action?var="
					+ document.getElementById(id).value;
			var res = id.match(/\d/g);
			$.ajax({
				type : "GET",
				url : myurl,
				success : function(itr) {
					document.getElementById('manufacturingQtyUnit').innerHTML = ''+itr;
				document.getElementById('manufacturingQtyUnitHidden').value=''+itr;
				},

				error : function(itr) {

				}
			});
				
		}
	 function getUnitByItemScrap(id) {
			
			var myurl1="<%=basePath%>";
			
				myurl = myurl1+"/com/stpl/pms/action/bo/um/bo_um_tm_get_sales.action?var="
					+ document.getElementById(id).value;
			var res = id.match(/\d/g);
			$.ajax({
				type : "GET",
				async: false,
				url : myurl,
				success : function(itr) {
					document.getElementById('scrapItemUnit' + res).value = ''+itr;
					
				},

				error : function(itr) {

				}
			});
				
		}
	 
	 function calScrapRate(id){
		 var res = id.match(/\d/g);
		 var perAlloc = Number(document.getElementById('scrapCostPercent'+res).value);
		 var qtyAlloc = Number(document.getElementById('scrapItemQty'+res).value);
		 var rate = (qtyAlloc*perAlloc)/100;
		 rate = rate.toFixed(2);
		 
		 document.getElementById('scrapItemrate'+res).value = rate;
		 document.getElementById('scrapItemAmt'+res).value = rate*qtyAlloc;
		 alterFinalCosts();
	 }
	 function showGodownQty(id){
			
			var myurl = "<%=basePath%>";
			var res = id.match(/\d/g);
			var itemName = document.getElementById('componentitemName'+res).value;
			myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_availableQtyPuchase.action?goDown="
					+ document.getElementById('componentitemGodown'+res).value+"&itemName="+itemName;
			$.ajax({
				type : "GET",
				url : myurl,
				success : function(itr) {
					
					document.getElementById('componentAvailableQty' + res).value = itr;
					
				},

				error : function(itr) {

				}
			});
		}
	 function showGodownQtyScrap(id){
			
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
		Create Stock Manufacturing
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Manufacture if Materials</h4>
		</div>
		<s:form
			action="/com/stpl/pms/action/bo/um/bo_um_create_manufacturing.action"
			id="searchUserFrm" theme="simple" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Name of Product </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
								<s:select name="manufacturingBean.stockItemName" id="stockItemName"
								headerKey="-1" headerValue="Select Item"
								list="stockItemsList" cssClass="select1" onchange="getUnitItem(this.id)" theme="myTheme"
								applyscript="true"></s:select>
							<div id="stockItemName_error" class="fieldError">
								<s:fielderror>
									<s:param>stockItemName</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Godown </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select name="manufacturingBean.stockGodown" id="stockGodown"
								headerKey="-1" headerValue="Select Godown"
								list="goDownList" cssClass="select1" theme="myTheme"
								applyscript="true"></s:select>

							<div id="stockGodown_error" class="fieldError">
								<s:fielderror>
									<s:param>stockGodown</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>

					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Qty </label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="manufacturingBean.manufacturingQty"
							id="manufacturingQty" value="0" theme="myTheme" applyscript="true" cssStyle="width:30%"></ss:textfield>
							<span id="manufacturingQtyUnit"></span>
							<s:hidden id="manufacturingQtyUnitHidden"/>
							<div id="manufacturingQty_error" class="fieldError">
								<s:fielderror>
									<s:param>manufacturingQty</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Batch No </label>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="manufacturingBean.batchNo"
							id="batchNo" theme="myTheme" cssStyle="width:20%"></ss:textfield>

						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label>Mfg Date</label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:textfield id="mfg" name="manufacturingBean.mfg" placeholder="Date" cssClass="dateField" theme="myTheme" readonly="true" applyscript="true" cssStyle="width:50%" />
						<div id="paymentDate_error" class="fieldError">
								<s:fielderror>
									<s:param>paymentDate</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>
					
					<div class="FormMainBox">

						<div class="labelDiv">
							<label>Exp Date</label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:textfield id="exp" name="manufacturingBean.exp" placeholder="Date" cssClass="dateField" theme="myTheme" readonly="true" applyscript="true" cssStyle="width:50%" />
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
						<h3>
							Component (Consumption)
									
						</h3>
							<!--<span class="minus1" id="min"></span>
							--></div>
							
	<div class="accordian_content" id="accordian_content1" style="display: block;padding-top: 8px;padding-bottom: 8px;margin-top:0px; border:1px #AAAAAA solid;width: 92%;">
			<div style="width: 98%; height: auto; margin: 0 auto; margin-top: 18px; font-size: 12px; border: 0px #c2c2c2 solid">
							
			<table width="100%" cellspacing="0" align="center"
						id="payTransactionTable" class="transactionTable">
						<thead>
							<tr>

								<th style="text-align: center;" nowrap="nowrap">Name of Item</th>
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
										headerKey="-1" headerValue="Please Select" name="manufacturingBean.componentitemName"
										id="%{'componentitemName' + #data.count}" list="stockItemsList" cssClass="select1"
										theme="myTheme" cssStyle="width:120px;" onchange="getUnitByItemComponent(this.id)"/></td>
								<td style="text-align: center;" nowrap="nowrap"><s:select
										headerKey="-1" headerValue="Please Select" name="manufacturingBean.componentitemGodown"
										id="%{'componentitemGodown' + #data.count}" onchange="showGodownQty(this.id)" list="goDownList" cssClass="select1"
										theme="myTheme" cssStyle="width:120px;" /></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="100" name="manufacturingBean.componentAvailableQty" value="0" id="%{'componentAvailableQty' + #data.count}"
										theme="myTheme" pattern="^[0-9.]*$" readOnly="true" cssStyle="width:50%">
									</ss:textfield></td>	
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="100" name="manufacturingBean.componentItemQty" value="0" id="%{'componentItemQty' + #data.count}"
										theme="myTheme" onfocusout="calAmount(this.id)" pattern="^[0-9.]*$" cssStyle="width:50%">
									</ss:textfield></td>
									<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="100" name="manufacturingBean.componentItemUnit" value="" id="%{'componentItemUnit' + #data.count}"
										theme="myTheme" readOnly="true" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="100" name="manufacturingBean.componentItemRate" value="0" id="%{'componentItemRate' + #data.count}"
										theme="myTheme" onfocusout="calAmount(this.id)" pattern="^[0-9.]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="100" name="manufacturingBean.componentItemAmt" value="0" id="%{'componentItemAmt' + #data.count}"
										theme="myTheme" readOnly="true" cssStyle="width:50%">
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
						<h3>
							Co-Product/Scrap
									
						</h3>
							<!--<span class="minus1" id="min"></span>
							--></div>
							
	<div class="accordian_content" id="accordian_content2" style="display: block;padding-top: 8px;padding-bottom: 8px;margin-top:0px; border:1px #AAAAAA solid;width: 92%;">
			<div style="width: 98%; height: auto; margin: 0 auto; margin-top: 18px; font-size: 12px; border: 0px #c2c2c2 solid">
							
			<table width="100%" cellspacing="0" align="center"
						id="payTransactionTable1" class="transactionTable">
						<thead>
							<tr>

								<th style="text-align: center;" nowrap="nowrap">Name of Item</th>
								<th style="text-align: center;" nowrap="nowrap">Godown</th>
								<th style="text-align: center;" nowrap="nowrap">Available Qty</th>
								<th style="text-align: center;" nowrap="nowrap">% of cost allocation</th>
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
										headerKey="-1" headerValue="Please Select" name="manufacturingBean.scrapitemName"
										id="%{'scrapitemName' + #data.count}" list="stockItemsList" cssClass="select1"
										theme="myTheme" cssStyle="width:120px;" onchange="getUnitByItemScrap(this.id)"/></td>
								<td style="text-align: center;" nowrap="nowrap"><s:select
										headerKey="-1" headerValue="Please Select" name="manufacturingBean.scrapitemGodown"
										id="%{'scrapitemGodown' + #data.count}" onchange="showGodownQtyScrap(this.id)" list="goDownList" cssClass="select1"
										theme="myTheme" cssStyle="width:120px;" /></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="100" name="manufacturingBean.scrapAvailableQty" value="0" id="%{'scrapAvailableQty' + #data.count}"
										theme="myTheme" pattern="^[0-9.]*$" readOnly="true" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="100" name="manufacturingBean.scrapCostPercent" value="0" id="%{'scrapCostPercent' + #data.count}"
										theme="myTheme" onfocusout="calScrapRate(this.id)" pattern="^[0-9.]*$"cssStyle="width:50%">
									</ss:textfield></td>		
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="100" name="manufacturingBean.scrapItemQty" value="0" id="%{'scrapItemQty' + #data.count}"
										theme="myTheme" onfocusout="calScrapRate(this.id)" pattern="^[0-9.]*$"cssStyle="width:50%">
									</ss:textfield></td>
									<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="100" name="manufacturingBean.scrapItemUnit" value="" id="%{'scrapItemUnit' + #data.count}"
										theme="myTheme" readOnly="true" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="100" name="manufacturingBean.scrapItemrate" value="0" id="%{'scrapItemrate' + #data.count}"
										theme="myTheme" readOnly="true" pattern="^[0-9.]*$" cssStyle="width:50%">
									</ss:textfield></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="100" name="manufacturingBean.scrapItemAmt" value="0" id="%{'scrapItemAmt' + #data.count}"
										theme="myTheme" readOnly="true" cssStyle="width:50%">
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
						<h3>
							Cost of Component
									
						</h3>
							<!--<span class="minus1" id="min"></span>
							--></div>
							
	<div class="accordian_content" id="accordian_content3" style="display: block;padding-top: 8px;padding-bottom: 8px;margin-top:0px; border:1px #AAAAAA solid;width: 92%;">
			<div style="width: 98%; height: auto; margin: 0 auto; margin-top: 18px; font-size: 12px; border: 0px #c2c2c2 solid">
							
			<table width="100%" cellspacing="0" align="center"
						id="payTransactionTable1" class="transactionTable">
						<thead>
							<tr>

								<th style="text-align: center;" nowrap="nowrap">Type of Additional Cost</th>
								<th style="text-align: center;" nowrap="nowrap">Amount</th>
								
							</tr>
						</thead>
						<tbody>
							<s:iterator begin="1" end="10" status="data">
							<tr id="rowId<s:property value="#data.count"/>">
							<td style="text-align: center;" nowrap="nowrap"><s:select
										headerKey="-1" headerValue="Please Select" name="manufacturingBean.costComponentitemName"
										id="%{'costComponentitemName' + #data.count}" list="ledgerNamesList" cssClass="select1"
										theme="myTheme" cssStyle="width:120px;" /></td>
								
							<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="100" name="manufacturingBean.costComponentItemAmt" value="0" id="%{'costComponentItemAmt' + #data.count}"
										theme="myTheme" pattern="^[0-9.]*$" onfocusout="alterFinalCosts()" cssStyle="width:50%">
									</ss:textfield></td>

							</tr>

							</s:iterator>
						</tbody>
					</table>
					</div>
					</div>
				</div>
				</div>
				<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Total Addl. Cost </label>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="manufacturingBean.totalAdditionalCost"
							id="totalAdditionalCost" readOnly="true" theme="myTheme" cssStyle="width:30%"></ss:textfield>

						</div>
					</div>	
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Effective Cost </label>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="manufacturingBean.effectiveCost"
							id="effectiveCost" readOnly="true" theme="myTheme" cssStyle="width:30%"></ss:textfield>

						</div>
					</div>	
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Allocation to Primary item </label>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="manufacturingBean.allocationPrimaryItem"
							id="allocationPrimaryItem" readOnly="true" theme="myTheme" cssStyle="width:30%"></ss:textfield>

						</div>
					</div>	
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Effective rate of Primary item </label>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="manufacturingBean.effectiveRatePrimaryItem"
							id="effectiveRatePrimaryItem" readOnly="true" theme="myTheme" cssStyle="width:30%"></ss:textfield>

						</div>
					</div>	
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Effective Qty of Primary item </label>
						</div>
						<div class="InputDiv">
							<ss:textfield maxlength="100" name="manufacturingBean.effectiveQtyPrimaryItem"
							id="effectiveQtyPrimaryItem" readOnly="true" theme="myTheme" cssStyle="width:30%"></ss:textfield>

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
