package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Service.BoardService;
import Service.ReplyService;
import dto.BoardDto;
import dto.ReplyDto;


@WebServlet("/question/detail.do")
public class QuestionViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private BoardService boardservice = new BoardService();
	private ReplyService rsvc = new ReplyService();
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			String param = request.getParameter("boardno");
			
			int boardno=0;
			if(!"".equals(param) && param != null) {
				boardno = Integer.parseInt(param);
			}
			
			BoardDto dto = boardservice.getBoard(boardno);
			
			request.setAttribute("board", dto);		
			
			//추천수
			BoardDto recommend = new BoardDto();
			recommend.setBoardNo(boardno);
			recommend.setBoardUser((String) request.getSession().getAttribute("userId"));
			
			//추천 상태 정보 전달
			request.setAttribute("recommend", boardservice.recommendCheck(recommend));
			
			
			ArrayList<ReplyDto> dtos = rsvc.getReplyList(boardno);
			
			request.setAttribute("replyList", dtos);
			
			
			request.getRequestDispatcher("/QA/QAboard_detail.jsp").forward(request, response);
	}

}
