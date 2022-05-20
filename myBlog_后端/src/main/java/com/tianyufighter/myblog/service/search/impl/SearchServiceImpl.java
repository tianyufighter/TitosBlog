package com.tianyufighter.myblog.service.search.impl;

import com.tianyufighter.myblog.dao.SearchDao;
import com.tianyufighter.myblog.model.Searchdata;
import com.tianyufighter.myblog.service.search.SearchService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SearchServiceImpl implements SearchService {
    @Resource
    private SearchDao searchDao;

    @Override
    public int insertSearch(String searchRecord) {
        return searchDao.insertSearch(searchRecord);
    }

    @Override
    public int updateSearch(String searchRecord) {
        return searchDao.updateSearch(searchRecord);
    }

    @Override
    public List<Searchdata> getHotSearch(int cnt) {
        return searchDao.getHotSearch(cnt);
    }
}
