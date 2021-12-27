package com.ssg.study.notice;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssg.study.common.FileManager;
import com.ssg.study.common.dao.CommonDAO;

@Service("notice.noticeService")
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertBoard(Notice dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Notice> listBoard(Map<String, Object> map) {
		List<Notice> list = null;
		
		try {
			list = dao.selectList("notice.listBoard", map);
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("notice.dataCount", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public Notice readBoard(int nNum) {
	Notice dto = null;
		
		try {
			dto = dao.selectOne("notice.readBoard", nNum);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public void updateHitCount(int nNum) throws Exception {
		try {
			dao.updateData("notice.updateHitCount", nNum);
		} catch (Exception e) {
		}
	}

	@Override
	public Notice preReadBoard(Map<String, Object> map) {
		Notice dto = null;
		try {
			dto = dao.selectOne("notice.preReadBoard", map);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public Notice nextReadBoard(Map<String, Object> map) {
		Notice dto = null;
		try {
			dto = dao.selectOne("notice.nextReadBoard", map);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public void updateBoard(Notice dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteBoard(int nNum, String pathname, String userId) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertFile(Notice dto) throws Exception {
		try {
			dao.insertData("notice.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Notice> listFile(int nNum) {
		List<Notice> listFile = null;
		
		try {
			listFile = dao.selectList("notice.listFile", nNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFile;
	}

	@Override
	public Notice readFile(int notice_fileNum) {
		Notice dto = null;
		
		try {
			dto = dao.selectOne("notice.readFile", notice_fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("notice.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("notice.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null;
		
		try {
			list = dao.selectList("notice.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("notice.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("notice.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
		List<Reply> list = null;
		
		try {
			list = dao.selectList("notice.listReplyAnswer", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result = 0;
		
		try {
			result = dao.selectOne("notice.replyAnswerCount", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertReplyLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("notice.insertReplyLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteReplyLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("notice.deleteReplyLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int replyLikeCount(int replyNum) {
		int result = 0;
		
		try {
			result = dao.selectOne("notice.replyLikeCount", replyNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public boolean userReplyLiked(Map<String, Object> map) throws Exception {
		boolean result = false;
		
		try {
			Notice dto = dao.selectOne("notice.userReplyLiked", map);
			if( dto!=null )
				result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
