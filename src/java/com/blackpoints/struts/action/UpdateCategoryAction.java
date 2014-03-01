package com.blackpoints.struts.action;

import com.blackpoints.classes.Category;
import com.blackpoints.struts.form.CategoryForm;
import com.blackpoints.utils.StringUtil;
import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.FilenameUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

/**
 *
 * @author HKA
 */
public class UpdateCategoryAction extends org.apache.struts.action.Action {

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
        CategoryForm categoryForm = (CategoryForm) form;
        Category c = new Category();
        PrintWriter out = response.getWriter();
        String kq = "success";
        
        FormFile file = categoryForm.getFile();
        // get the servers upload directory real path name
        String filePath = getServlet().getServletContext().getRealPath("/") + "img/category";
        
        if (!file.getFileName().equals("")) {
            String fileName
                    = StringUtil.removeSignVietnameseString(categoryForm.getName())
                    + "." + FilenameUtils.getExtension(file.getFileName());
            
            File newFile = new File(filePath, fileName);
            // upload file
            if (!newFile.exists()) {
                FileOutputStream fos = new FileOutputStream(newFile);
                fos.write(file.getFileData());
                fos.flush();
                fos.close();
            }            
        }
        
        out.print(kq);
        out.flush();
        
        return null;
    }
}
