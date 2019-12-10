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
<div class="FormSection">
			<div class="greyStrip">
				<h4 style="float: left"><s:text name="global.generateprintreadydata.ZipfileReport"/></h4>
			</div>
			<div class="innerBox">
			
	<s:form
		action="/com/stpl/pms/action/bo/gl/st_download_game_downloadFile.action"
		id="download">
		<table cellspacing="0" cellpadding="4" border="0" align="center"
			class="payTransaction" id="subReportTable2">
			<thead>
				<tr>
				<th valign="middle" style="text-align: center;"><s:text name="global.generateprintreadydata.ZipFile"/> 1</th>
					<th valign="middle" style="text-align: center;"><s:text name="global.generateprintreadydata.ZipFile"/> 2
						</th>
				</tr>
			</thead>
			<tbody>
			<tr>
			<s:iterator value="zipFileMap" var="obj2" status="txnList">
			
				<td style='text-align:center'>
				<a href="javascript:;" onclick='clickme("<s:property value="%{key}"/>")'><s:property value="%{value}" /></a>
				<s:hidden id="fileNametoDownlaod" name="fileNametoDownlaod"></s:hidden>	
				</td>
				</s:iterator>
			</tr>
			</tbody>
		</table>
		
	</s:form>
	</div>
	</div>
</body>
</html>