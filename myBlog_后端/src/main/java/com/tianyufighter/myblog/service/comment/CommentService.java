package com.tianyufighter.myblog.service.comment;

import com.tianyufighter.myblog.model.Comment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommentService {
    // 向数据库中插入一条评论
    int insertComment(Comment comment);
    // 根据文章的信息查询相关的评论
    List<Comment> queryAllCommentByInfo(String author, String title, String label);
}
