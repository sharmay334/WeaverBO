<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>Edit Role Privileges</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
 <script type = "text/javascript" 
         src = "https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/jquery-ui.min.js">
      </script>
      <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
      <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>

$(document).ready(function() {
	$("#completeUpload").click(function(event) {
			event.preventDefault();
			var formData = new FormData($("#xmlData")[0]);
			var type="draftsubmit";
		var gameName=document.getElementById('gameName').value;
		var gameNO=document.getElementById('gameNO').value;
		var ticketPrize=document.getElementById('ticketPrize').value;
		var noOfTickets=document.getElementById('noOfTickets').value;
		var noOfTicketsPerBook=document.getElementById('noOfTicketsPerBook').value;
		var noOfBooksPerPack=document.getElementById('noOfBooksPerPack').value;
		var virnDigits =document.getElementById('virnDigits').value;
		var ticket_Str_Xml=document.getElementById('ticket_Str_Xml').value;
		var ge=document.getElementById('ge').value;
		var pd_Xml=document.getElementById('pd_Xml').value;
		var pdc_Xml=document.getElementById('pdc_Xml').value;
		var agtvc_Xml=document.getElementById('agtvc_Xml').value;
		var location_Xml=document.getElementById('location_Xml').value;

		if(gameName==''){
			 $("#gameName").effect( "shake", {times:4}, 1000 );
				document.getElementById("gameName").style.borderColor = "red";
			}
		else if(gameNO=='' || gameNO==0){
			 $("#gameNO").effect( "shake", {times:4}, 1000 );
				document.getElementById("gameNO").style.borderColor = "red";
			}
		else if(ticketPrize==''){
			 $("#ticketPrize").effect( "shake", {times:4}, 1000 );
				document.getElementById("ticketPrize").style.borderColor = "red";
			}
		else if(noOfTickets==''){
			 $("#noOfTickets").effect( "shake", {times:4}, 1000 );
				document.getElementById("noOfTickets").style.borderColor = "red";
			}
		else if(noOfTicketsPerBook==''){
			 $("#noOfTicketsPerBook").effect( "shake", {times:4}, 1000 );
				document.getElementById("noOfTicketsPerBook").style.borderColor = "red";
			}
		else if(noOfBooksPerPack==''){
			 $("#noOfBooksPerPack").effect( "shake", {times:4}, 1000 );
				document.getElementById("noOfBooksPerPack").style.borderColor = "red";
			}
		else if(virnDigits==''){
			 $("#virnDigits").effect( "shake", {times:4}, 1000 );
				document.getElementById("virnDigits").style.borderColor = "red";
			}
		else if(ticket_Str_Xml==''){
			 $("#ticket_Str_Xml").effect( "shake", {times:4}, 1000 );
				document.getElementById("ticket_Str_Xml").style.borderColor = "red";
			}
		else if(pd_Xml==''){
			 $("#pd_Xml").effect( "shake", {times:4}, 1000 );
				document.getElementById("pd_Xml").style.borderColor = "red";
			}
		else if(pdc_Xml==''){
			 $("#pdc_Xml").effect( "shake", {times:4}, 1000 );
				document.getElementById("pdc_Xml").style.borderColor = "red";
			}
		if(agtvc_Xml==''){
			 $("#agtvc_Xml").effect( "shake", {times:4}, 1000 );
				document.getElementById("agtvc_Xml").style.borderColor = "red";
			}
		else if(location_Xml==''){
			 $("#location_Xml").effect( "shake", {times:4}, 1000 );
				document.getElementById("location_Xml").style.borderColor = "red";
			}
		else if(ge==''){
			 $("#ge").effect( "shake", {times:4}, 1000 );
				document.getElementById("ge").style.borderColor = "red";
			}
		else
			{
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
						+ virnDigits
						+ "&saveMode=" 
						+ type,
				success : function(itr) {
					if(itr=="SUCCESS")
						{
						swal({
							  title: "Success!",
							  text: "Your data has been uploaded successfully!",
							  icon: "success",
							  button: "OK!",
							});
					
						}
					else
						{
						swal({
							  title: "Error!",
							  text: "Data already exists!",
							  icon: "warning",
							  button: "OK!",
							});
						}
				},
				error : function(itr) {
					swal({
						  title: "Error!",
						  text: "Some internal error. Please try again later!",
						  icon: "warning",
						  button: "OK!",
						});
				}
			});

			
			}
		
	});

});


function validGameName(GameName) {
	var gameName = GameName.value;
		var pattern = /^[0-9 a-z A-Z]+$/;
	if (gameName.length > 3 && gameName.length < 25 )
	
		document.getElementById("gameName").style.borderColor = "green";
	if(gameName.match(pattern))
		{
		
		document.getElementById("gameName").style.borderColor = "green";
		}
	else {
		$('#tooltp').show();
		   setTimeout(function() { 
		       $('#tooltp').fadeOut(); 
		   }, 800);
		var newString=gameName.replace(/[^a-zA-Z0-9 ]/g, "");
		document.getElementById("gameName").value=newString;
		document.getElementById("gameName").style.borderColor = "red";

	}

}

function validGameNo(GameNo) {
	
	var gameNo = GameNo.value;
	var pattern = /^[0-9]+$/;
	if (gameNo.length > 0 && gameNo.length < 4)
		document.getElementById("gameNO").style.borderColor = "green";
 		if(gameNo.match(pattern))
			{
		document.getElementById("gameNO").style.borderColor = "green";
			}
	else {
		$('#tooltpGameNo').show();
		   setTimeout(function() { 
		       $('#tooltpGameNo').fadeOut(); 
		   }, 800);
		
		var newString=gameNo.replace(/[^0-9]/g,"");
		document.getElementById("gameNO").value =newString;
		document.getElementById("gameNO").style.borderColor = "red";

	}

}

function validTicketPrize(TicketPrize) {
	var ticketPrize = TicketPrize.value;
	var pattern = /^[0-9]+\.?[0-9]*$/;
	if (ticketPrize.length > 0 && ticketPrize.length < 11)
		document.getElementById("ticketPrize").style.borderColor = "green";
		if(ticketPrize.match(pattern))
			{
			document.getElementById("ticketPrize").style.borderColor = "green";		
			}
	else {
		$('#tooltpTktPrc').show();
		   setTimeout(function() { 
		       $('#tooltpTktPrc').fadeOut(); 
		   }, 800);
		
		var newString=ticketPrize.replace(/[^0-9.]/g,"");
		document.getElementById("ticketPrize").value =newString;
		document.getElementById("ticketPrize").style.borderColor = "red";
	}

}
function validNoOfTicket(NoOfTicket) {
	
	var noOfticket = NoOfTicket.value;
		var pattern = /^[0-9]+$/;
	if (noOfticket.length > 0 && noOfticket.length < 11)
		document.getElementById("noOfTickets").style.borderColor = "green";
		if(noOfticket.match(pattern))
			{
			document.getElementById("noOfTickets").style.borderColor = "green";
			}
	else {
		$('#tooltpTotlNoOfTckts').show();
		   setTimeout(function() { 
		       $('#tooltpTotlNoOfTckts').fadeOut(); 
		   }, 800);
		
		var newString=noOfticket.replace(/[^0-9]/g,"");
		document.getElementById("noOfTickets").value =newString;
		document.getElementById("noOfTickets").style.borderColor = "red";

	}

}

function validTicketPerBook(NoOfTicket) {
	var noOfTicketperbook = NoOfTicket.value;
		var pattern = /^[0-9]+$/;
	if (noOfTicketperbook.length > 0 && noOfTicketperbook.length < 6)
		document.getElementById("noOfTicketsPerBook").style.borderColor = "green";
		if(noOfTicketperbook.match(pattern))
			{
			document.getElementById("noOfTicketsPerBook").style.borderColor = "green";
			}
	else {
		$('#tooltpNoOfTcktsPerBk').show();
		   setTimeout(function() { 
		       $('#tooltpNoOfTcktsPerBk').fadeOut(); 
		   }, 800);
		
		var newString=noOfTicketperbook.replace(/[^0-9]/g,"");
		document.getElementById("noOfTicketsPerBook").value= newString;
		document.getElementById("noOfTicketsPerBook").style.borderColor = "red";

	}
}

function validTicketPerPack(NoOfTicket) {

	var noOfBook = NoOfTicket.value;
		var pattern = /^[0-9]+$/;
	if (noOfBook.length > 0 && noOfBook.length < 6)
		document.getElementById("noOfBooksPerPack").style.borderColor = "green";
		if(noOfBook.match(pattern))
			{
			document.getElementById("noOfBooksPerPack").style.borderColor = "green";
			}
	else {
		$('#tooltpNoOfBkPerPk').show();
		   setTimeout(function() { 
		       $('#tooltpNoOfBkPerPk').fadeOut(); 
		   }, 800);
		
		var newString=noOfBook.replace(/[^0-9]/g,"");
		document.getElementById("noOfBooksPerPack").value =newString;
		document.getElementById("noOfBooksPerPack").style.borderColor = "red";

	}

}

function validCheckVirn(virnNo)

{
	var VirnNo = virnNo.value;
		var pattern = /^[0-9]+$/;
	if (VirnNo.length > 0 && VirnNo.length < 11)
		document.getElementById("virnDigits").style.borderColor = "green";
		if(VirnNo.match(pattern))
			{
			document.getElementById("virnDigits").style.borderColor = "green";
		
					}
	else {
		$('#tooltpVirn').show();
		   setTimeout(function() { 
		       $('#tooltpVirn').fadeOut(); 
		   }, 800);
		
		var newString=VirnNo.replace(/[^0-9]/g,"");
		document.getElementById("virnDigits").value =newString;
		document.getElementById("virnDigits").style.borderColor = "red";

	}

}

function validateFile(fileName, id) {
	var file = fileName.value;
	var ext = file.substring(file.length, file.length - 3);
	if (file != "") {
		if (ext != "xml") {
			document.getElementById(id).value = "";
			alert("Please upload valid xml file!!!")
		}
	}
}
</script>
</head>
<body>


	<!--form section first start-->
	<div class="innerBox">
	<s:iterator value="draftdata" var="obj">
		
		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Game Name</label> <em class="Req">*</em>
			</div>
			<div class="InputDivHalf">
				<s:textfield id="gameName" theme="myTheme" onkeyup="validGameName(this)"
					name="gameName" maxlength="25" value="%{#obj.game_Name}" />
				<span style="display: none;" class="tooltiptext" id="tooltp">Special
					Character are not allowed.</span>
			</div>
		</div>
		<div class="clearFRM"></div>


		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Game No.</label> <em class="Req">*</em>
			</div>
			<div class="InputDivHalf">
				<s:textfield id="gameNO" theme="myTheme" onkeyup="validGameNo(this)"
					name="gameNO" maxlength="3" value="%{#obj.game_No}" />
				<span style="display: none;" class="tooltiptext" id="tooltpGameNo">Alphabets
					and special characters are not allowed.</span>

			</div>
		</div>
		<div class="clearFRM"></div>


		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Ticket Prize </label>
			</div>
			<div class="InputDivHalf">
				<ss:textfield id="ticketPrize" theme="myTheme" onkeyup="validTicketPrize(this)"
					name="ticketPrize" value="%{#obj.price}" maxlength="10"></ss:textfield>
				<span style="display: none;" class="tooltiptext" id="tooltpTktPrc">Only
					Numeric and Decimal allowed.</span>

			</div>
		</div>
		<div class="clearFRM"></div>



		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Total No. of Tickets</label>
			</div>
			<div class="InputDivHalf">
				<ss:textfield id="noOfTickets" name="noOfTickets" value="%{#obj.no_Of_Tickets}"
					theme="myTheme" onkeyup="validNoOfTicket(this)" maxlength="10"></ss:textfield>
				<span style="display: none;" class="tooltiptext"
					id="tooltpTotlNoOfTckts">Alphabets and special characters
					are not allowed.</span>

			</div>
		</div>
		<div class="clearFRM"></div>

		<div class="FormMainBox">
			<div class="labelDiv">
				<label> No. of Tickets Per Book </label>
			</div>
			<div class="InputDivHalf">
				<ss:textfield id="noOfTicketsPerBook" name="noOfTicketsPerBook"
					 value="%{#obj.no_Of_Tickets_Per_Book}" theme="myTheme"  onkeyup="validTicketPerBook(this)"  maxlength="5"></ss:textfield>
				<span style="display: none;" class="tooltiptext"
					id="tooltpNoOfTcktsPerBk">Alphabets and special characters
					are not allowed.</span>

			</div>
		</div>
		<div class="clearFRM"></div>


		<div class="FormMainBox">
			<div class="labelDiv">
				<label> No. of Books Per Pack </label>
			</div>
			<div class="InputDivHalf">
				<ss:textfield id="noOfBooksPerPack"  name="noOfBooksPerPack" value="%{#obj.no_Of_Books_Per_Pack}"
					theme="myTheme" onkeyup="validTicketPerPack(this)" maxlength="5"></ss:textfield>
				<span style="display: none;" class="tooltiptext"
					id="tooltpNoOfBkPerPk">Alphabets and special characters are
					not allowed.</span>

			</div>
		</div>
		<div class="clearFRM"></div>


		<div class="FormMainBox">
			<div class="labelDiv">
				<label> No. of Digits in VIRN </label>
			</div>
			<div class="InputDivHalf">
				<ss:textfield id="virnDigits" theme="myTheme" onkeyup="validCheckVirn(this)"
				 value="%{#obj.virn_Digits}" name="virnDigits" maxlength="10"></ss:textfield>
				<span style="display: none;" class="tooltiptext" id="tooltpVirn">Alphabets
					and special characters are not allowed.</span>

			</div>
		</div>
		<div class="clearFRM"></div>

			<s:form enctype="multipart/form-data" id="xmlData" method="post"
					theme="simple">


		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Ticket Structure XML </label> <em class="Req">*</em>
			</div>
			<div class="InputDivHalf">
				<s:file cssClass="textfield" theme="myTheme" onmouseout="validateFile(this,'ticket_Str_Xml')"
					name="ticket_Str_Xml" id="ticket_Str_Xml"></s:file>
			</div>
			<div>
				<div id="tsDiv"></div>
			</div>
		</div>
		<div class="clearFRM"></div>

		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Game Explorer XML </label> <em class="Req">*</em>
			</div>
			<div class="InputDivHalf">
				<s:file cssClass="textfield"  theme="myTheme"  onmouseout="validateFile(this,'ge')"
					name="ge" id="ge"></s:file>
			</div>
			<div>
				<div id="geDiv"></div>
			</div>
		</div>
		<div class="clearFRM"></div>

		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Prize Distribution XML</label> <em class="Req">*</em>
			</div>
			<div class="InputDivHalf">
				<s:file cssClass="textfield"  theme="myTheme"  onmouseout="validateFile(this,'pd_Xml')"
					name="pd_Xml" id="pd_Xml"></s:file>
			</div>
			<div>
				<div id="pdDiv"></div>
			</div>
		</div>
		<div class="clearFRM"></div>


		<div class="FormMainBox">
			<div class="labelDiv">
				<label>Prize Distribution Constraints XML <em class="Req">*</em></label>
			</div>
			<div class="InputDivHalf">
				<s:file cssClass="textfield" theme="myTheme" onmouseout="validateFile(this,'pdc_Xml')"
					name="pdc_Xml" id="pdc_Xml"></s:file>
			</div>
			<div>
				<div id="pdcDiv"></div>
			</div>
		</div>
		<div class="clearFRM"></div>

		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Agent Verification Code XML </label> <em class="Req">*</em>
			</div>
			<div class="InputDivHalf">
				<s:file cssClass="textfield" theme="myTheme" onmouseout="validateFile(this,'agtvc_Xml')"
					name="agtvc_Xml" id="agtvc_Xml"></s:file>
			</div>
			<div>
				<div id="avcDiv"></div>
			</div>
		</div>
		<div class="clearFRM"></div>


		<div class="FormMainBox">
			<div class="labelDiv">
				<label> Location XML</label> <em class="Req">*</em>
			</div>
			<div class="InputDivHalf">
				<s:file cssClass="textfield" name="location_Xml" onmouseout="validateFile(this,'location_Xml')" id="location_Xml"></s:file>
			</div>
			<div>
			</div>
			
		</div>
		</s:form>
</s:iterator>

	<div class="box_footer" align="right">
			<s:submit id="completeUpload" value="Upload"></s:submit>
			

		</div>
	</div>

</body>
</html>