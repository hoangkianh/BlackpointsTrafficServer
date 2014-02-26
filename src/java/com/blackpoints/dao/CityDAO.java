package com.blackpoints.dao;

import com.blackpoints.classes.City;
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
public class CityDAO implements Serializable {

    public List<City> getAllCities() {
        List<City> list = new ArrayList<City>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT * FROM city");
            rs = stm.executeQuery();

            while (rs.next()) {
                City c = new City();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));

                list.add(c);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return list;
    }

    public City getCityByID(int id) {
        City c = null;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT * FROM city WHERE id = ?");
            stm.setInt(1, id);
            rs = stm.executeQuery();

            if (rs.next()) {
                c = new City();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return c;
    }
    
    public City getCityByName (String name) {
        City c = null;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT * FROM city WHERE name LIKE ?");
            stm.setString(1, "%" + name + "%" );
            rs = stm.executeQuery();
            
            if (rs.next()) {
                c = new City();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
}
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return c;
    }
}