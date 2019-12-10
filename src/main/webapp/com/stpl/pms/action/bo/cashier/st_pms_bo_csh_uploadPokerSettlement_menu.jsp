<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

		<title>Upload Payment Gateway Settlement</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript">
			$(document).ready(function() {
					$("#domainId").change(function(){
					var vendorAvailable = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_check_domainVendorAvailable.action?vendorCode=POKER&domainId="+$(this).val(),"");
					$('#providerName').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					if(vendorAvailable)
						$('#providerName').append($('<option></option>').val("POKER").html("POKER"));
				  	 
	
				});		
			});
		</script>
		
	</head>

	<body>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>
					Upload Payment Poker Settlement Data
				</h4>
			</div>

			<s:form id="uploadData"
				action="st_pms_bo_csh_uploadPokerSettlement_Save" theme="simple" enctype="multipart/form-data" method="post">
				<s:token name="strutsToken" id="strutsToken"></s:token>
				<div class="innerBox">
				<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Domain Name
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:if test="%{domainId>1}">
								<s:hidden name="domainId" value="%{domainId}" id="domainId"></s:hidden>
								<s:property value="%{domainName}"/>
							</s:if>
							<s:else>
								<s:select theme="myTheme" cssClass="select1"
									list="%{domainMap}"
									name="domainId" id="domainId" headerKey="-1"
									headerValue="--Please Select--" listKey="%{key}"
									listValue="%{value}" applyscript="true"  ></s:select>
							</s:else>
							
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Provider Name
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select theme="myTheme" cssClass="select1" applyscript="true"
								list="{}" name="providerName" id="providerName" 
								headerKey="-1" headerValue="--Please Select--" ></s:select>					
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Upload File
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:file name="pokerSettlement" id="pokerSettlement" applyscript="true" accept=".csv" theme="myTheme"></s:file>
						</div>
						<div class="FormMainBox" style="height: 10px;">
							<p style="float: left;color:black">
								<b style="color: green;"> Note :</b> <b> <span> Accept csv file format only </span> </b>
							</p>
						</div>
					</div>
				</div>
				<div class="box_footer" align="right">
					<s:submit theme="simple" id="submitBtn" value="Upload File"></s:submit>
				</div>
			</s:form>
		</div>
	</body>
</html>
