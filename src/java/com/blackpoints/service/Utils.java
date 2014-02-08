package com.blackpoints.service;

import com.blackpoints.dao.DistrictDAO;
import com.google.gson.Gson;
import javax.ws.rs.PathParam;
import javax.ws.rs.Path;
import javax.ws.rs.GET;
import javax.ws.rs.Produces;

/**
 * REST Web Service
 *
 * @author HKA
 */
@Path("utils")
public class Utils {
    /**
     * Creates a new instance of Util
     */
    public Utils() {
    }

    @GET
    @Path("getDistrictsInCity/{city}")
    @Produces("application/json; charset=UTF-8")
    public String getDistrictsInCity(@PathParam("city") int city) { 
        return new Gson().toJson(new DistrictDAO().getAllDistrictsInCity(city));
    }
}
