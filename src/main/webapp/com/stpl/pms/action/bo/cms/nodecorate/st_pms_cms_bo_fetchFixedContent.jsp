<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ss" uri="/extended-struts2-tags" %>
<%@include file="/com/stpl/pms/action/bo/common/baseUrl.jsp" %>
<%
String path = request.getContextPath();
String basePath = (String)request.getAttribute("basePathURL") ;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Edit Static Content</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <SCRIPT type="text/javascript">
	 $(document).ready(function() {
	    var css;
	    if($("#device").val()=="PC"){
	       css = $( "#css" ).val()+"css/default/pc/LR/common.css"; 
	    }else{
	    	css = $( "#css" ).val()+"css/default/mobile/LR/jquery.mobile-1.4.0.css";
	    }
	     $("#css").val(css);
		 tinyMCE.init({
         mode : "specific_textareas",
         editor_deselector : "mceNoEditor",
     	 content_css : css,
       	 theme : "advanced",
         height : "320",
         convert_urls : false,
         forced_root_block : false,
         
       // plugins : "autolink,lists,spellchecker,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",
        // Theme options
        theme_advanced_buttons1 : "addVariable,anchor,addGraphics,widget,placeHolder,|,save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,styleselect,fontselect",
        theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor,|,fontsizeselect",
        //theme_advanced_buttons3 : "hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen,|,addVariable,addGraphics,anchor",
        //theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,spellchecker,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,blockquote,pagebreak,|,insertfile,insertimage,|,addVariable,addGraphics,anchor",
        
        //save_callback : "moveContents",
        submit_patch : false,
        init_instance_callback : "addNewEditor",
        schema:"html5",
		setup : function(ed) {
        // Add a custom button
       editor = ed;
        
        ed.addButton('addVariable', {
            title : 'Insert Variables',
            image : 'images/var.png',
            onclick : function() {
				// Add you own code to execute something on click
				ed.focus();
				editor = ed;
				$("#TinyMCEwidgetLink").attr("href","com/stpl/pms/action/bo/cms/st_pms_page_insertVariables.action?domainId="+$('#domainId').val()+"&pageType="+$('#pageType').val());
				$("#TinyMCEwidgetLink").click();
                //ed.selection.setContent();
            }
        });  
        ed.addButton('addGraphics', {
            title : 'Insert Graphics',
            image : 'images/img-icon.png',
            onclick : function() {
				// Add you own code to execute something on click
				ed.focus();
				editor = ed;
				$("#TinyMCEwidgetLink").attr("href","com/stpl/pms/action/bo/cms/st_pms_page_insertGraphics.action?domainId="+$("#domainId").val()+"&pageType="+$('#pageType').val()+"&device="+$('#device').val());
				$("#TinyMCEwidgetLink").click();
                //ed.selection.setContent();
            }
        }); 
        ed.addButton('anchor', {
            title : 'Insert Links',
            //image : 'images/link.png',
            onclick : function() {
				// Add you own code to execute something on click
				ed.focus();
				editor = ed;
				$('#TinyMCEwidgetLink').attr("href","com/stpl/pms/action/bo/cms/st_pms_page_insertLinks.action?aliasId="+$("#aliasId").val()+"&language="+$("#language").val()+"&device="+$('#device').val());
				$('#TinyMCEwidgetLink').click();
                //ed.selection.setContent();
            }
        });
        ed.addButton('placeHolder', {
            title : 'Insert Place Holder',
            image : 'images/place-holder.png',
            onclick : function() {
				// Add you own code to execute something on click
				ed.focus();
				editor = ed;
				$("#TinyMCEwidgetLink").attr("href","com/stpl/pms/action/bo/cms/st_pms_page_insertPlaceHolder.action?domainId="+$("#domainId").val()+"&language="+$("#language").val());
				$("#TinyMCEwidgetLink").click();
                //ed.selection.setContent();
            }
        });
        
       ed.addButton('widget', {
            title : 'Insert a widget',
            image : 'images/widget-icon.png',
            onclick : function() {
				// Add you own code to execute something on click
				ed.focus();
				editor = ed;
				$("#TinyMCEwidgetLink").attr("href","com/stpl/pms/action/bo/cms/st_pms_page_insertWidget.action?domainId="+$("#domainId").val()+"&aliasId="+$("#aliasId").val()+"&device="+$("#device").val());
				$("#TinyMCEwidgetLink").click();
                //ed.selection.setContent();
            }
        });
        
        } 
});
	
	
	$('a[rel*="facebox"]').click(function(event){
	
	if($("#domainId").val() == "-1"){
		alert("No Domain Selected !");
		event.stopImmediatePropagation();
		}
	
	});
	
	 $('a[rel*="facebox"]').facebox({
	 		
			closeImage : '<%=request.getContextPath()%>/images/closelabel.png',
  	 		});
  	 
	  
		 
	  
	});
	
</SCRIPT>
</head>
<body>
    <s:hidden id="jsonObjVariableId" name="jsonObjVariableId" ></s:hidden>
    <s:hidden id="variablesBeans" value="%{variablesBeanStr}"></s:hidden>
    <s:hidden id="css" value="%{cssPath}"></s:hidden>
    <div class="clearFRM"></div>	
                      <div class="FormMainBox newbxdv" style="height: 360px;">
                            <div class="labelDiv">
								<label>
									Content:
								</label>
							</div>
							<div class="InputDiv">
							<div>
								<a id="TinyMCEwidgetLink" style="display: none;" rel="facebox"></a>
								<!--<input type="button" style="display: none;" id="previewPage" value="Preview Page" onclick="getPreview('pageHTML')"/>-->
								</div>
							<div>
							
								<ss:textarea value="%{content}" name="content" id="pageHTML0" cols="93" cssStyle="width:98%" theme="myTheme"
															rows="10"></ss:textarea></div>
							</div>
					</div>
		<div id="tempDIv" style="display: none;"></div>	
		<div id="phAttr"></div>		
</body>
</html>