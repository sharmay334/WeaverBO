<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	/* String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/"; */
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
			src="<%=basePath%>com/stpl/pms/action/bo/reports/js/common_report.js"></script>
		<script>
		var gameName="";
		 $(document).ready(function(){
		setDefaultDate();
		$("#dateWise").attr("checked",true);
	
		
		loadAliasName($("#domainId").val());
		loadGameType();
		$('#domainId').change(function() {
		if($("#domainId").val()=="0"){
				$('#aliasId').attr('disabled','true');
		}
		else{
				$('#aliasId').removeAttr('disabled');
				$("#aliasId").html("");
				loadAliasName($(this).val());
				loadGameType();
			}
		});
		
		
		$('#aliasId').change(function() {
			loadGameType();
		});
		
		 $("#playerSearchFrm").submit(function(){
		 if ($("#startIndex").length){ 
			 	$("#startIndex").val("0");
		 }
	         $("#redirect").val("Search");
	         $("#playerSearchFrm").attr("target","searchResult");
	         $("#searchBtn").hide();
	         $("#waitDiv").show();
	         $("#searchBtn").attr("disabled",true);
         
      });	
		
		function loadAliasName(domainId){
					var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+domainId,"");
					$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					$.each(aliasMap,function(index, value) {
						$('#aliasId').append($('<option></opplayerSearchMenution>').val(index).html(value));
				  	});
			}
			
			function loadGameType(){
					gameName="";
					var gameMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchGameMap.action?domainId="+$("#domainId").val()+"&aliasId="+$("#aliasId").val(),"");
					$("#game").show();
					$('#gameType').empty();
					if("15" in gameMap && $("#domainId").val()!=3)
						delete gameMap["15"];
					var defaultcheck=true;
					$.each(gameMap,function(index, value) {
					if(defaultcheck) {
                        var $chk = $('<input type="radio" name="gameType" id="gameType" checked="checked" value="' + value + '_' + index + '" >' + value + '</input>');
						defaultcheck=false;
                    }else
                        var $chk = $('<input type="radio" name="gameType" id="gameType" value="'+value+'_'+index+'" >'+value+'</input>');
					$('#gameType').append($chk);
                    gameName+=value+",";
				  	});
					gameName=	gameName.substring(0,gameName.length-1);
				  	/* if(Object.keys(gameMap).length>1)
				  	  $('#gameType').append('<input type="radio" name="gameType" value="all" checked="checked" id="gameType">All</input>'); 
				  	  else{
				  	  	$('input:radio:first-child').attr('checked',true);
				  	  	} */
			}
		
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
			<s:form id="playerSearchFrm" action="st_pms_bo_rep_searchReport"
				cssClass="jsonFrm" target="searchResult" theme="simple">
				<s:hidden name="reportData" id="reportData"></s:hidden>
				<s:hidden name="procName" id="procName" value="%{procName}"></s:hidden>
				<s:hidden name="startIndex" id="startIndex" value="0"></s:hidden>
				<s:hidden name="recordTofetch" id="recordTofetch" value="101"></s:hidden>
				
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
										 listKey="%{key}"
										listValue="%{value}" value="%{bydefaultSelectedDomain}"></s:select>
								</s:else>
								
							</div>
						</div>
					</div>
					
					<div class="clearFRM"></div>
					
					
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Alias
							</label>
						</div>
						<div class="InputDiv">
							<div>
								<ss:select theme="myTheme" cssClass="select1" list="%{}" id="aliasId" headerKey="-1"
									headerValue="--Please Select--" >
								</ss:select>
							</div>
						</div>
					</div>
					
					
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								From Date 
							</label>
						</div>
						<div class="InputDivHalf">
							<ss:textfield id="fromDate" cssClass="dateField" theme="myTheme"   readonly="true"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								To Date
							</label>
						</div>
						<div class="InputDivHalf">
							<ss:textfield id="toDate" cssClass="dateField" theme="myTheme"  readonly="true"></ss:textfield>
						</div>
					</div>
					<div id="game" style="display: none">
					<div class="clearFRM"></div>
				<div class="FormMainBox" >
					<div class="labelDiv">
						<label> Game Type </label>
					</div>
					<div class="InputDiv" id="gameType">
							
						</div>
				</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox" >
					<div class="labelDiv">
						<label> How To Display </label>
					</div>
					<div class="InputDiv inpRadio">
					
			
							<s:radio list="#{'dateWise':'Date Wise','playerWise':'Player Wise'}"
								name="dispCriteria" id="%{key}"></s:radio>
						</div>
					
				</div>
					
				</div>
				<div class="box_footer" align="right">
				<div id="waitDiv" class="animated-button-div" style="margin-left: 0px; display: none;" >
					<div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
				</div>
					<s:submit name="Search" value="Search" id="searchBtn" cssClass="button"></s:submit>
				</div>
				
			</s:form>
		</div>
		<div id="searchResult">

		</div>
	</body>
</html>
