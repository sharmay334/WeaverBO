<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<html>
	<body>
		<s:form id="bo_Risk_blockEmailSearchResult" theme="simple"
			action="bo_dm_blockEmail_Edit_Save">
			<s:token name="strusTokenSearchResult" id="strutsTokenSearchResult"></s:token>
			<s:hidden name="domainId" id="domainId"></s:hidden>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						E-mail Address
					</h4>
				</div>
				<s:hidden id="emailCount" value="%{ipAddresses.size()}"></s:hidden>
				<s:if test="%{(ipAddresses.size()!=0)}">
					<div class="innerBox">
						<div class="FormMainBox1">
							
							<table width="100%" cellpadding="0" cellspacing="0" border="0"
								id="plrTxnDayWiseTable">
								<tbody>
									<tr>
										<td>
											<s:set name="count" value="0"></s:set>
											<s:iterator value="%{ipAddresses}">
												<s:if test="%{#count==4}">
													<br />
													<br />
													<s:set name="count" value="0"></s:set>
												</s:if>

												<ss:textfield name="emailIdList" theme="simple"
													id="email_%{key}" cssStyle="width:18%" readonly="true"
													value="%{value}"
													pattern="^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+){0,1})\.([A-Za-z]{2,})$"
													errorMassage="Please Enter Valid Email Id" patternOn="blur" />

												<s:a id="link_email_%{key}" theme="simple"
													href="javascript:void(0)">
													<img src="<%=path%>/images/cross.gif" />
												</s:a>
												<s:set name="count" value="%{#count+1}"></s:set>
											&nbsp; &nbsp;
									</s:iterator>
										</td>
									</tr>
								</tbody>
								<tfoot>
							</table>
						</div>
					</div>
				</s:if>
				<s:else>
					<div class="innerBox">
						<div class="FormMainBox1">
							<h3 align="center">
								No Records Found!
							</h3>
						</div>
					</div>
				</s:else>
				
				<div id="addEmail" style="display: none;">
					<div class="clearFRM" style="padding-top: 18px"></div>
					<div class="FormSection" style="width: 96%; margin: 10px">
						<div class="greyStrip">
							<h4>
								Blocked E-mail Information
							</h4>
						</div>

						<div class="innerBox" style="height: 130px">
							<div class="FormMainBox">

								<div class="labelDiv">
									<label>
										E-mail Address
									</label>
								</div>

								<div id="Container" style="height: auto;">
									<s:set name="count" value="1"></s:set>
									<s:iterator begin="1" end="3">
										<div class="InputDiv">
											<s:iterator begin="1" end="4">
												<ss:textfield name="emailIdList" theme="myTheme"
													cssStyle="width:20%" id="email%{#count}"
													pattern="^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+){0,1})\.([A-Za-z]{2,})$"
													errorMassage="Please Enter Valid Email Id" patternOn="blur"></ss:textfield>
												&nbsp;&nbsp;
							<s:set name="count" value="#count+1" />
											</s:iterator>
										</div>
										<br />
										<br />
									</s:iterator>
								</div>
							</div>
						</div>
					</div>
				</div>



				<div class="clearFRM" style="padding-top: 20px"></div>
			<div class="FormMainBox" <s:if test="%{(ipAddresses.size()==0)}"> style="display: none;" </s:if> id="reasonDiv">
						<div class="labelDiv">
							<label>
								Reason for block E-mail
							</label>
							<em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield name="reason" id="reason" theme="myTheme"
								maxlength="50" pattern="^[a-zA-Z ]*$" applyscript="true"
								errorMassage="Number and Special Character not allowed"></ss:textfield>
							<div id="reason_error" class="fieldError">
								<s:fielderror>
									<s:param>reason</s:param>
								</s:fielderror>
							</div>
						</div>
					</div>

				<div class="box_footer">
					<table width="100%">
						<tr>
							<td align="left" width="88%">
								<s:a title="Add to Block Email" href=""
									 id="addToBlock">
									<img alt="Add to Block Email" Class=""
										Style="margin: 15px 0px 0px 20px"
										src="<%=path%>/images/add.png" name="maximize"/>
								</s:a>
							</td>

							<td align="right" width="50%"
								<s:if test="%{(ipAddresses.size()==0)}"> style="visibility: hidden; float: right;" </s:if>>
								<s:submit align="right" name="editEmail" value="Submit"
									cssClass="button" id="submit" theme="simple">
								</s:submit>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</s:form>
	</body>
</html>

