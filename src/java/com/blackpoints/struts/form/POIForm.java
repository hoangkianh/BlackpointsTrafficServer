package com.blackpoints.struts.form;

import com.blackpoints.classes.Category;
import com.blackpoints.classes.City;
import com.blackpoints.classes.District;
import com.blackpoints.classes.POI;
import com.blackpoints.dao.CategoryDAO;
import com.blackpoints.dao.CityDAO;
import com.blackpoints.dao.DistrictDAO;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.upload.FormFile;

/**
 *
 * @author hka
 */
public class POIForm extends org.apache.struts.action.ActionForm {

    private int id;
    private int tempPOIId;
    private String name;
    private String address;
    private int city;
    private int district;
    private String description;
    private String image;
    private String geometry;
    private int categoryID;
    private int rating;
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
    private String cityName;
    private String districtName;
    private String categoryName;
    private String ratingName;
    private FormFile file;
    private double longitude;
    private double latitude;

    private List<POI> poiList;
    private List<POI> poiListInDistrict;

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
        if (longitude < 0.0) {
            err.add("longitude", new ActionMessage("errors.required", "Kinh độ", "10", "100", "kí tự"));
        }
        if (latitude < 0.0) {
            err.add("latitude", new ActionMessage("errors.required", "Vĩ độ", "10", "100", "kí tự"));
        }
        // validate file upload
        if (file == null || (file != null && file.getFileSize() == 0)) {
            err.add("file", new ActionMessage("errors.file.required"));
        } else {
            // only image file upload
            if (!file.getContentType().equals("image/png")
                    && !file.getContentType().equals("image/jpeg")
                    && !file.getContentType().equals("image/bmp")) {
                err.add("file", new ActionMessage("errors.file.extension", ".png, .jpg, .jpeg, .bmp"));
            } else {
                if (getFile().getFileSize() > 1048576) { //1 MB
                    err.add("file", new ActionMessage("errors.file.size"));
                }
            }
        }
        if (categoryID <= 0) {
            err.add("categoryID", new ActionMessage("errors.select", "kiểu điểm đen"));
        }
        if (description.trim().length() > 200) {
            err.add("description", new ActionMessage("errors.maxlength", "Mô tả điểm đen", "200"));
        }
        return err;
    }

    public int getTempPOIId() {
        return tempPOIId;
    }

    public void setTempPOIId(int tempPOIId) {
        this.tempPOIId = tempPOIId;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
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

    public List<POI> getPoiList() {
        return poiList;
    }

    public void setPoiList(List<POI> poiList) {
        this.poiList = poiList;
    }

    public List<Category> getCategoryList() {
        return new CategoryDAO().getAllCategories();
    }

    public String getCityName() {
        City c = new CityDAO().getCityByID(city);
        if (c != null) {
            return c.getName();
        }
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public String getDistrictName() {
        District d = new DistrictDAO().getDistrictByID(district);
        if (d != null) {
            return d.getName();
        }
        return districtName;
    }

    public void setDistrictName(String districtName) {
        this.districtName = districtName;
    }

    public String getCategoryName() {
        Category c = new CategoryDAO().getCategoryById(categoryID);
        if (c != null) {
            return c.getName();
        }
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public void setRatingName(String ratingName) {
        this.ratingName = ratingName;
    }

    public String getRatingName() {
        return this.ratingName;
    }

    public List<POI> getPoiListInDistrict() {
        return poiListInDistrict;
    }

    public void setPoiListInDistrict(List<POI> poiListInDistrict) {
        this.poiListInDistrict = poiListInDistrict;
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

    public FormFile getFile() {
        return file;
    }

    public void setFile(FormFile file) {
        this.file = file;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }
}
