package com.blackpoints.struts.action;

import com.blackpoints.classes.TempPOI;
import com.blackpoints.dao.TempPOIDAO;
import com.blackpoints.struts.form.TempPOIForm;
import java.util.List;
import java.util.Locale;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts.Globals;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.util.MessageResources;

/**
 *
 * @author hka
 */
public class GetAllTempPOIsAction extends org.apache.struts.action.Action {
    
    /**
     * This is the action called from the Struts framework.
     * @param mapping The ActionMapping used to select this instance.
     * @param form The optional ActionForm bean for this request.
     * @param request The HTTP Request we are processing.
     * @param response The HTTP Response we are processing.
     * @throws java.lang.Exception
     * @return
     */
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        TempPOIForm tempPOIForm = (TempPOIForm) form;
        List<TempPOI> list = new TempPOIDAO().getAllTempPOIs();
        tempPOIForm.setTempPOIList(list);
        HttpSession session = request.getSession(true);
        MessageResources mr = MessageResources.getMessageResources("com.blackpoints.struts.ApplicationResource");
        Locale locale = (Locale) session.getAttribute(Globals.LOCALE_KEY);
        for (TempPOI tempPOI : list) {
            tempPOI.setRatingName(mr.getMessage(locale, "poi.rating." + tempPOI.getRating()));
        }
        return mapping.findForward("getAllTempPOIsOK");
    }
}
