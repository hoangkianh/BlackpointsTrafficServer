package com.blackpoints.struts.form;

import com.blackpoints.classes.Category;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

/**
 *
 * @author hka
 */
public class CategoryForm extends org.apache.struts.action.ActionForm {

    private int categoryID;
    private String name;
    private String description;
    private String image;
    private List<Category> categoryList;

//    @Override
//    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
//        ActionErrors err = new ActionErrors();
//        if (name == null || name.trim().length() == 0) {
//            err.add("name", new ActionMessage("errors.required", "Tên kiểu điểm đen"));
//        }
//        if (name.trim().length() < 4 || name.trim().length() > 50) {
//            err.add("name", new ActionMessage("errors.range", "Tên (hoặc địa chỉ) điểm đen có độ dài", "4", "50", "kí tự"));
//        }
//        if (description.trim().length() > 100) {
//            err.add("description", new ActionMessage("errors.maxlength", "Mô tả điểm đen", "100"));
//        }
//        return err;
//    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public List<Category> getCategoryList() {
        return categoryList;
    }

    public void setCategoryList(List<Category> categoryList) {
        this.categoryList = categoryList;
    }
}
