<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags" %>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		
		<title>View Unit Measure</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	</head>
	<body>
		<div class="clear2"></div>
		<h2>
			View Unit Measure
			<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
		</h2>

		<!--form section first start-->
		<div class="FormSection">

			<div class="greyStrip">
				<h4>
					View Unit Measure
				</h4>
			</div>
			<s:form action="/com/stpl/pms/action/bo/um/bo_um_BoviewUnitMeasure_Search.action" id="searchUserFrm"
				theme="simple" target="searchDiv">
				<div class="innerBox">
					
					<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">


						<div class="FormMainBox">

							<div class="labelDiv">
								<label>
									Select Unit Measure
								</label>
							</div>
							<div class="InputDiv">
								<s:select name="unitSymbol" headerKey="-1"
									headerValue="Select Name" list="viewunitMeasureList"
									cssClass="select1" theme="myTheme"></s:select>
							</div>
						</div>
					</s:if>
					
				</div>
				<div class="box_footer" align="right">
					<%-- <s:submit value="Search" align="left" cssStyle="margin-left:0px"
						cssClass="button" theme="simple"></s:submit>
					 --%>	
						<input type="submit" value='View' align="left" style="margin-left:0px"
						class="button"/>
				</div>
			</s:form>
		</div>
		<div id="searchDiv"></div>
		<br />
		<br />
	</body>
</html>
