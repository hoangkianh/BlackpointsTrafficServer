package com.blackpoints.dao;

import com.blackpoints.classes.POI;
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
public class POIDAO {

    public List<POI> getAllPOIs(boolean getAllFlag) {
        List<POI> list = new ArrayList<POI>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        String query = "SELECT id, name, address, description"
                    + ", AsText(geometry) AS geometry, categoryID, rating, bbox, geoJson"
                    + ", createdOnDate, createdByUserID, updatedOnDate, updatedByUserID"
                    + ", isDeleted, deletedOnDate, deletedByUserID, restoreOnDate, restoreByUserID"
                    + " FROM poi";
        if (!getAllFlag) {
            query += " WHERE isDeleted = False";
        }
        try {
            stm = conn.prepareStatement(query);
            rs = stm.executeQuery();

            while (rs.next()) {
                POI p = new POI();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setAddress(rs.getString("address"));
                p.setDescription(rs.getString("description"));
                p.setGeometry(rs.getString("geometry"));
                p.setCategoryID(rs.getInt("categoryID"));
                p.setRating(rs.getDouble("rating"));
                p.setBbox(rs.getString("bbox"));
                p.setGeoJson(rs.getString("geoJson"));
                p.setDeleted(rs.getBoolean("isDeleted"));
                p.setCreatedByUserID(rs.getInt("createdByUserID"));
                p.setUpdatedByUserID(rs.getInt("updatedByUserID"));
                p.setDeletedByUserID(rs.getInt("deletedByUserID"));
                p.setRestoreByUserID(rs.getInt("restoreByUserID"));

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                java.sql.Date createdDateSQL = rs.getDate("createdOnDate");
                java.sql.Date updatedDateSQL = rs.getDate("updatedOnDate");
                java.sql.Date deletedDateSQL = rs.getDate("deletedOnDate");
                java.sql.Date restoreDateSQL = rs.getDate("restoreOnDate");
                if (createdDateSQL != null) {
                    p.setCreatedOnDate(sdf.format(new Date(createdDateSQL.getTime())));
                }
                if (updatedDateSQL != null) {
                    p.setUpdatedOnDate(sdf.format(new Date(updatedDateSQL.getTime())));
                }
                if (deletedDateSQL != null) {
                    p.setDeletedOnDate(sdf.format(new Date(deletedDateSQL.getTime())));
                }
                if (restoreDateSQL != null) {
                    p.setRestoreOnDate(sdf.format(new Date(restoreDateSQL.getTime())));
                }

                list.add(p);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return list;
    }

    public POI getPOIByID(int id) {
        POI p = null;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT id, name, address, description"
                    + ", AsText(geometry) AS geometry, categoryID, rating, bbox, geoJson"
                    + ", createdOnDate, createdByUserID, updatedOnDate, updatedByUserID"
                    + ", isDeleted, deletedOnDate, deletedByUserID, restoreOnDate, restoreByUserID"
                    + " FROM poi WHERE id=?");
            stm.setInt(1, id);
            rs = stm.executeQuery();

            if (rs.next()) {
                p = new POI();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setAddress(rs.getString("address"));
                p.setDescription(rs.getString("description"));
                p.setGeometry(rs.getString("geometry"));
                p.setCategoryID(rs.getInt("categoryID"));
                p.setRating(rs.getDouble("rating"));
                p.setBbox(rs.getString("bbox"));
                p.setGeoJson(rs.getString("geoJson"));
                p.setDeleted(rs.getBoolean("isDeleted"));
                p.setCreatedByUserID(rs.getInt("createdByUserID"));
                p.setUpdatedByUserID(rs.getInt("updatedByUserID"));
                p.setDeletedByUserID(rs.getInt("deletedByUserID"));
                p.setRestoreByUserID(rs.getInt("restoreByUserID"));

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                java.sql.Date createdDateSQL = rs.getDate("createdOnDate");
                java.sql.Date updatedDateSQL = rs.getDate("updatedOnDate");
                java.sql.Date deletedDateSQL = rs.getDate("deletedOnDate");
                java.sql.Date restoreDateSQL = rs.getDate("restoreOnDate");
                if (createdDateSQL != null) {
                    p.setCreatedOnDate(sdf.format(new Date(createdDateSQL.getTime())));
                }
                if (updatedDateSQL != null) {
                    p.setUpdatedOnDate(sdf.format(new Date(updatedDateSQL.getTime())));
                }
                if (deletedDateSQL != null) {
                    p.setDeletedOnDate(sdf.format(new Date(deletedDateSQL.getTime())));
                }
                if (restoreDateSQL != null) {
                    p.setRestoreOnDate(sdf.format(new Date(restoreDateSQL.getTime())));
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return p;
    }

    public boolean addNewPOI(POI p) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("INSERT INTO poi (name, address, description"
                    + ", geometry, categoryID, rating, bbox, geoJson"
                    + ", isDeleted, createdOnDate, createdByUserID)"
                    + " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            stm.setString(1, p.getName());
            stm.setString(2, p.getAddress());
            stm.setString(3, p.getDescription());
            stm.setString(4, p.getGeometry());
            stm.setInt(5, p.getCategoryID());
            stm.setDouble(6, p.getRating());
            stm.setString(7, p.getBbox());
            stm.setString(8, p.getGeoJson());
            stm.setBoolean(9, p.isDeleted());
            stm.setString(10, p.getCreatedOnDate());
            stm.setInt(11, p.getCreatedByUserID());

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

    public boolean updatePOI(POI p) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("UPDATE poi SET name=?, address=?, description=?"
                    + ", geometry=?, categoryID=?, rating=?, bbox=?, geoJson=?"
                    + ", isDeleted=?, updatedOnDate=?, updatedByUserID=?"
                    + " WHERE id=?");
            stm.setString(1, p.getName());
            stm.setString(2, p.getAddress());
            stm.setString(3, p.getDescription());
            stm.setString(4, p.getGeometry());
            stm.setInt(5, p.getCategoryID());
            stm.setDouble(6, p.getRating());
            stm.setString(7, p.getBbox());
            stm.setString(8, p.getGeoJson());
            stm.setBoolean(9, p.isDeleted());
            stm.setString(10, p.getUpdatedOnDate());
            stm.setInt(11, p.getUpdatedByUserID());
            stm.setInt(12, p.getId());

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

    public boolean deletePOI(POI p) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("UPDATE poi SET isDeleted=True"
                    + ", deletedOnDate=?, deletedByUserID=? WHERE id=?");
            stm.setString(1, p.getDeletedOnDate());
            stm.setInt(2, p.getDeletedByUserID());
            stm.setInt(3, p.getId());

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

    public boolean restorePOI(POI p) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("UPDATE poi SET isDeleted=False"
                    + ", restoreOnDate=?, restoreByUserID=? WHERE id=?");
            stm.setString(1, p.getRestoreOnDate());
            stm.setInt(2, p.getRestoreByUserID());
            stm.setInt(3, p.getId());

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
