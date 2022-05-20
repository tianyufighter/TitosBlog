package com.tianyufighter.myblog.dao;

import com.tianyufighter.myblog.model.Comment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CommentDao {
    // 向数据库中插入一条评论
    int insertComment(Comment comment);
    // 根据文章的信息查询相关的评论
    List<Comment> queryAllCommentByInfo(@Param("author") String author, @Param("title") String title, @Param("label") String label);
}
