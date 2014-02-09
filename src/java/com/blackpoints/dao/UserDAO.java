package com.blackpoints.dao;

import com.blackpoints.classes.User;
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
public class UserDAO {

    public List<User> getAllUsers() {
        List<User> list = new ArrayList<User>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT * FROM user");
            rs = stm.executeQuery();

            while (rs.next()) {
                User u = new User();
                u.setUserID(rs.getInt("userID"));
                u.setUserName(rs.getString("userName"));
                u.setPassword(rs.getString("password"));
                u.setDisplayName(rs.getString("displayName"));
                u.setDescription(rs.getString("description"));
                u.setEmail(rs.getString("email"));
                u.setPhoto(rs.getString("photo"));
                u.setGroupID(rs.getInt("groupID"));
                u.setActivated(rs.getBoolean("isActivated"));
                u.setSalt(rs.getString("salt"));

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                java.sql.Date createdDateSQL = rs.getDate("createdOnDate");
                java.sql.Date activatedDateSQL = rs.getDate("activatedOnDate");
                java.sql.Date updatedDateSQL = rs.getDate("updatedOnDate");
                if (createdDateSQL != null) {
                    u.setCreatedOnDate(sdf.format(new Date(createdDateSQL.getTime())));
                }
                if (activatedDateSQL != null) {
                    u.setActivatedOnDate(sdf.format(new Date(activatedDateSQL.getTime())));
                }
                if (updatedDateSQL != null) {
                    u.setUpdatedOnDate(sdf.format(new Date(updatedDateSQL.getTime())));
                }

                list.add(u);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return list;
    }

    public User getUserByEmail(String email) {
        User u = null;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT * FROM user WHERE email=?");
            stm.setString(1, email);
            rs = stm.executeQuery();

            if (rs.next()) {
                u = new User();
                u.setUserID(rs.getInt("userID"));
                u.setUserName(rs.getString("userName"));
                u.setPassword(rs.getString("password"));
                u.setDisplayName(rs.getString("displayName"));
                u.setDescription(rs.getString("description"));
                u.setEmail(rs.getString("email"));
                u.setPhoto(rs.getString("photo"));
                u.setGroupID(rs.getInt("groupID"));
                u.setActivated(rs.getBoolean("isActivated"));
                u.setSalt(rs.getString("salt"));

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                java.sql.Date createdDateSQL = rs.getDate("createdOnDate");
                java.sql.Date activatedDateSQL = rs.getDate("activatedOnDate");
                java.sql.Date updatedDateSQL = rs.getDate("updatedOnDate");
                if (createdDateSQL != null) {
                    u.setCreatedOnDate(sdf.format(new Date(createdDateSQL.getTime())));
                }
                if (activatedDateSQL != null) {
                    u.setActivatedOnDate(sdf.format(new Date(activatedDateSQL.getTime())));
                }
                if (updatedDateSQL != null) {
                    u.setUpdatedOnDate(sdf.format(new Date(updatedDateSQL.getTime())));
                }
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
            stm = conn.prepareStatement("INSERT INTO user (userName, password, displayName"
                    + ", description, email, photo, groupID, isActivated, salt, createdOnDate)"
                    + " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())");
            stm.setString(1, u.getUserName());
            stm.setString(2, u.getPassword());
            stm.setString(3, u.getDisplayName());
            stm.setString(4, u.getDescription());
            stm.setString(5, u.getEmail());
            stm.setString(6, u.getPhoto());
            stm.setInt(7, u.getGroupID());
            stm.setBoolean(8, u.isActivated());
            stm.setString(9, u.getSalt());

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
            stm = conn.prepareStatement("UPDATE user SET userName=?, password=?, displayName=?"
                    + ", description=?, email=?, photo=?, groupID=?, salt=?, updatedOnDate=NOW()"
                    + " WHERE userID=?");
            stm.setString(1, u.getUserName());
            stm.setString(2, u.getPassword());
            stm.setString(3, u.getDisplayName());
            stm.setString(4, u.getDescription());
            stm.setString(5, u.getEmail());
            stm.setString(6, u.getPhoto());
            stm.setInt(7, u.getGroupID());
            stm.setString(8, u.getSalt());
            stm.setInt(9, u.getUserID());

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

    public boolean activateUser(String email) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;

        try {
            stm = conn.prepareStatement("UPDATE user SET isActivated=?, activatedOnDate=NOW() WHERE email=?");
            stm.setBoolean(1, true);
            stm.setString(2, email);

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
            stm = conn.prepareStatement("DELETE FROM user WHERE userID=?");
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

        String findUserQuery = "SELECT * FROM user WHERE userName=? AND password=?";
        String findEmailQuery = "SELECT * FROM user WHERE email=? AND password=?";
        String updateLoginDateQuery = "UPDATE user SET lastLogin=NOW() WHERE userID=?";

        try {
            conn.setAutoCommit(false);
            stm = conn.prepareStatement(findUserQuery);
            stm.setString(1, userName);
            stm.setString(2, password);
            rs = stm.executeQuery();

            if (!rs.next()) {
                // find user by email
                stm = conn.prepareStatement(findEmailQuery);
                stm.setString(1, userName);
                stm.setString(2, password);
                rs = stm.executeQuery();
            }

            rs.beforeFirst();

            if (rs.next()) {
                u = new User();
                u.setUserID(rs.getInt("userID"));
                u.setUserName(rs.getString("userName"));
                u.setPassword(rs.getString("password"));
                u.setDisplayName(rs.getString("displayName"));
                u.setDescription(rs.getString("description"));
                u.setEmail(rs.getString("email"));
                u.setPhoto(rs.getString("photo"));
                u.setGroupID(rs.getInt("groupID"));

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                java.sql.Date createdDateSQL = rs.getDate("createdOnDate");
                java.sql.Date updatedDateSQL = rs.getDate("updatedOnDate");
                if (createdDateSQL != null) {
                    u.setCreatedOnDate(sdf.format(new Date(createdDateSQL.getTime())));
                }
                if (updatedDateSQL != null) {
                    u.setUpdatedOnDate(sdf.format(new Date(updatedDateSQL.getTime())));
                }

                stm = conn.prepareStatement(updateLoginDateQuery);
                stm.setInt(1, u.getUserID());
                stm.executeUpdate();

                conn.commit();
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException ex) {
                System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
            }
            DBUtil.closeAll(conn, stm, rs);
        }
        return u;
    }

    public boolean emailIsExist(String email) {
        boolean isExist = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT email FROM user WHERE email = ?");
            stm.setString(1, email);
            rs = stm.executeQuery();

            isExist = rs.next();
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }

        return isExist;
    }

    public boolean userNameIsExist(String userName) {
        boolean isExist = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT userName FROM user WHERE userName = ?");
            stm.setString(1, userName);
            rs = stm.executeQuery();

            isExist = rs.next();
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }

        return isExist;
    }
    
    public int countUser() {
        int count = 0;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT COUNT(*) AS count FROM user");
            rs = stm.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return count;
    }
}
