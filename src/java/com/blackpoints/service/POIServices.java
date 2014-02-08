package com.blackpoints.service;

import com.blackpoints.classes.City;
import com.blackpoints.classes.District;
import com.blackpoints.classes.GeoLocation;
import com.blackpoints.classes.POI;
import com.blackpoints.classes.TempPOI;
import com.blackpoints.dao.CategoryDAO;
import com.blackpoints.dao.CityDAO;
import com.blackpoints.dao.DistrictDAO;
import com.blackpoints.dao.POIDAO;
import com.blackpoints.dao.TempPOIDAO;
import com.blackpoints.utils.GeoUtil;
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
    public String getPOIInDistrict(@PathParam("district") String district, @PathParam("city") String city) {
        System.out.println(district);
        List<POI> inDistrictList = new ArrayList<POI>();
        City c = new CityDAO().getCityByName(city);
        District d = new DistrictDAO().getDistrictByName(district, c.getId());
        if (c != null && d != null) {
            System.out.println(d.getName());
            for (POI poi : pois) {
                if (poi.getCity() == c.getId() && poi.getDistrict() == d.getId()) {
                    inDistrictList.add(poi);
                }
            }
        }
        return new Gson().toJson(inDistrictList);
    }
    
    @GET
    @Path("getDistrict/{city}")
    @Produces("application/json; charset=UTF-8")
    public String getDistrict(@PathParam("city") int city) {
        return "";
    }
}
