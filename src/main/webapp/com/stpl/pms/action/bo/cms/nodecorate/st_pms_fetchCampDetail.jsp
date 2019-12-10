<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<SCRIPT type="text/javascript">
     $(document).ready(function(){
          if($("#campType").val()=='REFER_FRIEND'){
		    $("#addMoreCamp").hide();
          }
          if($("#campType").val()=='PPC'){
				$("#addParam").css("display","block");
			}else{
				$("#addParam").css("display","none");
			}
    	  $('[id*=fromDate_]').each(function(){
    	    $(this).datetimepicker({
						dateFormat : 'dd/mm/yy',
						timeFormat : 'HH:mm:ss',
						showSecond: true,
						changeMonth : true,
						numberOfMonths : 1,
						minDate: serverDateStr,
						minDateTime: $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
						onClose: function( selectedDate ) {
							$('[id*=toDate_]').datetimepicker( "option", "minDate", selectedDate );
							$('[id*=toDate_]').datetimepicker( "option", "minDateTime", $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',selectedDate));
						}
					});
		    });
		  $('[id*=toDate_]').each(function(){
    	      $(this).datetimepicker({
						dateFormat : 'dd/mm/yy',
						timeFormat : 'HH:mm:ss',
						showSecond: true,
						changeMonth : true,
						numberOfMonths : 1,
						minDate: serverDateStr,
						minDateTime: $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
						onClose: function( selectedDate ) {
							$('[id*=fromDate_]').datetimepicker( "option", "maxDate", selectedDate );
							$('[id*=fromDate_]').datetimepicker( "option", "maxDate", $.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',selectedDate));
						}
					});
			});  
		});	
	
    </SCRIPT>
	
  </head>
  
  <body>
  
    <div id="container">
     <s:hidden name = "campDetailString" id = "campDetailString"></s:hidden>
	 <s:hidden value="%{landingPageDetailStr}" id="landingPageDetail"></s:hidden>	
	  <div class="FormSection">
			<div class="greyStrip">
			<h4>
				Campaign Detail
			</h4>
		</div>
		<div class="innerbox">
                     <div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Campaign Name:
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield id="campName" name="campName" applyscript="true" theme="myTheme" value="%{campaignDetailBean.campaignName}" pattern="^[0-9a-zA-Z_,\- ]*$" errorMassage="Only alphanumeric character allowed" ></ss:textfield>
						</div>
					</div>
						 <div class="clearFRM"></div>
			             <div class="FormMainBox">

						 <div class="labelDiv"><s:label value="Campaign Type:" theme="simple"/><em class="Req">*</em></div>
			                <div class="InputDiv">
								<ss:select name="campType" headerKey="-1" 
									headerValue="-- Please Select --" cssClass="select1" value="%{campaignDetailBean.campaignType}"
									id="campType" list="#{'REFER_FRIEND':'Refer Friend','SOCIAL_REFER':'Social Refer','PPC':'PPC','AFFILIATE':'Affiliate'}" theme="myTheme" applyscript="true"/>
							</div></div>
						<div class="clearFRM"></div>
						
			             <div class="FormMainBox">
						 <div class="labelDiv"><s:label value="Status:" theme="simple"/><em class="Req">*</em></div>
			                <div class="InputDiv">
								<ss:select name="status" headerKey="-1" 
									headerValue="-- Please Select --" cssClass="select1" value="%{campaignDetailBean.status}"
									id="status" list="{'ACTIVE','INACTIVE'}" theme="myTheme" applyscript="true"/>
							</div></div>
					<div id="paramDiv">
					  <s:iterator value="%{campaignDetailBean.campParams}" status="campParams">
							<div class="clearFRM"></div>
							<div class="FormMainBox">
								<div class="labelDiv">
									<label>
										Param<s:property value="%{#campParams.index+1}"/>:
									</label>
								</div>
								<div class="InputDiv">
									<input type="text" id="param<s:property value="%{#campParams.index+1}"/>"
										value="<s:property />" name="campParams[<s:property value="%{#campParams.index}"/>]" />
								</div>
							</div>
						</s:iterator>
						<s:hidden id="paramCount" value="%{campaignDetailBean.campParams.size()}"></s:hidden>
					</div>	 
                   <div class="box_footer" align="right" style="display: none" id="addParam">
			      		<input type="button" class="button" value="Add Parameters" onclick="addParams()">
			      </div>   
                      
      
      </div>
      <s:set var="count1" value="1" />
      <div id="subCampDetail">
        <s:iterator value="campaignDetailBean.campDetailList" status="campDetailBean">
	      <div class = "FormSectionMenu" id = "subCamp_<s:property value="#campDetailBean.index+1"/>">
	      	<div class="greyStrip">
				<h4>
					Sub Campaign Information
				</h4>
			</div>
			<div class="innerbox">
			    <s:hidden id="subCampaignId_%{#campDetailBean.index+1}" value="%{subCampaignId}"></s:hidden>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>
							Sub Campaign Name:
						</label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:textfield id="subCampName_%{#campDetailBean.index+1}" name="subCampName" applyscript="true" theme="myTheme" value="%{subCampaignName}" pattern="^[0-9a-zA-Z_,\- ]*$" errorMassage="Only alphanumeric character allowed" ></ss:textfield>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>
							Rummy Url
						</label>
					</div>
					<div class="InputDiv" style="height: 55px;">
						<ss:textfield id="deepRummyUrl_%{#campDetailBean.index+1}" name="deepRummyUrl" theme="myTheme" value="%{deepRummy}"></ss:textfield>
						<div>
						<b>Note:</b> - Please Specify With # KeyWord
					</div>
					</div>
					
				</div>
				 <div class="clearFRM"></div>
	             <div class="FormMainBox">
					 <div class="labelDiv"><s:label value="Landing Page:" theme="simple"/><em class="Req">*</em></div>
					 <div class="InputDiv">
					 	<s:if test="%{'PortalContent'.equalsIgnoreCase(aliascontentType)}">
							<ss:select name="landingPage" headerKey="-1" value="%{content}" 
							headerValue="-- Please Select --" cssClass="select1"
							id="landingPage_%{#campDetailBean.index+1}" list="%{landingPageDetail}" theme="myTheme"
							listKey="%{key}" listValue="%{value}" applyscript="true"/>
						</s:if>
						<s:else>
							<ss:select name="landingPage" headerKey="-1" value="%{content}" 
							headerValue="-- Please Select --" cssClass="select1"
							id="landingPage_%{#campDetailBean.index+1}" list="%{joomlaCtBean}" theme="myTheme"
							listKey="%{publicUrl}" listValue="%{name}" applyscript="true"/>
						</s:else>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>
							Valid From Date
						</label>
						<em class="Req">*</em>
					</div>
					<div class="InputDivHalf">
					    <input id="fromDate_<s:property value="#campDetailBean.index+1"/>" type="text" patternon="both" readonly="readonly" value='<s:date name="%{fromDate}" format="dd/MM/yyyy HH:mm:ss" />' applyscript="true">
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>
							Valid To Date
						</label>
						<em class="Req">*</em>
					</div>
					<div class="InputDivHalf">
					    <input id="toDate_<s:property value="#campDetailBean.index+1"/>" type="text" patternon="both" applyscript="true" readonly="readonly" value='<s:date name="%{toDate}" format="dd/MM/yyyy HH:mm:ss" />'>
					</div>	
				</div>
						
			</div>
	      </div>
	      <s:set name="count1" value="%{#count1+1}"/>
	      </s:iterator>
	      <s:hidden name="count" id="count" value="%{#count1}"></s:hidden>
      </div>
      <div id="camp">
      
      </div>
      <div class="box_footer" align="right">
      		<input type="button" class="button" id="addMoreCamp" value="Add More" onclick = "addCamp()">
      		<s:submit value="Submit" align="right" theme="simple" onclick="return prepareCampData()"></s:submit>
      </div>
      </div>
      
		</div>
  </body>
</html>
