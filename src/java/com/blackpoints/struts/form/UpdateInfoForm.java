package com.blackpoints.struts.form;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

/**
 *
 * @author HKA
 */
public class UpdateInfoForm extends org.apache.struts.action.ActionForm {
    
    private String displayName;
    private String description;
    
    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    
    /**
     * This is the action called from the Struts framework.
     *
     * @param mapping The ActionMapping used to select this instance.
     * @param request The HTTP Request we are processing.
     * @return
     */
    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors err = new ActionErrors();
        // validate displayName
        if (displayName == null || displayName.trim().length() == 0) {
            err.add("displayName", new ActionMessage("errors.required", "Tên hiển thị"));
        } else {
            if (displayName.trim().length() < 6 || displayName.trim().length() > 30) {
                err.add("displayName", new ActionMessage("errors.range", "Tên hiển thị", "6", "30", "kí tự"));
            }
        }
        if (description != null && description.trim().length() > 200) {
            err.add("description", new ActionMessage("errors.maxlength", "Thông tin thêm", "200"));
        }
        return err;
    }
}
