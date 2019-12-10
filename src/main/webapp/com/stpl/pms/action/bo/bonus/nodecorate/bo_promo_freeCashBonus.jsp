<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

		<title>Bonus</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="<%=path%>/css/multiselect/chosen.css" rel="stylesheet"
			type="text/css" />
		<script type="text/javascript"
			src="<%=path%>/js/multiselect/chosen.jquery.js"></script>
		<SCRIPT type="text/javascript">
			$(document).ready(function(){
				$('#playerIdArr').chosen('{}');
				var bonusList = $.parseJSON($('#bonusList').val());
				$("#bonusId").change(function(){
					var bonusId=$(this).val();
					$.each(bonusList, function(i, value) {
						if(bonusId == value.bonusId)
						{
							if(value.bonusValueType=='FIXED')
							{
								$("#amount").val(value.bonusValue);
								$("#amount").prop("readonly", true);
							}
							else
							{
								$("#amount").val("");
								$("#amount").prop("readonly", false);
							}
						}
			 		});
				});
				$('#bonusFrm').submit(function(){
					var amt=$('#amount').val();
					var bonus=$("#bonusId").val();
					var errStr ="";
					var check=false;
					var amtCheck=true;
					if(amt>0 && bonus!=-1){
						$.each(bonusList,function(index,value){
							if(value.bonusId==bonus){
								errStr="Please Enter Amount Between "+value.activityValueMin+" and "+value.activityValueMax;
								if(amt >=value.activityValueMin && amt<=value.activityValueMax){
									check=true;
									amtCheck=false;
								}
							}
						});
					}else{
						alert("Please Select Bonus or Amount");
						amtCheck=false;
					}
					if(check && !amtCheck){
						if($('#playerIdArr').val()==null){
							alert("Please select atleast one player.");
							check = false;
						}
					}
					if(amtCheck){
						alert(errStr);
					}
					
					return check;
				});
			});
		</SCRIPT>
	</head>

	<body>
		<div class="clear2"></div>
		<h2>
			Free Cash
		</h2>
		<s:if test="%{domainId!=null && domainId!=0}">
		<s:if test="%{bonusList!=null && bonusList.size()>0}">
		<s:form id="bonusFrm" action="bo_promo_giveFreeCash" theme="simple">
	    <s:token name="strutsToken" id="strutsToken" theme="simple"></s:token>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Free Cash
					</h4>
				</div>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Select Bonus
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:hidden id="bonusList" value="%{bonusStr}"></s:hidden>
							<ss:select theme="simple" cssClass="select1" list="%{bonusList}"
								 id="bonusId" headerKey="-1" name="bonusId"
								headerValue="--Please Select--" listKey="%{bonusId}"
								listValue="%{bonusDispCode}"></ss:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Select Player
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select theme="myTheme" cssClass="select1" list="%{playerMap}"
								multiple="true" data-placeholder="Select Player Here"
								name="playerIdArr" id="playerIdArr"></s:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Amount
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield id="amount" name="amount"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
				</div>
				<div class="box_footer" align="right">
					<s:submit value="Submit" id="submitBonus"></s:submit>
				</div>
				</div>
		</s:form>
		</s:if>
		<s:else>
			<div class="clear2"></div>
			<!-- error messsge  start -->
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Message
					</h4>
				</div>
				<div class="innerBox">
					<div class="alert info_msg " style="width: 90%">
						<span class="alert_close"></span><strong>Info: </strong>No Bonus Available for Selected Domain!!
					</div>
				</div>
			</div>
			<!-- error messsge  end -->
		</s:else>
		</s:if>
		<s:else>
			<div class="clear2"></div>
			<!-- error messsge  start -->
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Message
					</h4>
				</div>
				<div class="innerBox">
					<div class="alert info_msg "  style="width: 90%">
						<span class="alert_close"></span><strong>Info: </strong>No Player Selected for Domain!!
					</div>
				</div>
			</div>
			<!-- error messsge  end -->
		</s:else>
	</body>
</html>
