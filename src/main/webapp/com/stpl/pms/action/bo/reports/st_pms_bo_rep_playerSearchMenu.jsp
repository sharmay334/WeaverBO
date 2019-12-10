<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = (String)request.getAttribute("basePathURL") ;
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>Player Search</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="<%=path%>/css/multiselect/chosen.css" rel="stylesheet"
			type="text/css" />
		<link href="css/facebox.css" media="screen" rel="stylesheet" type="text/css"/>
		<link href="<%=path%>/css/paginaton_style.css" rel="stylesheet" type="text/css" />
		
		<SCRIPT type="text/javascript" src="<%=path%>/js/jquery.paginate.js"></SCRIPT>
		<script type="text/javascript"
			src="<%=path%>/js/multiselect/chosen.jquery.js"></script>
		<script type="text/javascript"
			src="com/stpl/pms/action/bo/reports/js/playerSearch.js"></script>
		<script src="js/facebox.js" type="text/javascript"></script>
	</head>

	<body>
		<h2>
			Player Search
		</h2>
		<s:form id="plrSearchFrm" action="st_pms_bo_rep_playerSearchRep"
			cssClass="ajaxFrm"  theme="simple" novalidate="true" enctype="multipart/form-data">
			<s:hidden id="byDefaultDomainID" name="byDefaultDomainID" value="%{bydefaultSelectedDomain}"/>
			
			<s:hidden name="plrOpt.redirect"  id="redirect" value="Search"></s:hidden>
			<div class="FormSection">
				<input type="hidden" name="plrOpt.vipCriteriaBean"
					id="vipCriteriaBean" />
				<div class="greyStrip">
					<h4>
						Personal Information Section
					</h4>
				</div>
				<div class="innerBox">
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-1">
								<div class="lbl-name-div">
									Domain
								</div>
								<div class="small-text-box-div">
									<s:if test="%{domainId>1}">
										<s:hidden name="plrOpt.domainId" value="%{domainId}" id="domainId"></s:hidden>
										<s:property value="%{domainName}"/>
									</s:if>
									<s:else>
										<s:select theme="myTheme" cssClass="select2"
											list="%{domainMap}"
											name="plrOpt.domainId" id="domainId" headerKey="-1"
											headerValue="--Please Select--" listKey="%{key}"
											listValue="%{value}" cssStyle="width: 182px" > </s:select>

									</s:else>
								</div>
							</div>
							<div class="div-2">
								<div class="lbl-name-div">
									Reg. Alias
								</div>
								<div class="small-text-box-div">
										<div>
										<s:hidden name="alias" value="%{aliasId}" id="alias"></s:hidden>
									<ss:select theme="myTheme" cssClass="select2" list="%{}"
									name="plrOpt.aliasId" id="aliasId" headerKey="-1"
									headerValue="--Please Select--" cssStyle="width: 182px"></ss:select>
							</div>
								</div>
							</div>
						</div>
						
						
						<div class="div-1" style="padding-left:28px">
								<div class="lbl-name-div">
									Player Id
								</div>
								<div class="small-text-box-div">
									<s:textfield name="plrOpt.playerIdList" theme="myTheme" id="playerIdList" 
									pattern="^[0-9,]*$" errorMassage="Enter numeric character and comma only" 
									cssClass="text-field-small" ></s:textfield>
								</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div id="disableFileds">
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-1">
								<div class="lbl-name-div">
									First Name
								</div>
								<div class="small-text-box-div">
									<s:textfield name="plrOpt.fname" theme="myTheme" id="fname"
										cssClass="text-field-small"></s:textfield>
								</div>
							</div>

							<div class="div-2">
								<div class="lbl-name-div">
									last Name
								</div>
								<div class="small-text-box-div">
									<s:textfield name="plrOpt.lname" theme="myTheme" id="lname"
										cssClass="text-field-small"></s:textfield>
								</div>
							</div>
							<div class="div-3" style="float: left;margin-left: 28px;">
								<div class="lbl-name-div" ><!-- style="width: 94px;" --> 
									User Name
								</div>
								<div class="small-text-box-div">

									<s:textfield name="plrOpt.userName" theme="myTheme" id="userName"
										cssClass="text-field-small"></s:textfield>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-1">
								<div class="lbl-name-div">
									Email ID
								</div>
								<div class="small-text-box-div">

									<ss:textfield name="plrOpt.email" theme="myTheme"
										pattern="^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$"
										errorMassage="Enter valid email" patternOn="blur"
										cssClass="text-field-small" id="email"></ss:textfield>
								</div>
							</div>
							<div class="div-2">
								<div class="lbl-name-div">

									Mobile No.
								</div>
								<div class="small-text-box-div">

									<ss:textfield name="plrOpt.mobile" theme="myTheme" id="mobile"
										pattern="^[0-9]*$" errorMassage="Enter numeric character only"
										cssClass="text-field-small"></ss:textfield>
								</div>
							</div>
							<div class="div-3">
								<div class="lbl-name-div">
									Pan Num.
								</div>
								<div class="small-text-box-div">

									<s:textfield name="plrOpt.plrTaxId" theme="myTheme" id="plrTaxId"
										id="plrTaxId" cssClass="text-field-small"></s:textfield>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
							<div class="div-1">
								<div class="lbl-name-div">
									Gender:
								</div>
								<div class="small-text-box-div" style="font-size: 12px;">
								<s:checkboxlist list="#{'M':'Male','F':'Female'}" name="plrOpt.gender" id="gender"></s:checkboxlist>
								</div>
							</div>
							<div class="div-2">
								<div class="lbl-name-div">
									Is OLA Bind:
								</div>
								<div class="small-text-box-div" style="font-size: 12px;">
								<s:checkboxlist list="#{'YES':'Yes','NO':'No'}" name="plrOpt.isAffiliated" id="isAffiliated"></s:checkboxlist>
								</div>
							</div>
							<div class="div-2">
								<div class="lbl-name-div">
									Depositor:
								</div>
								<div class="small-text-box-div" style="font-size: 12px;">
								<s:checkboxlist list="#{'Y':'Yes','N':'No'}" name="plrOpt.depositer" id="depositer"></s:checkboxlist>
								</div>
							</div>
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						 <div class="small-text-box-section">
        	<div class="div-5">
            	<div class="lbl-name-div">
											Birth Date
										</div>
                <div class="small-text-box-div-new">
										<s:textfield name="plrOpt.fromDob" id="fromDob"
										readonly="true" 	placeholder="From Date" cssClass="text-field-small"  cssStyle="width:178px"></s:textfield>
									
										<s:textfield name="plrOpt.toDob" id="toDob"
											readonly="true"  placeholder="To Date" cssClass="text-field-small" cssStyle="width:150px; margin-left:8px"></s:textfield>
									</div>
            
         </div>
         
         <div class="div-5"  style="width:65px;float:left;">
            	<div class="lbl-name-div"  style="width:34px;">
											Year
										</div>
              							  <div class="small-text-box-div-new" style="width:20px">
										<s:checkbox name="plrOpt.yearCheck" id="yearCheck" value="Yes"></s:checkbox>
									</div>
            
         </div>
         
						<div class="div-5"  style="width:315px;float:right;">
            	<div class="lbl-name-div">
											Reg. IP
										</div>
              							  <div class="small-text-box-div-new" style="width:200px">
										<ss:textfield name="plrOpt.regIp" id="regIp1"
											 cssClass="text-field-small"  cssStyle="width:40px" maxlength="3" pattern="^([01]?\\d\\d?|2[0-4]\\d|25[0-5])$" errorMassage="Enter Valid IP" patternOn="blur"></ss:textfield>
									
										<ss:textfield name="plrOpt.regIp" id="regIp2"
											 cssClass="text-field-small"  cssStyle="width:40px" maxlength="3" pattern="^([01]?\\d\\d?|2[0-4]\\d|25[0-5])$" errorMassage="Enter Valid IP" patternOn="blur"></ss:textfield>
									
										<ss:textfield name="plrOpt.regIp" id="regIp3"
											 cssClass="text-field-small"  cssStyle="width:40px" maxlength="3" pattern="^([01]?\\d\\d?|2[0-4]\\d|25[0-5])$" errorMassage="Enter Valid IP" patternOn="blur"></ss:textfield>
									
										<ss:textfield name="plrOpt.regIp" id="regIp4"
										 	 cssClass="text-field-small"  cssStyle="width:40px" maxlength="3" pattern="^([01]?\\d\\d?|2[0-4]\\d|25[0-5])$" errorMassage="Enter Valid IP" patternOn="blur"></ss:textfield>
									</div>
            
         </div>
						
						</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						 <div class="small-text-box-section">
						<div class="div-5">
            	<div class="lbl-name-div">
											Reg. Date
										</div>
                <div class="small-text-box-div-new">
										<s:textfield name="plrOpt.fromRegDate" id="fromRegDate"
											readonly="true" theme="myTheme"
											 placeholder="From Date" cssClass="text-field-small" cssStyle="width:178px"></s:textfield>
									
										<s:textfield name="plrOpt.toRegDate" id="toRegDate"
											readonly="true" theme="myTheme"
											 placeholder="To date" cssClass="text-field-small" cssStyle="width:150px; margin-left:8px"></s:textfield>
									 </div>
						</div>
						<div class="div-5">
            	<div class="lbl-name-div">
											First Deposit
										</div>
                <div class="small-text-box-div-new">
										<s:textfield name="plrOpt.fromFirstDepositDate" id="fromFirstDepositDate"
											readonly="true" theme="myTheme"
											 placeholder="From Date" cssClass="text-field-small" cssStyle="width:150px"></s:textfield>
									
										<s:textfield name="plrOpt.toFirstDepositDate" id="toFirstDepositDate"
											readonly="true" theme="myTheme"
											 placeholder="To date" cssClass="text-field-small" cssStyle="width:178px; margin-left:8px"></s:textfield>
									 </div>
						</div>
						
						</div>
					</div>
						
				<div class="clearFRM"></div>
				<div class="FormMainBox">
					<div class="small-text-box-section">
						<div class="div-1" style="width: 100%;">
							<div class="lbl-name-div">Reg. Device :</div>
							<div class="small-text-box-div" style="font-size: 12px; width: 84%;">
								<s:checkboxlist
									list="#{'PC':'PC','MOBILE':'MOBILE','MOBILE_WEB':'MOBILE WEB','TAB':'TABLET','DOWNLOADABLE_CLIENT':'DOWNLOADABLE CLIENT'}"
									name="plrOpt.device" id="device"></s:checkboxlist>
							</div>
						</div>
					</div>
				</div>
					
					<div class="clearFRM"></div>
					<div class="FormMainBox">
					 <div class="small-text-box-section">
         <div class="div-1">
            	<div class="lbl-name-div">
								Country
							</div>
                <div class="small-text-box-div">
							<ss:select list="%{countryBeanList}" headerKey="-1" listKey="countryId" listValue="name" 
								headerValue="----Please Select----" theme="myTheme"
								cssClass="select2" name="plrOpt.countryId" id="countryId"
								cssStyle="width: 182px; margin-left:0px "  value="%{defaultCounry}"></ss:select>
						</div>
						</div>
						
						<div class="div-2">
            	<div class="lbl-name-div">
								State
						</div>
                <div class="small-text-box-div">
							<s:select list="#{}" headerKey="-1"
								headerValue="----Please Select----" theme="myTheme"
								cssClass="select2" name="plrOpt.stateId" id="state"
								cssStyle="width: 182px; margin-left:0px"></s:select>
						</div>
				 </div>
				 <div class="div-3">
								<div class="lbl-name-div">
									City
								</div>
								<div class="small-text-box-div">

									<s:textfield name="plrOpt.city" theme="myTheme"
										id="city" cssClass="text-field-small"></s:textfield>
								</div>
							</div>
				  </div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						 <div class="small-text-box-section" style="font-size: 12px;">
          <div class="div-1" style=" width:439px">
            	<div class="lbl-name-div">
								Is Verified
							</div>
               

							<s:checkboxlist name="plrOpt.isVerified" id="isVerified"
								list="#{'ageVerified':'Age','addressVerified':'Address','emailVerified':'Email','phoneVerified':'Mobile','taxationIdVerified':'Tax Id'}"></s:checkboxlist>
								</div>
								
					</div>
				</div>
				<div class="clearFRM"></div>
					<div class="FormMainBox">
						 <div class="small-text-box-section" style="font-size: 12px;">
						 		 <div class="div-5">
								<div class="lbl-name-div">
									Profile Status
								</div>

									<s:checkboxlist list="#{'MINI':'MINI','FULL':'FULL'}" name="plrOpt.status" id="status"></s:checkboxlist>
					</div>
						<div class="div-5">
								<div class="lbl-name-div">
									Player Status
								</div>

									<s:checkboxlist list="#{'ACTIVE':'ACTIVE','INACTIVE':'INACTIVE'}" name="plrOpt.plrStatus" id="plrStatus"></s:checkboxlist>
					</div>						 
				</div>
					</div>	 
				<div class="clearFRM"></div>
					<div class="FormMainBox">
						 <div class="small-text-box-section" style="font-size: 12px;">
          <div class="div-1" style=" width:439px">
            	<div class="lbl-name-div"  style="width: 150px">
								Uploaded Document Type
							</div>
									<s:select list="#{'-1':'--Select Document Type--','PASSPORT':'PASSPORT','DRIVING_LICENSE':'DRIVING LICENSE','VOTER_ID':'VOTER ID','PAN_CARD':'PAN CARD','AADHAR_CARD':'AADHAR CARD'}" name="plrOpt.uploadedDoc" id="uploadedDoc" cssClass="select2"></s:select>							
								</div>
								 <div class="div-3" style=" width:400px" id="uniqueNumDiv">
								<div class="lbl-name-div"  style="width: 100px">
									Unique Number 
								</div>
								<ss:textfield id="uniqueNo" name="plrOpt.docUniqueNum" disabled="true"></ss:textfield>
									
					</div>
					</div>
				</div>
				<div class="clearFRM"></div>
					<div class="FormMainBox">
						 <div class="small-text-box-section" style="font-size: 12px;">
          <div class="div-1" style=" width:439px">
            	<div class="lbl-name-div"  style="width: 150px" >
								Reg. Refer Source Type
							</div>
									<s:select list="#{'-1':'--Select Refer Type--','Direct':'Direct Player','REFER_FRIEND':'REFER FRIEND','SOCIAL_REFER':'SOCIAL REFER','AFFILIATE':'AFFILIATE','OLA':'OLA','PPC':'PPC'}" name="plrOpt.referSourceType" id="referSourceType" cssClass="select2"></s:select>							
								</div>
								 <div class="div-3" style=" width:400px" id="uniqueNumDiv">
								<div class="lbl-name-div"  style="width: 101px">
									Reg. Refer Source 
								</div>
								<s:select list="#{}" headerKey="-1"
								headerValue="----Please Select----" theme="myTheme"
								cssClass="select2" name="plrOpt.referSource" id="referSource"
								cssStyle="width: 182px; margin-left:0px " 
								></s:select>
								<s:hidden value="%{referSource}" id="referSourceMap"></s:hidden>	
					</div>
					</div>
				</div>
			</div>
			</div>
			</div>
			<div class="plrTransactionInfo">
				<div class="FormSection">
					<div class="greyStrip">
						<h4>
							Last Transaction Date
						</h4>
					</div>
					<div class="FormMainBox">
						 <div class="small-text-box-section">
        	<div class="div-5">
            	<div class="lbl-name-div">
								Wager
							</div>
                <div class="small-text-box-div-new">
							<s:textfield name="plrOpt.fromWagerDate" id="fromWagerDate"
								readonly="true" theme="myTheme"
								cssStyle="width:178px"
								placeholder="From Date" cssClass="text-field-small"></s:textfield>
							<s:textfield name="plrOpt.toWagerDate" id="toWagerDate"
								readonly="true" theme="myTheme"
								cssStyle="width:150px; margin-left:8px" placeholder="To date" cssClass="text-field-small"></s:textfield>

						</div>
</div>
						<div class="div-5">
            	<div class="lbl-name-div">
								Winning
							</div>
                <div class="small-text-box-div-new">
							<s:textfield name="plrOpt.fromWinDate" id="fromWinDate"
								readonly="true" theme="myTheme"
								cssStyle="width:150px" placeholder="From Date" cssClass="text-field-small"></s:textfield>
							<s:textfield name="plrOpt.toWinDate" id="toWinDate"
								readonly="true" theme="myTheme"
								cssStyle="width:178px; margin-left:8px" placeholder="To Date" cssClass="text-field-small"></s:textfield>

						</div>
					</div>
					 </div>
					  </div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
        	<div class="div-5">
            	<div class="lbl-name-div">
								Deposit
							</div>
                <div class="small-text-box-div-new">
							<s:textfield name="plrOpt.fromDepDate" id="fromDepDate"
								readonly="true" theme="myTheme"
								cssStyle="width:178px"
								placeholder="From Date" cssClass="text-field-small"></s:textfield>
							<s:textfield name="plrOpt.toDepDate" id="toDepDate"
								readonly="true" theme="myTheme"
								cssStyle="width:150px; margin-left:8px" placeholder="To date" cssClass="text-field-small"></s:textfield>

						</div>
						</div>
						
        	<div class="div-5">
            	<div class="lbl-name-div">
								Withdraw
							</div>
                <div class="small-text-box-div-new">
							<s:textfield name="plrOpt.fromWitDate" id="fromWitDate"
								readonly="true" theme="myTheme"
								cssStyle="width:150px" placeholder="From Date" cssClass="text-field-small"></s:textfield>
							<s:textfield name="plrOpt.toWitDate" id="toWitDate"
								readonly="true" theme="myTheme"
								cssStyle="width:178px; margin-left:8px" placeholder="To Date" cssClass="text-field-small"></s:textfield>

						</div>
					</div>
					</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
					<div class="small-text-box-section">
					<div class="div-5">
            	<div class="lbl-name-div">
								Login
							</div>
                <div class="small-text-box-div-new">
							<s:textfield name="plrOpt.fromLoginDate" id="fromLoginDate"
								readonly="true" theme="myTheme"
								cssStyle="width:178px" placeholder="From Date" cssClass="text-field-small"></s:textfield>
							<s:textfield name="plrOpt.toLoginDate" id="toLoginDate"
								readonly="true" theme="myTheme"
								cssStyle="width:150px; margin-left:8px" placeholder="To Date" cssClass="text-field-small"></s:textfield>

						</div>
					</div>
				</div>
			</div>
			</div>
			</div>
			<div class="plrBalInfo">
				<div class="FormSection">
					<div class="greyStrip">
						<h4>
							Balance Details
						</h4>
					</div>
					<div class="FormMainBox">
						 <div class="small-text-box-section">
						 <div class="div-5">
            	<div class="lbl-name-div">
								Cash Balance.
							</div>
                <div class="small-text-box-div-new">

							<ss:textfield name="plrOpt.minCashBal" id="minCashBal"
								theme="myTheme"
								cssStyle="width:178px"
								pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format." placeholder="Min"
								patternOn="both" cssClass="text-field-small">
							</ss:textfield>
							<ss:textfield name="plrOpt.maxCashBal" id="maxCashBal"
								theme="myTheme" cssStyle="width:150px; margin-left:8px"
								pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format."
								placeholder="Max" cssClass="text-field-small"></ss:textfield>

						</div>
						</div>
        	
						 <div class="div-5">
            	<div class="lbl-name-div">
								Bonus Bal.
							</div>
                <div class="small-text-box-div-new">
							<ss:textfield name="plrOpt.minBonBal" id="minBonBal"
								theme="myTheme" cssStyle="width:150px"
								pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format."
								placeholder="Min" cssClass="text-field-small"></ss:textfield>
							<ss:textfield name="plrOpt.maxBonBal" id="maxBonBal"
								theme="myTheme" cssStyle="width:178px; margin-left:8px"
								pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format."
								placeholder="Max" cssClass="text-field-small"></ss:textfield>
						</div>
					</div>
					</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						 <div class="small-text-box-section">
						 <div class="div-5">
            	<div class="lbl-name-div">
								Practice Bal.
							</div>
                <div class="small-text-box-div-new">

							<ss:textfield name="plrOpt.minPraBal" id="minPraBal"
								theme="myTheme"
								cssStyle="width:178px"
								pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format." placeholder="Min"
								patternOn="both" cssClass="text-field-small">
							</ss:textfield>
							<ss:textfield name="plrOpt.maxPraBal" id="maxPraBal"
								theme="myTheme" cssStyle="width:150px; margin-left:8px"
								pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format."
								placeholder="Max" cssClass="text-field-small"></ss:textfield>

						</div>
						</div>
        	
						 <div class="div-5">
            	<div class="lbl-name-div">
								Total Bal.
							</div>
                <div class="small-text-box-div-new">
							<ss:textfield name="plrOpt.minTotBal" id="minTotBal"
								theme="myTheme" cssStyle="width:150px"
								pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format."
								placeholder="Min" cssClass="text-field-small"></ss:textfield>
							<ss:textfield name="plrOpt.maxTotBal" id="maxTotBal"
								theme="myTheme" cssStyle="width:178px; margin-left:8px"
								pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format."
								placeholder="Max" cssClass="text-field-small"></ss:textfield>
						</div>
					</div>
				</div>
			</div>
			<div class="clearFRM"></div>
			<div class="FormMainBox">
						 <div class="small-text-box-section">
        	
						 <div class="div-5">
            	<div class="lbl-name-div">
								Pend. Bonus
							</div>
                <div class="small-text-box-div-new" style="font-size: 12px">
							<s:checkboxlist list="#{'Y':'Yes','N':'No'}"
								name="plrOpt.pendBonus" id="pendBonus"></s:checkboxlist>
						</div>
						</div>
					</div>
					</div>
			</div>
			</div>
			<div class="plrVipCriteria">
				<div class="FormSection">
					<div class="greyStrip">
						<h4>
							VIP Criteria
						</h4>
					</div>

					<table width="830" cellspacing="0" cellpadding="4" border="0"
						align="center" class="payTransaction" id="vipCriteriaTbl" style="font-size: 12px">


						<label> VIP Level </label>
						<ss:select list="%{vipLevelBeanList}" theme="myTheme" cssClass="select2"
							name="plrOpt.vipLevel" id="vipLevel" multiple="true" listKey="vipLevel" listValue="vipCode"></ss:select>
						<thead>
							<tr>

								<th width="5%" valign="middle" align="left" class="sNo"
									style="width: 98px; height: 20px;">
									Criteria
								</th>
								<th width="5%" valign="middle" align="left" class="sNo"
									style="width: 98px; height: 20px;">
									Last Month
								</th>
								<th width="5%" valign="middle" align="left" class="sNo"
									style="width: 98px; height: 20px;">
									Last Quarter
								</th>
								<th width="5%" valign="middle" align="left" class="sNo"
									style="width: 98px; height: 20px;">
									Last Year
								</th>
								<th width="5%" valign="middle" align="left" class="sNo"
									style="width: 98px; height: 20px;">
									Since Reg(Current Month Not included)
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>

								<td>
									<!--<s:textfield value="Login Freq" id="criteria_login" readonly="true"></s:textfield>
								-->
									<label id="criteria_login">Login Freq</label>
								</td>
								<td>
									<ss:textfield id="lastMonth_min_Freq_Login" pattern="^[0-9]*$"
										errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastMonth_max_Freq_Login" pattern="^[0-9]*$"
										errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastQuarter_min_Freq_Login"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastQuarter_max_Freq_Login"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastYear_min_Freq_Login" pattern="^[0-9]*$"
										errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastYear_max_Freq_Login" pattern="^[0-9]*$"
										errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="sinceRegi_min_Freq_Login" pattern="^[0-9]*$"
										errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="sinceRegi_max_Freq_Login" pattern="^[0-9]*$"
										errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
							</tr>
							<tr>

								<td>
									<!--<s:textfield value="Login Count" id="criteria_login" readonly="true"></s:textfield>
								-->
									<label id="criteria_login">Login Count</label>
								</td>
								<td>
									<ss:textfield id="lastMonth_min_Count_Login" pattern="^[0-9]*$"
										errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastMonth_max_Count_Login" pattern="^[0-9]*$"
										errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastQuarter_min_Count_Login"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastQuarter_max_Count_Login"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastYear_min_Count_Login" pattern="^[0-9]*$"
										errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastYear_max_Count_Login" pattern="^[0-9]*$"
										errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="sinceRegi_min_Count_Login" pattern="^[0-9]*$"
										errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="sinceRegi_max_Count_Login" pattern="^[0-9]*$"
										errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
							</tr>
							<tr>

								<td>
									<!--<s:textfield value="Deposit Freq" id="criteria_deposit" readonly="true"></s:textfield>
								-->
									<label id="criteria_deposit">Deposit Freq</label>
								</td>
								<td>
									<ss:textfield id="lastMonth_min_Freq_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastMonth_max_Freq_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastQuarter_min_Freq_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastQuarter_max_Freq_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastYear_min_Freq_Deposit" pattern="^[0-9]*$"
										errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastYear_max_Freq_Deposit" pattern="^[0-9]*$"
										errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="sinceRegi_min_Freq_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="sinceRegi_max_Freq_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
							</tr>
							<tr>

								<td>
									<!--<s:textfield value="Deposit Count" id="criteria_deposit" readonly="true"></s:textfield>
									
								-->
									<label id="criteria_deposit">Deposit Count</label>
								</td>
								<td>
									<ss:textfield id="lastMonth_min_Count_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastMonth_max_Count_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastQuarter_min_Count_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastQuarter_max_Count_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastYear_min_Count_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastYear_max_Count_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="sinceRegi_min_Count_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="sinceRegi_max_Count_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
								</td>
							</tr>
							<tr>

								<td>
									<!--<s:textfield value="Deposit Value" id="criteria_deposit" readonly="true"></s:textfield>
								-->
									<label id="criteria_deposit">Deposit Value</label>
								</td>
								<td>
									<ss:textfield id="lastMonth_min_Value_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastMonth_max_Value_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastQuarter_min_Value_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastQuarter_max_Value_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastYear_min_Value_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastYear_max_Value_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="sinceRegi_min_Value_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="sinceRegi_max_Value_Deposit"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
							</tr>
							<tr>

								<td>
									<!--<s:textfield value="Withdrawal Freq" id="criteria_withdrawal" readonly="true"></s:textfield>
								-->
									<label id="criteria_withdrawal">Withdrawal Freq</label>
								</td>
								<td>
									<ss:textfield id="lastMonth_min_Freq_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastMonth_max_Freq_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastQuarter_min_Freq_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastQuarter_max_Freq_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastYear_min_Freq_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastYear_max_Freq_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="sinceRegi_min_Freq_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="sinceRegi_max_Freq_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
							</tr>
							<tr>

								<td>
									<!--<s:textfield value="Withdrawal Count" id="criteria_withdrawal" readonly="true"></s:textfield>
								-->

									<label id="criteria_withdrawal">Withdrawal Count</label>
								</td>
								<td>
									<ss:textfield id="lastMonth_min_Count_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastMonth_max_Count_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastQuarter_min_Count_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastQuarter_max_Count_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastYear_min_Count_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastYear_max_Count_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="sinceRegi_min_Count_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="sinceRegi_max_Count_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
							</tr>
							<tr>

								<td>
									<!--<s:textfield value="Withdrawal Value" id="criteria_withdrawal" readonly="true"></s:textfield>
								-->
									<label id="criteria_withdrawal">Withdrawal Value</label>
								</td>
								<td>
									<ss:textfield id="lastMonth_min_Value_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastMonth_max_Value_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastQuarter_min_Value_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastQuarter_max_Value_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastYear_min_Value_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastYear_max_Value_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="sinceRegi_min_Value_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="sinceRegi_max_Value_Withdrawal"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
							</tr>
							<tr>

								<td>
									<!--<s:textfield value="WagerRummy Freq" id="criteria_wagerRummy" readonly="true"></s:textfield>
								-->
									<label id="criteria_wagerRummy">WagerRummy Freq</label>
								</td>
								<td>
									<ss:textfield id="lastMonth_min_Freq_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastMonth_max_Freq_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastQuarter_min_Freq_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastQuarter_max_Freq_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastYear_min_Freq_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastYear_max_Freq_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="sinceRegi_min_Freq_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="sinceRegi_max_Freq_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
							</tr>
							<tr>

								<td>
									<!--<s:textfield value="WagerRummy Count" id="criteria_wagerRummy" readonly="true"></s:textfield>
								-->
									<label id="criteria_wagerRummy">WagerRummy Count</label>
								</td>
								<td>
									<ss:textfield id="lastMonth_min_Count_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastMonth_max_Count_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>

								</td>
								<td>
									<ss:textfield id="lastQuarter_min_Count_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastQuarter_max_Count_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastYear_min_Count_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastYear_max_Count_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="sinceRegi_min_Count_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="sinceRegi_max_Count_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
							</tr>
							<tr>

								<td>
									<!--<s:textfield value="WagerRummy Value" id="criteria_wagerRummy" readonly="true"></s:textfield>
								-->
									<label id="criteria_wagerRummy">WagerRummy Value</label>
								</td>
								<td>
									<ss:textfield id="lastMonth_min_Valu_WagerRummye"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastMonth_max_Valu_WagerRummye"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastQuarter_min_Value_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastQuarter_max_Value_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="lastYear_min_Value_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="lastYear_max_Value_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
								<td>
									<ss:textfield id="sinceRegi_min_Value_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Min"></ss:textfield>
									<ss:textfield id="sinceRegi_max_Value_WagerRummy"
										pattern="^[0-9]*$" errorMassage="Please enter Numeric value."
										cssStyle="width: 58px; height: 20px;" placeholder="Max"></ss:textfield>
								</td>
							</tr>
						</tbody>
					</table>

				</div>
			</div>
			<div class="plrBonusInfo  ">
				<div class="FormSection">
					<div class="greyStrip">
						<h4>
							Bonus Details
						</h4>
					</div>
					<div class="FormMainBox">
						 <div class="small-text-box-section">
        	<div class="div-5">
            	<div class="lbl-name-div">
								Rec. Amount
							</div>
                <div class="small-text-box-div-new">
							<ss:textfield name="plrOpt.minBonRecAmount" id="minBonRecAmount"
								theme="myTheme" cssStyle="width:178px"
								placeholder="Min Amount" pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format." cssClass="text-field-small"></ss:textfield>
							<ss:textfield name="plrOpt.maxBonRecAmount" id="maxBonRecAmount"
								theme="myTheme" cssStyle="width:150px; margin-left:8px"
								placeholder="Max Amount" pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format." cssClass="text-field-small"></ss:textfield>

						</div>
						</div>
						
						<div class="div-5">
            	<div class="lbl-name-div">
								Exp. Amount
							</div>
                <div class="small-text-box-div-new">
							<s:textfield name="plrOpt.minBonExpAmount" id="minBonExpAmount"
								theme="myTheme" cssStyle="width:150px"
								placeholder="Min Amount" pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format." cssClass="text-field-small"></s:textfield>
							<s:textfield name="plrOpt.maxBonExpAmount" id="maxBonExpAmount"
								theme="myTheme" cssStyle="width:178px; margin-left:8px"
								placeholder="Max Amount" pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format." cssClass="text-field-small"></s:textfield>

						</div>
					</div>
					</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
        	<div class="div-5">
            	<div class="lbl-name-div">
								To Cash
							</div>
                <div class="small-text-box-div-new">
							<ss:textfield name="plrOpt.bonFromCash" id="bonFromCash"
								theme="myTheme"
								cssStyle="width:178px"
								pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format."
								placeholder="Min" cssClass="text-field-small"></ss:textfield>
							<ss:textfield name="plrOpt.bonToCash" id="bonToCash"
								theme="myTheme" cssStyle="width:150px; margin-left:8px"
								pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format."
								placeholder="Max" cssClass="text-field-small"></ss:textfield>
						</div>
						</div>
						<div class="div-5">
            	<div class="lbl-name-div">
								Pend. Amount
							</div>
                <div class="small-text-box-div-new">
							<ss:textfield name="plrOpt.minPenAmount" id="minPenAmount"
								theme="myTheme" cssStyle="width:150px"
								pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format."
								placeholder="Min" cssClass="text-field-small"></ss:textfield>
							<ss:textfield name="plrOpt.maxPenAmount" id="maxPenAmount"
								theme="myTheme" cssStyle="width:178px; margin-left:8px"
								pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format."
								placeholder="Max" cssClass="text-field-small"></ss:textfield>
						</div>
						</div>
					</div>
			</div>
			</div>
				

			</div>
				
			<div class="plrTxnDetails">
				<div class="FormSection">
					<div class="greyStrip">
						<h4>
							Transaction Details
						</h4>
					</div>
					<div class="FormMainBox">
						 <div class="small-text-box-section">
        	<div class="div-5">
            	<div class="lbl-name-div">
								Withdrawal 
							</div>
                <div class="small-text-box-div-new">
							<ss:textfield name="plrOpt.minWithdrawalAmount" id="minWithdrawalAmount"
								theme="myTheme" cssStyle="width:178px"
								placeholder="Min Amount" pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format." cssClass="text-field-small"></ss:textfield>
							<ss:textfield name="plrOpt.maxWithdrawalAmount" id="maxWithdrawalAmount"
								theme="myTheme" cssStyle="width:150px; margin-left:8px"
								placeholder="Max Amount" pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format." cssClass="text-field-small"></ss:textfield>

						</div>
						</div>
						<div class="div-5">
            	<div class="lbl-name-div">
								Deposit
							</div>
                <div class="small-text-box-div-new">
							<ss:textfield name="plrOpt.minDepositAmount" id="minDepositAmount"
								theme="myTheme" cssStyle="width:150px"
								pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format."
								placeholder="Min Amount" cssClass="text-field-small"></ss:textfield>
							<ss:textfield name="plrOpt.maxDepositAmount" id="maxDepositAmount"
								theme="myTheme" cssStyle="width:178px; margin-left:8px"
								pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format."
								placeholder="Max Amount" cssClass="text-field-small"></ss:textfield>
						</div>
						</div>
						
					</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
						<div class="div-5">
            	<div class="lbl-name-div">
								Winning 
							</div>
                <div class="small-text-box-div-new">
							<s:textfield name="plrOpt.minWinningAmount" id="minWinningAmount"
								theme="myTheme" cssStyle="width:178px"
								placeholder="Min Amount" pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format." cssClass="text-field-small"></s:textfield>
							<s:textfield name="plrOpt.maxWinningAmount" id="maxWinningAmount"
								theme="myTheme" cssStyle="width:150px; margin-left:8px"
								placeholder="Max Amount" pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format." cssClass="text-field-small"></s:textfield>

						</div>
					</div>
        	<div class="div-5">
            	<div class="lbl-name-div">
								Wager
							</div>
                <div class="small-text-box-div-new">
							<ss:textfield name="plrOpt.minWagerAmount" id="minWagerAmount"
								theme="myTheme"
								cssStyle="width:150px"
								pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format."
								placeholder="Min Amount" cssClass="text-field-small"></ss:textfield>
							<ss:textfield name="plrOpt.maxWagerAmount" id="maxWagerAmount"
								theme="myTheme" cssStyle="width:178px; margin-left:8px"
								pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format."
								placeholder="Max Amount" cssClass="text-field-small"></ss:textfield>
						</div>
						</div>
						
					</div>
			</div>
			<div class="clearFRM"></div>
					<div class="FormMainBox">
						<div class="small-text-box-section">
						<div class="div-5">
            	<div class="lbl-name-div">
								Bonus
							</div>
                <div class="small-text-box-div-new">
							<ss:textfield name="plrOpt.minBonusAmount" id="minBonusAmount"
								theme="myTheme"
								cssStyle="width:178px"
								pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format."
								placeholder="Min Amount" cssClass="text-field-small"></ss:textfield>
							<ss:textfield name="plrOpt.maxBonusAmount" id="maxBonusAmount"
								theme="myTheme" cssStyle="width:150px; margin-left:8px"
								pattern="^[0-9]*\.?[0-9]*$"
								errorMassage="Enter Value in correct format."
								placeholder="Max Amount" cssClass="text-field-small"></ss:textfield>
						</div>
						</div>
        	
						</div>
			</div>
				</div>

			</div>


			<div class="more_filter " align="left" style="font-size: 12px">
				More Filter:
				<s:a id="plrTransactionInfo" cssClass="plrTransactionInfo" href="#">
					<u>Last Transaction Date </u>  
			</s:a> |
				<s:a id="plrBalInfo" cssClass="plrBalInfo" href="#">
					<u>Balance Details</u>  
			</s:a> |
				<s:a id="plrVipCriteria" cssClass="plrVipCriteria" href="#">
					<u>VIP Criteria</u>  
			</s:a> |
				<s:a id="plrBonusInfo" cssClass="plrBonusInfo" href="#">
					<u>Bonus Details</u> 
				</s:a> |
				<s:a id="plrTxnDetails" cssClass="plrTxnDetails" href="#">
					<u>Transaction Details</u> 
				</s:a>



				<!--<s:a id="plrBonusCriteria" cssClass="plrBonusCriteria" href="#">
				<u>Bonus Criteria</u>
			</s:a>
		-->

			</div>
			
			<div class="box_footer" align="right"
				style="background: none; border: none" >
				<table>
				<tr>
				<td></td>
				<td>
				<ss:button id="reportToExcel" value="Download Excel"></ss:button>
				<div id="waitDiv" class="animated-button-div" style="margin-left: 0px; display: none;" >
					<div class="animated-striped" style="padding:3px 21px 2px 20px;">Wait...</div>
				</div>
				<s:submit name="Search" value="Search" cssClass="button" id="formSubmit"
					formnovalidate="true"></s:submit>
					<ss:button name="resetButton" value="Reset Filters" cssClass="button" id="resetButton"></ss:button>
				<ss:button id="advanceSearch" cssClass="button" value="Show Filters"></ss:button>
				</td>
				</tr>
				</table>
				

			</div>
			
			
			<div id="searchResult" >

			</div>
		</s:form>
		<div id="inactivePlrDiv"></div>
		<div id="downloadExcel"></div>
			
<br/>
<br/>
<br/>

	</body>
</html>