package com.tianyufighter.myblog.controller.chat;

import com.tianyufighter.myblog.model.Chat;
import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.chat.ChatService;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

/**
 * 查询未接收消息
 */
@RestController
public class QueryNoAcceptController {
    @Resource
    private ChatService chatService;

    @RequestMapping("/chat/queryNoAccept")
    public CommonResult<List<Chat>> queryNoAccept(@Param("sendUsername") String sendUsername, @Param("receiveUsername") String receiveUsername) {
        List<Chat> lists = chatService.queryChatByName(sendUsername, receiveUsername);
        int res = chatService.updateChat(sendUsername, receiveUsername);
        if(lists != null && res != 0) {
            return new CommonResult<>(200, "查询成功", lists);
        } else {
            return new CommonResult<>(444, "查询失败");
        }
    }
}
