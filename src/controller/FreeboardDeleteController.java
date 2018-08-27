package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Service.BoardService;
import dto.BoardDto;

@WebServlet("/Freeboard/delete.do")
public class FreeboardDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private BoardService boardService = new BoardService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//boardno 파라미터 얻어오기 
		String param = request.getParameter("boardNo");
		
		int boardno=0;
		if(!"".equals(param) && param != null) {
			boardno = Integer.parseInt(param);
		}
		
		//BoardDto 객체 생성
		BoardDto boarddto = new BoardDto();
		boarddto.setBoardNo(boardno);
		
		// 서비스에 매개변수로 boardno 전달 
		
		
		
		// 리다이렉트 (게시글 리스트 보기화면으로)
		response.sendRedirect("/Freeboard/free.do");
		
		
	}

}
