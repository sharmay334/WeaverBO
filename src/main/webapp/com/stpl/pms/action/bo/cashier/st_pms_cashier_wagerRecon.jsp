<%@ taglib uri="/struts-tags" prefix="s" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>Wager Reconciliation</title>
  	<script type="text/javascript" >
	$(function() {
			 $("#wagerFromDate").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				numberOfMonths : 1,
				maxDate : new Date(),
				onClose : function(selectedDate) {
					$("#wagerToDate").datetimepicker("option", "minDate", selectedDate);
				}
			});
			$("#wagerToDate").datetimepicker( {
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond: true,
				changeMonth : true,
				numberOfMonths : 1,
				hour: 23,
				minute: 59,
				second: 59,
				maxDate : new Date(),
				onClose : function(selectedDate) {
					$("#wagerFromDate").datetimepicker("option", "maxDate", selectedDate);
				}
			});
			
			$('#wagerFromDate').datetimepicker('setDate', '-1m');  
            $('#wagerToDate').datetimepicker('setDate', new Date());
			
			$("#domainId").change(function() {
			var domainId = $(this).val();
				$("#aliasId").empty().append($('<option></option>').val("-1").html("--Please Select--"));
			if(domainId!="-1"){
				var jsonList = '["aliasList"]';
				var map = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+domainId+"&jsonList="+jsonList,"");
				$.each(map["aliasList"], function(index, value) {
					$("#aliasId").append($('<option></option>').val(value.aliasId).html(value.aliasName));
				});
			}
			$("#wagerListContainer").empty();
			$("#aliasId").val(-1);
			$("#gameService").val(-1);
			$("#wagerStatus").val(-1);
			$("table[id*=bubbleTable]").hide();
			$('#wagerFromDate').datetimepicker('setDate', '-1m');  
            $('#wagerToDate').datetimepicker('setDate', new Date());
			
		});
		
		$("#aliasId").change(function() {
			var aliasId=$("#aliasId").val();
			if(aliasId!="-1"){
				$("#gameService").empty().append($('<option></option>').val("-1").html("--Please Select--"));
				var vendorMap=_ajaxCallJson("com/stpl/pms/action/bo/cashier/st_pms_csh_getGameVendors.action?aliasId="+aliasId,"");
				for (var key in vendorMap)
					if (vendorMap.hasOwnProperty(key))
						$("#gameService").append($('<option></option>').val(vendorMap[key]).html(key));
			}
			$("#wagerListContainer").empty();
			$("#gameService").val(-1);
			$("#wagerStatus").val(-1);
			$("table[id*=bubbleTable]").hide();
			$('#wagerFromDate').datetimepicker('setDate', '-1m');  
            $('#wagerToDate').datetimepicker('setDate', new Date());
		});

		$('#gameService').change(function() {
			$("#wagerListContainer").empty();
			$("#wagerStatus").val(-1);
			$("table[id*=bubbleTable]").hide();
		});
		
		$("#wagerStatus").change(function() {
			$("#wagerListContainer").empty();
			$("table[id*=bubbleTable]").hide();
		});
		
		$("#wagerSearchForm").submit(function(){
			var domainId = $("#domainId").val();
			var aliasId = $("#aliasId").val();
			var wagerStatus = $("#wagerStatus").val();
			var wagerFromDate=$("#wagerFromDate").val();
			var wagerToDate=$("#wagerToDate").val();
			var gameServiceId = $("#gameService").val();
			var gameServiceCode=$("#gameService option:selected").text();
			try{
			if (domainId !== "-1" && aliasId !== "-1" && gameServiceId!="-1")
				_ajaxCallDiv(
						'com/stpl/pms/action/bo/cashier/st_pms_bo_csh_getWagerList.action',
						"domainId=" + domainId + "&aliasId=" + aliasId + "&status="
						+ wagerStatus + "&gameServiceId=" + gameServiceId + 
						"&gameServiceCode=" + gameServiceCode + "&wagerFromDate=" + wagerFromDate
						+ "&wagerToDate=" + wagerToDate, 'wagerListContainer');
			}catch (e) {
				console.error(e);
				alert("script Exception caught!");
			}
			return false;				
		});
		
		
	});
  		
  	</script>
  </head>
<body>
	<div id="container">
		<h2>Wager Reconciliation</h2>
	</div>
	<div class="FormSection">
		<div class="greyStrip">
			<h4>Search Wager Listing</h4>
		</div>
		<s:form id="wagerSearchForm" action="" method="post">
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Domain Name:</label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:select theme="myTheme" cssClass="select1" list="%{domainMap}"
							applyscript="true" name="domainId" id="domainId" headerKey="-1"
							headerValue="--Please Select--"></s:select>
					</div>
				</div>

				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Alias Name:</label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:select theme="myTheme" cssClass="select1" list="#{}"
							applyscript="true" name="aliasId" id="aliasId" headerKey="-1"
							headerValue="--Please Select--"></s:select>
					</div>
				</div>

				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Game Service:</label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:select theme="myTheme" cssClass="select1" list="#{}"
							applyscript="true" name="gameService" id="gameService"
							headerKey="-1" headerValue="--Please Select--"></s:select>
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Select date range:</label>
					</div>
					<div class="InputDiv">
						<div class="small-text-box-div-new">
							<s:textfield name="wagerFromDate" id="wagerFromDate"
								readonly="true" placeholder="From Date"
								cssClass="text-field-small"
								cssStyle="width:165px;padding-left:0;"></s:textfield>
							-
							<s:textfield name="wagerToDate" id="wagerToDate" readonly="true"
								placeholder="To Date" cssClass="text-field-small"
								cssStyle="width:165px;padding-left:0; "></s:textfield>
						</div>
					</div>
				</div>

				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Wager Status:</label>
					</div>
					<div class="InputDiv">
						<s:select theme="myTheme" cssClass="select1"
							list="#{'Pending':'PENDING','Confirm':'CONFIRM','Refund':'REFUND'}"
							name="wagerStatus" id="wagerStatus"></s:select>
					</div>
				</div>
			</div>
			<div class="box_footer" align="right">
				<s:submit theme="simple" cssClass="button"></s:submit>
			</div>
		</s:form>
	</div>

	<div id="wagerListContainer" style="display: none;"></div>
	<div style="margin: 50px;"></div>
</body>
</html>
