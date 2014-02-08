package com.blackpoints.dao;

import com.blackpoints.classes.Category;
import com.blackpoints.utils.DBUtil;
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
public class CategoryDAO {

    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<Category>();
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT * FROM category");
            rs = stm.executeQuery();

            while (rs.next()) {
                Category c = new Category();
                c.setCategoryID(rs.getInt("categoryID"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
                c.setImage(rs.getString("image"));

                list.add(c);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return list;
    }

    public Category getCategoryById(int id) {
        Category c = null;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            stm = conn.prepareStatement("SELECT * FROM category WHERE categoryID=?");
            stm.setInt(1, id);
            rs = stm.executeQuery();

            if (rs.next()) {
                c = new Category();
                c.setCategoryID(rs.getInt("categoryID"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
                c.setImage(rs.getString("image"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getErrorCode() + ": " + ex.getSQLState() + ": " + ex.getMessage());
        } finally {
            DBUtil.closeAll(conn, stm, rs);
        }
        return c;
    }

    public boolean addNewCategory(Category c) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("INSERT INTO category (name, description, image) VALUES (? ,?, ?)");
            stm.setString(1, c.getName());
            stm.setString(2, c.getDescription());
            stm.setString(3, c.getImage());

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

    public boolean updateCategory(Category c) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("UPDATE category SET name=?, description=?, image=? WHERE categoryID=?");
            stm.setString(1, c.getName());
            stm.setString(2, c.getDescription());
            stm.setString(3, c.getImage());
            stm.setInt(4, c.getCategoryID());

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

    public boolean deleteCategory(int id) {
        boolean kq = false;
        Connection conn = DBUtil.getConnection();
        PreparedStatement stm = null;
        try {
            stm = conn.prepareStatement("DELETE FROM category WHERE categoryID=?");
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
