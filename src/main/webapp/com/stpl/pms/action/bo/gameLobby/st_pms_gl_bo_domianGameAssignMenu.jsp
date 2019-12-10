<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Game Assign to Domain</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<SCRIPT type="text/javascript">
	$(document).on(
			"change",
			'input[name="domainSelect"]',
			function() {
			alert("gfddsf");
			  $("#lobbyList").show();
			});
</SCRIPT>
	</head>

	<body>
		<h2>
			<s:property value="%{headerName}" />
		</h2>
		<div class="FormSection">

			<div class="greyStrip">
				<h4>
					Domain Info
				</h4>
			</div>
			<s:if test="%{actionName=='com_pms_bo_createNewGameLobby'}">
			
			<s:form id="playerSearchFrm" action="%{actionName}"
				target="searchResult" theme="simple">
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								<s:property value="%{headingName}" />
							</label>
						</div>
						<div class="InputDiv">
							<div>
									<s:select theme="myTheme" name="domainId" cssClass="select1"
										list="%{domainMap}"
										id="domainId" headerKey="0" 
										headerValue="--Please Select--" listKey="%{key}"
										listValue="%{value}" value="%{byDefaultDomainID}"></s:select>
										
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Game Group Type
							</label>
						</div>
						<div class="InputDiv">
							<div>
									<s:select theme="myTheme" name="gameGroupType" cssClass="select1"
										list="%{lobbyMaster}"
										id="domainId" headerKey="0" 
										listKey="%{lobbyId+'_'+lobbyName}" listValue="%{lobbyName}"
										headerValue="--Please Select--"></s:select>
										
							</div>
						</div>
					</div>
				</div>
				<div class="box_footer" align="right">
					<s:submit name="Select" value="Select" cssClass="button"></s:submit>
				</div>
			</s:form>
			</s:if>
			<s:else>
			<s:form id="playerSearchFrm" action="%{actionName}"
				target="searchResult" theme="simple">
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								<s:property value="%{headingName}" />
							</label>
						</div>
						<div class="InputDiv">
							<div>
									<s:select theme="myTheme" name="domainId" cssClass="select1"
										list="%{domainMap}"
										id="domainId" headerKey="0" headerValue="--All Domain--"
										listKey="%{key}" listValue="%{value}"
										value="%{byDefaultDomainID}"></s:select>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Game Group Type
							</label>
						</div>
						<div class="InputDiv">
							<div>
									<s:select theme="myTheme" name="gameGroupType" cssClass="select1"
										list="%{lobbyMaster}"
										id="domainId" headerKey="0" 
										listKey="%{lobbyId+'_'+lobbyName}" listValue="%{lobbyName}"
										headerValue="--Please Select--"></s:select>
										
							</div>
						</div>
					</div>
				</div>
				<div class="box_footer" align="right">
					<s:submit name="Select" value="Select" cssClass="button"></s:submit>
				</div>
			</s:form>
		</s:else>	
		</div>
		<div id="searchResult">

		</div>

	</body>
</html>