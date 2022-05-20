package com.tianyufighter.myblog.service.opinion;

import org.apache.ibatis.annotations.Param;

public interface OpinionService {
    /*
     * 存入用户的意见反馈信息
     * */
    int insertOpinion(String username, String content);
}
