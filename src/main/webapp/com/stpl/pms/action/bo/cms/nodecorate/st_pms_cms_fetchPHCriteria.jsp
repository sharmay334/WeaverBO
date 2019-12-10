<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
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
<SCRIPT type="text/javascript">
	$(document).ready(function() {
		$("#vipLevelList").chosen();
	 	$("#campSelect").chosen();
		$("#listColumns").change(function(){
			if($("#ppcCheckBox").prop('checked')){
		   		$("#campaignPpc").show();
		   	} else {
		   		$("#campaignPpc").hide();
		   	}
		});
		if($("#listColumns").find("#ppcCheckBox").prop('checked')) {
			$("#campaignPpc").show();
		}
		if($("input[id*=criWiseRadio]:checked").val()!='NONE'){
			$("#noteDiv").show();
		}	
			
		var selectCri = $("input[id*=criWiseRadio]:checked").val();
		$("#"+selectCri).show();
		$('input[id*=criWiseRadio]').click(function(){
			if(selectCri!=$("input[id*=criWiseRadio]:checked").val()) {
		   		if(!$("#"+selectCri).is(':hidden')){
		   			$("#criteriaSelect_"+selectCri).val('');
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
		            	  setBrowseFileData(values);
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

		      $("#editUserName").click(function(){
		  		$("#userNameFieldDiv").show();		
		  		$("#criteriaSelect_USER_NAMEWISE").val("");
		  		$("#isFile").val("N");
		  		$("#userFileLink").hide();		
		  		$(this).hide();
		  		return false;
		  	});
		
		createBubble();	
		if(selectCri=='USER_NAMEWISE')
			fileDownload();
		
	});	

	function fileDownload(){

		if($("#isFile").val()=='Y'){
			$("#userNameFieldDiv").hide();
			$("#userFileLink").click(function(){
				$(this).attr("href",'data:csv/plain;charset=utf-8,' + encodeURIComponent($("#criteriaSelect_USER_NAMEWISE").val()));			
			});
		}
		
		
	}		
</SCRIPT>	
  </head>
	<body>
	
		<s:hidden name="placeHolderCriteria.isFile" id="isFile" ></s:hidden>
		<s:hidden name="placeHolderCriteria.criteriaSelect" id="jsonData"></s:hidden>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>PlaceHolder-Content Criteria</h4>
			</div>
			<div class="innerBox">
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Player Type</label>
					</div>
					<div class="InputDiv">
						<s:radio name="placeHolderCriteria.plrType"
							list="#{'DEPOSITOR':'Depositor','FREE':'Free','BOTH':'Both'}"
							value="%{placeHolderCriteria.plrType}"></s:radio>
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
							data-placeholder="All vip levels"
							name="placeHolderCriteria.vipLevelId" id="vipLevelList"
							multiple="true" value="%{placeHolderCriteria.vipLevelId}"></ss:select>
					</div>
					<br>
				</div>
				<br>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Refer Type</label>
					</div>
					<div class="InputDiv">
						<div id="listColumns">
							<s:checkbox name="placeHolderCriteria.referFriend"
								id="referChkBox" value="%{placeHolderCriteria.referFriend}"></s:checkbox>
							<span class="inpSpan"> Refer Friend </span>
							<s:checkbox name="placeHolderCriteria.directPlayer"
								id="directChkBox" value="%{placeHolderCriteria.directPlayer}"></s:checkbox>
							<span class="inpSpan"> Direct Player </span>
							<s:checkbox name="placeHolderCriteria.affiliatePlayer"
								id="affiliateChkBox"
								value="%{placeHolderCriteria.affiliatePlayer}"></s:checkbox>
							<span class="inpSpan">Affiliate</span>
							<s:checkbox name="placeHolderCriteria.olaPlayer"
								id="olaChkBox"
								value="%{placeHolderCriteria.olaPlayer}"></s:checkbox>
							<span class="inpSpan">OLA</span>
							<s:checkbox name="placeHolderCriteria.ppcPlayer" id="ppcCheckBox"
								value="%{placeHolderCriteria.ppcPlayer}"></s:checkbox>
							<span class="inpSpan"> PPC </span>
						</div>
					</div>
				</div>
				<div class="FormMainBox" id="campaignPpc" style="display: none;">
					<div class="clearFRM"></div>
					<div class="labelDiv">
						<label>Campaign PPC</label>
					</div>
					<div class="InputDiv">
						<ss:select name="placeHolderCriteria.ppcCampaign"
							list="%{placeHolderCriteria.campNames}"
							value="%{placeHolderCriteria.ppcCampaign}" class="select1"
							id="campSelect" multiple="true" data-placeholder="All Campaigns"></ss:select>
					</div>
				</div>
				<br>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Player Wise Criteria</label>
					</div>
					<div class="InputDiv">
						<s:radio name="placeHolderCriteria.criteriaWise" id="criWiseRadio"
							list="#{'PLAYER_WISE':'Player ID','USER_NAMEWISE':'User name','EMAIL_WISE':'Player Emails','MOB_WISE':'Player Mobiles','NONE':'None'} "
							value="%{placeHolderCriteria.criteriaWise}"></s:radio>
					</div>
				</div>
				<div class="FormMainBox" id="PLAYER_WISE" style="display: none;">
					<div class="labelDiv">
						<label>Player ID's<em class="Req" style="color:green;">**</em></label>
					</div>
					<div class="InputDiv">
						<s:textfield id="criteriaSelect_PLAYER_WISE"
							value="%{placeHolderCriteria.criteriaWise=='PLAYER_WISE'?placeHolderCriteria.getCriteriaSelect().toString().replaceAll('^\\\\[|]$', ''):''}" />
					</div>
				</div>
				<div class="FormMainBox" id="USER_NAMEWISE" style="display: none">
					<div class="labelDiv">
						<label>User Name's<em class="Req" style="color:green;">**</em></label>
					</div>
					<div class="InputDiv" id="userIds">
						<s:if test="%{placeHolderCriteria.isFile == \"Y\"}">
											<a id="userFileLink" href="#" download="UserList.csv">Download File </a>
											<span><button id="editUserName" style="margin: 0 !important;" class="editAction">Edit</button></span>
											<%-- <span><a id="editUserName" href="#">Edit User Name List</a></span> --%>																		
							</s:if>
						<div id="userNameFieldDiv">	
							<s:textfield id="criteriaSelect_USER_NAMEWISE"
								value="%{placeHolderCriteria.criteriaWise=='USER_NAMEWISE'?placeHolderCriteria.getCriteriaSelect().toString().replaceAll('^\\\\[|]$', ''):''}" style="width: 58%;float: left;"  maxLength="500" placeholder="Accept upto 500 characters" />
							<div id="userFile">&nbsp;&nbsp;	<b> or</b>    <input type="file" id="fileInput" /> </div>	
							<span id="filenote" style="padding: 0 0 0 28px;">  .csv file only</span>
						</div>		
					</div>
				</div>
				<div class="FormMainBox" id="EMAIL_WISE" style="display: none">
					<div class="labelDiv">
						<label>Player Emails<em class="Req" style="color:green;">**</em></label>
					</div>
					<div class="InputDiv">
					
						
							<s:textfield id="criteriaSelect_EMAIL_WISE"
								value="%{placeHolderCriteria.criteriaWise=='EMAIL_WISE'?placeHolderCriteria.getCriteriaSelect().toString().replaceAll('^\\\\[|]$', ''):''}" />
							
					</div>
				</div>
				<div class="FormMainBox" id="MOB_WISE" style="display: none">
					<div class="labelDiv">
						<label>Player Mobile's<em class="Req" style="color:green;">**</em></label>
					</div>
					<div class="InputDiv">
						<s:textfield id="criteriaSelect_MOB_WISE"
							value="%{placeHolderCriteria.criteriaWise=='MOB_WISE'?placeHolderCriteria.getCriteriaSelect().toString().replaceAll('^\\\\[|]$', ''):''}" />
					</div>
				</div>
				<br>
			</div>
			<div class="FormMainBox" id="noteDiv" style="display: none">
					 <p style="float: left;color:black"><b style="color: red;"> Note</b></p><br>
					 <b>					 
					<span id="criWiseMessage">&nbsp;&nbsp;<em class='Req' style='color:green;''>**</em> &nbsp; values should be comma separated.</span>
				    </b>
			</div>
			<div class="clearFRM"></div>
			<div class="box_footer" align="right">
				<s:submit name="editCrit" value="Submit" cssClass="button"></s:submit>
			</div>
		</div>
		<br>
	</body>
</html>
