package com.blackpoints.struts.action;

import com.blackpoints.classes.User;
import com.blackpoints.dao.UserDAO;
import com.blackpoints.utils.SendingEmail;
import java.util.Locale;
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
        UserDAO userDAO = new UserDAO();
        User u = userDAO.getUserByEmail(email);

        if (u != null) {
            if (u.isActivated()) {
                return mapping.findForward("activateRedirect");
            }

            if (salt.equals(u.getSalt()) && userDAO.activateUser(email)) {
                StringBuffer requestURL = request.getRequestURL();
                String link = requestURL.substring(0, requestURL.lastIndexOf("/"));
                
                // send reactive email
                HttpSession session = request.getSession(true);
                MessageResources mr = MessageResources.getMessageResources("com.blackpoints.struts.ApplicationResource");
                Locale locale = (Locale) session.getAttribute(Globals.LOCALE_KEY);
                String from = mr.getMessage(locale, "emailconfig.from");
                String password = mr.getMessage(locale, "emailconfig.password");
                String subject = mr.getMessage(locale, "emailconfig.welcome.subject", u.getDisplayName());
                StringBuilder body = new StringBuilder(mr.getMessage(locale, "emailconfig.welcome.body", u.getDisplayName()));
                body.append(link).append("/login.do");
                body.append(mr.getMessage(locale, "emailconfig.help"));
                body.append(mr.getMessage(locale, "emailconfig.sign"));

                if (!SendingEmail.sendEmail(from, password, email, subject, body.toString())) {
                    return mapping.findForward("sendingEmailFailure");
                }
                return mapping.findForward("activateSuccess");
            }
        }

        return mapping.findForward("activateFailure");
    }
}
