package com.tianyufighter.myblog.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 好友关系实体类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PersonRelation {
    private int id;
    private String myName; // 我的名称
    private String friendName; // 好友的名称
    private String myPortrait; // 我的头像地址
    private String friendPortrait; // 好友的头像地址
    private String message; // 最后一条消息
    private Date sendTime; // 最后一条消息发送时间
    public PersonRelation(String myName, String friendName, String myPortrait, String friendPortrait, String message, Date sendTime) {
        this.myName = myName;
        this.friendName = friendName;
        this.myPortrait = myPortrait;
        this.friendPortrait = friendPortrait;
        this.message = message;
        this.sendTime = sendTime;
    }
}
