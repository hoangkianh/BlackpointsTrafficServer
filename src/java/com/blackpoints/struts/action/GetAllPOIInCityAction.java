package com.blackpoints.struts.action;

import com.blackpoints.classes.POI;
import com.blackpoints.dao.POIDAO;
import com.blackpoints.struts.form.POIForm;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author HKA
 */
public class GetAllPOIInCityAction extends org.apache.struts.action.Action {

    /**
     * This is the action called from the Struts framework.
     *
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
        POIForm poif = (POIForm) form;
        
        int city = 0;
        try {
            city = Integer.parseInt(request.getParameter("id"));
            List<POI> allPOIsInCity = new POIDAO().getAllPOIsInCity(city);
            poif.setPoiList(allPOIsInCity);
            poif.setCity(city);
        } catch (Exception e) {
            return mapping.findForward("getAllPOIInCityFailure");
        }

        return mapping.findForward("getAllPOIInCitySuccess");
    }
}
