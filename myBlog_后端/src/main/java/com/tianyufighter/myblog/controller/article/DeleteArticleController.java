package com.tianyufighter.myblog.controller.article;

import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.article.ArticleService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
public class DeleteArticleController {
    @Resource
    private ArticleService articleService;

    @RequestMapping("/article/deleteArticle")
    public CommonResult deleteArticle(@RequestParam("id") int id) {
        int res = articleService.deleteArticleById(id);
        if(res == 1) {
            return new CommonResult(200, "删除成功");
        } else {
            return new CommonResult(444, "删除失败");
        }
    }
}