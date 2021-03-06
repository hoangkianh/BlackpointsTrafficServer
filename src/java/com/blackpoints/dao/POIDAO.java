package com.blackpoints.dao;

import com.blackpoints.classes.POI;
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
import java.util.Map;
import java.util.TreeMap;

/**
 *
 * @author hka
 */
public class POIDAO implements Serializable {

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

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                Timestamp lastLoginTimeStamp = rs.getTimestamp("createdOnDate");
                Timestamp updatedDateTimeStamp = rs.getTimestamp("updatedOnDate");
                Timestamp deletedDateTimeStamp = rs.getTimestamp("deletedOnDate");
                Timestamp restoreDateTimeStamp = rs.getTimestamp("restoreOnDate");
                if (lastLoginTimeStamp != null) {
                    p.setCreatedOnDate(sdf.format(new Date(lastLoginTimeStamp.getTime())));
                }
                if (updatedDateTimeStamp != null) {
                    p.setUpdatedOnDate(sdf.format(new Date(updatedDateTimeStamp.getTime())));
                }
                if (deletedDateTimeStamp != null) {
                    p.setDeletedOnDate(sdf.format(new Date(deletedDateTimeStamp.getTime())));
                }
                if (restoreDateTimeStamp != null) {
                    p.setRestoreOnDate(sdf.format(new Date(restoreDateTimeStamp.getTime())));
                }

                list.add(p);
            }
        } catch (SQLException ex) {
            System.err.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
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

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                Timestamp lastLoginTimeStamp = rs.getTimestamp("createdOnDate");
                Timestamp updatedDateTimeStamp = rs.getTimestamp("updatedOnDate");
                Timestamp deletedDateTimeStamp = rs.getTimestamp("deletedOnDate");
                Timestamp restoreDateTimeStamp = rs.getTimestamp("restoreOnDate");
                if (lastLoginTimeStamp != null) {
                    p.setCreatedOnDate(sdf.format(new Date(lastLoginTimeStamp.getTime())));
                }
                if (updatedDateTimeStamp != null) {
                    p.setUpdatedOnDate(sdf.format(new Date(updatedDateTimeStamp.getTime())));
                }
                if (deletedDateTimeStamp != null) {
                    p.setDeletedOnDate(sdf.format(new Date(deletedDateTimeStamp.getTime())));
                }
                if (restoreDateTimeStamp != null) {
                    p.setRestoreOnDate(sdf.format(new Date(restoreDateTimeStamp.getTime())));
                }
            }
        } catch (SQLException ex) {
            System.err.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
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
                    + " VALUES(?, ?, ?, ?, ?, ?, GEOMFROMTEXT(?, 0), ?, ?, ?, ?, ?, NOW(), ?)");
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
            stm.setInt(13, p.getCreatedByUserID());

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

    public boolean updatePOI(POI p) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("UPDATE poi SET name=?, address=?, city=?, district=?, description=?"
                    + ", image=?, geometry=GEOMFROMTEXT(?, 0), categoryID=?, rating=?, bbox=?, geoJson=?"
                    + ", isDeleted=?, updatedOnDate=NOW(), updatedByUserID=?"
                    + " WHERE id=?");
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
            stm.setInt(13, p.getUpdatedByUserID());
            stm.setInt(14, p.getId());

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

    public boolean deletePOI(POI p) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("UPDATE poi SET isDeleted=True"
                    + ", deletedOnDate=NOW(), deletedByUserID=? WHERE id=?");
            stm.setInt(1, p.getDeletedByUserID());
            stm.setInt(2, p.getId());

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
    
    public boolean deletePermanentlyPOI(POI p) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("DELETE FROM poi WHERE id=?");
            stm.setInt(1, p.getId());

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

    public boolean restorePOI(POI p) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("UPDATE poi SET isDeleted=False"
                    + ", restoreOnDate=NOW(), restoreByUserID=? WHERE id=?");
            stm.setInt(1, p.getRestoreByUserID());
            stm.setInt(2, p.getId());

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

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                Timestamp lastLoginTimeStamp = rs.getTimestamp("createdOnDate");
                Timestamp updatedDateTimeStamp = rs.getTimestamp("updatedOnDate");
                Timestamp deletedDateTimeStamp = rs.getTimestamp("deletedOnDate");
                Timestamp restoreDateTimeStamp = rs.getTimestamp("restoreOnDate");
                if (lastLoginTimeStamp != null) {
                    p.setCreatedOnDate(sdf.format(new Date(lastLoginTimeStamp.getTime())));
                }
                if (updatedDateTimeStamp != null) {
                    p.setUpdatedOnDate(sdf.format(new Date(updatedDateTimeStamp.getTime())));
                }
                if (deletedDateTimeStamp != null) {
                    p.setDeletedOnDate(sdf.format(new Date(deletedDateTimeStamp.getTime())));
                }
                if (restoreDateTimeStamp != null) {
                    p.setRestoreOnDate(sdf.format(new Date(restoreDateTimeStamp.getTime())));
                }

                list.add(p);
            }
        } catch (SQLException ex) {
            System.err.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return list;
    }
    
    public List<POI> getAllPOIsInCity(int city) {
        List<POI> list = new ArrayList<POI>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        String query = "SELECT id, name, address, city, district, description, image"
                + ", AsText(geometry) AS geometry, categoryID, rating, bbox, geoJson"
                + ", createdOnDate, createdByUserID, updatedOnDate, updatedByUserID"
                + ", isDeleted, deletedOnDate, deletedByUserID, restoreOnDate, restoreByUserID"
                + " FROM poi WHERE city=?";
        try {
            stm = conn.prepareStatement(query);
            stm.setInt(1, city);
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

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                Timestamp lastLoginTimeStamp = rs.getTimestamp("createdOnDate");
                Timestamp updatedDateTimeStamp = rs.getTimestamp("updatedOnDate");
                Timestamp deletedDateTimeStamp = rs.getTimestamp("deletedOnDate");
                Timestamp restoreDateTimeStamp = rs.getTimestamp("restoreOnDate");
                if (lastLoginTimeStamp != null) {
                    p.setCreatedOnDate(sdf.format(new Date(lastLoginTimeStamp.getTime())));
                }
                if (updatedDateTimeStamp != null) {
                    p.setUpdatedOnDate(sdf.format(new Date(updatedDateTimeStamp.getTime())));
                }
                if (deletedDateTimeStamp != null) {
                    p.setDeletedOnDate(sdf.format(new Date(deletedDateTimeStamp.getTime())));
                }
                if (restoreDateTimeStamp != null) {
                    p.setRestoreOnDate(sdf.format(new Date(restoreDateTimeStamp.getTime())));
                }

                list.add(p);
            }
        } catch (SQLException ex) {
            System.err.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return list;
    }
    
    public List<POI> getAllPOIsInDistrict(int district) {
        List<POI> list = new ArrayList<POI>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        String query = "SELECT id, name, address, city, district, description, image"
                + ", AsText(geometry) AS geometry, categoryID, rating, bbox, geoJson"
                + ", createdOnDate, createdByUserID, updatedOnDate, updatedByUserID"
                + ", isDeleted, deletedOnDate, deletedByUserID, restoreOnDate, restoreByUserID"
                + " FROM poi WHERE district=?";
        try {
            stm = conn.prepareStatement(query);
            stm.setInt(1, district);
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

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                Timestamp lastLoginTimeStamp = rs.getTimestamp("createdOnDate");
                Timestamp updatedDateTimeStamp = rs.getTimestamp("updatedOnDate");
                Timestamp deletedDateTimeStamp = rs.getTimestamp("deletedOnDate");
                Timestamp restoreDateTimeStamp = rs.getTimestamp("restoreOnDate");
                if (lastLoginTimeStamp != null) {
                    p.setCreatedOnDate(sdf.format(new Date(lastLoginTimeStamp.getTime())));
                }
                if (updatedDateTimeStamp != null) {
                    p.setUpdatedOnDate(sdf.format(new Date(updatedDateTimeStamp.getTime())));
                }
                if (deletedDateTimeStamp != null) {
                    p.setDeletedOnDate(sdf.format(new Date(deletedDateTimeStamp.getTime())));
                }
                if (restoreDateTimeStamp != null) {
                    p.setRestoreOnDate(sdf.format(new Date(restoreDateTimeStamp.getTime())));
                }

                list.add(p);
            }
        } catch (SQLException ex) {
            System.err.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return list;
    }
    
    public List<POI> getAllPOIByCategory(int categoryID) {
        List<POI> list = new ArrayList<POI>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        String query = "SELECT id, name, address, city, district, description, image"
                + ", AsText(geometry) AS geometry, categoryID, rating, bbox, geoJson"
                + ", createdOnDate, createdByUserID, updatedOnDate, updatedByUserID"
                + ", isDeleted, deletedOnDate, deletedByUserID, restoreOnDate, restoreByUserID"
                + " FROM poi WHERE categoryID=?";
        try {
            stm = conn.prepareStatement(query);
            stm.setInt(1, categoryID);
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

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                Timestamp lastLoginTimeStamp = rs.getTimestamp("createdOnDate");
                Timestamp updatedDateTimeStamp = rs.getTimestamp("updatedOnDate");
                Timestamp deletedDateTimeStamp = rs.getTimestamp("deletedOnDate");
                Timestamp restoreDateTimeStamp = rs.getTimestamp("restoreOnDate");
                if (lastLoginTimeStamp != null) {
                    p.setCreatedOnDate(sdf.format(new Date(lastLoginTimeStamp.getTime())));
                }
                if (updatedDateTimeStamp != null) {
                    p.setUpdatedOnDate(sdf.format(new Date(updatedDateTimeStamp.getTime())));
                }
                if (deletedDateTimeStamp != null) {
                    p.setDeletedOnDate(sdf.format(new Date(deletedDateTimeStamp.getTime())));
                }
                if (restoreDateTimeStamp != null) {
                    p.setRestoreOnDate(sdf.format(new Date(restoreDateTimeStamp.getTime())));
                }

                list.add(p);
            }
        } catch (SQLException ex) {
            System.err.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return list;
    }

    public int countPOI(boolean isDeleted) {
        int count = 0;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT COUNT(*) AS count FROM poi WHERE isDeleted=?");
            stm.setBoolean(1, isDeleted);
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

    public int countNewPOI(boolean isDeleted) {
        int count = 0;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT COUNT(*) AS count FROM poi WHERE DATE( createdOnDate ) = CURDATE() AND isDeleted=?");
            stm.setBoolean(1, isDeleted);
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

    public Map<String, Integer> countPOIByCity() {
        Map<String, Integer> map = new TreeMap<String, Integer>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareCall("{CALL countPOIByCity ()}");
            rs = stm.executeQuery();
            while (rs.next()) {
                String city = rs.getString("city");
                int count = rs.getInt("count");
                map.put(city, count);
            }
        } catch (SQLException ex) {
            System.err.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return map;
    }

    public Map<String, Map<String, Integer>> countPOIByDistrict() {
        Map<String, Map<String, Integer>> map = new TreeMap<String, Map<String, Integer>>();
        Map<String, Integer> subMap = null;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareCall("{CALL countPOIByDistrict ( )}");
            rs = stm.executeQuery();
            while (rs.next()) {
                String city = rs.getString("city");
                String district = rs.getString("district");
                int count = rs.getInt("count");

                if (!map.containsKey(city)) {
                    subMap = new TreeMap<String, Integer>();
                    map.put(city, subMap);
                } else {
                    subMap = map.get(city);
                }
                subMap.put(district, count);
            }
        } catch (SQLException ex) {
            System.err.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return map;
    }
}
