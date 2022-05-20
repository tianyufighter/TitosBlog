package com.tianyufighter.myblog.dao;

import com.tianyufighter.myblog.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserDao {
    // 存储用户
    int insert(User user);
    // 根据用户名和密码查询用户是否存在
    User queryUser(@Param("email") String email, @Param("password")String password);
    // 根据用户名查找用户的密码
    String queryPasswordByUsername(@Param("email") String email);
    // 存入用户头像
    int insertHeadImage(@Param("username") String username, @Param("headImage") String headImage);
    // 根据用户名查询用户头像
    String queryHeadImage(@Param("username") String username);
    // 根据用户名查询用户是否存在
    User queryUserByUsername(@Param("username") String username);
}
