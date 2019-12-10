<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
	String path = request.getContextPath();
%>
<html>
	<head>
	<STYLE type="text/css">
	
	</STYLE>
		<script>
	var redips_url = '/javascript/drag-and-drop-table-row/';
</script>
		<script>

	$(document).ready(function() {
		redips_init();
		if(<%=((Map) request.getAttribute("pageWiseFieldMap")).size()%>==0){
			$(":radio[id*='SINGLEPAGE']").attr("checked","checked");
		
		}
		else{
			$(":radio[id*='MULTIPAGE']").attr("checked","checked");
			}
		
		

	});
</script>
	</head>
	<body>
	
		
        <div class="innerBox">
		<div id="drag" style="width: 100%; height: auto">

			<table class="nolayout" width="100%">
				<tr>
					<td style="width: 90%; height: auto; float: left;" id="main_td">
						<s:form action="bo_pm_save_fieldlist" method="POST"
							onsubmit="" theme="simple" id="frm" >

							<table class=""></table>



							<s:if test="%{pageWiseFieldMap.size!=0}">
								<s:set value="%{pageWiseFieldMap}" name="map"></s:set>
							</s:if>
							<s:else>
								<s:set value="%{sectionWiseFieldMap}" name="map"></s:set>
							</s:else>
							<table id="masterTable" width="100%">
								<s:iterator value="%{#map}" status="pageNo">
									<tr id="firstRow">
										<td class="rowhandler" valign="top" style="padding-top: 5px;">
											<div class="drag row" style="float:right; width:16px;margin-right: 5px;" align="center"><img src="<%=path %>/images/dragIcon1.gif" id="dragIcon1"/></div>
										</td>
										<td>
											<table class="nolayout" cellpadding="0" cellspacing="0" width="100%">
												<tr style="background-color: #E7E7E7; display: block; font-size: 12px;color: black; border-top: 1px solid #C6C6C6; border-left: 1px solid #C6C6C6; border-right: 1px solid #C6C6C6;">
													<td colspan="7" class="mark" style="height: 30px; padding-left:6px">
														<s:if test="%{pageWiseFieldMap.size==0}">Section No. <s:textfield value="%{#pageNo.index+1}"
																id="page" theme="simple" readonly="true" cssStyle="background: #ffffff; color:black; border:1px #c6c6c6 solid "></s:textfield> &nbsp; &nbsp; Section Name <s:textfield
																name="sectionName" theme="simple" cssStyle="background: #ffffff; color:#000; font-size:12px; border:1px #c6c6c6 solid " value="%{resource.getProperty('global.'+key)}" id="sectionName" maxlength="50"></s:textfield>
														<s:hidden name="sectionNameCode" value="%{key}"/></s:if>
														<s:else>Page No. <s:textfield value="%{key}"
																id="page" theme="simple" readonly="true" cssStyle="background: #ffffff; color:black; border:1px #c6c6c6 solid "></s:textfield> Page Name <s:textfield
																name="sectionName" theme="simple"
																value="%{resource.getProperty('global.'+value.get(0).sectionNameCode)}" id="sectionName" cssStyle="background: #ffffff; color:#000000; font-size:12px; border:1px #c6c6c6 solid " maxlength="50"></s:textfield>
														<s:hidden name="sectionNameCode" value="%{value.get(0).sectionNameCode}"/></s:else>
													</td>
												</tr>
												<tr >
													<td>
														<table id="managePaging" class="addedRows" >

															<tr class="mark" style="background-color: white; color: #333333;">
																<th class="mark"></th>
																
																<th class="mark" style="padding-left: 5px">
																	Field Name
																</th>
																<th class="mark" style="padding-left: 5px">
																	Field Display Name
																</th>

																<th class="mark" style="padding-left: 5px">
																	Mandatory
																</th>
																<th class="mark" style="padding-left: 5px">
																	Part of Mini-Reg
																</th>
																<th class="mark">
																	
																</th>


															</tr>
															<s:iterator value="value" status="fieldlist">

																<s:if test='%{isEditable.equals("N")}'>
																	<tr
																		id="<s:property value='%{#pageNo.index}'/>_fieldlist_<s:property value='%{#fieldlist.index}'/>">
																		<td class="rowhandler">
																			<div class="drag row"><img src="<%=path %>/images/dragIcon2.gif"/></div>
																		</td>
																		
																		<td id="fieldName" >
																			<s:textfield name="fieldName" value="%{fieldName}"
																				id="fieldName" readonly="true" theme="simple"
																				maxlength="20" cssStyle="background: #f2f2f2;border:1px #c6c6c6 solid; color:#c6c6c6 "></s:textfield>

																		</td>
																		<td id="fieldDispName">
																			<s:textfield name="fieldDispName"
																				value="%{resource.getProperty('global.'+fieldDispCode)}" id="fieldDispNameId"
																				readonly="true" theme="simple" maxlength="50" cssStyle="background:#f2f2f2; border-radius:0px; color: #c6c6c6; font-size:13px;  border:1px solid #C6C6C6;"></s:textfield>


																		</td>


																		<td id="selectFieldType">
																			<s:select
																				list="#{'Y':'Y','N':'N'}"
																				value="%{isMandatory}" name="fieldType" theme="simple"
																				disabled="true" id="fieldType" cssStyle="background: #f2f2f2; color:#c6c6c6 " cssClass="selectMP"></s:select>

																		</td>
																		<td id="selectMini">
																			<s:select
																				list="#{'Y':'Y','N':'N'}"
																				value="%{isPartOfMiniReg}" name="isPartOfMiniReg" theme="simple" accesskey="%{fieldName}"
																				disabled="true" id="isPartOfMiniReg" cssStyle="background: #f2f2f2; color:#c6c6c6 " cssClass="selectMP"></s:select>

																		</td>
																		<td></td>
																		<s:hidden name="isShow" value="%{isShow}"
																			id="isShow"></s:hidden>
																		<s:hidden name="pageNumber" value="%{pageSectionNo}"
																			id="pageNumber"></s:hidden>
																		<s:hidden name="fieldSequenceNo"
																			value="%{fieldSequenceNo}" id="fieldSequenceNo"></s:hidden>
																		<s:hidden name="fieldId" value="%{fieldId}"
																			id="fieldId"></s:hidden>
																		<s:hidden name="alertStr" value="%{helpStringCode}"
																			id="alertStr"></s:hidden>
																		<s:hidden name="fieldInputType"
																			value="%{fieldInputType}" id="fieldInputType"></s:hidden>
																		<s:hidden name="optionValues" value="%{optionValues}"
																			id="optionValues"></s:hidden>
																			<s:hidden name="fieldDispCode" value="%{fieldDispCode}"
																			id="fieldDispCode"></s:hidden>
																			<s:hidden name="miniSeqNo" value="%{miniRegSeqNo}"
																			id="%{fieldName}_miniSeqNo"></s:hidden>
																		
																	</tr>
																</s:if>
																<s:else>
																	<tr
																		id="<s:property value='%{#pageNo.index}'/>_fieldlist_<s:property value='%{#fieldlist.index}'/>">
																		<td class="rowhandler">
																			<div class="drag row"><img src="<%=path %>/images/dragIcon2.gif"/></div>
																		</td>
																		
																		<td id="fieldName" >
																			<s:textfield name="fieldName" value="%{fieldName}"
																				id="fieldName" theme="simple" readonly="true" cssStyle="background: #f2f2f2; border:1px #c6c6c6 solid; color:#c6c6c6 "></s:textfield>

																		</td>
																		<td id="fieldDispName" style="">
																			<s:textfield name="fieldDispName"
																				value="%{resource.getProperty('global.'+fieldDispCode)}" id="fieldDispNameId"
																				theme="simple" maxlength="50" cssStyle="background: #ffffff; border:1px #c6c6c6 solid; border-radius:0px; font-size:13px;"></s:textfield>


																		</td>


																		<td id="selectFieldType">
																			<s:select
																				list="#{'Y':'Y','N':'N'}"
																				value="%{isMandatory}" name="fieldType" theme="simple"
																				id="fieldType" cssClass="selectMP"></s:select>

																		</td>
																		<td id="selectMini">
																			<s:select
																				list="#{'Y':'Y','N':'N'}"
																				value="%{isPartOfMiniReg}" name="isPartOfMiniReg" theme="simple"
																				id="isPartOfMiniReg" cssClass="selectMP" accesskey="%{fieldName}"></s:select>

																		</td>
																		<td align="center">
							<s:a href="#"
								onclick="deleteField('%{key}','%{#pageNo.index}_fieldlist_%{#fieldlist.index}');return false;"><IMG src="<%=path %>/images/close.gif"></s:a>
						</td>										
																		<s:hidden name="isShow" value="%{isShow}"
																			id="isShow"></s:hidden>
																		<s:hidden name="pageNumber" value="%{pageSectionNo}"
																			id="pageNumber"></s:hidden>
																		<s:hidden name="fieldSequenceNo"
																			value="%{fieldSequenceNo}" id="fieldSequenceNo"></s:hidden>
																		<s:hidden name="fieldId" value="%{fieldId}"
																			id="fieldId"></s:hidden>
																		<s:hidden name="alertStr" value="%{helpStringCode}"
																			id="alertStr"></s:hidden>
																		<s:hidden name="fieldInputType"
																			value="%{fieldInputType}" id="fieldInputType"></s:hidden>
																		<s:hidden name="optionValues" value="%{optionValues}"
																			id="optionValues"></s:hidden>
																			<s:hidden name="fieldDispCode" value="%{fieldDispCode}"
																			id="fieldDispCode"></s:hidden>
																			<s:hidden name="miniSeqNo" value="%{miniRegSeqNo}"
																			id="%{fieldName}_miniSeqNo"></s:hidden>

																	</tr>

																</s:else>

																	
															</s:iterator>
															<!-- <tr>
																<td colspan="7" class="mark">
																	<span>Message line</span>
																</td>
															</tr>-->
														</table>
													</td>
												</tr>
											</table><br>
										</td>
									</tr>

								</s:iterator>
								
							</table>
							
							<s:hidden name="domainId" id="domain" value="%{domainId}"></s:hidden>
							<s:hidden name="regType" id="regTp" value="%{regType}"></s:hidden>
							
						</s:form>
					</td>
					<td
						style="width: 25%; height: auto;" id="ID_delete" valign="top">
						<div style="border-top: 1px solid #C6C6C6; border-left: 1px solid #C6C6C6; border-right: 1px solid #C6C6C6; display: block; height: 30px; font-size: 14px; line-height:27px; font-weight:bold; background-color: #E7E7E7; color: #333333; padding: " align="center"> Spare Fields</div>
						<div style="background:#E0E0E0; min-height:650px; height:auto; width: 100%; margin-top: 2px;">
						<table id="managePaging" class="deletedRows" style="margin-top:-2px">
							<tr>
								<th class="mark"></th>
								
								<th class="mark" style="padding-left: 5px">
									Field Name
								</th>




							</tr>
							
							<s:iterator value='%{spareFieldList}'
								status="masterFieldList">
								<s:if test='%{isEditable.equals("N")}'>
																	<tr
																		id="masterFieldList_<s:property value='%{#masterFieldList.index}'/>" class="">
																		<td class="rowhandler">
																			<div class="drag row"><img src="<%=path %>/images/dragIcon2.gif"/></div>
																		</td>
																		
																		<td id="fieldName" >
																			<s:textfield name="fieldName" value="%{fieldName}"
																				id="fieldName" readonly="true" theme="simple"
																				maxlength="20" cssStyle="background: #f2f2f2;border:1px #c6c6c6 solid; color:#c6c6c6 "></s:textfield>

																		</td>
																		<td id="fieldDispName" style="display: none;">
																			<s:textfield name="fieldDispName"
																				value="%{resource.getProperty('global.'+fieldDispCode)}" id="fieldDispNameId"
																				readonly="true" theme="simple" maxlength="50" cssStyle="background: #f2f2f2; border-radius:0px; color:#c6c6c6; font-size:13px; border:1px solid #C6C6C6"></s:textfield>


																		</td>


																		<td id="selectFieldType" style="display: none;">
																			<s:select
																				list="#{'Y':'Y','N':'N'}"
																				value="%{isMandatory}" name="fieldType" theme="simple"
																				disabled="true" id="fieldType" cssStyle="background: #f2f2f2; color:#c6c6c6 " cssClass="selectMP"></s:select>

																		</td>
																		<td id="selectMini" style="display: none;">
																			<s:select
																				list="#{'Y':'Y','N':'N'}"
																				value="%{isPartOfMiniReg}" name="isPartOfMiniReg" theme="simple" accesskey="%{fieldName}"
																				disabled="true" id="isPartOfMiniReg" cssStyle="background: #f2f2f2; color:#c6c6c6 " cssClass="selectMP"></s:select>

																		</td>
																		<td style="display: none;">
							
						</td>
																		<s:hidden name="isShow" value="%{isShow}"
																			id="isShow"></s:hidden>
																		<s:hidden name="pageNumber" value="%{pageSectionNo}"
																			id="pageNumber"></s:hidden>
																		<s:hidden name="fieldSequenceNo"
																			value="%{fieldSequenceNo}" id="fieldSequenceNo"></s:hidden>
																		<s:hidden name="fieldId" value="%{fieldId}"
																			id="fieldId"></s:hidden>
																		<s:hidden name="alertStr" value="%{resource.getProperty('global.'+helpStringCode)}"
																			id="alertStr"></s:hidden>
																		<s:hidden name="fieldInputType"
																			value="%{fieldInputType}" id="fieldInputType"></s:hidden>
																		<s:hidden name="optionValues" value="%{optionValues}"
																			id="optionValues"></s:hidden>
																			<s:hidden name="fieldDispCode" value="%{fieldDispCode}"
																			id="fieldDispCode"></s:hidden>
																			<s:hidden name="miniSeqNo" value="%{miniRegSeqNo}"
																			id="%{fieldName}_miniSeqNo"></s:hidden>

																	</tr>
																</s:if>
																<s:else>
																	<tr
																		id="masterFieldList_<s:property value='%{#masterFieldList.index}'/>">
																		<td class="rowhandler">
																			<div class="drag row"><img src="<%=path %>/images/dragIcon2.gif"/></div>
																		</td>
																		
																		<td id="fieldName" >
																			<s:textfield name="fieldName" value="%{fieldName}" readonly="true"
																				id="fieldName" theme="simple" cssStyle="background: #f2f2f2; border:1px #c6c6c6 solid; color: #c6c6c6  "></s:textfield>

																		</td>
																		<td id="fieldDispName" style="display: none;">
																			<s:textfield name="fieldDispName"
																				value="%{resource.getProperty('global.'+fieldDispCode)}" id="fieldDispNameId"
																				theme="simple" maxlength="50" cssStyle="background: #ffffff; border:1px #c6c6c6 solid; border-radius:0px; font-size:13px;"></s:textfield>


																		</td>


																		<td id="selectFieldType" style="display: none;">
																			<s:select
																				list="#{'Y':'Y','N':'N'}"
																				value="%{isMandatory}" name="fieldType" theme="simple" 
																				id="fieldType" cssClass="selectMP" ></s:select>

																		</td>
																		<td id="selectMini" style="display: none;">
																			<s:select
																				list="#{'Y':'Y','N':'N'}"
																				value="%{isPartOfMiniReg}" name="isPartOfMiniReg" theme="simple"
																				id="isPartOfMiniReg"  cssClass="selectMP" accesskey="%{fieldName}"></s:select>

																		</td>
																		 <td style="display: none;" align="center">
							<s:a href="#"
								onclick="deleteField('%{#masterFieldList.index}','masterFieldList_%{#masterFieldList.index}');return false;"><IMG src="<%=path %>/images/close.gif"></s:a>
						</td>									<s:hidden name="isShow" value="%{isShow}"
																			id="isShow"></s:hidden>
																		<s:hidden name="pageNumber" value="%{pageSectionNo}"
																			id="pageNumber"></s:hidden>
																		<s:hidden name="fieldSequenceNo"
																			value="%{fieldSequenceNo}" id="fieldSequenceNo"></s:hidden>
																		<s:hidden name="fieldId" value="%{fieldId}"
																			id="fieldId"></s:hidden>
																		<s:hidden name="alertStr" value="%{resource.getProperty('global.'+helpStringCode)}"
																			id="alertStr"></s:hidden>
																		<s:hidden name="fieldInputType"
																			value="%{fieldInputType}" id="fieldInputType"></s:hidden>
																		<s:hidden name="optionValues" value="%{optionValues}"
																			id="optionValues"></s:hidden>
																		<s:hidden name="fieldDispCode" value="%{fieldDispCode}"
																			id="fieldDispCode"></s:hidden>
																		<s:hidden name="miniSeqNo" value="%{miniRegSeqNo}"
																			id="%{fieldName}_miniSeqNo"></s:hidden>
																	</tr>

																</s:else>
																		
							</s:iterator>

							
						</table>
						</div>
					</td>
				</tr>
			</table>
				<div style="top: 445px; left: 406px;display: none;" id="facebox">
					<div class="popup">
						<div class="content"><p style="font-size: 14px;"><b>Mini Registration Fields Sequence</b></p>
							<table id="minifieldfaceBox" style="width: 100%;background-color: #E0E0E0">
							</table>
							<input type="button" class="button" onclick="if(setFieldSectionPage()){formSubmitRegistrationEdit('frm','decoBody');}" value="Submit" style="float: right"></input>
						</div>
							<a class="close" href="#" onclick="closeFacebox(); return false;"><img class="close_image"
									title="close" src="/<%=path %>/images/closelabel.png">
							</a>
						
					</div>
				</div>
				<div class="facebox_hide facebox_overlayBG" id="facebox_overlay" style="display: none; opacity: 0.4;"></div>
			</div>
	<div class="box_footer" style="padding-left: 10px; padding-right:28px; margin-left: -19px;" align="right">
							<input type="button" align="center" class="button" onclick="if(setMiniSequence() && setFieldSectionPage()){formSubmitRegistrationEdit('frm','decoBody');}" value="Submit"></input>
							<input type="button" class="button" onclick="showPreview()" name="preview" id="preview" value="Preview"/>
							</div>
</div>

	</body>

</html>