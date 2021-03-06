package com.blackpoints.struts.action;

import com.blackpoints.classes.Category;
import com.blackpoints.dao.CategoryDAO;
import com.blackpoints.struts.form.CategoryForm;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author hka
 */
public class GetAllCategoriesAction extends org.apache.struts.action.Action {
    
    /**
     * This is the action called from the Struts framework.
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
        CategoryForm cf = (CategoryForm) form;
        List<Category> list = new CategoryDAO().getAllCategories();
        cf.setCategoryList(list);
        return mapping.findForward("getAllCategoriesOK");
    }
}
