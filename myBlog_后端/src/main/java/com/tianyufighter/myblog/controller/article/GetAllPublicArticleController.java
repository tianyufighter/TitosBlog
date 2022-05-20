package com.tianyufighter.myblog.controller.article;

import com.github.pagehelper.PageInfo;
import com.tianyufighter.myblog.model.Article;
import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.article.ArticleService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/*
* 根据页号得到所有公开的文章
* */
@RestController
public class GetAllPublicArticleController {
    @Resource
    private ArticleService articleService;

    @RequestMapping("/article/getArticleByPage")
    public CommonResult<PageInfo<Article>> getAllPublicArticle(HttpServletRequest request) {
        int pageNum = Integer.parseInt(request.getParameter("pageNum"));
        int pageSize = Integer.parseInt(request.getParameter("pageSize"));
        PageInfo<Article> pageInfo = articleService.getAllArticleByPage(pageNum, pageSize);
        if(pageInfo != null) {
            return new CommonResult<>(200, "在数据库中成功找到请求数据", pageInfo);
        } else {
            return new CommonResult<>(444, "未在数据库中找到请求数据", pageInfo);
        }
    }
}
