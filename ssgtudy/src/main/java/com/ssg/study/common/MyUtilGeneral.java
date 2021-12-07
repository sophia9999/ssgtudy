package com.ssg.study.common;

import org.springframework.stereotype.Service;

@Service("myUtilGeneral")
public class MyUtilGeneral extends MyUtil {
		
	@Override
	public String paging(int current_page, int total_page, String list_url) {
		StringBuilder sb = new StringBuilder();
		
		int numPerBlock = 10;
		int currentPageSetup;
		int n, page;
		
		if(current_page < 1 || total_page < 1) {
			return "";
		}
		
		if(list_url.indexOf("?") != -1) {
			list_url += "&";
		} else {
			list_url += "?";
		}
		
		// currentPageSetup : 표시할첫페이지-1
		currentPageSetup = (current_page / numPerBlock) * numPerBlock;
		if(current_page % numPerBlock == 0) {
			currentPageSetup = currentPageSetup - numPerBlock;
		}

		sb.append("<div class='paginate'>");
		// 처음페이지, 이전(10페이지 전)
		n = current_page - numPerBlock;
		if(total_page > numPerBlock && currentPageSetup > 0) {
			sb.append("<a href='" + list_url + "page=1'>처음</a>");
			sb.append("<a href='" + list_url + "page=" + n + "'>이전</a>");
		}
		
		// 페이징
		page = currentPageSetup + 1;
		while(page <= total_page && page <= (currentPageSetup + numPerBlock)) {
			if(page == current_page) {
				sb.append("<span>" + page + "</span>");
			} else {
				sb.append("<a href='" + list_url + "page=" + page + "'>" + page + "</a>");
			}

			page++;
		}
		
		// 다음(10페이지 후), 마지막페이지
		n = current_page + numPerBlock;
		if(n > total_page) n = total_page;
		if(total_page - currentPageSetup > numPerBlock) {
			sb.append("<a href='" + list_url + "page=" + n + "'>다음</a>");
			sb.append("<a href='" + list_url + "page=" + total_page + "'>끝</a>");
		}
		sb.append("</div>");
	
		return sb.toString();
	}

	@Override
    public String pagingMethod(int current_page, int total_page, String methodName) {
    	StringBuilder sb = new StringBuilder();

        int numPerBlock = 10;   // 리스트에 나타낼 페이지 수
        int currentPageSetUp;
        int n, page;
        
        if(current_page < 1 || total_page < 1) {
        	return "";
        }
        
        // currentPageSetup : 표시할첫페이지-1
        currentPageSetUp = (current_page / numPerBlock) * numPerBlock;
        if (current_page % numPerBlock == 0) {
            currentPageSetUp = currentPageSetUp - numPerBlock;
        }

		sb.append("<div class='paginate'>");
        
        // 처음페이지, 이전(10페이지 전)
        n = current_page - numPerBlock;
        if ((total_page > numPerBlock) && (currentPageSetUp > 0)) {
			sb.append("<a onclick='" + methodName + "(1);'>처음</a>");
			sb.append("<a onclick='" + methodName + "(" + n + ");'>이전</a>");
        }

        // 페이지징
        page = currentPageSetUp + 1;
        while((page <= total_page) && (page <= currentPageSetUp + numPerBlock)) {
           if(page == current_page) {
        	   sb.append("<span>" + page + "</span>");
           } else {
			   sb.append("<a onclick='" + methodName + "(" + page + ");'>" + page + "</a>");
           }
           page++;
        }

        // 다음(10페이지 후), 마지막 페이지
        n = current_page + numPerBlock;
		if(n > total_page) n = total_page;
        if (total_page - currentPageSetUp > numPerBlock) {
			sb.append("<a onclick='" + methodName + "(" + n + ");'>다음</a>");
			sb.append("<a onclick='" + methodName + "(" + total_page + ");'>끝</a>");
        }
		sb.append("</div>");

        return sb.toString();
    }
}
