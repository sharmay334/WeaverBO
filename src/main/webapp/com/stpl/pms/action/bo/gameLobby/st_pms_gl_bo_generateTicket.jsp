<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>Generate Ticket</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script src="/WeaverBO/js/sweetalert.min.js"></script>
<script type="text/javascript"
	src="/WeaverBO/js/jQuery/1.11.3/jquery-ui.min.js">
      </script>
<link rel="stylesheet" href="/WeaverBO/js/jQuery/1.11.3/jquery-ui.css">
<script>
$(document).ready( function () {
	$("#batch_no_div").hide();
	$("#game_no_div").hide();
	$("#batch_no_div1").hide();
	$("#game_no_div1").hide();
	});

function Callstatus()
{
	var ticketStatus = document.getElementById("ticketStatus").value;
	
	if(ticketStatus==-1){
		$("#batch_no_div").hide();
		$("#game_no_div").hide();
		$("#batch_no_div1").hide();
		$("#game_no_div1").hide();
		}
	else
		{
		$.ajax({
			type : "GET",
			url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_game_status_gameUploadGeneration.action?ticketStatus="+ticketStatus,
			success : function(itr) {
				$("#game_no_div1").show();
				$("#game_no_div").show();
				$("#game_no_div").html(itr);
				
				},
	 
			error : function(itr) {
				$("#game_no_div").hide();
				$("#batch_no_div").hide();
				$("#game_no_div1").hide();
				$("#batch_no_div1").hide();
			}
		});
		}
	}

function generateTicket()
	{
	var generation110 = document.getElementById('generation110').value;
	var generation111 = document.getElementById('generation111').value;
	var generation112 = document.getElementById('generation112').value;
	var generation113 = document.getElementById('generation113').value;
	
	var generation114 = document.getElementById('generation114').value;
	var generation115 = document.getElementById('generation115').value;
	var generation116 = document.getElementById('generation116').value;
	var generation117 = document.getElementById('generation117').value;
	var generation118 = document.getElementById('generation118').value;
	
	var generation119 = document.getElementById('generation119').value;
	var generation120 = document.getElementById('generation120').value;
	var generation121 = document.getElementById('generation121').value;
	var generation122 = document.getElementById('generation122').value;
	var generation123 = document.getElementById('generation123').value;
	
	var generationonceclicked = document.getElementById('generationonceclicked').value;
	
	var gameNo=$('#roleId1 :selected').val();
	var ticketStatus = document.getElementById("ticketStatus").value;
	var batchNo = $('#roleId :selected').val();
	
		if(gameNo=='' || gameNo==-1){

		swal(generation111, {
					      icon: "warning",
					    });
		}
		else if(ticketStatus == -1)
	{
		swal(generation112, {
					      icon: "warning",
					    });
	}
	else{


	 $.ajax({
			type : "POST",
			cache : false,
			contentType : false,
			processData : false,
			url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_batch_status_gameGeneration.action",
			success : function(itr) {
				
				//button enable
			
				if(itr=="1")
					{
					swal(generation110, {
					      icon: "warning",
					    });
					
					}
				else if(itr=="0")
					{
					if(gameNo=='')
					{
					$("#gameNO").effect( "shake", {times:1}, 200 );
					document.getElementById("gameNO").style.borderColor = "red";
					}
				else if(ticketStatus==-1)
					{
					swal(generation112, {
					      icon: "warning",
					    });
					}
				else if(batchNo==-1)
					{
					swal(generation113, {
					      icon: "warning",
					    });
					}
				else if(ticketStatus=='Generated' && batchNo!=-1)
					{
					///button disable
					
					swal({
						  title: generation114,
						  text: generation115,
						  icon: "/WeaverBO/images/ticket.png",
						  buttons: true,
						  dangerMode: true,
						  
						}).then((willDelete) => {	
						  if (willDelete) {
							  swal({
								  title: generation116,
								  icon: "/WeaverBO/images/1.gif",
								  buttons: false,
								});
								
							  $.ajax({
									type : "POST",
									cache : false,
									contentType : false,
									processData : false,
									url : "/WeaverBO/com/stpl/pms/action/bo/gl/ticket_generate_start_click.action?gameNo="+gameNo+"&batchNo="+batchNo,
									success : function(itr) {
										var msg = itr;
										//button enable
										
										if(itr=="success")
											{
											swal(generation117, {
											      icon: "success",
											    });	
											
											ticketStatus = -1;
											$("#batch_no_div").hide();
											$("#game_no_div").hide();
											$("#batch_no_div1").hide();
											$("#game_no_div1").hide();								
											
													$.ajax({
														type : "GET",
														url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_global_bo_mail_send_activity.action?emailType=GENERATE_TICKET_EMAIL_USER&gameNo="+gameNo+"&batchNo="+batchNo+"&mailMsg='generated'",
														success : function(itr) {
															 		
														},
														error : function(itr) {
																

																}
													});	
													
													$.ajax({
														type : "GET",
														url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_global_bo_mail_send_activity.action?emailType=GENERATE_TICKET_SUPPORT&gameNo="+gameNo+"&batchNo="+batchNo+"&mailMsg='support'",
														success : function(itr) {
															 		
														},
														error : function(itr) {
																

																}
													});	
													
													$.ajax({
														type : "GET",
														url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_global_bo_sms_send_activity.action?smsType=GENERATING_TICKETS&gameNo="+gameNo+"&batchNo="+batchNo,
														success : function(itr) {
															 		
														},
														error : function(itr) {
																

																}
													});	 		
												
											}
										else if(itr=='')
											{
											swal(generation118, {
											      icon: "warning",
											    });
											}
										else 
											{
											swal(msg, {
											      icon: "warning",
											    });
											}
									},
									error : function(itr) {
										
									}
								});
						  } else {
						    swal(generation119);
						   
						  }
						});

					}
				else{
					//button disable
					
				swal({
					  title: generation114,
					  text: generationonceclicked,
					  icon: "/WeaverBO/images/ticket.png",
					  buttons: true,
					  dangerMode: true,
					}).then((willDelete) => {	
					  if (willDelete) {
						  swal({
							  title: generation116,
							  icon: "/WeaverBO/images/1.gif",
							  buttons: false,
							});
							
						  $.ajax({
								type : "POST",
								cache : false,
								contentType : false,
								processData : false,
								url : "/WeaverBO/com/stpl/pms/action/bo/gl/ticket_generate_start_click.action?gameNo="+gameNo+"&batchNo="+batchNo,
								success : function(itr) {
									var msg = itr;
									//button enable
									
									if(itr=="success")
										{
										swal(generation117, {
										      icon: "success",
										    });
											ticketStatus = -1;
											$("#batch_no_div").hide();
											$("#game_no_div").hide();
											$("#batch_no_div1").hide();
											$("#game_no_div1").hide();	
												$.ajax({
													type : "GET",
													url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_global_bo_mail_send_activity.action?emailType=GENERATE_TICKET_EMAIL_USER&gameNo="+gameNo+"&batchNo="+batchNo+"&mailMsg='generated'",
													success : function(itr) {
														 		
													},
													error : function(itr) {
															

															}
												});
												
												$.ajax({
													type : "GET",
													url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_global_bo_mail_send_activity.action?emailType=GENERATE_TICKET_SUPPORT&gameNo="+gameNo+"&batchNo="+batchNo+"&mailMsg='support'",
													success : function(itr) {
														 		
													},
													error : function(itr) {
															

															}
												});	
	 											$.ajax({
														type : "GET",
														url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_global_bo_sms_send_activity.action?smsType=GENERATING_TICKETS&gameNo="+gameNo+"&batchNo="+batchNo,
														success : function(itr) {
															 		
														},
														error : function(itr) {
																

																}
													});	 
											
										}
									else if(itr=='')
										{
										swal(generation118, {
										      icon: "warning",
										    });
										}
									else 
										{
										swal(msg, {
										      icon: "warning",
										    });
										}
								},
								error : function(itr) {
									//button enable
									
								}
							});
					  } else {
					    swal(generation119);
					 	 //button enable
					    
					  }
					});
				}
					
					
					}
			},
			error : function(itr) {
				
			}
		});

}
	
	}

function validGameNo(GameNo) {
	
	var gameNo = GameNo.value;
	var pattern = /^[0-9]+$/;
	$('#game_status_div').hide();
	$("#batch_no_div").hide();
	if (gameNo.match(pattern) && (gameNo.length > 2 && gameNo.length < 4))
		{
		$('#tooltp').hide();
		document.getElementById("gameNO").style.borderColor = "green";
		$.ajax({
			type : "GET",
			url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_batch_status_gameGenerateTime.action?gameNo="
					+gameNo,
			success : function(itr) {
				if(itr.includes("exists"))
				$('#game_status_div').show();
				else
					{
					$('#game_status_div').hide();
					$('#tooltp').show();
					var msg="Game not exists.";
					document.getElementById("tooltp").innerHTML = msg;
					document.getElementById("gameNO").style.borderColor = "red";
					}
					
				},
	 
			error : function(itr) {
				swal("Some error occured!");
			}
		});
		
			}
	else if(!gameNo.match(pattern))
		{
		$('#tooltp').show();
		var msg="Alphabet & Special characters are not allowed.";
		document.getElementById("tooltp").innerHTML = msg;
		document.getElementById("gameNO").style.borderColor = "red";
		}
	else if(!(gameNo.length > 2 && gameNo.length < 4))
		{
		$('#tooltp').show();
		var msg="Game number length must be 3 digit.";
		document.getElementById("tooltp").innerHTML = msg;
		document.getElementById("gameNO").style.borderColor = "red";
		}
	else {
		$('#tooltp').show();
		document.getElementById("gameNO").style.borderColor = "red";

	}

}
</script>
<link rel="stylesheet" href="/WeaverBO/css/custom.css">
</head>

<body>

	<input type="hidden" value='<s:text name="global.itgs.110"/>' id="generation110" />
	<input type="hidden" value='<s:text name="global.itgs.111"/>' id="generation111" />
	<input type="hidden" value='<s:text name="global.itgs.112"/>' id="generation112" />
	<input type="hidden" value='<s:text name="global.itgs.113"/>' id="generation113" />
	<input type="hidden" value='<s:text name="global.itgs.114"/>' id="generation114" />
	<input type="hidden" value='<s:text name="global.itgs.115"/>' id="generation115" />
	<input type="hidden" value='<s:text name="global.itgs.116"/>' id="generation116" />
	<input type="hidden" value='<s:text name="global.itgs.117"/>' id="generation117" />
	<input type="hidden" value='<s:text name="global.itgs.118"/>' id="generation118" />
	<input type="hidden" value='<s:text name="global.itgs.119"/>' id="generation119" />
	<input type="hidden" value='<s:text name="global.itgs.120"/>' id="generation120" />
	<input type="hidden" value='<s:text name="global.itgs.121"/>' id="generation121" />
	<input type="hidden" value='<s:text name="global.itgs.122"/>' id="generation122" />
	<input type="hidden" value='<s:text name="global.itgs.123"/>' id="generation123" />
	<input type="hidden" value='<s:text name="global.gen.warning"/>'
		id="generationonceclicked" />

	<div class="clear2"></div>
	<h2>
		<s:text name="global.home.generatetestreadydata" />
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>
				<s:text name="global.searchuser.requiredinformation" />
			</h4>
		</div>

		<div class="FormMainBox" id="game_status_div">
			<div class="labelDiv">
				<label><s:text
						name="global.generatetestreadydata.SelectTicketStatus" /></label>
			</div>
			<div class="InputDivHalf" id="showTicketStatusDiv">
				<select name="ticketStatus" id="ticketStatus" onchange=Callstatus()>
					<option value="-1"><s:text name="global.SELECTHEADER"></s:text></option>
					<option value="Initiated"><s:text name="global.generatetestreadydata.initiated"></s:text></option>
					<option value="Generated"><s:text name="global.generatetestreadydata.generated"/></option>
				</select>
			</div>
		</div>

		<div class="clearFRM" id="game_no_div1"></div>

		<div class="FormMainBox" id="game_no_div"></div>

		<div class="clearFRM" id="batch_no_div1"></div>

		<div class="FormMainBox" id="batch_no_div"></div>

		<div class="box_footer" align="right">
			<%-- <s:submit value="Generate" align="left" id="generateBtn"
				cssStyle="margin-left:0px" cssClass="button" theme="simple"
				onclick="generateTicket()"></s:submit> --%>
			<input type="submit" align="left" id="generateBtn"
				value='<s:text name="global.generatetestreadydata.generateButon"/>'
				style="margin-left: 0px" class="button" onclick="generateTicket()" />
		</div>

	</div>

	<div id="searchDiv"></div>
	<br />
	<br />
</body>
</html>