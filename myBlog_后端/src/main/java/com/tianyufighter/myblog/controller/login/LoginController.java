package com.tianyufighter.myblog.controller.login;

import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.model.User;
import com.tianyufighter.myblog.service.user.UserService;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * 用户登录
 */
@RestController
public class LoginController {
    @Resource
    private UserService userService;

    /**
     * 用户登录的方法
     * @param email 邮箱
     * @param password 密码
     * @return 返回用户登录的结果
     */
    @RequestMapping("/user/login")
    public CommonResult<String> userLogin(@RequestParam("email") String email, @RequestParam("password") String password) {
        User user = userService.queryUser(email, password);
        if(user != null) {
            return new CommonResult(200, "true", user.getUsername());
        } else {
            return new CommonResult(404, "false");
        }
    }
}
