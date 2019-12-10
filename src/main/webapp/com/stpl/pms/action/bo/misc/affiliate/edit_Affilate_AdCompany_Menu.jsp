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

    <title>Edit Affiliate Info</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <script type="text/javascript">
        $(document).ready(function(){
            $("#resultDiv").hide();
            var domainId=$("#domainId").val();
			
            
            $('#domainId').change(function(){
                $('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
                if($(this).val()=="-1")
                    $('#aliasId').attr('disabled','true');
                else{
                    $('#aliasId').removeAttr('disabled');
                    var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
                    $.each(aliasMap,function(index, value) {
                        $('#aliasId').append($('<option></option>').val(index).html(value));
                    });
                }
            });

            $("#aliasId").change(function(){
            	  $('#affiliateName').empty().append($('<option></option>').val("-1").html("----Please Select----"));
            	  if($(this).val()=="-1"){
            		  $('#affiliateName').attr('disabled','true');
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

             } );

            $("#affiliateName").change(function(){
          	  $('#offerId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
          	  if($(this).val()=="-1"){
          		  $('#offerId').attr('disabled','true');
                }else{
                    $('#offerId').removeAttr('disabled');
                    var offerIdList = _ajaxCallJson("com/stpl/pms/action/bo/misc/getOfferIdForAffilateName.action?domainId="+$("#domainId").val()+"&aliasId="+$("#aliasId").val()
                            			+"&affiliateName="+$("#affiliateName").val(),"");
                    debugger;
                    if(offerIdList){
	                      $("#offerDiv").show();
	                      $.each(offerIdList,function(index,value) {
	                          $('#offerId').append($('<option></option>').val(value).html(value));
	                      });
                    }else{
                  	  $("#offerDiv").hide();
						  alert("Offer id is not available for selected option");  
                  	  
                     }   
                }

           } );


            $("#offerId").change(function(){            	
            	  if($(this).val()=="-1"){
            		  $(".box_footer").hide();
            		  $("#rakePerDiv").hide();
            		  $("#commissionDiv").hide();
            		  $("#statusDiv").hide();
                  }else{
                      
                       $("#commissionDiv").show();
                       $(".box_footer").show();
                       $("#statusDiv").show(); 
                      var affilateInfo = _ajaxCallJson("com/stpl/pms/action/bo/misc/getAffilateInfo.action?domainId="+$("#domainId").val()+"&aliasId="+$("#aliasId").val()
                    		  +"&affiliateName="+$("#affiliateName").val()+"&offerId="+$("#offerId").val(),"");
                     	$("#affilateOption").val(affilateInfo.affiliateOption);
                     	$("#rakePercentage").val(affilateInfo.rakePercentage);
                     	$("#status").val(affilateInfo.status);
                     	$("#affilateInfoId").val(affilateInfo.affilateId);
                        commissionOptChange(affilateInfo.affiliateOption);
                  }

             } );  

            $("#affilateOption").change(function(){
            	commissionOptChange($(this).val());
              });

        });
	function commissionOptChange(commissionOptVal){
		if(commissionOptVal=="DEPOSIT"){
			$("#rakePerDiv").hide();
			$("#rakePercentage").removeAttr('applyscript');
		}else{
			$("#rakePerDiv").show();
			$("#rakePercentage").attr('applyscript','true');
		}		
	}

    </script>
</head>

<body>
<s:form id="editAffiliateFrm" theme="simple" action="editAffilate_AdCompany">
	<s:token name="strutsToken" id="strutsToken"></s:token>
	<s:hidden name="affilateInfoId" id="affilateInfoId"></s:hidden>
    <div class="FormSection">

        <div class="greyStrip">
            <h4>Edit Affiliate Info.</h4>
        </div>
        <div class="innerBox">
            <div class="FormMainBox">
                <div class="labelDiv">
                    <label> Domain Name </label><em class="Req">*</em>
                </div>
                <div class="InputDivHalf">
                    <s:if test="%{domainId>1 }">
                        <s:hidden name="domainId" value="%{domainId}" id="domainId"></s:hidden>
                        <s:property value="%{domainName}" />
                    </s:if>
                    <s:else>
                        <s:select theme="myTheme" cssClass="select1" name="domainId"
                                  list="%{domainMap}" id="domainId" headerKey="-1"
                                  headerValue="--Please Select--" listKey="%{key}"
                                  listValue="%{value}" value="%{bydefaultSelectedDomain}" applyscript="true"></s:select>
                    </s:else>
                </div>
            </div>
            <div class="clearFRM"></div>
            <div class="FormMainBox">
                <div class="labelDiv">
                    <label> Alias Name </label> <em class="Req">*</em>
                </div>
                <div class="InputDivHalf">
                    <s:select theme="myTheme" cssClass="select1" name="aliasId"
                              list="%{aliasMap}" id="aliasId" headerKey="-1" applyScript="true"
                              headerValue="--Please Select--" ></s:select>
                </div>
            </div>
            <div  id="affiliateNameDiv" style="display:none;" >
	            <div class="clearFRM"></div>
	            <div class="FormMainBox">
	                <div class="labelDiv">
	                    <label> Affiliate Name </label> <em class="Req">*</em>
	                </div>
	                <div class="InputDivHalf">
	                     <s:select theme="myTheme" cssClass="select1" name="affiliateName"
	                              id="affiliateName"  applyScript="true"
	                              list="{}" headerKey="-1" headerValue="--Please Select--"></s:select>
	                </div>
	            </div>
	         </div>   
            <div  id="offerDiv" style="display:none;" >
	            <div class="clearFRM"></div>
	            <div class="FormMainBox">
	                <div class="labelDiv">
	                    <label> Offer Id </label> <em class="Req">*</em>
	                </div>
	                <div class="InputDivHalf">
	                     <s:select theme="myTheme" cssClass="select1" name="offerId"
	                              id="offerId"  applyScript="true"
	                              list="{}" headerKey="-1" headerValue="--Please Select--"></s:select>
	                </div>
	            </div>
	         </div>
	         <div id="commissionDiv" style="display:none;">   
	             <div class="clearFRM"></div>
	            <div class="FormMainBox">
	                <div class="labelDiv">
	                    <label> Commission Option </label>
	                </div>
	                <div class="InputDiv">
	                    <s:select theme="myTheme" cssClass="select1" name="affilateOption"
	                              id="affilateOption"  applyScript="true"
	                              list="{'DEPOSIT','RAKE'}" headerKey="-1" headerValue="--Please Select--"></s:select>
	                </div>
	            </div>
	          </div>
	         <div id="rakePerDiv" style="display:none;">       
	            <div class="clearFRM"></div>
	            <div  class="FormMainBox">
	                <div class="labelDiv">
	                    <label> Rake Percentage </label>
	                </div>
	                <div class="InputDivHalf">
	                    <ss:textfield id="rakePercentage" name="rakePercentage" theme="myTheme"
	                                  applyScript="true" style="width:51%;" maxLength="5" max="100" pattern="^[0-9.]+$" errorMassage="Please insert in correct format"></ss:textfield>
	                </div>
	            </div>
	         </div> 
	         
	        <div id="statusDiv" style="display:none;">   
	            <div class="clearFRM"></div>
	            <div class="FormMainBox">
	                <div class="labelDiv">
	                    <label> Status  </label>
	                </div>
	                <div class="InputDiv">
	                    <s:select theme="myTheme" cssClass="select1" name="status"
	                              id="status"  applyScript="true"
	                              list="{'ACTIVE','INACTIVE'}" headerKey="-1" headerValue="--Please Select--"></s:select>
	                </div>
	            </div>
	          </div>
            


        </div>
        <div class="box_footer" align="right" style="display:none;">
            <div id="waitDiv" class="animated-button-div" style="margin-left: 0px; display: none;" >
                <div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
            </div>
            <s:submit name="Search" value="Submit" id="searchButton" cssClass="button"></s:submit>
        </div>
        </div>
        </s:form>   
   			
</body>
</html>
