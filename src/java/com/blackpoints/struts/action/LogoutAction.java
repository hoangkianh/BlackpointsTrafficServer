package com.blackpoints.struts.action;

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
public class LogoutAction extends org.apache.struts.action.Action {

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
        HttpSession session = request.getSession(true);
        session.removeAttribute("BPT_userName");
        session.removeAttribute("BPT_displayName");
        session.removeAttribute("BPT_userID");
        
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("BPT_userName") || cookie.getName().equals("BPT_displayName")) {
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        }
        
//        if (loginForm.isRememberMe()) {
//            Cookie c = new Cookie("BPT_userName", u.getUserName());
//            c.setMaxAge(7 * 24 * 60 * 60);
//            response.addCookie(c);
//            c = new Cookie("BPT_displayName", u.getDisplayName());
//            c.setMaxAge(7 * 24 * 60 * 60);
//            response.addCookie(c);
//        }
        
        return mapping.findForward("logoutSuccess");
    }
}
