package com.blackpoints.struts.form;

import com.blackpoints.classes.Category;
import com.blackpoints.classes.City;
import com.blackpoints.classes.District;
import com.blackpoints.classes.TempPOI;
import com.blackpoints.dao.CategoryDAO;
import com.blackpoints.dao.CityDAO;
import com.blackpoints.dao.DistrictDAO;
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
    private String address;
    private int city;
    private int district;
    private String description;
    private int categoryID;
    private int rating;
    private String createdOnDate;
    private int createdByUserID;
    private String updatedOnDate;
    private int updatedByUserID;
    private List<TempPOI> tempPOIList;

    @Override
    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors err = new ActionErrors();
        if (name == null || name.trim().length() == 0) {
            err.add("name", new ActionMessage("errors.required", "Tên điểm đen"));
        } else {
            if (name.trim().length() < 4 || name.trim().length() > 100) {
                err.add("name", new ActionMessage("errors.range", "Tên điểm đen có độ dài", "4", "100", "kí tự"));
            }
        }
        if (address == null || address.trim().length() == 0) {
            err.add("address", new ActionMessage("errors.required", "Địa chỉ"));
        } else {
            if (address.trim().length() < 10 || address.trim().length() > 100) {
                err.add("address", new ActionMessage("errors.range", "Địa chỉ", "10", "100", "kí tự"));
            }
        }
        if (categoryID <= 0) {
            err.add("categoryID", new ActionMessage("errors.select", "kiểu điểm đen"));
        }
        if (description != null && description.trim().length() > 500) {
            err.add("description", new ActionMessage("errors.maxlength", "Mô tả điểm đen", "500"));
        }
        City c = new CityDAO().getCityByID(city);
        District d = new DistrictDAO().getDistrictByID(district);
        if (c!= null && d != null && city != d.getCity()) {
            err.add("city", new ActionMessage("errors.nodistrict", c.getName(), d.getName())); 
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

    public List<TempPOI> getTempPOIList() {
        return tempPOIList;
    }

    public void setTempPOIList(List<TempPOI> tempPOIList) {
        this.tempPOIList = tempPOIList;
    }

    public List<Category> getCategoryList() {
        return new CategoryDAO().getAllCategories();
    }

    public List<City> getCityList() {
        return new CityDAO().getAllCities();
    }

    public List<District> getDistrictList() {
        if (city == 0) {
            city = 1;
        }
        return new DistrictDAO().getAllDistrictsInCity(city);
    }
}
