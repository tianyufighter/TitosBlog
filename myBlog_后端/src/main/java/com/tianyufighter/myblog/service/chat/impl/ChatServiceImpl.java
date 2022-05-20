package com.tianyufighter.myblog.service.chat.impl;

import com.tianyufighter.myblog.dao.ChatDao;
import com.tianyufighter.myblog.model.Chat;
import com.tianyufighter.myblog.service.chat.ChatService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class ChatServiceImpl implements ChatService {
    @Resource
    private ChatDao chatDao;

    @Override
    public int insertChat(Chat chat) {
        return chatDao.insertChat(chat);
    }

    @Override
    public List<Chat> queryAllChat(String sendUsername, String receiveUsername) {
        return chatDao.queryAllChat(sendUsername, receiveUsername);
    }

    @Override
    public List<Chat> queryChatByName(String sendUsername, String receiveUsername) {
        return chatDao.queryChatByName(sendUsername, receiveUsername);
    }

    @Override
    public int updateChat(String sendUsername, String receiveUsername) {
        return chatDao.updateChat(sendUsername,receiveUsername);
    }

    @Override
    public int deleteMessage(String sendUsername, String receiveUsername) {
        return chatDao.deleteMessage(sendUsername, receiveUsername);
    }
}
