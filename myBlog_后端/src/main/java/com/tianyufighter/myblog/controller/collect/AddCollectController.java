package com.tianyufighter.myblog.controller.collect;

import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.collect.CollectService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
public class AddCollectController {
    @Resource
    private CollectService collectService;

    @RequestMapping("/collect/add")
    public CommonResult addCollect(@RequestParam("articleId") int articleId, @RequestParam("username") String username, @RequestParam("isLove") boolean isLove) {
        try {
            int isExist = collectService.selectCollect(articleId, username);
            // 表示该条记录已经存在
            int res = collectService.updateCollect(articleId, username, isLove);
            if(res == 1) {
                if(isLove) {
                    return new CommonResult(200, "收藏成功~");
                } else {
                    return new CommonResult(200, "取消收藏~");
                }
            } else {
                return new CommonResult(444, "操作失败~");
            }
        } catch(Exception e) {
            int res = collectService.insertCollect(articleId, username, isLove);
            if(res == 1) {
                return new CommonResult(200, "收藏成功~");
            } else {
                return new CommonResult(444, "操作失败~");
            }
        }
    }
}
