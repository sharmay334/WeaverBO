<%@ taglib prefix="s" uri="/struts-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
	<div class="FormSection">
		<s:form name="obsForm">
			<div class="greyStrip">
				<h4>Confirmation required</h4>
			</div>
			<s:hidden name="appVerId" id="obsAppVerId"></s:hidden>
			<div class="innerBox"><p id="labeltxt" style="margin: 20px;">Proceed to make the app version
				Obsolete, else press cancel.</p></div>
				<div class="FormMainBox" id="fold_face" style="display: none">
					<div class="labelDiv">
						<label> Alternate version: </label> <em class="Req">*</em>
					</div>
					
					<div class="InputDiv">
					<s:if test="%{appList.size()==0}">
						<p>No alternate versions available.Please register some alternate verions in the system and try again.</p>
					</s:if>
					<s:else>
						<s:select theme="myTheme" cssClass="select1" list="%{appList}"
							applyscript="true" name="altApp" id="altApp" headerKey="-1"
							headerValue="--Please Select--" listKey="%{id}"
							listValue="%{appTag}"></s:select>
					</s:else>
					</div>
				</div>
			<button id="proceedbtn" class="button" >Proceed</button>
			<button id="sendbtn" class="button" style="display: none;">Confirm</button>
			<button id="cancelbtn" class="button" onclick="$.facebox.close();return false;">Cancel</button>
		</s:form>
	</div>
	<script type="text/javascript">
		$(function (){
			createBubble();
		});
		$("#proceedbtn").click(function(){
			$("#fold_face").show();
			$("#labeltxt").hide();
			$(this).hide();
			return false;
		});
		$("#altApp").change(function(){
			if(obsForm.altApp.value!=-1)
				$("#sendbtn").show();
			else
				$("#sendbtn").hide();
		});
		$("#sendbtn").click(function() {
			var appId=$("#obsAppVerId").val();
			var oldAppVer=control.datatable.cell("#appVerRow"+appId,1).data();
			var response=_ajaxCallText("com/stpl/pms/action/bo/misc/bo_mis_mobile_makeAppObsolete.action","appVerId="+appId+"&altAppId="+$("#altApp").val()+"&oldAppVer="+oldAppVer);
			if(response=="success"){
				control.datatable.row($("#appVerRow"+appId)).remove().draw();
				control.modal("App Version obsolete successful.");
			} else {
				control.modal("App Version obsolete failed!");
			}
			return false;
		});
	
	</script>
</body>
</html>
