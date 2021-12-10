package com.ssg.study.msg;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service("msg.msgService")
public class MsgServiceImpl implements MsgService{

	@Override
	public List<Msg> msgList(Map<String, Object> map) {

		return null;
	}

}
