package com.blackpoints.struts.action;

import com.blackpoints.classes.User;
import com.blackpoints.dao.UserDAO;
import com.blackpoints.dao.UserGroupDAO;
import com.blackpoints.struts.form.UserForm;
import com.blackpoints.utils.CookieUtils;
import com.blackpoints.utils.MD5Hashing;
import java.io.PrintWriter;
import java.net.URLDecoder;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author HKA
 */
public class DeleteUserGroupAction extends org.apache.struts.action.Action {

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
        UserForm userForm = (UserForm) form;
        UserGroupDAO userGroupDAO = new UserGroupDAO();
        UserDAO userDAO = new UserDAO();

        PrintWriter out = response.getWriter();
        String kq = "success";

        // Get userID
        int id = 0;
        HttpSession session = request.getSession(true);
        String s = (String) session.getAttribute("blackpoints");
        if (s == null) {
            Cookie cookie = CookieUtils.getCookieByName(request, "blackpoints");
            if (cookie == null) {
                kq = "failure";
            } else {
                s = URLDecoder.decode(cookie.getValue(), "UTF-8");
            }
        }
        try {
            response.setContentType("text/text;charset=utf-8");
            response.setHeader("cache-control", "no-cache");

            id = Integer.parseInt(s.split("~")[0]);
            User u = userDAO.getUserByID(id);

            // compare password
            if (u == null) {
                kq = "failure";
            } else {
                if (!u.getPassword().equals(MD5Hashing.encryptPassword(userForm.getPassword()))) {
                    kq = "passwordNotCorrect";
                } else {
                    // count user in group
                    if (userGroupDAO.countUserInGroup(userForm.getGroupID()) > 0) {
                        kq = "cannotDelete";
                    } else {
                        // if delete failure
                        if (!userGroupDAO.deleteUserGroup(userForm.getGroupID())) {
                            kq = "failure";
                        }
                    }
                }
            }
        } catch (Exception e) {
            kq = "failure";
        }

        out.print(kq);
        out.flush();

        return null;
    }
}
