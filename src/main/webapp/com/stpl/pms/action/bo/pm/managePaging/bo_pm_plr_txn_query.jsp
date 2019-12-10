<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "-1");
	String path = request.getContextPath();
	/*String basePath =  (String)request.getAttribute("basePathURL") ;*/
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tech Support</title>
</head>
<body>

<div class="clear2"></div>
<h2>
Search Player</h2>

<s:form action="bo_pm_plr_txn_query_search" method="POST"
	name="plrTxnQuery" theme="simple" target="resultData">
	<s:token name="strutsToken" id="strutsToken"></s:token>
	<div class="FormSection">

		<div class="greyStrip">
			<h4>
				Information
			</h4>
		</div>
<div align="left" style="font-family: Arial;font-size: 15px;color: #000000;padding-left: 5px">
<!-- <font style="color:red">* </font>All fields are mandatory.</div> -->
	
	<div align="left" style="padding-left: 15px" class="fieldError">
	<s:fielderror ><s:param >rolePriv</s:param></s:fielderror>
	</div>
	
		<div class="innerBox">
			<div class="FormMainBox">
				<div class="labelDiv">
					<label>
						Mobile Number
					</label>
					<em class="Req">*</em>
				</div>
				<div class="InputDivHalf">
					<ss:textfield theme="myTheme" cssClass="text-field-small" name="mobile_no" id="mobile_no" pattern="^[0-9]*$" patternon="both"  errorMassage="Only Numeric allowed" maxLength="12" applyscript="true"></ss:textfield>
						
            </div>
            </div>
            <div class="clearFRM"></div>
            <div class="FormMainBox">
            <div class="labelDiv">
							<label>
								Domain
							</label>
						</div>
						<div class="InputDiv">
							<div>
								
								<s:if test="%{domainId>1}">
									<s:hidden  value="%{domainId}" id="domainId" name="domainId" requestParam="YES"></s:hidden>
									<s:property value="%{domainName}"/>
								</s:if>
								<s:else>
									<s:select theme="myTheme" cssClass="select1"
										list="%{domainMap}"
										id="domainId" listKey="%{key}"
										listValue="%{value}" name="domainId" value="%{bydefaultSelectedDomain}"></s:select>
								</s:else>
									
							</div>
						</div>
			</div>	
			<div class="clearFRM"></div>
		</div>		
           <div class="box_footer" align="right">
			<s:submit style="margin:5px 6px 10px 0 !important;" value="Search" align="center" cssClass="button"
				 theme="simple"/>
		</div>
				
		
		
	</div>

		</div>
</s:form>

<div id="resultData">




</div>

</body>
</html>