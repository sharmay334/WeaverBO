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
    <base href="<%=basePath%>">
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <script type="text/javascript">
      $(document).ready(function(){
      $("#submitDetail").click(function(){
        var str = "{";
        $('#drForm table[id*="Table"]').each(function(){
            $(this).find('tr').each(function(){
              var pId = $(this).find("td").eq(0).find('input').val();
              var st = $(this).find("td").eq(6).find('select').val();
              if(pId!=null && st!=null && st!="-1"){
              if(str!="{"){
                str = str + ",";
              }
                str = str +pId+':"'+st+'"';
              }
            });
        });
      str = str + "}";
      $("#playerData").val(str);
      });
      
      });
    
    </script>
  </head>
  
  <body>
   <div id="container">
		<div class="FormSection">
		<s:if test="dpsList.size >0 ">
			<div class="greyStrip">
				<h4>
					Player Duplication Highest Score
				</h4>
			</div>
			<s:hidden name="playerData" id="playerData"></s:hidden>
				<div class="innerBox">
					<table id="duplicationTable" class="payTransaction" align="center"
						cellspacing="0" cellpadding="4" border="0">
							<tr>
							    <th height="28" align="left" valign="middle">
									User Name
								</th>
								<th height="28" align="left" valign="middle">
									First Name
								</th>
								<th height="28" align="left" valign="middle">
									Last Name
								</th>
								<th height="28" align="left" valign="middle">
									Registration Date
								</th>
								<th height="28" align="left" valign="middle">
									ScoreAsNew
								</th>
								<th height="28" align="left" valign="middle">
									ScoreAsOld
								</th>
								<th height="28" width="200px" align="left" valign="middle">
									Player Status
								</th>

							</tr>
							<s:iterator value="dpsList" status="dpsList">
								<tr>
									<td align="left" valign="middle">
									<a style="cursor: pointer"
												onclick="return getPlayerScore('<s:property value="playerId" />','<s:property value="userName" />');">
											<s:property value="userName" />
											</a>
									<s:hidden value="%{playerId}" />
											
									</td>
									<td align="left" valign="middle">
										<s:property value="firstName" />
									</td>
									<td align="left" valign="middle">
										<s:property value="lastName" />
									</td>
									<td align="left" valign="middle">
										<s:property value="registrationDate" />
									</td>
									<td align="left" valign="middle">
										<s:property value="scoreAsNew" />
									</td>
									<td align="left" valign="middle">
										<s:property value="scoreAsOld" />
									</td>
                                    <td>
                                      <ss:select theme="myTheme" cssStyle="width:200px" cssClass="select1"
												list="{'ACTIVE','INACTIVE'}" name="status"
												id="status" headerKey="-1" headerValue="--Please Select--"></ss:select>
                                    </td>

								</tr>
							</s:iterator>
					</table>
				</div>
			<div id="searchDivNew"></div>
			<div class="box_footer" align="right">
				<ss:submit value="Submit" cssClass="button"
					id="submitDetail" ajaxAction="com/stpl/pms/action/bo/riskMgmt/bo_risk_submitDuplicationReport.action" ajaxParam="playerData" target="mainDiv" theme="simple"/>
			</div>
		</s:if>
		<s:else>
                <div class="greyStrip">
                    <h4>
                        Error Message
                    </h4>
                </div>
                <div class="innerBox">
                    <div class="alert info_msg ">
                        <span class="alert_close"></span><strong>Msg: </strong>No Record
                        Found.
                    </div>
                </div>
            </s:else>
		  </div>
		
		</div>
	</body>
</html>
