package com.tianyufighter.myblog.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CollectDao {
    // 查询收藏记录
    int selectCollect(@Param("articleId") int articleId, @Param("username") String username);
    // 插入一条收藏记录
    int insertCollect(@Param("articleId") int articleId, @Param("username") String username, @Param("isLove") boolean isLove);
    // 更新收藏记录
    int updateCollect(int articleId, String username, boolean isLove);
}
