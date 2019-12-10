<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
    <base href="<%=basePath%>">
    <title>Edit Sub User</title>
    <SCRIPT type="text/javascript" src="<%=path %>/com/stpl/pms/action/bo/um/js/um.js"></SCRIPT>
    <script>
    function chksub1(){
    	var c = false;
    	//alert($('.chkOne'));
    	$('.chkOne').each(function() {
    					if (this.checked) {
    						c = true;
    					}
    				});
    				if(c == false){
    					var msg = document.getElementById("msgerr").value;
    				alert(msg);
    				return false;
    				}
    				else{`
    				return true;
    				}
    	}
    </script>
    </head>
    <body>
	<input type="hidden" value='<s:text name="global.um.msg10"/>' id="msgerr"/> 
  <h2><s:text name="global.scratchWeaver.edituserpriv"/></h2>
          
         <!--form section first start-->
         <div class="FormSection">
         
		<div class="greyStrip"><h4><s:text name="global.searchuser.requiredinformation"/></h4></div>
		<div align="left" style="padding-left: 15px" class="fieldError">
	<s:fielderror ><s:param >rolePriv</s:param></s:fielderror>
	</div>
        <div class="innerBox">	
        <div class="FormMainBox">
			<div class="labelDiv"><label><s:text name="global.subuserregistration.UserName"/></label></div>
            <div class="InputDiv">
            <ss:select  id="userName" name="userName" theme="myTheme"
							cssClass="select1" list="%{#session.subUserList}"
							 headerKey="-1" ajaxAction="com/stpl/pms/action/bo/um/bo_um_editBoSubUserPriv_FetchPriv.action" target="result"
							headerValue="%{getText('global.SELECTHEADER')}" applyscript="true"></ss:select>
			</div>
			</div>
			</div>
			</div>
		<s:form name="editUserPriv" id="editUserPrivFrm" action="/com/stpl/pms/action/bo/um/bo_um_editBoSubUserPriv_Save.action"
			method="POST" onsubmit="return chksub1();">
			<s:token name="strutsToken" id="strutsToken"></s:token>
			<div id="result">
			</div>
		</s:form>
			</body>
			</html>