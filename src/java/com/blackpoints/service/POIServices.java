package com.blackpoints.service;

import com.blackpoints.classes.POI;
import com.blackpoints.dao.POIDAO;
import com.google.gson.Gson;
import java.util.List;
import javax.ws.rs.Path;
import javax.ws.rs.GET;
import javax.ws.rs.Produces;

/**
 * REST Web Service
 *
 * @author hka
 */
@Path("POI")
public class POIServices {

    /**
     * Creates a new instance of GetAllPOI
     */
    public POIServices() {
    }

    /**
     * Retrieves representation of an instance of com.blackpoints.service.POIServices
     * @return an instance of java.lang.String
     */
    @GET
    @Path("getAll")
    @Produces("application/json")
    public String getAll() {
        List<POI> pois = new POIDAO().getAllPOIs();
        String json = new Gson().toJson(pois);
        return json;
    }
}
