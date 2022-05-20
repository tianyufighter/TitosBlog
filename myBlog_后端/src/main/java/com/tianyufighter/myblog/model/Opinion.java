package com.tianyufighter.myblog.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 意见反馈实体类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Opinion {
    private int id;
    private String username;
    private String content;
    private boolean isHandle;
}
