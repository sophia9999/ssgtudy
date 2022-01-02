package com.ssg.study.community;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ssg.study.common.FileManager;
import com.ssg.study.common.dao.CommonDAO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service("community.communityService")
public class CommunityServiceImpl implements CommunityService {
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertBoard(Community dto, String pathname) throws Exception {
		try {
			int seq = dao.selectOne("community.seq");
			dto.setBoardNum(seq);
			
			dao.insertData("community.insertBoard", dto);
			
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
	public List<Community> listBoard(Map<String, Object> map) {
		List<Community> list = null;
		
		try {
			list = dao.selectList("community.listBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("community.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Community readBoard(int boardNum) {
		Community dto = null;
		
		try {
			dto = dao.selectOne("community.readBoard", boardNum)
;		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateHitCount(int boardNum) throws Exception {
		try {
			dao.updateData("community.updateHitCount", boardNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}	
	}

	@Override
	public Community preReadBoard(Map<String, Object> map) {
		Community dto = null;
		
		try {
			dto = dao.selectOne("community.preReadBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Community nextReadBoard(Map<String, Object> map) {
		Community dto = null;
		
		try {
			dto = dao.selectOne("community.nextReadBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateBoard(Community dto, String pathname) throws Exception {
		try {
			dao.updateData("community.updateBoard", dto);
			
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
	public void deleteBoard(int boardNum, String pathname, String userId, int membership) throws Exception {
		try {
			List<Community> listFile = listFile(boardNum);
			if(listFile != null) {
				for(Community dto : listFile) {
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("field", "boardNum");
			map.put("boardNum", boardNum);
			deleteFile(map);
			
			dao.deleteData("community.deleteBoard", boardNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void deleteBoardList(List<String> chkRow, String pathname, String userId, int membership) {
		try {
			dao.deleteData("community.deleteBoardList", chkRow);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void insertBoardLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("community.insertBoardLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteBoardLike(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("community.deleteBoardLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int boardLikeCount(int boardNum) {
		int result = 0;
		
		try {
			result = dao.selectOne("community.boardLikeCount", boardNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public boolean userBoardLiked(Map<String, Object> map) {
		boolean result = false;
		try {
			Community dto = dao.selectOne("community.userBoardLiked", map);
			if(dto != null) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("community.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null;
		
		try {
			list = dao.selectList("community.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("community.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("community.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
		List<Reply> list = null;
		
		try {
			list = dao.selectList("community.listReplyAnswer", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result = 0;
		
		try {
			result = dao.selectOne("community.replyAnswerCount", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertReplyLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("community.insertReplyLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public int replyLikeCount(int replyNum) {
		int result = 0;
		
		try {
			result = dao.selectOne("community.replyLikeCount", replyNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	

	@Override
	public void deleteReplyLike(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("community.deleteReplyLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public boolean userReplyLiked(Map<String, Object> map) throws Exception {
		boolean result = false;
		
		try {
			Community dto = dao.selectOne("community.userReplyLiked", map);
			if(dto != null) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	
	// 파일 처리
	@Override
	public void insertFile(Community dto) throws Exception {
		try {
			dao.insertData("community.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Community> listFile(int boardNum) {
		List<Community> listFile = null; 
		
		try {
			listFile = dao.selectList("community.listFile", boardNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFile;
	}

	@Override
	public Community readFile(int fileNum) {
		Community dto = null;
				
		try {
			dto = dao.selectOne("community.readFile", fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		return dto;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("community.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertBoardReport(Community dto) throws Exception {
		try {
			dao.insertData("community.insertBoardReport", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertReplyReport(Reply dto) throws Exception {
		try {
			dao.insertData("community.insertReplyReport", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
