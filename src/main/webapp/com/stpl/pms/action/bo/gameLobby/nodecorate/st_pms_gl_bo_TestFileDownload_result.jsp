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
			class="payTransaction" id="subReportTable2">
			<thead>
				<tr>
					<th valign="middle" style="text-align: center;"><s:text name="global.searchgames.PackFile"/></th>
					<th valign="middle" style="text-align: center;"><s:text name="global.searchgames.BookFile"/>
						</th>
					<th valign="middle" style="text-align: center;"><s:text name="global.searchgames.PrizePatternFile"/>
						</th>
					<th valign="middle" style="text-align: center;"><s:text name="global.searchgames.ConsecutivePatternFile"/>
						</th>
						
				</tr>
			</thead>
			<tbody>
			<tr>
			<s:iterator value="testFiles" var="obj2">
				<td style="text-align:center">
				<a href="javascript:;" onclick='clickme("<s:property value="%{key}"/>")'><s:property value="%{value}" /></a>
				<s:hidden id="fileNametoDownlaod" name="fileNametoDownlaod"></s:hidden>	
				</td>
				</s:iterator>
			</tr>
			</tbody>
		</table>
		
	</s:form>
</body>
</html>