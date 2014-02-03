package com.blackpoints.classes;

/**
 *
 * @author hka
 */
public class TempPOI {

    private int id;
    private String name;
    private String address;
    private String description;
    private String geometry;
    private int categoryID;
    private double rating;
    private int count;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
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
}
