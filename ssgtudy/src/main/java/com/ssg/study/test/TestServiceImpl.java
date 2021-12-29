package com.ssg.study.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ssg.study.common.FileManager;
import com.ssg.study.common.dao.CommonDAO;
import com.ssg.study.notice.Notice;

@Service("test.testService")
public class TestServiceImpl implements TestService {
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertBoard(Mock dto, String pathname) throws Exception {
		try {
			int seq = dao.selectOne("test.seq");
			dto.setTestNum(seq);
			
			dao.insertData("test.insertBoard", dto);
			
			//파일업로드
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
	public List<Mock> listBoard(Map<String, Object> map) {
		List<Mock> list = null;
		
		try {
			list = dao.selectList("test.listBoard", map);
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("test.dataCount", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public Mock readBoard(int testNum) {
		Mock dto = null;
		
		try {
			dto = dao.selectOne("test.readBoard", testNum);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public void updateHitCount(int testNum) throws Exception {
		try {
			dao.updateData("test.updateHitCount", testNum);
		} catch (Exception e) {
		}
	}

	@Override
	public Mock preReadBoard(Map<String, Object> map) {
		Mock dto = null;
		try {
			dto = dao.selectOne("test.preReadBoard", map);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public Mock nextReadBoard(Map<String, Object> map) {
		Mock dto = null;
		try {
			dto = dao.selectOne("test.nextReadBoard", map);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public void updateBoard(Mock dto, String pathname) throws Exception {
		try {
			dao.updateData("test.updateBoard", dto);
			
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
	public void deleteBoard(int testNum, String pathname, String userId) throws Exception {
		try {
			
			//파일지우기
			List<Mock> listFile = listFile(testNum);
			if(listFile != null) {
				for( Mock dto : listFile) {
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			
			//파일테이블 내용 지우기
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "testNum");
			map.put("testNum", testNum);
			deleteFile(map);
			
			dao.deleteData("test.deleteBoard", testNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertFile(Mock dto) throws Exception {
		try {
			dao.insertData("test.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Mock> listFile(int testNum) {
		List<Mock> listFile = null;
		
		try {
			listFile = dao.selectList("test.listFile", testNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFile;
	}

	@Override
	public Mock readFile(int test_fileNum) {
		Mock dto = null;
		
		try {
			dto = dao.selectOne("test.readFile", test_fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("test.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("test.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null;
		
		try {
			list = dao.selectList("test.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("test.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("test.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
	List<Reply> list = null;
		
		try {
			list = dao.selectList("test.listReplyAnswer", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result = 0;
		
		try {
			result = dao.selectOne("test.replyAnswerCount", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertReplyLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("test.insertReplyLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteReplyLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("test.deleteReplyLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int replyLikeCount(int replyNum) {
	int result = 0;
		
		try {
			result = dao.selectOne("test.replyLikeCount", replyNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public boolean userReplyLiked(Map<String, Object> map) throws Exception {
		boolean result = false;
		
		try {
			Mock dto = dao.selectOne("test.userReplyLiked", map);
			if( dto!=null )
				result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
