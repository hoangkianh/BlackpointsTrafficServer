package com.blackpoints.classes;

import com.blackpoints.dao.UserDAO;
import java.io.Serializable;

/**
 *
 * @author hka
 */
public class UserGroup implements Serializable{

    private int userGroupID;
    private String name;
    private int level;
    private String description;
    private String createdOnDate;
    private int createdByUserID;
    private String updatedOnDate;
    private int updatedByUserID;
    private final UserDAO userDao;

    public UserGroup() {
        userDao = new UserDAO();
    }

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
    
    public String getUserCreated () {
        User u = this.userDao.getUserByID(createdByUserID);
        if (u != null) {
            return u.getUserName();
        }
        return "System";
    }
    
    public String getUserUpdated () {
        User u = this.userDao.getUserByID(updatedByUserID);
        if (u != null) {
            return u.getUserName();
        }
        return "";
    }
}
