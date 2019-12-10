<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Payment Correction</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript"
			src="com/stpl/pms/action/bo/reports/js/common_report.js"></script>
		<script>
		 $(document).ready(function(){
		setDefaultDate();
		
		 $("#submitBtn").click(function(){
			 if($('#domainId').val()==-1){
				 $('errorDiv'.show());
             	createBubble();}
	          
	                
		  	$("#startIndex").val("0");
	         $("#payCorrectionFrm").attr("target","searchResult");
	         $("#submitBtn").hide();
	         $("#waitDiv").show();
	         $("#submitBtn").attr("disabled",true);
	         $("#payCorrectionFrm").submit();
	         return false;
	      });	


			 loadAliasName($("#domainId").val());
			$('#domainId').change(function() {
			if($("#domainId").val()=="-1"){
				 $('errorDiv'.show());
             	createBubble();
            	$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
			}else{
					$('#aliasId').removeAttr('disabled');
					$("#aliasId").html("");
					loadAliasName($(this).val());
				}
			});
			function loadAliasName(domainId){
				var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+domainId,"");
				$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
				$.each(aliasMap,function(index, value) {
					$('#aliasId').append($('<option></opplayerSearchMenution>').val(index).html(value));
			  	});
		}
		});
		</script>
	</head>

	<body>
		<div class="FormSection">

			<div class="greyStrip">
				<h4>
					<s:property value="%{headerName}"/>
				</h4>
			</div>
			<s:form id="payCorrectionFrm" action="st_pms_bo_rep_searchReport"
				cssClass="jsonFrm" target="searchResult" theme="simple" callBack="attachEvent('searchResult')">
				<s:hidden name="reportData" id="reportData"></s:hidden>
				<s:hidden name="procName" id="procName" value="%{procName}"></s:hidden>
				<s:hidden name="startIndex" id="startIndex" value="0"></s:hidden>
				<s:hidden name="recordTofetch" id="recordTofetch" value="101"></s:hidden>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Domain
							</label><em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<div>
								<s:hidden  value="%{reportCurrency}" id="reportCurrency" requestParam="YES"></s:hidden>
								<s:if test="%{domainId>1}">
									<s:hidden  value="%{domainId}" id="domainId" requestParam="YES"></s:hidden>
									<s:property value="%{domainName}"/>
								</s:if>
								<s:else>
									<s:select theme="myTheme" cssClass="select1"
										list="%{domainMap}"
										id="domainId" headerKey="-1"
										headerValue="--Please Select--" listKey="%{key}"
										listValue="%{value}" value="%{bydefaultSelectedDomain}" applyscript="true"></s:select>
								</s:else>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Alias </label>
				</div>
				<div class="InputDiv">
					<div>
							<ss:select theme="myTheme" cssClass="select1" list="%{}" id="aliasId" headerKey="-1"
									headerValue="--Please Select--"  >
								</ss:select>


					</div>
				</div>
			</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								From Date 
							</label>
						</div>
						<div class="InputDivHalf">
							<ss:textfield id="fromDate" cssClass="dateField" theme="myTheme"  readonly="true"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								To Date
							</label>
						</div>
						<div class="InputDivHalf">
							<ss:textfield id="toDate" cssClass="dateField" theme="myTheme"  readonly="true"></ss:textfield>
						</div>
					</div>
					 <div class="clearFRM"></div>
			             <div class="FormMainBox">

						 <div class="labelDiv"><s:label value="Player Alias:" theme="simple"/></div>
			                <div class="InputDiv">
								<ss:textfield id="userName" cssClass="small-text-box-div-new" cssStyle="width:50%" theme="myTheme"></ss:textfield>
						</div></div>
						
					<div class="clearFRM"></div>
				

				</div>
				<div class="box_footer" align="right">
					<div id="waitDiv" class="animated-button-div" style="margin-left: 0px; display: none;" >
						<div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
					</div>
					<s:submit name="Search" value="Search"  id="submitBtn" cssClass="button"></s:submit>
				</div>
			</s:form>
		</div>
		<div id="searchResult">

		</div>
	</body>
</html>
