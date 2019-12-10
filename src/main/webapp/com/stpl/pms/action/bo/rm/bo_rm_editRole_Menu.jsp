<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
        
		<title>Edit Role Privileges</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		</head>
		<body>
     <h2>Edit Role Privileges</h2>
          
         <!--form section first start-->
         <div class="FormSection">
         
		<div class="greyStrip"><h4>Required Information</h4></div>
       <div align="left" style="padding-left: 15px" class="fieldError">
	<s:fielderror ><s:param >rolePriv</s:param></s:fielderror>
	</div>
        <div class="innerBox">	
        <div class="FormMainBox">
			<div class="labelDiv"><label>Role Name</label><em class="Req">*</em></div>
            <div class="InputDiv"><ss:select id="roleId" name="roleId"
								cssClass="select1" theme="myTheme" list="roleMap" ajaxAction="bo_rm_edit_role_FetchPriv.action" target="result"
								headerKey="-1" headerValue="-- Please Select --" applyscript="true"></ss:select>
			<div id="roleName_error" class="fieldError"> 
						 <s:fielderror ><s:param >roleName</s:param></s:fielderror>
			</div>
			</div>
			</div>
			</div>
			</div>
	<s:form name="editRolePriv" id="editRolePrivFrm"
					action="bo_rm_edit_role_save" method="POST" theme="simple" onsubmit="return chksub();">
					<s:token name="strutsToken" id="strutsToken"></s:token>
					<div id="result">
					
					</div>
	</s:form>
		</body>
</html>