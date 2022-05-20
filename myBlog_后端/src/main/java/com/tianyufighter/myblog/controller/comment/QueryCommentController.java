package com.tianyufighter.myblog.controller.comment;

import com.tianyufighter.myblog.model.Comment;
import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.comment.CommentService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController
public class QueryCommentController {
    @Resource
    private CommentService commentService;

    @RequestMapping("/comment/query")
    public CommonResult<List<Comment>> queryComment(String author, String title, String label) {
        List<Comment> comments = commentService.queryAllCommentByInfo(author, title, label);
        if(comments != null) {
            return new CommonResult<List<Comment>>(200, "查询成功", comments);
        } else {
            return new CommonResult<List<Comment>>(444,"查询失败");
        }
    }
}
