package com.blackpoints.classes;

/**
 *
 * @author hka
 */
public class GeoLocation {

    private double radLat;
    private double radLon;
    private double degLat;
    private double degLon;

    private static final double R = 6371.01; // Earth radius
    private static final double MIN_LAT = Math.toRadians(-90d); // -PI/2
    private static final double MAX_LAT = Math.toRadians(90d);  // PI/2
    private static final double MIN_LON = Math.toRadians(-180d); // -PI
    private static final double MAX_LON = Math.toRadians(180d); // PI

    public static GeoLocation fromDegress(double latitude, double longitude) {
        GeoLocation rs = new GeoLocation();
        rs.setRadLat(Math.toRadians(latitude));
        rs.setRadLon(Math.toRadians(longitude));
        rs.setDegLat(latitude);
        rs.setDegLon(longitude);
        rs.checkBounds();
        return rs;
    }

    public static GeoLocation fromRadians(double latitude, double longitude) {
        GeoLocation rs = new GeoLocation();
        rs.radLat = latitude;
        rs.radLon = longitude;
        rs.degLat = Math.toDegrees(latitude);
        rs.degLon = Math.toDegrees(longitude);
        rs.checkBounds();
        return rs;
    }

    private void checkBounds() {
        if (radLat < MIN_LAT || radLat > MAX_LAT
                || radLon < MIN_LON || radLon > MAX_LON) {
            throw new IllegalArgumentException();
        }
    }

    /**
     * Computes the bounding coordinates of all points on the surface of a
     * sphere that have a great circle distance to the point represented by this
     * GeoLocation instance that is less or equal to the distance argument.
     * 
     * @param distance the distance from the point represented by this
     * GeoLocation instance. Must me measured in the same unit as the radius
     * argument.
     * @return an array of two GeoLocation objects such that:<ul>
     * <li>The latitude of any point within the specified distance is greater or
     * equal to the latitude of the first array element and smaller or equal to
     * the latitude of the second array element.</li>
     * <li>If the longitude of the first array element is smaller or equal to
     * the longitude of the second element, then the longitude of any point
     * within the specified distance is greater or equal to the longitude of the
     * first array element and smaller or equal to the longitude of the second
     * array element.</li>
     * <li>If the longitude of the first array element is greater than the
     * longitude of the second element (this is the case if the 180th meridian
     * is within the distance), then the longitude of any point within the
     * specified distance is greater or equal to the longitude of the first
     * array element
     * <strong>or</strong> smaller or equal to the longitude of the second array
     * element.</li>
     * </ul>
     */
    public GeoLocation[] boundingCoordinates(double distance) {

        if (distance < 0d) {
            throw new IllegalArgumentException();
        }

        double radDist = distance / R;

        double minLat = radLat - radDist;
        double maxLat = radLat + radDist;

        double minLon, maxLon;
        if (minLat > MIN_LAT && maxLat < MAX_LAT) {
            double deltaLon = Math.asin(Math.sin(radDist) / Math.cos(radLat));
            minLon = radLon - deltaLon;
            if (minLon < MIN_LON) {
                minLon += 2d * Math.PI;
            }
            maxLon = radLon + deltaLon;
            if (maxLon > MAX_LON) {
                maxLon -= 2d * Math.PI;
            }
        } else {
            minLat = Math.max(minLat, MIN_LAT);
            maxLat = Math.min(maxLat, MAX_LAT);
            minLon = MIN_LON;
            maxLon = MAX_LON;
        }

        return new GeoLocation[]{
            fromRadians(minLat, minLon),
            fromRadians(maxLat, maxLon)};
    }

    public double getRadLat() {
        return radLat;
    }

    public void setRadLat(double radLat) {
        this.radLat = radLat;
    }

    public double getRadLon() {
        return radLon;
    }

    public void setRadLon(double radLon) {
        this.radLon = radLon;
    }

    public double getDegLat() {
        return degLat;
    }

    public void setDegLat(double degLat) {
        this.degLat = degLat;
    }

    public double getDegLon() {
        return degLon;
    }

    public void setDegLon(double degLon) {
        this.degLon = degLon;
    }
}
