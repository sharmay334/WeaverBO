<%@page import="com.stpl.pms.utility.Utility"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.stpl.pms.javabeans.UserInfoBean"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "-1");
	String path = request.getContextPath();
	String version ="1.0";
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<s:set name="contextPath"
			value="#request.get('javax.servlet.include.context_path')"
			scope="session" />
		<title><%=Utility.getClientName() %>-<decorator:title /> </title>
		<script type="text/javascript">	
			var Language = "<%=session.getAttribute("localeValue")%>";
		</script>
		<link rel="shortcut icon" href="<%= request.getContextPath()%>/images/client-specific/<%=Utility.getClientName() %>/favicon.ico" type="image/x-icon"/>
		<link href="<%=path %>/css/images/bubbletip.css?v=<%=version %>" rel="stylesheet" type="text/css" />
		<link href="<%=path %>/css/images/bubbletip-IE.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/jQuery/jquery.ui.all.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/BoNew.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/style.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/reset.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/menu.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/treeview/tree_view.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/jquery.dataTables.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/jquery.dataTables.mis.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/BoNew.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<script src="<%=path%>/js/jQuery/jquery-1.8.3.js?v=<%=version%>" type="text/javascript" ></script>
		<script type="text/javascript"
			src="<%=path%>/js/jQuery/jquery-ui-1.10.3.custom.js?v=<%=version%>"></script>
		<script type="text/javascript" src="<%=path%>/js/jQuery/jquery.tablednd.js?v=<%=version%>"></script>
		<script type="text/javascript" src="<%=path%>/js/jQuery/jquery.timepicker.js?v=<%=version%>"></script>
		<script type="text/javascript" src="<%=path%>/js/accodian.js?v=<%=version%>"></script>	
		<script type="text/javascript" src="<%=path%>/js/dynamicMenu.js?v=<%=version%>"></script>
		<script type="text/javascript" src="<%=path%>/js/ajaxCall.js?v=<%=version%>"></script>
		<script type="text/javascript" src="<%=path%>/js/validate.js?v=<%=version%>"></script>
		<script src="<%=path %>/js/jQuery.bubbletip-1.0.6.js?v=<%=version%>" type="text/javascript"></script>
		<script type="text/javascript" src="<%=path%>/js/commonfunctions.js?v=<%=version%>"></script>
		<script type="text/javascript" src="<%=path%>/js/datatable/jquery.dataTables.js?v=<%=version%>"></script>
		
<!--<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"> </script>-->
<script type="text/javascript" src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"> </script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/dataTables.buttons.min.js"> </script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"> </script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"> </script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"> </script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.html5.min.js"> </script>
		
		<script type="text/javascript">		
			var projectName="<%=path%>";
			var serverDateStr = '<s:property value="%{@com.stpl.pms.utility.Utility@getServerDate(0,0,0,\"dd/MM/yy HH:mm:ss\")}" />';
			//var menuStr = '<s:property value="%{menuStr}"/>';
			var menuStr = '<%=session.getAttribute("menuStr").toString()%>';	
			var currentLoggedUser='<s:property value="%{userInfoBean.userName}"/>';
			window.onload = function (ev) {
				BrowserDetect.init();	
				//initDojo.startDojo(ev);
			 	
				
				
			}
			
			$(function(){
				$("#bo_impersonate").click(function(){
					_ajaxCallDiv("<%=path%>"+"/com/stpl/pms/action/bo/um/dispatch_bo_subusers.action","","impersonate_welcomebox");
				});	
				$("#quit_impersonate").click(function(){
					var result=_ajaxCallText("<%=path%>"+"/com/stpl/pms/action/bo/um/quit_bo_impersonation.action","");
					if(result==="done"){
						document.location.href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()%>"+"/com/stpl/pms/action/bo/lm/bo_home_page.action?serviceName=MGMT";
					}else
						alert("Failed!");
				});	
				if('<s:property value="%{#parameters.serviceName}"/>'=='MGMT'){
					$("#container").addClass( "chartPage");
				}else{
					$("#container").removeClass( "chartPage");
				}
			});		
			function deleteNotificationById(dlt_id){
				var myurl = "<%=path%>";
				myurl+="/com/stpl/pms/action/bo/lm/delete_alert.action?deleteId="+dlt_id;
				 $.ajax({
				  url: myurl,
				  type: 'post',
				  success: function(response){
					alert('alert successfully deleted!');
					fetchdataAlert();
				  }
				 });
			}
			
			function goToPurchaseOrder(po_id){
				var myurl = "<%=path%>";
				var myurlRedirect = "<%=path%>";
				myurlRedirect+="/com/stpl/pms/action/bo/um/bo_um_tm_purchase_alert.action?POId="+po_id;
				myurl+="/com/stpl/pms/action/bo/lm/bo_um_get_emp_purchase_order_data.action?POId="+po_id;
				 $.ajax({
				  url: myurl,
				  type: 'post',
				  success: function(response){
					window.location.href = myurlRedirect;

				  }
				 });
			}
			function goToSaleOrder(so_id){
				var myurl = "<%=path%>";
				var myurlRedirect = "<%=path%>";
				myurlRedirect+="/com/stpl/pms/action/bo/um/bo_um_tm_sale_alert.action?SOId="+so_id;
				window.location.href = myurlRedirect;
				
				
			}
			
			function showSalesOrderEmp(so_id){
				
				var myurl = "<%=path%>";
				var myurlRedirect = "<%=path%>";
				myurlRedirect+="/com/stpl/pms/action/bo/um/bo_um_tm_sale_order_emp.action?SOId="+so_id;
				window.location.href = myurlRedirect;
			}
			function showPurchaseOrderEmp(po_id){
				
				var myurl = "<%=path%>";
				var myurlRedirect = "<%=path%>";
				myurlRedirect+="/com/stpl/pms/action/bo/um/bo_um_tm_purchase_order_emp.action?POId="+po_id;
				window.location.href = myurlRedirect;
			}
			function showReceiptOrderEmp(ro_id){
				
				var myurl = "<%=path%>";
				var myurlRedirect = "<%=path%>";
				myurlRedirect+="/com/stpl/pms/action/bo/um/bo_um_tm_receipt_order_emp.action?rcptId="+ro_id;
				window.location.href = myurlRedirect;
			}
			function showPaymentOrderEmp(po_id){
				
				var myurl = "<%=path%>";
				var myurlRedirect = "<%=path%>";
				myurlRedirect+="/com/stpl/pms/action/bo/um/bo_um_tm_payment_order_emp.action?pmtId="+po_id;
				window.location.href = myurlRedirect;
			}
			
			function showCreditNoteOrderEmp(cn_id){
				
				var myurl = "<%=path%>";
				var myurlRedirect = "<%=path%>";
				myurlRedirect+="/com/stpl/pms/action/bo/um/bo_um_tm_creditNote_order_emp.action?CNId="+cn_id;
				window.location.href = myurlRedirect;
			}
			function goToCN(cn_id){
				
				var myurl = "<%=path%>";
				var myurlRedirect = "<%=path%>";
				myurlRedirect+="/com/stpl/pms/action/bo/um/bo_um_tm_creditNote_alert.action?CNId="+cn_id;
				window.location.href = myurlRedirect;
				
				
			}
		  function goToDN(dn_id){
				
				var myurl = "<%=path%>";
				var myurlRedirect = "<%=path%>";
				myurlRedirect+="/com/stpl/pms/action/bo/um/bo_um_tm_debitNote_alert.action?DNId="+dn_id;
				window.location.href = myurlRedirect;
			}
		  function goToPMT(dn_id){
				
				var myurl = "<%=path%>";
				var myurlRedirect = "<%=path%>";
				myurlRedirect+="/com/stpl/pms/action/bo/um/bo_um_tm_payment_alert.action?pmtId="+dn_id;
				window.location.href = myurlRedirect;
			}
		  function goToRCPT(dn_id){
				
				var myurl = "<%=path%>";
				var myurlRedirect = "<%=path%>";
				myurlRedirect+="/com/stpl/pms/action/bo/um/bo_um_tm_receipt_alert.action?rcptId="+dn_id;
				window.location.href = myurlRedirect;
			}
			
			function fetchdataAlert(){
				var myurl = "<%=path%>";
				myurl+="/com/stpl/pms/action/bo/lm/getAlert.action";
				 $.ajax({
				  url: myurl,
				  type: 'post',
				  success: function(response){
					  var arr_msg = response.split('|');
				   // Perform operation on the return value
				   if(response.includes('|')){
					   document.getElementById('badge_value').innerHTML = arr_msg[1];
					   document.getElementById('noti_alerts_msg').innerHTML = arr_msg[0];
				   }
				   else{
					   var val = 0;
					   document.getElementById('badge_value').innerHTML = val;
					   document.getElementById('noti_alerts_msg').innerHTML = 'There is no notification yet!';
				   }
				  
				  }
				 });
				}
			function fetchdataAlertPO(){
				var myurl = "<%=path%>";
				myurl+="/com/stpl/pms/action/bo/lm/getAlertPO.action";
				 $.ajax({
				  url: myurl,
				  type: 'post',
				  success: function(response){
					  var arr_msg = response.split('|');
				   // Perform operation on the return value
				   if(response.includes('|')){
					   document.getElementById('badge_value_po').innerHTML = arr_msg[1];
					   document.getElementById('noti_alerts_msg_po').innerHTML = arr_msg[0];
				   }
				   else{
					   var val = 0;
					   document.getElementById('badge_value_po').innerHTML = val;
					   document.getElementById('noti_alerts_msg_po').innerHTML = 'There is no notification yet!';
				   }
				  
				  }
				 });
				}
			
			
			function fetchdataAlertSO(){
				var myurl = "<%=path%>";
				myurl+="/com/stpl/pms/action/bo/lm/getAlertSO.action";
				 $.ajax({
				  url: myurl,
				  type: 'post',
				  success: function(response){
					  var arr_msg = response.split('|');
				   // Perform operation on the return value
				   if(response.includes('|')){
					   document.getElementById('badge_value_so').innerHTML = arr_msg[1];
					   document.getElementById('noti_alerts_msg_so').innerHTML = arr_msg[0];
				   }
				   else{
					   var val = 0;
					   document.getElementById('badge_value_so').innerHTML = val;
					   document.getElementById('noti_alerts_msg_so').innerHTML = 'There is no notification yet!';
				   }
				  
				  }
				 });
				}
			function fetchdataAlertCN(){
				var myurl = "<%=path%>";
				myurl+="/com/stpl/pms/action/bo/lm/getAlertCN.action";
				 $.ajax({
				  url: myurl,
				  type: 'post',
				  success: function(response){
					  var arr_msg = response.split('|');
				   // Perform operation on the return value
				   if(response.includes('|')){
					   document.getElementById('badge_value_cn').innerHTML = arr_msg[1];
					   document.getElementById('noti_alerts_msg_cn').innerHTML = arr_msg[0];
				   }
				   else{
					   var val = 0;
					   document.getElementById('badge_value_cn').innerHTML = val;
					   document.getElementById('noti_alerts_msg_cn').innerHTML = 'There is no notification yet!';
				   }
				  
				  }
				 });
				}
			function fetchdataAlertDN(){
				var myurl = "<%=path%>";
				myurl+="/com/stpl/pms/action/bo/lm/getAlertDN.action";
				 $.ajax({
				  url: myurl,
				  type: 'post',
				  success: function(response){
					  var arr_msg = response.split('|');
				   // Perform operation on the return value
				   if(response.includes('|')){
					   document.getElementById('badge_value_dn').innerHTML = arr_msg[1];
					   document.getElementById('noti_alerts_msg_dn').innerHTML = arr_msg[0];
				   }
				   else{
					   var val = 0;
					   document.getElementById('badge_value_dn').innerHTML = val;
					   document.getElementById('noti_alerts_msg_dn').innerHTML = 'There is no notification yet!';
				   }
				  
				  }
				 });
				}
			function fetchdataAlertPMT(){
				var myurl = "<%=path%>";
				myurl+="/com/stpl/pms/action/bo/lm/getAlertPMT.action";
				 $.ajax({
				  url: myurl,
				  type: 'post',
				  success: function(response){
					  var arr_msg = response.split('|');
				   // Perform operation on the return value
				   if(response.includes('|')){
					   document.getElementById('badge_value_pmt').innerHTML = arr_msg[1];
					   document.getElementById('noti_alerts_msg_pmt').innerHTML = arr_msg[0];
				   }
				   else{
					   var val = 0;
					   document.getElementById('badge_value_pmt').innerHTML = val;
					   document.getElementById('noti_alerts_msg_pmt').innerHTML = 'There is no notification yet!';
				   }
				  
				  }
				 });
				}
			function fetchdataAlertRCPT(){
				var myurl = "<%=path%>";
				myurl+="/com/stpl/pms/action/bo/lm/getAlertRCPT.action";
				 $.ajax({
				  url: myurl,
				  type: 'post',
				  success: function(response){
					  var arr_msg = response.split('|');
				   // Perform operation on the return value
				   if(response.includes('|')){
					   document.getElementById('badge_value_rcpt').innerHTML = arr_msg[1];
					   document.getElementById('noti_alerts_msg_rcpt').innerHTML = arr_msg[0];
				   }
				   else{
					   var val = 0;
					   document.getElementById('badge_value_rcpt').innerHTML = val;
					   document.getElementById('noti_alerts_msg_rcpt').innerHTML = 'There is no notification yet!';
				   }
				  
				  }
				 });
				}
			

				$(document).ready(function(){
				 setInterval(fetchdataAlert,60000);
				});
				$(document).ready(function(){
					 setInterval(fetchdataAlertPO,300000);
					});
				$(document).ready(function(){
					 setInterval(fetchdataAlertSO,360000);
					});
				$(document).ready(function(){
					 setInterval(fetchdataAlertCN,370000);
					});
				$(document).ready(function(){
					 setInterval(fetchdataAlertDN,380000);
					});
				$(document).ready(function(){
					 setInterval(fetchdataAlertPMT,390000);
					});
				$(document).ready(function(){
					 setInterval(fetchdataAlertRCPT,400000);
					});
				fetchdataAlert();
				fetchdataAlertPO();
				fetchdataAlertSO();
				fetchdataAlertCN();
				fetchdataAlertDN();
				fetchdataAlertPMT();
				fetchdataAlertRCPT();
				
        </script>	
		<decorator:head />
	</head>
	<body >
	<%-- <s:if test="%{@com.stpl.pms.utility.Utility@getServerDate(0,0,0,\"dd\") > 10}">
		<div style="width: 100%; background-color: #cb0600; padding: 7px 4px; text-align: center; color: #ffffff; font-weight: 600;"><s:text name="global.licence"></s:text> <%= Utility.getServerDate(0, 1, 0, "MMMMM")%>.</div>
	</s:if>
	<s:else>
		<div style="width: 100%; background-color: #cb0600; padding: 7px 4px; text-align: center; color: #ffffff; font-weight: 600;"><s:text name="global.licence"></s:text> <%= Utility.getServerDate(0, 0, 0, "MMMMM")%>.</div>
	</s:else> --%>
	 <!-- top section start-->
  		<div id="TopBar">
         <div class="logo"><img src="<%= request.getContextPath()%>/images/client-specific/<%=Utility.getClientName() %>/logo-new.png" alt="logo" /></div>
            <div id="top_right">
                <div class="welcomebox">
                    <p> <s:text name="global.home.welcome"/>:<label id="currentLoggedUser"> <s:property value="%{userInfoBean.userName}"/></label>
                        <a
						href="<%=request.getContextPath()%>/com/stpl/pms/action/bo/lm/bo_lm_logout.action"><img
							src="<%=request.getContextPath()%>/images/logout.png" alt="logout" /> </a> 
                    </p>
                </div>
                
                <div class="changePSW">
              		<p>
						<a href="<%=request.getContextPath()%>/com/stpl/pms/action/bo/lm/bo_lm_changePassword.action"><s:text name="global.home.changepassword"/></a>
<%-- 						<br/>  Online Players : <s:property value="%{onlinePlayerCount}"/> --%>
		 			</p>
            	</div>
        	</div>
		    <s:if test="%{'ADMIN'.equals(userInfoBean.userType)||#session.impersionateeBean!=null}">
		        <div id="top_right_impersonate">
		        	<s:if test="%{#session.impersionateeBean!=null}">
			       		<div class="welcombox">
			       			<div>Impersonating user :&nbsp<span style="font-weight: 600!important;"><s:property value="%{#session.impersionateeBean.userName}" /></span><button id="quit_impersonate">quit</button></div>
			       		</div>
			    	</s:if>
			    	<s:else>
			        	<div id="impersonate_welcomebox" class="welcomebox">
			        		<button id="bo_impersonate">Impersonate</button>
			        	</div>
		        	</s:else>
		    	</div>
	    	</s:if>
    	 </div>
 	<!-- top section end-->
 	<div id="container">
    <!-- container div start-->
 	<a href="javascript:;" class="notification" onclick="openAlertBox()"><span>Alert</span><span id="badge_value" class="badge">0</span></a>
 	<a href="javascript:;" class="notification" onclick="openAlertBoxPO()" style="margin-right:20px;"><span>Purchase Order</span><span id="badge_value_po" class="badge">0</span></a>
	<a href="javascript:;" class="notification" onclick="openAlertBoxSO()" style="margin-right:20px;"><span>Sale Order</span><span id="badge_value_so" class="badge">0</span></a>
	<a href="javascript:;" class="notification" onclick="openAlertBoxCN()" style="margin-right:20px;"><span>Credit Note</span><span id="badge_value_cn" class="badge">0</span></a>
	<a href="javascript:;" class="notification" onclick="openAlertBoxDN()" style="margin-right:20px;"><span>Debit Note</span><span id="badge_value_dn" class="badge">0</span></a>
	<a href="javascript:;" class="notification" onclick="openAlertBoxPMT()" style="margin-right:20px;"><span>Payment</span><span id="badge_value_pmt" class="badge">0</span></a>
	<a href="javascript:;" class="notification" onclick="openAlertBoxRCPT()" style="margin-right:20px;"><span>Receipt</span><span id="badge_value_rcpt" class="badge">0</span></a>
	
		<s:include value="/com/stpl/pms/action/bo/common/header.jsp" />
		<div class="clear"></div>
		<!--navigation start-->
		<div id="Navigation">
			<div id="top">
				<div id="navbox">
				
				</div>
				<div id="top_bar">
					<div id="main_menu">
												
					<div class="clear"></div>
					</div>
	          					</div>
	          					
	          					
				<div class="clear"></div>
			</div>
		</div>
		<div class="clear2"></div>
					
	<div id="decoBody">
		<decorator:body />
	</div>
	</div>
	<div id="noti_myModal" class="noti_modal">

  <!-- Modal content -->
  <div class="noti_modal-content">
    <span class="noti_close">&times;</span>
    <div id="noti_alerts_msg"></div>
  </div>

</div>
<div id="noti_myModal_po" class="noti_modal_po">

  <!-- Modal content -->
  <div class="noti_modal-content_po">
    <span class="noti_close_po">&times;</span>
    <div id="noti_alerts_msg_po"></div>
  </div>

</div>
<div id="noti_myModal_so" class="noti_modal_so">

  <!-- Modal content -->
  <div class="noti_modal-content_so">
    <span class="noti_close_so">&times;</span>
    <div id="noti_alerts_msg_so"></div>
  </div>

</div>
<div id="noti_myModal_cn" class="noti_modal_cn">

  <!-- Modal content -->
  <div class="noti_modal-content_cn">
    <span class="noti_close_cn">&times;</span>
    <div id="noti_alerts_msg_cn"></div>
  </div>

</div>
<div id="noti_myModal_dn" class="noti_modal_dn">

  <!-- Modal content -->
  <div class="noti_modal-content_dn">
    <span class="noti_close_dn">&times;</span>
    <div id="noti_alerts_msg_dn"></div>
  </div>

</div>
<div id="noti_myModal_pmt" class="noti_modal_pmt">

  <!-- Modal content -->
  <div class="noti_modal-content_pmt">
    <span class="noti_close_pmt">&times;</span>
    <div id="noti_alerts_msg_pmt"></div>
  </div>

</div>
<div id="noti_myModal_rcpt" class="noti_modal_rcpt">

  <!-- Modal content -->
  <div class="noti_modal-content_rcpt">
    <span class="noti_close_rcpt">&times;</span>
    <div id="noti_alerts_msg_rcpt"></div>
  </div>

</div>
	<div class="footer-main"><p><jsp:include page="/com/stpl/pms/action/bo/common/copyright-client-specific.jsp"/></p></div>
	<script type="text/javascript" src="<%=path%>/js/common.js"></script>		
	</body>
	<script>
	createMenu('MGMT');
	</script>
</html>