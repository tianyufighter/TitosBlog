package com.tianyufighter.myblog.service.chat;

import com.tianyufighter.myblog.model.Chat;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ChatService {
    /**
     * 插入一条消息
     */
    int insertChat(Chat chat);
    /**
     * 根据用户名，查询该用户所有的消息
     */
    List<Chat> queryAllChat(String sendUsername, String receiveUsername);
    /**
     *  查询是否有该用户的聊天消息，如果有，就将这些未接收的消息全部返回给客户端
     */
    List<Chat> queryChatByName(String sendUsername, String receiveUsername);
    /**
     * 当用户接收到消息后，更改消息状态
     */
    int updateChat(String sendUsername, String receiveUsername);
    /**
     * 删除好友时，删除两个之间所有的聊天记录
     */
    int deleteMessage(String sendUsername, String receiveUsername);
}
