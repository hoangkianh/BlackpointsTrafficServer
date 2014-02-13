package com.blackpoints.dao;

import com.blackpoints.classes.POI;
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
public class POIDAO {

    public List<POI> getAllPOIs(boolean getAllFlag) {
        List<POI> list = new ArrayList<POI>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        String query = "SELECT id, name, address, city, district, description, image"
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
                p.setCity(rs.getInt("city"));
                p.setDistrict(rs.getInt("district"));
                p.setDescription(rs.getString("description"));
                p.setImage(rs.getString("image"));
                p.setGeometry(rs.getString("geometry"));
                p.setCategoryID(rs.getInt("categoryID"));
                p.setRating(rs.getInt("rating"));
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
            stm = conn.prepareStatement("SELECT id, name, address, city, district, description, image"
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
                p.setCity(rs.getInt("city"));
                p.setDistrict(rs.getInt("district"));
                p.setDescription(rs.getString("description"));
                p.setImage(rs.getString("image"));
                p.setGeometry(rs.getString("geometry"));
                p.setCategoryID(rs.getInt("categoryID"));
                p.setRating(rs.getInt("rating"));
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
            stm = conn.prepareStatement("INSERT INTO poi (name, address, city, district, description"
                    + ", image, geometry, categoryID, rating, bbox, geoJson"
                    + ", isDeleted, createdOnDate, createdByUserID)"
                    + " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            stm.setString(1, p.getName());
            stm.setString(2, p.getAddress());
            stm.setInt(3, p.getCity());
            stm.setInt(4, p.getDistrict());
            stm.setString(5, p.getDescription());
            stm.setString(6, p.getImage());
            stm.setString(7, p.getGeometry());
            stm.setInt(8, p.getCategoryID());
            stm.setInt(9, p.getRating());
            stm.setString(10, p.getBbox());
            stm.setString(11, p.getGeoJson());
            stm.setBoolean(12, p.isDeleted());
            stm.setString(13, p.getCreatedOnDate());
            stm.setInt(14, p.getCreatedByUserID());

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
            stm = conn.prepareStatement("UPDATE poi SET name=?, address=?, city=?, district=?, description=?"
                    + ", image=?, geometry=?, categoryID=?, rating=?, bbox=?, geoJson=?"
                    + ", isDeleted=?, updatedOnDate=?, updatedByUserID=?"
                    + " WHERE id=?");
            stm.setString(1, p.getName());
            stm.setString(2, p.getAddress());
            stm.setInt(3, p.getCity());
            stm.setInt(4, p.getDistrict());
            stm.setString(3, p.getDescription());
            stm.setString(4, p.getImage());
            stm.setString(5, p.getGeometry());
            stm.setInt(6, p.getCategoryID());
            stm.setInt(7, p.getRating());
            stm.setString(8, p.getBbox());
            stm.setString(9, p.getGeoJson());
            stm.setBoolean(10, p.isDeleted());
            stm.setString(11, p.getUpdatedOnDate());
            stm.setInt(12, p.getUpdatedByUserID());
            stm.setInt(13, p.getId());

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
    
    public int countPOI() {
        int count = 0;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT COUNT(*) AS count FROM poi");
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

    public List<POI> getAllPOIsInDistrict(int city, int district) {
        List<POI> list = new ArrayList<POI>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        String query = "SELECT id, name, address, city, district, description, image"
                + ", AsText(geometry) AS geometry, categoryID, rating, bbox, geoJson"
                + ", createdOnDate, createdByUserID, updatedOnDate, updatedByUserID"
                + ", isDeleted, deletedOnDate, deletedByUserID, restoreOnDate, restoreByUserID"
                + " FROM poi WHERE city=? AND district=?";
        try {
            stm = conn.prepareStatement(query);
            stm.setInt(1, city);
            stm.setInt(2, district);
            rs = stm.executeQuery();

            while (rs.next()) {
                POI p = new POI();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setAddress(rs.getString("address"));
                p.setCity(rs.getInt("city"));
                p.setDistrict(rs.getInt("district"));
                p.setDescription(rs.getString("description"));
                p.setImage(rs.getString("image"));
                p.setGeometry(rs.getString("geometry"));
                p.setCategoryID(rs.getInt("categoryID"));
                p.setRating(rs.getInt("rating"));
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
}
