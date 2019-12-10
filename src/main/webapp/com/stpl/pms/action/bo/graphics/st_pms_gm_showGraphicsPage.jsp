<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Add Graphics</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path%>/com/stpl/pms/action/bo/cms/js/cms.js"></script>
    <SCRIPT type="text/javascript">
    var dmDefLangArr =  new Array();
    //  var dmDefCurrArr =  new Array();
	$(document).ready(function(){
    	$('#domainId').change(function(){
			$('#aliasId').empty().append($('<option></option>').val("-1").html("----Please Select----"));
	  		var aliasMap = _ajaxCallJson("com/stpl/pms/action/bo/ajax/bo_ajax_call_fetch_fetchAlaisMap.action?domainId="+$(this).val(),"");
	  		$.each(aliasMap,function(index, value) {
	  			$('#aliasId').append($('<option></option>').val(index).html(value));
	  		});
	  	});	 	
      
		$("#graphicsType").change(function(){
			if($("#graphicsType").val()=="Image"){
          		$("#graphicsPath").attr("accept",".bmp,.gif,.jpg,.png,.psd,.pspimage,.tga,.thm,.tif,.yuv,.dds");
          	}else if($("#graphicsType").val()=="Flash"){
            	$("#graphicsPath").attr("accept",".3g2,.3gp,.asf,.asx,.avi,.flv,.m4v,.mov,.mp4,.mpg,.rm,.srt,.swf,.vob,.wmv");
            }else if($("#graphicsType").val()=="Video"){
            	$("#graphicsPath").attr("accept",".3g2,.3gp,.asf,.asx,.avi,.flv,.m4v,.mov,.mp4,.mpg,.rm,.srt,.swf,.vob,.wmv");
           	}else if($("#graphicsType").val()=="Image_Gif"){
            	$("#graphicsPath").attr("accept",".bmp,.gif,.jpg,.png,.psd,.pspimage,.tga,.thm,.tif,.yuv,.dds");
           	}else if($("#graphicsType").val()=="Others"){
            	$("#graphicsPath").attr("accept",".bmp,.gif,.jpg,.png,.psd,.pspimage,.tga,.thm,.tif,.yuv,.dds,.3g2,.3gp,.asf,.asx,.avi,.flv,.m4v,.mov,.mp4,.mpg,.rm,.srt,.swf,.vob,.wmv,.css,.js");
            }
        });
        
        $("#domainId").find('option').each(function(){
			var optArr= $(this).val().split('|');
			dmDefLangArr[optArr[0]] = optArr[1];
			//dmDefCurrArr[optArr[0]] = optArr[2];
			$(this).val(optArr[0]);
		});
	});
    
    </SCRIPT>
   </head>
       
  <body>
		<div id="container">
			<h2>
				Add Graphics Page

			</h2>
			<div class="FormSection">
				<div class="greyStrip">
					<h4>
						Add Graphics Form
					</h4>
				</div>
				<s:form theme="myTheme" id="pomFrm" method="POST" enctype="multipart/form-data" action="st_pms_gm_uploadGraphics">
					<s:token name="strutsToken" id="strutsToken"></s:token>
					<div class="innerBox">

						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Domain Name:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:if test="%{domainId>1}">
									<s:hidden name="domainId" value="%{domainId}"
										id="domainId"></s:hidden>
									<s:property value="%{domainName}" />
								</s:if>
								<s:else>
									<ss:select theme="myTheme" applyscript="true" cssClass="select1"
										list="%{domainMap}" name="domainId" id="domainId"
										headerKey="-1" headerValue="--Please Select--"
										listKey="%{key}" listValue="%{value}"></ss:select>
								</s:else>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Alias Name:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
									<ss:select theme="myTheme" applyscript="true" cssClass="select1"
										list="%{}" name="aliasId" id="aliasId"
										headerKey="-1" headerValue="--Please Select--" ></ss:select>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Graphics Type:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<ss:select theme="myTheme" applyscript="true" cssClass="select1"
									list="{'Image','Flash','Video','Image_Gif','Others'}"
									name="graphicsType" id="graphicsType" headerKey="-1"
									headerValue="--Please Select--" 
									></ss:select>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Default Graphics:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:file name="graphicsPath" id="graphicsPath" theme="myTheme" applyscript="true"></s:file>
							</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Size:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
							<s:select theme="myTheme" cssClass="select1" applyscript="true"
									list="{'50x50','100x100','100x200','200x200'}"
									name="graphicSize" id="graphicSize" headerKey="-1"
									headerValue="--Please Select--"
									></s:select>
								</div>
						</div>
						<div class="clearFRM"></div>
						<div class="FormMainBox">
							<div class="labelDiv">
								<label>
									Related To:
								</label>
								<em class="Req">*</em>
							</div>
							<div class="InputDiv">
								<s:select theme="myTheme" cssClass="select1" applyscript="true"
									list="{'STATIC_PAGE','DYNAMIC','INTERNAL_LOBBY','EXTERNAL_LOBBY','LANDING_PAGE','HOME_PAGE','FOOTER','PLACE_HOLDER_WEB','AFFILIATE_BANNER','EMAIL','SMS'}"
									name="relatedTo" id="relatedTo" headerKey="-1"
									headerValue="--Please Select--"
									></s:select>
							</div>
						</div>
					</div>
					<div id="graphics_new_div"></div>
					<div class="box_footer" align="right">
						 <input type="button" id="addGraphics" value="Add Grapics For Other Language" onclick="addGraphicsNew()"/>
					     <s:submit theme="simple" id="submitBtn" value="submit"></s:submit>
					</div>
					
				</s:form>
			</div>
			
		</div>
	</body>
</html>
