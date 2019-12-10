<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>PG Settlement Report</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="<%=path%>/css/jquery.ui.theme.min.css" rel="stylesheet" type="text/css" />
		<SCRIPT type="text/javascript">
			$(document).ready(function() {
				$(".dateField").datetimepicker(
					{
						dateFormat : 'dd/mm/yy',
						timeFormat : 'HH:mm:ss',
						showSecond : true,
						maxDate : '+0',
						onClose : function(dateText, inst) {
							if ($(this).attr('id').indexOf('fromDate') != -1) {
								$('#toDate').datetimepicker("option", "minDate",
										dateText);
								$('#toDate').datetimepicker("option", "minDateTime",
										new Date(dateText));
							} else if ($(this).attr('id').indexOf('toDate') != -1) {
								$('#fromDate').datetimepicker("option", "maxDate",
										dateText);
								$('#fromDate').datetimepicker("option", "maxDateTime",
										new Date(dateText));
							}
						}
					});
              $('#fromDate').datetimepicker('setDate', '-1m');  
               $('#toDate').datetimepicker('setDate', new Date());  
               
                $('#plrDepoSearchFrm :input, select').change(function(){
                	$('#searchResult').html('');
                });
                $('form').submit(function() {
					return ajaxCall(this);
				});
				
                $('#submitBtn').click(function(){
                if($('#providerId').val()==-1){
                $('errorDiv'.show());
                	createBubble();}
                	$("#submitBtn").hide();
        			$("#waitDiv").show();
        			$("#submitBtn").attr("disabled",true);
         			$("#plrDepoSearchFrm").submit();
                });
			});
		function ajaxCall(form) {
					var form = $(form);
					var target = form.attr('target');
					var callback = (typeof form.attr('callBack') !== 'undefined') ? form
							.attr('callBack') : '';
					$.ajax( {
						type : "POST",
						url : form.attr('action'),
						data : form.serialize(),
						success : function(result) {
							$('#' + target).html(result);
							eval('createBubble()');
							if (callback != '') {
								eval(callback);
							}
						}
					});
					return false;
				}
		</SCRIPT>
	</head>

	<body>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>PG Settlement Report </h4>
			</div>
			<s:form id="plrDepoSearchFrm" action="st_pms_bo_rep_pgSettlementReport" target="searchResult" theme="simple">
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Provider Name
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:select theme="myTheme" cssClass="select1" applyscript="true"
								list="%{paymentProviderMap}" name="providerId" id="providerId" 
								headerKey="-1" headerValue="--Please Select--" ></ss:select>
						</div>
					</div>
					<div class="bubble-div" style="display:none"><div class="fieldError" id="errorDiv"><p>Select one Provider</p></div></div>
					<div class="clearFRM"></div>
					
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Date
							</label>
						</div>
						<div class="InputDivHalf">
							<ss:textfield name="fromDate" id="fromDate" cssClass="dateField"  readonly="true" theme="myTheme" applyscript="true"></ss:textfield>
							<ss:textfield name="toDate" cssClass="dateField" id="toDate" readonly="true" theme="myTheme" applyscript="true"></ss:textfield>
						</div>
						
					</div>
					
				</div>
				<div class="box_footer" align="right">
					<div id="waitDiv" class="animated-button-div" style="margin-left: 0px; display: none;" >
						<div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
					</div>
					<s:submit theme="simple" id="submitBtn" value="Search"></s:submit>
				</div>
			</s:form>
		</div>
		<div id="searchResult">

		</div>
	</body>
</html>
