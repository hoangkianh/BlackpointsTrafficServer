package com.blackpoints.dao;

import com.blackpoints.classes.UserGroup;
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
public class UserGroupDAO {
    
public List<UserGroup> getAllUserGroups() {
        List<UserGroup> list = new ArrayList<UserGroup>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareCall("SELECT * FROM userGroup");
            rs = stm.executeQuery();

            while (rs.next()) {
                UserGroup ug = new UserGroup();
                ug.setUserGroupID(rs.getInt("userGroupID"));
                ug.setName(rs.getString("name"));
                ug.setLevel(rs.getInt("level"));
                ug.setCreatedByUserID(rs.getInt("createdByUserID"));
                ug.setUpdatedByUserID(rs.getInt("updatedByUserID"));                

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                ug.setCreatedOnDate(sdf.format(new Date(rs.getDate("createdOnDate").getTime())));
                ug.setUpdatedOnDate(sdf.format(new Date(rs.getDate("updatedOnDate").getTime())));

                list.add(ug);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return list;
    }

    public UserGroup getUserGroupByID(int id) {
        UserGroup ug = null;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareCall("SELECT * FROM userGroup WHERE userGroupID=?");
            stm.setInt(1, id);
            rs = stm.executeQuery();

            if (rs.next()) {
                ug = new UserGroup();
                ug.setUserGroupID(rs.getInt("userGroupID"));
                ug.setName(rs.getString("name"));
                ug.setLevel(rs.getInt("level"));
                ug.setCreatedByUserID(rs.getInt("createdByUserID"));
                ug.setUpdatedByUserID(rs.getInt("updatedByUserID"));

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                ug.setCreatedOnDate(sdf.format(new Date(rs.getDate("createdOnDate").getTime())));
                ug.setUpdatedOnDate(sdf.format(new Date(rs.getDate("updatedOnDate").getTime())));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return ug;
    }

    public boolean addNewUserGroup (UserGroup ug) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareCall("INSERT INTO userGroup (name, level, createdOnDate, createdByUserID)"
                    + " VALUES(?, ?, ?, ?)");
            stm.setString(1, ug.getName());
            stm.setInt(2, ug.getLevel());
            stm.setString(3, ug.getCreatedOnDate());
            stm.setInt(4, ug.getCreatedByUserID());

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

    public boolean updateUserGrop (UserGroup ug) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareCall("UPDATE userGroup SET name=?, level=?"
                    + ", updatedByUserID=?, updatedOnDate=? WHERE userGroupID=?");
            stm.setString(1, ug.getName());
            stm.setInt(2, ug.getLevel());
            stm.setInt(3, ug.getUpdatedByUserID());
            stm.setString(4, ug.getUpdatedOnDate());
            stm.setInt(5, ug.getUserGroupID());

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
    
    public boolean deleteUserGroup (int id) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareCall("DELETE FROM userGroup WHERE userGroupID=?");
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
}
