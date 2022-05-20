package com.tianyufighter.myblog.controller.article;

import com.tianyufighter.myblog.model.Article;
import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.article.ArticleService;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController
public class QueryOwnArticleController {
    @Resource
    private ArticleService articleService;

    @RequestMapping("/article/ownArticle")
    public CommonResult<List<Article>> getOwnArticle(@RequestParam("username") String username, @RequestParam("isPublic") int isPublic) {
        List<Article> articles = articleService.queryOwnArticle(username, isPublic);
        if(articles != null) {
            return new CommonResult<List<Article>>(200, "查询成功", articles);
        } else {
            return new CommonResult<List<Article>>(444, "查询失败");
        }
    }
}
