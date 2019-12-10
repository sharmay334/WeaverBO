<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>

<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<%
  String fieldDispname[] = request.getParameter("fieldDispname").split(",");
  String fieldInputType[] = request.getParameter("fieldInputType").split(",");
  String fieldType[] = request.getParameter("fieldType").split(",");
  String pageNumber[] = request.getParameter("pageNumber").split(",");
  String fieldSequenceNo[] = request.getParameter("fieldSequenceNo").split(",");
  String alertStr[] = request.getParameter("alertStr").split(",");
  String sectionName[] = request.getParameter("sectionName").split(",");
  String optionValues[] = request.getParameter("optionValues").split(";,");
  String regType = request.getParameter("regType");
  %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Preview page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<script type="text/javascript"
			src="<%=path%>/js/jQuery/jquery-1.8.3.js"></script>
	<script type="text/javascript">
	function manipulateData(fieldDispname,fieldInputType,pageNumber,fieldSequenceNo,alertStr,sectionName,regType){
	
	//alert(fieldDispname+"\n"+fieldInputType+"\n"+pageNumber+"\n"+fieldSequenceNo+"\n"+alertStr+"\n"+sectionName);
	
	}
	
	$(document).ready(function(){
	$('div[id="page_1"]').attr('style','display: block');
	
	});
	
	
	
	function changePage(buttonElem,type){
				  var index = buttonElem.getAttribute('lang');
				  $('div[id*="page_"]').attr('style','display: none');
				  if(type=='next'){
				    index = parseInt(index)+1;
				  }
				  else if(type=='back')
				  {
				   index = parseInt(index)-1;
				  }
				  $('div[id="page_'+index+'"]').attr('style','display: block');
			}
	</script>
	
	<STYLE type="text/css">
	@charset "utf-8";

/* CSS Document */
body {
	margin: 0px;
	padding: 0px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	color: #fff;
	font-size: 11px;
	background: #980101 url(../images/bg-red.gif) top repeat-x;
}

img {
	border: 0px;
}

form {
	margin: 0px;
	padding: 0px;
}

a {
	text-decoration: none;
	color:#fff;
}

a:hover {
	text-decoration: underline;
}

ul {
	margin: 0px;
	padding: 0px;
	list-style-type: none;
}

p {
	margin: 0px;
	padding: 0px;
}

h1,h2,h3,h4,h5,h6 {
	margin: 0px;
	padding: 0px;
}

#container {
	width: 950px;
	height: auto;
	margin: 0 auto;
}

#header {
	width: 100%;
	height: auto;
}

#header .logo {
	width: 401px;
	height: 75px;
	float: left;
	
}

#header_right {
	width: 540px;
	height: 70px;
	float: right; /*border:1px #F00 solid;*/
	padding-top: 5px;
	font-size: 11px;
	

}

#header_right .quickbg {
	width: 130px;
	height: 24px;
	background: #820101;
	float: left;
	padding: 4px 0px 0px 3px;
	
}


#header_right .language {
	width: 70px;
	height: 24px;
	background: #820101;
	float: left;
	padding: 4px 0px 0px 3px;
	
}

#language{ font-size: 11px; border: thin; border-color: #680000;}


.quickbg input {
	width: 100px;
	height: 18px;
	float: left;
	font-size: 11px;
}

#header_right .quickInp {
	width: 21px;
	height: 19px;
	background: url(../images/quic_bt.gif) no-repeat;
	float: left;
	border: none;
	margin: 0px 0px 0px 2px
}

#header_right .loginbox {
	width: 246px;
	height: 55px;
	background: #820101;
	float: left;
	margin-left: 8px;
	float: right;
	padding: 3px;
	border:1px #820101 solid; -moz-border-radius:5px;
	-webkit-border-radius:5px;
}

#header_right .user_passInp {
	width: 95px;
	height: 20px;
	font-size: 11px;
	margin-top: 14px;
	border: 1px #666666 solid;
	color:#666666;
}

#header_right .log {
	width: 23px;
	height: 22px;
	background: url(../images/go.gif) no-repeat;
	border: none;
	margin: 13px 0px 0px 4px;
}

#header_right .pdleft {
	padding-left: 14px;
}

.style1 {
	color: #FFF;
	padding-bottom: 4px;
	font-weight: bold;
}

.style3 {
	color: #fff;
	font-size: 10px;
	padding:0px 4px 0px 0px;
}

.style3 a {
	color: #fff;
	font-weight:bold;
	font-size: 10px;
	padding:0px 2px 0px 0px;
}
.style3 a:hover {
	color: #ffae00;
	text-decoration:none:
	
}



.style4 a {
	color: #fff;
	padding: 0px 0px 0px 78px;
}

.flot_left {
	float: left;
}


.flot_right{
	float: right;
	}
	
.checkifbox{/*width: 100%; height:22px; border: 1px #ff0000 solid; padding-top: 4px;*/}


.forgot-register {
	margin-top: 13px;
	clear:both;
}

.clear {
	width: 100%;
	height: 4px;
	clear: both;
}

#banner {
	width: 99.8%;
	height: 300px;
	clear: both;
	margin-top: 0px;
}
#banner img
	{
		width: 100%;
	}
#Gamebox {
	width: 99.5%;
	height: 250px;
	border: 1px #000 solid;
}

/*footer section*/
#fotterbox {
	width: 950px;
	height: 150px;
	margin-top: 30px;
	position: relative;
	clear: both;
	/*border: 1px #ff0000 solid;*/
}

.ftrlinks {
	width: 100%;
	height: auto;
	float: left;
	margin-top: 8px;
}

.ftrlinks p {
	display: inline;
	color: #686868;
}

.ftrlinks p a {
	color: #fff;
	font-size: 12px;
	margin: 0px 5px 0px 4px;
	text-decoration: none;
}

.ftrlinks p a:hover {
	color: #FFF;
	text-decoration: underline;
}

.social_icon {
	width: 27%;
	height: auto;
	float:left;
}

.logo_sikkim {
	width: 113px;
	height: 118px;
	float: left;
	position: absolute;
	right: 205px;
	bottom: 83px;
}

.social_icon img {
	float: right;
	margin: 0px 6px 0px 0px;
}

#fotterbox .btm {
	width: 100%;
	height: 80px;
	background: url(../images/bg-fotter.jpg) no-repeat;
	clear: both;
}

#fotterbox .btm img {
	margin: 8px 0px 0px 62px;
}

/*footer section end*/

.welcomeBalBox p {
	color: #FFF;
	padding: 3px;
	font-size: 12px;
	
}

.welcomeBalBox_left{width:178px; height:auto; /*border: 1px #ff0000 solid;*/ float:left;}
.welcomeBalBox_rightIcon{width:auto; height:auto; /*border: 1px #ff0000 solid;*/ float:right;}

.welcomeBalBox p span {
	font-weight: bold;
}

.welcomeBalBox img {
	
	
}



/*-------------------------------------------------- Left section start-----------------------------------------------*/
#leftPanel{width:173px; height:auto; min-height:400px; margin-bottom:15px; background:#990000; margin-top:0px; margin-left:0px;  float:left;}
#boxleft{width:165px; height:auto; float:left; background:#990000; margin:0 auto; padding:0px 8px 10px 0px; }
#leftPanel h4{width:163px; color:#FFF; margin-bottom:9px; font: bold 12px Arial; background:#d10000; /*background:url(images/titlebar.png) repeat-x left center;*/ text-transform:uppercase; padding: 4px 0 4px 10px;}
#box2{float:left; margin-left:0px; width:20%; height:400px; background:#990033; margin:10px 0px 0px 10px;}
.arrowlistmenu{width: 173px; /*width of accordion menu*/}

.arrowlistmenu .menuheader{ /*CSS class for menu headers in general (expanding or not!)*/
font: bold 12px Verdana, Arial;
color: white;
/*background: black url(../images/titlebar.png) repeat-x center left;*/
background:#d10000;
margin-bottom: 4px; /*bottom spacing between header and rest of content*/
text-transform: capitalize;
padding: 4px 0 4px 10px; /*header text is indented 10px*/

}

.arrowlistmenu .openheader{ /*CSS class to apply to expandable header when it's expanded*/
background-image: url(../images/titlebar-active.png);
}

.arrowlistmenu ul{ /*CSS for UL of each sub menu*/
list-style-type: none;
margin: 0;
padding: 0;
margin-bottom: 8px; /*bottom spacing between each UL and rest of content*/
}


.arrowlistmenu ul li{
padding-bottom: 2px; /*bottom spacing between menu items*/
}

.arrowlistmenu ul li a{
color: #ffffff;
/*background: url(images/arrowbullet.png) no-repeat center left; margin-left:8px; /*custom bullet list image*/
display: block;
padding: 4px 0;
padding-left: 12px; /*link text is indented 19px*/
text-decoration: none;
font-weight: bold;
border-bottom: 1px solid #dadada;
font-size: 11px;
}

.arrowlistmenu ul li a:visited{
color: #ffffff;
}

.arrowlistmenu ul li a:hover{ /*hover state CSS*/
color: #000;
/*background-color: #F3F3F3;*/

}

.mininav{margin-left:8px; font-weight:normal; color:#000; color:#FFF; display:block;} 
.mininav:hover{color:#000;}

/*-------------------------------------------------------- Left section end--------------------------------------------------*/



#account_content{width:80%; min-height:392px; height:auto;float:right; padding:4px; color:#fff;background-color:#5c0000; line-height:22px;margin-bottom: 30px;}
#account_content h4{color:#ffa200; font-size:15px; margin:0px 0px 0px 0px; text-transform: uppercase; font-family:Candara;}
#content{width:100%; min-height:350px; height:auto; padding:0px; color:#fff; background-color:#5c0000; line-height:22px; margin-bottom: 30px;}
#content h4{color:#ffa200; font-size:15px; margin:0px 0px 0px 0px; text-transform: uppercase; font-family:Candara;}

#account_content fieldset{border:1px #3a0100 solid; width:98%; min-height:100px; height:auto; margin:5px 1px 0px 1px;}
#account_content legend{font-weight:bold; color:#fff;}
/*#account_content input[type="submit"]{background:#af1010; color:#FFF; font-weight:bold; font-size:12px; padding:0px 3px 0px 3px; font-family:Arial, Helvetica, sans-serif; border:1px #e70000 solid; margin-top:12px;}*/
#account_content select{color:#000; padding:0px 0px 0px 3px; border:1px #e70000 solid; margin-top:0px; font-size:11px;}
#account_content input[type="password"]{color:#000; padding:0px 0px 0px 3px; border:1px #e70000 solid;}
#account_content input[type="text"]{color:#000; padding:0px 0px 0px 3px; border:1px #e70000 solid;}
/*#account_content input[type="reset"]{background:#af1010; color:#FFF; font-weight:bold; font-size:12px; padding:0px 3px 0px 3px; font-family:Arial, Helvetica, sans-serif; border:1px #e70000 solid; margin-top:12px;}
#account_content input[type="button"]{background:#af1010; color:#FFF; font-weight:bold; font-size:12px; padding:0px 3px 0px 3px; font-family:Arial, Helvetica, sans-serif; border:1px #e70000 solid; margin-top:12px;}*/
/*#content input[type="button"]{background:#af1010; color:#FFF; font-weight:bold; font-size:12px; padding:0px 3px 0px 3px; font-family:Arial, Helvetica, sans-serif; border:1px #e70000 solid; margin-top:12px;}*/


.greyshade{width:99.7%; height:26px; padding-left:2px; margin-top:0px; background-color:#550000;margin-bottom: 2px;}
.labelbody{width:100%; height:auto;}

.blak{
	color:#000000;
}
.requiredfiled{width:100%; text-align:right;}
.bordr{
	border:1px solid #e5e3e3;	
}
.star{	
	color:#ff0000;
	width:0.45em	
}

.col1{	
	width:25%;
	text-align:right;	
	float:left;	
	height:3em;
	padding-right:0.2em;
	/*border:1px #ff0000 solid;*/
		
	
}

.rightcol1{	
	width:25%;
	text-align:left;	
	float:left;	
	height:3em;
	padding-right:0.2em;
	/*border:1px #ff0000 solid;*/
		
	
}

.col2{	
	width:40%;
	height:3em;
	text-align:left;
	float:left;
	padding-left:5px;
	/*border:1px #ff0000 solid;*/
}

.col3{
	width:33%;
	text-align:left;
	height:3em;
	float:left;
	color:white;
	/*border:1px #ff0000 solid;*/
	}
	

.redcol3 {
	width: 33%;
	text-align: left;
	color: red;
	height: 3em;
	float: left;
	line-height: 100%;
}
	
.col2 select{color:#000; padding:0px 0px 0px 3px; border:1px #e70000 solid; margin-left:0px; font-size:11px;}	
	
#content fieldset{border:1px #3a0100 solid; width:98%; min-height:100px; height:auto; margin:5px 1px 0px 1px;}
#content legend{font-weight:bold; color:#fff;}
/* #content input[type="submit"]{background:#af1010; color:#FFF; font-weight:bold; font-size:12px; padding:0px 3px 0px 3px; font-family:Arial, Helvetica, sans-serif; border:1px #e70000 solid; margin-top:12px;} */
#content select{color:#000; padding:0px 0px 0px 3px; border:1px #e70000 solid; margin-top:0px; font-size:11px;}
#content input[type="password"]{color:#000; padding:0px 0px 0px 3px; border:1px #e70000 solid;}
#content input[type="text"]{color:#000; padding:0px 0px 0px 3px; border:1px #e70000 solid;}
/* #content input[type="reset"]{background:#af1010; color:#FFF; font-weight:bold; font-size:12px; padding:0px 3px 0px 3px; font-family:Arial, Helvetica, sans-serif; border:1px #e70000 solid; margin-top:12px;}
*/
#payTransaction
{
font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;
width:100%;
border-collapse:collapse;
}

#payTransaction td, #customers th 
{
font-size:12px;
border:1px solid #5b0001;
padding:3px 7px 2px 7px;
}

#payTransaction th 
{
font-size:14px;
text-align: left;
padding-top:5px;
padding-left:5px;
padding-bottom:4px;
background-color:#5b0001;
color:#ffffff;
border:1px solid #5b0001;
}

.Captch_col1{	
	width:49%;
	text-align:right;	
	float:left;	
	height:5em;
	/*padding-right:0.2em;*/
	padding-top:1.5em;
}
.Captch_col2{	
	width:28%;
	text-align:right;	
	float:left;	
	height:5em;
	padding-right:0.2em;
	padding-top:2.5em;
	padding-left:5px;
	
}



.Captch_col2 a{ color:#fff; text-decoration: underline; }


.tabbox2{width:100%; height:auto; margin-top:8px; padding-left:4px; height:40px;}
.tab2{display:inline;}
.tab2 a{float:left; background-color:#161616; font-size:11px; font-weight:bold; text-align:center; color:#FFFFFF; width:auto; height:21px; padding:2px 8px 2px 8px; text-decoration:none; line-height:19px; margin-right:4px;}
/*.tab2 a:hover{background:#af1010; background-image:url("../images/arrow_up1.gif"); background-repeat:no-repeat; background-position:bottom;text-decoration: none;}*/
.tab2 .current{background:#af1010; background-image:url("../images/arrow_up1.gif"); background-repeat:no-repeat; background-position:bottom; text-decoration: none;}

.IGEbutton1{cursor:pointer; width:74px; height:23px; background:url(<%=path%>/images/YellowBTN1.png) center no-repeat; color:#64300d; font-size:13px; text-transform:uppercase; border:none; font-weight:bold; text-align:center;  padding-bottom:4px; font-family:Candara;}

.IGEbutton2{cursor:pointer; width:124px; height:23px; background:url(<%=path%>images/YellowBTN2.png) center no-repeat; color:#64300d; font-size:13px; text-transform:uppercase; border:none; font-weight:bold;  text-align:center;  padding-bottom:4px; font-family:Candara;}
.IGEbutton3{cursor:pointer; width:124px; height:23px; background:url(<%=path%>/images/YellowBTN3.png) center no-repeat; color:#64300d; font-size:13px; text-transform:uppercase; border:none; font-weight:bold;  text-align:center;  padding-bottom:4px; font-family:Candara;}

/*new games block start*/
#banner_HomeNew{width:100%; height:auto; clear:both; margin-top:5px;}
#GameLobbyLargeBox{ width:100%; height:250px; margin-top:10px;}
#GameLobbyLargeBox img{ float:left; margin:0px 1px 0px 5px; border:2px #4b0100 solid;}
#GameLobbyLargeBox img:hover{ border:2px #ffc000 solid; cursor:pointer;}
/*new games block end*/
.success1{font-size: 18px;text-align: center;}




#pswd_info {
	border-style:solid;
	border-width:2px;
	position:static;
	bottom:-75px;
	bottom: -115px\9; /* IE Specific */
	right:55px;
	width:220px;
	padding:15px;
	font-size:.875em;
	border-radius:2px;
	box-shadow:0 1px 3px #ccc;
	
}

#pswd_info h3 {
	color: #FFA200;
	margin:0 0 10px 0;
	padding:0;
	font-weight:normal;
}
#pswd_info::before {
	content: "\25B2";
	position:relative;
	top:-12px;
	left:40%;
	font-size:14px;
	line-height:14px;
	color:#ddd;
	text-shadow:none;
	display:block;
}
.invalid {
	background:url(../images/btn_del.gif) no-repeat 0 50%;
	padding-left:22px;
	line-height:24px;
	color:red;
}
.valid {
	background:url(../images/correct.gif) no-repeat 0 50%;
	padding-left:22px;
	line-height:24px;
	color:white;
}

#score {
	color: #000;
	font-size: 85%;
	position:absolute;
	text-align: center;
	width: 100px;
	z-index: 10;
}
#score,#rating,#standards {
	font-weight: bold;
}
#scorebar {
	background-image: url(../images/bg_strength_gradient.jpg);
	background-repeat: no-repeat;
	background-position: 0 0;
	position:absolute;
	width: 100px;
	z-index: 0;
}
#scorebarBorder {
	background: #990000;
	border: 1px #000 solid;
	height: 16px;
	margin-bottom: 2px;
	width: 100px;
}
	</STYLE>
	
  </head>
  
  <body onload="manipulateData('<%=fieldDispname %>','<%=fieldInputType %>','<%=pageNumber %>','<%=fieldSequenceNo %>','<%=alertStr %>','<%=sectionName %>','<%=regType %>')">
  <div id="container">
  <div id="header" style="width: 950px; height: 114px;"></div>
  <div id="decoBody" style="width: 950px; height: 350px;">
  <div id="content">
  <div class="content">
			<div>
				<div>
					<div class="left"></div>
					<div class="middle">
						<div>
						<h5 align="right"><a href="#" onclick="window.close()"  style="align: right">Close Window</a></h5>
						<h4>
							REGISTRATION
						</h4></div>
							
					</div>
					<div class="right"></div>
				</div>
			</div>
			<div id="regisbody">
				<div class="requiredfiled">
					Required fields are marked with an asterisk (<em>*</em>)
				</div>
				<%
				int i=0;
				for(int j=0;j<sectionName.length;j++){ %>
				<div <%if(!regType.equals("SINGLEPAGE")){ %>style="display: none;"<%} %> id="page_<%=j+1 %>">	<fieldset class="bordr">
					<legend class="blak">
						<%=sectionName[j] %>
					</legend>
				<%
				
				boolean first= false;
				while(i<fieldSequenceNo.length && (!fieldSequenceNo[i].equals("1") || first==false)){
				
				
				 %>
				<div class="labelbody">
									<div class="col1">
										<%=fieldDispname[i] %>
									</div>
									<div class="col2">
									
									
									<%if(!fieldInputType[i].equals("Select")){
									 %>
											<%  String[] options = optionValues[i].split(","); for(int k=0;k<options.length;k++){ 
												if(!options[k].equals(";")){
											%>	<input type="<%=fieldInputType[i] %>" value="<%=options[k] %>"/><%}
												else { %><input type="<%=fieldInputType[i] %>" value=""/><%}
											}
											}
											else{ %>
											<select><%  String[] options = optionValues[i].split(","); for(int k=0;k<options.length;k++){%><option><%=options[k] %></option><%}%></select>
											<%}%>
									
									<%if(fieldType[i].equals("Y")){ %><span class="star">*</span><%} %>
									
				</div>
				<div class="col3"><% System.out.println("ieiowdjjwd"+alertStr.length); if(!alertStr[i].equals("$")){%><s:property value="%{#resource.getProperty('global.'+alertStr[i])}"></s:property><%} %></div>
				</div>
				<%
				i++;
				first=true;
				
				} %>
				<div>
								<div class="col1"></div>
								<div class="col2">
									<input type="button"
										onclick="changePage(this,'next')"
										value="Next" id="button_<%=j %>" class="IGEbutton1"
										<%if(j==(sectionName.length-1) || regType.equals("SINGLEPAGE")){ %>style="display:none"<%} %>
										lang="<%=j+1 %>">
									<input type="submit" value="Submit"
										action="" class="IGEbutton1"
										<%if(j<(sectionName.length-1)){%>style="display:none"<%} %>
										onclick=""
										id=""
										lang="">
									<input type="button" onclick="changePage(this,'back')"
										value="Back" class="IGEbutton1"
										<%if(j==0 || regType.equals("SINGLEPAGE")){ %>style="display:none"<%} %>
										lang="<%=j+1 %>">
								</div>
								<div class="col3"></div>
							</div>
				
				
				</fieldset>
			</div>
			<%} %>
			</div>
		</div>
  </div></div></div>
  </body>
</html>
