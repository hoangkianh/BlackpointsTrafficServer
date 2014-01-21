package com.blackpoints.struts.form;

import com.blackpoints.classes.User;
import java.util.List;

/**
 *
 * @author hka
 */
public class UserForm extends org.apache.struts.action.ActionForm {

    private int userID;
    private String userName;
    private String password;
    private String displayName;
    private String description;
    private String email;
    private String photo;
    private String lastLogin;
    private int groupID;
    private String createdOnDate;
    private String updatedOnDate;
    private List<User> userList;

//    @Override
//    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
//        ActionErrors err = new ActionErrors();
//        if (userName == null || userName.trim().length() == 0) {
//            err.add("userName", new ActionMessage("errors.required", "Tên đăng nhập"));
//        }
//        if (userName.trim().length() < 6 || userName.trim().length() > 30) {
//            err.add("userName", new ActionMessage("errors.range", "Tên đăng nhập có độ dài", "6", "30", "kí tự"));
//        }
//        if (password == null || password.trim().length() == 0) {
//            err.add("password", new ActionMessage("errors.required", "Mật khẩu"));
//        }
//        if (password.trim().length() < 6 || password.trim().length() > 30) {
//            err.add("password", new ActionMessage("errors.range", "Mật khẩu có độ dài", "6", "30", "kí tự"));
//        }
//        if (displayName != null && displayName.trim().length() > 30) {
//            err.add("description", new ActionMessage("errors.maxlength", "Mô tả điểm đen", "200"));
//        }
//        if (email == null || email.trim().length() == 0) {
//            err.add("email", new ActionMessage("errors.required", "Email"));
//        }
//        String regex = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
//                + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
//        Pattern pattern = Pattern.compile(regex);
//        Matcher matcher = pattern.matcher(email);
//        if (!matcher.matches()) {
//            err.add("email", new ActionMessage("errors.email", email));
//        }
//        if (groupID <= 0) {
//            err.add("groupID", new ActionMessage("errors.required", "nhóm người dùng"));
//        }
//        if (description.trim().length() > 200) {
//            err.add("description", new ActionMessage("errors.maxlength", "Mô tả", "200"));
//        }
//        return err;
//    }

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

    public List<User> getUserList() {
        return userList;
    }

    public void setUserList(List<User> userList) {
        this.userList = userList;
    }
}