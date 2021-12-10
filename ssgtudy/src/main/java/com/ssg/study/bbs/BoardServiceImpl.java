package com.ssg.study.bbs;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssg.study.common.dao.CommonDAO;

@Service("bbs.boardService")
public class BoardServiceImpl implements BoardService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertBoard(Board dto) throws Exception {
		try {
			dao.insertData("bbs.insertBoard", dto);
		} catch (Exception e) {
			throw e;
		}
		
	}

	@Override
	public List<Board> listBoard(Map<String, Object> map) {
		List<Board> list = null;
		
		try {
			list = dao.selectList("bbs.listBoard", map);
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("bbs.dataCount", map);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public Board readBoard(int bbsNum) {
		Board dto = null;
		
		try {
			dto = dao.selectOne("bbs.readBoard", bbsNum);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public void updateHitCount(int bbsNum) throws Exception {
		try {
			dao.updateData("bbs.updateHitCount", bbsNum);
		} catch (Exception e) {
		}
		
	}

	@Override
	public Board preReadBoard(Map<String, Object> map) {
		Board dto = null;
		try {
			dto = dao.selectOne("bbs.preReadBoard", map);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public Board nextReadBoard(Map<String, Object> map) {
		Board dto = null;
		try {
			dto = dao.selectOne("bbs.nextReadBoard", map);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public void updateBoard(Board dto) throws Exception {
		try {
			dao.updateData("bbs.updateBoard", dto);
		} catch (Exception e) {
		}
		
	}

	@Override
	public void deleteBaord(int bbsNum) throws Exception {
		try {
			dao.deleteData("bbs.deleteBoard", bbsNum);
		} catch (Exception e) {
		}
	}
}
