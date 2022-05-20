package com.tianyufighter.myblog.controller.chat;

import com.tianyufighter.myblog.model.Chat;
import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.chat.ChatService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController
public class QueryAllMessageController {
    @Resource
    private ChatService chatService;

    @RequestMapping("/chat/queryAllMessage")
    public CommonResult<List<Chat>> queryAllMessage(@RequestParam("sendUsername") String sendUsername, @RequestParam("receiveUsername") String receiveUsername) {
        List<Chat> res = chatService.queryAllChat(sendUsername, receiveUsername);
        chatService.updateChat(sendUsername, receiveUsername);
        if(res != null) {
            return new CommonResult<>(200, "查询成功", res);
        } else {
            return new CommonResult<>(444, "查询失败");
        }
    }
}
