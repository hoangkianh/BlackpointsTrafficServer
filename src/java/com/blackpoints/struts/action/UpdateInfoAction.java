package com.blackpoints.struts.action;

import com.blackpoints.classes.User;
import com.blackpoints.classes.UserGroup;
import com.blackpoints.dao.UserDAO;
import com.blackpoints.dao.UserGroupDAO;
import com.blackpoints.struts.form.UpdateInfoForm;
import com.blackpoints.utils.CookieUtils;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
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
public class UpdateInfoAction extends org.apache.struts.action.Action {

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
        UpdateInfoForm infoForm = (UpdateInfoForm) form;
        UserDAO userDAO = new UserDAO();
        PrintWriter out = response.getWriter();
        String kq = "success";

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

            if (u == null) {
                kq = "failure";
            }

            BeanUtils.copyProperties(u, infoForm);

            if (!userDAO.updateUser(u)) {
                kq = "failure";
            }

            if (kq.equals("success")) {
                UserGroup ug = new UserGroupDAO().getUserGroupByID(u.getGroupID());
                String value = u.getUserID() + "~" + u.getUserName() + "~" + u.getDisplayName() + "~" + ug.getLevel() + "~" + u.getEmail();
                
                session.setAttribute("blackpoints", value);
                
                Cookie cookie = CookieUtils.getCookieByName(request, "blackpoints");
                if (cookie != null) {
                    cookie.setValue(URLEncoder.encode(value, "UTF-8"));
                    cookie.setMaxAge(7 * 24 * 60 * 60);
                    response.addCookie(cookie);

                }
            }

            kq += "~" + u.getDisplayName();
        } catch (Exception ex) {
            kq = "failure";
        }

        out.print(kq);
        out.flush();

        return null;
    }
}
