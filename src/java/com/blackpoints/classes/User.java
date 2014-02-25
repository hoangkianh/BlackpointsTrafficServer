package com.blackpoints.classes;

import com.blackpoints.dao.UserGroupDAO;
import java.io.Serializable;

/**
 *
 * @author hka
 */
public class User implements Serializable {

    private int userID;
    private String userName;
    private String password;
    private String displayName;
    private String description;
    private String email;
    private String photo;
    private String lastLogin;
    private int groupID;
    private boolean activated;
    private String salt;
    private String createdOnDate;
    private String activatedOnDate;
    private String updatedOnDate;

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(String lastLogin) {
        this.lastLogin = lastLogin;
    }

    public int getGroupID() {
        return groupID;
    }

    public void setGroupID(int groupID) {
        this.groupID = groupID;
    }

    public String getCreatedOnDate() {
        return createdOnDate;
    }

    public void setCreatedOnDate(String createdOnDate) {
        this.createdOnDate = createdOnDate;
    }

    public String getUpdatedOnDate() {
        return updatedOnDate;
    }

    public void setUpdatedOnDate(String updatedOnDate) {
        this.updatedOnDate = updatedOnDate;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public boolean isActivated() {
        return activated;
    }

    public void setActivated(boolean activated) {
        this.activated = activated;
    }

    public String getActivatedOnDate() {
        return activatedOnDate;
    }

    public void setActivatedOnDate(String activatedOnDate) {
        this.activatedOnDate = activatedOnDate;
    }
    
    public int getLevel() {
        UserGroup ug = new UserGroupDAO().getUserGroupByID(groupID);
        if (ug != null) {
            return ug.getLevel();
        }
        return 0;
    }
}
