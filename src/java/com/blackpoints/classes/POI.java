package com.blackpoints.classes;

/**
 *
 * @author hka
 */
public class POI {
    private int id;
    private String name;
    private String names;
    private String description;
    private String geometry;
    private int categoryID;
    private double rating;
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

    public String getNames() {
        return names;
    }

    public void setNames(String names) {
        this.names = names;
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
}