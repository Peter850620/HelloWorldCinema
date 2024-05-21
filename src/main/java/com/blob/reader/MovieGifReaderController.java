package com.blob.reader;

import java.io.IOException;

import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.service.MovieServiceYuan;

@WebServlet("/movie/MovieGifReader")
public class MovieGifReaderController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)throws ServletException, IOException{
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
		
		try {
			Integer movieId = Integer.valueOf(req.getParameter("movieId"));
			MovieServiceYuan movieSvc = new MovieServiceYuan();
			out.write(movieSvc.getOneMovie(movieId).getPoster());
		}catch(Exception e) {
			InputStream in = getServletContext().getResourceAsStream("resources/NoData/nopic.jpg");
			byte[] buf = new byte[in.available()];
			in.read(buf);
			out.write(buf);
			in.close();
		}
	}
}
