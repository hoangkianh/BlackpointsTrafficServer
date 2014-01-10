package com.blackpoints.dao;

import com.blackpoints.classes.User;
import com.blackpoints.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author hka
 */
public class UserDAO {

    public List<User> getAllUsers() {
        List<User> list = new ArrayList<User>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareCall("SELECT * FROM user");
            rs = stm.executeQuery();

            while (rs.next()) {
                User u = new User();
                u.setUserID(rs.getInt("userID"));
                u.setUserName(rs.getString("userName"));
                u.setPassword(rs.getString("password"));
                u.setDisplayName(rs.getString("displayName"));
                u.setEmail(rs.getString("email"));
                u.setPhoto(rs.getString("photo"));
                u.setGroupID(rs.getInt("groupID"));

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                u.setCreatedOnDate(sdf.format(new Date(rs.getDate("createdOnDate").getTime())));
                u.setUpdatedOnDate(sdf.format(new Date(rs.getDate("updatedOnDate").getTime())));

                list.add(u);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return list;
    }

    public User getUserByID(int id) {
        User u = null;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareCall("SELECT * FROM user WHERE userID=?");
            stm.setInt(1, id);
            rs = stm.executeQuery();

            if (rs.next()) {
                u = new User();
                u.setUserID(rs.getInt("userID"));
                u.setUserName(rs.getString("userName"));
                u.setPassword(rs.getString("password"));
                u.setDisplayName(rs.getString("displayName"));
                u.setEmail(rs.getString("email"));
                u.setPhoto(rs.getString("photo"));
                u.setGroupID(rs.getInt("groupID"));

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                u.setCreatedOnDate(sdf.format(new Date(rs.getDate("createdOnDate").getTime())));
                u.setUpdatedOnDate(sdf.format(new Date(rs.getDate("updatedOnDate").getTime())));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return u;
    }
    
    public boolean addNewUser(User u) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareCall("INSERT INTO user (userName, password"
                    + ", displayName, email, photo, groupID, createdOnDate)"
                    + " VALUES(?, ?, ?, ?, ?, ?, ?)");
            stm.setString(1, u.getUserName());
            stm.setString(2, u.getPassword());
            stm.setString(3, u.getDisplayName());
            stm.setString(4, u.getEmail());
            stm.setString(5, u.getPhoto());
            stm.setInt(6, u.getGroupID());
            stm.setString(7, u.getCreatedOnDate());

            if (stm.executeUpdate() > 0) {
                kq = true;
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, null);
        }
        return kq;
    }

    public boolean updateUser(User u) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareCall("UPDATE user SET userName=?, password=?"
                    + ", displayName=?, email=?, photo=?, groupID=?, updatedOnDate=?"
                    + " WHERE userID=?");
            stm.setString(1, u.getUserName());
            stm.setString(2, u.getPassword());
            stm.setString(3, u.getDisplayName());
            stm.setString(4, u.getEmail());
            stm.setString(5, u.getPhoto());
            stm.setInt(6, u.getGroupID());
            stm.setString(7, u.getUpdatedOnDate());
            stm.setInt(8, u.getUserID());

            if (stm.executeUpdate() > 0) {
                kq = true;
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, null);
        }
        return kq;
    }
    
    public boolean deleteUser(int id) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareCall("DELETE FROM user WHERE userID=?");
            stm.setInt(1, id);

            if (stm.executeUpdate() > 0) {
                kq = true;
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, null);
        }
        return kq;
    }
    
    public User login(String userName, String password) {
        User u = null;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareCall("SELECT * FROM user WHERE userName=? AND password=?");
            stm.setString(1, userName);
            stm.setString(1, password);
            rs = stm.executeQuery();

            if (rs.next()) {
                u = new User();
                u.setUserID(rs.getInt("userID"));
                u.setUserName(rs.getString("userName"));
                u.setPassword(rs.getString("password"));
                u.setDisplayName(rs.getString("displayName"));
                u.setEmail(rs.getString("email"));
                u.setPhoto(rs.getString("photo"));
                u.setGroupID(rs.getInt("groupID"));

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                u.setCreatedOnDate(sdf.format(new Date(rs.getDate("createdOnDate").getTime())));
                u.setUpdatedOnDate(sdf.format(new Date(rs.getDate("updatedOnDate").getTime())));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return u;
    }    
}
