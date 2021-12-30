package com.ssg.study.communitySch;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssg.study.common.dao.CommonDAO;

@Service("communitySch.scheduleService")
public class ScheduleServiceImpl implements ScheduleService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertSchedule(Schedule dto) throws Exception {
		try {
			if(dto.getAll_day()!=null) {
				dto.setStartTime("");
				dto.setEndTime("");
			}
			
			if(dto.getStartTime().length()==0&&dto.getEndTime().length()==0&&dto.getStartDate().equals(dto.getEndDate()))
			 dto.setEndDate("");
			
			if(dto.getRepeat_cycle()!=0) {
				dto.setEndDate("");
				dto.setStartTime("");
				dto.setEndTime("");
			}
			
			dao.insertData("communitySch.insertSchedule", dto);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public List<Schedule> listMonth(Map<String, Object> map) throws Exception {
		List<Schedule> list = null;
		try {
			list = dao.selectList("communitySch.listMonth", map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public Schedule readSchedule(int scheduleNum) throws Exception {
		Schedule dto = null;
		try {
			dto = dao.selectOne("communitySch.readSchedule", scheduleNum);
		} catch (Exception e) {
			throw e;
		}
		return dto;
	}

	@Override
	public void updateSchedule(Schedule dto) throws Exception {
		try {
			if(dto.getAll_day()!=null) {
				dto.setStartTime("");
				dto.setEndTime("");
			}
			
			if(dto.getStartTime().length()==0&&dto.getEndTime().length()==0&&dto.getStartDate().equals(dto.getEndDate()))
				dto.setEndDate("");
			
			if(dto.getRepeat_cycle()!=0) {
				dto.setEndDate("");
				dto.setStartTime("");
				dto.setEndTime("");
			}
			dao.updateData("communitySch.updateSchedule", dto);
		} catch (Exception e) {
			throw e;
		}
		
	}

	@Override
	public void deleteSchedule(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("communitySch.deleteSchedule", map);
		} catch (Exception e) {
			throw e;
		}
		
	}
}
