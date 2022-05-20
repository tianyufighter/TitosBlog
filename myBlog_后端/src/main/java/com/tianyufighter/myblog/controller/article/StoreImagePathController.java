package com.tianyufighter.myblog.controller.article;

import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.article.ArticleService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.util.WebUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

/*
* 存储文章中内容图片
* */
@RestController
public class StoreImagePathController {

    @RequestMapping(value = "/article/storeArticleImage", method = RequestMethod.POST)
    public CommonResult storeInfo(HttpServletRequest request) {
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
            return new CommonResult(200, "http://192.168.242.1/images/" + newFileName);
        } catch (IOException e) {
            return new CommonResult(444, "");
        }
    }
}
