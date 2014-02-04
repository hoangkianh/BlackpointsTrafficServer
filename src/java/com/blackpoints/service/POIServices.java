package com.blackpoints.service;

import com.blackpoints.classes.Category;
import com.blackpoints.classes.GeoLocation;
import com.blackpoints.classes.POI;
import com.blackpoints.classes.TempPOI;
import com.blackpoints.dao.CategoryDAO;
import com.blackpoints.dao.POIDAO;
import com.blackpoints.dao.TempPOIDAO;
import com.blackpoints.util.GeoUtil;
import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.List;
import javax.ws.rs.Path;
import javax.ws.rs.GET;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

/**
 * REST Web Service
 *
 * @author hka
 */
@Path("POI")
public class POIServices {

    private List<POI> pois;

    /**
     * Creates a new instance of GetAllPOI
     */
    public POIServices() {
        pois = new POIDAO().getAllPOIs(false);
    }

    /**
     * Get all not deleted POI in database
     *
     * @return json string
     */
    @GET
    @Path("getAll")
    @Produces("application/json")
    public String getAll() {
        String json = new Gson().toJson(pois);
        return json;
    }

    @GET
    @Path("getPOIinRadius/{lat}/{lng}/{radius}")
    @Produces("application/json")
    public String getPOIinRadius(@PathParam("lat") double lat, @PathParam("lng") double lng, @PathParam("radius") double radius) {
        List<POI> inRadiusList = new ArrayList<POI>();
        GeoLocation centerGeo = new GeoLocation(lat, lng);
        CategoryDAO categoryDAO = new CategoryDAO();

        for (POI poi : pois) {

            poi.setMarkerIcon(categoryDAO.getCategoryById(poi.getCategoryID()).getImage());
            
            List<GeoLocation> geoList = GeoUtil.toLatLng(poi.getGeometry());

            for (GeoLocation geoLocation : geoList) {

                double distance = GeoUtil.caculateDistance(centerGeo, geoLocation);

                if (distance <= radius) {
                    inRadiusList.add(poi);
                    break;
                }
            }
        }

        return new Gson().toJson(inRadiusList);
    }
    
    @GET
    @Path("getAllTempPOI/{lat}/{lng}/{radius}")
    @Produces("application/json")
    public String getAllTempPOI(@PathParam("lat") double lat, @PathParam("lng") double lng, @PathParam("radius") double radius) {
        List<TempPOI> tempPOIs = new TempPOIDAO().getAllTempPOIs();
        List<TempPOI> inRadiusList = new ArrayList<TempPOI>();
        GeoLocation centerGeo = new GeoLocation(lat, lng);
        
        for (TempPOI tempPOI : tempPOIs) {
            List<GeoLocation> geoList = GeoUtil.toLatLng(tempPOI.getGeometry());
            
            for (GeoLocation geoLocation : geoList) {
                
                double distance = GeoUtil.caculateDistance(centerGeo, geoLocation);
                if (distance <= radius) {
                    inRadiusList.add(tempPOI);
                    break;
                }
            }
        }
        return new Gson().toJson(inRadiusList);
    }
}
