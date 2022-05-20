package com.tianyufighter.myblog.service.article.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tianyufighter.myblog.dao.ArticleDao;
import com.tianyufighter.myblog.model.Article;
import com.tianyufighter.myblog.service.article.ArticleService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;

@Service
public class ArticleServiceImpl implements ArticleService {
    @Resource
    private ArticleDao articleDao;

    @Override
    public int insertArticle(Article article) {
        return articleDao.insertArticle(article);
    }

    @Override
    public List<Article> getAllPublicArticle() {
        return articleDao.getAllPublicArticle();
    }

    @Override
    public PageInfo<Article> getAllArticleByPage(int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        PageHelper.orderBy("id desc");
        List<Article> lists = articleDao.getAllPublicArticle();
        Collections.reverse(lists);
        PageInfo<Article> pageInfo = new PageInfo<>(lists, pageSize);
        return pageInfo;
    }

    @Override
    public int insertCoverPhoto(String coverPhoto, int id) {
        return articleDao.insertCoverPhoto(coverPhoto, id);
    }

    @Override
    public int getIdByUsernameAndTitle(String username, String title, String label) {
        return articleDao.getIdByUsernameAndTitle(username, title, label);
    }

    @Override
    public List<Article> fuzzyQueryArticle(String value) {
        return articleDao.fuzzyQueryArticle(value);
    }

    @Override
    public List<Article> queryCollectArticle(String username) {
        return articleDao.queryCollectArticle(username);
    }

    @Override
    public PageInfo<Article> getCollectArticleByPage(String username, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        PageHelper.orderBy("id desc");
        List<Article> lists = articleDao.queryCollectArticle(username);
        Collections.reverse(lists);
        PageInfo<Article> pageInfo = new PageInfo<>(lists, pageSize);
        return pageInfo;
    }

    @Override
    public List<Article> queryOwnArticle(String username, int isPublic) {
        return articleDao.queryOwnArticle(username, isPublic);
    }

    @Override
    public int deleteArticleById(int id) {
        return articleDao.deleteArticleById(id);
    }
}
