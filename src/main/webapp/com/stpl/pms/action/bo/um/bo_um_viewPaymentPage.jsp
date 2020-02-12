<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = (String) request.getAttribute("basePathURL");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>View Godown</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script>
function callForMoreRow(){
	var rowCount = countTotalRows();
	if(document.getElementById('amount'+rowCount).value!="0"){
			  var row = document.getElementById("rowId"+rowCount); // find row to copy
		      var table = document.getElementById("payTransactionTable"); // find table to append to
		      var clone = row.cloneNode(true); // copy children too
		      rowCount+=1;
		      clone.id = "rowId"+rowCount; // change id or other attributes/contents
		      table.appendChild(clone); // add new row to end of table
		      var oInput = document.getElementById("rowId"+rowCount);
				var e = oInput.childNodes[3].childNodes[1];
				e.id = "amount"+rowCount;
	}
	function countTotalRows(){
		
        var rowCount = 0;
        var table = document.getElementById("payTransactionTable");
        var rows = table.getElementsByTagName("tr");
        for (var i = 0; i < rows.length; i++) {
            if (rows[i].getElementsByTagName("td").length > 0) {
                rowCount++;
            }
        }
       return rowCount;
	}
}
</script>
</head>
<body>
	<div class="clear2"></div>
	<h2>
		Payment
		<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}"></s:if>
	</h2>

	<!--form section first start-->
	<div class="FormSection">

		<div class="greyStrip">
			<h4>Payment</h4>
		</div>
		<s:form
			action="/com/stpl/pms/action/bo/um/bo_um_BoviewStockItem_Search.action"
			id="searchUserFrm" theme="simple" target="searchDiv">
			<div class="innerBox">

				<s:if test="%{userInfoBean.getUserType().equalsIgnoreCase('BO')}">

					<div class="FormMainBox">

						<div class="labelDiv">
							<label> <b><font color='red'>Payment No.</font></b>
							</label>
						</div>
						<div class="InputDiv">
							<s:textfield name="paymentNo" value="1" theme="myTheme"
								readonly="true" cssStyle="width:10%" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Account </label>
						</div>
						<div class="InputDiv">
							<s:select name="account" headerKey="-1"
								headerValue="Select Account" list="accountList"
								cssClass="select1" theme="myTheme" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">

						<div class="labelDiv">
							<label> Current Balance </label>
						</div>
						<div class="InputDiv">
							<s:textfield name="currBalance" value="10000" theme="myTheme"
								readonly="true" cssStyle="width:20%" />
						</div>
					</div>
					<div class="clearFRM"></div>
					<br />
					<div class="clearFRM"></div>

					<table width="100%" cellspacing="0" align="center"
						id="payTransactionTable" class="transactionTable">
						<thead>
							<tr>
								<th style="text-align: center;" nowrap="nowrap">Particulars</th>
								<th style="text-align: center;" nowrap="nowrap">Amount</th>
								
							</tr>
						</thead>
						<tbody>

							<tr id="rowId1">
								<td style="text-align: center;" nowrap="nowrap"><s:select
										name="selectParticulars1" headerKey="-1"
										headerValue="--Please Select--" list="{'one','two'}"
										cssClass="select1" theme="myTheme" /></td>
								<td style="text-align: center;" nowrap="nowrap"><ss:textfield
										maxlength="30" name="amount1" value="0" id="amount1"
										theme="myTheme" pattern="^[0-9]*$" cssStyle="width:50%" onchange="callForMoreRow()">
										</ss:textfield></td>

							</tr>


						</tbody>
					</table>
				</s:if>

			</div>
			<div class="box_footer" align="right">
				<%-- <s:submit value="Search" align="left" cssStyle="margin-left:0px"
						cssClass="button" theme="simple"></s:submit>
					 --%>
				<input type="submit" value='Create' align="left"
					style="margin-left: 0px" class="button" />
			</div>
		</s:form>
	</div>
	<div id="searchDiv"></div>
	<br />
	<br />
</body>
</html>
