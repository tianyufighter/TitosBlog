package com.tianyufighter.myblog.controller.todo;

import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.todo.TodoService;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
public class DeleteTodoByIdController {
    @Resource
    private TodoService todoService;

    @RequestMapping("/todo/deleteById")
    public CommonResult deleteTodoById(@RequestParam("id") int id) {
        int res = todoService.deleteTodoById(id);
        if(res == 1) {
            return new CommonResult(200, "删除成功");
        } else {
            return new CommonResult(444, "删除失败");
        }
    }
}
