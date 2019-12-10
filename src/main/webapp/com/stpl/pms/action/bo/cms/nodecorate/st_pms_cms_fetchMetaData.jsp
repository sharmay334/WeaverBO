<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<base href="<%=basePath%>">
<title>Update SEO Tags</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
</head>
<body>
	<div class="FormSection">
		<div class="greyStrip">
			<h4>Update SEO Tags</h4>
		</div>
		<div class="innerBox">
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Title </label>
				</div>
				<div class="InputDiv1">
					<s:textarea name="pageTitle" cols="93" rows="5" id="title"
						value="%{urlBean.title!=null?urlBean.title:''}"
						cssStyle="width:98%;"></s:textarea>
				</div>
			</div>
			<div class="clearFRM"></div>
		</div>
		<div class="innerBox">
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Meta Keyword </label>
				</div>
				<div class="InputDiv1">
					<s:textarea name="pageKeyword" cols="93" rows="5" id="keyword"
						value="%{urlBean.meta!=null?urlBean.meta.get('keyword'):''}"
						cssStyle="width:98%;"></s:textarea>
				</div>
			</div>
			<div class="clearFRM"></div>
		</div>
		<div class="innerBox">
			<div class="FormMainBox">
				<div class="labelDiv">
					<label> Meta Description </label>
				</div>
				<div class="InputDiv1">
					<s:textarea name="pageDescription" cols="93" rows="5"
						id="description"
						value="%{urlBean.meta!=null?urlBean.meta.get('description'):''}"
						cssStyle="width:98%;"></s:textarea>
				</div>
			</div>
			<div class="clearFRM"></div>
		</div>
		<div class="box_footer" align="right">
			<s:submit theme="simple" id="submitBtn" value="Save"></s:submit>
		</div>
	</div>
	<br />
</body>
</html>
