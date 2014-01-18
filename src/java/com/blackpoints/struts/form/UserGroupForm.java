package com.blackpoints.struts.form;

import com.blackpoints.classes.UserGroup;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

/**
 *
 * @author hka
 */
public class UserGroupForm extends org.apache.struts.action.ActionForm {

    private int userGroupID;
    private String name;
    private int level;
    private String description;
    private String createdOnDate;
    private int createdByUserID;
    private String updatedOnDate;
    private int updatedByUserID;
    private List<UserGroup> userGroupList;

//    @Override
//    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
//        ActionErrors err = new ActionErrors();
//        if (name == null || name.trim().length() == 0) {
//            err.add("name", new ActionMessage("errors.required", "Tên nhóm người dùng"));
//        }
//        if (name.trim().length() < 4 || name.trim().length() > 30) {
//            err.add("name", new ActionMessage("errors.range", "Tên nhóm người dùng có độ dài", "4", "30", "kí tự"));
//        }
//        if (level <= 0) {
//            err.add("level", new ActionMessage("errors.select", "level cho nhóm người dùng"));
//        }
//        if (description.trim().length() > 200) {
//            err.add("description", new ActionMessage("errors.maxlength", "Mô tả", "200"));
//        }
//        return err;
//    }

    public int getUserGroupID() {
        return userGroupID;
    }

    public void setUserGroupID(int userGroupID) {
        this.userGroupID = userGroupID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public List<UserGroup> getUserGroupList() {
        return userGroupList;
    }

    public void setUserGroupList(List<UserGroup> userGroupList) {
        this.userGroupList = userGroupList;
    }
}
