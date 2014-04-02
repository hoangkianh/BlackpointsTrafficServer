package com.blackpoints.struts.action;

import com.blackpoints.classes.TempPOI;
import com.blackpoints.dao.TempPOIDAO;
import com.blackpoints.struts.form.TempPOIForm;
import com.blackpoints.utils.CookieUtils;
import java.io.PrintWriter;
import java.net.URLDecoder;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author HKA
 */
public class AddNewTempPOIAction extends org.apache.struts.action.Action {

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
        TempPOIForm tempPOIForm = (TempPOIForm) form;
        TempPOI tempPOI = new TempPOI();
        BeanUtils.copyProperties(tempPOI, tempPOIForm);
        HttpSession session = request.getSession(true);
        String str = (String) session.getAttribute("blackpoints");
        if (str == null) {
            Cookie c = CookieUtils.getCookieByName(request, "blackpoints");
            str = URLDecoder.decode(c.getValue(), "UTF-8");
        }

        tempPOI.setCreatedByUserID(Integer.parseInt(str.split("~")[0]));

        response.setContentType("text/text;charset=utf-8");
        response.setHeader("cache-control", "no-cache");
        PrintWriter out = response.getWriter();

        if (new TempPOIDAO().addNewTempPOI(tempPOI)) {
            out.println("success");
        } else {
            out.println("failure");
        }

        out.flush();

        return null;
    }
}
