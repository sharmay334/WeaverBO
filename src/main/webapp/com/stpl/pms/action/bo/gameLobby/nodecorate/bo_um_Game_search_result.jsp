<%@page import="com.stpl.pms.constants.ServerStatusBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="com.stpl.pms.*" %>
<%
String path = request.getContextPath();
System.out.println("server path  === == = == == "+path);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="sweetalert.css" type="text/css" rel="stylesheet">
<%-- <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.0/sweetalert.min.js"></script> --%>

	<script src="/WeaverBO/js/jQuery/sweetalert2/sweetalert2.js"></script>
	 <link rel="stylesheet" href="/WeaverBO/js/jQuery/sweetalert2/sweetalert2.css">
<script>
	var dataTable= $('#subReportTable').DataTable();
	$('#downlaod_data').hide();
	$('#note').hide();
	$('#downlaod_data_testFiles').hide();
	
function deleteGame(gameNO,batch_No,row_id)
{


		swal({
			  title: "Are you sure?",
		  text: "Once deleted, you will not be able to recover this data!",
			  icon: "/WeaverBO/images/info.png",
			  buttons: true,
			  dangerMode: true,
			}).then((willDelete) =>{
			  if (willDelete) {
				  $.ajax({
						type : "GET",
						url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_delete_game.action?gameNO="
							+gameNO+"&batchNo="+batch_No,
						success : function(itr) {
					
							if(itr=="DELETED"){
								
								 swal("Poof! Data deleted successfully! ", {
								      icon: "success",
								    });
								 dataTable.$('#'+row_id).addClass('selected');
								 dataTable.row('.selected').remove().draw( false );
								}
							else
								{

								 swal("Poof! Data not deleted. Please try again! ", {
								      icon: "warning",
								    });
								}
							
							},
				 
						error : function(itr) {
							 swal("Poof! Data not deleted. Some error occured!!! ", {
							      icon: "warning",
							    });
						}
					});
				  
				
			  } else {
			    swal("Your record is safe!");
			  }
			});
	}
	
	function showImage(gameNo,batchNo)
	{
		$.ajax({
			type : "GET",
			url : "/WeaverBO/com/stpl/pms/action/bo/gl/game_search_show_tkt_img.action?gameNo="+gameNo+"&batchNo="+batchNo,
			success : function(itr) {
				var frontImg = "/WeaverBO/images/frontImg_"+gameNo+"_"+batchNo+".png";
				var backImg = "/WeaverBO/images/backImg_"+gameNo+"_"+batchNo+".png";
				var scratchImg = "/WeaverBO/images/scratchedImg_"+gameNo+"_"+batchNo+".png";
				
				var url = [frontImg,backImg,scratchImg];
				var html = "";	
				for(var i=0;i<3;i++){
						
						html += '<img style="padding:10px;" src="'+url[i]+'">';
					}
					
					show();
					$('.popup-container .popup-content').html(html);
				 	
			},
			error : function(itr) {
					

					}
		});
		
		
	}

function downloadGame(noOfTickets,gameNo,gameNme,tcktPerBook,tcktPerPack,batch_no,ticket_status)
{
	
	
	var msgdownload = document.getElementById("msgdownload").value;
	var msgwait = document.getElementById("msgwait").value;
	var msgselect = document.getElementById("msgselect").value;
	var err101 = document.getElementById("err101").value;
	var errmsg102 = document.getElementById("err102").value;
	var msgpopup  =document.getElementById("msgpopup").value; 
	
	var err103 = document.getElementById('err103').value;
	var err104 = document.getElementById('err104').value;
	var err105 = document.getElementById('err105').value;
	var err106 = document.getElementById('err106').value;
	var err107 = document.getElementById('err107').value;
	var err108 = document.getElementById('err108').value;
	
	if(ticket_status!="Initiated")
		{
	var selectBoxData={};
	if (noOfTickets <= 1000) {
		selectBoxData["1"]=noOfTickets;
	} else if (noOfTickets <= 5000) {
		selectBoxData["1"]=1000;
		selectBoxData["2"]=noOfTickets;
		
	} else if (noOfTickets <= 10000) {
		selectBoxData["1"]=1000;
		selectBoxData["2"]=5000;
		selectBoxData["3"]=noOfTickets;
	} else if (noOfTickets <= 50000) {
		selectBoxData["1"]=5000;
		selectBoxData["2"]=10000;
		selectBoxData["3"]=noOfTickets;
		
	} else if (noOfTickets <= 100000) {
		selectBoxData["1"]=10000;
		selectBoxData["2"]=25000;
		selectBoxData["3"]=noOfTickets;
		
	} else if (noOfTickets > 100000) {
		selectBoxData["1"]=10000;
		selectBoxData["2"]=25000;
		selectBoxData["3"]=50000;
		selectBoxData["4"]=noOfTickets;
	}

	swal({
		  title: msgpopup,
		  icon: "/WeaverBO/images/download.png",
		  input: 'select',
		  inputOptions: selectBoxData,
		  inputPlaceholder: msgselect,
		  showCancelButton: true,
		  inputValidator: function (value) {
		    return new Promise(function (resolve, reject) {
		      if (value !== '') {
		        resolve();
		      } else {
		        reject(err101);
		      }
		    });
		  }
		}).then(function (result) {
			
				swal({
  title: msgdownload,
  text: msgwait,
  imageUrl: '/WeaverBO/images/1.gif',
  closeOnClickOutside:false,
  showConfirmButton: false,
})
		    $.ajax({
				type : "GET",
				url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_download_game.action?noOfTickets="
						+noOfTickets+"&gameName="+gameNme+"&gameNO="+gameNo+"&no_Of_Tickets_Per_Book="+tcktPerBook+"&no_Of_Books_Per_Pack="+tcktPerPack+"&noOfticketsInFile="+selectBoxData[result]+"&batchNo="+batch_no,
				success : function(itr) {
					
					swal(
							  err103,
							  err104,
							  'success'
							)
						$.ajax({
		type : "GET",
		url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_testfile_download_result.action",
		success : function(itr) {
			$('#downlaod_data_testFiles').show();
			$('#note').show();
			$('#DownloadTestFilesList').html(itr);
    /// mail service when downlaod success 
					$.ajax({
						type : "GET",
						url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_global_bo_mail_send_activity.action?emailType=DOWNLOAD_TEST_READY_EMAIL_USER&gameNo="+gameNo+"&batchNo="+batch_no+"&mailMsg='downloaded'",
						success : function(itr) {
							 		
						},
						error : function(itr) {
								

								}
					});	
    					
					$.ajax({
						type : "GET",
						url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_global_bo_mail_send_activity.action?emailType=DOWNLOAD_TICKET_SUPPORT&gameNo="+gameNo+"&batchNo="+batch_no+"&mailMsg='support'",
						success : function(itr) {
							 		
						},
						error : function(itr) {
								

								}
					});	
						
							$.ajax({
						type : "GET",
						url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_global_bo_mail_send_activity.action?emailType=DOWNLOAD_TEST_READY_EMAIL_BO&gameNo="+gameNo+"&batchNo="+batch_no+"&mailMsg='downloaded'",
						success : function(itr) {
							 		
						},
						error : function(itr) {
								

								}
					});	
													$.ajax({
														type : "GET",
														url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_global_bo_sms_send_activity.action?smsType=DOWNLOADING_TICKETS&gameNo="+gameNo+"&batchNo="+batch_no,
														success : function(itr) {
															 		
														},
														error : function(itr) {

																}
													});	
											$.ajax({
														type : "GET",
														url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_global_bo_sms_send_activity_to_bo.action?smsType=BO_DOWNLOAD_TICKET&gameNo="+gameNo+"&batchNo="+batch_no,
														success : function(itr) {
															 		
														},
														error : function(itr) {
																

																}
													});		
				
			//end of mail service
		},
		error : function(itr) {
			$('#downlaod_data_testFiles').hide();
			$('#note').hide();
		}
	});	
					$('#downlaod_data').show();
					$('#note').show();
					$('#DownloadFilesList').html(itr);
						
					},
		 
				error : function(itr) {
					$('#downlaod_data').hide();
					$('#note').hide();
					swal(
							  err106,
							  err107,
							  'error'
							)
				}
			});
		});


	
		
	
		}
	else
		{
		swal(errmsg102)
		}
	}
</script>
<link rel="stylesheet" href="/WeaverBO/css/custom.css">
</head>

<body>
	<input type="hidden" value='<s:text name="global.Downloadmsg" />' id="msgdownload"/>
	<input type="hidden" value='<s:text name="global.waitmsg" />' id="msgwait"/>
	<input type="hidden" value='<s:text name="global.SELECTHEADER" />' id="msgselect"/>
	<input type="hidden" value='<s:text name="global.itgs.101" />' id="err101"/>
	<input type="hidden" value='<s:text name="global.itgs.102" />' id="err102"/>
	<input type="hidden" value='<s:text name="global.itgs.103" />' id="err103"/>
	<input type="hidden" value='<s:text name="global.itgs.104" />' id="err104"/>
	<input type="hidden" value='<s:text name="global.itgs.105" />' id="err105"/>
	<input type="hidden" value='<s:text name="global.itgs.106" />' id="err106"/>
	<input type="hidden" value='<s:text name="global.itgs.107" />' id="err107"/>
	<input type="hidden" value='<s:text name="global.itgs.108" />' id="err108"/>
	<input type="hidden" value='<s:text name="global.download.msgpopup" />' id="msgpopup"/>
	
	
	
	
	<div class="FormSection">
		<s:if test="%{getGameSearchData.size()>0}">
			<div class="greyStrip">
				<h4 style="float: left"><s:text name="global.searchgames.GameSearchReport" /></h4>
			</div>
			<div class="innerBox">
				<table cellspacing="0" cellpadding="4" border="0" align="center"
					class="payTransaction" id="subReportTable">
					<thead>
						<tr>
							<th valign="middle" style="text-align: center;"><s:text name="global.searchgames.sno"/></th>
							<th valign="middle" style="text-align: center;"><s:text name="global.searchgames.GameName"/></th>
							<th valign="middle" style="text-align: center;"><s:text name="global.searchgames.GameNo"/></th>
							<th valign="middle" style="text-align: center;"><s:text name="global.searchgames.batchNo" /></th>
							<th valign="middle" style="text-align: center;"><s:text name="global.searchgames.tickettype" /></th>
							<th valign="middle" style="text-align: center;"><s:text name="global.searchgames.TicketCost"/></th>
							<th valign="middle" style="text-align: center;"><s:text name="global.searchgames.nooftickets" /></th>
							<th valign="middle" style="text-align: center;"><s:text name="global.searchgames.status" /></th>
							<th valign="middle" style="text-align: center;"><s:text name="global.searchgames.testreadydata"/></th>


						</tr>
					</thead>
					<tbody>
						<s:iterator value="%{getGameSearchData}" status="txnList"
							var="obj">

							<tr id="<s:property  value="%{#txnList.index+1}" />">
								<td width="2%" valign="middle" style="text-align: center;"><s:property
										value="%{#txnList.index+1}" /></td>
								<td width="4%" valign="middle" style="text-align:center;">
								
								<% 
								if(ServerStatusBean.SERVER_TYPE.equals("P")){
								%>
									<a href="#" onclick="showImage('<s:property value="#obj.game_No"/>','<s:property
								value="batch_no" />')">
								<s:property
										value="game_Name" /> <input type="hidden" id="gameNm"
									value="<s:property value="game_Name"/>" /> </a>
									<%
								}
								else{
								%>
								<s:property
										value="game_Name" /> <input type="hidden" id="gameNm"
									value="<s:property value="game_Name"/>" />
									<% }
									%>
									
									</td>
								<td width="4%" valign="middle" style="text-align: center;"><s:property
										value="game_No" /> <input type="hidden" id="gameNo"
									value="<s:property value="game_No"/>" /></td>
								<td width="3%" valign="middle" style="text-align: center;"><s:property
										value="batch_no" /></td>
								<td width="4%" valign="middle" style="text-align: center;"><s:text name="global.searchgames.printed"/>
									<input type="hidden" id="myid"
									value="<s:property  value="%{#txnList.index+1}" />" />
								</td>
								<td width="3%" valign="middle" style="text-align: center;"><s:property
										value="price" /></td>
								<td width="4%" valign="middle" style="text-align: center;"><s:property
										value="no_Of_Tickets" /></td>
								<td width="4%" valign="middle" style="text-align: center;"><s:property
										value="status" /></td>
									<s:set name="check" value="status"/>
									<s:if test="%{#check=='Generated'}">
									<td width="4%" valign="middle" style="text-align: center;">
									<a href="#"
									onclick="downloadGame('<s:property value="#obj.no_Of_Tickets"/>','<s:property value="#obj.game_No"/>','<s:property
										value="game_Name" />','<s:property value="#obj.no_Of_Tickets_Per_Book"/>','<s:property value="#obj.no_Of_Books_Per_Pack"/>','<s:property
										value="batch_no" />','<s:property value="status" />')"
									id="downloadGame"><s:text name="global.searchgames.download"/></a>
									</td>
									</s:if>	
									<s:elseif test="%{#check=='Downloaded'}">
   											<td width="4%" valign="middle" style="text-align: center;">
									<a href="#" onclick="downloadGame('<s:property value="#obj.no_Of_Tickets"/>','<s:property value="#obj.game_No"/>','<s:property
										value="game_Name" />','<s:property value="#obj.no_Of_Tickets_Per_Book"/>','<s:property value="#obj.no_Of_Books_Per_Pack"/>','<s:property
										value="batch_no" />','<s:property value="status" />')"
									id="downloadGame"><s:text name="global.searchgames.download"/></a>
									</td>
									</s:elseif>
								<s:else>
    								<td width="4%" valign="middle" style="text-align: center;">
									<a href="#" id="downloadGame"></a>
									</td>
								</s:else>

								

							</tr>
						</s:iterator>
					</tbody>
				</table>
			</div>


			<div class="box_footer"></div>
		</s:if>
		<s:else>
			<div class="greyStrip">
				<h4><s:text name="global.searchgameresult.errMsg"/></h4>
			</div>
			<div class="innerBox">
				<div class="alert info_msg ">
					<span class="alert_close"></span><strong><s:text name="global.searchgame.msg"/>: </strong><s:text name="global.searchgame.msg.norecord"/>
				</div>
			</div>
		</s:else>
	</div>
	<div class="FormSection"  id="note">
		<div class="greyStrip">
			<h4 style="float: left"><strong><s:text name="global.searchgames.note"/>:</strong> <s:text name="global.searchgames.noteMsg" />. </h4>
		</div>
		
	</div>
	<br/><br/>
	<div class="FormSection" id="downlaod_data">
		<div class="greyStrip">
			<h4 style="float: left"><s:text name="global.searchgames.TestReadyTicketData"/></h4>
		</div>
		<div class="innerBox">
			<div class="innerBox" id="DownloadFilesList"></div>
		</div>
	</div>
	<br />
	<div class="FormSection" id="downlaod_data_testFiles">
		<div class="greyStrip">
			<h4 style="float: left"><s:text name="global.searchgames.TestReports"/></h4>
		</div>
		<div class="innerBox">
			<div class="innerBox" id="DownloadTestFilesList"></div>
		</div>
	</div>
	
	
	
<style>
.popup-ovelay{
	position:fixed;
	top:0px;
	left:0px;
	width:100%;
	bottom:0px;
	display:none;
	background-color: #0009;
	
}

.popup-container{
	position:fixed;
	top:50%;
	left:50%;
	transform: translate(-50%,-50%);
	display:inline-block;
	display:none;
}

.popup-content{
	padding:10px;
	background-color:#fff;
	
}
</style>
<div class="popup-ovelay"></div>
<div class="popup-container">
	<div class="popup-content">
		
	</div>
</div>
<script>
function show(){
	$('.popup-ovelay').show();
	$('.popup-container').show();
}

function hide(){
	$('.popup-ovelay').hide();
	$('.popup-container').hide();
}
$(document).on('click','.popup-ovelay',function(){
	hide();
});

</script>
</body>
</html>