package com.tianyufighter.myblog.service.todo.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tianyufighter.myblog.dao.TodoDao;
import com.tianyufighter.myblog.model.Todo;
import com.tianyufighter.myblog.service.todo.TodoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@Service
public class TodoServiceImpl implements TodoService {
    @Resource
    private TodoDao todoDao;

    @Override
    public int insertTodo(String username, String title, String content, int priority, Date createDate, int type) {
        return todoDao.insertTodo(username, title, content, priority, createDate, type);
    }

    @Override
    public int updateTodo(int id, String username, String title, String content, int priority, Date createDate, int type) {
        return todoDao.updateTodo(id, username, title, content, priority, createDate, type);
    }

    @Override
    public List<Todo> queryTodo(String username, int type, int status) {
        return todoDao.queryTodo(username, type, status);
    }

    @Override
    public PageInfo<Todo> getTodoByPage(int pageNum, int pageSize, String username, int type, int status) {
        PageHelper.startPage(pageNum, pageSize);
//        PageHelper.orderBy("create_date desc");
        PageHelper.orderBy("create_date");
        List<Todo> lists = todoDao.queryTodo(username, type, status);
        Collections.reverse(lists);
        PageInfo<Todo> pageInfo = new PageInfo<>(lists, pageSize);
        return pageInfo;
    }

    @Override
    public int deleteTodoById(int id) {
        return todoDao.deleteTodoById(id);
    }

    @Override
    public int updateStatusById(int id, int status) {
        return todoDao.updateStatusById(id, status);
    }
}
