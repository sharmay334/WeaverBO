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
    
    <title>Add Pixel and GoogleAnalytics</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <SCRIPT type="text/javascript">
    $(document).ready(function(){
      $("#urlId").change(function(){
        $("#scriptFor").val("-1");
	    $("#content").html("");
      });
    });
    function getScriptContent(){
	    if($("#scriptFor").val()!="-1"){
		     result =  _ajaxCallText('com/stpl/pms/action/bo/cms/st_pms_getPixelGaContent.action?domainId='+$("#domainId").val()+'&urlId='+$("#urlId").val()+'&scriptFor='+$("#scriptFor").val(), '');
		     $("#content").html(result);
	     }
    }  
    
    function getPageNames(){
      $('#urlId').empty().append(
				$('<option></option>').val("-1").html("----Please Select----"));
	  $("#scriptFor").val("-1");
	  $("#content").html("");
	  if($('#domainId').val() == "-1"){
	     return false;
	    }
	      var result =  _ajaxCallText('com/stpl/pms/action/bo/cms/st_pms_getPageNames.action?domainId='+$("#domainId").val(), '');
		  var pageNameList = $.parseJSON(result);
		  $.each(pageNameList, function(i, value) {
						$("#urlId").append(
								$('<option></option>').val(value.urlId).html(
										value.urlDisplayName));
				});
		  return false;
    }
    </SCRIPT>
  </head>
  
  <body>
    <div class="FormSection">
			<div class="greyStrip">
				<h4>
					Add Pixel and GoogleAnalytics
				</h4>
			</div>
			<s:form theme="simple" action="st_pms_savePixelGoogleAnalytics">
              <div class="innerBox">
              <div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Domain Name:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
							<s:if test="%{domainId>1}">
								<s:hidden name="domainId" value="%{domainId}" id="domainId"></s:hidden>
								<s:property value="%{domainName}" />
							</s:if>
							<s:else>
								<ss:select theme="myTheme" cssClass="select1"
									list="%{domainMap}" name="domainId" id="domainId"
									headerKey="-1" headerValue="--Please Select--" listKey="%{key}"
									listValue="%{value}" applyscript="true" onchange="return getPageNames()"></ss:select>
							</s:else>
						</div>
					</div>
				<div class="clearFRM"></div>	
				<div class="FormMainBox">
									<div class="labelDiv">
										<label>
											Page Name:
										</label>
										<em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<ss:select label="Page Name"
											headerKey="-1" headerValue="-- Please Select --"
											cssClass="select1" name="urlId" id="urlId" list="{}"
											theme="myTheme" applyscript="true"/>
									</div>
								</div>
				<div class="clearFRM"></div>				
				<div class="FormMainBox">
									<div class="labelDiv">
										<label>
											Script For:
										</label>
										<em class="Req">*</em>
									</div>
									<div class="InputDiv">
										<ss:select
											headerKey="-1" headerValue="-- Please Select --"
											cssClass="select1" name="scriptFor" id="scriptFor" list="#{'GOOGLE_ANALYTICS':'Google Analytics','PIXEL':'Pixel'}" key="key"
											theme="myTheme" applyscript="true" onchange="getScriptContent()"/>
									</div>
					</div>
				<div class="clearFRM"></div>	
				<div class="FormMainBox" style="height: 180px;">
					<div class="labelDiv">
								<label>
									Script:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:textarea applyscript="true" theme="myTheme"  name="content" id="content" cols="80"
															rows="10"></s:textarea></div>
					</div>
					</div>
					
					<div class="box_footer" align="right">
					<input id="saveContent" name="saveContent" class="button" type="submit" value="Submit">
				   </div>
				
			</s:form>
		</div>
  
  </body>
</html>
