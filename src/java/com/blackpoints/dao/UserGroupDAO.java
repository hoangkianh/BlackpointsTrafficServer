package com.blackpoints.dao;

import com.blackpoints.classes.UserGroup;
import com.blackpoints.utils.DBUtil;
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
            stm = conn.prepareStatement("SELECT * FROM userGroup");
            rs = stm.executeQuery();

            while (rs.next()) {
                UserGroup ug = new UserGroup();
                ug.setUserGroupID(rs.getInt("userGroupID"));
                ug.setName(rs.getString("name"));
                ug.setLevel(rs.getInt("level"));
                ug.setDescription(rs.getString("description"));
                ug.setCreatedByUserID(rs.getInt("createdByUserID"));
                ug.setUpdatedByUserID(rs.getInt("updatedByUserID"));                

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                java.sql.Date createdDateSQL = rs.getDate("createdOnDate");
                java.sql.Date updatedDateSQL = rs.getDate("updatedOnDate");
                if (createdDateSQL != null) {
                    ug.setCreatedOnDate(sdf.format(new Date(createdDateSQL.getTime())));
                }
                if (updatedDateSQL != null) {
                    ug.setUpdatedOnDate(sdf.format(new Date(updatedDateSQL.getTime())));
                }

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
            stm = conn.prepareStatement("SELECT * FROM userGroup WHERE userGroupID=?");
            stm.setInt(1, id);
            rs = stm.executeQuery();

            if (rs.next()) {
                ug = new UserGroup();
                ug.setUserGroupID(rs.getInt("userGroupID"));
                ug.setName(rs.getString("name"));
                ug.setLevel(rs.getInt("level"));
                ug.setDescription(rs.getString("description"));
                ug.setCreatedByUserID(rs.getInt("createdByUserID"));
                ug.setUpdatedByUserID(rs.getInt("updatedByUserID"));

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                java.sql.Date createdDateSQL = rs.getDate("createdOnDate");
                java.sql.Date updatedDateSQL = rs.getDate("updatedOnDate");
                if (createdDateSQL != null) {
                    ug.setCreatedOnDate(sdf.format(new Date(createdDateSQL.getTime())));
                }
                if (updatedDateSQL != null) {
                    ug.setUpdatedOnDate(sdf.format(new Date(updatedDateSQL.getTime())));
                }
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
            stm = conn.prepareStatement("INSERT INTO userGroup (name, level, description, createdOnDate, createdByUserID)"
                    + " VALUES(?, ?, ?, ?, ?)");
            stm.setString(1, ug.getName());
            stm.setInt(2, ug.getLevel());
            stm.setString(3, ug.getDescription());
            stm.setString(4, ug.getCreatedOnDate());
            stm.setInt(5, ug.getCreatedByUserID());

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
            stm = conn.prepareStatement("UPDATE userGroup SET name=?, level=?, description=?"
                    + ", updatedByUserID=?, updatedOnDate=? WHERE userGroupID=?");
            stm.setString(1, ug.getName());
            stm.setInt(2, ug.getLevel());
            stm.setString(3, ug.getDescription());
            stm.setInt(4, ug.getUpdatedByUserID());
            stm.setString(5, ug.getUpdatedOnDate());
            stm.setInt(6, ug.getUserGroupID());

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
            stm = conn.prepareStatement("DELETE FROM userGroup WHERE userGroupID=?");
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
