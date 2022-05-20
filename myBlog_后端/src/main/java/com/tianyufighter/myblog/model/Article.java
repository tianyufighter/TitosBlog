package com.tianyufighter.myblog.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Article {
    private int id;
    private String username;
    private String title;
    private String label;
    private String content;
    private Date createTime;
    private boolean isPublic;
    private String plainText;
    private String coverPhoto;
    public Article(String username, String title, String label, String content, Date createTime, boolean isPublic, String plainText, String coverPhoto) {
        this.username = username;
        this.title = title;
        this.label = label;
        this.content = content;
        this.createTime = createTime;
        this.isPublic = isPublic;
        this.plainText = plainText;
        this.coverPhoto = coverPhoto;
    }
}
