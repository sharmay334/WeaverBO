<%@ taglib prefix="s" uri="/struts-tags" %>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>Loyalty Migration Matrix Query Form</title>
  <script type="text/javascript">
  	$(document).ready(function(){
			$(".dateField").datetimepicker({
						dateFormat : 'dd/mm/yy',
						timeFormat : 'HH:mm:ss',
						showSecond : true,
						maxDate :serverDateStr,
						maxDateTime:$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',serverDateStr),
						onClose : function(dateText, inst) {
							if ($(this).attr('id').indexOf('fromDate') != -1) {
								$('#toDate').datetimepicker("option", "minDate",
										dateText);
								$('#toDate').datetimepicker("option", "minDateTime",
										$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',dateText));
							} else if ($(this).attr('id').indexOf('toDate') != -1) {
								$('#fromDate').datetimepicker("option", "maxDate",
										dateText);
								$('#fromDate').datetimepicker("option", "maxDateTime",
										$.datepicker.parseDateTime('dd/mm/yy','HH:mm:ss',dateText));
							}
						}
					});
              $('#fromDate').datetimepicker('setDate', "-1");  
               $('#toDate').datetimepicker('setDate', serverDateStr);  
			$("#mgrationReset").click(function(){
				$("#matrixContainer").empty();
				$('#fromDate').datepicker("setDate", "-1");
				$('#toDate').datepicker("setDate", "0");
				return false;
			});
			
			$("#matrixQueryForm").submit(function(){
				$("#matrixContainer").empty();
				var toDate=$('#toDate').val();
				var fromDate=$('#fromDate').val();
				var qryStr="migrationSummaryRequest.toDate="+encodeURI(toDate)+"&migrationSummaryRequest.fromDate="+encodeURI(fromDate);
				console.log(qryStr);
				_ajaxCallDiv("com/stpl/pms/action/bo/loyalty/bo_ajax_migrationMatrix.action",qryStr,"matrixContainer");
				return false;
			});
		});
  </script>
  </head>
  <body>
  	<div id="container">
  		<div class="FormSection">
	  		<div class="greyStrip">
	  			<h4>
	  				Loyalty Migration Matrix Query Form
	  			</h4>
	  		</div>
	  		<form action="" method="post" id="matrixQueryForm" >
	  			<div class="innerBox">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> From Date </label><em class="Req">*</em>
						</div>
						<div class="InputDivHalf">
							<s:textfield name="migrationSummaryRequest.fromDate" applyscript="true" cssClass="dateField" id="fromDate" theme="myTheme" readonly="true" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="labelDiv">
							<label> To Date </label><em class="Req">*</em>
						</div>
						<div class="InputDivHalf">
							<s:textfield name="migrationSummaryRequest.toDate" applyscript="true" cssClass="dateField" id="toDate" theme="myTheme" readonly="true" />
						</div>
					</div>
	  			</div>
	  			<div class="box_footer" align="right">
					<input type="submit" id="mgrationSearch" name="Search" value="Search" class="button">
					
					<input type="reset"  id="mgrationReset" name="reset" value="reset" class="button">
				</div>
	  		</form>
  		</div>
  		<div id="matrixContainer"></div>
  	</div>
  </body>
</html>