package com.tianyufighter.myblog.controller.chat;

import com.tianyufighter.myblog.model.Chat;
import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.chat.ChatService;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;

@RestController
public class SendMessageController {
    @Resource
    private ChatService chatService;

    @RequestMapping("/chat/sendMessage")
    public CommonResult<Chat> sendMessage(Chat chat) {
        chat.setSendTime(new Date());
        chat.setComplete(false);
        int res = chatService.insertChat(chat);
        if(res == 1) {
            return new CommonResult(200, "存储成功", chat);
        } else {
            return new CommonResult(444, "存储失败");
        }
    }
}
