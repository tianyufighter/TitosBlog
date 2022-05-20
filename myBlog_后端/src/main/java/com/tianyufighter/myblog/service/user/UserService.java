package com.tianyufighter.myblog.service.user;

import com.tianyufighter.myblog.model.User;
import org.apache.ibatis.annotations.Param;

public interface UserService {
    int insertUser(User user);
    User queryUser(String email, String password);
    String queryPasswordByUsername(String email);
    int insertHeadImage(String username, String headImage);
    String queryHeadImage(String username);
    User queryUserByUsername(@Param("username") String username);
}
