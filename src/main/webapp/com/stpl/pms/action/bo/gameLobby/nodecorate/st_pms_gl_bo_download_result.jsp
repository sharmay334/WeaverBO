<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script>
	$('#subReportTable1').DataTable();
	// 	function downlaodTicket(download_link) {

	// 		 $.ajax({
	// 				type : "GET",
	// 				url : "/WeaverBO/com/stpl/pms/action/bo/gl/st_download_game_downloadFile.action?fileNametoDownlaod="
	// 						+download_link,
	// 				success : function(itr) {

	// 					},

	// 				error : function(itr) {

	// 				}
	// 			});

	// 	}

	function clickme(fileName) {
		document.getElementById('fileNametoDownlaod').value = fileName;
		$('#download').submit();
	}
</script>
</head>

<body>

	<s:form
		action="/com/stpl/pms/action/bo/gl/st_download_game_downloadFile.action"
		id="download">
		<table cellspacing="0" cellpadding="4" border="0" align="center"
			class="payTransaction" id="subReportTable1">
			<thead>
				<tr>
					<th valign="middle" style="text-align: center;"><s:text name="global.searchgames.ticketrange" /></th>
					<th valign="middle" style="text-align: center;"><s:text name="global.searchgames.tickettextfile" /></th>
					<th valign="middle" style="text-align: center;"><s:text name="global.searchgames.ticketvirnfile"/></th>

				</tr>
			</thead>
			<tbody>
				<s:iterator value="fileNamesTemp" var="obj1">
					<s:iterator var="data" value="value" status="txnList1">
						<s:if test="%{#txnList1.index == 0}">
							<tr>
								<td><s:property value="%{key}"/></td>
						</s:if>
						<s:elseif test="%{#txnList1.index%3 == 0}">
							</tr>
							<tr>
							<s:if test="%{#txnList1.index%3 == 1 || #txnList1.index%3 == 2 }">
				<td ><a href="javascript:;" onclick='clickme("<s:property value="%{value}"/>")'><s:property value="%{key}" /></a>
							<s:hidden id="fileNametoDownlaod" name="fileNametoDownlaod"></s:hidden>	
							</td>
							</s:if>
							<s:else><td ><s:property value="%{key}" /></td></s:else>
								
						</s:elseif>
						<s:else>
					<td><a href="javascript:;" onclick='clickme("<s:property value="%{value}"/>")'><s:property value="%{key}" /></a>
						<s:hidden id="fileNametoDownlaod" name="fileNametoDownlaod"></s:hidden>	
							</td>
						</s:else>
					</s:iterator>
				</s:iterator>

			</tbody>
		</table>
		
	</s:form>
	
</body>
</html>