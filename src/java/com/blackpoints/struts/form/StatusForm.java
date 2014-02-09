package com.blackpoints.struts.form;

import com.blackpoints.dao.POIDAO;
import com.blackpoints.dao.UserDAO;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

/**
 *
 * @author HKA
 */
public class StatusForm extends org.apache.struts.action.ActionForm {
    public int getCountPOI () {
        return new POIDAO().countPOI();
    }
    public int getCountUser () {
        return new UserDAO().countUser();
    }
}
