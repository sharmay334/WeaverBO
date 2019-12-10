<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>POM Search</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="<%=path%>/css/facebox.css" media="screen" rel="stylesheet" type="text/css"/>
		<script type="text/javascript">
	$(document).ready(function() {
	$('td[class="handle"]').hover(function(){
	   $(this).css("cursor","move");
	});
		$('td[id*="payTypeTd_"]').each(function() {
			var rowId = this.id.replace('payTypeTd_', '');
			$(this).attr('rowspan', $('#payTypeRowCount_' + rowId).val());
		});
		
		$('input[id*="pomId_"]').click(function(){
			$('#priorityOrder_'+this.id.replace('pomId_','')).attr('disabled',!this.checked);
		});
		$("#chooseVipLevelBtn").click(function(e){	
			$("#facebox").css("display","block");
			$("#facebox_overlay").css("display","block");
			$("#facebox").attr("tabindex",-1).focus();
		});
		$("#podmSetupForm").submit(function(){
			if($( "input:checked",$('#chooseVipLevelBox')).length==0)
			{
				alert("Please select atleast one vip level");
				return false;
			}
			return true;
		});
						
			
			
		$('#selectAllVip').click(function(e){
		    var div= $('#chooseVipLevelBox');
		    $('input:checkbox',div).attr('checked',e.target.checked);
		});
		
	});
	
	var fixHelper = function(e, ui) {
	ui.children().each(function() {
		$(this).width($(this).width());
	});
	return ui;
   };
   $(function() {
   var count = $("#count").val();
   for(var i =0;i<count;i++){
	$(".sortable"+i).sortable({
	handle: ".handle",
	helper: fixHelper,
	cursor: "move",
    items: 'tr',
    axis: "y",
    update: function(event, ui){  
              $($(this).find('tr')).each(function(){
              $(this).find('td:eq(5) input[name="priorityOrder"]').val($(this).index()+1);
              });
             }
   }).disableSelection();
   }
    });
   function selectAll(th,sType){
    var collection = document.getElementById(sType).getElementsByTagName('INPUT');
     if($(th).attr("checked")){
          $('#'+sType+' input').each(function(){
              if ($(this).attr("type")== 'checkbox') {
                $(this).attr("checked",true);
             }else{
                $(this).attr("disabled",false);
             }
          });
      }else{
           $('#'+sType+' input').each(function(){
              if ($(this).attr("type")== 'checkbox') {
                $(this).attr("checked",false);
             }else{
                $(this).attr("disabled",true);
             }
          });
      }
   }
   function selectProvider(th,pType,sType,payType){
    selectAll(th,pType);
    var flag = true;
	if($(th).attr("checked")){
	    $('#'+sType+' input[type="checkbox"]').each(function(){
              if (!$(this).attr("checked")) {
                flag = false;
              }
         });
		if(flag){
	        $("#"+payType).attr("checked",true);
	     }
	  }else{
	    $("#"+payType).attr("checked",false);
	  }
   }
   
   function checkSelect(th,sType,pType,subType,payType){
    var flag = true;
    if(!$(th).attr("checked")){
     $("#"+payType).attr("checked",false);
     $("#"+subType).attr("checked",false);
    }else{
	        $('#'+pType+' input[type="checkbox"]').each(function(){
	              if (!$(this).attr("checked")) {
	                flag = false;
	              }
	         });
			if(flag){
		        $("#"+subType).attr("checked",true);
	        }
	        flag =true;
	        $('#'+sType+' input[type="checkbox"]').each(function(){
	              if (!$(this).attr("checked")) {
	                flag = false;
	              }
	         });
			if(flag){
				$("#"+payType).attr("checked",true);
	        }
       }
   }
   function closeFacebox(){
		$("#facebox").css("display","none");
		$("#facebox_overlay").css("display","none");
	}
</script>
	</head>

	<body>
	<div id="container">
	<div id="formDiv">
	
		<div class="FormSection">
			<div class="greyStrip">
				<h4>
					Payment Providers
				</h4>
			</div>
			<s:form action="bo_csh_podmSetup_Save" theme="simple" id="podmSetupForm">
			<s:token name="strutsToken" id="strutsToken"></s:token>
				<s:hidden name="domainId" id="podmDomainId" value="%{domainId}"></s:hidden>
				<s:hidden name="aliasId" id="podmaliasId" value="%{aliasId}"></s:hidden>
				<s:hidden name="countryId" value="%{countryId}"></s:hidden>
				<s:hidden name="currencyId" value="%{currencyId}"></s:hidden>
				<s:hidden name="device" value="%{device}"></s:hidden>
				<s:hidden name="txnType" value="%{txnType}"></s:hidden>
				<s:if test="%{pomMap.size>0}">
				<div class="innerBox">
					<table style="border-bottom:3px #c2c2c2 solid" class="payTransaction" align="center" cellspacing="0"
						cellpadding="4" border="0">
						<tr>
							<th width="50px">
								Payment Type
							</th>
							<th width="205px">
								Payment Sub Type
							</th>
							<th width="206px">
								Payment Providers
							</th>
							<th width="94px">
								Mean Processing Time
							</th>
							<th width="92px">
								Success Rate
							</th>
							<th width="92px">
								Typical Process Time
							</th>
							<th>
								Priority Order
							</th>
						</tr>
                       <s:set var="count" value="1" />
                       <s:set var="pomCount" value="1" />
						<s:iterator value="%{pomMap}" var="pmap">
							<tr>
								<td id="payTypeTd_<s:property value="%{value.payTypeCode}"/>" >
									<input name="payType"
										id="payType_<s:property value="%{value.payTypeCode}" />"
										type="checkbox"
										onclick="selectAll(this,'sType<s:property value="%{#pmap.value.payTypeCode}"/>')"
										value=""
										<s:property value="%{(value.status=='ACTIVE')?'checked=checked':''}" /> />
									<s:property value="%{value.payTypeCode}" />
								</td>
								<td class="" colspan="6" style="border-bottom: none">
									<div id="sType<s:property value="%{#pmap.value.payTypeCode}"/>">
										<s:iterator value="%{value.subTypeMap}" var="sTypeMap">
											<table width="101%" cellspacing="0" cellpadding="0" style="margin-top:-6px; margin-left:-6px;margin-bottom: -3px" >
												<tr>
													<td width="195px" style="border-bottom:1px #c2c2c2 solid; border-left:none; border-top:none;">
													
                                                         <input name="subType"
															id="subType_<s:property value='#count' />"
															type="checkbox"
															onclick="selectProvider(this,'pType<s:property value="%{#pmap.value.payTypeCode}"/><s:property value="%{#sTypeMap.value.subTypeCode}"/>','sType<s:property value="%{#pmap.value.payTypeCode}"/>','payType_<s:property value="%{#pmap.value.payTypeCode}" />')"
															value=""
															<s:property value="%{(value.status=='ACTIVE')?'checked=checked':''}" /> />
														<s:property value="%{value.subTypeCode}" />
													</td>
													<td colspan="5" style="border-bottom:1px #c2c2c2 solid; border-left:none;border-right:none; border-top:none; border-bottom:none" >
														<div
															id="pType<s:property value="%{#pmap.value.payTypeCode}"/><s:property value="%{#sTypeMap.value.subTypeCode}"/>">
															<table class="sortable<s:property value='#count' />" width="103%" style="margin-left: -7px;margin-bottom: -2px">
																<tbody >
															      <s:iterator value="%{value.providerMap}">
																		<tr height="40px">
																		<td width="5%" class="handle" style="border-left:none; border-right:none; border-top:none;">
																			<img src="<%=path%>/images/dragIcon2.gif" style="width: 20px;height:20px ">
																			</td >
																			<td width="162px" style="border-left:1px #c2c2c2 solid; border-right:none; border-top:none;">
																				<input name="pomId"
																					id="pomId_<s:property value='#pomCount' />"
																					type="checkbox" onclick="checkSelect(this,'sType<s:property value="%{#pmap.value.payTypeCode}"/>','pType<s:property value="%{#pmap.value.payTypeCode}"/><s:property value="%{#sTypeMap.value.subTypeCode}"/>','subType_<s:property value='#count' />','payType_<s:property value="%{#pmap.value.payTypeCode}"/>')"
																					value="<s:property value="%{value.pomId}" />"
																					<s:property value="%{(value.status=='ACTIVE')?'checked=checked':''}" /> />
																				<s:property value="%{value.providerDiscCode}" />
																			</td>

																			<td width="85px" style="border-left:1px #c2c2c2 solid; border-right:none; border-top:none; ">
																				<s:property value="%{value.meanProccessTime}" />
																			</td>

																			<td width="83px" style="border-left:1px #c2c2c2 solid; border-right:none; border-top:none; ">
																				<s:property value="%{value.succesRate}" />
																			</td>

																			<td width="83px" style="border-left:1px #c2c2c2 solid; border-right:none; border-top:none; ">
																				<s:property value="%{value.typicalProcessTime}" />
																			</td>

																			<td style="border-left:1px #c2c2c2 solid; border-right:none; border-top:none; ">
																				<s:textfield cssStyle="width:25px"
																					name="priorityOrder"
																					id="priorityOrder_%{#pomCount}"
																					disabled="%{(value.status!='ACTIVE')}"
																					value="%{value.priorityOrder}" theme="simple"></s:textfield>
																			</td>
																		</tr>
											                   <s:set name="pomCount" value="%{#pomCount+1}"/>
															</s:iterator>
														  </tbody>
													    </table>
														</div>
													</td>
												</tr>
											</table>
											<s:set name="count" value="%{#count+1}"/>
										</s:iterator>
									</div>
								</td>
							</tr>
						</s:iterator>
						<s:hidden name="count" id="count" value="%{#count}"></s:hidden>
					</table>
					<div style="top: 445px; left: 150px;display: none" id="facebox">
					<div class="popup">
						<div class="content" style="width: 650px;"><p style="font-size: 14px;"><b>Select Vip Level</b></p>
							<div class="FormSection"  >
								<div class="labelDiv">
									<label> Vip Level </label>
								</div> 
								<div class="InputDiv1" id="chooseVipLevelBox" style="width: 76%;">
									<s:set name="count" value="0"></s:set>
									<s:set name="selectedVip" value="%{vipLevelId}"/>
									
									<s:iterator value="%{domainVipList}">
									<div style="float: left; width: 94px;">
										<s:checkbox id="vipList" name="vipList" fieldValue="%{vipLevel}" value="%{#selectedVip == vipLevel}" theme="myTheme"> </s:checkbox>
										<span class="inpSpan" id="vipList_span">
											<s:property value="%{vipCode}" />
										</span>
										<s:if test="%{#count==4}"> <br />
											<s:set name="count" value="0"></s:set>
										</s:if>
										<s:else>
											<s:set name="count" value="%{#count+1}"></s:set>
												&nbsp;&nbsp;
										</s:else>
										</div>
									</s:iterator>
									
								</div>
								
								<div class="box_footer" align="right">
									<s:submit value="Submit" id="submitvip" style="float: right;"></s:submit>
									<span style="margin-top: 15px; float: right; margin-right: 15px;">
									<input type="checkbox" id="selectAllVip" /> All Vip Level
									</span>
								</div>
								</div>
						</div>
							<a class="close" href="#" onclick="closeFacebox(); return false;"><img class="close_image"
									title="close" src="<%=path%>/images/closelabel.png">
							</a>
						
					</div>
				</div>
				<div class="facebox_hide facebox_overlayBG" id="facebox_overlay" style="display: none; opacity: 0.4;"></div>
				</div>
				<div class="box_footer" align="right">
				 <input type="button" class="button" id="chooseVipLevelBtn" value="Submit" style="float: right"></input>
				</div>
				</s:if>
				<s:else>
			
			<div class="innerBox">
				<div class="alert info_msg ">
					<span class="alert_close"></span><strong>Msg: </strong>No Record
					Found.
				</div>
			</div>
		</s:else>
			</s:form>
		</div>
		
		</div>
		</div>
	</body>
</html>
