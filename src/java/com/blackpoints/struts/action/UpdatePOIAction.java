package com.blackpoints.struts.action;

import com.blackpoints.classes.POI;
import com.blackpoints.dao.POIDAO;
import com.blackpoints.struts.form.POIForm;
import com.blackpoints.utils.CookieUtils;
import java.io.PrintWriter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author HKA
 */
public class UpdatePOIAction extends org.apache.struts.action.Action {

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
        POIForm poiForm = (POIForm) form;
        POI p = new POI();
        String kq = "success";
        
        // set geometry
        poiForm.setGeometry("POINT(" + poiForm.getLongitude() + " " + poiForm.getLatitude() + ")");
        
        // set update by user
        HttpSession session = request.getSession(true);
        String str = (String) session.getAttribute("blackpoints");
        if (str == null) {
            Cookie c = CookieUtils.getCookieByName(request, "blackpoints");
            str = c.getValue();
        }

        try {
            poiForm.setUpdatedByUserID(Integer.parseInt(str.split("~")[0]));
        } catch (Exception e) {
            kq = "failure";
        }
        
        BeanUtils.copyProperties(p, poiForm);        
        response.setContentType("text/text;charset=utf-8");
        response.setHeader("cache-control", "no-cache");
        PrintWriter out = response.getWriter();
        
        if (!new POIDAO().updatePOI(p)) {
            kq = "failure";
        }
        
        out.print(kq);
        out.flush();
        
        return null;
    }
}
