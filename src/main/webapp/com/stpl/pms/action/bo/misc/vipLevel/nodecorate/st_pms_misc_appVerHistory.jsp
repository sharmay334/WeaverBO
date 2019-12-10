<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<html>
<script type="text/javascript">

	$(function(){
		$("#appType").change(function(){

			if("CASH"==this.value && "false"==="<s:property value='%{cashAppExists}'/>"){

					$($(".mandate")[0]).attr('checked', true);
					$($(".mandate")[1]).attr('disabled', true);


			}else if ("FREE"==this.value && "false"==="<s:property value='%{freeAppExists}'/>") {

					$($(".mandate")[0]).attr('checked', true);
					$($(".mandate")[1]).attr('disabled', true);
			}else{

				$($(".mandate")[1]).attr('disabled', false);
				$($(".mandate")[1]).attr('checked', true);
			}
			if("CASH"==this.value){
                $('#version_type').empty().append($('<option></option>').val("-1").html("--Please Select--"));


                $('#version_type').append($('<option></option>').val("PRODUCTION").html("Production"));
                $('#version_type').append($('<option></option>').val("BETA").html("Beta"));
			}
			else if("FREE"==this.value){
                $('#version_type').empty().append($('<option></option>').val("-1").html("--Please Select--"));


                $('#version_type').append($('<option></option>').val("PRODUCTION").html("Production"));
			}
			else{
                $('#version_type').empty().append($('<option></option>').val("-1").html("--Please Select--"));



			}


		});




	});
</script>
<body>
	<div class="FormSection">
		<div class="greyStrip">
			<h4>App Version History</h4>
		</div>
		<div class="innerBox">
			<s:if test="%{appList.size>0}">
				<table class="payTransaction" id="appVerTable">
					<thead>
						<tr>
							<th>App-Tag</th>
							<th>Version</th>
							<th>Version code</th>
							<th>Version Date</th>
							<th>Mandatory</th>
							<th>Type</th>
							<th>URL</th>
							<th>Obsolete</th>
							<th>Version Status</th>

						</tr>
					</thead>
					<tbody>
						<s:iterator value="%{appList}">
							<tr id='appVerRow<s:property value="%{id}" />'
								class="appVerRow" title='<s:property value="%{message}"/>'>
								<td><s:property value="%{appTag}" />
								</td>
								<td><s:property value="%{version}" />
								</td>
								<td><s:property value="%{versionCode}" />
								</td>
								<td><s:property value="%{versionDate}" />
								</td>
								<td><s:property value="%{mandatory}" />
								</td>
								<td><s:property value="%{appType}" />
								</td>
								<td> <a href="<s:property value="%{url}" />" title="<s:property value="%{url}"/>">Download URL</a>
								</td>
								<td><a class="button" style="margin:0!important" rel="facebox"
									href="com/stpl/pms/action/bo/misc/bo_mis_mobile_fetchAltVersion.action?appVerId=<s:property value="%{Id}" />&domainId=<s:property value="%{domainId}" />&aliasId=<s:property value="%{aliasId}" />&os=<s:property value="%{os}" />&appType=<s:property value="%{appType}" />"
									title="Make App Obsolete">OBSOLETE</a></td>
								<%--<td><a class="button app-push" style="margin:0!important" rel="facebox"
									href="com/stpl/pms/action/bo/misc/bo_mis_mobile_app_version_menu.action#fb_payload"
									title="Push to all users.">Push</a>
								</td>--%>
								<td>
									<s:if test="%{version_type.equals('BETA')}">
									<a class="button" style="margin:0!important"
									   href="com/stpl/pms/action/bo/misc/bo_mis_mobile_updateversionRelease.action?appVerId=<s:property value="%{Id}"/>"
									   title="Convert To Production">Convert</a>
									</s:if>
									<s:else>

										<a class="button" style="margin:0!important"
										   title="Already Production">Convert</a>
									</s:else>
								</td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</s:if>
			<s:else>
				<div class="innerBox">
					<div class="alert info_msg " style="width: auto">
						<span class="alert_close"></span><strong>Info: </strong> No app
						version record exists!
					</div>
				</div>
			</s:else>

		</div>
		<div class="box_footer" id="addApp_footer" align="right">
			<input type="button" name="addApp" value="+ADD NEW APP VERSION"
				class="button" id="addApp" />

		</div>
	</div>
	<div id="foldForm" style="display: none;">
		<div class="FormSection">
			<s:form action="bo_mis_mobile_app_version_submit" name="addAppForm">
				<div class="greyStrip">
					<h4>Add New App Version</h4>
				</div>
				<s class="innerBox">
					<s:token name="strutsToken" id="strutsToken"></s:token>
					<s:hidden name="domainId"></s:hidden>
					<s:hidden name="aliasId"></s:hidden>
					<s:hidden name="os"></s:hidden>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Application Type: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select theme="myTheme" applyscript="true" cssClass="select1"
								list="#{'CASH':'CASH', 'FREE':'FREE'}" name="appType" id="appType" headerKey="-1"
								headerValue="--Please Select--"></s:select>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox" >
						<div class="labelDiv">
							<label> Version </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:textfield theme="myTheme" name="version" id="version" maxLength="12"
								applyscript="true"
								action="com/stpl/pms/action/bo/misc/bo_mis_mobile_appVersionCheck.action"
								ajaxParam="domainId,aliasId,version,appType,os" />
						</div>
						<div id="error_div" class="fieldError"></div>
					</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label> Version Code </label> <em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:textfield theme="myTheme" name="versionCode"
									errorMassage="Only Numeric Character allowed" id="versionCode"
									applyscript="true" maxlength="12" pattern="^[0-9]*$"
									patternOn="both"
									action="com/stpl/pms/action/bo/misc/bo_mis_mobile_appVersionCheck.action"
									ajaxParam="domainId,aliasId,versionCode,appType,os"
									errorMassage="Please enter valid versionCode">
								</s:textfield>
							</div>
							<div id="error_div" class="fieldError"></div>
						</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Mandatory Update: </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:radio theme="myTheme" cssClass="inpRadio mandate"
								list="#{'YES':'Yes','NO':'No'}" value="%{'NO'}" name="mandatory"
								id="mandatory" applyscript="true"></s:radio>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> URL </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<ss:textfield
								pattern="^((http:\/\/+|https:\/\/+|ftp:\/\/+|HTTP:\/\/+|FTP:\/\/+|HTTPS:\/\/+)[\w\d\-]+\.+[\w\d]+.*)$"
								theme="myTheme" name="url" id="url" maxlength="250"
								applyscript="true" patternOn="blur"
								errorMassage="Please enter url in a valid format." />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Message </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:textfield theme="myTheme" name="message" id="message"
								maxlength="250" applyscript="true"></s:textfield>
						</div>
					</div>

					<s:if test="%{os.equals('Android')}">
						<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> Release Version </label> <em class="Req">*</em>
						</div>
						<div class="InputDiv">
							<s:select theme="myTheme" applyscript="true" cssClass="select1"
									  list="#{}" name="version_type" id="version_type" headerKey="-1"
									  headerValue="--Please Select--"

									  action="com/stpl/pms/action/bo/misc/bo_mis_mobile_ReleaseVersionCheck.action"
									  ajaxParam="domainId,aliasId,version_type,appType,os"
									  patternOn="both"
									   errorMassage="Beta Already Exist"
									  ></s:select>
						</div>
					</div>
						</s:if>
					<s:else>
							<s:hidden name="version_type" value="PRODUCTION" id="version_type"></s:hidden>
						</s:else>
				</div>
				<div class="box_footer" align="right">
					<s:submit id="Submit" name="Submit" value="Submit" theme="simple"
						cssClass="button"></s:submit>
				</div>
			</s:form>
		</div>
	</div>
	<div id="fb_payload" style="display: none;">
		<div class="FormSection">
			<div class="greyStrip">
				<h4>Confirmation required</h4>
			</div>
			<div class="innerBox">
				<p style="margin: 20px;">Proceed to push selected App Version to
					all users?</p>
			</div>
		</div>
		<button id="obsProceedBtn"  class="button">Proceed</button>
		<button id="obsCancelBtn" class="button"
			onclick="$.facebox.close();return false;">Cancel</button>
	</div>
</body>
<script type="text/javascript">
	 $('a[rel*="facebox"]').facebox({
				closeImage : '<%=request.getContextPath()%>/images/closelabel.png',
 	});
	
	$(document).on("click", "#addApp", function(){
		$("#foldForm").show();
		$("#addApp_footer").remove();
		createBubble();
	});
	
	$(".appVerRow .app-push").click(function(){
		control.clickedAppId=$($(this).parent()).parent().attr("id").split('appVerRow')[1];
	});
	
	$(document).on("click", "#obsProceedBtn", function(){
		var response=_ajaxCallText("com/stpl/pms/action/bo/misc/bo_mis_mobile_pushToAll.action","appVerId="+control.clickedAppId);
		if(response=="success")
			control.modal("App Version Push Successful.");
		else
			control.modal("App Version Push Failed!");
		return false;
	});
	
	control.datatable=$("#appVerTable").DataTable( {
        "order": [[ 3, "desc" ]]
    } );

</script>
</html>
