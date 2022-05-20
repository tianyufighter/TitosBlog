package com.tianyufighter.myblog.service.todo;

import com.github.pagehelper.PageInfo;
import com.tianyufighter.myblog.model.Todo;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface TodoService {
    int insertTodo(String username, String title, String content, int priority, Date createDate, int type);
    // 根据任务号来修改任务
    int updateTodo(int id, String username, String title, String content, int priority, Date createDate, int type);
    // 根据用户名、待办类型查询该用户所有未完成的任务
    List<Todo> queryTodo(String username, int type, int status);
    PageInfo<Todo> getTodoByPage(int pageNum, int pageSize, String username, int type, int status);
    // 根据任务号删除任务
    int deleteTodoById(@Param("id") int id);
    // 根据任务号更改任务的状态
    int updateStatusById(int id, int status);
}
