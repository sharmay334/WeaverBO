<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags" %>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>Print Ready Data</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script src="/WeaverBO/js/sweetalert.min.js"></script>
<script type = "text/javascript" 
         src = "/WeaverBO/js/jQuery/1.11.3/jquery-ui.min.js">
      </script>
      <link rel="stylesheet" href="/WeaverBO/js/jQuery/1.11.3/jquery-ui.css">
<script>
$(document).ready( function () {
	$("#game_batch_div").hide();


});
function CallbatchNoList()
{
	var gameNo = document.getElementById("gameNo").value;
	$.ajax({
		type : "GET",
		url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_batch_no_list_print_ticket.action?gameNo="
				+gameNo,
		success : function(itr) {
			$("#game_batch_div").show();
			$("#game_batch_div").html(itr);
			
			},
 
		error : function(itr) {
			$("#game_batch_div").hide();
		}
	});
	
}
function getPrintResult()
{
		var gameNo=document.getElementById("gameNo").value;
		var batchNo=$('#roleId :selected').val();
		
		var errmsg1 = document.getElementById("errmsg1").value;		
		var errmsg2 = document.getElementById("errmsg2").value;
		var errmsg3 = document.getElementById("errmsg3").value;
		var errmsg4 = document.getElementById("errmsg4").value;
		var errmsg5 = document.getElementById("errmsg5").value;
		
		if(gameNo==-1 || gameNo=="No game available")
			{
			swal(errmsg1, {
			      icon: "warning",
			    });
			}
		else if(batchNo==-1 || batchNo=="No batch available")
			{
			swal(errmsg2, {
			      icon: "warning",
			    });
		}
		else
			{
			$.ajax({
				type : "GET",
				url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_print_ticket_result.action?gameNo="
						+gameNo+"&batchNo="+batchNo,
				success : function(itr) {
					
					if(itr=="no file "){
						swal(errmsg3, {
						      icon: "warning",
						    });
						}
					else
						{
						$('#searchDiv').html(itr);
						swal(errmsg4, {
						      icon: "success",
						    });
						}
					$.ajax({
						type : "GET",
						url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_global_bo_mail_send_activity.action?emailType=DOWNLOAD_PRINT_READY_EMAIL_BO&gameNo="+gameNo+"&batchNo="+batchNo+"&mailMsg='requested for print ready'",
						success : function(itr) {
							 		
						},
						error : function(itr) {
								

								}
					});	
						$.ajax({
						type : "GET",
						url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_global_bo_mail_send_activity.action?emailType=DOWNLOAD_PRINT_READY_EMAIL_USER&gameNo="+gameNo+"&batchNo="+batchNo+"&mailMsg='requested for print ready'",
						success : function(itr) {
							 		
						},
						error : function(itr) {
								

								}
					});	
						
						$.ajax({
							type : "GET",
							url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_global_bo_mail_send_activity.action?emailType=PRINT_TICKET_SUPPORT&gameNo="+gameNo+"&batchNo="+batchNo+"&mailMsg='support'",
							success : function(itr) {
								 		
							},
							error : function(itr) {
									

									}
						});	
														$.ajax({
														type : "GET",
														url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_global_bo_sms_send_activity.action?smsType=PRINT_TICKET&gameNo="+gameNo+"&batchNo="+batchNo,
														success : function(itr) {
															 		
														},
														error : function(itr) {
																

																}
													});	
													$.ajax({
														type : "GET",
														url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_global_bo_sms_send_activity_to_bo.action?smsType=BO_PRINT_TICKET&gameNo="+gameNo+"&batchNo="+batchNo,
														success : function(itr) {
															 		
														},
														error : function(itr) {
																

																}
													});	
					},
		 
				error : function(itr) {
					$("#game_batch_div").hide();
					swal(errmsg5, {
					      icon: "warning",
					    });
				}
			});
			}
		
		
}


		</script>
	</head>
	<body>
	<input type="hidden" value='<s:text name="global.generateprintreadydata.PleaseSelectgamenumberfirst"/>' id="errmsg1"/>
	<input type="hidden" value='<s:text name="global.generateprintreadydata.PleaseSelectbatchnumberfirst"/>' id="errmsg2"/>
	<input type="hidden" value='<s:text name="global.printready.101"/>' id="errmsg3"/>	
	<input type="hidden" value='<s:text name="global.printready.102"/>' id="errmsg4"/>
	<input type="hidden" value='<s:text name="global.printready.103"/>' id="errmsg5"/>
	
		<div class="clear2"></div>
		<h2>
			<s:text name="global.home.generateprintreadydata"/>
		</h2>

		<!--form section first start-->
		<div class="FormSection">

			<div class="greyStrip">
				<h4>
					<s:text name="global.searchuser.requiredinformation"></s:text>
				</h4>
			</div>
				<div class="innerBox">
						<div class="FormMainBox">

							<div class="labelDiv">
								<label>
									<s:text name="global.printready.selectgame"/>
								</label>
							</div>
							<div class="InputDiv">
								<s:select name="gameNo" id="gameNo" headerKey="-1"
									headerValue="%{getText('global.SELECTHEADER')}" list="gameNoList"
									cssClass="select1" theme="myTheme" onchange="CallbatchNoList()"></s:select>
							</div>
						</div>
						
						<div class="clearFRM"></div>
						
						<div class="FormMainBox" id="game_batch_div">

						</div>
				
					
				</div>
				<div class="box_footer" align="right">
					<%-- <s:submit value="Generate" align="left" cssStyle="margin-left:0px"
						cssClass="button" theme="simple" onclick="getPrintResult()"></s:submit> --%>
						
						<input type="submit" align="left" value='<s:text name="global.uploadnewgame.generate"/>' style="margin-left:0px" class="button" onclick="getPrintResult()" />
				</div>
		</div>
		<div id="searchDiv"></div>
		<br />
		<br />
	</body>
</html>
