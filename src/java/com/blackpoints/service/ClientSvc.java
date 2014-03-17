package com.blackpoints.service;

import com.blackpoints.classes.GeoLocation;
import com.blackpoints.classes.POI;
import com.blackpoints.classes.POIClient;
import com.blackpoints.dao.CategoryDAO;
import com.blackpoints.dao.POIDAO;
import com.blackpoints.utils.GeoUtil;
import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import javax.ws.rs.Path;
import javax.ws.rs.GET;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

/**
 * REST Web Service
 *
 * @author HKA
 */
@Path("client")
public class ClientSvc {

    private final POIDAO poiDAO;
    private final CategoryDAO categoryDAO;    
    private final String urlHost = "http://blackpoints.jelastic.lunacloud.com/";

    public ClientSvc() {
        poiDAO = new POIDAO();
        categoryDAO = new CategoryDAO();
    }

    @GET
    @Path("getAll")
    @Produces("application/json; charset=UTF-8")
    public String getAll() {
        List<POI> list = poiDAO.getAllPOIs(false);
        List<POIClient> listPOIClients = new ArrayList<POIClient>();
        
        for (POI poi : list) {
            POIClient poiClient = new POIClient();
            
            poiClient.setId(poi.getId());
            poiClient.setName(poi.getName());
            poiClient.setCategory(poi.getCategoryName());
            poiClient.setAddress(poi.getAddress());
            poiClient.setCity(poi.getCityName());
            poiClient.setDistrict(poi.getDistrictName());
            poiClient.setDescription(poi.getDescription());
            poiClient.setImage(urlHost + poi.getImage());
            poiClient.setMarkerIcon(urlHost + categoryDAO.getCategoryById(poi.getCategoryID()).getImage());
            poiClient.setGeometry(poi.getGeometry());
            poiClient.setRating(poi.getRatingName());
            poiClient.setCreatedOnDate(poi.getCreatedOnDate());

            listPOIClients.add(poiClient);
        }
        return new Gson().toJson(listPOIClients);
    }

    @GET
    @Path("getPOIInRadius/{lng}/{lat}/{radius}")
    @Produces("application/json; charset=UTF-8")
    public String getPOIInRadius(@PathParam("lng") double lng, @PathParam("lat") double lat, @PathParam("radius") double radius) {
        List<POI> list = poiDAO.getAllPOIs(false);
        List<POIClient> inRadiusList = new ArrayList<POIClient>();

        GeoLocation centerGeo = new GeoLocation(lat, lng);

        for (POI poi : list) {

            List<GeoLocation> geoList = GeoUtil.toLatLng(poi.getGeometry());

            for (GeoLocation geoLocation : geoList) {

                double distance = GeoUtil.caculateDistance(centerGeo, geoLocation);

                if (distance <= radius) {
                    POIClient poiClient = new POIClient();
                    
                    poiClient.setId(poi.getId());
                    poiClient.setName(poi.getName());
                    poiClient.setCategory(poi.getCategoryName());
                    poiClient.setAddress(poi.getAddress());
                    poiClient.setCity(poi.getCityName());
                    poiClient.setDistrict(poi.getDistrictName());
                    poiClient.setDescription(poi.getDescription());
                    poiClient.setImage(urlHost + poi.getImage());
                    poiClient.setMarkerIcon(urlHost + categoryDAO.getCategoryById(poi.getCategoryID()).getImage());
                    poiClient.setGeometry(poi.getGeometry());
                    poiClient.setRating(poi.getRatingName());
                    poiClient.setCreatedOnDate(poi.getCreatedOnDate());
                    poiClient.setDistance(distance);
                    
                    inRadiusList.add(poiClient);
                    break;
                }
            }
        }
        
        // sort inRadiusList
        Collections.sort(inRadiusList, new Comparator<POIClient>() {

            @Override
            public int compare(POIClient p1, POIClient p2) {
                int kq = 0;
                if (p1.getDistance() > p2.getDistance()) {
                    kq = 1;
                } else {
                    kq = -1;
                }
                return kq;
            }
        });
        
        return new Gson().toJson(inRadiusList);
    }
}
