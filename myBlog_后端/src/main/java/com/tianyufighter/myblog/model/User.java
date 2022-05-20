package com.tianyufighter.myblog.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private int id;
    private String email;
    private String password;
    private String username;
    private String headImage;
    public User(String email, String password, String username, String headImage) {
        this.email = email;
        this.password = password;
        this.username = username;
        this.headImage = headImage;
    }
}
