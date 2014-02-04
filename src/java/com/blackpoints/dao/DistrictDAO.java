package com.blackpoints.dao;

import com.blackpoints.classes.District;
import com.blackpoints.util.DBUtil;
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
public class DistrictDAO {
     private List<District> getAllCities() {
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
    
    private District getCityByID (int id) {
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
}
