package com.ssg.study.todo;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssg.study.common.FileManager;
import com.ssg.study.common.dao.CommonDAO;

@Service("todo.TodoService")
public class TodoServiceImpl implements TodoService{
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	
	
	
	@Override
	public void insertTodo(Todo dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Todo> listTodo(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Todo readTodo(int todoNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Todo preReadTodo(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Todo nextReadTodo(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateTodo(Todo dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteTodo(int todoNum, String pathname, String userId) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertFile(Todo dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Todo> listFile(int todoNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Todo readFile(int todo_fileNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

}
