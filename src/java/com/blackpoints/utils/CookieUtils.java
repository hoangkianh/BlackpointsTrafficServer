package com.blackpoints.utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author HKA
 */
public class CookieUtils {
    /**
     * 
     * @param request
     * @param name
     * @return Cookie
     */
    public static Cookie getCookieByName (HttpServletRequest request, String name) {
        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if (cookie.getName().equals(name)) {
                    return cookie;
                }
            }
        }
        return null;
    }
}
