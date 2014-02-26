package com.blackpoints.dao;

import com.blackpoints.classes.District;
import com.blackpoints.utils.DBUtil;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author HKA
 */
public class DistrictDAO implements Serializable {

    public List<District> getAllDistricts() {
        List<District> list = new ArrayList<District>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT * FROM district");
            rs = stm.executeQuery();

            while (rs.next()) {
                District d = new District();
                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setCity(rs.getInt("city"));

                list.add(d);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return list;
    }

    public List<District> getAllDistrictsInCity(int city) {
        List<District> list = new ArrayList<District>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT * FROM district WHERE city=?");
            stm.setInt(1, city);
            rs = stm.executeQuery();

            while (rs.next()) {
                District d = new District();
                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setCity(rs.getInt("city"));

                list.add(d);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return list;
    }

    public District getDistrictByID(int id) {
        District d = null;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT * FROM district WHERE id = ?");
            stm.setInt(1, id);
            rs = stm.executeQuery();

            if (rs.next()) {
                d = new District();
                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setCity(rs.getInt("city"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return d;
    }

    public District getDistrictByName(String name, int cityID) {
        District d = null;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT * FROM district WHERE name LIKE ? AND city = ?");
            stm.setString(1, "%" + name + "%");
            stm.setInt(2, cityID);
            rs = stm.executeQuery();

            if (rs.next()) {
                d = new District();
                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setCity(rs.getInt("city"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return d;
    }
}
