package com.blackpoints.struts.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

/**
 *
 * @author HKA
 */
public class ChangePassForm extends org.apache.struts.action.ActionForm {

    private String oldPass;
    private String newPass;
    private String newPass2;

    public String getOldPass() {
        return oldPass;
    }

    public void setOldPass(String oldPass) {
        this.oldPass = oldPass;
    }

    public String getNewPass() {
        return newPass;
    }

    public void setNewPass(String newPass) {
        this.newPass = newPass;
    }

    public String getNewPass2() {
        return newPass2;
    }

    public void setNewPass2(String newPass2) {
        this.newPass2 = newPass2;
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

        if (newPass == null || newPass.trim().length() == 0) {
            err.add("newPass", new ActionMessage("errors.required", "Mật khẩu"));
        } else {
            if (newPass.trim().length() < 6 || newPass.trim().length() > 30) {
                err.add("newPass", new ActionMessage("errors.range", "Mật khẩu có độ dài", "6", "30", "kí tự"));
            }
        }

        // validate confirm password
        if (newPass2 != null && !newPass2.equals(newPass2)) {
            err.add("password2", new ActionMessage("errors.equal", "Mật khẩu", "mật khẩu nhập lại"));
        }
        return err;
    }
}
