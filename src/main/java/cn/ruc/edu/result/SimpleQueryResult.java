package cn.ruc.edu.result;

import cn.ruc.edu.basecore.QueryFileName;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class SimpleQueryResult
 */
public class SimpleQueryResult extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String dbLogFilePath = "";
		if(session.getAttribute("transLogPath") != null){
			dbLogFilePath = (String) session.getAttribute("transLogPath");
			dbLogFilePath = dbLogFilePath.substring(0, dbLogFilePath.lastIndexOf("/"));
		}
		else
			dbLogFilePath = (String) session.getAttribute("logpath") +
					"/" + (String) session.getAttribute("databasetype");


		if(request.getParameter("type").equals("info")){
			String filecount = request.getParameter("copynum");
			FileReader reader = null;
			int c=0;
			String copynum = filecount.split(":")[0];
			filecount = filecount.split(":")[1];
			reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/" + QueryFileName.QUERY_ONE + ".txt");
			BufferedReader br = new BufferedReader(reader);
			String str = null;
			float[] query1info =new float[3];
			while((str = br.readLine()) != null) {
				query1info[c] = Float.parseFloat(str);
				c++;
			}

			reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/" + QueryFileName.QUERY_TWO + ".txt");
			br = new BufferedReader(reader);
			c = 0;
			float[] query2info =new float[3];
			while((str = br.readLine()) != null) {
				query2info[c] = Float.parseFloat(str);
				c++;
			}

			reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/" + QueryFileName.QUERY_THREE + ".txt");
			br = new BufferedReader(reader);
			c= 0;
			float[] query3info = new float[3];
			String time = br.readLine();
			while((str = br.readLine()) != null) {
				query3info[c] = Float.parseFloat(str);
				c++;
			}

			reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/" + QueryFileName.QUERY_FOUR + ".txt");
			br = new BufferedReader(reader);
			c = 0;
			float[] query4info =new float[3];
			while((str = br.readLine()) != null) {
				query4info[c] = Float.parseFloat(str);
				c++;
			}

			reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/" + QueryFileName.QUERY_FIVE + ".txt");
			br = new BufferedReader(reader);
			c = 0;
			float[] query5info =new float[3];
			while((str = br.readLine()) != null) {
				query5info[c] = Float.parseFloat(str);
				c++;
			}

			reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/" + QueryFileName.QUERY_SIX + ".txt");
			br = new BufferedReader(reader);
			c = 0;
			float[] query6info =new float[3];
			while((str = br.readLine()) != null) {
				query6info[c] = Float.parseFloat(str);
				c++;
			}

			reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/" + QueryFileName.QUERY_SEVEN + ".txt");
			br = new BufferedReader(reader);
			c = 0;
			float[] query7info =new float[3];
			while((str = br.readLine()) != null) {
				query7info[c] = Float.parseFloat(str);
				c++;
				System.out.println(query7info[c-1]);
			}

			reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/" + QueryFileName.QUERY_VERISON + ".txt");
			br = new BufferedReader(reader);
			c = 0;
			float[] query8info =new float[4];
			while((str = br.readLine()) != null) {
				query8info[c] = Float.parseFloat(str);
				c++;
				System.out.println(query8info[c-1]);
			}

			response.getWriter().write("{\"devicetype_count\":" + "\"" + query1info[0] +"\"" + ","
					+ "\"devicetype_speed\":"+ "\""+ query1info[2] + "\""+ ","
					+ "\"devicetype_time\":"+ "\""+ query1info[1] + "\""+ ","
					+ "\"towerhight_count\":" + "\""+ query2info[0] + "\""+ ","
					+ "\"towerhight_speed\":"+ "\""+ query2info[2] + "\""+ ","
					+ "\"towerhight_time\":"+ "\""+ query2info[1] + "\""+ ","
					+ "\"simulation_count\":"+ "\"" + query3info[0]+ "\"" + ","
					+ "\"simulation_speed\":"+ "\""+ query3info[2]+ "\"" + ","
					+ "\"simulation_time\":"+ "\""+ query3info[1]+ "\""	+ ","
					+ "\"sett\":"+ "\"" +  time + "\"" + ","
					+ "\"query4_count\":"+ "\"" + query4info[0]+ "\"" + ","
					+ "\"query4_speed\":"+ "\""+ query4info[2] + "\""+ ","
					+ "\"query4_time\":"+ "\""+ query4info[1] + "\""+ ","
					+ "\"query5_count\":" + "\""+ query5info[0] + "\""+ ","
					+ "\"query5_speed\":"+ "\""+ query5info[2] + "\""+ ","
					+ "\"query5_time\":"+ "\""+ query5info[1] + "\""+ ","
					+ "\"query6_count\":"+ "\"" + query6info[0]+ "\"" + ","
					+ "\"query6_speed\":"+ "\""+ query6info[2]+ "\"" + ","
					+ "\"query6_time\":"+ "\""+ query6info[1]+ "\""	+ ","
					+ "\"query7_count\":"+ "\"" + query7info[0]+ "\"" + ","
					+ "\"query7_speed\":"+ "\""+ query7info[2]+ "\"" + ","
					+ "\"query7_time\":"+ "\""+ query7info[1]+ "\"" + ","
					+ "\"query8_count\":"+ "\"" + query8info[0]+ "\"" + ","
					+ "\"query8_speed\":"+ "\""+ query8info[2]+ "\"" + ","
					+ "\"query8_time\":"+ "\""+ query8info[1]+ "\"" + ","
					+ "\"query8_rate\":"+ "\""+ query8info[3]+ "\""
					+"}");
		}

		if(request.getParameter("type").equals("draw"))
		{
            int interval =  Integer.parseInt(request.getParameter("interval"));
			String dbWithQuery = request.getParameter("copynum");
			String dbName = dbWithQuery.split(":")[0];
			String queryName = dbWithQuery.split(":")[1];
			FileReader reader = null;	

			if(request.getParameter("chartname").equals("query1"))
				reader = new FileReader(dbLogFilePath + "/" + dbName + "/" + queryName + "/" + QueryFileName.DOWN_QUERY_ONE + ".txt");
			else if (request.getParameter("chartname").equals("query2"))
				reader = new FileReader(dbLogFilePath + "/" + dbName + "/" + queryName + "/" + QueryFileName.DOWN_QUERY_TWO + ".txt");
			else if (request.getParameter("chartname").equals("query3"))
				reader = new FileReader(dbLogFilePath + "/" + dbName + "/" + queryName + "/" + QueryFileName.DOWN_QUERY_THREE + ".txt");
			else if (request.getParameter("chartname").equals("query4"))
				reader = new FileReader(dbLogFilePath + "/" + dbName + "/" + queryName + "/" + QueryFileName.DOWN_QUERY_FOUR + ".txt");
			else if (request.getParameter("chartname").equals("query5"))
				reader = new FileReader(dbLogFilePath + "/" + dbName + "/" + queryName + "/" + QueryFileName.DOWN_QUERY_FIVE + ".txt");
			else if (request.getParameter("chartname").equals("query6"))
				reader = new FileReader(dbLogFilePath + "/" + dbName + "/" + queryName + "/" + QueryFileName.DOWN_QUERY_SIX + ".txt");
			else
				reader = new FileReader(dbLogFilePath + "/" + dbName + "/" + queryName + "/" + QueryFileName.DOWN_QUERY_SEVEN + ".txt");
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
						sum += Float.valueOf(str);
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

		if(request.getParameter("type").equals("querya")){
		    System.out.println(dbLogFilePath);
			String dbWithQuery = request.getParameter("copynum");
			String dbName = dbWithQuery.split(":")[0];
			String queryName = dbWithQuery.split(":")[1];
			FileReader reader = null;
			int c = 0;
            //System.out.println(dbLogFilePath + "/" + copynum + "/" + filecount + "/query_devicetype_blade.txt");
            reader = new FileReader(dbLogFilePath + "/" + dbName + "/" + queryName + "/" + QueryFileName.QUERY_ONE + ".txt");
            BufferedReader br = new BufferedReader(reader);
            String str = null;
            float[] query1info =new float[3];
            while((str = br.readLine()) != null) {
                query1info[c] = Float.parseFloat(str);
                c++;
            }

            reader = new FileReader(dbLogFilePath + "/" + dbName + "/" + queryName + "/" + QueryFileName.QUERY_TWO + ".txt");
            br = new BufferedReader(reader);
            c = 0;
            float[] query2info =new float[3];
            while((str = br.readLine()) != null) {
                query2info[c] = Float.parseFloat(str);
                c++;
            }

            reader = new FileReader(dbLogFilePath + "/" + dbName + "/" + queryName + "/" + QueryFileName.QUERY_THREE + ".txt");
            br = new BufferedReader(reader);
            c= 0;
            float[] query3info = new float[3];
            String time = br.readLine();
            while((str = br.readLine()) != null) {
                query3info[c] = Float.parseFloat(str);
                c++;
            }

            System.out.println("{\"devicetype_count\":" + "\"" + query1info[0] +"\"" + ","
                            + "\"devicetype_speed\":"+ "\""+ query1info[2] + "\""+ ","
                            + "\"devicetype_time\":"+ "\""+ query1info[1] + "\""+ ","
                            + "\"towerhight_count\":" + "\""+ query2info[0] + "\""+ ","
                            + "\"towerhight_speed\":"+ "\""+ query2info[2] + "\""+ ","
                            + "\"towerhight_time\":"+ "\""+ query2info[1] + "\""+ ","
                            + "\"simulation_count\":"+ "\"" + query3info[0]+ "\"" + ","
                            + "\"simulation_speed\":"+ "\""+ query3info[2]+ "\"" + ","
                            + "\"simulation_time\":"+ "\""+ query3info[1]+ "\""	+ ","
                            + "\"sett\":"+ "\"" +  time + "\"" +
                            "}");

            response.getWriter().write("{\"devicetype_count\":" + "\"" + query1info[0] +"\"" + ","
                            + "\"devicetype_speed\":"+ "\""+ query1info[2] + "\""+ ","
                            + "\"devicetype_time\":"+ "\""+ query1info[1] + "\""+ ","
                            + "\"towerhight_count\":" + "\""+ query2info[0] + "\""+ ","
                            + "\"towerhight_speed\":"+ "\""+ query2info[2] + "\""+ ","
                            + "\"towerhight_time\":"+ "\""+ query2info[1] + "\""+ ","
                            + "\"simulation_count\":"+ "\"" + query3info[0]+ "\"" + ","
                            + "\"simulation_speed\":"+ "\""+ query3info[2]+ "\"" + ","
                            + "\"simulation_time\":"+ "\""+ query3info[1]+ "\""	+ ","
                            + "\"sett\":"+ "\"" +  time + "\"" +
                            "}");

		}

		if(request.getParameter("type").equals("queryb")){
			System.out.println(dbLogFilePath);
			String dbWithQuery = request.getParameter("copynum");
			String dbName = dbWithQuery.split(":")[0];
			String queryName = dbWithQuery.split(":")[1];
			FileReader reader = null;
			int c = 0;
			//System.out.println(dbLogFilePath + "/" + copynum + "/" + filecount + "/query_devicetype_blade.txt");
			reader = new FileReader(dbLogFilePath + "/" + dbName + "/" + queryName + "/" + QueryFileName.QUERY_FOUR + ".txt");
			BufferedReader br = new BufferedReader(reader);
			String str = "";
			c = 0;
			float[] query4info =new float[3];
			while((str = br.readLine()) != null) {
				query4info[c] = Float.parseFloat(str);
				c++;
			}

			reader = new FileReader(dbLogFilePath + "/" + dbName + "/" + queryName + "/" + QueryFileName.QUERY_FIVE + ".txt");
			br = new BufferedReader(reader);
			c = 0;
			float[] query5info =new float[3];
			while((str = br.readLine()) != null) {
				query5info[c] = Float.parseFloat(str);
				c++;
			}

			reader = new FileReader(dbLogFilePath + "/" + dbName + "/" + queryName + "/" + QueryFileName.QUERY_SIX + ".txt");
			br = new BufferedReader(reader);
			c = 0;
			float[] query6info =new float[3];
			while((str = br.readLine()) != null) {
				query6info[c] = Float.parseFloat(str);
				c++;
			}

			reader = new FileReader(dbLogFilePath + "/" + dbName + "/" + queryName + "/" + QueryFileName.QUERY_SEVEN + ".txt");
			br = new BufferedReader(reader);
			c = 0;
			float[] query7info =new float[3];
			while((str = br.readLine()) != null) {
				query7info[c] = Float.parseFloat(str);
				c++;
				System.out.println(query7info[c-1]);
			}

			response.getWriter().write("{\"query4_count\":"+ "\"" + query4info[0]+ "\"" + ","
					+ "\"query4_speed\":"+ "\""+ query4info[2] + "\""+ ","
					+ "\"query4_time\":"+ "\""+ query4info[1] + "\""+ ","
					+ "\"query5_count\":" + "\""+ query5info[0] + "\""+ ","
					+ "\"query5_speed\":"+ "\""+ query5info[2] + "\""+ ","
					+ "\"query5_time\":"+ "\""+ query5info[1] + "\""+ ","
					+ "\"query6_count\":"+ "\"" + query6info[0]+ "\"" + ","
					+ "\"query6_speed\":"+ "\""+ query6info[2]+ "\"" + ","
					+ "\"query6_time\":"+ "\""+ query6info[1]+ "\""	+ ","
					+ "\"query7_count\":"+ "\"" + query7info[0]+ "\"" + ","
					+ "\"query7_speed\":"+ "\""+ query7info[2]+ "\"" + ","
					+ "\"query7_time\":"+ "\""+ query7info[1]+ "\""
					+"}");
		}

		if(request.getParameter("type").equals("queryc")){
			System.out.println(dbLogFilePath);
			String dbWithQuery = request.getParameter("copynum");
			String dbName = dbWithQuery.split(":")[0];
			String queryName = dbWithQuery.split(":")[1];
			FileReader reader = null;
			int c = 0;
			reader = new FileReader(dbLogFilePath + "/" + dbName + "/" + queryName + "/" + QueryFileName.QUERY_VERISON + ".txt");
			BufferedReader br = new BufferedReader(reader);
			c = 0;
			String str = "";
			float[] query8info =new float[4];
			while((str = br.readLine()) != null) {
				query8info[c] = Float.parseFloat(str);
				c++;
				System.out.println(query8info[c-1]);
			}

			response.getWriter().write("{\"query8_count\":"+ "\"" + query8info[0]+ "\"" + ","
					+ "\"query8_speed\":"+ "\""+ query8info[2]+ "\"" + ","
					+ "\"query8_time\":"+ "\""+ query8info[1]+ "\"" + ","
					+ "\"query8_rate\":"+ "\""+ query8info[3]+ "\""
					+"}");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
