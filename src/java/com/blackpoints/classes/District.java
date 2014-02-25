package com.blackpoints.classes;

import java.io.Serializable;

/**
 *
 * @author HKA
 */
public class District implements Serializable {
    private int id;
    private String name;
    private int city;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCity() {
        return city;
    }

    public void setCity(int city) {
        this.city = city;
    }
}
