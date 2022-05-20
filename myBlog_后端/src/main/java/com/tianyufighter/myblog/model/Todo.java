package com.tianyufighter.myblog.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Todo {
    private int id;
    private String username; // 创建者的用户名
    private String title; // 标题
    private String content; // 详情
    private int priority; // 优先级 0: 一般 1: 重要
    private Date createDate; // 创建日期
    private Date completeDate; // 完成日期
    private int status; // 完成状况
    private int type; // 待办类型(0: 工作, 1: 学习, 2: 生活)
    public Todo(String username, String title, String content, int priority, Date createDate, Date completeDate, int status, int type) {
        this.username = username;
        this.title = title;
        this.content = content;
        this.priority = priority;
        this.createDate = createDate;
        this.completeDate = completeDate;
        this.status = status;
        this.type = type;
    }
}
