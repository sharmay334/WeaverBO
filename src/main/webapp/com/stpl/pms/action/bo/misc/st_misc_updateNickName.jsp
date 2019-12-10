<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>

<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<html>
<head>
<title>Update Poker Nick Name</title>

<script type="text/javascript">
      window.history.forward();
    function noBack()
    {
     window.history.forward(); 
      location.reload(); 
    }
   var domainId;
   $(document).ready(function() {
	   
   $('#nickName').keydown(function(e) {
	    if (e.keyCode == 32) {
	        return false;
	    }
	});
	   
   $('#updateBtn').attr("disabled", "disabled"); 
   $('#updateBtn').addClass('disabledInputButton');
   $('#nickName').val('');
   $('#userName').val('');
   $('#domainId').val(-1);
   $('#domainId').val("-- Please Select --");
    $("#nickName").attr("disabled", "disabled"); 
    $('#nickName').addClass('input-disabled');
   if($('#userDomainId').val()!=0){
      $("#domainName").replaceWith("<s:property value='%{#session.USER_INFO.domainName}' /><input type='hidden' value=<s:property value='%{#session.USER_INFO.domainId}'/>  name='playerBugSearchBean.domainId' />");
   }
 
   $('#submitBtn').click(function(){
      $('#resultDiv1').hide();
      $('#resultDiv2').hide();
         var domainId = $('#domainId').val();
            var userName = $('#userName').val();
            if(domainId == "-1"){
               alert("Please select the Domain Name");
               return false;
               }
               if(userName == ""){
               alert("Please provide the User Name");
               return false;
               }
           if(userName != ""){
            $.getJSON('bo_mis_ajax_showPokerNickNameSearchResult.action',{domainsId : domainId , userName : userName },
                function(jsonResponse) {
                if(jsonResponse != null && jsonResponse.status == 200){
                          $("#nickName").removeAttr('disabled'); 
                          $('#nickName').removeClass('input-disabled');
                          $('#nickName').val(jsonResponse.nickName);
                          $('#resultDiv1').hide();
                          $('#updateBtn').removeAttr('disabled'); 
                          $('#updateBtn').removeClass('disabledInputButton');
                          }else{
                          $('#resultDiv1').show();
                          }
                
                          $('#nickNameChkStatus').hide();
                     });
                   }
          });
          
       
    $("#userName").change(function() {
       $('#nickName').val('');
       $('#updateBtn').attr("disabled", "disabled"); 
        $("#nickName").attr("disabled", "disabled");
        $('#nickName').addClass('input-disabled');
        $('#updateBtn').addClass('disabledInputButton');
        $('#updateBtn').attr("disabled", "disabled"); 
        $('#resultDiv1').hide();
            $('#resultDiv2').hide();
          });
   $('#domainId').change(function() {
                $('#nickName').val('');
             $('#userName').val('');
             $("#userName").removeAttr('disabled'); 
             $('#updateBtn').attr("disabled", "disabled"); 
            $('#updateBtn').addClass('disabledInputButton');
             $("#nickName").attr("disabled", "disabled"); 
            $('#nickName').addClass('input-disabled');
            $('#resultDiv1').hide();
            $('#resultDiv2').hide();
         });
   
   $('#updateBtn').click(function(){
         $("#userName").removeAttr('disabled'); 
         var domainId = $('#domainId').val();
         var aliasId = $('#aliasId').val();
         var userName = $('#userName').val();
         var nickName = $('#nickName').val();

            if(domainId == "-1"){
               alert("Please select the Domain Name");
               return false;
            }
            if(userName == ""){
               alert("Please provide the User Name");
               return false;
            }
            if(nickName == ""){
               alert("Please provide the Nick Name.");
               return false;
            }else if(nickName.length < 5){
                  alert("Length of Nick Name must be 5 or greater.");
                  return false;
            }else{
                  if (/^[a-zA-Z]{1}[a-zA-Z0-9_]+$/.test(nickName)) {
                  } else {
                     alert("Nick Name allow alpha-numeric value only. ");
                     $('#nickName').val('');
                     $('#nickName').focus();
                     return false;
                  }
               }
            
            $('#formDiv').hide();
            $('#resultDiv').show();
            $('#Image_loading').show();
            
            $.getJSON('bo_mis_pokerNickNameUpdate.action',{nickName : nickName,domainsId : domainId,alaisId : aliasId,userName : userName},
                    function(jsonResponse) {
	            	    $('#Image_loading').hide();
	                    if(jsonResponse != null && jsonResponse.status == 200){
	                         $('#resultDiv').find('span#message').text("NickName update successful");
	                       }else{
	                    	   $('#resultDiv').find('span#message').text(jsonResponse.message);
	                     }
                        
	                    $('#resultDiv').find('#message_info').show();	
                    }); 
   });
   
   $('#checkAvailabilty').click(function(){
	   checkNickNameExist();
   });
   
   
});
   
function checkNickNameExist(){
	
		 $('#nickNameChkStatus').attr('src','<%=request.getContextPath()%>/images/loading.gif');
		 $('#nickNameChkStatus').show();
         var nickName = $('#nickName').val();
         var aliasId = $('#aliasId').val();
         $('#resultDiv2').hide();
         
            $.getJSON('bo_mis_ajax_isPokerNickNameAvailable.action',{nickName : nickName ,alaisId : aliasId},
                function(jsonResponse) {
                if(jsonResponse != null && jsonResponse.status==200){
                	$('#updateBtn').removeAttr('disabled'); 
                    $('#updateBtn').removeClass('disabledInputButton');
                    $('#nickNameChkStatus').attr('src','<%=request.getContextPath()%>/images/tick.png');
                }else{
                  if(jsonResponse != null && (jsonResponse.status==6011 || jsonResponse.status==102)){
                	  $('#resultDiv2').text("Internal Error: Either CAPI is down or poker service is not associated with selected alias");
                  }else{
                	  $('#resultDiv2').text("This Nick Name is already Exist, Please choose other nick name.");
                  }		
                  $('#resultDiv2').show();
                  $('#updateBtn').attr("disabled", "disabled"); 
                  $('#updateBtn').addClass('disabledInputButton');
                  $('#nickNameChkStatus').attr('src','<%=request.getContextPath()%>/images/close_32.png');
				}
			});
	}
</script>
</head>
<body onload="noBack();" onpageshow="if (event.persisted) noBack();"
	onunload="">
	<s:hidden value="%{#session.USER_INFO.domainId} " id="userDomainId"></s:hidden>
	<div class="clear2"></div>
	<h2>Update Poker Nick Name</h2>

	<!--form section first start-->
	<div class="FormSection" id="formDiv"> 

		<div class="greyStrip">
			<h4>Search Nick Name</h4>
		</div>

		<s:form theme="simple" action="bo_mis_pokerNickNameUpdate" >
			<div class="innerBox">
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Domain Name </label>
					</div>
					<div class="InputDiv">
						<div>
							<s:select theme="myTheme" cssClass="select1" list="%{domainMap}"
								applyscript="true" id="domainId" headerKey="-1"
								headerValue="--Please Select--" listKey="%{key}"
								listValue="%{value}" name="domainsId"></s:select>
						</div>
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Alias Name </label>
					</div>
					<div class="InputDiv">
						<div>
							<s:select theme="myTheme" cssClass="select1" list="%{aliasMap}"
								applyscript="true" id="aliasId" headerKey="-1"
								headerValue="--Please Select--" listKey="%{key}"
								listValue="%{value}" name="alaisId"></s:select>
						</div>
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> User Name </label>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield name="userName" id="userName"
								placeholder="Please enter the User Name" maxlength="20"
								style="width: 73.7%; height: 26px;"></s:textfield>
						</div>
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Nick Name </label>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield name="nickName" id="nickName" value=""
								maxlength="20"
								style="width: 73.7%; height: 26px;"></s:textfield>
							<img id="nickNameChkStatus"
								src="<%=request.getContextPath()%>/images/tick.png"
								style="display: none"></img>
							<font style="align: left"> <input type="button"
								id="checkAvailabilty" value="Check"></input></font>	
								
							<div id="resultDiv1" style="display: none; color: red">
								<font color="red">Nick name not found for this User Name.</font>
							</div>
							<div id="resultDiv2" style="display: none; color: red">
								<font color="red">This Nick Name is already Exist, Please
									choose other nick name.</font>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="box_footer" align="right">
				<font style="align: left"> <input type="button"
					id="submitBtn" value="Search"></input></font>
					
				<font style="align: left"> <input type="button"
					id="updateBtn" value="Update"></input></font>	
				<%-- <s:submit theme="simple" id="updateBtn" value="Update"></s:submit> --%>
			</div>
		</s:form>
	</div>
	
	 <div id="resultDiv" class="FormSection" id="infostrip_payCorrection" style="display:none">
				<div class="greyStrip">
					<h4>Message</h4>
				</div>
				<div class="innerBox">
					<div id="Image_loading" style="display: none" align="center"><img src="<%=request.getContextPath()%>/images/loading.gif"></img></div>
					<div class="alert info_msg" id="message_info" style="display:none">
						<span class="alert_close" ></span><strong>Info: </strong> <span id="message"></span>
					</div>
				</div>
		</div>
	
</body>
</html>