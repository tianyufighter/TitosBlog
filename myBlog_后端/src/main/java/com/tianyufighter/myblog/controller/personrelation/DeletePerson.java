package com.tianyufighter.myblog.controller.personrelation;

import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.chat.ChatService;
import com.tianyufighter.myblog.service.personrelation.PersonRelationService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
public class DeletePerson {
    @Resource
    private PersonRelationService personRelationService;
    @Resource
    private ChatService chatService;

    @RequestMapping("/relation/deleteLiaison")
    public CommonResult deleteLiaison(@RequestParam("myName") String myName, @RequestParam("friendName") String friendName) {
        int res = personRelationService.deleteLiaison(myName, friendName);
        int res2 = chatService.deleteMessage(myName, friendName);
        if(res != 0) {
            return new CommonResult(200, "删除成功");
        } else {
            return new CommonResult(444, "删除失败");
        }
    }
}
