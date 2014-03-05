package com.blackpoints.struts.action;

import com.blackpoints.classes.Category;
import com.blackpoints.dao.CategoryDAO;
import com.blackpoints.struts.form.CategoryForm;
import com.blackpoints.utils.FileWrapper;
import java.io.File;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

/**
 *
 * @author HKA
 */
public class GetCategoryDetailsAction extends org.apache.struts.action.Action {

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
        int id = 0;

        try {
            id = Integer.parseInt(request.getParameter("id"));
            Category c = new CategoryDAO().getCategoryById(id);

            if (c == null) {
                return mapping.findForward("getCategoryDetailsFailure");
            }

            CategoryForm categoryForm = (CategoryForm) form;
            BeanUtils.copyProperties(categoryForm, c);

            // get file path
            String filePath = getServlet().getServletContext().getRealPath("/") + c.getImage();
            File file = new File(filePath);
            FormFile formFile = new FileWrapper(file);
            categoryForm.setFile(formFile);
        } catch (Exception e) {
            return mapping.findForward("getCategoryDetailsFailure");
        }
        return mapping.findForward("getCategoryDetailsSuccess");
    }
}
