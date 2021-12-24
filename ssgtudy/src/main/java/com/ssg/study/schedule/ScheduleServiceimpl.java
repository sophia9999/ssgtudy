package com.ssg.study.schedule;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssg.study.common.dao.CommonDAO;

@Service("Schedule.scheduleService")
public class ScheduleServiceimpl implements ScheduleService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertSchedule(Schedule dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Schedule> listMonth(Map<String, Object> map) throws Exception {
		List<Schedule> list = null;
		try {
			list=dao.selectList("schedule.listMonth", map);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	@Override
	public Schedule readSchedule(int num) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateSchedule(Schedule dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteSchedule(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
