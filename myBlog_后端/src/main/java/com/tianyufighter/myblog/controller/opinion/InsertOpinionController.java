package com.tianyufighter.myblog.controller.opinion;

import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.opinion.OpinionService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
public class InsertOpinionController {
    @Resource
    private OpinionService opinionService;

    @RequestMapping("/opinion/insert")
    public CommonResult insertOpinion(@RequestParam("username") String username, @RequestParam("content") String content) {
        int res = opinionService.insertOpinion(username, content);
        if(res == 1) {
            return new CommonResult(200, "存储成功");
        } else {
            return new CommonResult(444, "存储失败");
        }
    }
}
