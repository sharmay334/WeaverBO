<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript">
		$(document).ready(function(){
				var userName='<s:property value="%{userInfoBean.getUserName()}"/>';
				$('#addField').click(function(){
				  $("#newFieldDiv").css("display","block");
				  $("#secQues").val("");
				  $('secQues').attr("applyscript","true");
				  return false;
				});
				$('#addButton').click(function(){
						var val = $("#secQues").val();
						var pattern = /^[A-Za-z,'? ]*$/g;
						if(!val.match(pattern))
						{
						return false;
						}
					   var list = $("#jsonList").val();
					   var jsonList = $.parseJSON(list);
					   var flag = true;
					   var val = $("#secQues").val();
					   if(val.trim()==""){
					    return false;
					   }
					   $.each(jsonList, function(i, value) {
							if (value.displayName.trim() == val.trim()) {
							  $("#secQues_errorDiv").html("Security Question Not Available");
							  _Show($("#secQues_errorDiv"),$("#secQues"));
								flag = false;
								return false;
							}
				       });
				       if(!flag){
				        return false;
				       }
				    var userName='<s:property value="%{userInfoBean.getUserName()}"/>';
				    var userId = '<s:property value="%{userInfoBean.getUserId()}"/>';
				    var str = ',{"secQues":0,"displayName":"'+$("#secQues").val()+'","addedBy":"BO","status":"ACTIVE","userId":'+userId+',"userName":"'+userName+'"}';
					jsonList = $("#jsonList").val();
					jsonList = jsonList.replace("]","");
					jsonList =jsonList + str+"]";
					$("#jsonList").val(jsonList);
					var table = document.getElementById('payTransaction');
					var iteration = table.rows.length;
					var row = table.insertRow(table.rows.length);
					row.innerHTML = '<td><input type="checkbox" id="chk' + iteration
							+ '" checked="true" name="refId" value="' + (iteration - 1) + '" /></td><td>'
							+ $("#secQues").val() + '</td><td>' + userName + '</td>';
					//$("#secQues").val("");
					$("#newFieldDiv").css("display","none");
					$('secQues').attr("applyscript","false");
					$("table.bubbletip").css("display","none");			
				});
				
			});

		</script>
	</head>
	<body>
		<div class="FormSection">
			<div class="greyStrip">
				<h4>
					Security Question
				</h4>
			</div>
			<s:hidden name="jsonList" id="jsonList"></s:hidden>
			<s:if test="secQuesList.size >0 ">
				<div class="innerBox">
					<div id="errorDiv" class="fieldError"></div>
					<table id="payTransaction" class="payTransaction" align="center"
						cellspacing="0" cellpadding="4" border="0">
						<tbody>
							<tr>
								<th height="28" width="4%" align="left" valign="middle">
									Select
								</th>
								<th height="28" width="28%" align="left" valign="middle">
									Security Question
								</th>
								<th height="28" width="18%" align="left" valign="middle">
									Added By
								</th>

							</tr>
							<s:iterator value="secQuesList" status="secQuesList">
								<tr>
									<td align="left" valign="middle">
											<input type="checkbox"
												value="<s:property value="#secQuesList.index" />"
												name="refId" <s:property value="%{(status=='ACTIVE')?'checked=checked':''}" />
												id="chk<s:property value="%{#secQuesList.index}" />" />
									</td>
									<td align="left" valign="middle">
										<%-- <s:property value="%{resource.getProperty('global.'+secQues)}" /> --%>
										<s:property value="%{displayName}" />
									</td>
									<td align="left" valign="middle">
										<s:property value="userName" />
									</td>


								</tr>
							</s:iterator>
						</tbody>
					</table>
				</div>
			</s:if>
			<div class="box_footer" align="right">

				<input type="button" value="Add Field" id="addField"/>
				<s:submit cssClass="button" align="right" theme="simple"
					onclick="return checkForm('Please select atleast one Security Question');"></s:submit>
			</div>
		</div>
		
		
		<div id="newFieldDiv" style="display: none;">
		   <div class="FormSection">
				<div class="greyStrip">
					<h4>
						New Security Question
					</h4>
				</div>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Security Question:
							</label>
						</div>
						<div class="InputDiv">
							<ss:textfield id="secQues" name="secQues" maxlength="70" pattern="^[A-Za-z,'? ]*$"
								errorMassage="Only [A-Za-z,'? ] characters allowed" theme="myTheme" applyscript="true" placeholder="Please enter Question here." ></ss:textfield>
						</div>
					</div>
				</div>
				<div class="box_footer" align="right">
				<ss:button id="addButton" cssClass="button" value="Add To List"></ss:button>
				</div>
			</div>
		
		
		</div>
		
	</body>
</html>