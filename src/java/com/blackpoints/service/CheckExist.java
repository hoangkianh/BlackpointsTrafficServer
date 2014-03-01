package com.blackpoints.service;

import com.blackpoints.dao.CategoryDAO;
import com.blackpoints.dao.UserDAO;
import javax.ws.rs.PathParam;
import javax.ws.rs.Path;
import javax.ws.rs.POST;
import javax.ws.rs.Produces;

/**
 * REST Web Service
 *
 * @author HKA
 */
@Path("checkExist")
public class CheckExist {

    /**
     * Creates a new instance of CheckUserExist
     */
    public CheckExist() {
    }

    @POST
    @Path("checkUserExist/{userName}")
    @Produces("text/plain")
    public String checkUserExist(@PathParam("userName") String userName) {
        String result = "true";
        if (new UserDAO().userNameIsExist(userName)) {
            result = "false";
        }
        return result;
    }
    
    @POST
    @Path("checkEmailExist/{email}")
    @Produces("text/plain")
    public String checkEmailExist(@PathParam("email") String email) {
        String result = "true";
        if (new UserDAO().emailIsExist(email)) {
            result = "false";
        }
        return result;
    }
}
