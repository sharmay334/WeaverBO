	<%@ taglib prefix="s" uri="/struts-tags"%>
	<%@ taglib prefix="ss" uri="/extended-struts2-tags" %>
<div class="FormSection">
<s:form id="RegistrationDomain" action="bo_dm_blockPhone_Edit_Save.action"	 method="post" theme="simple">
		<div class="greyStrip">
			<h4>
				Phone No
			</h4>
		</div>
	
		
				<s:hidden id="domainId" value="%{domainId}" name="domainId" />
				<s:if test="%{(ipAddresses.size()!=0)}">
					<div class="innerBox">
				<div class="FormMainBox1" >
					<table width="100%" cellpadding="0" cellspacing="0" border="0"
						id="plrTxnDayWiseTable" >
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
										
										<ss:textfield name="email" theme="simple" maxlength="15"
											id="domainIp_%{key}"
											pattern="^[0-9]*$" errorMassage="Only Numeric Characters allowed"
											cssStyle="width:18%" 
											value="%{value}"  /> 
					
					<s:a onclick="getedit('domainIp_%{key}')" href="javascript:void(0)"><img src="<%= request.getContextPath()%>/images/cross.gif"/></s:a>
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
							<div class="box_footer">
				<table width="100%">	<tr><td align="left"  width="88%">
				<s:a  onclick="addnewblockIP()" title="Add to Block Phone" 
				 href="javascript:void(0)" >
				 <img alt="Add to Block Phone" Class="" Style="margin:15px 0px 0px 20px" src="<%= request.getContextPath()%>/images/add.png"/>
				 </s:a>
				</td>
				<td align="right" width="50%" style="float:right">
				<s:submit align="right" name="EditIP" value="OK" cssClass="button" 
						id="submit" theme="simple" onclick="submitForm()"></s:submit>
				</td></tr>
				</table>
		</div>
					</s:if>
					<s:else>
			<div class="innerBox">
				<div class="FormMainBox1" >
					<h3 align="center">
					No Records Found!
					</h3>
					
					</div>
					</div>
					<div class="box_footer">
				<table width="100%">	<tr><td align="left"  width="88%">
				<s:a  onclick="addnewblockIP()" title="Add to Block Phone" 
				 href="javascript:void(0)" >
				 <img alt="Add to Block Phone" Class="" Style="margin:15px 0px 0px 20px" src="<%= request.getContextPath()%>/images/add.png"/>
				 </s:a>
				</td>
				<td align="right" width="50%" style="float:right">
				</td></tr>
				</table>
		</div>
		</s:else>
		</s:form>
	</div>
	
	<div id="addIP">
	</div>
	
	
					