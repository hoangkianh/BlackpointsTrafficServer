package com.blackpoints.struts.action;

import com.blackpoints.classes.POI;
import com.blackpoints.dao.POIDAO;
import com.blackpoints.struts.form.POIForm;
import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

/**
 *
 * @author HKA
 */
public class UpdatePOIImageAction extends org.apache.struts.action.Action {

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
        POIForm poif = (POIForm) form;
        POI poi = new POIDAO().getPOIByID(poif.getId());
        String kq = "failure";

        if (poi != null) {
            FormFile newFile = poif.getFile();
            String oldFilePath = getServlet().getServletContext().getRealPath("/") + poi.getImage();
            File oldFile = new File(oldFilePath);

            // upload new file
            if (oldFile.exists()) {
                // delete old file
                if (oldFile.delete()) {
                    FileOutputStream fos = new FileOutputStream(oldFile);
                    fos.write(newFile.getFileData());
                    fos.flush();
                    fos.close();
                    kq = "success";
                }
            }
        }
        
        PrintWriter out = response.getWriter();
        out.print(kq);
        out.flush();
        return null;
    }
}
