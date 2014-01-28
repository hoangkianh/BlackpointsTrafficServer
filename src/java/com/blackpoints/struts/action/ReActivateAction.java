package com.blackpoints.struts.action;

import com.blackpoints.classes.User;
import com.blackpoints.dao.UserDAO;
import com.blackpoints.struts.form.ReActivateForm;
import com.blackpoints.util.MD5Hashing;
import com.blackpoints.util.SendingEmail;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
public class ReActivateAction extends org.apache.struts.action.Action {

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
        ReActivateForm reActivateForm = (ReActivateForm) form;
        UserDAO userDAO = new UserDAO();
        User u = userDAO.getUserByEmail(reActivateForm.getEmail());

        if (u != null) {
            if (u.isActivated()) {
                return mapping.findForward("activateRedirect");
            }
            
            // set new salt
            DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            u.setSalt(MD5Hashing.encryptPassword(dateFormat.format(new Date())));
            
            // send reactive email
            HttpSession session = request.getSession(true);
            MessageResources mr = MessageResources.getMessageResources("com.blackpoints.struts.ApplicationResource");
            Locale locale = (Locale) session.getAttribute(Globals.LOCALE_KEY);
            String from = mr.getMessage(locale, "emailconfig.from");
            String password = mr.getMessage(locale, "emailconfig.password");
            String subject = mr.getMessage(locale, "emailconfig.reactivate.subject");
            StringBuilder body = new StringBuilder(mr.getMessage(locale, "emailconfig.reactivate.body", u.getDisplayName(), u.getUserName()));
            body.append(mr.getMessage(locale, "emailconfig.reactivate.link", u.getEmail(), u.getSalt()));
            body.append(mr.getMessage(locale, "emailconfig.help"));
            body.append(mr.getMessage(locale, "emailconfig.sign"));

            if (!SendingEmail.sendEmail(from, password, reActivateForm.getEmail(), subject, body.toString())) {
                return mapping.findForward("sendingEmailFailure");
            }
            
            if (userDAO.updateUser(u)) {
                return mapping.findForward("activateSuccess");                
            }
        }
        return mapping.findForward("activateFailure");
    }
}
