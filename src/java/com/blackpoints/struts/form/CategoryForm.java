package com.blackpoints.struts.form;

import com.blackpoints.classes.Category;
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
public class CategoryForm extends org.apache.struts.action.ActionForm {

    private int categoryID;
    private String name;
    private String description;
    private String image;
    private FormFile file;
    private List<Category> categoryList;

    @Override
    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors err = new ActionErrors();
        if (name == null || name.trim().length() == 0) {
            err.add("name", new ActionMessage("errors.required", "Tên kiểu điểm đen"));
        } else {
            if (name.trim().length() < 4 || name.trim().length() > 30) {
                err.add("name", new ActionMessage("errors.range", "Tên (hoặc địa chỉ) điểm đen có độ dài", "4", "30", "kí tự"));
            }
        }
        if (description.trim().length() > 100) {
            err.add("description", new ActionMessage("errors.maxlength", "Mô tả điểm đen", "100"));
        }
        
        // validate file upload
        if (file.getFileSize() == 0) {
            err.add("file", new ActionMessage("errors.file.required"));
        } else {
            // only image file upload
            if (!file.getContentType().equals("image/png")) {
                err.add("file", new ActionMessage("errors.file.extension", ".png"));
            } else {
                if (getFile().getFileSize()> 1048576) { //1 MB
                    err.add("file", new ActionMessage("errors.file.size"));
                }
            }
        }
        return err;
    }

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

    public FormFile getFile() {
        return file;
    }

    public void setFile(FormFile file) {
        this.file = file;
    }

    public List<Category> getCategoryList() {
        return categoryList;
    }

    public void setCategoryList(List<Category> categoryList) {
        this.categoryList = categoryList;
    }
}
