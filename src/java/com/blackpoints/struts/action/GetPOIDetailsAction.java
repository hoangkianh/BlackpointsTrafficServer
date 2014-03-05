package com.blackpoints.struts.action;

import com.blackpoints.classes.GeoLocation;
import com.blackpoints.classes.POI;
import com.blackpoints.dao.CategoryDAO;
import com.blackpoints.dao.CityDAO;
import com.blackpoints.dao.DistrictDAO;
import com.blackpoints.dao.POIDAO;
import com.blackpoints.struts.form.POIForm;
import com.blackpoints.utils.FileWrapper;
import com.blackpoints.utils.GeoUtil;
import java.io.File;
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
import org.apache.struts.upload.FormFile;
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
        int id = 0;
        if (request.getParameter("id") != null) {
            try {
                id = Integer.parseInt(request.getParameter("id"));
            } catch (NumberFormatException ex) {
                return mapping.findForward("getPOIDetailsFailure");
            }
        } else {
            return mapping.findForward("getPOIDetailsFailure");
        }
        POIForm poiForm = (POIForm) form;
        POIDAO dao = new POIDAO();
        POI poi = dao.getPOIByID(id);
        if (poi != null) {
            BeanUtils.copyProperties(poiForm, poi);
            String geometry = poiForm.getGeometry();
            List<GeoLocation> geoLocations = GeoUtil.toLatLng(geometry);
            GeoLocation location = geoLocations.get(0);
            
            poiForm.setLongitude(location.getLng());
            poiForm.setLatitude(location.getLat());
            poiForm.setCityName((new CityDAO().getCityByID(poiForm.getCity())).getName());
            poiForm.setDistrictName((new DistrictDAO().getDistrictByID(poiForm.getDistrict())).getName());
            poiForm.setCategoryName((new CategoryDAO().getCategoryById(poiForm.getCategoryID()).getName()));

            // set file path
            String filePath = getServlet().getServletContext().getRealPath("/") + poi.getImage();
            File file = new File(filePath);
            FormFile formFile = new FileWrapper(file);
            poiForm.setFile(formFile);
            
            HttpSession session = request.getSession(true);
            MessageResources mr = MessageResources.getMessageResources("com.blackpoints.struts.ApplicationResource");
            Locale locale = (Locale) session.getAttribute(Globals.LOCALE_KEY);
            poiForm.setRatingName(mr.getMessage(locale, "poi.rating." + poiForm.getRating()));
            List<POI> allPOIsInDistrict = dao.getAllPOIsInDistrict(poiForm.getCity(), poiForm.getDistrict());

            for (POI p : allPOIsInDistrict) {
                if (p.getId() == poiForm.getId()) {
                    allPOIsInDistrict.remove(p);
                    break;
                }
            }

            poiForm.setPoiListInDistrict(allPOIsInDistrict);
        } else {
            return mapping.findForward("getPOIDetailsFailure");
        }

        return mapping.findForward("getPOIDetailsSuccess");
    }
}
