<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">
	<title>Search Data</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script>
        $(document).ready(function() {
            $('#waitDiv').hide();
            $('#searchButtons').show();
            $('#searchButtons').attr("disabled",false);
            fromAndToDate();
            $("#reportTablePPC").dataTable({
                "sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesActionMis.action',
                "sAjaxDataProp":"resultList",
                "sServerMethod": "POST",
                "scrollX": true,
                "deferRender": true,
                "pageLength" : 20,
                "bLengthChange" : false,
                "oLanguage" : {
                    "sInfo" : '',
                },
                "aaSorting":[],
                "aoColumnDefs": [{
                    "aTargets": [0],
                    "bVisible": false,
                }, {
                    "aTargets": [1],
                    "bVisible": false,
                },{
                    "aTargets": [6],
                    "bVisible": false,
                },{
                    "aTargets": [7],
                    "bVisible": false,
                },{
                    "aTargets": [10],
                    "bVisible": false,
                },{
                    "aTargets": [11],
                    "bVisible": false,
                },{
                    "aTargets": [13],
                    "bVisible": false,
                },{
                    "aTargets": [14],
                    "bVisible": false,
                },{
                    "aTargets": [8],
                    "mRender": function (data, type, full) {
                        if(data!="--")
                            if(full[0]=="0"&&full[2]=="<b>ALL</b>") {
                                if (full[8] < 101)
                                    return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerRegReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","emailVerified":"' + 'undefined' + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#startIndexSub").text() + '","' + 'recordTofetch":"' + full[8] + '"}  target=' + '"expandIt">' + data + '</a>';
                                else
                                    return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerRegReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","emailVerified":"' + 'undefined' + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#startIndexSub").text() + '","' + 'recordTofetch":"' + $("#rowCountSub").text() + '"}  target=' + '"expandIt">' + data + '</a>';

                            }else
                                return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerRegReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","emailVerified":"' + 'undefined' + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#startIndexSub").text() + '","' + 'recordTofetch":"' + $("#rowCountSub").text() + '"}  target=' + '"expandIt">' + data + '</a>';

                        else
                            return data;
                    }
                },{
                    "aTargets": [9],
                    "mRender": function (data, type, full) {
                        if(data==="0")
                            data="--";
                        if(data!="--")
                            if(full[0]=="0"&&full[2]=="<b>ALL</b>") {
                                if (full[9] < 101)
                                    return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerRegReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","emailVerified":"' + $('#email_verified').val() + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#startIndexSub").text() + '","' + 'recordTofetch":"' + full[9] + '"}  target=' + '"expandIt">' + data + '</a>';
                                else
                                    return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerRegReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","emailVerified":"' + $('#email_verified').val() + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#startIndexSub").text() + '","' + 'recordTofetch":"' + $("#rowCountSub").text() + '"}  target=' + '"expandIt">' + data + '</a>';
                            }else
                                return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerRegReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","emailVerified":"' + $('#email_verified').val() + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#startIndexSub").text() + '","' + 'recordTofetch":"' + $("#rowCountSub").text() + '"}  target=' + '"expandIt">' + data + '</a>';

						else
                            return data;
                    }
                },{
                    "aTargets": [12],
                    "mRender": function (data, type, full) {
                        if(data!="--")
                            if(full[0]=="0"&&full[2]=="<b>ALL</b>") {
                                if (full[12] < 101)
                                    return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerDepReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#startIndexSub").text() + '","' + 'recordTofetch":"' + full[12] + '"}  target=' + '"expandIt">' + data + '</a>';
                                else
                                    return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerDepReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#startIndexSub").text() + '","' + 'recordTofetch":"' + $("#rowCountSub").text() + '"}  target=' + '"expandIt">' + data + '</a>';
                            }
                            else
                                return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerDepReport&reportData={"domainId":'+$("#domainId").val()+',"campId":"'+full[1]+'","subCampId":"'+full[0] +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'campType":"'+$("#campType").val()+'","device":"'+$("#deviceType").val()+'","'+'startIndex":"'+$("#startIndexSub").text()+'","'+'recordTofetch":"'+$("#rowCountSub").text()+'"}  target='+'"expandIt">'+data+'</a>';
                        else
                            return data;
                    }
                },{
                    "aTargets": [15],
                    "mRender": function (data, type, full) {
                        if(data!="--")
                            return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampAppDownReport&reportData={"domainId":'+$("#domainId").val()+',"campId":"'+full[1]+'","subCampId":"'+full[0] +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'campType":"'+$("#campType").val()+'","'+'startIndex":"'+$("#startIndexSub").text()+'","'+'recordTofetch":"'+$("#rowCountSub").text()+'"} target='+'"expandIt">'+data+'</a>';
                        else
                            return data;
                    }
                }],
            });

            $(document).on("click", "[aria-controls='reportTablePPC'][data-dt-idx='5']:not(.next,.previous)", function(){
                if($("#rowCount").text()==101 && $("[aria-controls='reportTablePPC'][id='search']").val()==""){
                    $("#reportTablePPC_next").removeClass("disabled");
                    $("[aria-controls='reportTablePPC'][data-dt-idx='5']").addClass('nextCall');
                }
            });
            $(document).on("click", "[aria-controls='reportTablePPC'][data-dt-idx='1']:not(.next,.previous)", function(){
                if($("[aria-controls='reportTablePPC'][data-dt-idx='1']").text()>1)
                    $("#reportTablePPC_previous").removeClass("disabled");
                $("[aria-controls='reportTablePPC'][data-dt-idx='1']").addClass('prevCall');
            });
            $("#reportTablePPC_next").live('click', function(e) {
                if($("#rowCount").text()==101 && $("[aria-controls='reportTablePPC'][id='search']").val()==""){
                    $("#reportTablePPC_next").removeClass("disabled");
                }
                if($("#reportTablePPC_next").hasClass("disabled"))
                    return false;
                if($('.paginate_button.current').eq(0).attr("data-dt-idx")==4){
                    $("[aria-controls='reportTablePPC'][data-dt-idx='5']").removeClass('nextCall');
                    return false;
                }
                else if($('.paginate_button.current').eq(0).attr("data-dt-idx")<5){
                    $("[aria-controls='reportTablePPC'][data-dt-idx='5']").removeClass('nextCall');
                    return false;
                }
                else if($('.paginate_button.current').eq(0).attr("data-dt-idx")==5   && !($("[aria-controls='reportTablePPC'][data-dt-idx='5']").hasClass("nextCall") )){
                    $("[aria-controls='reportTablePPC'][data-dt-idx='5']").addClass('nextCall');
                    e.stopImmediatePropagation();
                    e.preventDefault();
                    return false;
                }
                if($("[aria-controls='reportTablePPC'][data-dt-idx='5']").hasClass("nextCall")  && !($("#reportTablePPC_next").hasClass("disabled"))) {
                    var start = parseInt($(
                            "#startIndex")
                            .val()) + 100 - 1 ;
                    flagPage = 0;
                    var nextPageStart = parseInt($('.paginate_button.current').eq(0).text())+1;
                    $("#nextPageStart").val(nextPageStart);
                    $('#startIndex').val(start);
                    x = document.getElementById("reportTablePPC_paginate").lastChild.innerHTML;
                    document.getElementById("reportTablePPC_paginate").lastChild.innerHTML=document.getElementById("waitDivNext").innerHTML;
                    $('#reportTablePPC_paginate > a:last-child').addClass('waitBtn');
                    $(".paginate_button").eq(0).css("pointer-events","none");
                    _ajaxCallJsonSynch(
                        "com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReportOnClick.action?reportData="
                        + $(
                            "#reportData")
                            .val().slice(0, -1)+',"proceName":"StCmsCampTracking"}'
                        + "&startIndex="
                        + $(
                            '#startIndex')
                            .val()
                        + "&recordTofetch="
                        + $(
                            "#recordTofetch")
                            .val(),
                        "",
                        function(response) {
                            displayDataofCampaign(response);


                        });
                }else
                    return false;
                e.stopImmediatePropagation();
                e.preventDefault();
            });
            $('#reportTablePPC_previous').live('click', function(e) {
                if($("[aria-controls='reportTablePPC'][data-dt-idx='1']").text()>1){
                    $("#reportTablePPC_previous").removeClass("disabled");
                }

                if($('.paginate_button.current').eq(0).attr("data-dt-idx")==2){
                    $("[aria-controls='reportTablePPC'][data-dt-idx='1']").removeClass('prevCall');
                    return false;
                }
                else if($('.paginate_button.current').eq(0).attr("data-dt-idx")>1){
                    $("[aria-controls='reportTablePPC'][data-dt-idx='1']").removeClass('prevCall');
                    return false;
                }
                else if($('.paginate_button.current').eq(0).attr("data-dt-idx")==1   && !($("[aria-controls='reportTablePPC'][data-dt-idx='1']").hasClass("prevCall") )){
                    $("[aria-controls='reportTablePPC'][data-dt-idx='1']").addClass('prevCall');
                    e.stopImmediatePropagation();
                    e.preventDefault();
                    return false;
                }

                if($("[aria-controls='reportTablePPC'][data-dt-idx='1']").hasClass("prevCall") && !($("#reportTablePPC_previous").hasClass("disabled"))) {
                    if( parseInt($("#startIndex").val())>0)
                        var start = parseInt($("#startIndex").val()) - 100 + 1;
                    var nextPageStart = parseInt($('.paginate_button.current').eq(0).text())-5;
                    $("#nextPageStart").val(nextPageStart);
                    $('#startIndex').val(start);
                    y = document.getElementById("reportTablePPC_paginate").firstChild.innerHTML;
                    document.getElementById("reportTablePPC_paginate").firstChild.innerHTML=document.getElementById("waitDivPrev").innerHTML;
                    $('#reportTablePPC_paginate > a:first-child').addClass('waitBtn');
                    $(".paginate_button").eq(0).css("pointer-events","none");
                    _ajaxCallJsonSynch(
                        "com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchMISReportOnClick.action?reportData="
                        +$(
                            "#reportData")
                            .val().slice(0, -1)+',"proceName":"StCmsCampTracking"}'
                        + "&startIndex="
                        + $(
                            '#startIndex')
                            .val()
                        + "&recordTofetch="
                        + $(
                            "#recordTofetch")
                            .val(),
                        "",
                        function(response) {
                            displayDataofCampaignPrev(response);
                        });
                }
                e.stopImmediatePropagation();
                e.preventDefault();
            });
            $(document).on('keyup', "[aria-controls='reportTablePPC'][id='search']", function(){
                if($(this).val()!=""){
                    var currentPageNum = 1;
                    $($("#reportTablePPC_paginate>span>.paginate_button")).each(function(){
                        $(this).text(currentPageNum);
                        $(this).addClass('search');
                        currentPageNum++;
                    });
                    $(".paginate_button").eq(0).css("pointer-events","auto");
                }else if($("[aria-controls='reportTablePPC'][data-dt-idx='1']").text()>1){
                    $("#reportTablePPC_previous").removeClass("disabled");
                    $("[aria-controls='reportTablePPC'][data-dt-idx='1']").addClass("prevCall");
                }
            });
            fromAndToDate();
        });
        function displayDataofCampaign(response) {
            var resultList = response;
			if($("#sumofreg").text()==="0")
                $('#sumofreg').text($('#sumofregvalue').text());

            if($("#sumofdep").text()==="0")
                $('#sumofdep').text($('#sumofdepvalue').text());

            if($("#sumofemailreg").text()==="0")
                $('#sumofemailreg').text($('#sumofemailregvalue').text());


            $("#rowCount").text(resultList.length);

            if(response[0][8]!=="--") {
                $('#sumofregvalue').text(response[0][8]);
                $("#sumofreg1").text($("#sumofreg").text());
                $("#sumofreg").text(parseInt($("#sumofreg").text()) + parseInt(response[0][8]));
                $('#sumofregpre').text(response[0][8]);
            }

			if(response[0][9]!=="--") {
                $('#sumofemailregvalue').text(response[0][9]);
                $("#sumofemailreg1").text($("#sumofemailreg").text());
                $("#sumofemailreg").text(parseInt($("#sumofemailreg").text()) + parseInt(response[0][9]));
                $('#sumofemailregpre').text(response[0][9]);
            }

            if(response[0][12]!=="--") {
                $('#sumofdepvalue').text(response[0][12]);
                $("#sumofdep1").text($("#sumofdep").text());
                $("#sumofdep").text(parseInt($("#sumofdep").text()) + parseInt(response[0][12]));
                $('#sumofdeppre').text(response[0][12]);
            }


            if ($("#rowCount").text() < 101){
                $("#reportTablePPC_next").addClass("disabled");}
            //	alert(response.size());
            var nextPage = $("#nextPageStart").val();

            jQuery('#reportTablePPC').dataTable().fnDestroy();
            $("#" + 'reportTablePPC')
                .DataTable(
                    {
                        "sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesActionMis.action',
                        "sAjaxDataProp" : "resultList",
                        "sServerMethod" : "POST",
                        "scrollX" : true,
                        "deferRender" : true,
                        "aaSorting" : [],
                        "pageLength" : 20,
                        "bLengthChange" : false,
                        "oLanguage" : {
                            "sInfo" : '',
                        },
                        "aoColumnDefs": [{
                            "aTargets": [0],
                            "bVisible": false,
                        }, {
                            "aTargets": [1],
                            "bVisible": false,
                        },{
                            "aTargets": [6],
                            "bVisible": false,
                        },{
                            "aTargets": [7],
                            "bVisible": false,
                        },{
                            "aTargets": [10],
                            "bVisible": false,
                        },{
                            "aTargets": [11],
                            "bVisible": false,
                        },{
                            "aTargets": [13],
                            "bVisible": false,
                        },{
                            "aTargets": [14],
                            "bVisible": false,
                        },{
                            "aTargets": [8],
                            "mRender": function (data, type, full) {
                                if(data!="--")
                                    if(full[0]=="0"&&full[2]=="<b>ALL</b>") {
                                    	if(full[8]<101)
                                        	return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerRegReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","emailVerified":"' + 'undefined' + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#sumofreg1").text() + '","' + 'recordTofetch":"' + full[8] + '"}  target=' + '"expandIt">' + data + '</a>';
										else
                                            return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerRegReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","emailVerified":"' + 'undefined' + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#sumofreg1").text() + '","' + 'recordTofetch":"' + $("#rowCountSub").text() + '"}  target=' + '"expandIt">' + data + '</a>';
                                	}
									else
                                        return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerRegReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","emailVerified":"' + 'undefined' + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#startIndexSub").text() + '","' + 'recordTofetch":"' + $("#rowCountSub").text() + '"}  target=' + '"expandIt">' + data + '</a>';

                                else
                                    return data;
                            }
                        },{
                            "aTargets": [9],
                            "mRender": function (data, type, full) {
                                if(data==="0")
                                    data="--";
                                if(data!="--")
                                    if(full[0]=="0"&&full[2]=="<b>ALL</b>") {
                                    	if(full[9]<101)
                                    	    return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerRegReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","emailVerified":"' + $('#email_verified').val() + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#sumofemailreg1").text() + '","' + 'recordTofetch":"' + full[9] + '"}  target=' + '"expandIt">' + data + '</a>';
										else
                                            return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerRegReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","emailVerified":"' + $('#email_verified').val() + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#sumofemailreg1").text() + '","' + 'recordTofetch":"' + $("#rowCountSub").text() + '"}  target=' + '"expandIt">' + data + '</a>';
                                	}else
                                        return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerRegReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","emailVerified":"' + $('#email_verified').val() + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#startIndexSub").text() + '","' + 'recordTofetch":"' + $("#rowCountSub").text() + '"}  target=' + '"expandIt">' + data + '</a>';

                                else
                                    return data;
                            }
                        },{
                            "aTargets": [12],
                            "mRender": function (data, type, full) {
                                if(data!="--")
                                    if(full[0]=="0"&&full[2]=="<b>ALL</b>")
                                        if(full[12]<101)
                                    		return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerDepReport&reportData={"domainId":'+$("#domainId").val()+',"campId":"'+full[1]+'","subCampId":"'+full[0] +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'campType":"'+$("#campType").val()+'","device":"'+$("#deviceType").val()+'","'+'startIndex":"'+$("#sumofdep1").text()+'","'+'recordTofetch":"'+full[12]+'"} target='+'"expandIt">'+data+'</a>';
                                    	else
                                            return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerDepReport&reportData={"domainId":'+$("#domainId").val()+',"campId":"'+full[1]+'","subCampId":"'+full[0] +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'campType":"'+$("#campType").val()+'","device":"'+$("#deviceType").val()+'","'+'startIndex":"'+$("#sumofdep1").text()+'","'+'recordTofetch":"'+$("#rowCountSub").text()+'"} target='+'"expandIt">'+data+'</a>';
                                    else
                                        return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerDepReport&reportData={"domainId":'+$("#domainId").val()+',"campId":"'+full[1]+'","subCampId":"'+full[0] +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'campType":"'+$("#campType").val()+'","device":"'+$("#deviceType").val()+'","'+'startIndex":"'+$("#startIndexSub").text()+'","'+'recordTofetch":"'+$("#rowCountSub").text()+'"} target='+'"expandIt">'+data+'</a>';
                                else
                                    return data;
                            }
                        },{
                            "aTargets": [15],
                            "mRender": function (data, type, full) {
                                if(data!="--")
                                    return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampAppDownReport&reportData={"domainId":'+$("#domainId").val()+',"campId":"'+full[1]+'","subCampId":"'+full[0] +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'campType":"'+$("#campType").val()+'","'+'startIndex":"'+$("#startIndexSub").text()+'","'+'recordTofetch":"'+$("#rowCountSub").text()+'"} target='+'"expandIt">'+data+'</a>';
                                else
                                    return data;
                            }
                        }],
                        //"searching" : false,
                        "bSort" : false,
                        "fnInitComplete": function( oSettings) {
                            $("#reportTablePPC_previous").removeClass("disabled");
                            $("[aria-controls='reportTablePPC'][data-dt-idx='1']").addClass('prevCall');
                            document.getElementById("reportTablePPC_paginate").lastChild.innerHTML = x;
                            $($("#reportTablePPC_paginate>span>.paginate_button")).each(function(){
                                $(this).text(nextPage);
                                nextPage++;
                            });
                        },
                        "fnDrawCallback" : function(oSettings) {
                            if($("[aria-controls='reportTablePPC'][id='search']").val()==""){
                                flagPage++;
                                if(flagPage < 3) {
                                    return false;
                                }
                                var currentPageNum = nextPage-$("#reportTablePPC_paginate>span>.paginate_button").length;
                                $($("#reportTablePPC_paginate>span>.paginate_button")).each(function(){
                                    $(this).text(currentPageNum);
                                    currentPageNum++;
                                });
                            }else if($('span:last').hasClass("current")){
                                $("#reportTablePPC_next").addClass("disabled");
                            }
                        }
                    });



            }

        function displayDataofCampaignPrev(response) {

			if(response[0][8]!=="--") {
                $("#sumofreg").text(Math.abs(parseInt($("#sumofreg").text()) - parseInt($("#sumofregpre").text())));
                $("#sumofreg").text(Math.abs(parseInt($("#sumofreg").text()) - parseInt(response[0][8])));
                $('#sumofregvalue').text(response[0][8]);
				$("#sumofreg1").text($("#sumofreg").text());
            }

            if(response[0][9]!=="--") {
                $("#sumofemailreg").text(Math.abs(parseInt($("#sumofemailreg").text()) - parseInt($("#sumofemailregpre").text())));
                $("#sumofemailreg").text(Math.abs(parseInt($("#sumofemailreg").text()) - parseInt(response[0][9])));
                $('#sumofemailregvalue').text(response[0][9]);
                $("#sumofemailreg1").text($("#sumofemailreg").text());
            }

            if(response[0][12]!=="--") {
                $("#sumofdep").text(Math.abs(parseInt($("#sumofdep").text()) - parseInt($("#sumofdeppre").text())));
                $("#sumofdep").text(Math.abs(parseInt($("#sumofdep").text()) - parseInt(response[0][12])));
                $('#sumofdepvalue').text(response[0][12]);
                $("#sumofdep1").text($("#sumofdep").text());
            }

            if ($("#rowCount").text() < 101)
                $("#reportTablePPC_next").addClass("disabled");
            var nextPage = $("#nextPageStart").val();
            jQuery('#reportTablePPC').dataTable().fnDestroy();
            $("#" + 'reportTablePPC')
                .DataTable(
                    {
                        "sAjaxSource" : 'com/stpl/pms/action/bo/reports/dataTablesActionMis.action',
                        "sAjaxDataProp" : "resultList",
                        "sServerMethod" : "POST",
                        "scrollX" : true,
                        "deferRender" : true,
                        "aaSorting" : [],
                        "pageLength" : 20,
                        "bLengthChange" : false,

                        "oLanguage" : {
                            "sInfo" : '',
                        },
                        "aoColumnDefs": [{
                            "aTargets": [0],
                            "bVisible": false,
                        }, {
                            "aTargets": [1],
                            "bVisible": false,
                        },{
                            "aTargets": [6],
                            "bVisible": false,
                        },{
                            "aTargets": [7],
                            "bVisible": false,
                        },{
                            "aTargets": [10],
                            "bVisible": false,
                        },{
                            "aTargets": [11],
                            "bVisible": false,
                        },{
                            "aTargets": [13],
                            "bVisible": false,
                        },{
                            "aTargets": [14],
                            "bVisible": false,
                        },{
                            "aTargets": [8],
                            "mRender": function (data, type, full) {
                                if (data != "--")
                                    if (full[0] == "0" && full[2] == "<b>ALL</b>") {
                                    	if(full[8]<101)
                                    		return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerRegReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","emailVerified":"' + 'undefined' + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#sumofreg1").text() + '","' + 'recordTofetch":"' + full[8] + '"}  target=' + '"expandIt">' + data + '</a>';
                                    	else
                                        	return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerRegReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","emailVerified":"' + 'undefined' + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#sumofreg1").text() + '","' + 'recordTofetch":"' + $("#rowCountSub").text() + '"}  target=' + '"expandIt">' + data + '</a>';
                                    }else
                                        return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerRegReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","emailVerified":"' + 'undefined' + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#startIndexSub").text() + '","' + 'recordTofetch":"' + $("#rowCountSub").text() + '"}  target=' + '"expandIt">' + data + '</a>';

                                else
                                    return data;
                            }
                        },{
                            "aTargets": [9],
                            "mRender": function (data, type, full) {
                                if(data==="0")
                                    data="--";
                                if(data!="--")
                                    if(full[0]=="0"&&full[2]=="<b>ALL</b>") {
                                    	if(full[9]<101)
                                    		return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerRegReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","emailVerified":"' + $('#email_verified').val() + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#sumofemailreg1").text() + '","' + 'recordTofetch":"' + full[9] + '"} target=' + '"expandIt">' + data + '</a>';
                                    	else
                                        	return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerRegReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","emailVerified":"' + $('#email_verified').val() + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#sumofemailreg1").text() + '","' + 'recordTofetch":"' + $("#rowCountSub").text() + '"} target=' + '"expandIt">' + data + '</a>';

                                    }else
                                        return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerRegReport&reportData={"domainId":' + $("#domainId").val() + ',"campId":"' + full[1] + '","subCampId":"' + full[0] + '","fromDate"' + ':"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0])) + '%20' + $("#fromDate").val().split(' ')[1] + '","' + 'toDate":"' + $.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0])) + '%20' + $("#toDate").val().split(' ')[1] + '","' + 'campType":"' + $("#campType").val() + '","emailVerified":"' + $('#email_verified').val() + '","device":"' + $("#deviceType").val() + '","' + 'startIndex":"' + $("#startIndexSub").text() + '","' + 'recordTofetch":"' + $("#rowCountSub").text() + '"} target=' + '"expandIt">' + data + '</a>';

                                else
                                    return data;
                            }
                        },{
                            "aTargets": [12],
                            "mRender": function (data, type, full) {
                                if(data!="--")
                                    if(full[0]=="0"&&full[2]=="<b>ALL</b>")
                                        if(full[12]<101)
                                    			return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerDepReport&reportData={"domainId":'+$("#domainId").val()+',"campId":"'+full[1]+'","subCampId":"'+full[0] +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'campType":"'+$("#campType").val()+'","device":"'+$("#deviceType").val()+'","'+'startIndex":"'+$("#sumofdep1").text()+'","'+'recordTofetch":"'+full[12]+'"}  target='+'"expandIt">'+data+'</a>';
                                			else
                                    			return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerDepReport&reportData={"domainId":'+$("#domainId").val()+',"campId":"'+full[1]+'","subCampId":"'+full[0] +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'campType":"'+$("#campType").val()+'","device":"'+$("#deviceType").val()+'","'+'startIndex":"'+$("#sumofdep1").text()+'","'+'recordTofetch":"'+$("#rowCountSub").text()+'"}  target='+'"expandIt">'+data+'</a>';

                                    	else
                                        	return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampPlayerDepReport&reportData={"domainId":'+$("#domainId").val()+',"campId":"'+full[1]+'","subCampId":"'+full[0] +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'campType":"'+$("#campType").val()+'","device":"'+$("#deviceType").val()+'","'+'startIndex":"'+$("#startIndexSub").text()+'","'+'recordTofetch":"'+$("#rowCountSub").text()+'"}  target='+'"expandIt">'+data+'</a>';
                                else
                                    return data;
                            }
                        },{
                            "aTargets": [15],
                            "mRender": function (data, type, full) {
                                if(data!="--")
                                    return '<a href=com/stpl/pms/action/bo/reports/st_pms_bo_rep_searchReport.action?procName=stCmsCampAppDownReport&reportData={"domainId":'+$("#domainId").val()+',"campId":"'+full[1]+'","subCampId":"'+full[0] +'","fromDate"'+':"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#fromDate").val().split(' ')[0]))+'%20'+ $("#fromDate").val().split(' ')[1]+'","'+'toDate":"'+$.datepicker.formatDate('yy-mm-dd', $.datepicker.parseDate('dd/mm/yy', $("#toDate").val().split(' ')[0]))+'%20'+$("#toDate").val().split(' ')[1]+'","'+'campType":"'+$("#campType").val()+'","'+'startIndex":"'+$("#startIndexSub").text()+'","'+'recordTofetch":"'+$("#rowCountSub").text()+'"}  target='+'"expandIt">'+data+'</a>';
                                else
                                    return data;
                            }
                        }],
                        //"searching" : false,
                        "bSort" : false,
                        "fnInitComplete": function( oSettings) {
                            if($('#startIndex').val()==0){
                                $("#reportTablePPC_previous").addClass("disabled");}
                            else
                                $("#reportTablePPC_previous").removeClass("disabled");
                            $("[aria-controls='reportTablePPC'][data-dt-idx='1']").addClass('prevCall');
                            document.getElementById("reportTablePPC_paginate").firstChild.innerHTML = y;
                            $($("#reportTablePPC_paginate>span>.paginate_button")).each(function(){
                                $(this).text(nextPage);
                                nextPage++;
                                $('#reportTablePPC').dataTable().fnPageChange( 'last' );
                                $("#reportTablePPC_next").removeClass("disabled");
                                $("[aria-controls='reportTablePPC'][data-dt-idx='5']").addClass('nextCall');
                            });
                        },
                        "fnDrawCallback" : function(oSettings) {
                            if($("[aria-controls='reportTablePPC'][id='search']").val()==""){
                                $("#rowCount").text("101");
                                flagPage++;
                                if(flagPage < 3) {
                                    return false;
                                }
                                var currentPageNum = nextPage-$("#reportTablePPC_paginate>span>.paginate_button").length;
                                $($("#reportTablePPC_paginate>span>.paginate_button")).each(function(){
                                    $(this).text(currentPageNum);
                                    currentPageNum++;
                                });
                            }
                        }
                    });
        }

	</script>
</head>
<body>
<div class="clear2"></div>
<div class="FormSection" >
	<s:if test="%{resultList!=null && resultList.size()>0}">
		<div class="greyStrip">
			<h4 style="float: left">
				Campaign Tracking Report For Domain :
				<s:property value="%{domainName}" />
			</h4>
			<h4 class="dateData" style="text-align: right;background: none">
			</h4>
		</div>
		<div class="innerBox">
			<s:hidden id="email_verified" value="Y"></s:hidden>
			<table cellspacing="0" cellpadding="4" border="0" align="center"
				   class="payTransaction" id="reportTablePPC">
				<thead>
				<tr class="headerRow">
					<th style="display: none;">Sub Campaign Id</th>
					<th valign="middle" style="display: none;">Campaign Id</th>
					<th style="text-align: center;">Campaign Name</th>
					<th valign="middle" style="text-align: center;">Sub
						Campaign Name</th>
					<th valign="middle" style="text-align: center;">Total
						Visitor</th>
					<th valign="middle" style="text-align: center;">Unique
						Visitor</th>
					<th></th>
					<th></th>
					<th valign="middle" style="text-align: center;">Total
						Registered</th>
					<th valign="middle" style="text-align: center;">email
						Verified</th>
					<th></th>
					<th></th>
					<th valign="middle" style="text-align: center;">Total
						Deposited</th>
					<th></th>
					<th></th>
					<th  valign="middle" style="text-align: center;">Total
						Download Click</th>
				</tr>
				</thead>
				<tbody></tbody>
			</table>
		</div>
		<div id="startIndex" style="display:none"><s:property value="0" /></div>
		<div id="rowCount" style="display:none"><s:property value="%{resultList.size()}"/> </div>
		<div id="startIndexSub" style="display:none"><s:property value="0" /></div>
		<div id="sumofreg" style="display:none"><s:property value="%{resultList.get(0)[8]}" /></div>
		<div id="sumofreg1" style="display:none"><s:property value="0" /></div>
		<div id="sumofregpre" style="display:none"><s:property value="0" /></div>
		<div id="sumofregvalue" style="display:none"><s:property value="%{resultList.get(0)[8]}" /></div>


		<div id="sumofemailreg" style="display:none"><s:property value="%{resultList.get(0)[9]}" /></div>
		<div id="sumofemailreg1" style="display:none"><s:property value="0" /></div>
		<div id="sumofemailregpre" style="display:none"><s:property value="0" /></div>
		<div id="sumofemailregvalue" style="display:none"><s:property value="%{resultList.get(0)[9]}" /></div>

		<div id="sumofdep" style="display:none"><s:property value="%{resultList.get(0)[12]}" /></div>
		<div id="sumofdep1" style="display:none"><s:property value="0" /></div>
		<div id="sumofdeppre" style="display:none"><s:property value="0" /></div>
		<div id="sumofdepvalue" style="display:none"><s:property value="%{resultList.get(0)[12]}" /></div>

		<div id="rowCountSub" style="display:none"><s:property value="101" /></div>
		<div id="nextPageStart" style="display:none"></div>
		<div id="waitDivNext" class="animated-button-div" style="margin-left: 0px; display:none">
			<div class="animated-striped">Wait</div>
		</div>
		<div id="waitDivPrev" class="animated-button-div" style="margin-left: 0px;display:none">
			<div class="animated-striped" style="padding:3px 20px 2px 20px;">Wait...</div>
		</div>
		<br/>
	</s:if>
	<s:else>
		<div class="greyStrip">
			<h4>Error Message</h4>
		</div>
		<div class="innerBox">
			<div class="alert info_msg ">
				<span class="alert_close"></span><strong>Msg: </strong>No Record
				Found.
			</div>
		</div>
	</s:else>
</div>
<br/>
<div id="expandIt"></div>
</body>
</html>

