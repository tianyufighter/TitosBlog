package com.tianyufighter.myblog.dao;

import com.tianyufighter.myblog.model.Todo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

@Mapper
public interface TodoDao {
    int insertTodo(@Param("username") String username, @Param("title") String title, @Param("content") String content, @Param("priority") int priority, @Param("createDate") Date createDate, @Param("type") int type);
    // 根据任务号来修改任务
    int updateTodo(@Param("id") int id, @Param("username") String username, @Param("title") String title, @Param("content") String content, @Param("priority") int priority, @Param("createDate") Date createDate, @Param("type") int type);
    // 根据用户名、待办类型查询该用户所有未完成的任务
    List<Todo> queryTodo(@Param("username") String username, @Param("type") int type, @Param("status") int status);
    // 根据任务号删除任务
    int deleteTodoById(@Param("id") int id);
    // 根据任务号更改任务的状态
    int updateStatusById(@Param("id") int id, @Param("status") int status);
}