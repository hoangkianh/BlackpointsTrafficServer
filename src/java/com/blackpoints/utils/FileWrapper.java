package com.blackpoints.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.net.URL;
import java.net.URLConnection;
import org.apache.struts.upload.FormFile;

/**
 *
 * @author HKA
 */
public class FileWrapper implements FormFile, Serializable {

    private final File file;

    public FileWrapper(File file) {
        this.file = file;
    }

    @Override
    public String getContentType() {
        String type = "";
        try {
            URL url = new URL("file:" + file.getAbsolutePath());
            URLConnection connection = url.openConnection();
            type = connection.getContentType();
        } catch (Exception ex) {
            System.err.println(ex.getMessage());
        }
        return type;
    }

    @Override
    public void setContentType(String contentType) {
    }

    @Override
    public int getFileSize() {
        return (int) file.length();
    }

    @Override
    public void setFileSize(int fileSize) {
        this.setFileSize(fileSize);
    }

    @Override
    public String getFileName() {
        return file.getName();
        //throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void setFileName(String fileName) {
    }

    @Override
    public byte[] getFileData() throws FileNotFoundException, IOException {
        byte[] buffer = new byte[(int) file.length()];
        FileInputStream fs = new FileInputStream(file);
        fs.read(buffer);
        fs.close();
        return buffer;
    }

    @Override
    public InputStream getInputStream() throws FileNotFoundException, IOException {
        return new FileInputStream(file);
    }

    @Override
    public void destroy() {
        if (!file.delete()) {
            throw new RuntimeException("File " + file.getName() + " can't be deleted");
        }
    }

}
