package cn.ruc.edu.result;

import cn.ruc.edu.basecore.QueryFileName;
import cn.ruc.edu.mbdatagen.Testpath;

import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ResultShow extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		String dbLogFilePath = "";
		if(session.getAttribute("transLogPath") != null){
			dbLogFilePath = (String) session.getAttribute("transLogPath");
			dbLogFilePath = dbLogFilePath.substring(0, dbLogFilePath.lastIndexOf("/"));
		}
		else
			dbLogFilePath = (String) session.getAttribute("logpath") +
					"/" + (String) session.getAttribute("databasetype");

		String path = Testpath.class.getClassLoader().getResource("HistorySettings").getPath();
		if(request.getParameter("type").equals("dbinfo"))
		{
			String copynum = request.getParameter("copynum");
			session.setAttribute("copynum", copynum);
			System.out.println(copynum);
			FileReader file = new FileReader(dbLogFilePath + "/" + copynum + "/dbinfo.txt");

			BufferedReader reader = new BufferedReader(file);
			String loadfile = reader.readLine();
			String loadfiletime = loadfile.split(",")[0];
			String loadfilespeed = loadfile.split(",")[1];
			String loadmeta = reader.readLine();
			String loadmetatime = loadmeta.split(",")[0];
			String loadmetaspeed = loadmeta.split(",")[1];
			String downfile = reader.readLine();
			String downfiletime = downfile.split(",")[0];
			String downfilespeed = downfile.split(",")[1];
			String downmeta = reader.readLine();
			String downmetatime = downmeta.split(",")[0];
			String downmetaspeed = downmeta.split(",")[1];
			String rates = reader.readLine();
			String filenum = reader.readLine();
			String dbname = reader.readLine();
			String storagesize = reader.readLine();

			System.out.println("{\"loadfiletime\":\"" + loadfiletime + "\","
					+ "\"loadfilespeed\":\""+ loadfilespeed + "\","
					+ "\"loadmetatime\":\""+ loadmetatime + "\","
					+ "\"loadmetaspeed\":\""+ loadmetaspeed + "\","
					+ "\"downfiletime\":\""+ downfiletime + "\","
					+ "\"downfilespeed\":\""+ downfilespeed + "\","
					+ "\"downmetatime\":\""+ downmetatime + "\","
					+ "\"downmetaspeed\":\""+ downmetaspeed + "\","
					+ "\"rates\":\"" + rates+ "\","
					+ "\"filenum\":\"" + filenum+ "\","
					+ "\"dbname\":\"" + dbname+ "\","
					+ "\"storagesize\":\"" + storagesize
					+ "\"}");

			response.getWriter().write("{\"loadfiletime\":\"" + loadfiletime + "\","
					+ "\"loadfilespeed\":\""+ loadfilespeed + "\","
					+ "\"loadmetatime\":\""+ loadmetatime + "\","
					+ "\"loadmetaspeed\":\""+ loadmetaspeed + "\","
					+ "\"downfiletime\":\""+ downfiletime + "\","
					+ "\"downfilespeed\":\""+ downfilespeed + "\","
					+ "\"downmetatime\":\""+ downmetatime + "\","
					+ "\"downmetaspeed\":\""+ downmetaspeed + "\","
					+ "\"rates\":\"" + rates+ "\","
					+ "\"filenum\":\"" + filenum+ "\","
					+ "\"dbname\":\"" + dbname+ "\","
					+ "\"storagesize\":\"" + storagesize
					+ "\"}");
		}

		if(request.getParameter("type").equals("draw") && request.getParameter("charttype").equals("load"))
		{
			int interval =  Integer.parseInt(request.getParameter("interval"));
			FileReader reader = null;
			String fileName = request.getParameter("copynum");
            System.out.println(fileName);
			if(interval >= 1000)
			{
			    interval = interval / 1000;
			    reader = new FileReader(dbLogFilePath + "/" + fileName + "/" + QueryFileName.LOAD_FILE_PER + ".txt");
			}
			else if(interval < 1000)
			    reader = new FileReader(dbLogFilePath + "/" + fileName + "/loadfile.txt");

			StringBuffer speed = new StringBuffer("");
			@SuppressWarnings("resource")
			BufferedReader br = new BufferedReader(reader);
			String str = null;
			speed.append("[");
			int i = 0;
			if(interval == 1)
			{
				while((str = br.readLine()) != null)
					speed.append("{\"speed\":" + str + "},");
			}
			else
			{
				while((str = br.readLine()) != null)
				{
					boolean enough = true;
					float sum = 0;
					for(i = 0; i < interval; i++, str = br.readLine())
					{
						if(str == null)
						{
							enough = false;
							break;
						}
						sum += Float.parseFloat(str);
					}
					if(enough)				
						speed.append("{\"speed\":" + sum / interval + "},");
					else
						speed.append("{\"speed\":" + sum / i + "},");
				}
			}
			speed.append("{\"speed\":" + (interval-1) + "}");
			speed.append("]");
			System.out.println(speed.toString());
			response.getWriter().write(speed.toString());		
		}
		
		if(request.getParameter("type").equals("draw") && request.getParameter("charttype").equals("loadmeta"))
		{
			int interval =  Integer.parseInt(request.getParameter("interval"));
			FileReader reader = null;
            String fileName = request.getParameter("copynum");

            reader = new FileReader(dbLogFilePath + "/" + fileName + "/loadmeta.txt");
			StringBuffer speed = new StringBuffer("");
			@SuppressWarnings("resource")
			BufferedReader br = new BufferedReader(reader);
			String str = null;
			speed.append("[");
			int i = 0;
			if(interval == 1)
			{
				while((str = br.readLine()) != null)
					speed.append("{\"speed\":" + str + "},");
			}
			else
			{
				while((str = br.readLine()) != null)
				{
					boolean enough = true;
					float sum = 0;
					for(i = 0; i < interval; i++, str = br.readLine())
					{
						if(str == null)
						{
							enough = false;
							break;
						}
						sum += Float.parseFloat(str);
					}
					if(enough)				
						speed.append("{\"speed\":" + sum / interval + "},");
					else
						speed.append("{\"speed\":" + sum / i + "},");
				}
			}
			speed.append("{\"speed\":" + (interval-1) + "}");
			speed.append("]");
			System.out.println(speed.toString());
			response.getWriter().write(speed.toString());		
		}
		
		if(request.getParameter("type").equals("draw") && request.getParameter("charttype").equals("down"))
		{
			int interval =  Integer.parseInt(request.getParameter("interval"));
			FileReader reader = null;
			String fileName = request.getParameter("copynum");

			if(interval >= 1000)
			{
			    interval = interval / 1000;
			    reader = new FileReader(dbLogFilePath + "/" + fileName + "/" + QueryFileName.DOWN_FILE_PER + ".txt");
			}
			else if(interval < 1000)
			    reader = new FileReader(dbLogFilePath + "/" + fileName + "/downfile.txt");

			StringBuffer speed = new StringBuffer("");
			@SuppressWarnings("resource")
			BufferedReader br = new BufferedReader(reader);
			String str = null;
			speed.append("[");
			int i = 0;
			if(interval == 1)
			{
				while((str = br.readLine()) != null)
					speed.append("{\"speed\":" + str + "},");
			}
			else
			{
				while((str = br.readLine()) != null)
				{
					boolean enough = true;
					float sum = 0;
					for(i = 0; i < interval; i++, str = br.readLine())
					{
						if(str == null)
						{
							enough = false;
							break;
						}
						sum += Float.parseFloat(str);
					}
					if(enough)				
						speed.append("{\"speed\":" + sum / interval + "},");
					else
						speed.append("{\"speed\":" + sum / i + "},");
				}
			}
			speed.append("{\"speed\":" + (interval-1) + "}");
			speed.append("]");
			System.out.println(speed.toString());
			response.getWriter().write(speed.toString());		
		}
		
		if(request.getParameter("type").equals("draw") && request.getParameter("charttype").equals("downmeta"))
		{
			int interval =  Integer.parseInt(request.getParameter("interval"));
			FileReader reader = null;
            String fileName = request.getParameter("copynum");

            reader = new FileReader(dbLogFilePath + "/" + fileName + "/downmeta.txt");
			StringBuffer speed = new StringBuffer("");
			@SuppressWarnings("resource")
			BufferedReader br = new BufferedReader(reader);
			String str = null;
			speed.append("[");
			int i = 0;
			if(interval == 1)
			{
				while((str = br.readLine()) != null)
					speed.append("{\"speed\":" + str + "},");
			}
			else
			{
				while((str = br.readLine()) != null)
				{
					boolean enough = true;
					float sum = 0;
					for(i = 0; i < interval; i++, str = br.readLine())
					{
						if(str == null)
						{
							enough = false;
							break;
						}
						sum += Float.parseFloat(str);
					}
					if(enough)				
						speed.append("{\"speed\":" + sum / interval + "},");
					else
						speed.append("{\"speed\":" + sum / i + "},");
				}
			}
			speed.append("{\"speed\":" + interval + "}");
			speed.append("]");
			System.out.println(speed.toString());
			response.getWriter().write(speed.toString());		
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}

}
