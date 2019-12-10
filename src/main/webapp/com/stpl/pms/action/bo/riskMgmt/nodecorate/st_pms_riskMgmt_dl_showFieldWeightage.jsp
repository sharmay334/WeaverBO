<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>Duplication</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="Duplication Logic">
		
	</head>
	<body>
		<s:hidden id="actionNotiList_hidden"
			value="%{actionNotiStr}" />
		<s:form id="myform" action="st_pms_bo_riskMgmt_editDLFieldWeightage"
			method="post" theme="simple">
			<s:token name="strutsToken" id="strutsToken"></s:token>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Duplication Field Weightage
					</h4>
				</div>
				<div class="innerBox">
					<table width="830" cellspacing="0" cellpadding="4" border="1"
						align="center" id="payTransaction" class="transactionTable">
						<tbody>
							<tr>
								<th width="8%" valign="middle" align="left">
									Field Name
								</th>
								<th width="18%" valign="middle" align="left">
									Match Criteria
								</th>
								<th width="18%" valign="middle" align="left">
									Section Name
								</th>
								<th width="20%" valign="middle" align="left">
									Weightage
								</th>
								<th width="18%" valign="middle" align="left">
									Status
								</th>
							</tr>
							<s:iterator value="fieldWeightList" status="score">
								<tr>
									<td valign="middle" height="20" align="left">
										<s:property value="fieldName" />
									</td>
									<td valign="middle" height="20" align="left">
										<s:property value="matchCriteria" />
									</td>
									<td valign="middle" height="20" align="left">
										<s:property value="sectionName" />
									</td>
									<td valign="middle" height="20" align="left">
										<ss:textfield id="weightageArr_%{#score.index+1}"
											cssClass="makeEnable" name="weightageArr" maxlength="4"
											value="%{weightage}" disabled="true" pattern="^[0-9]*$"
											errorMassage="Value Should Be Positive Numeric" patternOn="blur"
											applyscript="true" cssStyle="width: 40px;" theme="myTheme"></ss:textfield>
											</td>
									<td valign="middle" height="20" align="left">
										<ss:select cssClass="makeEnable" list="{'ACTIVE','INACTIVE'}"
											name="statusArr" id="statusArr" value="status" theme="simple"
											disabled="true"></ss:select>
									</td>
								</tr>
							</s:iterator>
							<tr>
								<td valign="middle" height="20" align="left">
									Total Weightage
								</td>
								<td valign="middle" height="20" align="left"></td>
								<td valign="middle" height="20" align="left"></td>
								<td valign="middle" height="20" align="left" id="totWeightage"></td>
								<td valign="middle" height="20" align="left"></td>
							</tr>
						</tbody>
					</table>

				</div>
				<div class="box_footer">
				</div>
			</div>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Score Range
					</h4>
				</div>
				<div class="innerBox">
					<table width="830" cellspacing="0" cellpadding="4" border="0"
						align="center" class="transactionTable" id="scoreTable">
						<tbody>
							<tr>
								<th width="0%" valign="middle" align="left"
									style="display: none;">
								</th>
								<th width="6%" valign="middle" align="left">
									Delete
								</th>
								<th width="6%" valign="middle" align="left">
									FromScore
								</th>
								<th width="6%" valign="middle" align="left">
									ToScore
								</th>
								<th width="8%" valign="middle" align="left">
									IS Record
								</th>
								<th width="20%" valign="middle" align="left">
									Action on New
								</th>
								<th width="20%" valign="middle" align="left">
									Action on Old
								</th>
								<th width="16%" valign="middle" align="left">
									Notification on New
								</th>
								<th width="16%" valign="middle" align="left">
									Notification on Old
								</th>
							</tr>
							<s:iterator value="scoreRangeMasterList" status="score">
								<tr id="makeEnable_tr_<s:property value="%{#score.index+1}"/>">
									<td valign="middle" height="10" align="left"
										style="display: none;">
										<ss:textfield name="idScoreArr"
											id="idScoreArr_%{#score.index+1}" value="%{#score.index+1}"
											theme="simple"></ss:textfield>
									</td>
									<td valign="middle" height="10" align="left">
										<s:checkbox id="deleteIt_%{#score.index+1}" name="deleteIt"
											cssClass="checkOne makeEnable" value="false" disabled="true"
											theme="simple"></s:checkbox>
									</td>
									<td valign="middle" height="20" align="left">
										<ss:textfield id="fromScoreArr_%{#score.index+1}"
											cssClass="makeEnable" name="fromScoreArr" pattern="^[0-9]*$" maxlength="4"
											errorMassage="Value Should Be Positive Numeric" patternOn="blur"
											applyscript="true" value="%{fromScore}" disabled="true" cssStyle="width: 40px;"
											theme="simple"></ss:textfield>
									</td>
									<td valign="middle" height="20" align="left">
										<ss:textfield id="toScoreArr_%{#score.index+1}" pattern="^[0-9]*$"
											errorMassage="Value Should Be Positive Numeric" patternOn="blur" maxlength="4"
											applyscript="true" name="toScoreArr" cssClass="makeEnable" value="%{toScore}"
											disabled="true" cssStyle="width: 40px;" theme="simple"></ss:textfield>
									</td>
									<td valign="middle" height="20" align="left">
										<s:select cssClass="makeEnable" list="{'Y','N'}"
											name="isRecordArr" id="isRecordArr_%{#score.index+1}"
											value="isRecord" theme="simple" disabled="true"></s:select>
									</td>
									<td valign="middle" height="20" align="left">
										<s:iterator value="actionNotiList" status="lowerScore">
											<s:if test="%{type=='ACTION'}">
												<s:if test="%{actionNewList.contains(name)}">
													<ss:checkbox
														id="actionNewArr_%{#score.index+1}_%{#lowerScore.index+1}"
														name="actionNewArr" cssClass="checkOne makeEnable chkSerial"
														value="true" fieldValue="%{#score.index+1}-%{name}" disabled="true"></ss:checkbox>
													<s:property value="name" />

													<br />
												</s:if>
												<s:else>
													<ss:checkbox
														id="actionNewArr_%{#score.index+1}_%{#lowerScore.index+1}"
														name="actionNewArr" cssClass="checkOne makeEnable chkSerial"
														value="false" fieldValue="%{#score.index+1}-%{name}" disabled="true"></ss:checkbox>
													<s:property value="name" />

													<br />
												</s:else>
											</s:if>
										</s:iterator>
									</td>

									<td valign="middle" height="20" align="left">
										<s:iterator value="actionNotiList" status="lowerScore">
											<s:if test="%{type=='ACTION'}">
												<s:if test="%{actionOldList.contains(name)}">
													<ss:checkbox
														id="actionOldArr_%{#score.index+1}_%{#lowerScore.index+1}"
														name="actionOldArr" cssClass="checkOne makeEnable chkSerial"
														value="true" fieldValue="%{#score.index+1}-%{name}" label="%{name}"
														disabled="true"></ss:checkbox>
													<s:property value="name" />
													<br />
												</s:if>
												<s:else>
													<ss:checkbox
														id="actionOldArr_%{#score.index+1}_%{#lowerScore.index+1}"
														name="actionOldArr" cssClass="checkOne makeEnable chkSerial"
														value="false" fieldValue="%{#score.index+1}-%{name}" disabled="true"
														label="%{name}"></ss:checkbox>
													<s:property value="name" />
													<br />
												</s:else>
											</s:if>
										</s:iterator>
									</td>

									<td valign="middle" height="20" align="left">

										<s:iterator value="actionNotiList" status="lowerScore">
											<s:if test="%{type!='ACTION'}">
												<s:if test="%{notifiNewList.contains(name)}">
													<ss:checkbox
														id="notifiNewArr_%{#score.index+1}_%{#lowerScore.index+1}"
														name="notifiNewArr" cssClass="checkOne makeEnable chkSerial"
														value="true" fieldValue="%{#score.index+1}-%{name}" label="%{name}"
														disabled="true"></ss:checkbox>
													<s:property value="name" />
													<br />
												</s:if>
												<s:else>
													<ss:checkbox
														id="notifiNewArr_%{#score.index+1}_%{#lowerScore.index+1}"
														name="notifiNewArr" cssClass="checkOne makeEnable chkSerial"
														value="false" fieldValue="%{#score.index+1}-%{name}" disabled="true"></ss:checkbox>
													<s:property value="name" />
													<br />
												</s:else>
											</s:if>
										</s:iterator>
									</td>
									<td valign="middle" height="20" align="left">
										<s:iterator value="actionNotiList" status="lowerScore">
											<s:if test="%{type!='ACTION'}">
												<s:if test="%{notifiOldList.contains(name)}">
													<ss:checkbox
														id="notifiOldArr_%{#score.index+1}_%{#lowerScore.index+1}"
														name="notifiOldArr" cssClass="checkOne makeEnable chkSerial"
														value="true" fieldValue="%{#score.index+1}-%{name}" disabled="true"></ss:checkbox>
													<s:property value="name" />
													<br />
												</s:if>
												<s:else>
													<ss:checkbox
														id="notifiOldArr_%{#score.index+1}_%{#lowerScore.index+1}"
														name="notifiOldArr" cssClass="checkOne makeEnable chkSerial"
														value="false" fieldValue="%{#score.index+1}-%{name}" disabled="true"></ss:checkbox>
													<s:property value="name" />
													<br />
												</s:else>
											</s:if>
										</s:iterator>
									</td>
								</tr>
							</s:iterator>
						</tbody>
					</table>
				</div>
				<div class="box_footer">
			<ss:button name="edit" value="Edit" id="edit"></ss:button>
			<ss:button cssClass="makeEnable" name="add" value="Add" id="add"></ss:button>
			<ss:button cssClass="makeEnable" name="delete" value="Delete"
				id="delete"></ss:button>
			<ss:submit value="Submit" theme="simple" cssClass="makeEnable" id="submitBtn"
				disabled="true"></ss:submit>
				</div>
			</div>

		</s:form>
	</body>
</html>

