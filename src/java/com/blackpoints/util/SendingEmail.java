package com.blackpoints.util;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author HKA
 */
public class SendingEmail {
    
    static Properties properties = new Properties();

    static {
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.socketFactory.port", "465");
        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.port", "465");
    }

    public static boolean sendEmail(final String from, final String password, String to, String subject, String body) {
        boolean sendOK = false;

        try {
            Session session = Session.getDefaultInstance(properties,
                    new Authenticator() {
                        @Override
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(from, password);
                        }
                    });
            
            MimeMessage msg = new MimeMessage(session);
            msg.setContent("", to);
            msg.setFrom(new InternetAddress(from));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            msg.setSubject(subject, "utf-8");
            msg.setContent(body, "text/html; charset=utf-8");
            
            // send email
            Transport.send(msg);
            
            // send email success
            sendOK = true;
        } catch (MessagingException e) {
            System.out.println(e.getMessage());
        }

        return sendOK;
    }
}
