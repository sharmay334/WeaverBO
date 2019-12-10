<%@page import="com.stpl.pms.utility.Utility"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<c:set var = "client" scope = "session" value = "<%=Utility.getClientName()%>"/>

<jsp:include page="/com/stpl/pms/action/bo/common/client-specific/${client}/copyright-text.jsp"></jsp:include>
<div style="text-align: right;">Build version: <%=Utility.getBuildVersion() %></div>
