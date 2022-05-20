package com.tianyufighter.myblog.controller.chat;

import com.tianyufighter.myblog.model.Chat;
import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.chat.ChatService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.util.WebUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;

/**
 * 发送图片
 */
@RestController
public class SendPictureController {
    @Resource
    private ChatService chatService;

    @RequestMapping("/chat/sendPicture")
    public CommonResult<Chat> sendPicture(HttpServletRequest request) {
        // 获取上传的文件
        MultipartHttpServletRequest multipartRequest = WebUtils.getNativeRequest(request, MultipartHttpServletRequest.class);
        MultipartFile multipartFile = multipartRequest.getFile("file");
        // 文件名
        String fileName = multipartFile.getOriginalFilename();
        // 文件保存路径
        String filePath = "D:\\JavaProject\\myBlog\\src\\main\\resources\\static\\images\\";
        // 判断文件夹是否存在，不存在则创建
        File file = new File(filePath);
        if(!file.exists()) {
            file.mkdirs();
        }
        String newFileName = UUID.randomUUID() + fileName;
        String newFilePath = filePath + newFileName;
        try {
            // 将图片存到指定的位置
            multipartFile.transferTo(new File(newFilePath));
        } catch (IOException e) {
            e.printStackTrace();
        }
        Chat chat = new Chat();
        chat.setSendUsername(request.getParameter("sendUsername"));
        chat.setReceiveUsername(request.getParameter("receiveUsername"));
        chat.setImageUrl("http://192.168.242.1/images/" + newFileName);
        chat.setSendTime(new Date());
        chat.setMessage("");
        chat.setComplete(false);
        int res = chatService.insertChat(chat);
        if(res == 1) {
            return new CommonResult(200, "存储成功", chat);
        } else {
            return new CommonResult(444, "存储失败");
        }
    }
}
