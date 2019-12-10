<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Duplicate Bonus</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript">
		$(document).ready(function() {

			var dataSize="<s:property value='%{emailList.size()}' />";
			if(dataSize){
					$('td[class="handle"]').hover(function(){
					   $(this).css("cursor","move");
					});
					var rows = $('.payTransaction').get(0).tBodies[0].rows;
					var str='{';
					for ( var i = 1; i < rows.length; i++) {
						str+='"'+$.trim($(rows[i].cells[3]).attr('id'))+'":"'+$.trim($(rows[i].cells[3]).html())+'",';
					}
					str=str.substring(0,str.length-1)+'}';
					$('#emailOrderStr').val(str);
			}
		});
    	$(function() {
    		console.log("in function");
    		
				$("#emailTable").tableDnD({
					onDrop : function(table, row) {
						 var rows = table.tBodies[0].rows;
						for ( var i = 1; i < rows.length; i++) {
							$(rows[i].cells[3]).html(i);
						}
						var str='{';
						for ( var i = 1; i < rows.length; i++) {
							str+='"'+$(rows[i].cells[3]).attr('id')+'":"'+$(rows[i].cells[3]).html()+'",';
						}
						str=str.substring(0,str.length-1)+'}';
						$('#emailOrderStr').val(str);
					},
					dragHandle : ".dragHandle"
				});

				$(".payTransaction tr").hover(function() {
					$(this.cells[0]).addClass('showDragHandle');
				}, function() {
					$(this.cells[0]).removeClass('showDragHandle');
				});
			});
		</script>
	</head>

	<body>
	<div id="container">
	<div id="formDiv">
		<s:if test="%{emailList.size()>0}">
			
			
				<div class="FormSection">
					<div class="greyStrip">
						<h4>
							Providers
						</h4>
					</div>
					<s:form action="bo_dm_update_email_order" theme="simple">
					<s:token name="strutsToken" id="strutsToken"></s:token>
					<s:hidden name="emailOrderStr" id="emailOrderStr"></s:hidden>
					<div class="innerBox" style="overflow-y: auto;">
						<table id="emailTable" width="830" cellspacing="0" cellpadding="4"
							border="0" align="center" class="payTransaction">
							<tr class="nodrop nodrag">
							<th colspan="2" width="30%">
								Provider Name
							</th>
							<th width="36%">
								Mean Processing Time
							</th>
							<th width="34%">
								Priority Order
							</th>
						</tr>
							<s:set name="rowCount" value="%{0}"></s:set>
							<s:iterator value="%{emailList}" status="emailList">
								<s:set name="rowCount" value="%{#emailList.index+1}" id="rowCount"></s:set>
									<tr id="tr_<s:property value="%{#rowCount}"/>">
										<td  class="dragHandle" width="5%">
											<img src="<%=path %>/images/dragIcon2.gif"
											style="width: 20px;height:20px "> </td>
										<td width="25%">
											<s:property value="%{providerName}" /></td>
										<td width="36%">
											<s:property value="%{meanProcessingTime}" /></td>

										<td width="34%" id="<s:property value="%{id}" />">
											<%-- <s:textfield cssStyle="width:25px" name="priorityOrder"
												id="priorityOrder_%{#rowCount}"
												value="%{priorityOrder}" theme="simple"></s:textfield> --%>
												<s:property value="%{priorityOrder}" />
										</td>

									</tr>
								</s:iterator>
						</table>

					</div>
					<div class="box_footer">
						<s:submit value="Update Order"></s:submit>
					</div>
					</s:form>
				</div>
							
		</s:if>
		</div>
		</div>
		<s:else>		
		<div id="searchResult" class="FormSection">
			<div class="greyStrip">
				<h4>Error Message</h4>
			</div>
			<div class="innerBox">
				<div class="alert info_msg ">
					<span class="alert_close"></span><strong>Msg: </strong>No Record
					Found.
				</div>
			</div>
		</div>	
		</s:else>
		
	</body>
</html>
