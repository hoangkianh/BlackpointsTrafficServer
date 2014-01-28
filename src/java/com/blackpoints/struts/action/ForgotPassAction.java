package com.blackpoints.struts.action;

import com.blackpoints.classes.User;
import com.blackpoints.dao.UserDAO;
import com.blackpoints.struts.form.ForgotPassForm;
import com.blackpoints.util.MD5Hashing;
import com.blackpoints.util.SendingEmail;
import java.security.SecureRandom;
import java.util.Locale;
import java.util.Random;
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
public class ForgotPassAction extends org.apache.struts.action.Action {
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
        ForgotPassForm forgotPassForm = (ForgotPassForm) form;
        UserDAO userDAO = new UserDAO();
        User u = userDAO.getUserByEmail(forgotPassForm.getEmail());
        
        if (u != null) {
            // generate random password
            Random random = new SecureRandom();
            char[] charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_".toCharArray();
            char[] result = new char[10];
            for (int i = 0; i < 10; i++) {
                int idx = random.nextInt(charset.length);
                result[i] = charset[idx];
            }
            String newPassword = new String(result);
            u.setPassword(MD5Hashing.encryptPassword(newPassword));
            
            // send reactive email
            HttpSession session = request.getSession(true);
            MessageResources mr = MessageResources.getMessageResources("com.blackpoints.struts.ApplicationResource");
            Locale locale = (Locale) session.getAttribute(Globals.LOCALE_KEY);
            String from = mr.getMessage(locale, "emailconfig.from");
            String password = mr.getMessage(locale, "emailconfig.password");
            String subject = mr.getMessage(locale, "emailconfig.forgotpass.subject");
            StringBuilder body = new StringBuilder(mr.getMessage(locale, "emailconfig.forgotpass.body", u.getDisplayName(), newPassword));
            body.append(mr.getMessage(locale, "emailconfig.forgotpass.link", u.getEmail(), u.getSalt()));
            body.append(mr.getMessage(locale, "emailconfig.help"));
            body.append(mr.getMessage(locale, "emailconfig.sign"));

            if (!SendingEmail.sendEmail(from, password, forgotPassForm.getEmail(), subject, body.toString())) {
                return mapping.findForward("sendingEmailFailure");
            }
            
            if (userDAO.updateUser(u)) {
                return mapping.findForward("forgotPassSuccess");                
            }
        }
        
        return mapping.findForward("forgotPassFailure");
    }
}
