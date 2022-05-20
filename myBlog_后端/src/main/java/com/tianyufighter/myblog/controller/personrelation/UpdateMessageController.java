package com.tianyufighter.myblog.controller.personrelation;

import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.personrelation.PersonRelationService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;

@RestController
public class UpdateMessageController {
    @Resource
    private PersonRelationService personRelationService;

    @RequestMapping("/relation/update")
    public CommonResult updateMessage(@RequestParam("myName") String myName, @RequestParam("friendName") String friendName, @RequestParam("message") String message) {
        int res = personRelationService.updateMessage(myName, friendName, message, new Date());
        if(res == 1) {
            return new CommonResult(200, "更改成功");
        } else {
            return new CommonResult(444, "更改失败");
        }
    }
}
