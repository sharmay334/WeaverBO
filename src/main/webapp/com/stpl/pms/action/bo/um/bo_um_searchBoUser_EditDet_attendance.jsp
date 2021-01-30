<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <base href="<%=basePath%>">
  <title>Edit Employee Detail</title>
  <meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
  
  
    <SCRIPT type="text/javascript" src="<%=path %>/com/stpl/pms/action/bo/um/js/um.js"></SCRIPT>
    <script type="text/javascript">
    $(document).ready(function(){
    	$('a[id*=resetPlayerPass_]').click(function(){
 		var isValid = false;
 		var name = $(this).attr('name');
 		if(confirm("Do you want to reset password for User "+name)){
 			isValid=true;
 		}
 		if(isValid){
 			var anchor = $(this);
			var linkArr = $(this).attr('href').split('?');
			$.ajax( {
				type : "POST",
				url : linkArr[0],
				data : linkArr[1],
				async : false,
				success : function(result, arguments, text) {
					alert("Reset Password mail is sent to Your mail ID.");				
				}
			});
 		}
 		return false;
	 });
	 });

    function chkSub(){
    	  //alert($('#phoneNbr').val().length);
    	  var flag = true;
    	  var errmsg1 = document.getElementById("errmsg1").value;
    	  var errmsg2 = document.getElementById("errmsg2").value;
    	  var errmsg3 = document.getElementById("errmsg3").value;
    	  
    	  if($('#phoneNbr').val() == ""){
    	  document.getElementById("phoneNbr_error").className="fieldError";	    	
    	document.getElementById("phoneNbr_error").innerHTML = errmsg1;
    	  //alert("please fill the phone no");
    	  flag = false;
    	  }
    	  
    	  else if($('#phoneNbr').val().length!= 10){
    	    document.getElementById("phoneNbr_error").className="fieldError";	    	
    	document.getElementById("phoneNbr_error").innerHTML = errmsg2;
    	  //alert("Please Enter the 10 digits phone Number");
    	  flag =  false;
    	  }
    	  if($('#email').val() == ""){
    	 document.getElementById("email_error").className="fieldError";	    	
    	 document.getElementById("email_error").innerHTML = errmsg3;
    	 // alert("Please Fill the emailID");
    	  flag =  false;
    	  }
    	  if(flag == false){
    	  	return false;
    	  }else{
    	 	return true;
    	 	} 
    	  }
    	 

    </script>
    </head>
    <body>          
 <div class="FormSection">
         
		<div class="greyStrip"><h4>Edit Employee Details</h4></div>
	
		<s:form action="/com/stpl/pms/action/bo/um/bo_um_searchBoUser_Save.action" method="POST" theme="simple">
			<s:hidden id="user_id" name="user_id" value="%{userDetailsBean.UserId}"></s:hidden>
			<s:hidden id="domainId" name="domainId" value="%{userDetailsBean.domainId}"></s:hidden>
			<s:hidden name="type" value="%{userDetailsBean.boUserType}"></s:hidden>
			<s:hidden name="firstName" value="%{userDetailsBean.firstName}"></s:hidden>
			<s:hidden name="lastName" value="%{userDetailsBean.lastName}"></s:hidden>
			<s:hidden name="userName" value="%{userDetailsBean.userName}"></s:hidden>
			 
			 <div class="innerBox">
			
          
         <!--form section first start-->
        	
        <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Name</label></div>
            <div class="InputDiv">
            <ss:textfield name="userDetailsBean.firstName" value="%{userDetailsBean.firstName}" id="firstName" theme="myTheme"  readonly="true"></ss:textfield>
          </div>
        	
        </div>
        
        
       <div class="clearFRM"></div>
			
			<div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Gender (M/F)</label></div>
            <div class="InputDiv">
            <ss:textfield name="userDetailsBean.gender" value="%{userDetailsBean.gender}" id="gender" theme="myTheme"  maxlength="1" readonly="true"></ss:textfield>
          </div>
        	
        </div>
        
        
       
        <div class="clearFRM"></div>
			
			<div class="FormMainBox">
        	
        	<div class="labelDiv"><label>PAN</label></div>
            <div class="InputDiv">
            <ss:textfield name="userDetailsBean.panNumber" value="%{userDetailsBean.panNumber}" id="panNumber" theme="myTheme"  readonly="true"></ss:textfield>
          </div>
        	
        </div>
        
        
       <div class="clearFRM"></div>
			
			<div class="FormMainBox">
        	
        	<div class="labelDiv"><label>AADHAR</label></div>
            <div class="InputDiv">
            <ss:textfield name="userDetailsBean.aadharNumber" value="%{userDetailsBean.aadharNumber}" id="aadharNumber" theme="myTheme" readonly="true"></ss:textfield>
          </div>
        	
        </div>
        
        
       <div class="clearFRM"></div>
			
			<div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Blood Group</label></div>
            <div class="InputDiv">
            <ss:textfield name="userDetailsBean.bloodGroup" value="%{userDetailsBean.bloodGroup}" id="bloodGroup" theme="myTheme" readonly="true"></ss:textfield>
          </div>
        	
        </div>
        
        
       <div class="clearFRM"></div>
       <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Leaves</label></div>
            <div class="InputDiv">
            <ss:textfield name="userDetailsBean.leaves" value="%{userDetailsBean.leaves}" id="leaves" theme="myTheme" readonly="true"></ss:textfield>
          </div>
        	
        </div>
        
        
       <div class="clearFRM"></div>
       <div class="FormMainBox">
        	
        	<div class="labelDiv"><label>Authentication Amount</label></div>
            <div class="InputDiv">
            <ss:textfield name="userDetailsBean.authAmount" value="%{userDetailsBean.authAmount}" id="authAmount" theme="myTheme" readonly="true"></ss:textfield>
          </div>
        	
        </div>
        
        
       <div class="clearFRM"></div>
		 <div class="FormMainBox">
        	
        	<div class="labelDiv"><label><s:text name="global.scratchWeaver.email"/></label></div>
            <div class="InputDiv">
            <ss:textfield name="email"  maxlength="40" value="%{userDetailsBean.emailId}"
					id="email" disabled="true"  theme="myTheme"
				 pattern="^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$"
							errorMassage="Please Enter Valid Email Id"  patternOn="blur"  action="bo_um_validateemail.action?prevEmailId=%{userDetailsBean.emailId}" ajaxParam="user_id,email">
				</ss:textfield>
				<div class="fieldError" id="email_error">
						<s:fielderror ><s:param >emailId</s:param></s:fielderror>
				</div>
            </div>
        </div>
        
        <div class="clearFRM"></div>
			 <div class="FormMainBox">
        	
        	<div class="labelDiv"><label><s:text name="global.subuserregistration.PhoneNumber"/></label></div>
            <div class="InputDiv">	
  			<ss:textfield name="phoneNbr" id="phoneNbr"
						maxlength="15" readonly="true" value="%{userDetailsBean.phoneNum}"
						pattern="^[0-9]*$" errorMassage="Only Numeric character allowed." theme="myTheme"></ss:textfield>
				<div class="fieldError" id="phoneNbr_error">
						<s:fielderror ><s:param >phoneNbr</s:param></s:fielderror>
				</div>
            </div>
        	
        </div>
         <div class="clearFRM"></div>
      	  <div class="FormMainBox">
					<div class="labelDiv">
						<label>Salary(Calender Year)
						</label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="userDetailsBean.salary" id="salary"
							theme="myTheme" pattern="^[0-9.]*$" value="%{userDetailsBean.salary}"
							errorMassage="Special Character not allowed" ></ss:textfield>
						<div id="salary_error" class="fieldError">
							<s:fielderror>
								<s:param>salary</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Travelling Allowance(per km)
						</label>
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="userDetailsBean.travellingAllowance" id="travellingAllowance"
							theme="myTheme" pattern="^[0-9.]*$" value="%{userDetailsBean.travellingAllowance}"
							errorMassage="Special Character not allowed" ></ss:textfield>
						<div id="travellingAllowance_error" class="fieldError">
							<s:fielderror>
								<s:param>travellingAllowance</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Average Traveling Per Day (in km)
						</label> 
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="userDetailsBean.avgTravellingPerDay" id="avgTravellingPerDay"
							theme="myTheme" pattern="^[0-9.]*$" value="%{userDetailsBean.avgTravellingPerDay}"
							errorMassage="Special Character not allowed" ></ss:textfield>
						<div id="avgTravellingPerDay_error" class="fieldError">
							<s:fielderror>
								<s:param>avgTravellingPerDay</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>City Allowance(per km)
						</label> 
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="cityAllowance" id="cityAllowance"
							theme="myTheme" pattern="^[0-9.]*$" value="%{userDetailsBean.cityAllowance}"
							errorMassage="Special Character not allowed" ></ss:textfield>
						<div id="cityAllowance_error" class="fieldError">
							<s:fielderror>
								<s:param>cityAllowance</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Ex-City Allowance(per km)
						</label> 
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="userDetailsBean.exCityAllowance" id="exCityAllowance"
							theme="myTheme" pattern="^[0-9.]*$" value="%{userDetailsBean.exCityAllowance}"
							errorMassage="Special Character not allowed" ></ss:textfield>
						<div id="exCityAllowance_error" class="fieldError">
							<s:fielderror>
								<s:param>exCityAllowance</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Daily Allowance(with doc)
						</label> 
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="userDetailsBean.dailyAllowanceDoc" id="dailyAllowanceDoc"
							theme="myTheme" pattern="^[0-9.]*$" value="%{userDetailsBean.dailyAllowanceDoc}"
							errorMassage="Special Character not allowed" ></ss:textfield>
						<div id="dailyAllowanceDoc_error" class="fieldError">
							<s:fielderror>
								<s:param>dailyAllowanceDoc</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label>Daily Allowance(without doc)
						</label> 
					</div>
					<div class="InputDiv">
						<ss:textfield maxlength="30" name="userDetailsBean.dailyAllowance" id="dailyAllowance"
							theme="myTheme" pattern="^[0-9.]*$" value="%{userDetailsBean.dailyAllowance}"
							errorMassage="Special Character not allowed" ></ss:textfield>
						<div id="dailyAllowance_error" class="fieldError">
							<s:fielderror>
								<s:param>dailyAllowance</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Branch </label>
					</div>
					<div class="InputDiv">
						<ss:select list="branchList" cssClass="select1" theme="myTheme"
							errorMassage="Please select one" value="%{userDetailsBean.branch}" name="userDetailsBean.branch"
							id="branch"></ss:select>

						<div id="branch_error" class="fieldError">
							<s:fielderror>
								<s:param>branch</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Region </label>
					</div>
					<div class="InputDiv">
						<ss:select list="regionList" cssClass="select1" theme="myTheme"
							errorMassage="Please select one" value="%{userDetailsBean.region}" name="userDetailsBean.region"
							id="region"></ss:select>

						<div id="region_error" class="fieldError">
							<s:fielderror>
								<s:param>region</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Role </label>
					</div>
					<div class="InputDiv">
						<ss:select list="roleList" cssClass="select1" theme="myTheme"
							errorMassage="Please select one" value="%{userDetailsBean.role}"  name="userDetailsBean.role"
							id="role"></ss:select>

						<div id="role_error" class="fieldError">
							<s:fielderror>
								<s:param>role</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Department </label>
					</div>
					<div class="InputDiv">
						<ss:select list="departmentList" cssClass="select1" theme="myTheme"
							errorMassage="Please select one" value="%{userDetailsBean.department}" name="userDetailsBean.department"
							id="department"></ss:select>

						<div id="role_error" class="fieldError">
							<s:fielderror>
								<s:param>department</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="labelDiv">
						<label> Week day off </label>
					</div>
					<div class="InputDiv">
						<ss:select list="{'Sunday','Monday','Tuesday','Wedunsday','Thrusday','Friday','Saturday'}" multiple="true" cssStyle="height:40px !important" cssClass="select2" theme="myTheme"
							errorMassage="Please select one"  name="userDetailsBean.weekDay"
							id="weekDay"></ss:select>

						<div id="role_error" class="fieldError">
							<s:fielderror>
								<s:param>weekDay</s:param>
							</s:fielderror>
						</div>
					</div>
				</div>
        
		
</div>
	<div class="box_footer" align="right">
		
	<input class="button" type="button" value='<s:text name="global.EDIT"/>' id="editButton"
							onclick="enableBoxesAttendanceUser()" style="float:right;" />
                 
         		 <input type="submit" value='<s:text name="global.login.submit"/>' id="submitButton"
							style="display: none;width:73px;" class="button" 
							/>
							
							
			<a style="color: #000000; font-size:12px;font-weight:bold;float: right;margin-right: 30px;margin-top: 15px;" href="bo_um_editEmployeeReg.action">
					<s:text name="global.scratchWeaver.BackToSearch"/></a>	
            </div>
							
		</s:form>
		
	</div>
	<div id="searchResult"></div>
</body>
</html>