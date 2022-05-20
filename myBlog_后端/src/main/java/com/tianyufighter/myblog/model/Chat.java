package com.tianyufighter.myblog.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 消息的实体类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Chat {
    private int id;
    private String sendUsername;
    private String receiveUsername;
    private String imageUrl;
    private String message;
    private Date sendTime;
    private boolean isComplete;
    public Chat(String sendUsername, String receiveUsername, String imageUrl, String message, Date sendTime, boolean isComplete) {
        this.sendUsername = sendUsername;
        this.receiveUsername = receiveUsername;
        this.imageUrl = imageUrl;
        this.message = message;
        this.sendTime = sendTime;
        this.isComplete = isComplete;
    }
}
