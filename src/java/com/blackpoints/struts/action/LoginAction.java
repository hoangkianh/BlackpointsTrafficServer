package com.blackpoints.struts.action;

import com.blackpoints.classes.User;
import com.blackpoints.dao.UserDAO;
import com.blackpoints.struts.form.LoginForm;
import com.blackpoints.util.MD5Hashing;
import java.util.Locale;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts.Globals;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.util.MessageResources;

/**
 *
 * @author HKA
 */
public class LoginAction extends org.apache.struts.action.Action {

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
        LoginForm loginForm = (LoginForm) form;
        HttpSession session = request.getSession(true);
        MessageResources mr = MessageResources.getMessageResources("com.blackpoints.struts.ApplicationResource");
        Locale locale = (Locale) session.getAttribute(Globals.LOCALE_KEY);

        User u = new UserDAO().login(loginForm.getUserName(), MD5Hashing.encryptPassword(loginForm.getPassword()));

        if (u == null) {
            loginForm.setError("<p>" + mr.getMessage(locale, "login.failure") + "</p>");
            return mapping.findForward("loginFailure");
        }

        session.setAttribute("BPT_userName", u.getUserName());
        session.setAttribute("BPT_displayName", u.getDisplayName());
        session.setAttribute("BPT_userID", u.getUserID());

        if (loginForm.isRememberMe()) {
            Cookie c = new Cookie("BPT_userName", u.getUserName());
            c.setMaxAge(7 * 24 * 60 * 60);
            response.addCookie(c);
            c = new Cookie("BPT_displayName", u.getDisplayName());
            c.setMaxAge(7 * 24 * 60 * 60);
            response.addCookie(c);
        }

        return mapping.findForward("loginSuccess");
    }
}
