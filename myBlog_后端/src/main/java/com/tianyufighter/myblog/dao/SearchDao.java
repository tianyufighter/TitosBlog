package com.tianyufighter.myblog.dao;

import com.tianyufighter.myblog.model.Searchdata;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SearchDao {
    // 插入一条搜索记录的数据
    int insertSearch(@Param("searchRecord") String searchRecord);
    // 修改搜索记录的搜索次数
    int updateSearch(@Param("searchRecord") String searchRecord);
    // 获取搜索次数最多的几条记录
    List<Searchdata> getHotSearch(@Param("cnt") int cnt);
}
