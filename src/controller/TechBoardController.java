package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Service.TechBoardService;
import board.util.Paging;
import dto.BoardDto;

/*
 * 수정일 : 2018.09.01
 * 수정자 : 안희민
 *  - 정렬 추가
 */

@WebServlet("/tech/tech.do")
public class TechBoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private TechBoardService tbsvc = new TechBoardService();
	private final String categoryName = "TechBoard";
	private String order = null; // 정렬
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 현재 페이지 
		String param = request.getParameter("curPage");
		
		int curPage = 0;
		if( !"".equals(param) && param != null ) {
			curPage = Integer.parseInt(
				request.getParameter("curPage") );
		}	// 페이지가 비어있거나 [""], null값일 때 curPage를 요청한다
		
		// 총 게시글 수
		int totalCount = tbsvc.getTotal(categoryName); // DB에서 카테고리게시물의 숫자를 가져옴

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
		List<BoardDto> boardList
			= tbsvc.getPagingList(paging, categoryName, order);

		// JSP에 전달할 MODEL 처리
		request.setAttribute("boardList", boardList);
		request.setAttribute("paging", paging);
		request.setAttribute("order", order); // 정렬
		
		
		request.getRequestDispatcher("/tech/techboard.jsp").forward(request,response);
	}
}