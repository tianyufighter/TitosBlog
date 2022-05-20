package com.tianyufighter.myblog.dao;

import com.tianyufighter.myblog.model.Article;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ArticleDao {
    // 向数据库中存入文章
    int insertArticle(Article article);
    // 获取所有的公开文章
    List<Article> getAllPublicArticle();
    // 上传封面图片
    int insertCoverPhoto(@Param("coverPhoto") String coverPhoto, @Param("id") int id);
    // 根据用户名和标题查询出对应的文章序号
    int getIdByUsernameAndTitle(@Param("username") String username, @Param("title") String title, @Param("label") String label);
    // 模糊查询文章
    List<Article> fuzzyQueryArticle(@Param("value") String value);
    // 根据用户名查询该用户收藏的文章
    List<Article> queryCollectArticle(@Param("username") String username);
    // 查询用户发布的文章（isPublic为1时查询所有公开的文章，为0时查询所有私有的文章）
    List<Article> queryOwnArticle(@Param("username") String username, @Param("isPublic") int isPublic);
    // 根据文章的序号删除该文章
    int deleteArticleById(@Param("id") int id);
}
