package com.blackpoints.util;

import com.blackpoints.classes.GeoLocation;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author hka
 */
public class GeoUtil {

    /**
     * Convert a geometry string to latitude & longitude
     *
     * @param geoString
     * @return array with first element is latitude, second element is longitude
     */
    public static List<GeoLocation> toLatLng(String geoString) {
        List<GeoLocation> geoList = new ArrayList<GeoLocation>();
        List<Double> coordinatesList = new ArrayList<Double>();

        Matcher m = Pattern.compile("\\([^\\(\\)]+\\)").matcher(geoString);

        while (m.find()) {
            Matcher m2 = Pattern.compile("-?\\d+\\.?\\d*").matcher(m.group());

            while (m2.find()) {
                coordinatesList.add(Double.parseDouble(m2.group()));
            }
        }

        int i;
        for (i = 0; i < coordinatesList.size(); i += 2) {
            GeoLocation gl = new GeoLocation();
            gl.setLng(coordinatesList.get(i));
            gl.setLat(coordinatesList.get(i + 1));

            geoList.add(gl);
        }
        return geoList;
    }

    /**
     * Caculate distance from geo1 to geo2
     *
     * @param geo1 GeoLocation1
     * @param geo2 GeoLocation2
     * @return
     */
    public static double caculateDistance(GeoLocation geo1, GeoLocation geo2) {

        double radLat1 = Math.toRadians(geo1.getLat()); // latitude of geo1 inradian
        double radLng1 = Math.toRadians(geo1.getLng()); // longitude of geo1 inradian
        double radLat2 = Math.toRadians(geo2.getLat()); // latitude of geo2 inradian
        double radLng2 = Math.toRadians(geo2.getLng()); // longitude of geo2 inradian
        
        double distance
                = Math.acos(
                        Math.sin(radLat1) * Math.sin(radLat2)
                        + Math.cos(radLat1) * Math.cos(radLat2) * Math.cos(radLng2 - radLng1)
                ) * 6371000;
        return distance;
    }
}
