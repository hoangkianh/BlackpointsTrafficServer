package com.blackpoints.struts.action;

import com.blackpoints.classes.UserGroup;
import com.blackpoints.dao.UserGroupDAO;
import com.blackpoints.struts.form.UserGroupForm;
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
public class UpdateUserGroupAction extends org.apache.struts.action.Action {

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
        UserGroupForm userGroupForm = (UserGroupForm) form;
        UserGroupDAO ugDAO = new UserGroupDAO();
        PrintWriter out = response.getWriter();
        String kq = "success";

        try {
            int id = userGroupForm.getUserGroupID();
            UserGroup ug = ugDAO.getUserGroupByID(id);

            if (ug == null) {
                kq = "failure";
            }

            HttpSession session = request.getSession(true);
            String s = (String) session.getAttribute("blackpoints");
            if (s == null) {
                Cookie cookie = CookieUtils.getCookieByName(request, "blackpoints");
                if (cookie == null) {
                    kq = "error";
                } else {
                    s = cookie.getValue();
                }
            }
            BeanUtils.copyProperties(ug, userGroupForm);
            ug.setUpdatedByUserID(Integer.parseInt(s.split("~")[0]));

            if (!ugDAO.updateUserGroup(ug)) {
                kq = "failure";
            }
        } catch (Exception e) {
            kq = "failure";
        }

        out.print(kq);
        out.flush();

        return null;
    }
}
