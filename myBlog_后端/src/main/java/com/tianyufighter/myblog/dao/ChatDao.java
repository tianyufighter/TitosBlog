package com.tianyufighter.myblog.dao;

import com.tianyufighter.myblog.model.Chat;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ChatDao {
    /**
     * 插入一条消息
     */
    int insertChat(Chat chat);
    /**
     * 根据用户名，查询该用户所有的消息
     */
    List<Chat> queryAllChat(@Param("sendUsername") String sendUsername, @Param("receiveUsername") String receiveUsername);
    /**
     *  查询是否有该用户的聊天消息，如果有，就将这些未接收的消息全部返回给客户端
     */
    List<Chat> queryChatByName(@Param("sendUsername") String sendUsername,@Param("receiveUsername") String receiveUsername);
    /**
     * 当用户接收到消息后，更改消息状态
     */
    int updateChat(@Param("sendUsername") String sendUsername, @Param("receiveUsername") String receiveUsername);
    /**
     * 删除好友时，删除两个之间所有的聊天记录
     */
    int deleteMessage(@Param("sendUsername") String sendUsername, @Param("receiveUsername") String receiveUsername);
}
