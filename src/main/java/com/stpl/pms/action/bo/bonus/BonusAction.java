package com.stpl.pms.action.bo.bonus;

//import java.lang.reflect.Type;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpSession;
//
//import org.apache.log4j.Logger;
//
//import com.google.gson.Gson;
//import com.google.gson.reflect.TypeToken;
//import com.opensymphony.xwork2.ActionContext;
//import com.stpl.pms.controller.bonus.BonusController;
//import com.stpl.pms.controller.commonMethods.CommonMethodController;
//import com.stpl.pms.exception.PMSException;
//import com.stpl.pms.javabeans.BonusActivityBean;
//import com.stpl.pms.javabeans.BonusMasterBean;
//import com.stpl.pms.javabeans.BonusSearchBean;
import com.stpl.pms.struts.common.BaseActionSupport;
//import com.stpl.pms.utility.UserValidation;
//import com.stpl.pms.utility.Utility;

public class BonusAction extends BaseActionSupport {
}
/*	private static final long serialVersionUID = 1L; 
	private static final Logger logger = Logger.getLogger(BonusAction.class);

	private Map<String, List<BonusActivityBean>> activityMap;
	private Map<String, List<BonusActivityBean>> criteriaMap;
	private String activityStr;
	private String criteriaStr;
	private BonusMasterBean bonusMaster;
	private Map<Long, String> playerMap;
	private List<BonusMasterBean> bonusList;
	private String bonusStr;
	private List<BonusSearchBean> bonusSearchList;
	private Long[] playerIdArr;
	private long[] bonusId;
	private String plrList;
	private double amount;
	private String relatedTo;
	private String ifDuplicate;
	private String bonusOrderStr;
	private boolean specificSearch;
	private long playerId;
	private String promoCode;
	private String activityName;
	private List<Long> selectedBonusIdList;
	private Integer activityId;
	private String aliasName;

	public String searchBonusMenu() {
		logger.info("--Search Bonus Menu--");
		BonusController controller = BonusController.getInstance();
		Utility utility=new Utility();
		try {
			activityMap = controller.fetchBonusActivities();
			activityStr=utility.convertJSON(activityMap);
			criteriaMap = controller.fetchBonusCriteria();
			criteriaStr=utility.convertJSON(criteriaMap);
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception e) {
			e.printStackTrace();
			addActionError("Some Internal Error!");
			return "exception";
		}
		return SUCCESS;
	}

	public String searchBonusSearch() {
		logger.info("--Search Bonus Search Start--");
		logger.info("--Bonus Bean--" + bonusMaster);
		logger.info("--Is Specific Search--" + specificSearch);
		BonusController controller = BonusController.getInstance();
		try {
			bonusSearchList = controller.searchBonus(bonusMaster,specificSearch);
			activityId = bonusMaster.getActivityId();
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		logger.info("--Search Bonus Search End--");
		return SUCCESS;
	}

	public String createBonusMenu() {
		logger.info("--Create Bonus Menu--");
		BonusController controller = BonusController.getInstance();
		Utility utility=new Utility();
		try {
			activityStr =utility.convertJSON( controller.fetchBonusActivities());
			criteriaStr = utility.convertJSON(controller.fetchBonusCriteria());
			if (bonusMaster != null && bonusMaster.getBonusId() > 0) {
				bonusMaster = controller.fetchBonusEdit(bonusMaster
						.getBonusId());
				if (bonusMaster.getDomainId()>0)
					domainName = CommonMethodController.getInstance().getDmProperty(Short.valueOf(bonusMaster.getDomainId()), "domainName");
				if (bonusMaster.getAliasId()>0)
					aliasName = CommonMethodController.getInstance().getDmAliasProperty(Short.valueOf(bonusMaster.getAliasId()), "aliasName");
			} else {
				bonusMaster = new BonusMasterBean();
			}
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}

	public String checkDuplicateBonus() {
		logger.info("--In Check Duplicate New Bonus--");
	//	logger.info("--Bonus Info--" + bonusMaster);
		BonusController controller = BonusController.getInstance();
		HttpSession session = request.getSession();
		try {
			if (userInfoBean != null) {
				bonusSearchList = controller.checkDuplicateBonus(bonusMaster,
						userInfoBean);
				if (bonusSearchList == null) {
					return "BONUS_CREATED";
				}
				session.setAttribute("tempBonus", bonusMaster);
			} else {
				return "SESSION_TIME_OUT";
			}
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}
	
	public String updateBonusOrder() {
		logger.info("--Update Order Bonus--");
		logger.info("--if Duplicate--" + ifDuplicate);
		logger.info("--bonusOrderStr--" + bonusOrderStr);
		Map<String, String> boOrder = null;
		Type type = new TypeToken<Map<String, String>>() {
		}.getType();
		boOrder = new Gson().fromJson(bonusOrderStr, type);

		BonusController controller = BonusController.getInstance();
		HttpSession session = request.getSession();
		try {
			if (userInfoBean != null) {
				bonusMaster = (BonusMasterBean) session
						.getAttribute("tempBonus");
				controller.updateBonusOrder(bonusMaster, ifDuplicate, boOrder,
						userInfoBean);
			} else {
				return "SESSION_TIME_OUT";
			}
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		} 
		finally {
			session.removeAttribute("tempBonus");
		}
		return SUCCESS;
	}

	public String createBonusSave() {
		logger.info("--Save New Bonus--");
		logger.info("--Bonus Info--" + bonusMaster);
		BonusController controller = BonusController.getInstance();
		try {
			if (userInfoBean != null) {
				controller.saveNewBonus(bonusMaster, userInfoBean);
			} else {
				return "SESSION_TIME_OUT";
			}
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}

	public String freeCashBonus() {
		logger.info("--In Free Cash Bonus--");
		BonusController controller = BonusController.getInstance();
		try {
			bonusList = controller.fetchAvailableFreeBonus(domainId,aliasId);
			bonusStr=new Utility().convertJSON(bonusList);
			if (!(plrList == null || "".equals(plrList))) {
				Type type = new TypeToken<Map<Long, String>>() {
				}.getType();
				playerMap = new Gson().fromJson(plrList, type);
				playerIdArr = playerMap.keySet().toArray(new Long[0]);
			}
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return "exception";
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}

	public String giveFreeCash() {
		BonusController controller = BonusController.getInstance();
		try {
			controller.giveFreeCash(playerIdArr, amount, bonusId);
		} catch (PMSException e) {
			e.printStackTrace();
			addActionError(e.getErrorMessage());
			return ERROR;
		}catch (Exception be) {
			addActionError("Some internal error.");
			be.printStackTrace();
			return "exception";
		}
		return SUCCESS;
	}

	@Override
	public void validate() {
		String actionName = (String) ActionContext.getContext().getContextMap()
				.get(ActionContext.ACTION_NAME);
		try {
			if ("bo_promo_create_bonus_checkDuplicate".equals(actionName)) {
				if (bonusMaster != null) {
					if (bonusMaster.getBonusDispCode() == null) {
						addFieldError("bonusDispCode",
								"Bonus name is required.");
					} else if (!UserValidation.isAlphanumeric(bonusMaster
							.getBonusDispCode(), true)) {
						addFieldError("bonusDispCode",
								"Only alphanumeric characters allowed.");
					}

					if (bonusMaster.getAvailabilityType() == null) {
						addFieldError("availabilityType",
								"Availability type is required.");
					} else if ("GEN_EVENT".equals(bonusMaster
							.getAvailabilityType())) {
						if (bonusMaster.getAvailableFromDate() == null) {
							addFieldError("availableFromDate",
									"From date is required.");
						} else if (bonusMaster.getAvailableToDate() == null) {
							addFieldError("availableToDate",
									"To date is required.");
						} else if (bonusMaster.getAvailableFromDate().after(
								bonusMaster.getAvailableToDate())) {
							addFieldError("availableFromDate",
									"From date should be before to date.");
						}
					} else if ("PLR_SPECIFIC_EVENT".equals(bonusMaster
							.getAvailabilityType())) {
						if (bonusMaster.getAvailableBeforeDays() == null) {
							addFieldError("availableBeforeDays",
									"Available before days is required.");
						}
						if (bonusMaster.getAvailableAfterDays() == null) {
							addFieldError("availableAfterDays",
									"Available before days is required.");
						}
					}

					if (bonusMaster.getActivityId() == null
							|| bonusMaster.getActivityId() == -1) {
						addFieldError("activityId", "Activity is required.");
					}

					if (bonusMaster.getDomainId() == -1) {
						addFieldError("domainId", "Domain is required");
					}

					if (bonusMaster.getBonusValue() <= 0.0) {
						addFieldError("bonusValue",
								"Bonus value can't be less than or equal to zero.");
					}
					if (bonusMaster.getBonusValueType() == null) {
						addFieldError("bonusValueType",
								"Bonus value type is required");
					} else if ("FIXED".equals(bonusMaster.getBonusValueType())) {
						bonusMaster.setMaxBonusValue(0.0);
					} else if (bonusMaster.getBonusValue() > 0
							&& bonusMaster.getMaxBonusValue() > 0
							&& bonusMaster.getBonusValue() > bonusMaster
									.getMaxBonusValue()) {
						addFieldError("bonusValue",
								"Bonus value can't be greater than max bonus value.");
					}

					if (bonusMaster.getPlayerUsageCount() != null
							&& bonusMaster.getMaxUsageCount() != null
							&& bonusMaster.getPlayerUsageCount() > bonusMaster
									.getMaxUsageCount()) {
						addFieldError("playerUsageCount",
								"Player usage count can't be greater than max usage count.");
					}

					if (bonusMaster.getExpiryAfterAcceptType() == null) {
						addFieldError("expiryAfterAcceptType",
								"Expiry after accept type is required.");
					} else if ("DATE".equals(bonusMaster
							.getExpiryAfterAcceptType())) {
						if (bonusMaster.getExpiryAfterAcceptDate() == null) {
							addFieldError("expiryAfterAcceptDate",
									"Expiry after accept date is required.");
						}
					} else if ("DAYS".equals(bonusMaster
							.getExpiryAfterAcceptType())) {
						if (bonusMaster.getExpiryAfterAcceptDays() == null) {
							addFieldError("expiryAfterAcceptDays",
									"Expiry after accept days is required.");

						}
					}

					if (bonusMaster.getDeliveryMode() != null) {
						if ("COUPON_SAME".equals(bonusMaster.getDeliveryMode())) {
							if (bonusMaster.getPromoCode() == null) {
								addFieldError("promoCode",
										"Promo code is required.");
							}
						}
					}

				}
				if (getFieldErrors().size() > 0) {
					BonusController controller = BonusController.getInstance();
					activityMap = controller.fetchBonusActivities();
					criteriaMap = controller.fetchBonusCriteria();
					domainMap = CommonMethodController.getInstance()
							.getDomainIdMap();
				}
			}
		} catch (PMSException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String inactivateBonus() {
			BonusController controller = BonusController.getInstance();
			try {
			controller.inactivateBonus(selectedBonusIdList,userInfoBean.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String hideBonus() {
		BonusController controller = BonusController.getInstance();
		try {
		controller.hideBonus(selectedBonusIdList,userInfoBean.getUserId());
	} catch (Exception e) {
		e.printStackTrace();
	}
	return SUCCESS;
}
	
	public void setActivityMap(Map<String, List<BonusActivityBean>> activityMap) {
		this.activityMap = activityMap;
	}

	public Map<String, List<BonusActivityBean>> getActivityMap() {
		return activityMap;
	}

	public void setBonusMaster(BonusMasterBean bonusMaster) {
		this.bonusMaster = bonusMaster;
	}

	public BonusMasterBean getBonusMaster() {
		return bonusMaster;
	}

	public void setCriteriaMap(Map<String, List<BonusActivityBean>> criteriaMap) {
		this.criteriaMap = criteriaMap;
	}

	public Map<String, List<BonusActivityBean>> getCriteriaMap() {
		return criteriaMap;
	}

	public void setPlayerMap(Map<Long, String> playerMap) {
		this.playerMap = playerMap;
	}

	public Map<Long, String> getPlayerMap() {
		return playerMap;
	}

	public Long[] getPlayerIdArr() {
		return playerIdArr;
	}

	public void setPlayerIdArr(Long[] playerIdArr) {
		this.playerIdArr = playerIdArr;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public void setBonusList(List<BonusMasterBean> bonusList) {
		this.bonusList = bonusList;
	}

	public List<BonusMasterBean> getBonusList() {
		return bonusList;
	}
	
	public String getBonusStr() {
		return bonusStr;
	}

	public void setBonusStr(String bonusStr) {
		this.bonusStr = bonusStr;
	}

	public void setPlrList(String plrList) {
		this.plrList = plrList;
	}

	public String getPlrList() {
		return plrList;
	}

	public void setBonusSearchList(List<BonusSearchBean> bonusSearchList) {
		this.bonusSearchList = bonusSearchList;
	}

	public List<BonusSearchBean> getBonusSearchList() {
		return bonusSearchList;
	}

	public void setRelatedTo(String relatedTo) {
		this.relatedTo = relatedTo;
	}

	public String getRelatedTo() {
		return relatedTo;
	}

	public void setIfDuplicate(String ifDuplicate) {
		this.ifDuplicate = ifDuplicate;
	}

	public String getIfDuplicate() {
		return ifDuplicate;
	}

	public void setBonusOrderStr(String bonusOrderStr) {
		this.bonusOrderStr = bonusOrderStr;
	}

	public String getBonusOrderStr() {
		return bonusOrderStr;
	}

	public void setBonusId(long[] bonusId) {
		this.bonusId = bonusId;
	}

	public long[] getBonusId() {
		return bonusId;
	}

	public void setSpecificSearch(boolean specificSearch) {
		this.specificSearch = specificSearch;
	}

	public boolean isSpecificSearch() {
		return specificSearch;
	}

	public void setPlayerId(long playerId) {
		this.playerId = playerId;
	}

	public long getPlayerId() {
		return playerId;
	}

	public void setPromoCode(String promoCode) {
		this.promoCode = promoCode;
	}

	public String getPromoCode() {
		return promoCode;
	}

	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}

	public String getActivityName() {
		return activityName;
	}

	public List<Long> getSelectedBonusIdList() {
		return selectedBonusIdList;
	}

	public void setSelectedBonusIdList(List<Long> selectedBonusIdList) {
		this.selectedBonusIdList = selectedBonusIdList;
	}

	public Integer getActivityId() {
		return activityId;
	}

	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
	}

	public String getAliasName() {
		return aliasName;
	}

	public void setAliasName(String aliasName) {
		this.aliasName = aliasName;
	}

	public String getActivityStr() {
		return activityStr;
	}

	public void setActivityStr(String activityStr) {
		this.activityStr = activityStr;
	}

	public String getCriteriaStr() {
		return criteriaStr;
	}

	public void setCriteriaStr(String criteriaStr) {
		this.criteriaStr = criteriaStr;
	}
	
	
	
	
}
*/