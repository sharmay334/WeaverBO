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

    <title>Add Affiliate</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <script type="text/javascript">
        $(document).ready(function(){
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

            $("#affilateOption").change(function(){
					if($(this).val()=="DEPOSIT"){
						$("#rakePerDiv").hide();
						$("#rakePercentage").removeAttr('applyscript');
					}else{
						$("#rakePerDiv").show();
						$("#rakePercentage").attr('applyscript','true');
					}		
              })

        });


    </script>
</head>

<body>
<s:form id="addAffiliateSearchFrm" theme="simple" action="add_Affilate_AdCompany_Save">
	<s:token name="strutsToken" id="strutsToken"></s:token>
    <div class="FormSection">

        <div class="greyStrip">
            <h4>Add Affiliate</h4>
        </div>
        <div class="innerBox">
            <div class="FormMainBox">
                <div class="labelDiv">
                    <label> Domain Name </label><em class="Req">*</em>
                </div>
                <div class="InputDiv">
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
                <div class="InputDiv">
                    <s:select theme="myTheme" cssClass="select1" name="aliasId"
                              list="%{aliasMap}" id="aliasId" headerKey="-1" applyScript="true"
                              headerValue="--Please Select--" ></s:select>
                </div>
            </div>
            <div class="clearFRM"></div>
            <div class="FormMainBox">
                <div class="labelDiv">
                    <label> Affiliate Name </label> <em class="Req">*</em>
                </div>
                <div class="InputDivHalf">
                    <ss:textfield id="affiliateName" name="affiliateName" theme="myTheme"
                                  applyScript="true" style="width:51%;" maxLength="50"></ss:textfield>
                </div>
            </div>
            <div class="clearFRM"></div>
            <div class="FormMainBox">
                <div class="labelDiv">
                    <label> Offer Id </label>  <em class="Req">*</em>
                </div>
                <div class="InputDivHalf">
                    <ss:textfield id="offerId" name="offerId" theme="myTheme"
                                  applyScript="true" style="width:51%;" maxLength="6" pattern="^[a-zA-Z0-9_]+$" errorMassage="Special Character is not allowed"></ss:textfield>
                </div>
            </div>
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
            <div class="clearFRM"></div>
            <div id="rakePerDiv" class="FormMainBox">
                <div class="labelDiv">
                    <label> Rake Percentage </label>
                </div>
                <div class="InputDivHalf">
                    <ss:textfield id="rakePercentage" name="rakePercentage" theme="myTheme"
                                  applyScript="true" style="width:51%;" maxLength="5" max="100" pattern="^[0-9.]+$" errorMassage="Please insert in correct format"></ss:textfield>
                </div>
            </div>
          
            


        </div>
        <div class="box_footer" align="right">
            <div id="waitDiv" class="animated-button-div" style="margin-left: 0px; display: none;" >
                <div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
            </div>
            <s:submit name="Search" value="Submit" id="searchButton" cssClass="button"></s:submit>
           
        </div>
        </div>
        </s:form>
    
   
<div id="searchResult">

</div>
</body>
</html>
