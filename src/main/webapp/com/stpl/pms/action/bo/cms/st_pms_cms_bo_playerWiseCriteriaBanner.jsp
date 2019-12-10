<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Player Wise Banner jsp</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="<%=path%>/css/multiselect/chosen.css" rel="stylesheet"
			type="text/css" />
		<script type="text/javascript"
			src="<%=path%>/js/multiselect/chosen.jquery.js"></script>
			<script src="com/stpl/pms/action/bo/cms/js/cms.js" type="text/javascript"></script>
		<SCRIPT type="text/javascript">
		$(document).ready(function() {
			$('#domainId').change(function(){
				$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
	  			var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
	  			$.each(aliasMap,function(index, value) {
	  				$('#aliasId').append($('<option></option>').val(index).html(value));
	  			});
	  		});	
	  
			$("#aliasId").change(function(){
				var domainId=$("#domainId").val(); 
		   		$('#vipLevelList_chzn').remove();
				$('#vipLevelList').empty().removeClass('chzn-done').show();
				var jsonList = '["vipList"]';
				languageMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_commonData.action?domainId="+domainId+"&jsonList="+jsonList,"");
				if(domainId!="-1"){
				  $.each(languageMap["vipList"], function(
							index, value) {
						$('#vipLevelList').append($('<option></option>').val(value.vipLevel).html(value.vipCode));
					});
				  $('#vipLevelList').chosen('{}');
				  $('#referSelect').chosen('{}');
				}
			$('#campSelect_chzn').remove();
					$('#campSelect').empty().removeClass('chzn-done').show();
		   		campaignList = _ajaxCallText("com/stpl/pms/action/bo/cms/st_pms_cms_fetchCampNames.action?campType=PPC&aliasId="+$(aliasId).val());	  
				var campNames = $.parseJSON(campaignList);
				$("#campSelect").empty();
			      //  $("#campSelect").empty().append($('<option></option>').val("-1").html("----Please Select----"));
					$.each(campNames, function(i, value) {
							$("#campSelect").append(
									$('<option></option>').val(i).html(
											value));
					});
					
				if($("#domainId").val()>1){
					$(function(){
						$('#vipLevelList').chosen();
						$('#campSelect').chosen('{}');
					});
				}
				return false;	
		   });
		   
		   $("#listColumns").change(function(){
		   		var domainId=$("#domainId").val(); 
		   		var campaignList;
		   		if($("#ppcCheckBox").prop('checked')== true){
		   			$("#campaignPpc").show();
		   		}else{
		   			$("#campaignPpc").hide();
		   		}
		   });
		   var selectCri;
		   
		   $('input[id*=criWiseRadio]').click(function(){
		  		if(!$("#"+selectCri).is(':hidden')){
		   			$("#"+selectCri).hide();
		   		}
		   		if(selectCri){		   		
			   		$("[id=criteriaSelect_"+selectCri+"]").removeAttr("applyscript");
			   		$("[id=criteriaSelect_"+selectCri+"_bubbleTable]").hide();
		   		}
		   		
		   		selectCri =  $("input[id*=criWiseRadio]:checked").val();
		   		if(selectCri=='NONE'){
		   			$("#noteDiv").hide();
		   		}else{
		   			$("[id=criteriaSelect_"+selectCri+"]").attr("applyscript","true");
		   			$("#noteDiv").show();		   				
		   		}
		   		
		   		$("#"+selectCri).show();
		   });
		   
		   $("#placeHolderCriteria").submit(function(){
		   		var crVal = $("input[id*=criWiseRadio]:checked").val();
				if(crVal!='NONE'){					
					if(typeof document.getElementById('fileInput').files[0] == 'undefined')
						 values = $("#criteriaSelect_"+crVal).val();
					if(values!=""){
						valArr = values.split(",");
					
						$("#jsonData").val(	JSON.stringify(values));
					/* 	$.each(valArr,function(index,value){
							$("#placeHolderCriteria").append($('<input type="hidden" name="placeHolderCriteria.criteriaSelect" value="'+value+'">'));
						}); */
					}
				}
				
			});
			var values="";
		   var fileInput = document.getElementById('fileInput');    

		      fileInput.addEventListener('change', function(e) {
		          var file = fileInput.files[0];
		          
		          var regex = new RegExp("(.*?)\.(csv)$");

		          if (regex.test(file.name)) {
		              var reader = new FileReader();

		              reader.onload = function(e) {
		            	  values=reader.result;
		            	  $("#criteriaSelect_USER_NAMEWISE").val("");
		            	  $("#criteriaSelect_USER_NAMEWISE").prop('readonly', true);		            	 
		            	  $("#criteriaSelect_USER_NAMEWISE").removeAttr("applyscript");
		            	  $("[id=criteriaSelect_USER_NAMEWISE_errorDiv]").hide();
		            	  $("#isFile").val("Y");
		              }

		              reader.readAsText(file);    
		          } else {
		              alert("File not supported!");
		              userNameArr="";
		              $("#fileInput").val("");
		              $("#isFile").val("N");
		              $("#criteriaSelect_USER_NAMEWISE").removeProp('readonly');
		          }
		      });

		      $("#criteriaSelect_USER_NAMEWISE").change(function(){
		     	 if($(this).val()==""){ 
		     		 $("#userFile").show();
		     	 }else{
		     		 $("#userFile").hide();
		     		 $("#filenote").hide();
		     	 }
		       });
			
	  	});			
	 </SCRIPT>	
  </head>
  
  <body>
   <s:form id="placeHolderCriteria" theme="simple"  method="POST"
			action="st_pms_cms_placeHolderCriteria">
			<s:token name="strutsToken" id="strutsToken" />
			<s:hidden name="placeHolderCriteria.isFile" id="isFile" value="N"></s:hidden> 
			<s:hidden name="placeHolderCriteria.criteriaSelect" id="jsonData"></s:hidden>
    <div class="FormSection">
	  <div class="greyStrip">
					<h4>
						PlaceHolder-Content Criteria
					</h4>
	  </div>
	  <div class="innerBox">
	  			<div class="FormMainBox">
					<div class="labelDiv">
						<label>Domain Name</label> <em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<s:select name="domainId" id="domainId" list="%{domainMap}"
						 headerKey="-1" headerValue="--Please Select--" listKey="%{key}"
						 listValue="%{value}" cssClass="select1" applyscript="true"/> 
					</div>
				</div>
	  		<div class="clearFRM"></div>
	  			<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Alias Name:
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
								<ss:select theme="myTheme" cssClass="select1"
									list="%{}" name="aliasId" id="aliasId"
									headerKey="-1" headerValue="--Please Select--" applyscript="true"></ss:select>
						</div>
					</div>
	  		<div class="clearFRM"></div>
	  		
	  		<div class="FormMainBox">
				<div class="labelDiv">
					<label>Criteria Name</label> <em class="Req">*</em>
				</div>
				<div class="InputDiv">
					<s:textfield name="criteriaName" id="criteriaName" action="com/stpl/pms/action/bo/cms/st_pms_cms_availabalCriteria.action" ajaxParam="criteriaName" applyscript="true"/> 
				</div>
			</div>
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label>Player Type</label>
				</div>
				<div class="InputDiv">
					<s:radio name="placeHolderCriteria.plrType" list="#{'DEPOSITOR':'Depositor','FREE':'Free','BOTH':'Both'}" value="%{'BOTH'}"></s:radio>
				</div>
			</div>
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label>Vip-Level</label>
				</div>
				<div class="InputDiv">
					<ss:select theme="myTheme" cssClass="select1"
						list="%{vipLevelBeanList}" listKey="vipLevel" listValue="vipCode"
						data-placeholder="All vip levels" name="placeHolderCriteria.vipLevelId"
						id="vipLevelList" multiple="true"></ss:select>
				</div><br>
			</div>
			<br>
			<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label>Refer Type</label>
				</div>
				<div class="InputDiv">
					<div id="listColumns">
						<s:checkbox name="placeHolderCriteria.referFriend" id="referChkBox"></s:checkbox>
							<span class="inpSpan"> Refer Friend </span>
						<s:checkbox name="placeHolderCriteria.directPlayer" id="directChkBox"></s:checkbox>
							<span class="inpSpan"> Direct Player </span>
						<s:checkbox name="placeHolderCriteria.affiliatePlayer" id="affiliateChkBox"></s:checkbox>
							<span class="inpSpan">Affiliate Player</span>
						<s:checkbox name="placeHolderCriteria.olaPlayer" id="olaCheckBox"></s:checkbox>
							<span class="inpSpan"> OLA </span>
						<s:checkbox name="placeHolderCriteria.ppcPlayer" id="ppcCheckBox"></s:checkbox>
							<span class="inpSpan"> PPC </span>
					</div>	
				</div>
			</div>
			<div class="FormMainBox" id="campaignPpc" style="display: none"><div class="clearFRM"></div>
				<div class="labelDiv">
					<label>Campaign PPC</label>
				</div>
				<div class="InputDiv">
					<select name="placeHolderCriteria.ppcCampaign" class="select1" id="campSelect" multiple="multiple" data-placeholder="All Campaigns"></select>
				</div>
			</div><br>
		<div class="clearFRM"></div>
			<div class="FormMainBox">
				<div class="labelDiv">
					<label>Player Wise Criteria </label>
				</div>
				<div class="InputDiv">
						<s:radio name="placeHolderCriteria.criteriaWise" id="criWiseRadio"  list="#{'PLAYER_WISE':'Player ID','USER_NAMEWISE':'User name','EMAIL_WISE':'Player Emails','MOB_WISE':'Player Mobiles','NONE':'None'} " value="%{'NONE'}" ></s:radio>
				</div>
			</div>
			<div class="FormMainBox" id="PLAYER_WISE" style="display: none">
				<div class="labelDiv">
					<label>Player ID's <em class="Req" style="color:green;">**</em></label>
				</div>
				<div class="InputDiv">
					<s:textfield id="criteriaSelect_PLAYER_WISE"/>
				</div>
			</div>
			<div class="FormMainBox" id="USER_NAMEWISE" style="display: none">
				<div class="labelDiv">
					<label>User Name's <em class="Req" style="color:green;">**</em></label>
				</div>
				<div class="InputDiv" id="userIds">
					<s:textfield id="criteriaSelect_USER_NAMEWISE" style="width: 58%;float: left;"  maxLength="500" placeholder="Accept upto 500 characters"/>
					<div id="userFile">&nbsp;&nbsp;	<b> or</b>    <input type="file" id="fileInput" /> </div>	
						<span id="filenote" style="padding: 0 0 0 28px;">  .csv file only</span>
					
				</div>
			</div>
			<div class="FormMainBox" id="EMAIL_WISE" style="display: none">
				<div class="labelDiv">
					<label>Player Emails <em class="Req" style="color:green;">**</em></label>
				</div>
				<div class="InputDiv">
					<s:textfield id="criteriaSelect_EMAIL_WISE"/>
				</div>
			</div>
			<div class="FormMainBox" id="MOB_WISE" style="display: none">
				<div class="labelDiv">
					<label>Player Mobile's <em class="Req" style="color:green;">**</em></label>
				</div>
				<div class="InputDiv">
					<s:textfield id="criteriaSelect_MOB_WISE"/>
				</div>
			</div>
			<div class="FormMainBox" id="noteDiv" style="display: none">
					 <p style="float: left;color:black"><b style="color: red;"> Note</b></p><br>
					 <b>					 
					<span id="criWiseMessage">&nbsp;&nbsp;<em class='Req' style='color:green;''>**</em> &nbsp; values should be comma separated.</span>
				    </b>
			</div>
			<br>
			</div>
			<div class="clearFRM"></div>
			<div class="box_footer" align="right">
					<s:submit name="saveCriteria" value="Save Criteria" cssClass="button"></s:submit>
				</div>
		</div>	
		</s:form>
	<br>
  </body>
</html>
