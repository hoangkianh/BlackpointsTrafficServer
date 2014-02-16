package com.blackpoints.struts.action;

import com.blackpoints.classes.User;
import com.blackpoints.dao.UserDAO;
import com.blackpoints.struts.form.ChangePassForm;
import com.blackpoints.utils.CookieUtils;
import com.blackpoints.utils.MD5Hashing;
import java.io.PrintWriter;
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
public class ChangePassAction extends org.apache.struts.action.Action {

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
        ChangePassForm passForm = (ChangePassForm) form;
        UserDAO userDAO = new UserDAO();
        PrintWriter out = response.getWriter();
        String kq = "success";

        int id = 0;
        HttpSession session = request.getSession(true);
        String s = (String) session.getAttribute("blackpoints");
        if (s == null || s.isEmpty()) {
            Cookie cookie = CookieUtils.getCookieByName(request, "blackpoints");
            if (cookie == null) {
                kq = "error";
            } else {
                s = cookie.getValue();
            }
        }
        try {
            response.setContentType("text/text;charset=utf-8");
            response.setHeader("cache-control", "no-cache");

            id = Integer.parseInt(s.split("~")[0]);
            User u = userDAO.getUserByID(id);

            if (u == null) {
                kq = "error";
            } else {
                if (!u.getPassword().equals(MD5Hashing.encryptPassword(passForm.getOldPass()))) {                    
                    kq = "error" + "~passNotCorrect";
                } else {
                    u.setPassword(MD5Hashing.encryptPassword(passForm.getNewPass()));
                }
            }

            if (!userDAO.updateUser(u)) {
                kq = "error";
            }
        } catch (Exception e) {
            kq = "error";
        }
        
        out.print(kq);
        out.flush();

        return null;
    }
}
