package com.stpl.pms.struts.common;

import javax.servlet.FilterConfig;
import javax.servlet.ServletException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter;

public class FilterDispatcher extends StrutsPrepareAndExecuteFilter {
	private static final Log logger = LogFactory.getLog(FilterDispatcher.class);
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		super.init(filterConfig);
		logger.info("------Weaver FilterDispatcher Start--------");
		
		logger.info("------Weaver FilterDispatcher End--------");
	}

}
