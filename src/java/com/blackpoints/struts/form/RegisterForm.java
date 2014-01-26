package com.blackpoints.struts.form;

import com.blackpoints.dao.UserDAO;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import static org.glassfish.jersey.internal.Errors.error;

/**
 *
 * @author HKA
 */
public class RegisterForm extends org.apache.struts.action.ActionForm {

    private String userName;
    private String displayName;
    private String email;
    private String password;
    private String password2;
    private String description;
    private String photo;

    @Override
    public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors err = new ActionErrors();
        String regex;
        Pattern pattern;
        Matcher matcher;

        // validate userName
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

        // validate confirm password
        if (password2 != null && !password2.equals(password)) {
            err.add("password2", new ActionMessage("errors.equal", "Mật khẩu", "mật khẩu nhập lại"));
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

    public String getPassword2() {
        return password2;
    }

    public void setPassword2(String password2) {
        this.password2 = password2;
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
}
