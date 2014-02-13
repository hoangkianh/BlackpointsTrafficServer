package com.blackpoints.struts.action;

import com.blackpoints.classes.POI;
import com.blackpoints.dao.CategoryDAO;
import com.blackpoints.dao.CityDAO;
import com.blackpoints.dao.DistrictDAO;
import com.blackpoints.dao.POIDAO;
import com.blackpoints.struts.form.POIForm;
import java.util.List;
import java.util.Locale;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.Globals;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.util.MessageResources;

/**
 *
 * @author HKA
 */
public class GetPOIDetailsAction extends org.apache.struts.action.Action {

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
        int id = 0;
        if (request.getParameter("id") != null) {
            id = Integer.parseInt(request.getParameter("id"));
        } else {
            return mapping.findForward("getPOIDetailsFailure");
        }
        POIDAO dao = new POIDAO();
        POI poi = dao.getPOIByID(id);
        if (poi != null) {
            BeanUtils.copyProperties(poif, poi);
            poif.setCityName((new CityDAO().getCityByID(poif.getCity())).getName());
            poif.setDistrictName((new DistrictDAO().getDistrictByID(poif.getDistrict())).getName());
            poif.setCategoryName((new CategoryDAO().getCategoryById(poif.getCategoryID()).getName()));

            HttpSession session = request.getSession(true);
            MessageResources mr = MessageResources.getMessageResources("com.blackpoints.struts.ApplicationResource");
            Locale locale = (Locale) session.getAttribute(Globals.LOCALE_KEY);
            poif.setRatingName(mr.getMessage(locale, "poi.rating." + poif.getRating()));
            List<POI> allPOIsInDistrict = dao.getAllPOIsInDistrict(poif.getCity(), poif.getDistrict());

            for (POI p : allPOIsInDistrict) {
                if (p.getId() == poif.getId()) {
                    allPOIsInDistrict.remove(p);
                    break;
                }
            }

            poif.setPoiListInDistrict(allPOIsInDistrict);
        } else {
            return mapping.findForward("getPOIDetailsFailure");
        }

        return mapping.findForward("getPOIDetailsSuccess");
    }
}
