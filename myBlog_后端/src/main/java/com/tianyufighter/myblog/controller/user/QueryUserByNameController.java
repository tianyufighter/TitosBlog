package com.tianyufighter.myblog.controller.user;

import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.model.User;
import com.tianyufighter.myblog.service.user.UserService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * 根据用户名查询用户是否存在
 */
@RestController
public class QueryUserByNameController {
    @Resource
    private UserService userService;

    @RequestMapping("/user/queryUserByName")
    public CommonResult<User> queryUser(@RequestParam("username") String username) {
        User user = userService.queryUserByUsername(username);
        if(user != null) {
            return new CommonResult<>(200, "查询成功", user);
        } else {
            return new CommonResult<>(444, "查询失败");
        }
    }
}
