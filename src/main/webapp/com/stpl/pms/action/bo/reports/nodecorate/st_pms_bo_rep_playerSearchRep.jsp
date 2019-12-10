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

		<title>Search Data</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="css/facebox_bigsize.css" media="screen" rel="stylesheet"
			type="text/css" />
		<script src="js/facebox.js" type="text/javascript"></script>
		<SCRIPT type="text/javascript">
		
		var control = {};
			control.modal=function(message,type){
					try{
					if(type==undefined)
						type="info";
					$.facebox(" <div class='FormSection'>"+
					"<div class='greyStrip'>"+
					"<h4>"+"Message"+"</h4>"+
					"</div>"+
					"<div class='innerBox'>"
								+"<div class='alert info_msg' style='width: auto'>"
									+"<span class='alert_close'></span><strong>"+type+": </strong>"+
								message+"</div>"
							+"</div>"
						+	"<button onclick='$.facebox.close()'>close</button>"
						+"</div>"
							);
					}catch (e) {
						alert("facebox.js not loaded properly!!");
						}
				};
		
		$(document).ready(function(){
			$("#facebox").remove();
  			$("#pagination").paginate({
				count 		: $('#totalPlr').val(),
				start 		: $('#paginationPage').val(),
				display     : $('#recordPerPage').val(),
				border					: false,
				text_color  			: '#888',
				background_color    	: '#EEE',	
				text_hover_color  		: 'black',
				mouse		: 'press',
				background_hover_color	: '#CFCFCF'
			});
                                      
              $('#recordPerPage').change(function(){
              	$('#paginationPage').val(1);
              	$('#formSubmit').submit();
              });
              $('[id*=paginationPage_]').click(function(){
              $('#paginationPage').val($(this).attr('value'));
               $('#redirect').val("Search");
              	$('#formSubmit').submit();
              });
              
              $('#redirectPage').click(function(){
              $('#paginationPage').val($('#redirectPageNo').val());
               $('#redirect').val("Search");
              	$('#formSubmit').submit();
              });
              $('#redirectPrev').click(function(){
              	$('#paginationPage').val(parseInt($('#paginationPage').val())-1);
              	 $('#redirect').val("Search");
              	$('#formSubmit').submit();
              });
				
              $('#redirectFirst').click(function(){
              	$('#paginationPage').val(1);
              	$('#formSubmit').submit();
              });
              
              $('.jPag-first').click(function(){
              $('#paginationPage').val(1);
               $('#redirect').val("Search");
              $('#formSubmit').submit();
              });
              
              $('.jPag-last').click(function(){
               var totalPage=parseInt(Math.ceil($('#totalPlr').val()/$('#recordPerPage').val()));
               $('#paginationPage').val(totalPage);
                $('#redirect').val("Search");
              $('#formSubmit').submit();
              });
              
              
		
		$('a[id*=resetPlayerPass_]').click(function(){
 		var isValid = false;
 		var name = $(this).attr('name');
 		if(confirm("Do you want to reset password for Player "+name)){
 			isValid=true;
 		}
 		if(isValid){
 			var anchor = $(this);
			var linkArr = $(this).attr('href').split('?');
			$.ajax( {
				type : "POST",
				url : linkArr[0],
				data : linkArr[1],
				async : false,
				success : function(result, arguments, text) {
					alert("Reset Password mail is sent to player.");				
				}
			});
 		}
 		return false;
	 });
		$.each(globalCheckList,function(index,value){
			$('input[type=checkBox]#'+value).attr('checked','checked');
			$('.'+value).show();
		});
				
		$("input[type=checkbox]").click(function() {
				var classId = $(this).attr('class');
				 if($(this).is(':checked')) {
				 	$('.'+classId).show();
				 	globalCheckList.push(classId);
				 }else{
				 	globalCheckList.splice(globalCheckList.indexOf(classId),1);
					 $('.'+classId).not('input[type=checkbox]').hide();
				 }
			});
				
			$('#allCheckBox').click(function(){
				if(($(this).attr('checked')!='checked') && (typeof $(this).attr('checked')=='undefined')) {
		 		$(this).removeAttr('checked');
		 		$('[id^=checkBoxId_]').removeAttr('checked');
		 		}else{
				$(this).attr('checked','true');
				$('[id^=checkBoxId_]').attr('checked','true');
		 		}
			});
			$('[id*=checkBoxId_]').click(function(){
				if(($(this).attr('checked')!='checked') || (typeof $(this).attr('checked')=='undefined')) {
		 		$(this).removeAttr('checked');
		 		}else{
				$(this).attr('checked','true');
		 		}
			});
			
			$( "#accordion" ).accordion({
					collapsible : true,
					clearStyle : true,
					icons : {
					header : "plus",
					headerSelected : "minus"
					},
					active : false 
			});
			
			$('#sendPlrMail').click(function(){
				var isValid = true;
				var plrList = new Object();
				$('[id*=checkBoxId_]:checked').each(function(index,value){
					var checkBox = $(this);
					if(($(this).attr('checked')=='checked') && (typeof $(this).attr('checked')!='undefined')) {
						isValid = true;
						plrList[$(this).val()] = $(this).attr('class');
					}
				});
				plrList = JSON.stringify(plrList);
				if(isValid){
					$('#sendPlrMail').attr('href','com/stpl/pms/action/bo/pm/st_pm_plr_emailDispatch.action?plrIdList='+plrList+'&domainId='+$('#domainId').val()+'&allPlr=true');
				} else{
					$('#sendPlrMail').attr('href','com/stpl/pms/action/bo/pm/st_pm_plr_emailDispatch.action');
				}
				
				return isValid;
			});
			$('a[id*=viewPlayerDetails_]').click(function(){
				AjaxCall($(this));
			});
			
			$('#pushAppVersion').click(function(){
				var isValid = false;
				var domainId = $("#domainId").val();
				var aliasId = $("#aliasId").val();
				if(domainId==-1){
					control.modal("please select domain name!");
					return isValid;	
				} if(aliasId==-1){
					control.modal("please select alias name!");
					return isValid;	
				}
				var plrList = new Object();
				$('[id*=checkBoxId_]:checked').each(function(index,value){
					if((typeof $(this).attr('checked')!='undefined') && ($(this).attr('checked')=='checked')) {
						plrList[$(this).val()] = $(this).attr('class');
					}
				});
				plrList = JSON.stringify(plrList);
				jQuery.facebox({ ajax: 'com/stpl/pms/action/bo/pm/st_pm_plr_appUpdatePanel.action?plrIdList='+plrList+'&domainId='+domainId+'&aliasId='+aliasId });
			});
			
			$('#sendPlrNotification').click(function(){
				var isValid = true;
				var plrList = new Object();
				var aliasId = $("#aliasId").val();
				
				if(aliasId==-1){
					control.modal("please select alias name!");
					console.log("please select alias name!");
					isValid=false;
					return false;	
				}
				$('[id*=checkBoxId_]:checked').each(function(index,value){
					var checkBox = $(this);
					if(($(this).attr('checked')=='checked') && (typeof $(this).attr('checked')!='undefined')) {
						isValid = true;
						plrList[$(this).val()] = $(this).attr('class');
					}
				});
				plrList = JSON.stringify(plrList);
				if(isValid){
					jQuery.facebox({ ajax: 'com/stpl/pms/action/bo/pm/st_pm_plr_notificationDispatch.action?plrIdList='+plrList+'&aliasId='+aliasId });
				} else{
					jQuery.facebox({ ajax: 'com/stpl/pms/action/bo/pm/st_pm_plr_notificationDispatch.action' });
				}
				
				return isValid;
			});
			
			
			$('#freeBonus').click(function(){
				var isValid = false;
				var plrList = new Object();
				$('[id*=checkBoxId_]:checked').each(function(index,value){
					var checkBox = $(this);
					if(($(this).attr('checked')=='checked') && (typeof $(this).attr('checked')!='undefined')) {
						isValid = true;
						plrList[$(this).val()] = $(this).attr('class');
					}
				});
				plrList = JSON.stringify(plrList);
				if(isValid){
					$('#freeBonus').attr('href','com/stpl/pms/action/bo/bonus/bo_promo_freeCashBonus.action?plrList='+plrList+'&domainId='+$('#domainId').val()+'&aliasId='+$('#aliasId').val());
				}
				else{
					$('#freeBonus').attr('href','com/stpl/pms/action/bo/bonus/bo_promo_freeCashBonus.action');
				}
				return isValid;
			});
			$('#changePlrVip').click(function(){
				var isValid = false;
				var param = '';
				var plrList = new Object();
				var plrDomainId = '';
				var prevDomainId = '-1';
				if($('[id*=checkBoxId_]:checked').length > 0){
					$('[id*=checkBoxId_]:checked').each(function(index,value){
						plrDomainId = $('input[id=playerDomainId_'+$(this).val()+']').val();
						if(prevDomainId =='-1' || plrDomainId == prevDomainId){
							prevDomainId =plrDomainId;
							plrList[$(this).val()] = $(this).attr('class');
							isValid = true;
						}else{
							errorMsg = "Player with different domain not allowed";
							isValid = false;
							return false;
						}	
					});
						
				}else{
					errorMsg = "Please select atleast one player";
				}
				if(isValid == true){
					plrList = JSON.stringify(plrList);
					param = '?domainId='+plrDomainId + '&plrList=' + plrList;
				}else{
					param = '?errorMsg='+errorMsg ;
				}
				$('#changePlrVip').attr('href','com/stpl/pms/action/bo/misc/st_pms_misc_changePlayerVip.action'+param);
				return isValid;
			});
			
			
			
			$('a[rel*="facebox"]').facebox({
				closeImage : '<%=request.getContextPath()%>/images/closelabel.png',
  	 		});
  	 		
  	 		/* $('#reportToExcel').click(function(){
  	 			var totalPLr = $('#totalPlr').val();
  	 			var isValid = false;
  	 			if(totalPLr>500){	
  	 				if(confirm("It will take several minutes to download "+totalPLr+" player Data")){
  	 				isValid=true;
  	 				}
  	 			}else{
  	 				isValid=true;
  	 			}
  	 			if(isValid){
					$('#redirect').val('Excel');
					$('#plrSearchFrm').submit();
				}
										
			}); */
			
		$("#inactivePlr").click(function(){
				var isValid = false;
				var inactiveFrm = $("<form></form>");
				inactiveFrm.attr("action","com/stpl/pms/action/bo/pm/st_bo_pm_inactivePlayer.action");
				inactiveFrm.attr("method","POST");
				inactiveFrm.attr("id","inactiveForm");
				if($('[id*=checkBoxId_]:checked').length > 0){
					$('[id*=checkBoxId_]:checked').each(function(index,value){
						var checkBox = $(this);
						if(($(this).attr('checked')=='checked') && (typeof $(this).attr('checked')!='undefined')) {
							isValid = true;
							//plrList[$(this).val()] = $(this).attr('class');
							var plrData = $("<input></input>");
							plrData.attr("type","hidden");
							plrData.attr("name","plrIds");
							plrData.val($(this).val());
							//plrData.wrapInner(inactiveFrm);
							inactiveFrm.append(plrData);
						}
					});
				}else{
					alert("Please select atleast one player");
					return false;
					}
				$("#inactivePlrDiv").append(inactiveFrm);
				$("#inactiveForm").submit();
				return false;
			});	
									
	});
	function AjaxCall(txt){
	$("#waitDivView").show();
		$("#viewPlayerDetails").hide();
		var divId = txt.attr('target1');
		var param = "";
		var ajaxParam = new Array();
		var ajaxParamVal = "";
		//var isChk = true;alert($('#' + txt.attr('ajaxParamPlr')).val());
		if (typeof txt.attr('ajaxParamPlr') !== 'undefined') {
			//		ajaxParamVal = $('#' + txt.attr('ajaxParamPlr')).val();
					param = txt.attr('ajaxParamPlr') ;
				// param.replaceLast('&','');
			} 
			$("#waitDivView_"+param.split("=")[1]).show();
		$("#viewPlayerDetails_"+param.split("=")[1]).hide();
		$.ajax( {
			type : "POST",
			url : txt.attr('ajaxActionPlr'),
			data : param,
			//async : false,
			success : function(result) {
				$("#" + divId).html(result);
			}
		});
		return false;
	}
	
</SCRIPT>

	</head>
	<body>
		<s:if test="%{plrList.get(0).size()>0}">
			<div id="accordion">
				<h4>
					Player Data
					<span class="plus1" id="min"></span>
				</h4>

				<div id="playerData">

					<table class="payTransaction" style="width:100%">
					
						<tr>
							<td>
								<s:checkbox id="playerId" 
									name="plrList_playerId" theme="simple" cssClass="playerId">Player Id</s:checkbox>
							</td>
							<td>
								<s:checkbox id="fname" 
									name="plrList_fname" theme="simple" cssClass="fname">Name</s:checkbox>

							</td>
							<%-- <td>
								<s:checkbox id="lname" 
									name="plrList_lname" theme="simple" cssClass="lname">last Name</s:checkbox>

							</td> --%>
							<td>
								<s:checkbox id="userName" 
									name="plrList_uname" theme="simple" cssClass="userName">User Name</s:checkbox>

							</td>
							<td>
								<s:checkbox id="pokerNickName" 
									name="plrList_pokerNM" theme="simple" cssClass="pokerNickName">Poker <br/> NickName</s:checkbox>

							</td>
							<td>
								<s:checkbox id="rummyNickName" 
									name="plrList_rummyNM" theme="simple" cssClass="rummyNickName">Rummy<br/>NickName</s:checkbox>

							</td>							
							<td>
								<s:checkbox id="email" 
									name="plrList_email" theme="simple" cssClass="email">Email</s:checkbox>

							</td>
							<td>
								<s:checkbox id="mobile" 
									name="plrList_mobile" theme="simple" cssClass="mobile">Mobile No</s:checkbox>

							</td>
							<td>
								<s:checkbox id="regIp" 
									name="plrList_regIp" theme="simple" cssClass="regIp">Registration IP</s:checkbox>

							</td>							
						</tr>
						<tr>						
							<td>
								<s:checkbox id="totalBalance" name="plrList_totalBal"
									theme="simple" cssClass="totalBalance">Total Balance</s:checkbox>

							</td>
							<td>
								<s:checkbox id="regStatus" 
									name="plrList_regStatus" theme="simple" cssClass="regStatus">Profile Status</s:checkbox>

							</td>
							<td>
								<s:checkbox id="dateOfBrith" name="plrList_dateOfBrith"
									theme="simple" cssClass="dateOfBrith">DOB</s:checkbox>

							</td>
							<td>
								<s:checkbox id="gender" name="plrList_gender" theme="simple"
									cssClass="gender">Gender</s:checkbox>

							</td>
							<td>
								<s:checkbox id="lastLoginDate" name="plrList_lastLoginDate"
									theme="simple" cssClass="lastLoginDate">Registration Date</s:checkbox>

							</td>

						
							<td>
								<s:checkbox id="cashBalance" 
									name="plrList_cashBalance" theme="simple"
									cssClass="cashBalance">Cash Balance</s:checkbox>

							</td>
							<td>
								<s:checkbox id="bonusBalance" name="plrList_bonusBalance"
									theme="simple" cssClass="bonusBalance">Bonus Balance</s:checkbox>

							</td>
							<td>
								<s:checkbox id="praBalance" name="plrList_praBalance"
									theme="simple" cssClass="praBalance">Practice Balance</s:checkbox>

							</td>
							</tr>
						<tr>							
							
							<td>
								<s:checkbox id="referSource" name="plrList_referSource"
									theme="simple" cssClass="referSource">Reg. Refer Source</s:checkbox>

							</td>
							<td>
								<s:checkbox id="regDevice" name="plrList_regDevice"
									theme="simple" cssClass="regDevice">Reg. Device</s:checkbox>
							</td>
							<td>
								<s:checkbox id="aliasId" 
									name="plrList_aliasId" theme="simple" cssClass="aliasId">Registered Alias</s:checkbox>
							</td>
							<td>
								<s:checkbox id="browser" name="plrList_browser"
									theme="simple" cssClass="browser">Browser</s:checkbox>
							</td>
							<td>
								<s:checkbox id="OS" name="plrList_OS"
									theme="simple" cssClass="OS">OS</s:checkbox>
							</td>
							<td>
								<s:checkbox id="device" name="plrList_device"
									theme="simple" cssClass="device">Model</s:checkbox>
							</td>
							<td>
								<s:checkbox id="depositReferSource" name="plrList_depositReferSource"
									theme="simple" cssClass="depositReferSource">Deposit Refer Source</s:checkbox>

							</td>
							<td>
								<s:checkbox id="commPromo" 
									name="plrList_commPromo" theme="simple" cssClass="commPromo">Promo Mail</s:checkbox>
							</td>							
							<%-- <td>
								<s:checkbox id="firstDepositDate" name="plrList_firstDepositDate"
									theme="simple" cssClass="firstDepositDate">First Deposit Date</s:checkbox>
							</td>
							<td>
								<s:checkbox id="firstDepositAmount" name="plrList_firstDepositAmount"
									theme="simple" cssClass="firstDepositAmount">First Deposit Amount</s:checkbox>
							</td> --%>
						</tr>
						<tr>		
							<td>
									<s:checkbox id="plrStatus" 
										name="plrList_plrStatus" theme="simple" cssClass="plrStatus">Player Status</s:checkbox>
							</td>
							<td>
								<s:checkbox id="isPlay2x" name="plrList_isPlay2x"
									theme="simple" cssClass="isPlay2x">Is Play 2X</s:checkbox>
							</td>
						</tr>

					</table>
				</div>
			</div>
		</s:if>
		<s:hidden value="%{plrList.get(1)}" id="totalPlr"></s:hidden>
		<s:hidden id="paginationPage" name="paginationPage"
			value="%{plrList.get(3)}"></s:hidden>
		<div class="clear2"></div>
		<div class="FormSection">
			<s:if test="%{plrList.get(0).size()>0}">

				<div class="greyStrip">
					<h4>

						Player Search Data
						<ss:select list="#{'10':'10','20':'20','50':'50','100':'100'}"
							id="recordPerPage" name="recordPerPage" value="%{plrList.get(2)}"></ss:select>
					</h4>
				</div>
				
				<br/>
				<div class="innerBox" id="paginationDiv" style="margin: 29px auto 0;">
				  <div style="overflow-x: scroll;">
					<table width="830" cellspacing="0" cellpadding="4" border="0"
						align="center" class="payTransaction" id="playerTable">
						<tr>
							<th width="5%" valign="middle" align="left" class="allCheckBox">
								<s:checkbox id="allCheckBox" fieldValue="false"
									name="allCheckBox" theme="simple"></s:checkbox>
							</th>
							<th width="5%" valign="middle" align="left" class="sNo" >
								S. No.
							</th>
							<th width="15%" valign="middle" align="left" nowrap="nowrap"
								class=playerId style="display: none;">
								Player Id
							</th>
							<th width="15%" valign="middle" align="left" nowrap="nowrap"
								class=fname style="display: none;">
								Name
							</th>
							<!-- <th width="15%" valign="middle" align="left" nowrap="nowrap"
								class="lname" style="display: none;">
								Last Name
							</th> -->
							<th width="15%" valign="middle" align="left" nowrap="nowrap"
								class="userName" style="display: none;">
								User Name
							</th>
							<th width="5%" valign="middle" align="left" nowrap="nowrap"
								class="pokerNickName" style="display: none;">
								Poker<br/>NickName
							</th>
							<th width="5%" valign="middle" align="left" nowrap="nowrap"
								class="rummyNickName" style="display: none;">
								Rummy<br/>NickName
							</th>							
							<th width="15%" valign="middle" align="left" nowrap="nowrap"
								class="email" style="display: none;">
								Email
							</th>
							<th width="8%" valign="middle" align="left" nowrap="nowrap"
								class="mobile" style="display: none;">
								Mobile
							</th>
							<th width="8%" valign="middle" align="left" nowrap="nowrap"
								class="regIp" style="display: none;">
								Registration IP
							</th>
							<th width="10%" valign="middle" align="left" nowrap="nowrap"
								class="regStatus" style="display: none;">
								Profile Status
							</th>
							<th width="10%" valign="middle" align="left" nowrap="nowrap"
								class="plrStatus" style="display: none;">
								Player Status
							</th>
							<th width="2%" valign="middle" align="left" class="dateOfBrith" style="display: none;">
								DOB
							</th>
							<th width="2%" valign="middle" align="left" class="gender" style="display: none;">
								Gender
							</th>
							<th width="2%" valign="middle" align="left" class="lastLoginDate" style="display: none;">
								Registration Date
							</th>
							<th width="2%" valign="middle" align="left" class="totalBalance" style="display: none;">
								Total Balance
							</th>
							<th width="2%" valign="middle" align="left" class="cashBalance" style="display: none;">
								Cash Balance
							</th>
							<th width="2%" valign="middle" align="left" class="bonusBalance" style="display: none;">
								Bonus Balance
							</th>
							<th width="2%" valign="middle" align="left" class="praBalance" style="display: none;">
								Practice Balance
							</th>
								<th width="2%" valign="middle" align="left" class="isPlay2x" style="display: none;">
								Player 2X
							</th>
							<th width="2%" valign="middle" align="left" class="referSource" style="display: none;">
								Reg. Refer Source
							</th>
							<th width="2%" valign="middle" align="left" class="depositReferSource" style="display: none;">
								Deposit Refer Source
							</th>
							<th width="2%" valign="middle" align="left" class="regDevice" style="display: none;">
								Reg. Device
							</th>
						
							<!-- <th width="2%" valign="middle" align="left" class="firstDepositDate" style="display: none;">
								First Deposit Date
							</th> -->
							<!-- <th width="2%" valign="middle" align="left" class="firstDepositAmount" style="display: none;">
								First Deposit Amount
							</th> -->
							<th width="15%" valign="middle" align="left" nowrap="nowrap"
								class=aliasId style="display: none;">
								Registered Alias
							</th>
							<th width="15%" valign="middle" align="left" nowrap="nowrap"
								class=commPromo style="display: none;">
								Promo Mail
							</th>
							<th width="2%" valign="middle" align="left" class="browser" style="display: none;">
								Browser
							</th>
							<th width="2%" valign="middle" align="left" class="OS" style="display: none;">
								OS
							</th>
							<th width="2%" valign="middle" align="left" class="device" style="display: none;">
								Model
							</th>
							
							<th width="2%" valign="middle" align="left" class="resetPass" >
								Reset password
							</th>

							<th width="2%" valign="middle" align="left" class="details" >
								Details
							</th>

						</tr>
						<s:iterator value="%{plrList.get(0)}" status="plrList">
							<tr>
								<td>
									<s:checkbox id="checkBoxId_%{playerId}" name="checkBoxId_"
										theme="simple" fieldValue="%{playerId}" cssClass="%{userName}"></s:checkbox>
										<s:hidden id="playerDomainId_%{playerId}" value="%{domainId}"></s:hidden>
								</td>
								<td>
									<s:property value="%{index}" />
								</td>
								<td class="playerId" style="display: none;">
									<s:property value="%{playerId}" />
								</td>
								<td class="fname" style="display: none;">
									<s:property value="%{fname}" />
								</td>
								
								<td class="userName" style="display: none;">
									<s:property value="%{userName}" />
								</td>
								<td class="pokerNickName" style="display: none;">
									<s:property value="%{pokerNickName}" />
								</td>
								<td class="rummyNickName" style="display: none;">
									<s:property value="%{rummyNickName}" />
								</td>							
								<td class="email" style="display: none;">
									<s:property value="%{email}" />
								</td>
								<td class="mobile" style="display: none;">
									<s:property value="%{mobile}" />
								</td>
								<td class="regIp" style="display: none;">
									<s:property value="%{regIp}" />
								</td>
								<td class="regStatus" style="display: none;">
									<s:property value="%{regStatus}" />
								</td>
								<td class="plrStatus" style="display: none;">
									<s:property value="%{plrStatus}" />
								</td>								
								<td class="dateOfBrith" style="display: none;">
									<s:property value="%{dateOfBrith}" />
								</td>
								<td class="gender" style="display: none;">
									<s:if test='%{gender=="M"}'>
									Male
									</s:if>
									<s:elseif test='%{gender=="F"}'>
									Female
									</s:elseif>
									
								</td>
								<td class="lastLoginDate" style="display: none;">
									<s:property value="%{lastLoginDate}" />
								</td>
								<td class="totalBalance" style="display: none;">
									<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(totalBal)}" />
								</td>
								<td class="cashBalance" style="display: none;">
									<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(cashBalance)}" />
								</td>
								<td class="bonusBalance" style="display: none;">
									<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(bonusBalance)}" />
								</td>
								<td class="praBalance" style="display: none;">
									<s:property value="%{@com.stpl.pms.utility.Utility@roundingNumber(praBalance)}" />
								</td>
								<td class="isPlay2x" style="display: none;">
									<s:property value="%{isPlay2x}" />
								</td>
								<td class="referSource" style="display: none;">
									<s:property value="%{referSource}" />
								</td>
								<td class="depositReferSource" style="display: none;">
									<s:property value="%{firstDepositReferSource}" />
								</td>
								<td class="regDevice" style="display: none;">
									<s:property value="%{regDevice}" />
								</td>
								
								<%-- <td class="firstDepositDate" style="display: none;">
									<s:property value="%{firstDepositDate}" />
								</td> --%>
								<%-- <td class="firstDepositAmount" style="display: none;">
									<s:property value="%{firstDepositAmount}" />
								</td> --%>
								<td class="aliasId" style="display: none;">
									<s:property value="%{aliasIdMap[aliasId]}" />
								</td>
								<td class="commPromo" style="display: none;">
									<s:property value="%{commPromo}" />
								</td>
								<td class="browser" style="display: none;">
									<s:property value="%{browser}" />
								</td>
								<td class="OS" style="display: none;">
									<s:property value="%{OS}" />
								</td>
								<td class="device" style="display: none;">
									<s:property value="%{device}" />
								</td>
								
								<td class="resetPass">
									<s:hidden value="%{playerId}" id="playerId"></s:hidden>
									<a
										href="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerPasswordChange.action?playerId=<s:property value="%{playerId}" />&domainId=<s:property value="%{domainId}" />&emailId=<s:property value="%{email}" />&userName=<s:property value="%{userName}"/>"
										id="resetPlayerPass_<s:property value='%{fname}'/>"
										name="<s:property value='%{userName}'/>">Reset</a>

								</td>
								<td class="details">
								
								<div id="waitDivView_<s:property value="%{playerId}"/>" class="animated-button-div" style="margin:13px 0px 14px 0px; display: none;" >
								<div class="animated-striped" style="padding:3px 21px 2px 20px;">Wait...</div>
								</div>
									<a    ajaxActionPlr="com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerDetailsRep.action"
										ajaxParamPlr="playerId=<s:property value="%{playerId}" />"  id="viewPlayerDetails_<s:property value="%{playerId}"/>" target1="plrDataResult" class="view-btn">View</a>

								</td>
							</tr>
						</s:iterator>
						
					</table>
				</div>	
					<div style=";text-align: right;">
					<a rel="facebox" id="sendPlrMail" class="button">Send Mail</a>
					<a id="sendPlrNotification" class="button">Send Notification</a>
					<a id="pushAppVersion" class="button">Push App Version</a>
					 <a
						rel="facebox" id="freeBonus" class="button">Free Bonus</a> <a
						rel="facebox" id="changePlrVip" class="button">Change VIP</a>
						<s:if test="%{actionPrivFunctionMap.containsKey('st_bo_pm_inactivePlayer')}" >
							<input id="inactivePlr" type="button" class="button" value="Inactive Player"/>
						</s:if>
				</div>
					<br />
					<div class="box_footer" style=" overflow-x: hidden;">

						<div id="pagination" style="padding-top: 15px;">
						</div>
					</div>
				</div>
				<br />



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

		<div id="clearFRM">

		</div>
		<div id="plrDataResult">

		</div>
	</body>
</html>
