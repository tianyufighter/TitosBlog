package com.tianyufighter.myblog.service.search;

import com.tianyufighter.myblog.model.Searchdata;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SearchService {
    // 插入一条搜索记录的数据
    int insertSearch(String searchRecord);
    // 修改搜索记录的搜索次数
    int updateSearch(String searchRecord);
    // 获取搜索次数最多的几条记录
    List<Searchdata> getHotSearch(int cnt);
}
