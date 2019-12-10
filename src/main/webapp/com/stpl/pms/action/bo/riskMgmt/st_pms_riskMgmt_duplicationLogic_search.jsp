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
    
    <title>Duplication Report</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <SCRIPT type="text/javascript">
	   function getPlayerScore(playerId,userName){
	
		var scoreFor=document.getElementById('scoreFor').value;
		var Min=document.getElementById('Min').value;
		var Max=document.getElementById('Max').value;
		var actionName='com/stpl/pms/action/bo/riskMgmt/bo_risk_duplicationLogicSearch.action?scoreFor='+scoreFor+'&min='+ Min +'&max='+Max+'&playerId='+playerId+'&userName='+userName;
		//var actionParam='scoreFor='+scoreFor+'&min='+ Min +'&max='+Max;
		_ajaxCallDiv(actionName,'','searchDivNew');
				 
		return false;
	}
    </SCRIPT>
   </head>

	<body>
	<div id="mainDiv">
		<h2>
			Duplication Report
		</h2>
<s:form theme="myTheme" id="drForm" action="bo_risk_duplicationPlayerScore" target="searchDiv">
   <div id="container">
		<div class="FormSection">

			<div class="greyStrip">
				<h4>
					Required Information
				</h4>
			</div>
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
							<s:hidden value="%{domainId}" id="domainId"
								name="domainId"></s:hidden>
							<s:property value="%{domainName}" />
						</s:if>
						<s:else>
							<ss:select theme="myTheme" applyscript="true" cssClass="select1"
								list="%{domainMap}" name="domainId" id="domainId"
								headerKey="-1" headerValue="--Please Select--"
								listKey="%{key}" listValue="%{value}"></ss:select>
						</s:else>
					</div>
				</div>
			<div class="clearFRM"></div>
                
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>
							Score For
						</label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv">
						<ss:select name="scoreFor" cssClass="select1" id="scoreFor"
							list="{'Registration','Deposit','Withdrawal'}" key="key"
							headerKey="-1" headerValue="--Please Select--" theme="myTheme" applyscript="true" />
					</div>
				</div>
				<div class="clearFRM"></div>

				<div class="FormMainBox">
					<div class="labelDiv">
						<label>
							Range
						</label>
						<em class="Req">*</em>
					</div>
					<div class="InputDiv"
						style="color: #2b2b2b; font-size: 14px; line-height: 36px; padding-left: 19px;">
						Min&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<ss:textfield name="Min" theme="myTheme" applyscript="true"
							cssStyle="width:15%;height:22px; margin-left:-18px" maxlength="3" id="Min" />
						&nbsp;&nbsp;&nbsp; Max&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<ss:textfield name="Max" theme="myTheme" applyscript="true"
							cssStyle="width:15%;height:22px; margin-left:-18px" maxlength="3" id="Max" />
					</div>
				</div>
			</div>
			<div class="box_footer" align="right">
				<ss:submit value="Search" cssClass="button"
					id="submit" theme="simple"/>
			</div>
         
		</div>

		<div id="searchDiv"></div>
		</div>
		 </s:form>
		</div>
	</body>
</html>
