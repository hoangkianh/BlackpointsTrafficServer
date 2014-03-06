package com.blackpoints.classes;

import com.blackpoints.dao.CategoryDAO;
import com.blackpoints.dao.CityDAO;
import com.blackpoints.dao.DistrictDAO;
import com.blackpoints.dao.UserDAO;
import java.io.Serializable;

/**
 *
 * @author hka
 */
public class POI implements Serializable {

    private int id;
    private String name;
    private String address;
    private int city;
    private int district;
    private String description;
    private String image;
    private String markerIcon;
    private String geometry;
    private int categoryID;
    private int rating;
    private String ratingName;
    private String bbox;
    private String geoJson;
    private String createdOnDate;
    private int createdByUserID;
    private String updatedOnDate;
    private int updatedByUserID;
    private boolean deleted;
    private String deletedOnDate;
    private int deletedByUserID;
    private String restoreOnDate;
    private int restoreByUserID;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String names) {
        this.address = names;
    }

    public int getCity() {
        return city;
    }

    public void setCity(int city) {
        this.city = city;
    }

    public int getDistrict() {
        return district;
    }

    public void setDistrict(int district) {
        this.district = district;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getMarkerIcon() {
        return markerIcon;
    }

    public void setMarkerIcon(String markerIcon) {
        this.markerIcon = markerIcon;
    }

    public String getGeometry() {
        return geometry;
    }

    public void setGeometry(String geometry) {
        this.geometry = geometry;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getBbox() {
        return bbox;
    }

    public void setBbox(String bbox) {
        this.bbox = bbox;
    }

    public String getGeoJson() {
        return geoJson;
    }

    public void setGeoJson(String geoJson) {
        this.geoJson = geoJson;
    }

    public String getCreatedOnDate() {
        return createdOnDate;
    }

    public void setCreatedOnDate(String createdOnDate) {
        this.createdOnDate = createdOnDate;
    }

    public int getCreatedByUserID() {
        return createdByUserID;
    }

    public void setCreatedByUserID(int createdByUserID) {
        this.createdByUserID = createdByUserID;
    }

    public String getUpdatedOnDate() {
        return updatedOnDate;
    }

    public void setUpdatedOnDate(String updatedOnDate) {
        this.updatedOnDate = updatedOnDate;
    }

    public int getUpdatedByUserID() {
        return updatedByUserID;
    }

    public void setUpdatedByUserID(int updatedByUserID) {
        this.updatedByUserID = updatedByUserID;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public String getDeletedOnDate() {
        return deletedOnDate;
    }

    public void setDeletedOnDate(String deletedOnDate) {
        this.deletedOnDate = deletedOnDate;
    }

    public int getDeletedByUserID() {
        return deletedByUserID;
    }

    public void setDeletedByUserID(int deletedByUserID) {
        this.deletedByUserID = deletedByUserID;
    }

    public String getRestoreOnDate() {
        return restoreOnDate;
    }

    public void setRestoreOnDate(String restoreOnDate) {
        this.restoreOnDate = restoreOnDate;
    }

    public int getRestoreByUserID() {
        return restoreByUserID;
    }

    public void setRestoreByUserID(int restoreByUserID) {
        this.restoreByUserID = restoreByUserID;
    }
    
    public String getCityName () {
        City c = new CityDAO().getCityByID(city);
        if (c != null) {
            return c.getName();
        }
        return "";
    }
    
    public String getDistrictName () {
        District d = new DistrictDAO().getDistrictByID(district);
        if (d != null) {
            return d.getName();
        }
        return "";
    }
    
    public String getCategoryName () {
        Category c = new CategoryDAO().getCategoryById(categoryID);
        if (c != null) {
            return c.getName();
        }
        return "";
    }
    
    public String getCreatedByUserName () {
        User u = new UserDAO().getUserByID(createdByUserID);
        if (u != null) {
            return u.getUserName();
        }
        return "";
    }
    
    public String getUpdatedByUserName () {
        User u = new UserDAO().getUserByID(updatedByUserID);
        if (u != null) {
            return u.getUserName();
        }
        return "";
    }
    
    public String getDeletedByUserName () {
        User u = new UserDAO().getUserByID(deletedByUserID);
        if (u != null) {
            return u.getUserName();
        }
        return "";
    }
    
    public String getRestoredByUserName () {
        User u = new UserDAO().getUserByID(restoreByUserID);
        if (u != null) {
            return u.getUserName();
        }
        return "";
    }

    public String getRatingName() {
        return ratingName;
    }

    public void setRatingName(String ratingName) {
        this.ratingName = ratingName;
    }
    
}
