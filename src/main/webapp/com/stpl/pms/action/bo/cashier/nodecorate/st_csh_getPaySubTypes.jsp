<%@ taglib uri="/struts-tags" prefix="s"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>
<div class="FormSection">
	<div class="greyStrip">
		<h4>Payment Sub Types</h4>	
	</div>
		<form name="chngStatusForm" id="chngStatusForm" action="st_pms_csh_payTypeChngStatus.action" method="post">
			<s:hidden id="payTypeCode" name="paymentTypeCode"></s:hidden>
			<div class="innerBox">
				<s:if test="%{true}">
					<s:hidden id="payTypeId" value="%{paySubTypesList.get(0).getPaymentTypeId()}" name="paySubType.typeId"></s:hidden>
					
						<s:if test='%{"CREDIT_CARD".equals(paymentTypeCode)}'>
							<table class="payTransaction">
								<thead>
									<tr>
										<th width="50">Select</th>
										<th data-propName="cardName">Card Name</th>
										<th width="155">Status</th>
										<th width="71" style="display: none;">Edit</th>
									</tr>
								</thead>
								<tbody>
									<s:iterator value="%{paySubTypesList}">
										<tr data-id='<s:property value="%{subTypeId}"/>'>
											<td><input type="checkbox" class="checkRow" name="paySubType.subTypeIdArr"  id='chkBx_<s:property value="%{subTypeId}"/>'  value='<s:property value="%{subTypeId}"/>' /></td>
											<td data-propName="cardName"><s:property value="cardName"/></td>
											<td><s:property value="status"/></td>
											<td style="display: none;"><button style="margin: 0 !important;" disabled="disabled" class="editAction">Edit</button></td>
										</tr>
									</s:iterator>
								</tbody>
							</table>
							<script type="text/javascript">
								$(function(){
									$("#addNewBtn").hide();
								})
							</script>
						</s:if>
						<s:elseif test='%{"DEBIT_CARD".equals(paymentTypeCode)}'>
							<table class="payTransaction">
								<thead>
									<tr>
										<th width="50">Select</th>
										<th data-propName="cardName">Card Name</th>
										<th width="155">Status</th>
										<th width="71" style="display: none;">Edit</th>
									</tr>
								</thead>
								<tbody>
									<s:iterator value="%{paySubTypesList}">
										<tr data-id='<s:property value="%{subTypeId}"/>'>
											<td><input type="checkbox" class="checkRow" name="paySubType.subTypeIdArr"  id='chkBx_<s:property value="%{subTypeId}"/>'  value='<s:property value="%{subTypeId}"/>' /></td>
											<td data-propName="cardName"><s:property value="%{cardName}"/></td>
											<td><s:property value="status"/></td>
											<td style="display: none;"><button style="margin: 0 !important;" disabled="disabled" class="editAction">Edit</button></td>
										</tr>
									</s:iterator>
								</tbody>
							</table>
							<script type="text/javascript">
								$(function(){
									$("#addNewBtn").hide();
								})
							</script>
						</s:elseif>
						<s:elseif test='%{"NET_BANKING".equals(paymentTypeCode)}'>
							<table id="payTable" class="payTransaction">
								<thead>
									<tr>
										<th width="50">Select</th>
										<th data-propName="bankNameDispCode">Bank</th>
										<th data-propName="countryId" width="200">Country</th>
										<th width="155">Status</th>
										<th width="71">Edit</th>
									</tr>
								</thead>
								<tbody>
									<s:iterator value="%{paySubTypesList}">
										<tr data-id='<s:property value="%{subTypeId}"/>' >
											<td><input type="checkbox" class="checkRow" name="paySubType.subTypeIdArr"  id='chkBx_<s:property value="%{subTypeId}"/>'  value='<s:property value="%{subTypeId}"/>' /></td>
											<td data-propName="bankNameDispCode"><s:property value="bankNameDispCode"/></td>
											<td data-propName="countryId" data-propVal="<s:property value='%{countryId}'/>"><s:property value='%{countryMap.get(countryId)}'/></td>
											<td><s:property value="status"/></td>
											<td><button style="margin: 0 !important;" class="editAction">Edit</button></td>
										</tr>
									</s:iterator>
								</tbody>
							</table>
						</s:elseif>
						<s:elseif test='%{"CASH_PAYMENT".equals(paymentTypeCode)}'>
							<table class="payTransaction">
								<thead>
									<tr>
										<th width="50">Select</th>
										<th data-propName="cshpayTypeDispCode">Display Code</th>
										<th width="155">Status</th>
										<th width="71">Edit</th>
									</tr>
								</thead>
								<tbody>
									<s:iterator value="%{paySubTypesList}">
										<tr data-id='<s:property value="%{subTypeId}"/>'>
											<td><input type="checkbox" class="checkRow" name="paySubType.subTypeIdArr"  id='chkBx_<s:property value="%{subTypeId}"/>'  value='<s:property value="%{subTypeId}"/>' /></td>
											<td data-propName="cshpayTypeDispCode"><s:property value="cshpayTypeDispCode"/></td>
											<td><s:property value="status"/></td>
											<td><button style="margin: 0 !important;" class="editAction">Edit</button></td>
										</tr>
									</s:iterator>
								</tbody>
							</table>
						</s:elseif>
						<s:elseif test='%{"TP_PAYMENT".equals(paymentTypeCode)}'>
							<table class="payTransaction">
								<thead>
									<tr>
										<th width="50">Select</th>
										<th data-propName="tpPaymentTypeDispCode">Display Code</th>
										<th width="155">Status</th>
										<th width="71">Edit</th>
									</tr>
								</thead>
								<tbody>
									<s:iterator value="%{paySubTypesList}">
										<tr data-id='<s:property value="%{subTypeId}"/>'>
											<td><input type="checkbox" class="checkRow" name="paySubType.subTypeIdArr"  id='chkBx_<s:property value="%{subTypeId}"/>'  value='<s:property value="%{subTypeId}"/>' /></td>
											<td data-propName="tpPaymentTypeDispCode"><s:property value="tpPaymentTypeDispCode"/></td>
											<td><s:property value="status"/></td>
											<td><button style="margin: 0 !important;" class="editAction">Edit</button></td>
										</tr>
									</s:iterator>
								</tbody>
							</table>
						</s:elseif>
						<s:elseif test='%{"CASH_COLLECTION".equals(paymentTypeCode)}'>
							<table class="payTransaction cash-cl" width="960">
								<thead>
									<tr>
										<th width="50">Select</th>
										<th data-propName="countryId" width="100">Country</th>
										<th data-propName="city" width="80">City</th>
										<th data-propName="pinCode" width="510">Pin Code</th>
										<th width="175">Status</th>
										<th width="95">Edit</th>
									</tr>
								</thead>
								<tbody>
									<s:iterator value="%{paySubTypesList}">
										<tr data-id='<s:property value="%{subTypeId}"/>'>
											<td><input type="checkbox" class="checkRow" name="paySubType.subTypeIdArr"  id='chkBx_<s:property value="%{subTypeId}"/>'  value='<s:property value="%{subTypeId}"/>' /></td>
											<td width="100" data-propName="countryId" data-propVal="<s:property value='%{countryId}'/>"><s:property value='%{countryMap.get(countryId)}'/></td>
											<td width="80"  data-propName="city"><s:property value="%{city}"/></td>
											<td width="510" data-propName="pinCode"><s:property value="%{pinCodeString}"/></td>
											<td width="175"><s:property value="status"/></td>
											<td width="95"><button style="margin: 0 !important;" class="editAction">Edit</button></td>
										</tr>
									</s:iterator>
								</tbody>
							</table>
						</s:elseif>
						<s:elseif test='%{"BANK_TRANS".equals(paymentTypeCode)}'>
							<table class="payTransaction">
								<thead>
									<tr>
										<th width="50">Select</th>
										<th data-propName="bankNameDispCode">Bank</th>
										<th data-propName="countryId"width="200">Country</th>
										<th width="155">Status</th>
										<th width="71">Edit</th>
									</tr>
								</thead>
								<tbody>
									<s:iterator value="%{paySubTypesList}">
										<tr data-id='<s:property value="%{subTypeId}"/>'>
											<td><input type="checkbox" class="checkRow" name="paySubType.subTypeIdArr"  id='chkBx_<s:property value="%{subTypeId}"/>'  value='<s:property value="%{subTypeId}"/>' /></td>
											<td data-propName="bankNameDispCode"><s:property value="%{bankNameDispCode}"/></td>
											<td data-propName="countryId" data-propVal="<s:property value='%{countryId}'/>"><s:property value='%{countryMap.get(countryId)}'/></td>
											<td><s:property value="status"/></td>
											<td><button style="margin: 0 !important;" class="editAction">Edit</button></td>
										</tr>
									</s:iterator>
								</tbody>
							</table>
						</s:elseif>
						<s:elseif test='%{"CASH_CARD".equals(paymentTypeCode)}'>
							<table class="payTransaction">
								<thead>
									<tr>
										<th width="50">Select</th>
										<th data-propName="cardName">Card Name</th>
										<th width="155">Status</th>
										<th width="71" style="display: none;">Edit</th>
									</tr>
								</thead>
								<tbody>
									<s:iterator value="%{paySubTypesList}">
										<tr data-id='<s:property value="%{subTypeId}"/>'>
											<td><input type="checkbox" class="checkRow" name="paySubType.subTypeIdArr"  id='chkBx_<s:property value="%{subTypeId}"/>'  value='<s:property value="%{subTypeId}"/>' /></td>
											<td data-propName="cardName"><s:property value="%{cardName}"/></td>
											<td><s:property value="status"/></td>
											<td style="display: none;"><button style="margin: 0 !important;"  disabled="disabled" class="editAction">Edit</button></td>
										</tr>
									</s:iterator>
								</tbody>
								<script type="text/javascript">
									$(function(){
										$("#addNewBtn").hide();
									})
								</script>
							</table>
						</s:elseif>
						<s:elseif test='%{"PREPAID_WALLET".equals(paymentTypeCode)}'>
							<table class="payTransaction">
							<thead>
								<tr>
									<th width="50">Select</th>
									<th data-propName="walletName">Wallet Name</th>
									<th width="155">Status</th>
									<th width="71">Edit</th>
								</tr>
							</thead>
							<tbody>
								<s:iterator value="%{paySubTypesList}">
									<tr data-id='<s:property value="%{subTypeId}"/>'>
										<td><input type="checkbox" class="checkRow" name="paySubType.subTypeIdArr"  id='chkBx_<s:property value="%{subTypeId}"/>'  value='<s:property value="%{subTypeId}"/>' /></td>
										<td data-propName="walletName"><s:property value="%{walletName}"/></td>
										<td><s:property value="status"/></td>
										<td><button style="margin: 0 !important;" class="editAction">Edit</button></td>
									</tr>
								</s:iterator>
							</tbody>
						</table>
					</s:elseif>
					<s:elseif test='%{"MOBILE_WALLET".equals(paymentTypeCode)}'>
							<table class="payTransaction">
							<thead>
								<tr>
									<th width="50">Select</th>
									<th data-propName="walletName">Wallet Name</th>
									<th width="155">Status</th>
									<th width="71">Edit</th>
								</tr>
							</thead>
							<tbody>
								<s:iterator value="%{paySubTypesList}">
									<tr data-id='<s:property value="%{subTypeId}"/>'>
										<td><input type="checkbox" class="checkRow" name="paySubType.subTypeIdArr"  id='chkBx_<s:property value="%{subTypeId}"/>'  value='<s:property value="%{subTypeId}"/>' /></td>
										<td data-propName="walletName"><s:property value="%{walletName}"/></td>
										<td><s:property value="status"/></td>
										<td><button style="margin: 0 !important;" class="editAction">Edit</button></td>
									</tr>
								</s:iterator>
							</tbody>
						</table>
					</s:elseif><s:elseif test='%{"PAYTM_WALLET".equals(paymentTypeCode)}'>
							<table class="payTransaction">
							<thead>
								<tr>
									<th width="50">Select</th>
									<th data-propName="walletName">Wallet Name</th>
									<th width="155">Status</th>
									<th width="71">Edit</th>
								</tr>
							</thead>
							<tbody>
								<s:iterator value="%{paySubTypesList}">
									<tr data-id='<s:property value="%{subTypeId}"/>'>
										<td><input type="checkbox" class="checkRow" name="paySubType.subTypeIdArr"  id='chkBx_<s:property value="%{subTypeId}"/>'  value='<s:property value="%{subTypeId}"/>' /></td>
										<td data-propName="walletName"><s:property value="%{walletName}"/></td>
										<td><s:property value="status"/></td>
										<td><button style="margin: 0 !important;" class="editAction">Edit</button></td>
									</tr>
								</s:iterator>
							</tbody>
						</table>
					</s:elseif>
					<s:elseif test='%{"FREECHARGE_WALLET".equals(paymentTypeCode)}'>
						<table class="payTransaction">
							<thead>
							<tr>
								<th width="50">Select</th>
								<th data-propName="walletName">Wallet Name</th>
								<th width="155">Status</th>
								<th width="71">Edit</th>
							</tr>
							</thead>
							<tbody>
							<s:iterator value="%{paySubTypesList}">
								<tr data-id='<s:property value="%{subTypeId}"/>'>
									<td><input type="checkbox" class="checkRow" name="paySubType.subTypeIdArr"  id='chkBx_<s:property value="%{subTypeId}"/>'  value='<s:property value="%{subTypeId}"/>' /></td>
									<td data-propName="walletName"><s:property value="%{walletName}"/></td>
									<td><s:property value="status"/></td>
									<td><button style="margin: 0 !important;" class="editAction">Edit</button></td>
								</tr>
							</s:iterator>
							</tbody>
						</table>
					</s:elseif>

					<s:elseif test='%{"UPI_PAYMENT".equals(paymentTypeCode)}'>
							<table class="payTransaction">
							<thead>
								<tr>
									<th width="50">Select</th>
									<th data-propName="walletName">Wallet Name</th>
									<th width="155">Status</th>
									<th width="71">Edit</th>
								</tr>
							</thead>
							<tbody>
								<s:iterator value="%{paySubTypesList}">
									<tr data-id='<s:property value="%{subTypeId}"/>'>
										<td><input type="checkbox" class="checkRow" name="paySubType.subTypeIdArr"  id='chkBx_<s:property value="%{subTypeId}"/>'  value='<s:property value="%{subTypeId}"/>' /></td>
										<td data-propName="walletName"><s:property value="%{walletName}"/></td>
										<td><s:property value="status"/></td>
										<td><button style="margin: 0 !important;" class="editAction">Edit</button></td>
									</tr>
								</s:iterator>
							</tbody>
						</table>
					</s:elseif>
				
				
			</s:if>
			<%-- <s:else>
				<div class="innerBox">
					<div class="alert info_msg " style="width: auto">
						<span class="alert_close"></span><strong>Info: </strong> No record found!
					</div>
				</div>
			</s:else> --%>
			<div style="margin: 15px;"></div>
		</div>
		<div class="box_footer" align="right">
			<button id="addNewBtn">add more</button>
			<s:submit class="chngStatus" name="paySubType.status" value="ACTIVE"></s:submit>
			<s:submit class="chngStatus" name="paySubType.status" value="INACTIVE"></s:submit>
		</div>
	</form>
</div>
<div id="addNewForm" style="display: none;">
	<div class="FormSection">
		<div class="greyStrip">
			<h4></h4>
		</div>
		<form method="post" action="st_pms_csh_createNewSubType.action" id="createSubPay">
			<div class="innerBox">
				<s:if test="%{countryMap!=null}">
					<div class="FormMainBox">
						<div class="labelDiv"><label>Country</label> <em class="Req">*</em></div>
						<div class="InputDiv">
							<s:select applyscript="true" id="payCountry" name="paySubType.countryId" headerKey="" headerValue="--Please Select--" list="%{countryMap}" theme="myTheme" cssClass="select1"></s:select>
						</div>
					</div>
					<div class="clearFRM"></div>
				</s:if>
				<div id="dynamicArea"></div>
			</div>
			<s:token />
			<s:hidden name="paySubType.typeCode" value="%{paymentTypeCode}" id="newSubTypeCode"></s:hidden>
			<s:hidden name="paySubType.typeId" value="%{paySubTypesList.get(0).getPaymentTypeId()}" id="newSubTypeId"></s:hidden>
			<div class="box_footer">
				<s:submit id="editCancel" type="button">cancel</s:submit>
				<s:submit id="createSubPaybtn"></s:submit>				
			</div>
		</form>
	</div>    	
</div>
<script>
	var createDynForm=function(row){
		$("#dynamicArea").empty();
		//discovering displayNames and properties...
		var refRow=row||$("div#tabContainer table tbody tr:last");
		//console.log(refRow);
		var rowhead=$("div#tabContainer table tr:first");
		var columns=refRow.find("td");
		var headings=rowhead.find("th");
		var paramNameArr=[];
		var displayNameArr=[];
		var paramValArr=[];
		
		//console.log(columns);
		//console.log(headings);
		for(i=0;i<(columns.length-2);i++)
			if(window.textField.indexOf($(columns[i]).attr("data-propname"))!=-1){
				paramNameArr.push("paySubType."+$(columns[i]).attr("data-propname"));
				displayNameArr.push($(headings[i]).text());
				paramValArr.push($(columns[i]).text());
				//console.log($(headings[i]).text()+"\("+$(columns[i]).attr("data-propname")+"\)==>"+$(columns[i]).text());
			}
		
		var dynfields="";
		
		//creating form...
		for(i=0;i<displayNameArr.length;i++){
			dynfields+='<div class=\"FormMainBox\">'+
					'<div class=\"labelDiv\">'+
						'<label>'+displayNameArr[i]+'</label> <em class=\"Req">*</em>'+
					'</div>'+
				'<div class=\"InputDiv\">'+
					'<input type="text" id="'+paramNameArr[i].split(".")[1]+'" applyscript="true" name=\"'+paramNameArr[i]+'\"';
			if(row)
				dynfields+=' value=\"'+paramValArr[i]+'\" ';
			dynfields+='\/>'+
				'</div>'+
			'</div>'+
			'<div class="clearFRM"></div>';
		}		
		
			
		$("#newSubTypeCode").val($("#payTypeCode").val());
		$("#newSubTypeId").val($("#payTypeId").val());
		
		//console.log(dynfields);
		$("#dynamicArea").append(dynfields);
		
		$("#dynamicArea").append('<div class=\"FormMainBox\"><div class=\"labelDiv\"><label>Status</label></div><div class=\"InputDiv\"><select applyscript=\"true\" id="payStatus" name=\"paySubType.status\" class="select1"><option value="ACTIVE">ACTIVE</option><option value="INACTIVE">INACTIVE</option></select></div></div>');
		if(window.cntryReqLst.indexOf($("#payTypeMast").val())!=-1)
			$("#dynamicArea").append(refRow.find);
		
		if(row){
			$("#payCountry").val($(refRow.find("td[data-propval]")).attr("data-propval"));
			$("#payStatus").val($(columns[columns.length-2]).text());
			$("#dynamicArea").append("<input type=\"hidden\" name=\"paySubType.subTypeId\" value=\""+$(refRow).attr("data-id")+"\" \/>");
		}
		createBubble();
		$("#addNewForm").show();
		
		//scrolls to the form...
		$(document).scrollTop($("#addNewForm").offset().top);
		return false;
	};
	$("#addNewBtn").click(function(){
		$("#addNewForm h4").text("Add New Payment Sub Type");
		return createDynForm();
	});
	$("#editCancel").click(function(){
		$("#dynamicArea").empty();
		$("#addNewForm").hide();
		return false;
	});
	$("#chngStatusForm").submit(function(){
		if(!($(".checkRow:checked").length>0)){
			alert("Please select one or more rows!");
			return false;
		}
	});
</script>
	

