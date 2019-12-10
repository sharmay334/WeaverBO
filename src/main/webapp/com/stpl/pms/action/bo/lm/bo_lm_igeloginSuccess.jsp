<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  
  
  

  
  
  <title>IGE Bo</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="ige back office">
		<meta http-equiv="description" content="IGE backoffice from platform">
		
		<script type="text/javascript">
        function listener(event) {
            var iframe = document.getElementById("igeFrame");

            var regexp = new RegExp(event.origin, "i");
            if (regexp.test(iframe.src) == false) {
                return;
            }
            var height = /number|string/i.test(typeof event.data) == true ? parseInt(event.data) : 0;
            if (isNaN(height) == false && height > 0 && iframe) {
                iframe.height = event.data + "px";
            }
        }
        if (window.addEventListener) {
            window.addEventListener("message", listener, false);
        }
        else {
            window.attachEvent("onmessage", listener);
        }
 </script>
	</head>
	<body>
		<iframe name="igeFrame1" src='<s:property value="%{url}" />' id="igeFrame" scrolling="no" align="middle" frameborder="0" width="100%"></iframe>
	</body>
</html>
