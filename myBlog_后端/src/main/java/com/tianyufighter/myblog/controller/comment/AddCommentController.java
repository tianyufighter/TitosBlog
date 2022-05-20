package com.tianyufighter.myblog.controller.comment;

import com.tianyufighter.myblog.model.Comment;
import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.comment.CommentService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;

@RestController
public class AddCommentController {
    @Resource
    private CommentService commentService;

    @RequestMapping("/comment/add")
    public CommonResult addComment(String author, String title, String label, String username, String content) {
        Comment comment = new Comment();
        comment.setAuthor(author);
        comment.setTitle(title);
        comment.setLabel(label);
        comment.setUsername(username);
        comment.setContent(content);
        comment.setReleaseTime(new Date());
        int res = commentService.insertComment(comment);
        if(res == 1) {
            return new CommonResult(200, "评论成功~");
        } else {
            return new CommonResult(444, "评论失败~");
        }
    }
}
