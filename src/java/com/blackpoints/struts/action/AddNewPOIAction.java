package com.blackpoints.struts.action;

import com.blackpoints.classes.POI;
import com.blackpoints.dao.POIDAO;
import com.blackpoints.dao.TempPOIDAO;
import com.blackpoints.struts.form.POIForm;
import com.blackpoints.utils.CookieUtils;
import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Locale;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.struts.Globals;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;
import org.apache.struts.util.MessageResources;

/**
 *
 * @author HKA
 */
public class AddNewPOIAction extends org.apache.struts.action.Action {

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
        POIForm poiForm = (POIForm) form;
        POI p = new POI();
        HttpSession session = request.getSession(true);
        MessageResources mr = MessageResources.getMessageResources("com.blackpoints.struts.ApplicationResource");
        Locale locale = (Locale) session.getAttribute(Globals.LOCALE_KEY);
        String poiDir = mr.getMessage(locale, "dir.poi");
        String kq = "success";
        FormFile file = poiForm.getFile();
        // get the servers upload directory real path name
        String filePath = getServlet().getServletContext().getRealPath("/") + poiDir;
        // create the upload folder if not exists
        File folder = new File(filePath);
        if (!folder.exists()) {
            folder.mkdir();
        }

        Date date = new Date();
        if (!file.getFileName().equals("")) {
            String fileName = date.getTime() + "." + FilenameUtils.getExtension(file.getFileName());

            File newFile = new File(filePath, fileName);

            // upload file
            if (!newFile.exists()) {
                FileOutputStream fos = new FileOutputStream(newFile);
                fos.write(file.getFileData());
                fos.flush();
                fos.close();
            }
            poiForm.setImage(poiDir + "/" + fileName);
        }

        // set geometry 
        poiForm.setGeometry("POINT(" + poiForm.getLongitude() + " " + poiForm.getLatitude() + ")");

        // set create by user
        String str = (String) session.getAttribute("blackpoints");
        if (str == null) {
            Cookie c = CookieUtils.getCookieByName(request, "blackpoints");
            str = c.getValue();
        }

        try {
            poiForm.setCreatedByUserID(Integer.parseInt(str.split("~")[0]));
        } catch (Exception e) {
            kq = "failure";
        }

        BeanUtils.copyProperties(p, poiForm);
        response.setContentType("text/text;charset=utf-8");
        response.setHeader("cache-control", "no-cache");
        PrintWriter out = response.getWriter();

        if (!new POIDAO().addNewPOI(p)) {
            kq = "failure";
        } else {
            // delete temppoi if exists
            int tempPOIId = poiForm.getTempPOIId();
            if (tempPOIId > 0) {
                if (!new TempPOIDAO().deletePOI(tempPOIId)) {
                    kq = "failure";
                }
            }
        }

        out.print(kq);
        out.flush();

        return null;
    }
}
