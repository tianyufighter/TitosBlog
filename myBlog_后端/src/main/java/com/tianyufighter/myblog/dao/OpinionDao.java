package com.tianyufighter.myblog.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface OpinionDao {
    /*
    * 存入用户的意见反馈信息
    * */
    int insertOpinion(@Param("username") String username, @Param("content") String content);
}
