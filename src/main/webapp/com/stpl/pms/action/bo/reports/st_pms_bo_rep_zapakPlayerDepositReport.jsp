<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title><s:property value="%{headerName}"/></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript"
			src="com/stpl/pms/action/bo/reports/js/common_report.js"></script>
		<script type="text/javascript" src="<%=path%>/js/jQuery/jquery.mtz.monthpicker.js"></script>
		<script>
		 $(document).ready(function(){
		
          $('#month').monthpicker();
          
          $('#search').click(function(){
            if($('#month').val()==""){
             alert("Please select a month");
             return false;
            }else{
            	 $("#zapakPlrDepRepFrm").attr("target","searchResult");
        		 $("#search").hide();
         		 $("#waitDiv").show();
         		 $("#search").attr("disabled",true);
         		 $("#zapakPlrDepRepFrm").submit();
         		 return false;
            }
            
          
          });
          
		});
		</script>
	</head>

	<body>
		<div class="FormSection">

			<div class="greyStrip">
				<h4>
					<s:property value="%{headerName}"/>
				</h4>
			</div>
			<s:form id="zapakPlrDepRepFrm" action="st_pms_bo_rep_searchReport"
				cssClass="jsonFrm" target="searchResult" theme="simple" callBack="attachEvent('searchResult')">
				<s:hidden name="reportData" id="reportData"></s:hidden>
				<s:hidden name="procName" id="procName" value="%{procName}"></s:hidden>
				
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Domain
							</label>
						</div>
						<div class="InputDiv">
							<div>
								<s:if test="%{domainId>1}">
									<s:hidden  value="%{domainId}" id="domainId" requestParam="YES"></s:hidden>
									<s:property value="%{domainName}"/>
								</s:if>
								<s:else>
									<s:select theme="myTheme" cssClass="select1"
										list="%{domainMap}"
										id="domainId" headerKey="0"
										headerValue="--All Domain--" listKey="%{key}"
										listValue="%{value}" value="%{bydefaultSelectedDomain}"></s:select>
								</s:else>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
					<div class="labelDiv">
							<label>
								Month
							</label>
					</div>
					<div class="InputDiv">
					<input id="month" type="text" style="width: 40%">
					</div>
					</div>
					 <div class="clearFRM"></div>
				</div>
				<div class="box_footer" align="right">
					<div id="waitDiv" class="animated-button-div" style="margin-left: 0px; display: none;" >
						<div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
					</div>
					<s:submit id="search" name="Search" value="Search" cssClass="button"></s:submit>
				</div>
			</s:form>
		</div>
		<div id="searchResult">

		</div>
	</body>
</html>
