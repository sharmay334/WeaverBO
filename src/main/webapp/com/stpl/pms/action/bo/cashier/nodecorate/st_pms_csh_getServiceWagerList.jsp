<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>

<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<script>
$(function(){
	$("#reconForm").submit(function(){
		if($(".tids:checked").map(function(){return this.value;}).length==0){
			alert("please select atleast one transaction!");
			return false;
		}
	});
	
	$("#gameServiceId").val($("#gameService").val());
	
	if($("#wagerStatus").val()==="Pending"){
		$(".box_footer").show();
		window.dtable=$("#wagerTable").DataTable( {
	        "order": [[ 4, "desc" ]],
	        "aoColumnDefs": [
		      	{"bSortable": false, "aTargets": [ 0 ]}
	    	]
    	} );
	}else{
			window.dtable=$("#wagerTable").DataTable( {
	        "order": [[ 4, "desc" ]],
	        "aoColumnDefs": [
		      	{"bSortable": false, "aTargets": [ 0 ]},
		      	{
	                "targets": [ 0 ],
	                "visible": false,
	                "searchable": false
	            }
	    	]
    	} );
	}
});
</script>
<body>
	<form action="<%=basePath%>com/stpl/pms/action/bo/cashier/st_pms_bo_csh_resolveWagerStatus.action" method="post" id="reconForm">
	<s:token></s:token>
	<s:hidden name="gameServiceId" id="gameServiceId"></s:hidden>
	<div class="FormSection">
		<div class="greyStrip">
			<h4>Wager List</h4>
		</div>
		<div class="innerBox">
			<s:if test="%{wagerList.size>0}">
				<div style="overflow-x: scroll">
					<table class="payTransaction" id="wagerTable">
						<thead>
							<tr>
								<th><input type="checkbox" id="selectAll"/><lablel for="selectAll">Select</lablel></th>
								<th>Transaction ID</th>
								<th>Player ID</th>
								<th>Game Name</th>
								<th>Amount</th>
								<th width="5%">Transaction Date</th>
							</tr>
						</thead>
						<tbody>
							<s:iterator value="%{wagerList}">
								<tr id='wagerRow<s:property value="%{getTransactionId()}" />' class="wagerRow_" >
									<td><input type="checkbox" name="tids" class="tids" value='<s:property value="%{getTransactionId()}" />' />
									</td>
									<td><s:property value="%{getTransactionId()}" />
									</td>
									<td><s:property value="%{getPlayerId()}" />
									</td>
									<td><s:property value="%{getGameName()}" />
									</td>
									<td><s:property value="%{getAmount()}" />
									</td>
									<td><s:property value="%{getTransactionDate()}" />
									</td>
								</tr>
							</s:iterator>
						</tbody>
					</table>
				</div>
			</s:if>
			<s:else>
				<div class="innerBox">
					<div class="alert info_msg " style="width: auto">
						<span class="alert_close"></span><strong>Info: </strong> No wager transaction record found!
					</div>
				</div>
			</s:else>
		</div>
		<div class="box_footer" align="right" style="display: none;">
			<s:submit type="button" theme="simple" id="collectiveAction" value="Resolve transaction status" cssClass="button"></s:submit>
		</div>
	</div>
	</form>
	<div class="clear2"></div>
	<script type="text/javascript">
		$("#wagerListContainer").show();
		
     $(function(){
    	/* $("#collectiveAction").click(function(){
    		var selectedtranIds;
    		selectedtranIds=$(".tids:checked").map(function(){
    			return this.value;
    		}).get().join();
    	alert("Selectd Transaction ids:"+selectedtranIds);
    	}); */
    	$("#selectAll").change(function(){
    		$(".tids").prop('checked', $(this).prop("checked"));
    	});
    }); 
	</script>
</body>
