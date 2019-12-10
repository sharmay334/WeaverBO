<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%
String path = request.getContextPath();
String basePath =  (String)request.getAttribute("basePathURL") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//Ddiv HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>Edit Menu</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=path%>/js/commonfunctions.js"></script>
	<script type="text/javascript">
	var stop1 = false;
	var stop2 = false;
	$(document).ready(function() {
		$("#domainId").change(function(){
			$('#menu').empty().append($('<option></option>').val("-1").html("----Please Select----"));
			$('#device').val("-1");
			$("#menuDiv").html("");
		});
		var contentMap = $("#contentMap").val();
		var contentMapJSON = $.parseJSON(contentMap);
		$('select[id^="contentName"]').each(function() {
							var suffix = $(this).attr("id").replace("contentName", "");
							var contentTypeId = "contentType"+ suffix;
							var contentType = $("#" + contentTypeId).val();
							if (contentType != "-1") {
								var contentNameList = contentMapJSON[contentType];
								var contentId;
								for ( var i = 0; i < contentNameList.length; i++) {
									if (contentNameList[i].contentName.toLowerCase() == $("#content" + suffix).val().toLowerCase()) {
										contentId = contentNameList[i].contentId;
									}
									$(this).append($('<option></option>').val(contentNameList[i].contentId)
															        .html(contentNameList[i].contentName));
								}
								$(this).val(contentId);
							}

						});

	});

	
    $(".h3").click(function( event ) {
        if ( stop1 ) {
            event.stopImmediatePropagation();
            event.preventDefault();
            stop1 = false;
        }
        createBubble();
    });
    
    $(".h2").click(function( event ) {
        if ( stop2 ) {
            event.stopImmediatePropagation();
            event.preventDefault();
            stop2 = false;
            
        }
        createBubble();
    });
	  $(".UIaccordian1").accordion( {
                       collapsible : true,
                       clearStyle : true,
                       heightStyle: "content",
                       header : 'div[id="h1"]',
                       icons : {header : "plus1",headerSelected : "minus1" },
                       active : 0
               });
       $('.UIaccordian2').accordion( {
                       collapsible : true,
                       clearStyle : true,
                       heightStyle: "content",
                       header : 'div[id^="h2"]',
                       icons : { header : "plus1",headerSelected : "minus1"},
                       active : false
               });
               
       $('.UIaccordian3').accordion( {
                       collapsible : true,
                       clearStyle : true,
                       heightStyle: "content",
                       header : 'div[id^="h3"]',
                       icons : {header : "plus1",headerSelected : "minus1"},
                       active : false
               });
               
      
    var fixHelper = function(e, ui) {
	ui.children().each(function() {
		$(this).css('width',$(this).css('width'));
	});
	return ui;
   };
   
  $(function() {
   var count = $("#count2").val();
   for(var i =0;i<=count;i++){
		var id = "#sortable3_"+i;	
		$(id).sortable({
		helper: fixHelper,handle: ".handle",opacity: 0.5,
	    scope: "drop",items: 'div[id*="level3_"]',axis: "y",
	    start :function() {
	        $('.accordianHeader').css("cursor","move");
	    },
	    stop: function() {
	        $('.accordianHeader').css("cursor","pointer");
	        stop1 = true;
	        createBubble();
	    }
	   });
  }});
		
  $("#sortable2").sortable({
	helper: fixHelper,handle: ".handle",opacity: 0.5, 
	scope: "drop",items: 'div[id*="sub"]',axis: "y",
    start :function() {
       $('.accordianHeader').css("cursor","move");
    },
    stop: function() {
       $('.accordianHeader').css("cursor","pointer");
       stop2 = true;
       createBubble();
    }
   });
	
	
	function addLevel2(){
	 var count = $("#count2").val();
	 count++;
              $("#count2").val(count);
	 var content = $("#addContent").html();
	 var html = '<div style="width: 95%;" class="FormSection UIaccordian2" id="sub_'+count+'"><div class="accordianHeader greyStrip handle h2" style="width:850px" id="h2_'+count+'"><h4>Level2 Detail:</h4></div><div  class="accordian_content" id="accordian_content_'+count+'" style="width: 820px;margin-top: -5px">'+content+'<div id="sortable3_'+count+'"><div id="level3Content_'+count+'"></div></div><div class="box_footer" align="right" style="background: #f2f2f2; border: none;font-size: 11px"><input id="addSubMenu3_'+count+'" class="button" type="button" value="Add Level3" onclick="addLevel3ForEdit(this.id)"/></div></div></div>';
	 $("#level2Content").append(html);
	 $('#sub_'+count+' input[id*="displayName_"]').attr("id","displayName_"+count);
	 $('#sub_'+count+' input[name*="status_"]').attr("name","status_"+count);
	 $('#sub_'+count+' select[id*="contentType_"]').attr("id","contentType_"+count);
	 $('#sub_'+count+' select[id*="contentName_"]').attr("id","contentName_"+count);
	 $('#sub_'+count+' input[id*="menuId_"]').attr("id","menuId_"+count).val("0");
	 $('#sub_'+count+' input[name*="highLightOpt_"]').attr("name","highLightOpt_"+count);
	 if($(':checked[name="status"]').val()=='ACTIVE'){
	   $('input[name="status_'+count+'"] :nth(0)').attr("checked","checked");
	  }else{
	   $('input[name="status_'+count+'"] :nth(1)').attr("checked","checked").attr('disabled', 'disabled');
	  }
	 $('input[name="highLightOpt_'+count+'"] :nth(1)').attr("checked","checked");
	 	
		createBubble();
	 $(".h2").click(function( event ) {
        if ( stop2 ) {
            event.stopImmediatePropagation();
            event.preventDefault();
            stop2 = false;
        }
        createBubble();
    });
	 $('.UIaccordian2').accordion( {
                       collapsible : true,
                       clearStyle : true,
                       heightStyle: "content",
                       header : 'div[id="h2_'+count+'"]',
                       icons : { header : "plus1",headerSelected : "minus1"},
                       active : 0
               });
              
  $("#sortable2").sortable({
	helper: fixHelper,handle: ".handle",opacity: 0.5,
    scope: "drop",items: 'div[id*="sub"]',axis: "y",
    start :function() {
         $('.accordianHeader').css("cursor","move");
    },
    stop: function() {
         $('.accordianHeader').css("cursor","pointer");
         stop2 = true;
         createBubble();
     }
     
   });
             return false; 
	}
	
	
	function addLevel3ForEdit(id) {
	  var arr = id.split('_');
	  var count1 = arr[1];
	  var count2 = $('div[id*="level3_'+arr[1]+'"]').length;
	  var content = $("#addContent").html();
	  var html = '<div style="width: 95%;" class="FormSection UIaccordian3" id="level3_'+count1+'_'+count2+'"><div class="accordianHeader greyStrip handle h3" style="width:775px" id="h3_'+count1+'_'+count2+'"><h4>Level3 Detail:</h4></div><div  class="accordian_content" id="accordian_content_'+count1+'_'+count2+'" style="width: 745px;margin-top: -5px">'+content+'</div></div>';
	  $("#level3Content_"+arr[1]).append(html);
	  $('#level3_'+count1+'_'+count2+' input[id*="displayName_"]').attr("id","displayName_"+count1+"_"+count2);
	  $('#level3_'+count1+'_'+count2+' input[name*="status_"]').attr("name","status_"+count1+"_"+count2);
	  $('#level3_'+count1+'_'+count2+' select[id*="contentType_"]').attr("id","contentType_"+count1+"_"+count2);
	  $('#level3_'+count1+'_'+count2+' select[id*="contentName_"]').attr("id","contentName_"+count1+"_"+count2);
	  $('#level3_'+count1+'_'+count2+' input[id*="menuId_"]').attr("id","menuId_"+count1+"_"+count2).val("0");
	  $('#level3_'+count1+'_'+count2+' input[name*="highLightOpt_"]').attr("name","highLightOpt_"+count1+"_"+count2);
	  if($(':checked[name="status_'+count1+'"]').val()=='ACTIVE'){
	    $('input[name="status_'+count1+'_'+count2+'"]:nth(0)').attr("checked","checked");
	  }else{
	    $('input[name="status_'+count1+'_'+count2+'"]:nth(1)').attr("checked","checked").attr('disabled', 'disabled');
	  }
		$('input[name="highLightOpt_'+count1+'_'+count2+'"]:nth(1)').attr("checked","checked")
	 createBubble();
    $(".h3").click(function( event ) {
        if ( stop1 ) {
            event.stopImmediatePropagation();
            event.preventDefault();
            stop1 = false;
        }
        createBubble();
    });
	  $('.UIaccordian3').accordion( {
                       collapsible : true,
                       clearStyle : true,
                       heightStyle: "content",
                       header : 'div[id="h3_'+count1+'_'+count2+'"]',
                       icons : {header : "plus1",headerSelected : "minus1"},
                       active : 0
               });
  $(function() {
    var count = $("#count2").val();
    for(var i =0;i<=count;i++){
	var id = "#sortable3_"+i;	
	$(id).sortable({
	helper: fixHelper,handle: ".handle",  opacity: 0.5,
    scope: "drop", items: 'div[id*="level3_"]',axis: "y",
    start :function() {
     $('.accordianHeader').css("cursor","move");
    },
    stop: function() {
              $('.accordianHeader').css("cursor","pointer");
                stop1 = true;
                createBubble();
            }
    });
  }});
}
	
	
	</script>

  </head>
  
  <body>
			<s:hidden id="contentMap" name="contentMap"></s:hidden>
			<s:hidden name="menuString" id="menuString"></s:hidden>
			<s:hidden id="menuType" value="edit"></s:hidden>
			<div class="FormSection UIaccordian1" id="main">
				<div class="accordianHeader greyStrip" id="h1" style=" width:95%;">
					<h4>
						Menu Detail
					</h4>
				</div>
				<div  class="accordian_content" style="width: 902px;margin-top: -5px">
					<div class="FormMainBox">
						<div class="labelDiv">
							<label>
								Display Name:
							</label>
						</div>
						<div class="InputDiv">
						    <s:hidden id="menuId" value="%{menuData.menuId}"></s:hidden>
							<ss:textfield id="displayName" applyscript="true"
						theme="myTheme" value="%{menuData.menuDisplayName}"></ss:textfield>
						</div>
					</div>
					<div class="clearFRM"></div>
					
					<div class="FormMainBox">
					 <div class="labelDiv">
							<label> Show On Page:</label>
					 </div>
					 <div class="InputDiv">
						<s:radio  list="#{'ACTIVE':'Y','INACTIVE':'N'}"
						value="%{menuData.status}" name="status" id="status"
						cssClass="inpSpan" theme="simple" onchange="checkStatus(this.name)"></s:radio>
					</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						 <div class="labelDiv">
							<label>Content Type: </label>
					 </div>
					 <div class="InputDiv">
						<ss:select headerKey="-1" onchange="getContentNameList(this.id)"
						headerValue="-- Please Select --" cssClass="select1"
						id="contentType" cssStyle="font-size:14px"
						list="{'STATIC_PAGE','DYNAMIC','INTERNAL_LOBBY','EXTERNAL_LOBBY','HOME_PAGE'}"
					    value="menuData.contentType" theme="myTheme" applyscript="true"/>
					</div>
					</div>
					<div class="clearFRM"></div>
					<div class="FormMainBox">
						 <div class="labelDiv">
							<label>Content Name:</label>
					 </div>
					 <div class="InputDiv">
						<ss:select headerKey="-1"
						headerValue="-- Please Select --" cssClass="select1" cssStyle="font-size:14px"
						id="contentName" list='{}' theme="myTheme" applyscript="true"/>
						<s:hidden id="content" value="%{menuData.contentName}"></s:hidden>
					</div>
					</div>
					<div  style="display:none;">
						<div class="clearFRM"></div>
								<div class="FormMainBox">
									<div class="labelDiv">
										<label>
											Highlight Option:
										</label>
									</div>
									<div class="InputDiv">
									<s:radio  list="#{'ACTIVE':'Y','INACTIVE':'N'}"
										 name="highLightOpt" id="highLightOpt" value="%{menuData.highLightOpt}"
										cssClass="inpSpan" theme="simple"></s:radio>
									</div>
								</div>
							
				</div>	
                 <s:set var="count2" value="0" />
				<div id="sortable2">
					<s:iterator value="#request.menuData.menuBeanList"
						status="subMenuList">
						<div  class="FormSection UIaccordian2" id="sub_<s:property value="#subMenuList.index"/>">
							<div class="accordianHeader greyStrip handle h2" style="width: 860px" id='h2_<s:property value="#subMenuList.index"/>'>
								<h4>
									Level2 Detail: <s:property value="%{menuDisplayName}"/>
								</h4>
							</div>
							<div class="accordian_content" id='accordian_content_<s:property value="#subMenuList.index"/>' style="width: 820px;margin-top: -5px">
								<div class="FormMainBox">
									<div class="labelDiv">
										<label>
											Display Name:
										</label>
									</div>
									<div class="InputDiv">
									<s:hidden id="menuId_%{#subMenuList.index}" value="%{menuId}"></s:hidden>
										<ss:textfield id="displayName_%{#subMenuList.index}"
											theme="myTheme" applyscript="true" value="%{menuDisplayName}"></ss:textfield>
									</div>
								</div>
                                <div class="clearFRM"></div>
								
								<div class="FormMainBox">
					                <div class="labelDiv">
							         <label> Show On Page:</label>
					                </div>
					                <div class="InputDiv">
						              <s:radio  list="#{'ACTIVE':'Y','INACTIVE':'N'}"
						                        value="%{status}" name="status_%{#subMenuList.index}"
						                        cssClass="inpSpan" theme="simple" onchange="checkStatus(this.name)"></s:radio>
					                </div>
					            </div>
					            <div class="clearFRM"></div>
								<div class="FormMainBox">
									<div class="labelDiv">
										<label>
											Content Type:
										</label>
									</div>
									<div class="InputDiv">
										<ss:select applyscript="true"
											headerKey="-1" onchange="getContentNameList(this.id)"
											headerValue="-- Please Select --" cssClass="select1"
											id="contentType_%{#subMenuList.index}" cssStyle="font-size:14px"
											list="{'STATIC_PAGE','DYNAMIC','INTERNAL_LOBBY','EXTERNAL_LOBBY','HOME_PAGE'}"
											value="%{contentType}" theme="myTheme" />
									</div>
								</div>
								<div class="clearFRM"></div>
								<div class="FormMainBox">
									<div class="labelDiv">
										<label>
											Content Name:
										</label>
									</div>
									<div class="InputDiv">
										<ss:select applyscript="true"
											headerKey="-1" headerValue="-- Please Select --" cssStyle="font-size:14px"
											cssClass="select1" id="contentName_%{#subMenuList.index}" list='{}'
											theme="myTheme" />
										<s:hidden id="content_%{#subMenuList.index}" value="%{contentName}"></s:hidden>
									</div>
								</div>
								
								<div class="clearFRM"></div>
								<div class="FormMainBox">
									<div class="labelDiv">
										<label>
											Highlight Option:
										</label>
									</div>
									<div class="InputDiv">
										<s:radio  list="#{'ACTIVE':'Y','INACTIVE':'N'}"
						                        value="INACTIVE" name="highLightOpt_%{#subMenuList.index}" value="%{highLightOpt}"
						                        cssClass="inpSpan" theme="simple"></s:radio>
									</div>
								</div>
							
							<div id="sortable3_<s:property value="#subMenuList.index"/>">
							<s:iterator value="menuBeanList"
						status="menuList">
						
						<div style="width: 95%;" class="FormSection UIaccordian3" id="level3_<s:property value="#subMenuList.index"/>_<s:property value="#menuList.index"/>">
							<div class="accordianHeader greyStrip handle h3" id='h3_<s:property value="#subMenuList.index"/>_<s:property value="#menuList.index"/>' style="width: 775px">
								<h4>
									Level3 Detail: <s:property value="%{menuDisplayName}"/>
								</h4>
							</div>
							<div  class="accordian_content" id='accordian_content_<s:property value="#subMenuList.index"/>_<s:property value="#menuList.index"/>' style="width: 745px;margin-top: -5px">
								<div class="FormMainBox">
									<div class="labelDiv">
										<label>
											Display Name:
										</label>
									</div>
									<div class="InputDiv">
									<s:hidden value="%{menuId}" id="menuId_%{#subMenuList.index}_%{#menuList.index}"></s:hidden>
										<s:textfield id="displayName_%{#subMenuList.index}_%{#menuList.index}"
											theme="myTheme" applyscript="true" value="%{menuDisplayName}"></s:textfield>
									</div>
								</div>
								<div class="clearFRM"></div>

								
								<div class="FormMainBox">
					                <div class="labelDiv">
							         <label> Show On Page:</label>
					                </div>
					                <div class="InputDiv">
						              <s:radio  list="#{'ACTIVE':'Y','INACTIVE':'N'}"
						                        value="%{status}" name="status_%{#subMenuList.index}_%{#menuList.index}"
						                        cssClass="inpSpan" theme="simple" onchange="checkStatus(this.name)"></s:radio>
					                </div>
					            </div>
					            <div class="clearFRM"></div>
								<div class="FormMainBox">
									<div class="labelDiv">
										<label>
											Content Type:
										</label>
									</div>
									<div class="InputDiv">
										<ss:select applyscript="true"
											headerKey="-1" onchange="getContentNameList(this.id)" cssStyle="font-size:14px"
											headerValue="-- Please Select --" cssClass="select1"
											id="contentType_%{#subMenuList.index}_%{#menuList.index}"
											list="{'STATIC_PAGE','DYNAMIC','INTERNAL_LOBBY','EXTERNAL_LOBBY','HOME_PAGE'}"
										    value="%{contentType}" theme="myTheme" />
									</div>
								</div>
								<div class="clearFRM"></div>
								<div class="FormMainBox">
									<div class="labelDiv">
										<label>
											Content Name:
										</label>
									</div>
									<div class="InputDiv">
										<ss:select applyscript="true"
											headerKey="-1" headerValue="-- Please Select --" cssStyle="font-size:14px"
											cssClass="select1" id="contentName_%{#subMenuList.index}_%{#menuList.index}" list='{}'
											theme="myTheme" />
									    <s:hidden id="content_%{#subMenuList.index}_%{#menuList.index}" value="%{contentName}"></s:hidden>
									</div>
								</div>
								<div class="clearFRM"></div>
								<div class="FormMainBox">
									<div class="labelDiv">
										<label>
											Highlight Option:
										</label>
									</div>
									<div class="InputDiv">
									  <s:radio  list="#{'ACTIVE':'Y','INACTIVE':'N'}"
						                        value="%{highLightOpt}" name="highLightOpt_%{#subMenuList.index}_%{#menuList.index}"
						                        cssClass="inpSpan" theme="simple"></s:radio>
									</div>
								</div>				
								
							</div>
						</div>
					</s:iterator>
					<div id="level3Content_<s:property value="#subMenuList.index"/>"></div>
					<s:set name="count2" value="%{#count2+1}"/>
						</div>
					    	<div class="box_footer" align="right" style="background: #f2f2f2; border: none;font-size: 11px">
								<input id="addSubMenu_<s:property value="#subMenuList.index"/>" class="button" type="button" value="Add Level3" onclick="addLevel3ForEdit(this.id)" />
						    </div>

						</div>	
							
					</div>

					</s:iterator>
					<div id="level2Content"></div>
				</div>
                 
               <s:hidden name="count2" id="count2" value="%{#count2}"></s:hidden>
               
               <div class="box_footer" align="right">
					<input id="addSubMenu2" class="button" type="button" style="font-size: 11px"
						value="Add Level2" onclick="return addLevel2()"/>
				</div>
				</div>
				
			</div>
			
			  
			 <div class="box_footer" align="right">
			<input id="preview" class="button" type="button"
						value="Preview" onclick="previewData()"/>
				<s:submit value="Submit" align="right" theme="simple" onclick="return prepareData()" ></s:submit>
			</div>
	</body>
</html>
