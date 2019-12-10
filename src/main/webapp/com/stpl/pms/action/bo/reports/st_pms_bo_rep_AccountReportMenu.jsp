<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1" %>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
    String path = request.getContextPath();
    String basePath = (String) request.getAttribute("basePathURL");
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <%
        String realpaths = request.getAttribute("javax.servlet.forward.request_uri").toString();
        int index = realpaths.lastIndexOf('/');
        realpaths = realpaths.substring(0, index);

    %>

    <title>Accounting Report</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <link href="css/facebox_bigsize.css" media="screen" rel="stylesheet"
          type="text/css"/>
    <link href="css/jquery.dataTables.css" rel="stylesheet" type="text/css"/>
    <link href="css/jquery.dataTables.mis.css" rel="stylesheet"
          type="text/css"/>
    <script src="js/facebox.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/datatable/jquery.dataTables.js"></script>
    <script type="text/javascript"
            src="com/stpl/pms/action/bo/reports/js/common_report.js"></script>
    <script type="text/javascript"
            src="com/stpl/pms/action/bo/reports/js/MisReport.js"></script>
    <script type="text/javascript"
            src="<%=path%>/js/multiselect/chosen.jquery.js"></script>
    <script type="text/javascript"
            src="com/stpl/pms/action/bo/reports/js/mis_report_pagination.js"></script>

<style>
#forstatewise{
    display: none;
}
#textState{
    display: none;}
</style>
    <script>

        $(document).ready(function () {
            var firstYear=2013;
            var dt = new Date();
            var current=dt.getFullYear();
            var currentmonth=dt.getMonth();

            var currentYear=current;

            var finalloop=current-firstYear;
            $('#financialyear').empty().append($('<option></option>').val("-1").html("--Please Select--"));
            for(var a=0;a<finalloop;a++){

            if(currentmonth>2&&currentYear==current)
                $('#financialyear').append($('<option></option>').val(current+"-"+(current+1)).html(current+"-"+(current+1)));
            else if(currentYear!=current)
                $('#financialyear').append($('<option></option>').val(current+"-"+(current+1)).html(current+"-"+(current+1)));
                current=current-1;

            }


            $('#financialyear').append($('<option></option>').val(current+"-"+(current+1)).html(current+"-"+(current+1)));
            $("#aliasId").change(function(){

                $('#forstatewise').hide();
            });
            $("#financialyear").change(function () {
                var monthNames = [ "April", "May", "June",
                    "July", "August", "September", "October", "November", "December","January", "February", "March"
                ];
                var montharr;
                var d = new Date();
                var currentYear=dt.getFullYear();
                var monthvalue=d.getMonth();
               var fyear= $(this).val();

               if(currentYear+"-"+(currentYear+1)==fyear) {
                   if (monthvalue > 3) {
                       montharr = monthNames.slice(0, (monthvalue - 3));
                   } else {
                       montharr = monthNames.slice(0, (monthvalue + 9));
                   }
               }else if(((currentYear-1)+"-"+currentYear)==fyear){
                   if (monthvalue < 3) {
                       montharr = monthNames.slice(0, (monthvalue - 3));
                   }else{
                       montharr=monthNames;
                   }
               }
               else{
                   montharr=monthNames;
               }

                    $('#taxmonthwise').empty().append($('<option></option>').val("-1").html("--Please Select--"));
                    var monthVal=["04","05","06","07","08","09","10","11","12","01","02","03"];
                    for(var a=0;a<montharr.length;a++){
                        $('#taxmonthwise').append($('<option></option>').val(monthVal[a]).html(montharr[a]));
                    }



            });


    });
        function showStates(){
            if(document.getElementById("taxreportwiseSTATEWISE").checked==true){
                $('#textState').show();
            }
            else{
                $('#textState').hide();
            }

        }
        function callAction(cond) {

            if ($("#proceName").val() == 'dailyRakeAndRoyaltyForAlias') {
                $("#procName").remove();
                $("#playerSearchFrm").attr("action", "<%=realpaths%>/st_pms_bo_rep_dailyRakeWithRoyalty.action");
                $('#forstatewise').hide();
                $('#download').hide();
                $('#defaultDateFilter').show();


            }
            else if ( $("#proceName").val() == 'StateWiseReport' ) {
                $("#procName").remove();
                $("#proceName").after('<input type="hidden"  name="procName" id="procName" value="StateWiseReport">');
                $("#playerSearchFrm").attr("action", "<%=realpaths%>/st_pms_bo_rep_searchReport.action");
                  if ($("#whatToGet").val() == 'StateWiseRakeForAlias') {
                		$("#procName").val('StateWiseRakeForAlias');
				} else {
					$("#procName").val('StateWiseReport');
				}


                $('#forstatewise').show();
                $('#download').show();
                $('#defaultDateFilter').show();



            }
            else if($("#proceName").val() == 'itPlayerWise'){
                $("#procName").remove();

                $("#playerSearchFrm").attr("action", "<%=realpaths%>/st_pms_bo_rep_searchTaxPlayerWiseReport.action");
                $('#forstatewise').hide();
                $('#defaultDateFilter').hide();
                $('#download').show();
                if(cond=='1'){
                getStateTaxReport();
                }
            }
            else {
                $("#procName").remove();
                $("#playerSearchFrm").attr("action", "<%=realpaths%>/st_pms_bo_rep_searchMISReport.action");
                $('#forstatewise').hide();
                $('#download').show();
                $('#defaultDateFilter').show();

            }

        }
					$(document).on('change', '#whatToGet', function() {
						if ($("#whatToGet").val() == 'StateWiseRakeForAlias') {
							$("#procName").val('StateWiseRakeForAlias');
						} else {
							$("#procName").val('StateWiseReport');
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

    <s:form id="playerSearchFrm" action=""
            cssClass="jsonFrmMisReport" theme="simple" name="misSearchForm"
            callBack="convertDataTable()" enctype="multipart/form-data">
        <s:hidden name="reportData" id="reportData"></s:hidden>
        <s:hidden name="reportTypeName" id="reportTypeName"></s:hidden>
        <s:hidden name="redirect" id="redirect" value="Search"></s:hidden>
        <s:hidden name="startIndex" id="startIndex" value="0"></s:hidden>
        <%--<s:hidden name="procName" id="procName" value="StateWiseReport"></s:hidden>--%>
        <s:hidden name="recordTofetch" id="recordTofetch" value="101"></s:hidden>

        <div class="innerBox">
            <div class="FormMainBox">
                <div class="small-text-box-section">
                    <div class="div-5 din-5-new">
                        <div class="lbl-name-div-misReport line-ht">Domain</div>

                        <div class="small-text-box-div">
                            <s:if test="%{domainId>1}">
                                <s:hidden name="domainId" value="%{domainId}" id="domainId"
                                          cssClass="select2 commonFilter"></s:hidden>
                                <s:property value="%{domainName}"/>
                            </s:if>
                            <s:else>
                                <s:select theme="myTheme" cssClass="select2 commonFilter"
                                          list="%{domainMap}" name="domainId" id="domainId"
                                          headerKey="0" headerValue="--Please Select--" listKey="%{key}"
                                          value="%{bydefaultSelectedDomain}" listValue="%{value}"
                                          cssStyle="width: 210px">
                                </s:select>
                            </s:else>
                        </div>
                    </div>

                    <div class="div-5 din-5-new">
                        <div class="lbl-name-div-misReport txt-rt line-ht">Alias<em class="Req">*</em>
                        </div>

                        <div class="small-text-box-div">
                            <s:select name="aliasId" id="aliasId"
                                      list="{}" headerKey="-1"
                                      headerValue="--Please Select--" cssClass="commonFilter"
                                      onChange="getAccountReportTypeAliasWise();"
                                      cssStyle="width: 180px"/>
                        </div>

                    </div>
                    <div class="div-5 din-5-new	">
                        <div class="lbl-name-div-misReport txt-rt line-ht">Report Type<em class="Req">*</em></div>
                        <div class="small-text-box-div">
                            <s:select name="proceName" id="proceName"
                                      list="{}" headerKey="-1"
                                      headerValue="--Please Select--" cssClass="commonFilter"
                                      cssStyle="width: 180px" onchange="callAction('1')"/>
                        </div>

                    </div>
                </div>
            </div>
            <div class="clearFRM"></div>
            <div class="FormMainBox" id="defaultDateFilter">
                <div class="small-text-box-section">

                    <div class="div-5 din-5-new">
                        <div class="lbl-name-div-misReport line-ht" id="fromDateField">
                            From Date
                        </div>

                        <div class="small-text-box-div">
                            <ss:textfield id="fromDate" name="fromDate"
                                          cssClass="dateField commonFilter" theme="myTheme"
                                          readonly="true"></ss:textfield>
                        </div>
                    </div>
                    <div class="div-5 din-5-new">
                        <div class="lbl-name-div-misReport line-ht" id="toDateField">To
                            Date
                        </div>

                        <div class="small-text-box-div">
                            <ss:textfield id="toDate" name="toDate"
                                          cssClass="dateField commonFilter" theme="myTheme"
                                          readonly="true"></ss:textfield>
                        </div>
                    </div>

                    <div class="div-5 din-5-new" id="forstatewise">

                        <div class="lbl-name-div-misReport txt-rt line-ht">StateWise</div>
                        <div class="small-text-box-div">
                            <s:select name="whatToGet" id="whatToGet"
                                      list="#{'registration':'Registration','firstDep':'First Depositor','totalWager':'Total Wager & Winning','totalDeposit':'Total Deposit','StateWiseRakeForAlias':'GST/IGST'}"  headerKey="-1"
                                      headerValue="--Please Select--" cssClass="commonFilter"
                                      cssStyle="width: 180px" />
                        </div>


                    </div>


                </div>
            </div>



            <div id="MisDepositAndWithdrawal" style="display: none"
                 class="reportFilter">
                <div class="clearFRM"></div>
                <div class="FormMainBox">
                    <div class="small-text-box-section">
                        <div class="div-5" style="width: 340px;margin-left: 0PX;">
                            <div class="lbl-name-div-misReport">Transaction</div>
                            <div class="small-text-box-div" style="width: 240px;">
                                <s:radio id="tranType" name="tranType"
                                         list="#{'DEPOSIT':'DEPOSIT','WITHDRAWAL':'WITHDRAWAL','Both':'Both'}"
                                         theme="myTheme" value="%{'Both'}"
                                         cssClass="MisDepositAndWithdrawal"/>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="clearFRM"></div>
                <div class="FormMainBox">
                    <div class="small-text-box-section">
                        <div class="div-5">
                            <div class="lbl-name-div-misReport">Profile Status</div>

                            <div class="small-text-box-div">
                                <s:checkboxlist id="profileStatus" name="profileStatus"
                                                list="#{'plrMini':'MINI','plrFull':'FULL'}"
                                                cssClass="MisDepositAndWithdrawal" theme="myTheme"></s:checkboxlist>
                            </div>
                        </div>
                        <div class="div-5">
                            <div class="lbl-name-div-misReport">Player Status</div>
                            <div class="small-text-box-div">
                                <s:checkboxlist id="playerStatus" name="playerStatus"
                                                list="#{'plrActive':'ACTIVE','plrInactive':'INACTIVE'}"
                                                cssClass="MisDepositAndWithdrawal" theme="myTheme"></s:checkboxlist>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="clearFRM"></div>
                <div class="FormMainBox">
                    <div class="small-text-box-section">
                        <div class="div-5">
                            <div class="lbl-name-div-misReport" style="width: 100px;">
                                Deposit Amount
                            </div>
                            <div class="small-text-box-div-new">

                                <ss:textfield name="minimumDepAmt" id="minimumDepAmt"
                                              theme="myTheme" cssStyle="width:150px"
                                              pattern="^[0-9]*\.?[0-9]*$"
                                              errorMassage="Enter Value in correct format."
                                              placeholder="Minimum" patternOn="blur"
                                              cssClass="text-field-small">
                                </ss:textfield>
                                <ss:textfield name="maximumDepAmt" id="maximumDepAmt"
                                              theme="myTheme" cssStyle="width:150px; margin-left:8px"
                                              pattern="^[0-9]*\.?[0-9]*$"
                                              errorMassage="Enter Value in correct format."
                                              placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
                            </div>
                        </div>
                        <div class="div-5">
                            <div class="lbl-name-div-misReport" style="width: 100px;">
                                Withdrawal Amount
                            </div>
                            <div class="small-text-box-div-new">
                                <ss:textfield name="minimumWithAmt" id="minimumWithAmt"
                                              theme="myTheme" cssStyle="width:150px"
                                              pattern="^[0-9]*\.?[0-9]*$"
                                              errorMassage="Enter Value in correct format."
                                              placeholder="Minimum" patternOn="blur"
                                              cssClass="text-field-small">
                                </ss:textfield>
                                <ss:textfield name="maximumWithAmt" id="maximumWithAmt"
                                              theme="myTheme" cssStyle="width:150px; margin-left:8px"
                                              pattern="^[0-9]*\.?[0-9]*$"
                                              errorMassage="Enter Value in correct format."
                                              placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clearFRM"></div>
                <div class="FormMainBox">
                    <div class="small-text-box-section">
                        <div class="div-5">
                            <div class="lbl-name-div-misReport" style="width: 100px;">
                                First Deposit date
                            </div>
                            <div class="small-text-box-div-new">
                                <s:textfield name="fromDateFirstDep" id="fromDateFirstDep"
                                             readonly="true" placeholder="From Date"
                                             cssClass="text-field-small" cssStyle="width:150px"></s:textfield>
                                <s:textfield name="toDateFirstDep" id="toDateFirstDep"
                                             readonly="true" placeholder="To Date"
                                             cssClass="text-field-small"
                                             cssStyle="width:150px; margin-left:8px"></s:textfield>
                            </div>
                        </div>
                        <div class="div-5">
                            <div class="lbl-name-div-misReport" style="width: 100px;">
                                Last Deposit Date
                            </div>
                            <div class="small-text-box-div-new">
                                <s:textfield name="fromDateLastDep" id="fromDateLastDep"
                                             readonly="true" placeholder="From Date"
                                             cssClass="text-field-small" cssStyle="width:150px"></s:textfield>
                                <s:textfield name="toDateLastDep" id="toDateLastDep"
                                             readonly="true" placeholder="To Date"
                                             cssClass="text-field-small"
                                             cssStyle="width:150px; margin-left:8px"></s:textfield>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clearFRM"></div>
                <div class="FormMainBox">
                    <div class="small-text-box-section">
                        <div class="div-5">
                            <div class="lbl-name-div-misReport" style="width: 100px;">
                                First Withdrawal Date
                            </div>
                            <div class="small-text-box-div-new">
                                <s:textfield name="fromDateFirstWith" id="fromDateFirstWith"
                                             readonly="true" placeholder="From Date"
                                             cssClass="text-field-small" cssStyle="width:150px"></s:textfield>
                                <s:textfield name="toDateFirstWith" id="toDateFirstWith"
                                             readonly="true" placeholder="To Date"
                                             cssClass="text-field-small"
                                             cssStyle="width:150px; margin-left:8px"></s:textfield>
                            </div>
                        </div>
                        <div class="div-5">
                            <div class="lbl-name-div-misReport" style="width: 100px;">
                                Last Withdrawal Date
                            </div>
                            <div class="small-text-box-div-new">
                                <s:textfield name="fromDateLastWith" id="fromDateLastWith"
                                             readonly="true" placeholder="From Date"
                                             cssClass="text-field-small" cssStyle="width:150px"></s:textfield>
                                <s:textfield name="toDateLastWith" id="toDateLastWith"
                                             readonly="true" placeholder="To Date"
                                             cssClass="text-field-small"
                                             cssStyle="width:150px; margin-left:8px"></s:textfield>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="clearFRM"></div>
                <div class="FormMainBox">
                    <div class="small-text-box-section">
                        <div class="div-5">
                            <div class="lbl-name-div-misReport" style="width: 100px;">
                                Last Deposit Amount
                            </div>
                            <div class="small-text-box-div-new">
                                <ss:textfield name="minimumLastDepAmt" id="minimumLastDepAmt"
                                              theme="myTheme" cssStyle="width:150px"
                                              pattern="^[0-9]*\.?[0-9]*$"
                                              errorMassage="Enter Value in correct format."
                                              placeholder="Minimum" patternOn="both"
                                              cssClass="text-field-small">
                                </ss:textfield>
                                <ss:textfield name="maximumLastDepAmt" id="maximumLastDepAmt"
                                              theme="myTheme" cssStyle="width:150px; margin-left:8px"
                                              pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
                                              errorMassage="Enter Value in correct format."
                                              placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
                            </div>
                        </div>
                        <div class="div-5">
                            <div class="lbl-name-div-misReport" style="width: 100px;">
                                Last Withdrawal Amount
                            </div>
                            <div class="small-text-box-div-new">
                                <ss:textfield name="minimumLastWithAmt" id="minimumLastWithAmt"
                                              theme="myTheme" cssStyle="width:150px"
                                              pattern="^[0-9]*\.?[0-9]*$" patternOn="both"
                                              errorMassage="Enter Value in correct format."
                                              placeholder="Minimum" patternOn="both"
                                              cssClass="text-field-small">
                                </ss:textfield>
                                <ss:textfield name="maximumLastWithAmt" id="maximumLastWithAmt"
                                              theme="myTheme" cssStyle="width:150px; margin-left:8px"
                                              pattern="^[0-9]*\.?[0-9]*$"
                                              errorMassage="Enter Value in correct format."
                                              placeholder="Maximum" cssClass="text-field-small"></ss:textfield>
                            </div>
                        </div>
                    </div>
                </div>

            </div>


            <div id="itPlayerWise" style="display: none"
                 class="reportFilter">
                <div class="clearFRM"></div>
                <div class="FormMainBox">
                    <div class="small-text-box-section">
                        <div class="div-5">
                            <div class="lbl-name-div-misReport">FinancialYear<em class="Req">*</em></div>

                            <div class="small-text-box-div">
                                <s:select name="financialyear" id="financialyear"
                                          list="#{}"  headerKey="-1"
                                          headerValue="--Please Select--" cssClass="MisDepositAndWithdrawal"
                                          cssStyle="width: 180px" />
                            </div>
                        </div>
                        <div class="div-5" id="textState">
                                <div class="lbl-name-div-misReport">State<em class="Req">*</em></div>
                            <div class="small-text-box-div">
                                <s:select name="taxstatewise" id="taxstatewise"
                                          list="#{}"  headerKey="-1"
                                          headerValue="--Please Select--" cssClass="MisDepositAndWithdrawal"
                                          cssStyle="width: 180px" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="clearFRM"></div>
                <div class="FormMainBox">
                    <div class="small-text-box-section">
                        <div class="div-5">
                            <div class="lbl-name-div-misReport">Month<em class="Req">*</em></div>

                            <div class="small-text-box-div">
                                <s:select name="taxmonthwise" id="taxmonthwise"
                                          list="#{}"  headerKey="-1"
                                          headerValue="--Please Select--" cssClass="MisDepositAndWithdrawal"
                                          cssStyle="width: 180px" />
                            </div>
                        </div>
                        <div class="div-5">
                            <%--<div class="lbl-name-div-misReport"></div>--%>
                            <div class="small-text-box-div">
                                <s:radio id="taxreportwise" name="taxreportwise"
                                         list="#{'STATEWISE':'StateWise','PLAYERWISE':'PlayerWise'}"
                                         theme="myTheme" value="%{'PLAYERWISE'}"
                                         onchange="showStates()"
                                         cssClass="MisDepositAndWithdrawal"/>
                            </div>
                        </div>
                    </div>
                </div>



            </div>


















        </div>

        <div class="box_footer" align="right" >
            <div id="waitDiv" class="animated-button-div" style="margin-left: 0px; display: none;">
                <div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
            </div>
            <s:submit name="Search" id="searchButtonMis" value="Search"
                      cssClass="button" onclick="callAction('2')"></s:submit>
            <ss:button name="Download" id="download" value="Download Excel"
                       onclick="setParam()" cssClass="button"></ss:button>
        </div>

    </s:form>
</div>
<div id="waitDivNext" class="animated-button-div" style="margin-left: 0px; display:none">
    <div class="animated-striped">Wait</div>
</div>
<div id="waitDivPrev" class="animated-button-div" style="margin-left: 0px;display:none">
    <div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
</div>
<div id="searchResult"></div>
</body>
</html>

