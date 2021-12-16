package com.ssg.study.calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssg.study.common.APISerializer;

@Controller("calendar.Controller")
@RequestMapping(value="/calendar/*")
public class CalendarController {
	@Autowired
	APISerializer apiSerializer;
	
	
	@RequestMapping(value = "test", method = RequestMethod.GET)
	public String testForm() {
		return ".calendar.test";
	}
	
	@RequestMapping(value="api",method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String apisch(
			@RequestParam String start,
			@RequestParam String end
			) throws Exception{
		String result = null;
		
		String spec= "https://open.neis.go.kr/hub/SchoolSchedule";
		String serviceKey="a5a7d869f2b74dbfb79f4bf0a1fa0036";
		
				// 한페이지 결과수
				Integer pSize=100;
				// 페이지번호
				Integer pIndex=1;
				// 데이터 타입-XML/JSON, 기본:XML
				String dataType="XML";
				String ATPT_OFCDC_SC_CODE = "N10";
				String SD_SCHUL_CODE = "8140246";
				
				
				spec+="?KEY="+serviceKey+"&pSize="+pSize+"&pIndex="+pIndex;
				spec+="&ATPT_OFCDC_SC_CODE="+ATPT_OFCDC_SC_CODE+"&SD_SCHUL_CODE="+SD_SCHUL_CODE;
				spec+="&Type="+dataType+"&AA_FROM_YMD="+start+"&AA_TO_YMD="+end;

				result = apiSerializer.receiveXmlToJson(spec);
		
		return result;
	}

	
}
