package com.ssg.study.todo;

import java.util.List;
import java.util.Map;

public interface TodoService {
	public void insertTodo(Todo dto, String pathname) throws Exception;
	public List<Todo> listTodo(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Todo readTodo(int todoNum);
	public Todo preReadTodo(Map<String, Object> map);
	public Todo nextReadTodo(Map<String, Object> map);
	public void updateTodo(Todo dto, String pathname) throws Exception;
	public void deleteTodo(int todoNum, String pathname, String userId) throws Exception;
	
	public void insertFile(Todo dto) throws Exception;
	public List<Todo> listFile(int todoNum);
	public Todo readFile(int fileNum);
	public void deleteFile(Map<String, Object> map)throws Exception;
	
}
