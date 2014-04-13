package com.blackpoints.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import org.apache.struts.action.Action;

/**
 *
 * @author hka
 */
public class DBUtil extends Action {

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            InitialContext ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup("java:comp/env/blackpointstraffic_db");
            conn = ds.getConnection();
        } catch (ClassNotFoundException ex) {
            System.out.println(ex.getMessage());
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        } catch (NamingException ex) {
            System.out.println(ex.getMessage());
        }

        return conn;
    }

    public static void closeAll(Connection conn, PreparedStatement stm, ResultSet rs) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
            }
        }
        if (stm != null) {
            try {
                stm.close();
            } catch (SQLException ex) {
                System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
            }
        }
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException ex) {
                System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
            }
        }
    }
}
