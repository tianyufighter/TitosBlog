package com.tianyufighter.myblog.service.comment.impl;

import com.tianyufighter.myblog.dao.CommentDao;
import com.tianyufighter.myblog.model.Comment;
import com.tianyufighter.myblog.service.comment.CommentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {
    @Resource
    private CommentDao commentDao;

    @Override
    public int insertComment(Comment comment) {
        return commentDao.insertComment(comment);
    }

    @Override
    public List<Comment> queryAllCommentByInfo(String author, String title, String label) {
        return commentDao.queryAllCommentByInfo(author, title, label);
    }


}
