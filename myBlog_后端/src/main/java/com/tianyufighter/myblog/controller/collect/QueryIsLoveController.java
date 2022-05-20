package com.tianyufighter.myblog.controller.collect;

import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.collect.CollectService;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
public class QueryIsLoveController {
    @Resource
    private CollectService collectService;

    @RequestMapping("/collect/queryIsLove")
    public CommonResult queryIsLove(@RequestParam("articleId") int articleId, @RequestParam("username") String username) {
        try {
            int isLove = collectService.selectCollect(articleId, username);
            if(isLove == 1) {
                return new CommonResult(200, "true");
            } else {
                return new CommonResult(444, "false");
            }
        } catch (Exception e) {
            return new CommonResult(444, "failure");
        }
    }
}
