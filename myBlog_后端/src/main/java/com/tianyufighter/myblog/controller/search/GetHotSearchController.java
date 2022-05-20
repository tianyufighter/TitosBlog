package com.tianyufighter.myblog.controller.search;

import com.tianyufighter.myblog.model.Article;
import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.model.Searchdata;
import com.tianyufighter.myblog.service.search.SearchService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController
public class GetHotSearchController {
    @Resource
    private SearchService searchService;

    @RequestMapping("/search/hotSearch")
    public CommonResult<List<Searchdata>> getHotSearch(@RequestParam("cnt") int cnt) {
        List<Searchdata> articles = searchService.getHotSearch(cnt);
        if(articles != null) {
            return new CommonResult<List<Searchdata>>(200, "查询成功", articles);
        } else {
            return new CommonResult<List<Searchdata>>(444, "查询失败");
        }
    }
}
