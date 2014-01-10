package com.blackpoints.dao;

import com.blackpoints.classes.POIProperty;
import com.blackpoints.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hka
 */
public class POIPropertyDAO {

    public List<POIProperty> getAllProperties() {
        List<POIProperty> list = new ArrayList<POIProperty>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT * FROM property");
            rs = stm.executeQuery();

            while (rs.next()) {
                POIProperty p = new POIProperty();
                p.setPoiID(rs.getInt("poiID"));
                p.setKey(rs.getString("key"));
                p.setValue(rs.getString("value"));

                list.add(p);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return list;
    }

    public POIProperty getProperty(int id, String key) {
        POIProperty p = null;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT value FROM property WHERE poiID=? AND key=?");
            stm.setInt(1, id);
            stm.setString(2, key);
            rs = stm.executeQuery();

            if (rs.next()) {
                p = new POIProperty();
                p.setPoiID(id);
                p.setKey(key);
                p.setValue(rs.getString("value"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return p;
    }

    public boolean addNewCategory(POIProperty p) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("INSERT INTO property (poiID, key, value) VALUES (? ,?, ?)");
            stm.setInt(1, p.getPoiID());
            stm.setString(2, p.getKey());
            stm.setString(2, p.getValue());

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

    public boolean updateCategory(POIProperty p) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("UPDATE property SET value=? WHERE poiID=? AND key=?");
            stm.setString(1, p.getValue());
            stm.setInt(2, p.getPoiID());
            stm.setString(3, p.getKey());

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

    public boolean deleteCategory(int PoiID, String key) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("DELETE FROM property WHERE poiID=? AND key=?");
            stm.setInt(1, PoiID);
            stm.setString(1, key);

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
