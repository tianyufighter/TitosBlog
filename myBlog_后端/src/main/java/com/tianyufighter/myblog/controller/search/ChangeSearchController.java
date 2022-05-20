package com.tianyufighter.myblog.controller.search;

import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.search.SearchService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
/*
* 记录每天搜索记录的搜索次数
* */
@RestController
public class ChangeSearchController {
    @Resource
    private SearchService searchService;

    @RequestMapping("/search/change")
    public CommonResult changeSearch(@RequestParam("value") String value) {
        try {
            int res = searchService.insertSearch(value);
            return new CommonResult(200, "记录已存入数据库");
        } catch (Exception e) {
            int res = searchService.updateSearch(value);
            return new CommonResult(200, "记录的访问次数已成功修改");
        }
    }
}
