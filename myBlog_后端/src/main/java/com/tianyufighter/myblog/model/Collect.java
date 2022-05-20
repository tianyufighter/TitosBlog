package com.tianyufighter.myblog.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
* 收藏实体类
* */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Collect {
    private int id;
    private int articleId; // 文章序号
    private String username; // 点赞的用户名
    private boolean isLove;
    public Collect(int articleId, String username, boolean isLove) {
        this.articleId = articleId;
        this.username = username;
        this.isLove = isLove;
    }
}
