package com.blackpoints.struts.form;

import com.blackpoints.dao.UserDAO;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

/**
 *
 * @author HKA
 */
public class ReActivateForm extends org.apache.struts.action.ActionForm {
    
    private String email;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * This is the action called from the Struts framework.
     *
     * @param mapping The ActionMapping used to select this instance.
     * @param request The HTTP Request we are processing.
     * @return
     */
    @Override
    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors err = new ActionErrors();
        
        // validate email
        if (email == null || email.trim().length() == 0) {
            err.add("email", new ActionMessage("errors.required", "Email"));
        } else {
            String regex = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
                    + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
            Pattern pattern = Pattern.compile(regex);
            Matcher matcher = pattern.matcher(email);
            if (!matcher.matches()) {
                err.add("email", new ActionMessage("errors.email"));
            } else {
                if (!new UserDAO().emailIsExist(email)) {
                    err.add("email", new ActionMessage("errors.notExist", "Email"));
                }
            }
        }
        return err;
    }
}
