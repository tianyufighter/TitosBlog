package com.tianyufighter.myblog.controller.article;

import com.tianyufighter.myblog.model.Article;
import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.article.ArticleService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

/**
 * 模糊查询文章
 */
@RestController
public class FuzzyQueryArticleController {
    @Resource
    private ArticleService articleService;

    @RequestMapping("/article/fuzzyquery")
    public CommonResult<List<Article>> fuzzyQueryArticle(@RequestParam("value") String value) {
        List<Article> articles = articleService.fuzzyQueryArticle(value);
        if(articles != null) {
            return new CommonResult<List<Article>>(200, "查询成功", articles);
        } else {
            return new CommonResult<List<Article>>(444, "查询失败");
        }
    }
}
