package com.tianyufighter.myblog.controller.article;

import com.tianyufighter.myblog.model.Article;
import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.article.ArticleService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;

@RestController
public class AddArticleController {
    @Resource
    private ArticleService articleService;

    @RequestMapping("/article/add")
    public CommonResult addArticle(@RequestParam("username") String username, @RequestParam("title") String title,
                                   @RequestParam("label") String label, @RequestParam("content") String content,
                                   @RequestParam("isPublic") Boolean isPublic, @RequestParam("plainText") String plainText) {
        Article article = new Article();
        article.setUsername(username);
        article.setTitle(title);
        article.setLabel(label);
        article.setContent(content);
        article.setCreateTime(new Date());
        article.setPublic(isPublic);
        article.setPlainText(plainText);
        int result = articleService.insertArticle(article);
        if(result == 0) {
            return new CommonResult(444, "false");
        } else {
            return new CommonResult(200, "true");
        }
    }
}
