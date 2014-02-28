package com.blackpoints.utils;

/**
 *
 * @author HKA
 */
public class StringUtil {
    
    private static final String[] VietnameseSigns = new String[]{
        "aAeEoOuUiIdDyY",
        "áàạảãâấầậẩẫăắằặẳẵ",
        "ÁÀẠẢÃÂẤẦẬẨẪĂẮẰẶẲẴ",
        "éèẹẻẽêếềệểễ",
        "ÉÈẸẺẼÊẾỀỆỂỄ",
        "óòọỏõôốồộổỗơớờợởỡ",
        "ÓÒỌỎÕÔỐỒỘỔỖƠỚỜỢỞỠ",
        "úùụủũưứừựửữ",
        "ÚÙỤỦŨƯỨỪỰỬỮ",
        "íìịỉĩ",
        "ÍÌỊỈĨ",
        "đ",
        "Đ",
        "ýỳỵỷỹ",
        "ÝỲỴỶỸ"
    };
    
    public static String removeSignVietnameseString(String str) {
        str = str.replaceAll(" ", "-").toLowerCase();
        for (int i = 1; i < VietnameseSigns.length; i++) {            
            for (int j = 0; j < VietnameseSigns[i].length(); j++) {
                str = str.replace(VietnameseSigns[i].charAt(j), VietnameseSigns[0].charAt(i - 1));
            }
        }
        return str;
    }
}
