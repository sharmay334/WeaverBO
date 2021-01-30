<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Party Status</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link href="css/facebox.css" media="screen" rel="stylesheet" type="text/css"/>
<script src="js/facebox.js" type="text/javascript"></script>
<script src="/WeaverBO/js/sweetalert.min.js"></script>
<script type="text/javascript"
	src="/WeaverBO/js/jQuery/1.11.3/jquery-ui.min.js">
      </script>
<link rel="stylesheet" href="/WeaverBO/js/jQuery/1.11.3/jquery-ui.css">

<SCRIPT type="text/javascript" src="<%=path %>/com/stpl/pms/action/bo/cms/js/cms.js"></SCRIPT>
	<SCRIPT type="text/javascript">
	function bo_um_validatePartyStatus(partyName){
		var frm = $('#pomFrm');
		if(partyName!="-1"){
			 $.ajax({
			        type: "GET",
			        url: '/WeaverBO/com/stpl/pms/action/bo/misc/bo_um_validatePartyStatus.action?partyName='+partyName,
			        success: function (data) {
			        	if(data=="Blocked"){
			        		document.getElementById('partyName_error').innerHTML = "Party is blocked";
			        	}
			        	else{
			        		document.getElementById('partyName_error').innerHTML = "<font color='green'>Party is not blocked</font>";
			        	}
			        },
			        error: function (data) {
			        	swal("Server Error Occured!");
			        },
			    });
			
			
		}
	}
	function changeStatus(){
		
		var frm = $('#pomFrm');
			 $.ajax({
			        type: "POST",
			        url: '/WeaverBO/com/stpl/pms/action/bo/misc/bo_um_validatePartyblockUnblock.action',
			        data: frm.serialize(),
			        success: function (data) {
			        	if(data=="blocked"){
			        		swal("This party is blocked successfully!");
			        	}
			        	else if(data=="unblocked"){
			        		swal("This order is unblocked successfully!");
			        	}
			        	else{
			        		swal("Some error occured!");
			        	}
			        },
			        error: function (data) {
			        	swal("Server Error Occured!");
			        },
			    });
	}
	$(document).ready(function() {
	 $('a[rel*="facebox"]').facebox({
			closeImage : '<%=request.getContextPath()%>/images/closelabel.png',
  	 		});
	});
	</SCRIPT>
	
  </head>
  
   <body>
	<div id="container">
			<h2>
				Party Block - Unblock 

			</h2>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Party Block - Unblock
					</h4>
				</div>
				<s:form theme="simple" id="pomFrm" method="POST" action="bo_um_validatePartyblockUnblock">
					 
					<div class="innerBox">


						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Party Name:
								</label>
							</div>
							<div class="InputDiv">
								<s:select theme="myTheme" cssClass="select1"
									list="%{partyList}"
									name="partyName" id="partyName" onchange="bo_um_validatePartyStatus(this.value)" headerKey="-1"
									headerValue="--Please Select--" applyscript="true"></s:select>
									<div id="partyName_error" class="fieldError">
							<s:fielderror>
								<s:param>partyName</s:param>
							</s:fielderror>
						</div>
									
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Status:
								</label>
							</div>
							<div class="InputDiv">
								<s:select theme="myTheme" cssClass="select1"
									list="{'Block','Unblock'}"
									name="status" id="status" headerKey="-1"
									headerValue="--Please Select--"
									></s:select>
							</div>
						</div>
						
								
					</div>
					<div class="box_footer" align="right">
					<button type="button" theme="simple" onclick="changeStatus()">Submit</button>
					     
					</div>
				</s:form>
			</div>
			
		</div>
  </body>
</html>
