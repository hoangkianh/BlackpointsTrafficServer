package com.blackpoints.struts.form;

import com.blackpoints.classes.POIProperty;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

/**
 *
 * @author hka
 */
public class POIPropertyForm extends org.apache.struts.action.ActionForm {

    private int poiID;
    private String key;
    private String value;
    private String description;
    private List<POIProperty> propertyList;

//    @Override
//    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
//        ActionErrors err = new ActionErrors();
//        if (key == null || key.trim().length() == 0) {
//            err.add("key", new ActionMessage("errors.required", "Tên thuộc tính"));
//        }
//        if (key.trim().length() < 10 || key.trim().length() > 100) {
//            err.add("key", new ActionMessage("errors.range", "Tên (hoặc địa chỉ) điểm đen có độ dài", "10", "100", "kí tự"));
//        }
//        if (value == null || value.trim().length() == 0) {
//            err.add("value", new ActionMessage("errors.required", "Giá trị thuộc tính"));
//        }
//        if (value.trim().length() > 100) {
//            err.add("value", new ActionMessage("errors.maxlength", "Giá trị thuộc tính", "100"));
//        }
//        if (description.trim().length() > 200) {
//            err.add("description", new ActionMessage("errors.maxlength", "Mô tả", "200"));
//        }
//        return err;
//    }

    public int getPoiID() {
        return poiID;
    }

    public void setPoiID(int poiID) {
        this.poiID = poiID;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<POIProperty> getPropertyList() {
        return propertyList;
    }

    public void setPropertyList(List<POIProperty> propertyList) {
        this.propertyList = propertyList;
    }
}
