package com.blackpoints.struts.action;

import com.blackpoints.classes.POI;
import com.blackpoints.classes.User;
import com.blackpoints.dao.POIDAO;
import com.blackpoints.dao.UserDAO;
import com.blackpoints.struts.form.POIForm;
import com.blackpoints.utils.CookieUtils;
import com.blackpoints.utils.MD5Hashing;
import java.io.PrintWriter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author HKA
 */
public class DeletePOIAction extends org.apache.struts.action.Action {

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
        POIDAO poiDAO = new POIDAO();
        UserDAO userDAO = new UserDAO();
        PrintWriter out = response.getWriter();
        String kq = "success";

        // get UserID
        int userID = 0;
        HttpSession session = request.getSession(true);
        String s = (String) session.getAttribute("blackpoints");
        if (s == null) {
            Cookie cookie = CookieUtils.getCookieByName(request, "blackpoints");
            if (cookie == null) {
                kq = "failure";
            } else {
                s = cookie.getValue();
            }
        }
        try {
            response.setContentType("text/text;charset=utf-8");
            response.setHeader("cache-control", "no-cache");

            userID = Integer.parseInt(s.split("~")[0]);
            User u = userDAO.getUserByID(userID);

            // compare password
            if (u == null) {
                kq = "failure";
            } else {
                String password = MD5Hashing.encryptPassword(request.getParameter("password"));
                if (!u.getPassword().equals(password)) {
                    kq = "passwordNotCorrect";
                } else {
                    POI p = poiDAO.getPOIByID(poif.getId());
                    // delete userID
                    p.setDeletedByUserID(userID);
                    if (!poiDAO.deletePOI(p)) {
                        kq = "failure";
                    }
                }
            }
        } catch (Exception e) {
            kq = "failure";
        }

        out.print(kq);
        out.flush();;

        return null;
    }
}
