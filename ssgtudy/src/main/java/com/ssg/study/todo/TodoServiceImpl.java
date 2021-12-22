package com.ssg.study.todo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
		try {
			int seq = dao.selectOne("todo.seq");
			dto.setTodoNum(seq);
			
			dao.insertData("todo.insertTodo", dto);
			
			// 파일 업로드
			if(! dto.getSelectFile().isEmpty()) {
				for(MultipartFile mf : dto.getSelectFile()) {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename == null) {
						continue;
					}
					
					String originalFilename = mf.getOriginalFilename();
					long fileSize = mf.getSize();
					
					dto.setOriginalFilename(originalFilename);
					dto.setSaveFilename(saveFilename);
					dto.setFileSize(fileSize);
					
					insertFile(dto);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Todo> listTodo(Map<String, Object> map) {
		List<Todo> list = null;
		
		try {
			list = dao.selectList("todo.listTodo", map);
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public Todo readTodo(int todoNum) {
		Todo dto = null;
		 
		try {
			dto = dao.selectOne("todo.readTodo", todoNum);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public Todo preReadTodo(Map<String, Object> map) {
		Todo dto = null;
		try {
			dto = dao.selectOne("todo.preReadTodo", map);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public Todo nextReadTodo(Map<String, Object> map) {
		Todo dto = null;
		try {
			dto = dao.selectOne("todo.nextReadTodo", map);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public void updateTodo(Todo dto, String pathname) throws Exception {

		try {
			dao.updateData("todo.updateTodo", dto);
			
			if( ! dto.getSelectFile().isEmpty()) {
				for(MultipartFile mf : dto.getSelectFile()) {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if(saveFilename == null) {
						continue;
					}
					
					String originalFilename = mf.getOriginalFilename();
					long fileSize = mf.getSize();
					
					dto.setOriginalFilename(originalFilename);
					dto.setSaveFilename(saveFilename);
					dto.setFileSize(fileSize);
					
					insertFile(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteTodo(int todoNum, String pathname, String userId) throws Exception {
		try {
			
			//파일 지우기
			List<Todo> listFile = listFile(todoNum);
			if(listFile != null) {
				for( Todo dto : listFile) {
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			
			// 파일테이블 내용 지우기
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "todoNum");
			map.put("todoNum", todoNum);
			deleteFile(map);
			
			dao.deleteData("todo.deleteTodo", todoNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void insertFile(Todo dto) throws Exception {
		try {
			dao.insertData("todo.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
			
	}

	@Override
	public List<Todo> listFile(int todoNum) {
		List<Todo> listFile = null;
		
		try {
			listFile = dao.selectList("todo.listFile", todoNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFile;
	}

	@Override
	public Todo readFile(int fileNum) {
		Todo dto = null;
		
		try {
			dto = dao.selectOne("todo.readFile", fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("todo.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("todo.dataCount", map);
		} catch (Exception e) {
		}
		return result;
	}

}
