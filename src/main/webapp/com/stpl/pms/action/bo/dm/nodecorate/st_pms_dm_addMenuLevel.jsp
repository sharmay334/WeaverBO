<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>Main</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript" src="<%=path%>/js/commonfunctions.js"></script>
		<script type="text/javascript">
     $(document).ready(function() {
             $(".UIaccordian").accordion( {
                     collapsible : true,
                     clearStyle : true,
                     header : 'div[class*="accordianHeader"]',
                     icons : {
                             header : "plus1",
                             headerSelected : "minus1"
                     },
                     active : 0
             });
        $(".accordianHeader").click(function( event ) {
		        createBubble();
               });
		
});	
		
   
		

		
	</script>
	</head>
	<body >
	        <s:hidden id="contentMap" name="contentMap"></s:hidden>
			<s:hidden name="menuString" id="menuString"></s:hidden>
			<s:hidden id="menuType" value="add"></s:hidden>
			<s:hidden  value="0" id="count"></s:hidden>
			<div class="FormSection">
			<div class="UIaccordian" id="main">
				
				<div class="accordianHeader greyStrip" style=" width:96%; margin-top: -11px">
					<h4>
						Add Menu Level1 Detail
					</h4>
				</div>
				<div class="accordian_content" style="width: 920px;">
				<div id="addContent">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Display Name:
							</label>
						</div>
						<div class="InputDiv">
							<ss:textfield id="displayName" applyscript="true" theme="myTheme"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						 <div class="labelDiv">
							<label>Content Type: </label>
					 </div>
					 <div class="InputDiv">
						<ss:select headerKey="-1" onchange="getContentNameList(this.id)"
						headerValue="-- Please Select --" cssClass="select1"
						id="contentType" cssStyle="font-size:14px"
						list="{'STATIC_PAGE','DYNAMIC','INTERNAL_LOBBY','EXTERNAL_LOBBY','HOME_PAGE'}"
					    theme="myTheme" applyscript="true"/>
					</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						 <div class="labelDiv">
							<label>Content Name:</label>
					 </div>
					 <div class="InputDiv">
						<ss:select headerKey="-1"
						headerValue="-- Please Select --" cssClass="select1" cssStyle="font-size:14px"
						id="contentName" list='{}' theme="myTheme" applyscript="true"/>
					</div>
					</div>
				 </div>
				  <div id="level2Content">
					
				  </div>
				<div class="box_footer" align="right">
					<input id="addSubMenu" class="button" type="button" style="font-size: 11px"
						value="Add Level2" onclick="addLevel2()"/>
				</div>
				  
				</div>	
			 </div>
			<div class="box_footer" align="right">
			<input id="preview" class="button" type="button"
						value="Preview" onclick="previewData()"/>
				<s:submit value="Submit" align="right" theme="simple" onclick="return prepareData()"></s:submit>
			</div>
			</div>
	</body>
</html>
