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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.UUID;

/*
* 上传封面图片
* */
@RestController
public class UploadCoverPhotoController {
    @Resource
    private ArticleService articleService;

    @RequestMapping(value = "/article/imgupload", method = RequestMethod.POST)
    public CommonResult storeInfo(HttpServletRequest request) {
        String username = request.getParameter("username");
        String title = request.getParameter("title");
        String label = request.getParameter("label");
        int id = articleService.getIdByUsernameAndTitle(username, title, label);
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
        // 将用户信息存储数据库
        int res = articleService.insertCoverPhoto("http://192.168.242.1/images/" + newFileName, id);
        if(res == 1) {
            return new CommonResult(200, "数据存储成功");
        } else {
            System.out.println("数据存储失败");
            return new CommonResult(444, "数据存储失败");
        }
    }
}
