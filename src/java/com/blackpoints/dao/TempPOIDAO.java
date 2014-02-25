package com.blackpoints.dao;

import com.blackpoints.classes.TempPOI;
import com.blackpoints.utils.DBUtil;
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
public class TempPOIDAO {

    public List<TempPOI> getAllTempPOIs() {
        List<TempPOI> list = new ArrayList<TempPOI>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT id, name, address, city, district, description"
                    + ", categoryID, rating, createdOnDate, createdByUserID, updatedOnDate, updatedByUserID FROM tempPoi");
            rs = stm.executeQuery();

            while (rs.next()) {
                TempPOI tp = new TempPOI();
                tp.setId(rs.getInt("id"));
                tp.setName(rs.getString("name"));
                tp.setAddress(rs.getString("address"));
                tp.setCity(rs.getInt("city"));
                tp.setDistrict(rs.getInt("district"));
                tp.setDescription(rs.getString("description"));
                tp.setCategoryID(rs.getInt("categoryID"));
                tp.setRating(rs.getDouble("rating"));
                tp.setCreatedByUserID(rs.getInt("createdByUserID"));
                tp.setUpdatedByUserID(rs.getInt("updatedByUserID"));

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                Timestamp createdTimeStamp = rs.getTimestamp("createdOnDate");
                Timestamp updatedTimeStamp = rs.getTimestamp("updatedOnDate");
                if (createdTimeStamp != null) {
                    tp.setCreatedOnDate(sdf.format(new Date(createdTimeStamp.getTime())));
                }
                if (updatedTimeStamp != null) {
                    tp.setUpdatedOnDate(sdf.format(new Date(updatedTimeStamp.getTime())));
                }
                
                list.add(tp);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return list;
    }

    public TempPOI getTempPOIByID(int id) {
        TempPOI tp = null;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT id, name, address, city, district, description"
                    + ", categoryID, rating, createdOnDate, createdByUserID, updatedOnDate, updatedByUserID"
                    + " FROM tempPoi WHERE id=?");
            stm.setInt(1, id);
            rs = stm.executeQuery();

            if (rs.next()) {
                tp = new TempPOI();
                tp.setId(rs.getInt("id"));
                tp.setName(rs.getString("name"));
                tp.setAddress(rs.getString("address"));
                tp.setCity(rs.getInt("city"));
                tp.setDistrict(rs.getInt("district"));
                tp.setDescription(rs.getString("description"));
                tp.setCategoryID(rs.getInt("categoryID"));
                tp.setRating(rs.getDouble("rating"));
                tp.setCreatedByUserID(rs.getInt("createdByUserID"));
                tp.setUpdatedByUserID(rs.getInt("updatedByUserID"));

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                Timestamp createdTimeStamp = rs.getTimestamp("createdOnDate");
                Timestamp updatedTimeStamp = rs.getTimestamp("updatedOnDate");
                if (createdTimeStamp != null) {
                    tp.setCreatedOnDate(sdf.format(new Date(createdTimeStamp.getTime())));
                }
                if (updatedTimeStamp != null) {
                    tp.setUpdatedOnDate(sdf.format(new Date(updatedTimeStamp.getTime())));
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return tp;
    }

    public boolean addNewTempPOI(TempPOI tp) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("INSERT INTO tempPoi (name, address, city, district, description"
                    + ", categoryID, rating, createdOnDate, createdByUserID)"
                    + " VALUES(?, ?, ?, ?, ?, ?, ?, NOW(), ?)");
            stm.setString(1, tp.getName());
            stm.setString(2, tp.getAddress());
            stm.setInt(3, tp.getCity());
            stm.setInt(4, tp.getDistrict());
            stm.setString(5, tp.getDescription());
            stm.setInt(6, tp.getCategoryID());
            stm.setDouble(7, tp.getRating());
            stm.setInt(8, tp.getCreatedByUserID());

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

    public boolean updatePOI(TempPOI tp) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("UPDATE tempPoi SET name=?, address=?, city=?, district=?, description=?"
                    + ", categoryID=?, rating=?, updatedOnDate=NOW(), updatedByUserID=?"
                    + " WHERE id=?");
            stm.setString(1, tp.getName());
            stm.setString(2, tp.getAddress());
            stm.setInt(3, tp.getCity());
            stm.setInt(4, tp.getDistrict());
            stm.setString(5, tp.getDescription());
            stm.setInt(6, tp.getCategoryID());
            stm.setDouble(7, tp.getRating());
            stm.setInt(8, tp.getUpdatedByUserID());
            stm.setInt(9, tp.getId());

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

    public boolean deletePOI(int id) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("DELETE FROM tempPoi WHERE id=?");
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
    
    public int countTempPOI() {
        int count = 0;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT COUNT(*) AS count FROM temppoi");
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
    
    public int countNewTempPOI() {
        int count = 0;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT COUNT(*) AS count FROM temppoi WHERE DATE( createdOnDate ) = CURDATE()");
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
