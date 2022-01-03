package com.ssg.study.school;

import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssg.study.common.APISerializer;
@Controller("school.schoolController")
@RequestMapping("school/*")
public class SchoolController {
	
	@Autowired
	APISerializer apiSerializer;

	

	@RequestMapping(value="findSchool",method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String findSchool(
			@RequestParam String schoolType,
			@RequestParam String schoolName
			) throws Exception{
		String result = null;
		System.out.println("gg");
		
		
		String spec= "https://open.neis.go.kr/hub/schoolInfo";
		String serviceKey="a5a7d869f2b74dbfb79f4bf0a1fa0036";
		
				// 한페이지 결과수
				Integer pSize=100;
				// 페이지번호
				Integer pIndex=1;
				// 데이터 타입-XML/JSON, 기본:XML
				String dataType="XML";
				schoolName = URLEncoder.encode(schoolName, "UTF-8");
				schoolType = URLEncoder.encode(schoolType, "UTF-8");
				
				spec+="?KEY="+serviceKey+"&pSize="+pSize+"&pIndex="+pIndex;
				spec+="&SCHUL_NM="+schoolName+"&SCHUL_KND_SC_NM="+schoolType;
				spec+="&Type="+dataType;
				
				System.out.println(spec);
				
				result = apiSerializer.receiveXmlToJson(spec);
		
		return result;
	}
	
	
}
