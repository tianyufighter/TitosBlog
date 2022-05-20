package com.tianyufighter.myblog.controller.login;

import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSendException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/*
* 找回密码
* */
@RestController
public class RetrievePassword {
    @Autowired
    private JavaMailSender javaMailSender;
    @Resource
    private UserService userService;
    // 存储验证码
    private Map<String, Object> resultMap = new HashMap<>();
    @RequestMapping("/user/getPassword")
    public CommonResult sendEmail(@RequestParam("email") String email) {
        String password = userService.queryPasswordByUsername(email);
        if(password != null) {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("3121402314@qq.com");
            message.setTo(email);
            message.setSubject("tianyufighter博客");// 标题
            message.setText("【tianyufighter博客】你的密码为："+password+"，请妥善保管(若不是本人操作，可忽略该条邮件)");//内容
            try {
                javaMailSender.send(message);
                return new CommonResult(200, "success");
            } catch (MailSendException e) {
                return new CommonResult(444,"false");
            } catch (Exception e) {
                return new CommonResult(444, "failure");
            }
        } else {
            // 没有该用户
            return new CommonResult(401, "false");
        }
    }
}
