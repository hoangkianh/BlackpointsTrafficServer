package com.blackpoints.struts.action;

import com.blackpoints.classes.User;
import com.blackpoints.dao.UserDAO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author HKA
 */
public class ActivateAction extends org.apache.struts.action.Action {

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
        String email = request.getParameter("e");
        String salt = request.getParameter("s");
        User u = new User();
        u.setEmail(email);
        u.setSalt(salt);
        
        if (!new UserDAO().activateUser(u)) {
            return mapping.findForward("activateFailure");            
        }
        
        return mapping.findForward("activateSuccess");
    }
}
