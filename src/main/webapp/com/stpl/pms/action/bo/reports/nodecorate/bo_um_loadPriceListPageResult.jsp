<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>
<html>
	<head>
	<base href="<%=basePath%>">
	
		<script type="text/javascript">
			function callUpdate(){
				var regPrice = document.getElementById('regularPrice').value;
				var superCash = document.getElementById('superCashPrice').value;
				var itemName  = document.getElementById('itemName').value;
				var myurl = "<%=basePath%>";
				myurl += "/com/stpl/pms/action/bo/um/bo_um_updatePriceList.action?itemName="
						+itemName+"&regularPrice="+regPrice+"&superCashPrice="+superCash;
				$.ajax({
					type : "GET",
					url : myurl,
					async:false,
					success : function(itr) {
						if(itr=='success')
							swal("Date is successfully updated...");
						else
							swal("ERROR: failed to update data!");	
						setTimeout(function(){
		        			   window.location.reload(1);
		        			}, 1000);
								
						},

					error : function(itr) {

					}
				});
			}
		</script>
	</head>
	<body>
		<div class="FormSection">

			<div class="greyStrip">
				<h4>
					<s:text name="global.searchuser.searchresult"></s:text>
				</h4>
			</div>
			<div class="innerBox">
			
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Regular Price </label>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield
										maxlength="30" name="regularPrice" value="%{regularPrice}" id="regularPrice" theme="myTheme"
										pattern="^[0-9.]*$" cssStyle="width:100%">
									</s:textfield>
							<s:hidden name="itemName" id="itemName" value="%{itemName}"></s:hidden>
						</div>
					</div>
				</div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> SuperCash Price </label>
					</div>
					<div class="InputDiv">
						<div>
							<s:textfield
										maxlength="30" name="superCashPrice" value="%{superCashPrice}" id="superCashPrice" theme="myTheme"
										pattern="^[0-9.]*$" cssStyle="width:100%">
									</s:textfield>

						</div>
					</div>
				</div>
				
				
				
			</div>
			<div class="box_footer" align="right">
			  
				<s:submit name="Search" value="Update" id="searchButton"
					cssClass="button" onclick="callUpdate()"></s:submit>
			</div>
		</div>
	</body>
</html>