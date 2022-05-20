package com.tianyufighter.myblog.controller.todo;

import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.todo.TodoService;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@RestController
public class UpdateTodoController {
    @Resource
    private TodoService todoService;

    @RequestMapping("/todo/update")
    public CommonResult updateTodo(@RequestParam("id") int id, @RequestParam("username") String username,
                                   @RequestParam("title") String title, @RequestParam("content") String content,
                                   @RequestParam("priority") int priority, @RequestParam("createDate") String createDate,
                                   @RequestParam("type") int type) {
        SimpleDateFormat sdf  = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        try {
            date = sdf.parse(createDate);
        } catch (ParseException e) {
        }
        int res = todoService.updateTodo(id, username, title, content, priority, date, type);
        if(res == 1) {
            return new CommonResult(200, "修改成功");
        } else {
            return new CommonResult(444, "修改失败");
        }
    }
}
