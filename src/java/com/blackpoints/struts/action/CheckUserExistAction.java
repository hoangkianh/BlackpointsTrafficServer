package com.blackpoints.struts.action;

import com.blackpoints.dao.UserDAO;
import com.blackpoints.struts.form.RegisterForm;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author HKA
 */
public class CheckUserExistAction extends org.apache.struts.action.Action {

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
        
        RegisterForm rf = (RegisterForm) form;

        response.setContentType("text/text;charset=utf-8");
        response.setHeader("cache-control", "no-cache");
        PrintWriter out = response.getWriter();

        if (new UserDAO().userNameIsExist(rf.getUserName())) {
            out.println("false"); // if user name is exist --> false
        }
        else{
            out.print("true"); // if user name is not exist --> true
        }
        out.flush();

        return null;
    }
}
