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
 * @author hka
 */
public class GetAllPOIsAction extends org.apache.struts.action.Action {
    
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
        POIForm pf = (POIForm) form;
        List<POI> list = new POIDAO().getAllPOIs();
        pf.setPoiList(list);
        return mapping.findForward("getAllPOIsOK");
    }
}
