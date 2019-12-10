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

		<title>Ad Company Report</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript"
			src="com/stpl/pms/action/bo/reports/js/common_report.js"></script>
		<script>
		 $(document).ready(function(){
			 var adCompanyName='<s:property value="%{affiliateName}"/>';
			 console.log(adCompanyName);
			 setDefaultDate();
			 loadAliasName($("#domainId").val());
			 getOfferId(adCompanyName);
		$('#domainId').change(function() {
		if($("#domainId").val()=="0"){
				$('#aliasId').attr('disabled','true');
		}
		else{
				$('#aliasId').removeAttr('disabled');
				$("#aliasId").html("");
				loadAliasName($(this).val());
			}
		});
		function loadAliasName(domainId){
					var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+domainId,"");
					$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
					  $.each(aliasMap,function(index, value) {
	                        $('#aliasId').append($('<option></option>').val(index).html(value));
	                    });
			}

		 $("#aliasId").change(function(){
       	  $('#affiliateName').empty().append($('<option></option>').val("-1").html("----Please Select----"));
       	  if($(this).val()=="-1"){
       		  $('#affiliateName').attr('disabled','true');
             }else{
                 if(adCompanyName!=''){
                	 getOfferId(adCompanyName);
                 }else{    
	                 $('#affiliateName').removeAttr('disabled');
	                 var affiliateNameList = _ajaxCallJson("com/stpl/pms/action/bo/misc/getAffilateName.action?domainId="+$("#domainId").val()+"&aliasId="+$("#aliasId").val(),"");
	                 if(affiliateNameList){
	                     $("#affiliateNameDiv").show();
	                     $.each(affiliateNameList,function(index,value) {
	                         $('#affiliateName').append($('<option></option>').val(value).html(value));
	                     });
	                 }else{
	               	  $("#affiliateNameDiv").hide();
						  alert("Affilate Ad Company is not available for selected option");  
	               	  
	                  }
                 }    
             }

        } );

	      $("#affiliateName").change(function(){
	     	  $('#offerId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
	     	  if($(this).val()!="-1"){              
	     		 getOfferId($(this).val());
	           }else{
	        	   $('#offerId').empty().append($('<option></option>').val("-1").html("----Please Select----"));	
		       }
	
	     	 } );
		
		});

		function getOfferId(adCompany){
			 $('#offerId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
			if(adCompany!=''){
				var offerIdList = _ajaxCallJson("com/stpl/pms/action/bo/misc/getOfferIdForAffilateName.action?domainId="+$("#domainId").val()+"&aliasId="+$("#aliasId").val()
	           			+"&affiliateName="+adCompany,"");
				   
				   if(offerIdList){
				         $.each(offerIdList,function(index,value) {
				             $('#offerId').append($('<option></option>').val(value).html(value));
				         });
				   }
			}     
		}
		function setParam(){
					   
		        $("#redirect").val("Excel");
		        $("#playerSearchFrm").removeAttr("target");
		        $("#playerSearchFrm").submit();
		    
		}		
		</script>
	</head>

	<body>
		<div class="FormSection">

			<div class="greyStrip">
				<h4>
					Ad Company Report
				</h4>
			</div>
			<s:form id="playerSearchFrm" action="st_pms_bo_rep_AffilateSearchReport"
				cssClass="jsonFrmNew" target="searchResult" theme="simple" name="misSearchForm">
				<s:hidden name="reportData" id="reportData"></s:hidden>
				<s:hidden name="startIndex" id="startIndex" value="0"></s:hidden>
				<s:hidden name="recordTofetch" id="recordTofetch" value="101"></s:hidden>	
				<s:hidden name="redirect" id="redirect" value="Search"></s:hidden>		
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
									<s:hidden  value="%{domainId}" id="domainId"></s:hidden>
									<s:property value="%{domainName}"/>
								</s:if>
								<s:else>
									<s:select theme="myTheme" cssClass="select1"
										list="%{domainMap}"
										id="domainId" headerKey="-1"
										headerValue="--Please Select--" listKey="%{key}"
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
								Affiliate ID
							</label>
						</div>
						<div class="InputDivHalf">
						
								<s:if test="%{affiliateName ==null}">
									<s:select theme="myTheme" cssClass="select1" name="affiliateName"
	                             		 id="affiliateName"  applyScript="true"
	                             		 list="{}" headerKey="-1" headerValue="--Please Select--"></s:select>
								</s:if>
								<s:else>
									<s:hidden  value="%{affiliateName}" id="affiliateName" requestParam="YES"></s:hidden>
									<s:property value="%{affiliateName}"/>
								</s:else>
							
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Offer ID
							</label>
						</div>
						<div class="InputDivHalf">
							<s:select theme="myTheme" cssClass="select1" name="offerId"
	                              id="offerId"  applyScript="true"
	                              list="{}" headerKey="-1" headerValue="--Please Select--"></s:select>
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
					
					
				</div>
				<div class="box_footer" align="right">
				<div id="waitDiv" class="animated-button-div" style="margin-left: 0px; display: none;" >
					<div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
				</div>
					<s:submit name="Search" value="Search" id="searchButton" cssClass="button"></s:submit>
					 <ss:button name="Download" id="download" value="Download Excel"
                       onclick="setParam()" cssClass="button"></ss:button>
				</div>
				
			</s:form>
		</div>
		<div id="searchResult">

		</div>
	</body>
</html>
