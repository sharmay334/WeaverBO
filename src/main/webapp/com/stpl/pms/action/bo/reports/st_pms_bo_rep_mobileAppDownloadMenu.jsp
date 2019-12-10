<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>Mobile App Download Report</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript"
	src="com/stpl/pms/action/bo/reports/js/common_report.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/jQuery/jquery.mtz.monthpicker.js"></script>
<script>
	$(document).ready(function(){
		setDefaultDate();
		 $("#searchBtn").click(function(){
		 if($('#reportType').val()==-1){
                	$('errorDiv'.show());
                	createBubble();
              }
	         $("#searchBtn").hide();
	         $("#waitDiv").show();
	         $("#searchBtn").attr("disabled",true);
	         $( "#reportTable_next" ).die( "click" );
			 $( "#reportTable_previous" ).die( "click" );
	         $("#appReport").submit();
	         return false;
	      });	
			
	});
</script>
</head>
<body>
	<div class="FormSection">
		<div class="greyStrip">
			<h4>Mobile App Download Report</h4>
		</div>
		<s:form id="appReport" action="st_pms_bo_rep_searchReport"
			target="searchResult" theme="simple" cssClass="jsonFrm">
			<s:hidden name="reportData" id="reportData"></s:hidden>
			<s:hidden name="procName" value="mobileAppDownloadDetail"></s:hidden>
			<s:hidden name="startIndex" id="startIndex" value="0"></s:hidden>
			<s:hidden name="recordTofetch" id="recordTofetch" value="101"></s:hidden>
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Domain </label>
					</div>
					<div class="InputDiv">
						<div>
							<s:if test="%{domainId>1}">
								<s:hidden value="%{domainId}" id="domainId" requestParam="YES"></s:hidden>
								<s:property value="%{domainName}" />
							</s:if>
							<s:else>
								<s:select theme="myTheme" cssClass="select1" list="%{domainMap}"
									id="domainId" headerKey="0" headerValue="--All Domain--"
									listKey="%{key}" listValue="%{value}"
									value="%{bydefaultSelectedDomain}"></s:select>
							</s:else>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> From Date </label>
					</div>
					<div class="InputDivHalf">
						<ss:textfield id="fromDate" cssClass="dateField" theme="myTheme"
							value=""></ss:textfield>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> To Date </label>
					</div>
					<div class="InputDivHalf">
						<ss:textfield id="toDate" cssClass="dateField" theme="myTheme"
							value=""></ss:textfield>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
				 
					<div class="labelDiv">
						<label> Report Type </label><em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select theme="myTheme" cssClass="select1"
							list="#{'msgSend':'Request For Message','appDownLoad':'Visit Link To Download(Direct Download)'}"
							id="reportType" headerKey="-1" headerValue="--Please Select--"
							applyscript="true" applyScript="true"></ss:select>
					</div>
				</div>
				<div class="clearFRM"></div>
			</div>
			<div class="box_footer" align="right">
				<div id="waitDiv" class="animated-button-div" style="margin-left: 0px; display: none;" >
						<div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
				</div>
				<s:submit name="Search" value="Search" id="searchBtn" cssClass="button"></s:submit>
			</div>
		</s:form>
	</div>
	<div id="searchResult"></div>
</body>
</html>
