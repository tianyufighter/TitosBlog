package com.tianyufighter.myblog.service.user.impl;

import com.tianyufighter.myblog.dao.UserDao;
import com.tianyufighter.myblog.model.User;
import com.tianyufighter.myblog.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserDao userDao;

    @Override
    public int insertUser(User user) {
        return userDao.insert(user);
    }

    @Override
    public User queryUser(String email, String password) {
        return userDao.queryUser(email, password);
    }

    @Override
    public String queryPasswordByUsername(String email) {
        return userDao.queryPasswordByUsername(email);
    }

    @Override
    public int insertHeadImage(String username, String headImage) {
        return userDao.insertHeadImage(username, headImage);
    }

    @Override
    public String queryHeadImage(String username) {
        return userDao.queryHeadImage(username);
    }

    @Override
    public User queryUserByUsername(String username) {
        return userDao.queryUserByUsername(username);
    }
}
