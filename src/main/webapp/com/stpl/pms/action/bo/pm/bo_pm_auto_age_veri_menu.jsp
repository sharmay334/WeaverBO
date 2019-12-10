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

		<title>Age Verification Search</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
			<link href="<%=path%>/css/multiselect/chosen.css" rel="stylesheet"
			type="text/css" />
		<link href="<%=path%>/css/paginaton_style.css" rel="stylesheet" type="text/css" />
		
		<SCRIPT type="text/javascript" src="<%=path%>/js/jquery.paginate.js"></SCRIPT>
		<script type="text/javascript"
			src="<%=path%>/js/multiselect/chosen.jquery.js"></script>
			<SCRIPT type="text/javascript">
			$(document).ready(function(){
				$('#formSubmit').click(function(){
					 $('#paginationPage').val(1);
					 $('#recordPerPage').val(10);	
					 $('#Image_loading').css("display","");
				});
				
				$("#domainId").change(function(){
				$("#searchResult").html('');
				});
				
				$("#vStatus").change(function(){
				$("#searchResult").html('');
				});
			
			});
			
			</SCRIPT>
		</head>

	<body>
		<div class="FormSection">

			<div class="greyStrip">
				<h4>
					Auto Verification
				</h4>
			</div>
			 <s:form id="playerSearchFrm" action="bo_pm_auto_age_veri_search_plr"
				target="searchResult" theme="simple">
					<s:set name="byDefaultDomainID" value="%{bydefaultSelectedDomain}"/>
				<s:hidden name="paginationPage" id="paginationPage"></s:hidden>
				<s:hidden name="recordPerPage" id="recordPerPage"></s:hidden>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Domain
							</label>
						</div>
						<div class="InputDiv">
							<div>
								<ss:select theme="myTheme" cssClass="select1" name="domainId"
									list="%{domainIdMap}"
									id="domainId" headerKey="-1" applyscript="true"
									headerValue="--All Domain--" listKey="%{key}"
									listValue="%{value}" value="%{bydefaultSelectedDomain}"></ss:select>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								User Name
							</label>
						</div>
						<div class="InputDivHalf">
							<ss:textfield id="userName" name="userName"  theme="myTheme"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								First Name
							</label>
						</div>
						<div class="InputDivHalf">
							<ss:textfield id="firstName"  name="firstName" theme="myTheme"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Last Name
							</label>
						</div>
						<div class="InputDivHalf">
							<ss:textfield id="lastName"  name="lastName" theme="myTheme"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Verification Status
							</label>
						</div>
						<div class="InputDivHalf">
							<ss:select id="vStatus" name="verificationStatus"  theme="myTheme" list="#{'SELF_EXCLUDED':'Self Excluded','UNDER_AGE':'Under Age','PENDING':'Pending','VERIFIED':'Verified'}" applyscript="true"></ss:select>
						</div>
					</div>

				</div>
				<div class="box_footer" align="right">
					<ss:submit name="Search" value="Search" cssClass="button" id="formSubmit"
					formnovalidate="true"></ss:submit>
				</div>
							</s:form>
							<div id="Image_loading" style="text-align: center;display: none;"><img alt="loader4" src="images/4.gif"></div>
				<div id="searchResult">

		</div>
		</div>
		
	</body>
</html>
