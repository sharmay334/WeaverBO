<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
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

<title>Report
</title>

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
	
</head>
<script>
function scheduleResult(){
	var frm = $('#searchUserFrm');
	var ledgerId = document.getElementById('ledgerName').value;
	var selected = [];
	  for (var option of document.getElementById('billList').options) {
	    if (option.selected) {
	      selected.push(option.value);
	    }
	  }
	  var myurl = "<%=basePath%>";
		myurl += "/com/stpl/pms/action/bo/um/bo_um_scheduleOldOverDueInterest.action?ledgerName="+ledgerId+"&voucherNo="+selected;
		
	  swal({
		  title: "Are you sure?",
		  text: "Once Saved, you will not be able to undo the entry!",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
					  if (willDelete) {
						  $.ajax({
						        type: frm.attr('method'),
						        url: myurl,
						        async:false,
						        success: function (data) {
						        	if(data=="success"){
						        		swal("Scheduling Successfully Done..Refreshing the page!!!");
						        		
						        		setTimeout(function(){
						        			   window.location.reload(1);
						        			}, 1000);
						        		
						        	}
						        	else{
						        		swal("Error Occured in calculation!");
						        	}
						            
						        },
						        error: function (data) {
						        	swal("Server Error Occured!");
						        },
						    });
						  
					  } else {
					    swal("Please Refresh The Page!");
					   
					  }
					});
	
}
function showBills(val){
	var myurl = "<%=basePath%>";
	 myurl += "/com/stpl/pms/action/bo/um/bo_um_tm_get_OverDueListBills.action?ledgerName="
			+ val;
	$.ajax({
		type : "GET",
		url : myurl,
		success : function(itr) {
			if(itr.includes("error")){
				var myoption;
				myoption+="<option value='-1'> No Bills </option>";
				document.getElementById("billList").innerHTML = myoption;
			}else{
				var arr = itr.split(";");
				var myoption="<option value='-1'>Please Select</option>";
				for(var i=0;i<arr.length;i++){
					if(arr[i]!="")
					myoption+="<option>" +arr[i] + "</option>";
				}
				document.getElementById("billList").innerHTML = myoption;
			}
			
		},

		error : function(itr) {

		}
	});
}
</script>
<body>
	<div class="FormSection">

		<div class="greyStrip">
			<h4>
				Schedule Old Due Bills Interest 
			</h4>
		</div>
		<s:form id="searchUserFrm" action="/com/stpl/pms/action/bo/um/bo_um_scheduleOldOverDueInterest.action"
			 target="searchResult" theme="simple">

			<div class="innerBox">
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Select Party </label>
					</div>
					<div class="InputDiv">
						<div>
							<s:select theme="myTheme" cssClass="select1"
								list="%{ledgerNames}" name="ledgerName" id="ledgerName" headerKey="-1"
								headerValue="--Please Select--" onchange="showBills(this.value)"></s:select>

						</div>
					</div>
				</div>
				
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Choose Bill </label>
					</div>
					<div class="InputDiv">
						<div>
						
							<select	multiple="multiple" name="billId" class="multipleSelect" id="billList">
										
						  </select>
						</div>
					</div>
				</div>
				
				
				
			</div>
			<div class="box_footer" align="right">
		<button type="button" id="saleBtn" align="left" style="margin-left: 0px" class="button" onclick="scheduleResult()">Calculate</button>
					
			</div>
		</s:form>
	</div>
	<div id="searchResult"></div>
</body>
</html>
