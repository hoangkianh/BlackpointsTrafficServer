package com.blackpoints.dao;

import com.blackpoints.classes.TempPOI;
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
public class TempPOIDAO {

    public List<TempPOI> getAllTempPOIs() {
        List<TempPOI> list = new ArrayList<TempPOI>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT id, name, description"
                    + ", AsText(geometry), rating, count"
                    + ", createdOnDate, createdByUserID, updatedOnDate, updatedByUserID FROM tempPoi");
            rs = stm.executeQuery();

            while (rs.next()) {
                TempPOI tp = new TempPOI();
                tp.setId(rs.getInt("id"));
                tp.setName(rs.getString("name"));
                tp.setDescription(rs.getString("description"));
                tp.setGeometry(rs.getString("geometry"));
                tp.setRating(rs.getDouble("rating"));
                tp.setCount(rs.getInt("count"));
                tp.setCreatedByUserID(rs.getInt("createdByUserID"));
                tp.setUpdatedByUserID(rs.getInt("updatedByUserID"));

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                java.sql.Date createdDateSQL = rs.getDate("createdOnDate");
                java.sql.Date updatedDateSQL = rs.getDate("updatedOnDate");
                if (createdDateSQL != null) {
                    tp.setCreatedOnDate(sdf.format(new Date(createdDateSQL.getTime())));
                }
                if (updatedDateSQL != null) {
                    tp.setUpdatedOnDate(sdf.format(new Date(updatedDateSQL.getTime())));
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
            stm = conn.prepareStatement("SELECT id, name, description"
                    + ", AsText(geometry), rating, count"
                    + ", createdOnDate, createdByUserID, updatedOnDate, updatedByUserID"
                    + " FROM tempPoi WHERE id=?");
            stm.setInt(1, id);
            rs = stm.executeQuery();

            if (rs.next()) {
                tp = new TempPOI();
                tp.setId(rs.getInt("id"));
                tp.setName(rs.getString("name"));
                tp.setDescription(rs.getString("description"));
                tp.setGeometry(rs.getString("geometry"));
                tp.setRating(rs.getDouble("rating"));
                tp.setCount(rs.getInt("count"));
                tp.setCreatedByUserID(rs.getInt("createdByUserID"));
                tp.setUpdatedByUserID(rs.getInt("updatedByUserID"));

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                java.sql.Date createdDateSQL = rs.getDate("createdOnDate");
                java.sql.Date updatedDateSQL = rs.getDate("updatedOnDate");
                if (createdDateSQL != null) {
                    tp.setCreatedOnDate(sdf.format(new Date(createdDateSQL.getTime())));
                }
                if (updatedDateSQL != null) {
                    tp.setUpdatedOnDate(sdf.format(new Date(updatedDateSQL.getTime())));
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return tp;
    }

    public boolean addNewPOI(TempPOI tp) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("INSERT INTO tempPoi (name, description"
                    + ", geometry, rating, count, createdOnDate, createdByUserID)"
                    + " VALUES(?, ?, ?, ?, ?, ?, ?)");
            stm.setString(1, tp.getName());
            stm.setString(2, tp.getDescription());
            stm.setString(3, tp.getGeometry());
            stm.setDouble(4, tp.getRating());
            stm.setInt(5, tp.getCount());
            stm.setString(6, tp.getCreatedOnDate());
            stm.setInt(7, tp.getCreatedByUserID());

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

    public boolean updatePOI(TempPOI p) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("UPDATE tempPoi SET name=?, description=?"
                    + ", geometry=?, rating=?, count=?, updatedOnDate=?, updatedByUserID=?"
                    + " WHERE id=?");
            stm.setString(1, p.getName());
            stm.setString(2, p.getDescription());
            stm.setString(3, p.getGeometry());
            stm.setDouble(4, p.getRating());
            stm.setDouble(5, p.getCount());
            stm.setString(6, p.getUpdatedOnDate());
            stm.setInt(7, p.getUpdatedByUserID());
            stm.setInt(8, p.getId());

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
}
