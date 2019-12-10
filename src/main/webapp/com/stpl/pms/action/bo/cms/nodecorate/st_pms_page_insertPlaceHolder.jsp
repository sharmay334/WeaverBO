<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
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
	</head>
	<body>
		<div id="container" style="min-height: 0px; width: auto;">
			<div style="width: 100%; height: 0.1px;"></div>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Configure Place Holders
					</h4>
				</div>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv" style="width: 35%">
							<label>
								Size:
							</label>
						</div>
						<div class="InputDiv" style="width: 62%">
							<ss:select id="ph_size" cssClass="select1"
								cssStyle="width:220px;"
								list="{'120X600','160X600','200X200','227X250','227X694','250X250','300X250','300X600','320X50','336X280','300X155','436X183','468X60','550X146','550X480','728X90','800X464','970X90','1000X80','1000X118','1000X120','1000X410'}"
								applyscript="true" theme="myTheme"></ss:select>
						</div>
					</div>

					<div class="FormMainBox">
						<div class="labelDiv" style="width: 35%">
							<label>
								Name:
							</label>
						</div>
						<div class="InputDiv" style="width: 62%;">
							<ss:textfield id="ph_name" value="" applyscript="true"
								pattern="^[a-zA-z0-9]*$" errorMassage="Numeric Only"
								theme="myTheme"></ss:textfield>
						</div>
					</div>
					<div class="box_footer" align="right">
						<s:submit theme="simple" id="submitBtn" value="Insert"
							onclick="insertPlaceHolder('%{#parameters.language}'); close_facebox(); return false;"></s:submit>
					</div>
				</div>
			</div>

		</div>

	</body>
</html>
