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
public class TempPOI implements Serializable {

    private int id;
    private String name;
    private String address;
    private int city;
    private int district;
    private String description;
    private int categoryID;
    private int rating;
    private String ratingName;
    private String createdOnDate;
    private int createdByUserID;
    private String updatedOnDate;
    private int updatedByUserID;

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

    public void setAddress(String address) {
        this.address = address;
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

    public String getRatingName() {
        return ratingName;
    }

    public void setRatingName(String ratingName) {
        this.ratingName = ratingName;
    }
}
