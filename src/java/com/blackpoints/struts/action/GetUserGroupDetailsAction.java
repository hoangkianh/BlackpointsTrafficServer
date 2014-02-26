package com.blackpoints.struts.action;

import com.blackpoints.classes.UserGroup;
import com.blackpoints.dao.UserGroupDAO;
import com.blackpoints.struts.form.UserGroupForm;
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
public class GetUserGroupDetailsAction extends org.apache.struts.action.Action {

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

        try {
            id = Integer.parseInt(request.getParameter("id"));
            UserGroup ug = new UserGroupDAO().getUserGroupByID(id);

            if (ug == null) {
                return mapping.findForward("getUserGroupDetailsFailure");
            }
            
            UserGroupForm userGroupForm = (UserGroupForm) form;
            BeanUtils.copyProperties(userGroupForm, ug);
        } catch (Exception e) {
            return mapping.findForward("getUserGroupDetailsFailure");
        }
        return mapping.findForward("getUserGroupDetailsSuccess");
    }
}
