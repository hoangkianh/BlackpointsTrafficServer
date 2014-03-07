package com.blackpoints.dao;

import com.blackpoints.classes.UserGroup;
import com.blackpoints.utils.DBUtil;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author hka
 */
public class UserGroupDAO implements Serializable {

    public List<UserGroup> getAllUserGroups() {
        List<UserGroup> list = new ArrayList<UserGroup>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT * FROM usergroup");
            rs = stm.executeQuery();

            while (rs.next()) {
                UserGroup ug = new UserGroup();
                ug.setUserGroupID(rs.getInt("userGroupID"));
                ug.setName(rs.getString("name"));
                ug.setLevel(rs.getInt("level"));
                ug.setDescription(rs.getString("description"));
                ug.setCreatedByUserID(rs.getInt("createdByUserID"));
                ug.setUpdatedByUserID(rs.getInt("updatedByUserID"));

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                Timestamp createdTimeStamp = rs.getTimestamp("createdOnDate");
                Timestamp updatedTimeStamp = rs.getTimestamp("updatedOnDate");
                if (createdTimeStamp != null) {
                    ug.setCreatedOnDate(sdf.format(new Date(createdTimeStamp.getTime())));
                }
                if (updatedTimeStamp != null) {
                    ug.setUpdatedOnDate(sdf.format(new Date(updatedTimeStamp.getTime())));
                }

                list.add(ug);
            }
        } catch (SQLException ex) {
            System.err.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return list;
    }
    
    public List<UserGroup> getUserGroups(boolean getNormalUserGroup) {
        List<UserGroup> list = new ArrayList<UserGroup>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        String query = "SELECT * FROM usergroup ";
        query += getNormalUserGroup ? "WHERE level=3" :  "WHERE level=1 OR level=2";
        try {
            stm = conn.prepareStatement(query);
            rs = stm.executeQuery();

            while (rs.next()) {
                UserGroup ug = new UserGroup();
                ug.setUserGroupID(rs.getInt("userGroupID"));
                ug.setName(rs.getString("name"));
                ug.setLevel(rs.getInt("level"));
                ug.setDescription(rs.getString("description"));
                ug.setCreatedByUserID(rs.getInt("createdByUserID"));
                ug.setUpdatedByUserID(rs.getInt("updatedByUserID"));

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                Timestamp createdTimeStamp = rs.getTimestamp("createdOnDate");
                Timestamp updatedTimeStamp = rs.getTimestamp("updatedOnDate");
                if (createdTimeStamp != null) {
                    ug.setCreatedOnDate(sdf.format(new Date(createdTimeStamp.getTime())));
                }
                if (updatedTimeStamp != null) {
                    ug.setUpdatedOnDate(sdf.format(new Date(updatedTimeStamp.getTime())));
                }

                list.add(ug);
            }
        } catch (SQLException ex) {
            System.err.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
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
            stm = conn.prepareStatement("SELECT * FROM usergroup WHERE userGroupID=?");
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

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                Timestamp createdTimeStamp = rs.getTimestamp("createdOnDate");
                Timestamp updatedTimeStamp = rs.getTimestamp("updatedOnDate");
                if (createdTimeStamp != null) {
                    ug.setCreatedOnDate(sdf.format(new Date(createdTimeStamp.getTime())));
                }
                if (updatedTimeStamp != null) {
                    ug.setUpdatedOnDate(sdf.format(new Date(updatedTimeStamp.getTime())));
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return ug;
    }

    public boolean addNewUserGroup(UserGroup ug) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("INSERT INTO usergroup (name, level, description, createdOnDate, createdByUserID)"
                    + " VALUES(?, ?, ?, NOW(), ?)");
            stm.setString(1, ug.getName());
            stm.setInt(2, ug.getLevel());
            stm.setString(3, ug.getDescription());
            stm.setInt(4, ug.getCreatedByUserID());

            if (stm.executeUpdate() > 0) {
                kq = true;
            }
        } catch (SQLException ex) {
            System.err.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, null);
        }
        return kq;
    }

    public boolean updateUserGroup(UserGroup ug) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("UPDATE usergroup SET name=?, level=?, description=?"
                    + ", updatedByUserID=?, updatedOnDate=NOW() WHERE userGroupID=?");
            stm.setString(1, ug.getName());
            stm.setInt(2, ug.getLevel());
            stm.setString(3, ug.getDescription());
            stm.setInt(4, ug.getUpdatedByUserID());
            stm.setInt(5, ug.getUserGroupID());

            if (stm.executeUpdate() > 0) {
                kq = true;
            }
        } catch (SQLException ex) {
            System.err.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, null);
        }
        return kq;
    }

    public boolean deleteUserGroup(int id) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("DELETE FROM usergroup WHERE userGroupID=?");
            stm.setInt(1, id);

            if (stm.executeUpdate() > 0) {
                kq = true;
            }
        } catch (SQLException ex) {
            System.err.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, null);
        }
        return kq;
    }

    public int countUserInGroup(int groupID) {
        int count = 0;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("{CALL countUserInGroup(?)}");
            stm.setInt(1, groupID);
            rs = stm.executeQuery();

            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException ex) {
            System.err.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return count;
    }
}
