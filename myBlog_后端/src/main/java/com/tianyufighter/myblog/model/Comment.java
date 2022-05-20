package com.tianyufighter.myblog.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Comment {
    private int id;
    private String author; // 文章作者名
    private String title; // 文章标题
    private String label; // 文章标签
    private String username; // 评论者
    private String content; // 评论内容
    private Date releaseTime; // 评论时间
    public Comment(String author, String title, String label, String username, String content, Date releaseTime) {
        this.author = author;
        this.title = title;
        this.label = label;
        this.username = username;
        this.content = content;
        this.releaseTime = releaseTime;
    }
}
