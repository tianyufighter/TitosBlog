package com.tianyufighter.myblog.controller.todo;

import com.github.pagehelper.PageInfo;
import com.tianyufighter.myblog.model.CommonResult;
import com.tianyufighter.myblog.model.Todo;
import com.tianyufighter.myblog.service.todo.TodoService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

/**
 * 根据用户名和任务类型分页查询其数据
 */
@RestController
public class QueryTodoByPageController {
    @Resource
    private TodoService todoService;

    @RequestMapping("/todo/query")
    public CommonResult<PageInfo<Todo>> queryTodoByPage(@RequestParam("pageNum") int pageNum, @RequestParam("pageSize") int pageSize,
                                                        @RequestParam("username") String username, @RequestParam("type") int type,
                                                        @RequestParam("status") int status) {
        PageInfo<Todo> pageInfo = todoService.getTodoByPage(pageNum, pageSize, username, type, status);
        if(pageInfo != null) {
            return new CommonResult<>(200, "在数据库中成功找到请求数据", pageInfo);
        } else {
            return new CommonResult<>(444, "未在数据库中找到请求数据", pageInfo);
        }
    }
}
