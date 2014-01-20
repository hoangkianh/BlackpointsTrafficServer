package com.blackpoints.service;

import javax.ws.rs.Path;
import javax.ws.rs.POST;
import javax.ws.rs.Produces;

/**
 * REST Web Service
 *
 * @author HKA
 */
@Path("LoginService")
public class LoginService {

    public LoginService() {
    }

    @POST
    @Produces("application/json")
    public String login() {
        return "";
    }
}
