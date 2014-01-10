package com.blackpoints.struts.form;

import com.blackpoints.classes.TempPOI;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

/**
 *
 * @author hka
 */
public class TempPOIForm extends org.apache.struts.action.ActionForm {

    private int id;
    private String name;
    private String description;
    private String geometry;
    private double rating;
    private int count;
    private String createdOnDate;
    private int createdByUserID;
    private String updatedOnDate;
    private int updatedByUserID;
    private List<TempPOI> tempPOIList;

    @Override
    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors err = new ActionErrors();
        if (name == null || name.trim().length() == 0) {
            err.add("name", new ActionMessage("errors.required", "Tên (hoặc địa chỉ) điểm đen"));
        }
        if (name.trim().length() < 10 || name.trim().length() > 100) {
            err.add("name", new ActionMessage("errors.range", "Tên (hoặc địa chỉ) điểm đen có độ dài", "10", "100", "kí tự"));
        }
        if (description.trim().length() > 200) {
            err.add("description", new ActionMessage("errors.maxlength", "Mô tả điểm đen", "200"));
        }
        if (geometry == null || geometry.trim().length() == 0) {
            err.add("geometry", new ActionMessage("errors.select", "điểm đen trên bản đồ"));
        }
        return err;
    }

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

    public List<TempPOI> getTempPOIList() {
        return tempPOIList;
    }

    public void setTempPOIList(List<TempPOI> tempPOIList) {
        this.tempPOIList = tempPOIList;
    }
}
