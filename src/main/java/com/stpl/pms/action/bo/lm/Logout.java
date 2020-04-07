package com.stpl.pms.action.bo.lm;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.stpl.pms.controller.lm.BOLoginController;
import com.stpl.pms.struts.common.BaseActionSupport;

import net.sf.ehcache.Cache;


public class Logout extends BaseActionSupport {

	private static final Logger logger = Logger.getLogger(Logout.class);

	private static final long serialVersionUID = 1L;

	public String logOut() {
		logger.debug("I am in Logout");
		HttpSession session = null;
		session = getRequest().getSession();
		Cache cache = null;
		try {
//			UserInfoBean userInfoBean = CommonMethodController.getInstance().checkBoUserLogin(session.getId());
//			cache = CacheManager.getInstance().getCache("userLoginBean");
			/*String userCachedName = userInfoBean!= null?""+userInfoBean.getUserName()+"_"+userInfoBean.getUserId():null;
			if(cache.get(userCachedName)!= null){
				cache.remove(userCachedName);
			}*/
		} catch (Exception e) {
			e.printStackTrace();
		}
		new BOLoginController().logoutUser(session.getId());
		session.removeAttribute("ACTION_LIST");
		session.removeAttribute("PRIV_LIST");
		session.invalidate();
		logger.debug("Log out Successfully and Session is " + session);

		return SUCCESS;
	}
}