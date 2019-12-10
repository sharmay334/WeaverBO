<%@ taglib prefix="s" uri="/struts-tags"%>
	<div id="wrap">
	<div id="top_form">
		<h3>
			CREATE DOMAIN
		</h3>
		<s:form name="mediaUploadFrm" action="/com/stpl/pms/action/bo/um/bo_cm_addMedia_upload.action" onsubmit="return checkUploadFrm()">
			<s:token name="clickToken"></s:token>
			
			<table width="100%" border="0" cellspacing="2" cellpadding="2"
				align="center">

				<s:textfield label="Domain" name="domainName" id="domainName" ></s:textfield>
				<s:textfield label="User Name" name="userName" id="userName" ></s:textfield>
				
				<s:textfield label="Domain Description" name="domainDesc"
					id="domainDesc"></s:textfield>
					
				<s:textfield label="IP Address" name="ipAddr"
					id="ipAddrId"></s:textfield>

		<s:submit cssClass="button" value="Create Domain" align="left"
					cssStyle="margin-left:409px" />
				
			</table>
		</s:form>
	</div>
</div>