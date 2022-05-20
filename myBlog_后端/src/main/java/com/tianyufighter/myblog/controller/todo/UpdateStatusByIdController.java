package com.tianyufighter.myblog.controller.todo;

import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.service.todo.TodoService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
public class UpdateStatusByIdController {
    @Resource
    private TodoService todoService;

    @RequestMapping("/todo/updateStatus")
    public CommonResult updateStatus(@RequestParam("id") int id, @RequestParam("status") int status) {
        int res = todoService.updateStatusById(id, status);
        if(res == 1) {
            return new CommonResult(200, "修改成功");
        } else {
            return new CommonResult(444, "修改失败");
        }
    }
}
