<%@page import="com.stpl.pms.constants.ServerStatusBean"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%@ page import="com.stpl.pms.*" %>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>


<base href="<%=basePath%>">

<title>Upload Game</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<script src="/WeaverBO/js/sweetalert.min.js"></script>
   
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <script type = "text/javascript"
         src = "https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js">
      </script>
		
      <script type = "text/javascript" 
         src = "https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/jquery-ui.min.js">
      </script>
      <style>
.tooltip {
    position: relative;
    display: inline-block;
    border-bottom: 1px dotted black;
}

.tooltip .tooltiptext {
    visibility: hidden;
    width: 120px;
    background-color: black;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 5px 0;

    /* Position the tooltip */
    position: absolute;
    z-index: 1;
}

</style>
<script type="text/javascript">
var GMN,GMNO,TP,TNT,NBPP,NTBP;
$('#batchToolTip').hide();
$('#packCounting').hide();
$('#tooltp').show();
$(document).ready(function() {
	$("#upload").click(function(event) {
			event.preventDefault();
				var mailGameNo;
				var mailBatchNo;
				var formData = new FormData($("#xmlData")[0]);
				var gameName = document.getElementById("gameName").value;
				var gameNO = document.getElementById("gameNO").value;
				var ticketPrize = document.getElementById("ticketPrize").value;
				var noOfTickets = document.getElementById("noOfTickets").value;
				var noOfTicketsPerBook = document.getElementById("noOfTicketsPerBook").value;
				var noOfBooksPerPack = document.getElementById("noOfBooksPerPack").value;
				var virnDigits = 11;
				var ticket_Str_Xml = document.getElementById("ticket_Str_Xml").value;
				var ge = document.getElementById("ge").value;
				var pd_Xml = document.getElementById("pd_Xml").value;
				var pdc_Xml = document.getElementById("pdc_Xml").value;
				var agtvc_Xml = document.getElementById("agtvc_Xml").value;
				var location_Xml = document.getElementById("location_Xml").value;
				var validate_field=validateTextFields();
				
				var msg1 = document.getElementById("msg1").value;
				var msg2 = document.getElementById("msg2").value;
				var msg3 = document.getElementById("msg3").value;
				var msg4 = document.getElementById("msg4").value;
				var msg5 = document.getElementById("msg5").value;
				var msg6 = document.getElementById("msg6").value;
				var msg7 = document.getElementById("msg7").value;
				var msg8 = document.getElementById("msg8").value;
				var msg9 = document.getElementById("msg9").value;
				var msg10 = document.getElementById("msg10").value;
				
				
				if(validate_field!=true){
				
				}
				else if (ticket_Str_Xml == ''
												|| ge == '' || pd_Xml == ''
												|| pdc_Xml == ''
												|| agtvc_Xml == ''
												|| location_Xml == '' ) {
											alert(msg1);
										} 
				else if(GMN==0 || GMNO==0 || TP==0 || TNT==0 || NBPP==0 || NTBP==0)
					{
					
					alert(msg2);
					}
										 
										else {
											document.getElementById("upload").disabled=true;
											
													$.ajax({
														type : "POST",
														data : formData,
														cache : false,
														contentType : false,
														processData : false,
														url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_game_upload_test_button_click.action?gameName="
																+ gameName
																+ "&gameNO="
																+ gameNO
																+ "&ticketPrize="
																+ ticketPrize
																+ "&noOfTickets="
																+ noOfTickets
																+ "&noOfTicketsPerBook="
																+ noOfTicketsPerBook
																+ "&noOfBooksPerPack="
																+ noOfBooksPerPack
																+ "&virnDigits="
																+ virnDigits,
														success : function(itr) {

															 $('#batchToolTip').hide();               
															 $('#packCounting').hide();
														if(itr.includes("Prize distribution doesn't match"))
															{
																		swal(itr, {
																      icon: "warning",
																    });
														 document.getElementById("gameName").value='';
															document.getElementById("gameNO").value='';
																 document.getElementById("ticketPrize").value='';
																document.getElementById("noOfTickets").value='';
																 document.getElementById("noOfTicketsPerBook").value='';
																document.getElementById("noOfBooksPerPack").value='';
																
																 document.getElementById("ticket_Str_Xml").value='';
																 document.getElementById("ge").value='';
																document.getElementById("pd_Xml").value='';
																document.getElementById("pdc_Xml").value='';
																 document.getElementById("agtvc_Xml").value='';
																 document.getElementById("location_Xml").value='';
																 
															}
											else if(itr=="error"){
																	swal(msg3, {
																      icon: "warning",
																    });
													}
											else if(itr.includes("Some internal error occured")){
													swal(itr, {
																icon: "warning",
																    });
														}
											else if (itr.includes("Game generation already in progress")){
												swal(msg4, {
													icon: "warning",
													    });
												
												 document.getElementById("gameName").value='';
													document.getElementById("gameNO").value='';
														 document.getElementById("ticketPrize").value='';
														document.getElementById("noOfTickets").value='';
														 document.getElementById("noOfTicketsPerBook").value='';
														document.getElementById("noOfBooksPerPack").value='';
														
														 document.getElementById("ticket_Str_Xml").value='';
														 document.getElementById("ge").value='';
														document.getElementById("pd_Xml").value='';
														document.getElementById("pdc_Xml").value='';
														 document.getElementById("agtvc_Xml").value='';
														 document.getElementById("location_Xml").value='';
											}
														
															else
																	{
																
										var batchNo = itr.substring(7, itr.length);
																
										swal({
											  title: msg6,
											  text: msg5,
											  icon: "warning",
											  buttons: ["Save", "Generate"],
											  dangerMode: true,
											}).then((willDelete) => {
											  if (willDelete) {
												  swal({
													  title: msg7,
													  icon: "/WeaverBO/images/1.gif",
													  buttons: false,
													});
											
												  $.ajax({
														type : "POST",
														cache : false,
														contentType : false,
														processData : false,
														url : "/WeaverBO/com/stpl/pms/action/bo/gl/ticket_generation_start.action?gameNo="+gameNO+"&batchNo="+batchNo,
														success : function(itr) {
															if(itr=="success")
																{
																mailGameNo = gameNO;
																mailBatchNo = batchNo;
																swal(msg8, {
																      icon: "success",
																    });
																document.getElementById("upload").disabled=false;	
																$.ajax({
																	type : "GET",
																	url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_global_bo_mail_send_activity.action?emailType=GENERATE_TICKET_EMAIL_USER&gameNo="+mailGameNo+"&batchNo="+mailBatchNo+"&mailMsg='generated'",
																	success : function(itr) {
																		 		
																	},
																	error : function(itr) {
																			

																			}
																});
																$.ajax({
																	type : "GET",
																	url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_global_bo_sms_send_activity.action?smsType=GENERATING_TICKETS&gameNo="+gameNO+"&batchNo="+batchNo,
																	success : function(itr) {
																		 		
																	},
																	error : function(itr) {
																			

																			}
																});	 				
																		
																}
															else if(itr==''){
																swal(msg9, {
																      icon: "warning",
																    });
																}
															else
																{
											
																swal(itr, {
																      icon: "warning",
																    });
																}
														},
														error : function(itr) {
															
														}
													});
											  } else {
											    swal(msg10)
												.then((value) => {
  													location.reload();
														});
											  }
											});
																	
																	 document.getElementById("gameName").value='';
																	document.getElementById("gameNO").value='';
																	 document.getElementById("ticketPrize").value='';
																	document.getElementById("noOfTickets").value='';
																	 document.getElementById("noOfTicketsPerBook").value='';
																	document.getElementById("noOfBooksPerPack").value='';
																	 document.getElementById("virnDigits").value='';
																	 document.getElementById("ticket_Str_Xml").value='';
																	 document.getElementById("ge").value='';
																	document.getElementById("pd_Xml").value='';
																	document.getElementById("pdc_Xml").value='';
																	 document.getElementById("agtvc_Xml").value='';
																	 document.getElementById("location_Xml").value='';
																	
																	}
																
														},
														error : function(itr) {
														
														}
													});

										}

									});

				});
	function validGameName(GameName) {
		var gameName = GameName.value;
 		var pattern = /^[0-9 a-z A-Z]+$/;
 		var temp = gameName.trim();
		var errmsg1 = document.getElementById("errmsg1").value;
		var errmsg2 = document.getElementById("errmsg2").value;
		
		if(gameName.match(pattern) && (gameName.length > 3 && gameName.length < 80) && (temp!='' && temp.length >3))
			{	
			$('#tooltp').hide();
			document.getElementById("gameName").style.borderColor = "green";
			GMN = 1;
			}
		else if(!gameName.match(pattern))
			{
			GMN = 0;
			$('#tooltp').show();
			var msg=errmsg1;
			document.getElementById("tooltp").innerHTML = msg;
			document.getElementById("gameName").style.borderColor = "red";
			}
		else if(!(gameName.length > 3 && gameName.length < 80)){
			GMN = 0;
			$('#tooltp').show();
			var msg=errmsg2;
			document.getElementById("tooltp").innerHTML = msg;
			document.getElementById("gameName").style.borderColor = "red";
			}
		else {
			GMN = 0;
			document.getElementById("gameName").style.borderColor = "red";
				
		}

	}

	function validGameNo(GameNo) {
		
		var gameNo = GameNo.value;
		var pattern = /^[0-9]+$/;
		var status = gameNo.startsWith("0");
		var startRange =<%=ServerStatusBean.getGAME_START_RANGE()%> ;
		var endRange = <%=ServerStatusBean.getGAME_END_RANGE()%>;
	//	var pattern = /^(?:[1-9]\d*|0)$/;
		var errmsg3 = document.getElementById("errmsg3").value;	
		var errmsg4 = document.getElementById("errmsg4").value;	
		var errmsg5 = document.getElementById("errmsg5").value;	
		var errmsg6 = document.getElementById("errmsg6").value;
		var errmsg12 = document.getElementById("errmsg12").value;
		var errmsgbatch = document.getElementById("errmsgbatch").value;
		
		 if((gameNo.match(pattern) && !status) && (gameNo.length > 2 && gameNo.length < 4) && (gameNo >= startRange && gameNo <=endRange))
 			{
			 $('#batchToolTip').hide();
			document.getElementById("gameNO").style.borderColor = "green";
			GMNO = 1;
			$.ajax({
				type : "GET",
				url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_batch_status_gameUpload.action?gameNo="
						+gameNo,
				success : function(itr) {
					var data= itr.substring(0,6);
					if(data=="exists")
						{
						/* $('#batchToolTip').show();
						   setTimeout(function() { 
						       $('#batchToolTip').fadeOut(); 
						       
						   }, 2200); */
						   var batch=itr.substring(6,itr.length);
						   
						   if(batch.length<2)
							   {
							   GMNO = 1;
							   $('#batchToolTip').show();
							   var msg=errmsgbatch+" "+batch+".";
							document.getElementById("batchToolTip").innerHTML = msg;
							   
							   }
						   else
							   {
							   $('#batchToolTip').show();
							   var msg=errmsg3;
								document.getElementById("batchToolTip").innerHTML = msg;
								document.getElementById("gameNO").style.borderColor = "red";
								GMNO = 0;
							   }
						   
						}
					else
						{
						$('#batchToolTip').hide();
						}
					},
		 
				error : function(itr) {
					$('#batchToolTip').hide();
				}
			});
 			}
		 else if(status)
			 {
			 GMNO = 0;
			 $('#batchToolTip').show();
				var msg=errmsg4;
				document.getElementById("batchToolTip").innerHTML = msg;
				document.getElementById("gameNO").style.borderColor = "red";
			 }
		 else if(!(gameNo.length > 2 && gameNo.length < 4))
			 {
			 GMNO = 0;
			 $('#batchToolTip').show();
				var msg=errmsg5;
				document.getElementById("batchToolTip").innerHTML = msg;
				document.getElementById("gameNO").style.borderColor = "red";
			 }
		 else if(!gameNo.match(pattern))
			 {
			 GMNO = 0;
			 $('#batchToolTip').show();
				var msg=errmsg6;
				document.getElementById("batchToolTip").innerHTML = msg;
				document.getElementById("gameNO").style.borderColor = "red";
			 }
		else {
			$('#batchToolTip').show();
			var msg=errmsg12;
			document.getElementById("batchToolTip").innerHTML = msg;
			document.getElementById("gameNO").style.borderColor = "red";
			GMNO = 0;
		}

	}

	function validTicketPrize(TicketPrize) {
		var ticketPrize = TicketPrize.value;
		var pattern = /^[0-9]+$/;
		var errmsg6 = document.getElementById("errmsg6").value;
		var errmsg7 = document.getElementById("errmsg7").value;
		var errmsg8 = document.getElementById("errmsg8").value;
		
 		if((ticketPrize.match(pattern) && ticketPrize!=0)&& (ticketPrize.length > 0 && ticketPrize.length < 11) && (ticketPrize%1000==0) )
 			{
 			$('#tooltpTktPrc').hide();
 			document.getElementById("ticketPrize").style.borderColor = "green";		
 			TP = 1;
 			}
 		else if(!ticketPrize.match(pattern))
 	 		{
 			$('#tooltpTktPrc').show();
			var msg=errmsg6;
			document.getElementById("tooltpTktPrc").innerHTML = msg;
			document.getElementById("ticketPrize").style.borderColor = "red";
			TP = 0;
 	 		}
 		else if(!(ticketPrize.length > 0 && ticketPrize.length < 11) || ticketPrize==0)
 	 		{
 			$('#tooltpTktPrc').show();
			var msg=errmsg7;
			document.getElementById("tooltpTktPrc").innerHTML = msg;
			document.getElementById("ticketPrize").style.borderColor = "red";
			TP = 0;
 	 		}
		else {
			$('#tooltpTktPrc').show();
			var msg=errmsg8;
			document.getElementById("tooltpTktPrc").innerHTML = msg;
			
			document.getElementById("ticketPrize").style.borderColor = "red";
			TP = 0;
		}

	}
	function validNoOfTicket(NoOfTicket) {
		
		var noOfticket = NoOfTicket.value;
 		var pattern = /^[0-9]+$/;
 		
 		var noOfTicketsPerBook = document.getElementById("noOfTicketsPerBook").value;
		var noOfBooksPerPack = document.getElementById("noOfBooksPerPack").value;

		var noOfPacks =  noOfticket/(noOfTicketsPerBook*noOfBooksPerPack);
		var decimal=  /^[-+]?[0-9]+\.[0-9]+$/; 
		var errmsg9 = document.getElementById("errmsg9").value;
		var errmsg6 = document.getElementById("errmsg6").value;
		var errmsg7 = document.getElementById("errmsg7").value;
		var errmsg10 = document.getElementById("errmsg10").value;
		noOfPacks=noOfPacks+"";
		
		
		 if(( !noOfPacks.match(decimal) && noOfticket.match(pattern) && noOfticket!=0 ) && (noOfticket.length > 0 && noOfticket.length < 8))
 			{
			 $('#packCounting').hide();
 			document.getElementById("noOfTickets").style.borderColor = "green";
 			TNT = 1;
 			var msg=errmsg9+" "+noOfPacks+".";
			document.getElementById("packCounting").innerHTML = msg;
 			$('#packCounting').show();
			
 			}
		 else if(!noOfticket.match(pattern))
			 {
			 var msg=errmsg6;
				document.getElementById("packCounting").innerHTML = msg;
	 			$('#packCounting').show();
				document.getElementById("noOfTickets").style.borderColor = "red";
				TNT = 0;
			 }
		 else if(noOfticket==0 ||!(noOfticket.length > 0 && noOfticket.length < 11))
			 {
			 var msg=errmsg7;
				document.getElementById("packCounting").innerHTML = msg;
	 			$('#packCounting').show();
				document.getElementById("noOfTickets").style.borderColor = "red";
				TNT = 0;
			 }
		else {
			var msg=errmsg10;
			document.getElementById("packCounting").innerHTML = msg;
 			$('#packCounting').show();
			document.getElementById("noOfTickets").style.borderColor = "red";
			TNT = 0;
		}

	}

	function validTicketPerBook(NoOfTicket) {
		var noOfTicketperbook = NoOfTicket.value;
 		var pattern = /^[0-9]+$/;
 		var errmsg6 = document.getElementById("errmsg6").value;
 		var errmsg11 = document.getElementById("errmsg11").value;
 		var errmsg12 = document.getElementById("errmsg12").value;
 		
 		if(!document.getElementById("noOfTickets").value==''){
 			validNoOfTicket(document.getElementById("noOfTickets"));
 	 		}
		if((noOfTicketperbook.match(pattern) && noOfTicketperbook!=0) && (noOfTicketperbook.length > 0 && noOfTicketperbook.length < 4))
 			{
			$('#tooltpNoOfTcktsPerBk').hide();
 			document.getElementById("noOfTicketsPerBook").style.borderColor = "green";
 			NTBP = 1;
 			}
		else if(!noOfTicketperbook.match(pattern))
			{
			$('#tooltpNoOfTcktsPerBk').show();
			var msg=errmsg6;
			document.getElementById("tooltpNoOfTcktsPerBk").innerHTML = msg;
			document.getElementById("noOfTicketsPerBook").style.borderColor = "red";
			NTBP = 0;
			}
		else if(!(noOfTicketperbook.length > 0 && noOfTicketperbook.length < 6) || noOfTicketperbook==0)
		{
		$('#tooltpNoOfTcktsPerBk').show();
		var msg=errmsg11;
		document.getElementById("tooltpNoOfTcktsPerBk").innerHTML = msg;
		document.getElementById("noOfTicketsPerBook").style.borderColor = "red";
		NTBP = 0;
		}
		else {
			$('#tooltpNoOfTcktsPerBk').show();
			var msg=errmsg12;
			document.getElementById("tooltpNoOfTcktsPerBk").innerHTML = msg;
			document.getElementById("noOfTicketsPerBook").style.borderColor = "red";
			NTBP = 0;
		}
	}

	function validTicketPerPack(NoOfTicket) {

		var noOfBook = NoOfTicket.value;
 		var pattern = /^[0-9]+$/;
 		var errmsg6 = document.getElementById("errmsg6").value;
 		var errmsg11 = document.getElementById("errmsg11").value;
 		var errmsg12 = document.getElementById("errmsg12").value;
 		
 		if(!document.getElementById("noOfTickets").value==''){
 			validNoOfTicket(document.getElementById("noOfTickets"));
 	 		}
 		if((noOfBook.match(pattern) && noOfBook!=0) && (noOfBook.length > 0 && noOfBook.length < 3))
 			{
 			$('#tooltpNoOfBkPerPk').hide();
 			document.getElementById("noOfBooksPerPack").style.borderColor = "green";
 			NBPP = 1;
 			}
 		else if(!(noOfBook.match(pattern) && noOfBook!=0))
 	 		{
 			$('#tooltpNoOfBkPerPk').show();
			var msg=errmsg6;
			document.getElementById("tooltpNoOfBkPerPk").innerHTML = msg;
			document.getElementById("noOfBooksPerPack").style.borderColor = "red";
			NBPP = 0;
 	 		}
 		else if(noOfBook==0 || !(noOfBook.length > 0 && noOfBook.length < 6))
 	 		{
 			$('#tooltpNoOfBkPerPk').show();
			var msg=errmsg11;
			document.getElementById("tooltpNoOfBkPerPk").innerHTML = msg;
			document.getElementById("noOfBooksPerPack").style.borderColor = "red";
			NBPP = 0;
 	 		}
		else {
			$('#tooltpNoOfBkPerPk').show();
			var msg=errmsg12;
			document.getElementById("tooltpNoOfBkPerPk").innerHTML = msg;
			document.getElementById("noOfBooksPerPack").style.borderColor = "red";
			NBPP = 0;
		}

	}

	
	function validateTextFields() {

		var gameName = document.getElementById("gameName").value;
		var gameNO = document.getElementById("gameNO").value;
		var ticketPrize = document.getElementById("ticketPrize").value;
		var noOfTickets = document.getElementById("noOfTickets").value;
		var noOfTicketsPerBook = document.getElementById("noOfTicketsPerBook").value;
		var noOfBooksPerPack = document.getElementById("noOfBooksPerPack").value;
		
		if (gameName == '') {
			$("#gameName").effect("shake");
			document.getElementById("gameName").style.borderColor = "red";
			return false;
		} else if (gameNO == '') {
			$("#gameNO").effect("shake");
			document.getElementById("gameNO").style.borderColor = "red";
			return false;
		} else if (ticketPrize == '') {
			$("#ticketPrize").effect("shake");
			document.getElementById("ticketPrize").style.borderColor = "red";
			return false;
		} else if (noOfTickets == '') {
			$("#noOfTickets").effect("shake");
			document.getElementById("noOfTickets").style.borderColor = "red";
			return false;
		} else if (noOfTicketsPerBook == '') {
			$("#noOfTicketsPerBook").effect("shake");
			document.getElementById("noOfTicketsPerBook").style.borderColor = "red";
			return false;
		} else if (noOfBooksPerPack == '') {
			$("#noOfBooksPerPack").effect("shake");
			document.getElementById("noOfBooksPerPack").style.borderColor = "red";
			return false;
		} 
		 else {
			
			return true;
		}

	}
	function validateFile(fileName, id) {
		var file = fileName.value;
		var errmsg1112 = document.getElementById("errmsg1112").value;
		var ext = file.substring(file.length, file.length - 3);
		if (file != "") {
			if (ext != "xml") {
				document.getElementById(id).value = "";
				alert(errmsg1112);
			}
		}

	}
</script>
<link rel="stylesheet" href="/WeaverBO/css/custom.css">
</head>

<body>

<input type="hidden" value='<s:text name="global.upload.uploaderrmsg1"/>' id="msg1"/>
<input type="hidden" value='<s:text name="global.upload.uploaderrmsg2"/>' id="msg2"/>
<input type="hidden" value='<s:text name="global.upload.uploaderrmsg3"/>' id="msg3"/>
<input type="hidden" value='<s:text name="global.upload.uploaderrmsg4"/>' id="msg4"/>
<input type="hidden" value='<s:text name="global.uploadnewgame.popup1"/>' id="msg5"/>
<input type="hidden" value='<s:text name="global.itgs.114"/>' id="msg6"/>
<input type="hidden" value='<s:text name="global.itgs.116"/>' id="msg7"/>
<input type="hidden" value='<s:text name="global.itgs.upload.success"/>' id="msg8"/>
<input type="hidden" value='<s:text name="global.itgs.118"/>' id="msg9"/>
<input type="hidden" value='<s:text name="global.uploadnewgame.Datasuccessfullyupload"/>' id="msg10"/>

<input type="hidden" value='<s:text name="global.uploadgame.errmsg201"/>' id="errmsg1"/>
<input type="hidden" value='<s:text name="global.uploadgame.errmsg202"/>' id="errmsg2"/>
<input type="hidden" value='<s:text name="global.uploadgame.errmsg203"/>' id="errmsg3"/>
<input type="hidden" value='<s:text name="global.uploadgame.errmsg204"/>' id="errmsg4"/>
<input type="hidden" value='<s:text name="global.uploadgame.errmsg205"/>' id="errmsg5"/>
<input type="hidden" value='<s:text name="global.uploadgame.errmsg206"/>' id="errmsg6"/>
<input type="hidden" value='<s:text name="global.uploadgame.errmsg207"/>' id="errmsg7"/>
<input type="hidden" value='<s:text name="global.uploadgame.errmsg208"/>' id="errmsg8"/>
<input type="hidden" value='<s:text name="global.uploadgame.errmsg209"/>' id="errmsg9"/>
<input type="hidden" value='<s:text name="global.uploadgame.errmsg210"/>' id="errmsg10"/>
<input type="hidden" value='<s:text name="global.uploadgame.errmsg211"/>' id="errmsg11"/>
<input type="hidden" value='<s:text name="global.uploadgame.errmsg212"/>' id="errmsg12"/>
<input type="hidden" value='<s:text name="global.uploadnewgame.Pleaseuploadvalidxmlfile"/>' id="errmsg1112"/>
<input type="hidden" value='<s:text name="global.uploadnewgame.GamealreadyexistsWillgeneratenewbatchnumber"/>' id="errmsgbatch"/>

	<div class="clear2"></div>
	
<h2><s:text name="global.home.uploadnewgameheader"/></h2>
<div class="FormSection">
		<div class="greyStrip">
			<h4><s:text name="global.searchuser.requiredinformation"/></h4>
		</div>
				<%-- <s:form
					action="/com/stpl/pms/action/bo/gl/st_game_upload_test_button_click.action"
					theme="simple" name="myForm" enctype="multipart/form-data">
	 --%>	<div class="innerBox">
			<div id="firstHide">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text name="global.searchgames.GameName"/></label> <em class="Req">*</em>
					</div>
					<div class="InputDivHalf">
						<ss:textfield id="gameName" theme="myTheme"
							applyscript="true" name="gameName" 
							 maxlength="25" value=""
							onkeyup="validGameName(this)"></ss:textfield>
						<span style="display:none;" class="tooltiptext" id="tooltp">Special Character are not allowed.</span>
					</div>
				</div>
				<div class="clearFRM"></div>


				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text name="global.searchgames.GameNo"/>.(<%=ServerStatusBean.getGAME_START_RANGE()%>-<%=ServerStatusBean.getGAME_END_RANGE() %>)</label> <em class="Req">*</em>
					</div>
					<div class="InputDivHalf">
					
						<ss:textfield id="gameNO" theme="myTheme"
							applyscript="true" name="gameNO"
							 value="" onkeyup="validGameNo(this)"
							maxlength="3" ></ss:textfield>
		<span style="display:none;" class="tooltiptext" id="batchToolTip">Game already exist, Will generate new batch.</span>
				
					</div>
				</div>
				
				
				
				<div class="clearFRM"></div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text name="global.searchgames.TicketCost"/> </label> <em class="Req">*</em>
					</div>
					<div class="InputDivHalf">
						<ss:textfield id="ticketPrize" theme="myTheme"
							applyscript="true"
							name="ticketPrize" value="" 
							onkeyup="validTicketPrize(this)" maxlength="10"></ss:textfield>
	<span style="display:none;" class="tooltiptext" id="tooltpTktPrc">Only Numeric and Decimal allowed.</span>
				
					</div>
				</div>
				<div class="clearFRM"></div>



				

				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text name="global.uploadnewgame.NoofTicketsPerBook"/> </label> <em class="Req">*</em>
					</div>
					<div class="InputDivHalf">
						<ss:textfield id="noOfTicketsPerBook" 
							name="noOfTicketsPerBook" value="" theme="myTheme"
							applyscript="true"
							 onkeyup="validTicketPerBook(this)" maxlength="5"
							></ss:textfield>
	<span style="display:none;" class="tooltiptext" id="tooltpNoOfTcktsPerBk">Alphabets and special characters are not allowed.</span>
				
					</div>
				</div>
				<div class="clearFRM"></div>


				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text name="global.uploadnewgame.NoofBooksPerPack"/> </label><em class="Req">*</em>
					</div>
					<div class="InputDivHalf">
						<ss:textfield id="noOfBooksPerPack" 
							name="noOfBooksPerPack" value="" theme="myTheme"
							applyscript="true"
							onkeyup="validTicketPerPack(this)" maxlength="5"
							></ss:textfield>
		<span style="display:none;" class="tooltiptext" id="tooltpNoOfBkPerPk">Alphabets and special characters are not allowed.</span>
	
					</div>
				</div>
				<div class="clearFRM"></div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> <s:text name="global.uploadnewgame.TotalNoofTickets"/></label> <em class="Req">*</em>
					</div>
					<div class="InputDivHalf">
						<ss:textfield id="noOfTickets" 
							name="noOfTickets" value="" theme="myTheme"
							applyscript="true"
							onkeyup="validNoOfTicket(this)" maxlength="10" 
							></ss:textfield>
					
					<span style="display:none;" class="tooltiptext" id="packCounting"></span>
							
					</div>
				</div>
				<div class="clearFRM"></div>
				
			</div>
			<div id="secondPart">

				<s:form enctype="multipart/form-data" id="xmlData" method="post"
					theme="simple">

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> <s:text name="global.uploadnewgame.TicketStructureXML"/> </label> <em class="Req">*</em>
						</div>
						<div class="InputDivHalf">
							<s:file  cssClass="textfield" theme="myTheme"
							applyscript="true"
								name="ticket_Str_Xml"
								onmouseout="validateFile(this,'ticket_Str_Xml')"
								id="ticket_Str_Xml"></s:file>
						</div>
						<div>
							<div id="tsDiv"></div>
						</div>
					</div>
					<div class="clearFRM"></div>

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> <s:text name="global.uploadnewgame.GameExplorerXML"></s:text> </label> <em class="Req">*</em>
						</div>
						<div class="InputDivHalf">
							<s:file   cssClass="textfield" theme="myTheme"
							applyscript="true"
								name="ge" onmouseout="validateFile(this,'ge')" id="ge"></s:file>
						</div>
						<div>
							<div id="geDiv"></div>
						</div>
					</div>
					<div class="clearFRM"></div>

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> <s:text name="global.uploadnewgame.PrizeDistributionXML"/> </label> <em class="Req">*</em>
						</div>
						<div class="InputDivHalf">
							<s:file  cssClass="textfield" theme="myTheme"
							applyscript="true"
								name="pd_Xml" onmouseout="validateFile(this,'pd_Xml')"
								id="pd_Xml"></s:file>
						</div>
						<div>
							<div id="pdDiv"></div>
						</div>
					</div>
					<div class="clearFRM"></div>


					<div class="FormMainBox">
						<div class="labelDiv">
							<label><s:text name="global.uploadnewgame.PrizeDistributionConstraintsXML"/> <em class="Req">*</em></label>
						</div>
						<div class="InputDivHalf">
							<s:file cssClass="textfield" theme="myTheme"
							applyscript="true"
								name="pdc_Xml" onmouseout="validateFile(this,'pdc_Xml')"
								id="pdc_Xml"></s:file>
						</div>
						<div>
							<div id="pdcDiv"></div>
						</div>
					</div>
					<div class="clearFRM"></div>

					<div class="FormMainBox">
						<div class="labelDiv">
							<label> <s:text name="global.uploadnewgame.AgentVerificationCodeXML"/> </label> <em class="Req">*</em>
						</div>
						<div class="InputDivHalf">
							<s:file  cssClass="textfield" theme="myTheme"
							applyscript="true"
								name="agtvc_Xml" onmouseout="validateFile(this,'agtvc_Xml')"
								id="agtvc_Xml"></s:file>
						</div>
						<div>
							<div id="avcDiv"></div>
						</div>
					</div>
					<div class="clearFRM"></div>


					<div class="FormMainBox">
						<div class="labelDiv">
							<label> <s:text name="global.uploadnewgame.LocationXML"/></label> <em class="Req">*</em>
						</div>
						<div class="InputDivHalf">
							<s:file  cssClass="textfield"
								name="location_Xml"
								onmouseout="validateFile(this,'location_Xml')" id="location_Xml"></s:file>
						</div>
						<div>
							<div id="locDiv"></div>
						</div>
					</div>
					<div class="clearFRM"></div>
					
					
					
					<% 
					if(ServerStatusBean.SERVER_TYPE.equals("P")){
						
						
						%>
						<div class="FormMainBox">
						<div class="labelDiv">
							<label><s:text name="global.uploadnewgame.imgfront"/></label> <em class="Req">*</em>
						</div>
						<div class="InputDivHalf">
							<s:file  cssClass="textfield"
								name="frontside_image_ticket"
								 id="frontside_image_ticket"></s:file>
						</div>
						<div>
							<div id="locDiv"></div>
						</div>
					</div>
					<div class="clearFRM"></div>
					
					<div class="FormMainBox">
						<div class="labelDiv">
							<label><s:text name="global.uploadnewgame.imgbck" /></label> <em class="Req">*</em>
						</div>
						<div class="InputDivHalf">
							<s:file  cssClass="textfield"
								name="backside_image_ticket"
								 id="backside_image_ticket"></s:file>
						</div>
						<div>
							<div id="locDiv"></div>
						</div>
					</div>
					<div class="clearFRM"></div>
					
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> <s:text name="global.uploadnewgame.imgscratched"/></label> <em class="Req">*</em>
						</div>
						<div class="InputDivHalf">
							<s:file  cssClass="textfield"
								name="scratched_image_ticket"
								 id="scratched_image_ticket"></s:file>
						</div>
						<div>
							<div id="locDiv"></div>
						</div>
					</div>
						
						<%
						
						
					}
						%>
					
					
					
					
					
				</s:form>
			</div>
		</div>
		<div class="box_footer" align="right">
			<%-- <s:submit id="upload" value="Upload" cssClass="button"></s:submit> --%>
			<input type="submit" class="button"
								value='<s:text name="global.uploadnewgame.upload" />' id="upload"/>
		</div>


				<%-- </s:form> --%>
		<div id="searchDiv"></div>

		

	</div>

</body>
</html>
