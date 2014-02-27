package com.blackpoints.struts.action;

import com.blackpoints.classes.User;
import com.blackpoints.dao.UserDAO;
import com.blackpoints.struts.form.UserForm;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author HKA
 */
public class GetAllUserInGroupAction extends org.apache.struts.action.Action {

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
        UserForm userForm = (UserForm) form;
        try {
            int groupID = Integer.parseInt(request.getParameter("id"));
            userForm.setGroupID(groupID);

            UserDAO userDAO = new UserDAO();
            List<User> list = userDAO.getAllUsersInGroup(groupID);
            if (list.isEmpty()) {
                return mapping.findForward("getAllUserInGroupFailure");
            }
            userForm.setUserList(list);
            return mapping.findForward("getAllUserGroupsSuccess");
        } catch (Exception e) {
            return mapping.findForward("getAllUserInGroupFailure");
        }
    }
}
