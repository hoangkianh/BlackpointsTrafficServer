package com.blackpoints.struts.action;

import com.blackpoints.classes.User;
import com.blackpoints.dao.UserDAO;
import com.blackpoints.struts.form.UserForm;
import com.blackpoints.utils.CookieUtils;
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
public class GetUserDetailsAction extends org.apache.struts.action.Action {

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
        HttpSession session = request.getSession(true);
        String s = (String) session.getAttribute("blackpoints");
        if (s == null || s.isEmpty()) {
            Cookie cookie = CookieUtils.getCookieByName(request, "blackpoints");
            if (cookie == null) {
                return mapping.findForward("getUserDetailsFailure");
            }
            s = cookie.getValue();
        }
        try {
            id = Integer.parseInt(s.split("~")[0]);
            User u = new UserDAO().getUserByID(id);

            if (u == null) {
                return mapping.findForward("getUserDetailsFailure");
            }

            UserForm userForm = (UserForm) form;
            BeanUtils.copyProperties(userForm, u);
        } catch (Exception ex) {
            return mapping.findForward("getUserDetailsFailure");
        }
        return mapping.findForward("getUserDetailsSuccess");
    }
}
