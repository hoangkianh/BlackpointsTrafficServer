package com.blackpoints.struts.form;

import com.blackpoints.dao.POIDAO;
import com.blackpoints.dao.UserDAO;

/**
 *
 * @author HKA
 */
public class StatisticForm extends org.apache.struts.action.ActionForm {
    public int getCountPOI () {
        return new POIDAO().countPOI();
    }
    public int getCountUser () {
        return new UserDAO().countUser();
    }
}
