<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>

<table width="500" cellpadding="2" cellspacing="1" border="0" align="center">
				<tr>
					<td><s:fielderror></s:fielderror>
						<s:select label="Domain Name" id="domainName" name="dmainName"
							cssClass="option" list="domainMasterList" listValue="%{domainName}" listKey="%{domainId+'+'+duplicateLogic}"
							onchange="selectDomain(this)" headerKey="-1" 
							headerValue="-- Please Select --" ></s:select>
					</td>
					
					<td><s:fielderror></s:fielderror>
						<s:select label="Section Name" id="sectionNameId" name="sectionName"
							cssClass="option" list="{'REGISTRATION','DEPOSIT','WITHDRAWAL'}"
							onchange="selectSection(this)" headerKey="-1" headerValue="-- Please Select --"
							disabled="true"></s:select>
					</td>
				</tr>
</table>