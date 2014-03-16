package com.blackpoints.service;

import com.blackpoints.classes.POI;
import com.blackpoints.classes.POIClient;
import com.blackpoints.dao.CategoryDAO;
import com.blackpoints.dao.CityDAO;
import com.blackpoints.dao.DistrictDAO;
import com.blackpoints.dao.POIDAO;
import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.List;
import javax.ws.rs.Path;
import javax.ws.rs.GET;
import javax.ws.rs.Produces;

/**
 * REST Web Service
 *
 * @author HKA
 */
@Path("client")
public class ClientSvc {

    private POIDAO poiDAO;
    private CategoryDAO categoryDAO;
    private CityDAO cityDAO;
    private DistrictDAO districtDAO;
    private final String urlHost = "http://blackpoints.jelastic.lunacloud.com/";
    
    public ClientSvc() {
        poiDAO = new POIDAO();
        categoryDAO = new CategoryDAO();
        cityDAO = new CityDAO();
        districtDAO = new DistrictDAO();
    }

    /**
     * Retrieves representation of an instance of com.blackpoints.service.ClientSvc
     * @return an instance of java.lang.String
     */
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
}
