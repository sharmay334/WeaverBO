<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<html>
	<body>
		<s:form id="bo_Risk_blockPhoneSearchResult" theme="simple"
			action="bo_dm_blockPhone_Edit_Save">
			<s:token name="strusTokenSearchResult" id="strutsTokenSearchResult"></s:token>
			<s:hidden id="domainId" name="domainId"></s:hidden>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Phone No
					</h4>
				</div>
				<s:hidden id="blockPhoneNos" value="%{ipAddresses.size()}"></s:hidden>
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

												<ss:textfield name="phoneNoList" theme="simple"
													maxlength="10" id="phoneNo_%{key}" readonly="true"
													pattern="^[0-9]*$"
													errorMassage="Only Numeric Characters allowed"
													cssStyle="width:18%" value="%{value}" />

												<s:a id="link_phoneNo_%{key}" href="javascript:void(0)">
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
				<div id="addPhone" style="display: none;">
					<div class="clearFRM" style="padding-top: 18px"></div>
					<div class="FormSection" style="width: 96%; margin: 10px">
						<div class="greyStrip">
							<h4>
								Blocked Phone Information
							</h4>
						</div>
						<div class="innerBox" style="height: 130px">
							<div class="FormMainBox">

								<div class="labelDiv">
									<label>
										Phone Number
									</label>
								</div>
								<div id="Container" style="height: auto;">
									<s:set name="count" value="1"></s:set>
									<s:iterator begin="1" end="3">
										<div class="InputDiv">
											<s:iterator begin="1" end="4">
												<ss:textfield name="phoneNoList" theme="myTheme"
													maxlength="10" id="phoneNo%{#count}"
													pattern="^[7-9]{1}[0-9]{9}$"
													errorMassage="Please Enter A Valid Phone No"
													patternOn="blur" cssStyle="width:20%"></ss:textfield>
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
				<div class="clearFRM" style="padding-top: 18px"></div>
				<div class="FormMainBox"  <s:if test="%{(ipAddresses.size()==0)}"> style="display: none;" </s:if> id="reasonDiv" >
					<div class="labelDiv">
						<label>
							Reason for block Phone Number
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
								<s:a title="Add to Block Phone" href=""
									 id="addToBlock">
									<img alt="Add to Block Phone" Class=""
										Style="margin: 15px 0px 0px 20px"
										src="<%=request.getContextPath()%>/images/add.png" name="maximize" />
								</s:a>
							</td>
							
								<td align="right" width="50%"  <s:if test="%{(ipAddresses.size()==0)}">style="visibility: hidden; float: right;" </s:if>>
									<s:submit align="right" name="EditPhone" value="submit"
										cssClass="button" id="editPhone" theme="simple"></s:submit>
								</td>
							
						</tr>
					</table>
				</div>

			</div>

		</s:form>
		
	</body>
</html>

