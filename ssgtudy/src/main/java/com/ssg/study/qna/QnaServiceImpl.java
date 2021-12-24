package com.ssg.study.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ssg.study.common.FileManager;
import com.ssg.study.common.dao.CommonDAO;

@Service("qna.qnaService")
public class QnaServiceImpl implements QnaService {
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertBoard(Qna dto, String pathname) throws Exception {
		try {
			int seq = dao.selectOne("qna.seq");
			dto.setQnaNum(seq);
			
			dao.insertData("qna.insertBoard", dto);
			
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
	public List<Qna> listBoard(Map<String, Object> map) {
		List<Qna> list = null;
		
		try {
			list = dao.selectList("qna.listBoard", map);
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("qna.dataCount", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public Qna readBoard(int qnaNum) {
		Qna dto = null;
		
		try {
			dto = dao.selectOne("qna.readBoard", qnaNum);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public void updateHitCount(int qnaNum) throws Exception {
		try {
			dao.updateData("qna.updateHitCount", qnaNum);
		} catch (Exception e) {
		}
		
	}

	@Override
	public Qna preReadBoard(Map<String, Object> map) {
		Qna dto = null;
		try {
			dto = dao.selectOne("qna.preReadBoard", map);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public Qna nextReadBoard(Map<String, Object> map) {
		Qna dto = null;
		try {
			dto = dao.selectOne("qna.preReadBoard", map);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public void updateBoard(Qna dto, String pathname) throws Exception {
		try {
			dao.updateData("qna.updateBoard", dto);
			
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
	public void deleteBoard(int qnaNum, String pathname, String userId) throws Exception {
		try {
			//파일지우기
			List<Qna> listFile = listFile(qnaNum);
			if(listFile != null) {
				for( Qna dto : listFile) {
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			
			//파일테이블 내용 지우기
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "qnaNum");
			map.put("qnaNum", qnaNum);
			deleteFile(map);
			
			dao.deleteData("qna.deleteBoard", qnaNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertFile(Qna dto) throws Exception {
		try {
			dao.insertData("qna.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Qna> listFile(int qnaNum) {
		List<Qna> listFile = null;
		
		try {
			listFile = dao.selectList("qna.listFile", qnaNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFile;
	}

	@Override
	public Qna readFile(int qnafileNum) {
		Qna dto = null;
		
		try {
			dto = dao.selectOne("qna.readFile", qnafileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("qna.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("qna.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null;
		
		try {
			list = dao.selectList("qna.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("qna.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("qna.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
		List<Reply> list = null;
		
		try {
			list = dao.selectList("qna.listReplyAnswer", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result = 0;
		
		try {
			result = dao.selectOne("qna.replyAnswerCount", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@Override
	public void insertBoardLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("qna.insertBoardLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteBoardLike(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("qna.deleteBoardLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	@Override
	public int boardLikeCount(int qnaNum) {
		int result = 0;
		
		try {
			result = dao.selectOne("qna.boardLikeCount", qnaNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public boolean userBoardLiked(Map<String, Object> map) {
		boolean result = false;
		
		try {
			Qna dto = dao.selectOne("qna.userBoardLiked", map);
			if(dto != null) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertReplyLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("qna.insertReplyLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteReplyLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("qna.deleteReplyLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public int replyLikeCount(int replyNum) {
		int result = 0;
		
		try {
			result = dao.selectOne("qna.replyLikeCount", replyNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public boolean userReplyLiked(Map<String, Object> map) throws Exception {
		boolean result = false;
		
		try {
			Qna dto = dao.selectOne("qna.userReplyLiked", map);
			if( dto!=null )
				result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int insertQnaReport(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = dao.insertData("qna.insertQnaReport", map);
		} catch (Exception e) {
		}
		return result;
	}


}
