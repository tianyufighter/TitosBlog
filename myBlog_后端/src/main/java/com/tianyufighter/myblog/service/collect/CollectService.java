package com.tianyufighter.myblog.service.collect;

import org.apache.ibatis.annotations.Param;

public interface CollectService {
    // 查询收藏记录
    int selectCollect(int articleId, String username);
    // 插入一条收藏记录
    int insertCollect(int articleId, String username, boolean isLove);
    // 更新收藏记录
    int updateCollect(int articleId, String username, boolean isLove);
}
