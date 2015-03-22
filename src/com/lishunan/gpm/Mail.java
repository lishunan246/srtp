package com.lishunan.gpm;
import java.util.Properties;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
/**
 * Created by chenxin on 2015/3/22.
 */

public class Mail {
    public static  void mailTo(String receiver,String content) {
        JavaMailSenderImpl senderImpl = new JavaMailSenderImpl();

        // 设定mail server
        senderImpl.setHost("smtp.163.com");

        // 建立邮件消息,发送简单邮件和html邮件的区别
        MimeMessage mailMessage = senderImpl.createMimeMessage();
        MimeMessageHelper messageHelper = new MimeMessageHelper(mailMessage);
        try {
            // 设置收件人，寄件人
            messageHelper.setTo(receiver);
            messageHelper.setFrom("");
            messageHelper.setSubject("找回密码");
            // true 表示启动HTML格式的邮件
            messageHelper
                    .setText(content,
                            true);
        }catch(MessagingException e){
            e.printStackTrace();
        }
        senderImpl.setUsername(""); // 根据自己的情况,设置邮箱账号
        senderImpl.setPassword(""); // 根据自己的情况, 设置password
        Properties prop = new Properties();
        prop.put("mail.smtp.auth", "true"); // 将这个参数设为true，让服务器进行认证,认证用户名和密码是否正确
        prop.put("mail.smtp.timeout", "25000");
        senderImpl.setJavaMailProperties(prop);
        // 发送邮件
        senderImpl.send(mailMessage);

        System.out.println("邮件发送成功..");
    }
}
