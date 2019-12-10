<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>Update Players Ledger</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="css/facebox.css" media="screen" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			$(document).ready(function(){
				/* $("#domainId").change(function(){
					var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
					$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					$.each(aliasMap,function(index, value) {
						$('#aliasId').append($('<option></option>').val(index).html(value));
	  				});
				}); */
				$(".dateField").datetimepicker(
			{
				dateFormat : 'dd/mm/yy',
				timeFormat : 'HH:mm:ss',
				showSecond : true,
				maxDate: serverDateStr,
				maxDateTime:$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
				onClose : function(dateText, inst) {
					if ($(this).attr('id').indexOf('fromDate') != -1) {
						$('#toDate').datetimepicker("option", "minDate",
								dateText);
						$('#toDate').datetimepicker("option", "minDateTime",
								$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',dateText));
					} else if ($(this).attr('id').indexOf('toDate') != -1) {
						$('#fromDate').datetimepicker("option", "maxDate",
								dateText);
						$('#fromDate').datetimepicker("option", "maxDateTime",
								$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',dateText));
					}
				}
			});
            
              
			});
		</script>
	</head>
	<body>
		<div id="container">
			<h2>
				Update Players Ledger

			</h2>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Update Players Ledger Form
					</h4>
				</div>
				<s:form theme="simple" id="updateLedger" method="POST"  action="st_csh_bo_update_players_ledger" target="searchResult" >
					<s:token name="strutsToken" id="strutsToken"></s:token>
					<div class="innerBox">
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Domain Name:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<div>
									<ss:select theme="myTheme" cssClass="select1"
										list="%{domainMap}"
										name="domainId" id="domainId" headerKey="-1"
										headerValue="--Please Select--"
										listKey="%{key}"
										listValue="%{value}" applyscript="true"></ss:select>
								</div>
							</div>
						</div>
						<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Date
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDivHalf">
							<ss:textfield name="fromDate" cssClass="dateField" id="fromDate" readonly="true"   theme="myTheme" applyscript="true"></ss:textfield>
							<ss:textfield name="toDate"  cssClass="dateField" id="toDate" readonly="true"  theme="myTheme" applyscript="true"></ss:textfield>
						</div>
						
					</div>
					<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Player ID's <em class="Req" style="color:green;">**</em></label>
					</div>
					<div class="InputDiv">
						<s:textfield id="playerIdList" name="playerList"/>
					</div>
				</div>
				<div class="FormMainBox" >
					 <p style="float: left;color:black"><b style="color: red;"> Note</b></p><br>
					 <b>					 
					<span id="criWiseMessage">&nbsp;&nbsp;<em class='Req' style='color:green;''>**</em> &nbsp; playerId's should be comma separated.</span>
				    </b>
				</div>
						</div>
						<div class="box_footer" align="right">
						<ss:submit theme="myTheme" id="submitBtn" value="submit" ></ss:submit>
					</div>
				</s:form>
			</div>
			<div id="searchResult"></div>
		</div>
	</body>
</html>
