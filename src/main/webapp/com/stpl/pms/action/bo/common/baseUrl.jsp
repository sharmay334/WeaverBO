  <%      
  	String contextPath = request.getContextPath();
	String basePathURL = (request.getHeader("x-forwarded-proto") != null ? request.getHeader("x-forwarded-proto")
			: request.getScheme()) + "://" + request.getServerName() + ":8080"+ contextPath + "/";
	request.setAttribute("basePathURL", basePathURL);
   %>