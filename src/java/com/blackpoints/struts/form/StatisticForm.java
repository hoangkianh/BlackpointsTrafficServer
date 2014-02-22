package com.blackpoints.struts.form;

import com.blackpoints.dao.POIDAO;
import com.blackpoints.dao.TempPOIDAO;
import com.blackpoints.dao.UserDAO;

/**
 *
 * @author HKA
 */
public class StatisticForm extends org.apache.struts.action.ActionForm {

    private POIDAO poiDAO;
    private TempPOIDAO tempPOIDAO;
    private UserDAO userDAO;
    
    public StatisticForm() {
        poiDAO = new POIDAO();
        userDAO = new UserDAO();
        tempPOIDAO = new TempPOIDAO();
    }
    public int getCountPOI () {
        return poiDAO.countPOI(false);
    }
    public int getCountNewPOI () {
        return poiDAO.countNewPOI(false);
    }
    public int getCountTempPOI() {
        return tempPOIDAO.countTempPOI();
    }
    public int getCountNewTempPOI () {
        return tempPOIDAO.countNewTempPOI();
    }
    public int getCountDeletedPOI () {
        return poiDAO.countPOI(true);
    }
    public int getCountNewDeletedPOI () {
        return poiDAO.countNewPOI(true);
    }
    public int getCountUser () {
        return userDAO.countUser();
    }
    public int getCountNewUser () {
        return userDAO.countNewUser();
    }
}
