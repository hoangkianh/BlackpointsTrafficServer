package com.blackpoints.service;

import com.blackpoints.classes.City;
import com.blackpoints.classes.District;
import com.blackpoints.classes.GeoLocation;
import com.blackpoints.classes.POI;
import com.blackpoints.dao.CategoryDAO;
import com.blackpoints.dao.CityDAO;
import com.blackpoints.dao.DistrictDAO;
import com.blackpoints.dao.POIDAO;
import com.blackpoints.utils.GeoUtil;
import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
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
    @Produces("application/json; charset=UTF-8")
    public String getAll() {
        String json = new Gson().toJson(pois);
        return json;
    }
    
    @GET
    @Path("getPOIByID/{id}")
    @Produces("application/json; charset=UTF-8")
    public String getPOIByID(@PathParam("id") int id) {
        String json = "";
        CategoryDAO categoryDAO = new CategoryDAO();
        for (POI poi : pois) {
            if (poi.getId() == id) {
                poi.setMarkerIcon(categoryDAO.getCategoryById(poi.getCategoryID()).getImage());
                json = new Gson().toJson(poi);
                break;
            }
        }
        return json;
    }

    @GET
    @Path("getPOIInRadius/{lat}/{lng}/{radius}")
    @Produces("application/json; charset=UTF-8")
    public String getPOIInRadius(@PathParam("lat") double lat, @PathParam("lng") double lng, @PathParam("radius") double radius) {
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
    @Path("getPOIInDistrict/{district}/{city}")
    @Produces("application/json; charset=UTF-8")
    public String getPOIInDistrict(@PathParam("district") String district, @PathParam("city") String city) {
        List<POI> inDistrictList = new ArrayList<POI>();
        City c = new CityDAO().getCityByName(city);
        District d = new DistrictDAO().getDistrictByName(district, c.getId());
        if (c != null && d != null) {
            for (POI poi : pois) {
                if (poi.getCity() == c.getId() && poi.getDistrict() == d.getId()) {
                    inDistrictList.add(poi);
                }
            }
        }
        return new Gson().toJson(inDistrictList);
    }
    
    @GET
    @Path("countPOIByDistrict")
    @Produces("text/plain; charset=UTF-8")
    public String countPOIByDistrict(){
        Map<String, Map<String, Integer>> map = new POIDAO().countPOIByDistrict();
        String data = "";
        if (map != null) {
            Set<Map.Entry<String, Map<String, Integer>>> entrySet = map.entrySet();
            for (Map.Entry<String, Map<String, Integer>> entry : entrySet) {
                Set<Map.Entry<String, Integer>> subEntrySet = entry.getValue().entrySet();
                for (Map.Entry<String, Integer> subEntry : subEntrySet) {                    
                    data += entry.getKey() + "-" + subEntry.getKey() + "-" + subEntry.getValue() + "\n";
                }
            }
        }
        
        return data;
    }
}
