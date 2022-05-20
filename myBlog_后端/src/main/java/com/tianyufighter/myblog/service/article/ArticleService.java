package com.tianyufighter.myblog.service.article;

import com.github.pagehelper.PageInfo;
import com.tianyufighter.myblog.model.Article;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ArticleService {
    int insertArticle(Article article);
    List<Article> getAllPublicArticle();
    PageInfo<Article> getAllArticleByPage(int pageNum, int pageSize);
    int insertCoverPhoto(String coverPhoto, int id);
    int getIdByUsernameAndTitle(String username, String title, String label);
    List<Article> fuzzyQueryArticle(@Param("value") String value);
    // 根据用户名查询该用户收藏的文章
    List<Article> queryCollectArticle(@Param("username") String username);
    PageInfo<Article> getCollectArticleByPage(String username, int pageNum, int pageSize);
    // 查询用户发布的文章（isPublic为1时查询所有公开的文章，为0时查询所有私有的文章）
    List<Article> queryOwnArticle(String username, int isPublic);
    // 根据文章的序号删除该文章
    int deleteArticleById(int id);
}
