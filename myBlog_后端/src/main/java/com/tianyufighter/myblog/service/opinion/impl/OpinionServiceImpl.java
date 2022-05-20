package com.tianyufighter.myblog.service.opinion.impl;

import com.tianyufighter.myblog.dao.OpinionDao;
import com.tianyufighter.myblog.service.opinion.OpinionService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class OpinionServiceImpl implements OpinionService {
    @Resource
    private OpinionDao opinionDao;

    @Override
    public int insertOpinion(String username, String content) {
        return opinionDao.insertOpinion(username, content);
    }
}
