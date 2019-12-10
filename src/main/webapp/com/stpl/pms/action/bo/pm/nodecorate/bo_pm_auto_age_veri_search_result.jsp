<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss"  uri="/extended-struts2-tags"%>
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
	<SCRIPT type="text/javascript">
			$(document).ready(function(){
				$("#pagination").paginate({
				count 		: $('#totalPlr').val(),
				start 		: $('#paginationPage1').val(),
				display     : $('#recordPerPage1').val(),
				border					: false,
				text_color  			: '#888',
				background_color    	: '#EEE',	
				text_hover_color  		: 'black',
				mouse		: 'press',
				background_hover_color	: '#CFCFCF'
			});
			var verificationStatus = '<s:property value="%{verificationStatus}"/>';
			if(verificationStatus=="PENDING"){
			$('#th_7').css("width","40%");
			}else{
			$('#th_7').css("width","25%");
			}
                         $('#Image_loading').css("display","none");             
              $('#recordPerPage1').change(function(){
               $('#recordPerPage').val($('#recordPerPage1').val());
              	 $('#paginationPage').val($('#paginationPage1').val());
              	$('#formSubmit').submit();
              });
              $('[id*=paginationPage_]').click(function(){
              $('#paginationPage').val($(this).attr('value'));
              
              	$('#formSubmit').submit();
              });
              
              $('#redirectPage').click(function(){
              $('#paginationPage').val($('#redirectPageNo').val());
              	$('#formSubmit').submit();
              });
              $('#redirectPrev').click(function(){
              	$('#paginationPage').val(parseInt($('#paginationPage1').val())-1);
              	$('#formSubmit').submit();
              });
				
              $('#redirectFirst').click(function(){
              	$('#paginationPage').val(1);
              	$('#formSubmit').submit();
              });
              
              $('#allCheckBox').click(function(){
				if(($(this).attr('checked')!='checked') && (typeof $(this).attr('checked')=='undefined')) {
		 		$(this).removeAttr('checked');
		 		$('[id*=checkBoxId_]').removeAttr('checked');
		 		}else{
				$(this).attr('checked','true');
				$('[id*=checkBoxId_]').attr('checked','true');
		 		}
			});
			
			$(':button[id*="terminate"]').click(function(){
				var action = "com/stpl/pms/action/bo/pm/bo_pm_auto_age_veri_terminate_plr.action";
				var param = "refundNTerPLrId="+(this.id).split("_")[1]+"&domainId="+$("#domainId").val();
				_ajaxCallDiv(action,param,"decoBody");
				$("#decoBody").html('<div class="innerBox">\
			<div class="alert info_msg ">\
				<span class="alert_close"></span><strong>Msg: </strong>\
				Player(s) terminated and Withdrawal request(s) successfully Initiated.\
			</div>\
		</div>');
			});
			
			$(':button[id*="verify"]').click(function(){
				var action = "com/stpl/pms/action/bo/pm/bo_pm_auto_age_veri_verify_cancel_plr.action";
				var param = "refundNTerPLrId="+(this.id).split("_")[1]+"&domainId="+$("#domainId").val()+"&veriAction=VERIFIED";
				_ajaxCallDiv(action,param);
				$("#decoBody").html('<div class="innerBox">\
			<div class="alert info_msg ">\
				<span class="alert_close"></span><strong>Msg: </strong>\
				Player(s) status changed to VERIFIED.\
			</div>\
		</div>');
			});
			
			$(':button[id*="selfExc"]').click(function(){
				var action = "com/stpl/pms/action/bo/pm/bo_pm_auto_age_veri_verify_cancel_plr.action";
				var param = "refundNTerPLrId="+(this.id).split("_")[1]+"&domainId="+$("#domainId").val()+"&veriAction=SELF_EXCLUDED";
				_ajaxCallDiv(action,param);
				$("#decoBody").html('<div class="innerBox">\
			<div class="alert info_msg ">\
				<span class="alert_close"></span><strong>Msg: </strong>\
				Player(s) status changed to SELF EXCLUDED.\
			</div>\
		</div>');
			});
			
			$(':button[id*="cancel"]').click(function(){
				var action = "com/stpl/pms/action/bo/pm/bo_pm_auto_age_veri_verify_cancel_plr.action";
				var param = "refundNTerPLrId="+(this.id).split("_")[1]+"&domainId="+$("#domainId").val()+"&veriAction=UNDER_AGE";
				_ajaxCallDiv(action,param,"decoBody");
				$("#decoBody").html('<div class="innerBox">\
			<div class="alert info_msg ">\
				<span class="alert_close"></span><strong>Msg: </strong>\
				Player(s) status changed to Under Age.\
			</div>\
		</div>');
			});
			
			$(':submit[id*="All"]').click(function(){
				var isValid = false;
				$('[id*=checkBoxId_]:checked').each(function(index,value){
					var checkBox = $(this);
					if(($(this).attr('checked')=='checked') && (typeof $(this).attr('checked')!='undefined')) {
						isValid = true;
					}
				});
				$("#veriAction").val($(this).attr("accesskey"));
				return isValid;
			});
              
             }); 
	</SCRIPT>
	</head>
	<body>
		<div class="clear2"></div>
		<div class="FormSection">
		<s:hidden value="%{plrList.get(1)}" id="totalPlr"></s:hidden>
		<s:hidden id="paginationPage1" name="paginationPage"
			value="%{plrList.get(3)}"></s:hidden>
			<s:if test="%{plrList!=null && plrList.get(0).size()>0}">
			<form method="POST" >
			<s:hidden value="%{domainId}" name="domainId"></s:hidden>
			<s:hidden name="veriAction" id="veriAction"></s:hidden>
				<div class="greyStrip">
					<h4 style="float: left">
						Player Information <s:select list="#{'10':'10','20':'20','50':'50','100':'100'}"
							id="recordPerPage1" name="recordPerPage" value="%{plrList.get(2)}"></s:select>
					</h4>
				</div>
				<div class="innerBox">
					<table width="830" cellspacing="0" cellpadding="4" border="0"
						align="center" class="payTransaction">
						  <tr class="headerRow">
						        <th id="th_0" id="th_1" width="10%" style="text-align: center;">
											<input type="checkbox" id="allCheckBox" name="allCheckBox" ></input>
								</th>
								<th width="10%" valign="middle" style="text-align: center;" id="th_2" >
											Player Id
								</th>
								<th width="10%" valign="middle" style="text-align: center;" id="th_3" >
											User Name
								</th>
								<th width="10%" valign="middle" style="text-align: center;" id="th_4" >
											First Name
								</th>
							  	<th width="10%" valign="middle" style="text-align: center;" id="th_5" >
											Last Name
								</th>
								<th width="10%" valign="middle" style="text-align: center;" id="th_6" >
											Refund Balance  
								</th>
								<th width="40%" valign="middle" style="text-align: center;" id="th_7" >
											Action
								</th>
							 </tr>
						<s:iterator value="%{plrList.get(0)}" status="plrList">
						<tr>
							    <td width="10%" valign="middle" style="text-align: center;" >
							    <s:checkbox id="checkBoxId_%{playerId}" name="refundNTerPLrId" fieldValue="%{playerId}" theme="simple"></s:checkbox>
							    </td>
							    <td width="10%" valign="middle" style="text-align: center;" > <s:property value="%{playerId}" />
							    </td>
							    <td width="10%" valign="middle" style="text-align: center;" >
							   <a  style="cursor: pointer;" onclick="window.open('com/stpl/pms/action/bo/reports/st_pms_bo_rep_playerDetailsRep.action?playerId=<s:property value="%{playerId}" />','_blank')"> 
							    <s:property value="%{userName}" /></a>
							    </td>
							    <td width="10%" valign="middle" style="text-align: center;" ><s:property value="%{firstName}" />
							    </td>
							    <td width="10%" valign="middle" style="text-align: center;" ><s:property value="%{lastName}" />
							    </td>
							    <td width="10%" valign="middle" style="text-align: center;" ><s:property value="%{playerWallet.totalDeposit - playerWallet.totalWithdrawal}" />
							    </td>
							     <td style="text-align: center;">
							     <s:if test='%{verificationStatus=="PENDING"}'>
							     	<input type="button" name="verify" id="verify_<s:property value="%{playerId}"/>" value="Verified"></input>
							     	<input type="button" name="cancel" id="cancel_<s:property value="%{playerId}"/>" value="Under Age"></input>
							     	<input type="button" name="selfExc" id="selfExc_<s:property value="%{playerId}"/>" value="Self Exclude"></input>
							     </s:if>
							     <s:elseif test='%{verificationStatus=="VERIFIED"}'>
   							     	<input type="button" name="selfExc" id="selfExc_<s:property value="%{playerId}"/>" value="Self Exclude"></input>
							     </s:elseif>
							     <s:else>
							     <input type="button" name="terminate" id="terminate_<s:property value="%{playerId}"/>" value="Process & Terminate"></input>
							    </s:else></td>
							</tr>
						</s:iterator>
						
					</table>
				</div><div align="right">
				<s:if test='%{verificationStatus=="PENDING"}'>
				<s:submit name="submit" accesskey="VERIFIED" theme="simple" value="All Verified" cssClass="button" id="veriAll" action="bo_pm_auto_age_veri_verify_cancel_plr"
					></s:submit>
					<s:submit name="submit" accesskey="UNDER_AGE" theme="simple" value="All Under Age" cssClass="button" id="cancAll" action="bo_pm_auto_age_veri_verify_cancel_plr"
					></s:submit>
					<s:submit name="submit" accesskey="SELF_EXCLUDED" theme="simple" value="All Self Excluded" cssClass="button" id="selfExcAll" action="bo_pm_auto_age_veri_verify_cancel_plr"
					></s:submit>
					</s:if>
					 <s:elseif test='%{verificationStatus=="VERIFIED"}'>
					 <s:submit name="submit" accesskey="SELF_EXCLUDED" theme="simple" value="All Self Excluded" cssClass="button" id="selfExcAll" action="bo_pm_auto_age_veri_verify_cancel_plr"
					></s:submit>
					 </s:elseif>
					<s:else>
					<s:submit name="submit" theme="simple" value="Process & Terminate All" cssClass="button" id="termAll" action="bo_pm_auto_age_veri_terminate_plr"
					></s:submit></s:else>
					</div>
				<div class="box_footer">
						<div id="pagination" style="padding-top:15px;" >
					</div>
					
				</div>
				</form>
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
   <div id="expandIt">
   </div>
	</body>
</html>

