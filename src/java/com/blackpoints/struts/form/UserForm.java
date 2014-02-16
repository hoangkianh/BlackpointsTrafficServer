package com.blackpoints.struts.form;

import com.blackpoints.classes.User;
import com.blackpoints.dao.UserDAO;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;

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
    private String salt;
    private boolean activated;
    private String createdOnDate;
    private String activatedOnDate;
    private String updatedOnDate;
    private List<User> userList;
    private int level;

    @Override
    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors err = new ActionErrors();
        String regex;
        Pattern pattern;
        Matcher matcher;

        if (userName == null || userName.trim().length() == 0) {
            err.add("userName", new ActionMessage("errors.required", "Tên đăng nhập"));
        } else {
            if (userName.trim().length() < 6 || userName.trim().length() > 30) {
                err.add("userName", new ActionMessage("errors.range", "Tên đăng nhập có độ dài", "6", "30", "kí tự"));
            } else {
                regex = "^[a-zA-Z0-9_]*$";
                pattern = Pattern.compile(regex);
                matcher = pattern.matcher(userName);

                if (!matcher.matches()) {
                    err.add("userName", new ActionMessage("errors.userName"));
                } else {
                    if (new UserDAO().userNameIsExist(userName)) {
                        err.add("userName", new ActionMessage("errors.isExist", "Tên đăng nhập"));
                    }
                }
            }
        }
        // validate displayName
        if (displayName == null || displayName.trim().length() == 0) {
            err.add("displayName", new ActionMessage("errors.required", "Tên hiển thị"));
        } else {
            if (displayName.trim().length() < 6 || displayName.trim().length() > 30) {
                err.add("displayName", new ActionMessage("errors.range", "Tên hiển thị", "6", "30", "kí tự"));
            }
        }

        // validate password
        if (password == null || password.trim().length() == 0) {
            err.add("password", new ActionMessage("errors.required", "Mật khẩu"));
        } else {
            if (password.trim().length() < 6 || password.trim().length() > 30) {
                err.add("password", new ActionMessage("errors.range", "Mật khẩu có độ dài", "6", "30", "kí tự"));
            }
        }
        
        // validate email
        if (email == null || email.trim().length() == 0) {
            err.add("email", new ActionMessage("errors.required", "Email"));
        } else {
            regex = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
                    + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
            pattern = Pattern.compile(regex);
            matcher = pattern.matcher(email);
            if (!matcher.matches()) {
                err.add("email", new ActionMessage("errors.email"));
            } else {
                if (new UserDAO().emailIsExist(email)) {
                    err.add("email", new ActionMessage("errors.isExist", "Email"));
                }
            }
        }
        if (description != null && description.trim().length() > 200) {
            err.add("description", new ActionMessage("errors.maxlength", "Thông tin thêm", "200"));
        }
        
        return err;
    }

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

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
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

    public void setActivated(boolean isActivated) {
        this.activated = isActivated;
    }

    public String getActivatedOnDate() {
        return activatedOnDate;
    }

    public void setActivatedOnDate(String activatedOnDate) {
        this.activatedOnDate = activatedOnDate;
    }
}
