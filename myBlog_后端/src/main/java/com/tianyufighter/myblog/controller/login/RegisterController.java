package com.tianyufighter.myblog.controller.login;

import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.model.User;
import com.tianyufighter.myblog.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSendException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@RestController
public class RegisterController {
    @Autowired
    private JavaMailSender javaMailSender;
    // 存储验证码
    private Map<String, Object> resultMap = new HashMap<>();
    @RequestMapping("/user/sendEmail")
    public CommonResult sendEmail(String email) {
        SimpleMailMessage message = new SimpleMailMessage();
        String code = VerifyCode(6);//随机数生成6位验证码
        message.setFrom("3121402314@qq.com");
        message.setTo(email);
        message.setSubject("tianyufighter博客");// 标题
        message.setText("【tianyufighter博客】你的验证码为："+code+"，有效时间为5分钟(若不是本人操作，可忽略该条邮件)");//内容
        try {
            javaMailSender.send(message);
            saveCode(code);
            return new CommonResult(200, "success");
        } catch (MailSendException e) {
            return new CommonResult(444,"false");
        } catch (Exception e) {
            return new CommonResult(444, "failure");
        }
    }

    @Autowired
    public UserService userService;

    /**
     * 用户注册
     * @param email
     * @param password
     * @return
     */
    @GetMapping("/user/register")
    public CommonResult doRegister(@RequestParam("username") String username, @RequestParam("email") String email, @RequestParam("password") String password, @RequestParam("verifyCode") String verifyCode) {
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        // 将客户端传过来的hash加密
        String verifyHash = com.tianyufighter.springboot.utils.MD5Utils.code(verifyCode);
        // 获取当前时间并格式化
        SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
        Calendar now = Calendar.getInstance();
        String currentTime = sf.format(now.getTime());
        try {
            if(currentTime.compareTo((String) resultMap.get("tamp")) < 0) {
                // 判断验证码是否正确
                if(verifyHash != null && verifyHash.equals(resultMap.get("hash"))) {
                    int res = 0;
                    try {
                        res = userService.insertUser(user);
                    } catch (Exception e) {
                    }
                    if(res == 1) {
                        // 注册成功
                        return new CommonResult(200, "true");
                    } else {
                        // 用户名已存在
                        return new CommonResult(401, "false");
                    }
                } else {
                    // 验证码错误
                    return new CommonResult(402, "false");
                }
            } else {
                // 验证码已失效
                return new CommonResult(403, "false");
            }
        } catch (Exception e) {
            // 没有请求验证码
           return new CommonResult(404, "false");
        }
    }
    private String VerifyCode(int n){
        Random r = new Random();
        StringBuffer sb =new StringBuffer();
        for(int i = 0;i < n;i ++){
            int ran1 = r.nextInt(10);
            sb.append(String.valueOf(ran1));
        }
        return sb.toString();
    }
    //保存验证码和时间
    private void saveCode(String code){
        SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
        Calendar c = Calendar.getInstance();
        c.add(Calendar.MINUTE, 5);
        String currentTime = sf.format(c.getTime());// 生成5分钟后时间，用户校验是否过期

        String hash =  com.tianyufighter.springboot.utils.MD5Utils.code(code);//生成MD5值
        resultMap.put("hash", hash);
        resultMap.put("tamp", currentTime);
    }
}
