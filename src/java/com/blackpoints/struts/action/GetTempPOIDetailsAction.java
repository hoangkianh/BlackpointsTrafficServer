package com.blackpoints.struts.action;

import com.blackpoints.classes.TempPOI;
import com.blackpoints.dao.TempPOIDAO;
import com.blackpoints.struts.form.TempPOIForm;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author HKA
 */
public class GetTempPOIDetailsAction extends org.apache.struts.action.Action {

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
                return mapping.findForward("getTempPOIDetailsFailure");
            }
        } else {
            return mapping.findForward("getTempPOIDetailsFailure");
        }
        TempPOIForm tempPOIForm = (TempPOIForm) form;
        TempPOI tempPOI = new TempPOIDAO().getTempPOIByID(id);
        
        if (tempPOI != null) {
            BeanUtils.copyProperties(tempPOIForm, tempPOI);
        }
        return mapping.findForward("getTempPOIDetailsSuccess");
    }
}
