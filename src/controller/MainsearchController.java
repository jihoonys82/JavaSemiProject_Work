package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Service.BoardsearchService;
import board.util.Paging;
import dto.BoardDto;

/*
 * 작성일 : 2018.09.07
 * 작성자 : 안희민
 *  
 */
@WebServlet("/Main/search.do")
public class MainsearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    private BoardsearchService bssvc = new BoardsearchService();
 //   private final String categoryName ="MainBoard"; // category 삭제염두해 둬야함
    private String order = null;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		// 현재 페이지 
		String param = request.getParameter("curPage");
		String searchString = request.getParameter("searchString");
				
		int curPage = 0;
		if( !"".equals(param) && param != null ) {
			curPage = Integer.parseInt(
				request.getParameter("curPage") );
		}	// 페이지가 비어있거나 [""], null값일 때 curPage를 요청한다
				
		// 총 게시글 수
		int totalCount = bssvc.searchTotal(searchString); // DB에서 카테고리게시물의 숫자를 가져옴

		// Paging Class 계산하기
		Paging paging = new Paging(totalCount, curPage);	// 페이징 객체에서 현재페이지의 총게시물을 정리해서 게시물의 값을 가져옴
				
//		System.out.println(paging);
	
		
		// --- 정렬 방법 ---
		String orderParam = request.getParameter("order");
//		System.out.println("FreeboardController_orderParam : " + orderParam);
		
		
		if (orderParam == null || orderParam.isEmpty() || orderParam.equals("create")) {
			order = "create";
		} else if (orderParam.equals("read")) {
			order = orderParam;
		} else if (orderParam.equals("recommend")) {
			order = orderParam;
		}
//		System.out.println("TechBoardController_order : " + order);
		// --------------
		
		
		// 게시글 조회 결과
		//List<BoardDto> boardList = tbsvc.getPagingList(paging, categoryName, order);
		List<BoardDto> boardList = bssvc.getSearchList(paging, order, searchString);
		// JSP에 전달할 MODEL 처리
		request.setAttribute("boardList", boardList);
		request.setAttribute("paging", paging);
		request.setAttribute("order", order); // 정렬
		request.setAttribute("searchString", searchString);
		
		
		request.getRequestDispatcher("/main/mainboard_search.jsp").forward(request,response);
	}
}