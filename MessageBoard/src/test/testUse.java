package test;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import MessageBoard.Dao.DbOperator;
import MessageBoard.Object.User;

public class testUse extends HttpServlet {

	private DbOperator dbOperator;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		dbOperator = DbOperator.getDbOperator();
		ArrayList<User> useList = dbOperator.getUse();
		response.setCharacterEncoding("utf-8");
		for(User u:useList){
			response.getWriter().println(u.getUname());
		}
		
	}


}
