<%@page import="com.stpl.pms.utility.Utility"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.stpl.pms.javabeans.UserInfoBean"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "-1");
	String path = request.getContextPath();
	String version ="1.0";
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<s:set name="contextPath"
			value="#request.get('javax.servlet.include.context_path')"
			scope="session" />
		<title><%=Utility.getClientName() %>-<decorator:title /> </title>
		<script type="text/javascript">	
			var Language = "<%=session.getAttribute("localeValue")%>";
		</script>
		<link rel="shortcut icon" href="<%= request.getContextPath()%>/images/client-specific/<%=Utility.getClientName() %>/favicon.ico" type="image/x-icon"/>
		<link href="<%=path %>/css/images/bubbletip.css?v=<%=version %>" rel="stylesheet" type="text/css" />
		<link href="<%=path %>/css/images/bubbletip-IE.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/jQuery/jquery.ui.all.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/BoNew.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/style.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/reset.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/menu.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/treeview/tree_view.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/jquery.dataTables.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/jquery.dataTables.mis.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<link href="<%=path%>/css/BoNew.css?v=<%=version%>" rel="stylesheet" type="text/css" />
		<script src="<%=path%>/js/jQuery/jquery-1.8.3.js?v=<%=version%>" type="text/javascript" ></script>
		<script type="text/javascript"
			src="<%=path%>/js/jQuery/jquery-ui-1.10.3.custom.js?v=<%=version%>"></script>
		<script type="text/javascript" src="<%=path%>/js/jQuery/jquery.tablednd.js?v=<%=version%>"></script>
		<script type="text/javascript" src="<%=path%>/js/jQuery/jquery.timepicker.js?v=<%=version%>"></script>
		<script type="text/javascript" src="<%=path%>/js/accodian.js?v=<%=version%>"></script>	
		<script type="text/javascript" src="<%=path%>/js/dynamicMenu.js?v=<%=version%>"></script>
		<script type="text/javascript" src="<%=path%>/js/ajaxCall.js?v=<%=version%>"></script>
		<script type="text/javascript" src="<%=path%>/js/validate.js?v=<%=version%>"></script>
		<script src="<%=path %>/js/jQuery.bubbletip-1.0.6.js?v=<%=version%>" type="text/javascript"></script>
		<script type="text/javascript" src="<%=path%>/js/commonfunctions.js?v=<%=version%>"></script>
		<script type="text/javascript" src="<%=path%>/js/datatable/jquery.dataTables.js?v=<%=version%>"></script>
		
		<script type="text/javascript">		
			var projectName="<%=path%>";
			var serverDateStr = '<s:property value="%{@com.stpl.pms.utility.Utility@getServerDate(0,0,0,\"dd/MM/yy HH:mm:ss\")}" />';
			//var menuStr = '<s:property value="%{menuStr}"/>';
			var menuStr = '<%=session.getAttribute("menuStr").toString()%>';	
			var currentLoggedUser='<s:property value="%{userInfoBean.userName}"/>';
			window.onload = function (ev) {
				BrowserDetect.init();	
				
					
				//initDojo.startDojo(ev);
			 	
				
				
			}
			
			$(function(){
				$("#bo_impersonate").click(function(){
					_ajaxCallDiv("<%=path%>"+"/com/stpl/pms/action/bo/um/dispatch_bo_subusers.action","","impersonate_welcomebox");
				});	
				$("#quit_impersonate").click(function(){
					var result=_ajaxCallText("<%=path%>"+"/com/stpl/pms/action/bo/um/quit_bo_impersonation.action","");
					if(result==="done"){
						document.location.href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()%>"+"/com/stpl/pms/action/bo/lm/bo_home_page.action?serviceName=MGMT";
					}else
						alert("Failed!");
				});	
				if('<s:property value="%{#parameters.serviceName}"/>'=='MGMT'){
					$("#container").addClass( "chartPage");
				}else{
					$("#container").removeClass( "chartPage");
				}
			});		
        </script>	
		<decorator:head />
	</head>
	<body >
	<%-- <s:if test="%{@com.stpl.pms.utility.Utility@getServerDate(0,0,0,\"dd\") > 10}">
		<div style="width: 100%; background-color: #cb0600; padding: 7px 4px; text-align: center; color: #ffffff; font-weight: 600;"><s:text name="global.licence"></s:text> <%= Utility.getServerDate(0, 1, 0, "MMMMM")%>.</div>
	</s:if>
	<s:else>
		<div style="width: 100%; background-color: #cb0600; padding: 7px 4px; text-align: center; color: #ffffff; font-weight: 600;"><s:text name="global.licence"></s:text> <%= Utility.getServerDate(0, 0, 0, "MMMMM")%>.</div>
	</s:else> --%>
	 <!-- top section start-->
  		<div id="TopBar">
         <div class="logo"><img src="<%= request.getContextPath()%>/images/client-specific/<%=Utility.getClientName() %>/logo-new.png" alt="logo" /></div>
            <div id="top_right">
                <div class="welcomebox">
                    <p> <s:text name="global.home.welcome"/>:<label id="currentLoggedUser"> <s:property value="%{userInfoBean.userName}"/></label>
                        <a
						href="<%=request.getContextPath()%>/com/stpl/pms/action/bo/lm/bo_lm_logout.action"><img
							src="<%=request.getContextPath()%>/images/logout.png" alt="logout" /> </a> 
                    </p>
                </div>
                
                <div class="changePSW">
              		<p>
						<a href="<%=request.getContextPath()%>/com/stpl/pms/action/bo/lm/bo_lm_changePassword.action"><s:text name="global.home.changepassword"/></a>
<%-- 						<br/>  Online Players : <s:property value="%{onlinePlayerCount}"/> --%>
		 			</p>
            	</div>
        	</div>
		    <s:if test="%{'ADMIN'.equals(userInfoBean.userType)||#session.impersionateeBean!=null}">
		        <div id="top_right_impersonate">
		        	<s:if test="%{#session.impersionateeBean!=null}">
			       		<div class="welcombox">
			       			<div>Impersonating user :&nbsp<span style="font-weight: 600!important;"><s:property value="%{#session.impersionateeBean.userName}" /></span><button id="quit_impersonate">quit</button></div>
			       		</div>
			    	</s:if>
			    	<s:else>
			        	<div id="impersonate_welcomebox" class="welcomebox">
			        		<button id="bo_impersonate">Impersonate</button>
			        	</div>
		        	</s:else>
		    	</div>
	    	</s:if>
    	 </div>
 	<!-- top section end-->
 	<div id="container">
    <!-- container div start-->
 
		<s:include value="/com/stpl/pms/action/bo/common/header.jsp" />
		<div class="clear"></div>
		<!--navigation start-->
		<div id="Navigation">
			<div id="top">
				<div id="navbox">
				</div>
				<div id="top_bar">
					<div id="main_menu">
												
					<div class="clear"></div>
					</div>
	          					</div>
				<div class="clear"></div>
			</div>
		</div>
		<div class="clear2"></div>
					
	<div id="decoBody">
		<decorator:body />
	</div>
	</div>
	<div class="footer-main"><p><jsp:include page="/com/stpl/pms/action/bo/common/copyright-client-specific.jsp"/></p></div>
	<script type="text/javascript" src="<%=path%>/js/common.js"></script>		
	</body>
	<script>
	createMenu('MGMT');
	</script>
</html>