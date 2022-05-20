package com.tianyufighter.myblog.controller.article;

import com.github.pagehelper.PageInfo;
import com.tianyufighter.myblog.model.Article;
import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.article.ArticleService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
public class QueryCollectArticle {
    @Resource
    private ArticleService articleService;

    @RequestMapping("/article/collect")
    public CommonResult<PageInfo<Article>> getCollectArticle(@RequestParam("username") String username, @RequestParam("pageNum") int pageNum, @RequestParam("pageSize") int pageSize) {
        PageInfo<Article> pageInfo = articleService.getCollectArticleByPage(username, pageNum, pageSize);
        if(pageInfo != null) {
            return new CommonResult<PageInfo<Article>>(200, "查询成功", pageInfo);
        } else {
            return new CommonResult<PageInfo<Article>>(444, "查询失败");
        }
    }
}
