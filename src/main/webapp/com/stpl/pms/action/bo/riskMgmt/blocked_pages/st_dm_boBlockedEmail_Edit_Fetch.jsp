	<%@ taglib prefix="s" uri="/struts-tags"%>
	<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
	<script type="text/javascript">
$(document).ready(function() {
		$("#plrTxnDayWiseTable").tablesorterPager({ container: $("#pagerOne"), positionFixed: false ,size : 1}) ;
});
</script>


<script type="text/javascript">
function getedit(e)
{
	//alert(e);
	document.getElementById(e).disabled=true;
	//document.getElementById(e).readonly=true;
	//document.getElementById(e).style.backgroundColor="red";
	//return false;
}

function submitForm(){
	var arr = $(":input[type='text']");
	for(var i=0; i< arr.length; i++){
		if(arr[i].disabled){
			arr[i].disabled = false;
		}
		else{
			arr[i].disabled = true;
		}
	}
	//alert(arr);
}

</script>
<div class="FormSection">
<s:form id="RegistrationDomain" action="bo_dm_blockEmail_Edit_Save.action"	theme="simple">
		<div class="greyStrip">
			<h4>
				E-mail Address
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
										
										<ss:textfield name="email" theme="myTheme" maxlength="25"
											id="domainIp_%{key}"
											cssStyle="width:18%" 
											value="%{value}" pattern="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$"
							errorMassage="Please Enter Valid Email Id"  patternOn="blur"/> 
					
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
				<s:a  onclick="addnewblockIP()" title="Add to Block IP" 
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
				<s:a  onclick="addnewblockIP()" title="Add to Block IP" 
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
	
	
					