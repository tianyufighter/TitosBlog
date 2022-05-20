package com.tianyufighter.myblog.service.collect.impl;

import com.tianyufighter.myblog.dao.CollectDao;
import com.tianyufighter.myblog.service.collect.CollectService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class CollectServiceImpl implements CollectService {
    @Resource
    private CollectDao collectDao;

    @Override
    public int selectCollect(int articleId, String username) {
        return collectDao.selectCollect(articleId, username);
    }

    @Override
    public int insertCollect(int articleId, String username, boolean isLove) {
        return collectDao.insertCollect(articleId, username, isLove);
    }

    @Override
    public int updateCollect(int articleId, String username, boolean isLove) {
        return collectDao.updateCollect(articleId, username, isLove);
    }
}
