<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Payment Type Content</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		
		<script type="text/javascript">
			$(document).ready(function(){
				
			$(function() {
					$('#uploadContentFrm').submit(function(){
						var contentArray = new Object();
						var isValid = false;
						$('#uploadContentFrm > .innerBox').children('.FormMainBox').each(function(){
							var payTypeCode = $(this).attr('id').replace('FormMainBox_', '');
							var content = $.trim($(this).find(' > .InputDiv1 > textarea[id*=payTypeContent_]').val());
							var payTypeId = $(this).find(' > .InputDiv1 > input[id*=payTypeIds_]').val();
							var domainId = $('#domainId').val();
							var txnType = $('#txnType').val();
							var status = content.length!=0?'ACTIVE':'INACTIVE';
							var contentId = $(this).find(' > .InputDiv1 > input[id*=contentIds_]').val();
							contentArray[payTypeId] = new payTypeContentObj(contentId,payTypeId,payTypeCode,domainId,txnType,content,status);
						});
						$('#contentJsonData').val(JSON.stringify(contentArray));
					});
					
				});
				
			});
			
			
			function payTypeContentObj(contentId,payTypeId,payTypeCode,domainId,txnType,content,status) {
				this.contentId= contentId;
				this.payTypeId = payTypeId;
				this.payTypeCode = payTypeCode;
				this.domainId = domainId;
				this.txnType = txnType;
				this.content = content;
				this.status = status;
			}
			
			
	
</script>
	</head>

	<body>
		<div class="FormSection">
		<s:if test="%{payTypeContentMap.size()>0}">
			<div class="greyStrip">
				<h4>
					Payment Type Content
				</h4>
			</div>
			<s:form id="uploadContentFrm"
				action="st_pms_bo_csh_uploadPayTypeContent" theme="simple" enctype="multipart/form-data" >
				<s:token name="strutsToken" id="strutsToken"></s:token>
				<div class="innerBox">
					<s:iterator value="%{payTypeContentMap}" status="payContent">
						<div class="FormMainBox" id="FormMainBox_<s:property value="%{value.payTypeCode}" />">
							<div class="labelDiv">
								<label>
									<s:property value="%{value.payTypeDispCode}" />
								</label>
							</div>
							<div class="InputDiv1" id="InputDiv1_<s:property value="%{value.payTypeCode}" />">
								<s:hidden id="payTypeIds_%{value.payTypeId}"
									value="%{value.payTypeId}"></s:hidden>
								<s:hidden id="contentIds_%{value.contentId}"
									value="%{value.contentId}"></s:hidden>
								<s:textarea name="content"
									id="payTypeContent_%{value.payTypeId}" cols="93" rows="5"
									cssStyle="width:98%;" value="%{value.content}"></s:textarea>
							</div>
						</div>
						<div class="clearFRM"></div>
					</s:iterator>
				</div>
				<div class="box_footer" align="right">
					<s:hidden name="contentJsonData" id="contentJsonData"></s:hidden>
					<s:hidden name="domainId" value="%{domainId}"></s:hidden>
					<s:hidden name="txnType" value="%{txnType}"></s:hidden>
					<s:hidden name="device" value="%{device}"></s:hidden>
					<s:submit theme="simple" id="submitBtn" value="Save"></s:submit>
				</div>
				</s:form>
		</s:if>
		<s:else>
			<div class="greyStrip">
				<h4>
					Error Message
				</h4>
			</div>
			<div class="innerBox">
				<div class="alert info_msg ">
					<span class="alert_close"></span><strong>Msg: </strong>No Record
					Found.
				</div>
			</div>
		</s:else>
</div>
	</body>
</html>
