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
public class MultiQueryResult extends HttpServlet {
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
            //复杂负载
            //排序
            reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + QueryFileName.QUERY_NINE + ".txt");
            BufferedReader br = new BufferedReader(reader);
            String str = null;
            float[] sort1info =new float[3];
            while((str = br.readLine()) != null) {
                sort1info[c] = Float.parseFloat(str);
                c++;

            }
            reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/" +QueryFileName.QUERY_TEN + ".txt");
            br = new BufferedReader(reader);
            c = 0;
            float[] sort2info =new float[3];
            while((str = br.readLine()) != null) {
                sort2info[c] = Float.parseFloat(str);
                c++;

            }
            reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/"  + QueryFileName.QUERY_ELEVEN + ".txt");
            br = new BufferedReader(reader);
            c = 0;
            float[] sort3info =new float[3];
            while((str = br.readLine()) != null) {
                sort3info[c] = Float.parseFloat(str);
                c++;
            }

            //最值平均值查询
            reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/"  + QueryFileName.QUERY_TWELVE + ".txt");
            br = new BufferedReader(reader);
            c = 0;
            float[] query1info =new float[3];
            while((str = br.readLine()) != null) {
                query1info[c] = Float.parseFloat(str);
                c++;
            }
            reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/"  + QueryFileName.QUERY_THIRTEEN + ".txt");
            br = new BufferedReader(reader);
            c = 0;
            float[] query2info =new float[3];
            while((str = br.readLine()) != null) {
                query2info[c] = Float.parseFloat(str);
                c++;
            }
            reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/"  + QueryFileName.QUERY_FORTEEN + ".txt");
            br = new BufferedReader(reader);
            c = 0;
            float[] query3info =new float[3];
            while((str = br.readLine()) != null) {
                query3info[c] = Float.parseFloat(str);
                c++;
            }
            //异常文件检测
            reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/"  + QueryFileName.QUERY_ABNORMAL + ".txt");
            br = new BufferedReader(reader);
            c = 0;
            float[] query4info =new float[5];
            while((str = br.readLine()) != null) {
                query4info[c] = Float.parseFloat(str);
                c++;
            }

            response.getWriter().write(
                    "{\"sort1_count\":"+ "\"" + sort1info[0]+ "\"" + ","
                            + "\"sort1_speed\":"+ "\""+ sort1info[2] + "\""+ ","
                            + "\"sort1_time\":"+ "\""+ sort1info[1] + "\""+ ","
                            + "\"sort2_count\":"+ "\"" + sort2info[0]+ "\"" + ","
                            + "\"sort2_speed\":"+ "\""+ sort2info[2] + "\""+ ","
                            + "\"sort2_time\":"+ "\""+ sort2info[1] + "\""+ ","
                            + "\"sort3_count\":"+ "\"" + sort3info[0]+ "\"" + ","
                            + "\"sort3_speed\":"+ "\""+ sort3info[2] + "\""+ ","
                            + "\"sort3_time\":"+ "\""+ sort3info[1] + "\"" +","

                            +"\"query1_count\":"+ "\"" + query1info[0]+ "\"" + ","
                            + "\"query1_speed\":"+ "\""+ query1info[2] + "\""+ ","
                            + "\"query1_time\":"+ "\""+ query1info[1] + "\""+ ","
                            + "\"query2_count\":"+ "\"" + query2info[0]+ "\"" + ","
                            + "\"query2_speed\":"+ "\""+ query2info[2] + "\""+ ","
                            + "\"query2_time\":"+ "\""+ query2info[1] + "\""+ ","
                            + "\"query3_count\":"+ "\"" + query3info[0]+ "\"" + ","
                            + "\"query3_speed\":"+ "\""+ query3info[2] + "\""+ ","
                            + "\"query3_time\":"+ "\""+ query3info[1] + "\"" +","

                            +"\"query4_count\":"+ "\"" + query4info[0]+ "\"" + ","
                            +"\"query4_speed\":"+ "\"" + query4info[1]+ "\"" + ","
                            + "\"query4_time\":"+ "\""+ query4info[2] + "\""+ ","
                            + "\"query4_acc\":"+ "\""+ query4info[3] + "\""+ ","
                            + "\"query4_recall\":"+ "\"" + query4info[4]+ "\""
                            +"}");
        }

        if(request.getParameter("type").equals("draw"))
        {
            int interval =  Integer.parseInt(request.getParameter("interval"));
            String filecount = request.getParameter("copynum");
            FileReader reader = null;
            int c=0;
            String copynum = filecount.split(":")[0];
            filecount = filecount.split(":")[1];

            reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/" + QueryFileName.QUERY_HOTFILE + ".txt");
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

        if(request.getParameter("type").equals("queryd")){
            String filecount = request.getParameter("copynum");
            FileReader reader = null;
            int c=0;
            String copynum = filecount.split(":")[0];
            filecount = filecount.split(":")[1];
            //复杂负载
            //排序
            reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + QueryFileName.QUERY_NINE + ".txt");
            BufferedReader br = new BufferedReader(reader);
            String str = null;
            float[] sort1info =new float[3];
            while((str = br.readLine()) != null) {
                sort1info[c] = Float.parseFloat(str);
                c++;

            }
            reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/" +QueryFileName.QUERY_TEN + ".txt");
            br = new BufferedReader(reader);
            c = 0;
            float[] sort2info =new float[3];
            while((str = br.readLine()) != null) {
                sort2info[c] = Float.parseFloat(str);
                c++;

            }
            reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/"  + QueryFileName.QUERY_ELEVEN + ".txt");
            br = new BufferedReader(reader);
            c = 0;
            float[] sort3info =new float[3];
            while((str = br.readLine()) != null) {
                sort3info[c] = Float.parseFloat(str);
                c++;
            }

            response.getWriter().write(
                    "{\"sort1_count\":"+ "\"" + sort1info[0]+ "\"" + ","
                            + "\"sort1_speed\":"+ "\""+ sort1info[2] + "\""+ ","
                            + "\"sort1_time\":"+ "\""+ sort1info[1] + "\""+ ","
                            + "\"sort2_count\":"+ "\"" + sort2info[0]+ "\"" + ","
                            + "\"sort2_speed\":"+ "\""+ sort2info[2] + "\""+ ","
                            + "\"sort2_time\":"+ "\""+ sort2info[1] + "\""+ ","
                            + "\"sort3_count\":"+ "\"" + sort3info[0]+ "\"" + ","
                            + "\"sort3_speed\":"+ "\""+ sort3info[2] + "\""+ ","
                            + "\"sort3_time\":"+ "\""+ sort3info[1] + "\""
                            +"}");
        }

        if(request.getParameter("type").equals("querye")){
            String filecount = request.getParameter("copynum");
            FileReader reader = null;
            int c=0;
            String copynum = filecount.split(":")[0];
            filecount = filecount.split(":")[1];
            //最值平均值查询
            reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/"  + QueryFileName.QUERY_TWELVE + ".txt");
            BufferedReader br = new BufferedReader(reader);
            String str = "";
            c = 0;
            float[] query1info =new float[3];
            while((str = br.readLine()) != null) {
                query1info[c] = Float.parseFloat(str);
                c++;
            }
            reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/"  + QueryFileName.QUERY_THIRTEEN + ".txt");
            br = new BufferedReader(reader);
            c = 0;
            float[] query2info =new float[3];
            while((str = br.readLine()) != null) {
                query2info[c] = Float.parseFloat(str);
                c++;
            }
            reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/"  + QueryFileName.QUERY_FORTEEN + ".txt");
            br = new BufferedReader(reader);
            c = 0;
            float[] query3info =new float[3];
            while((str = br.readLine()) != null) {
                query3info[c] = Float.parseFloat(str);
                c++;
            }

            response.getWriter().write(
                    "{\"query1_count\":"+ "\"" + query1info[0]+ "\"" + ","
                            + "\"query1_speed\":"+ "\""+ query1info[2] + "\""+ ","
                            + "\"query1_time\":"+ "\""+ query1info[1] + "\""+ ","
                            + "\"query2_count\":"+ "\"" + query2info[0]+ "\"" + ","
                            + "\"query2_speed\":"+ "\""+ query2info[2] + "\""+ ","
                            + "\"query2_time\":"+ "\""+ query2info[1] + "\""+ ","
                            + "\"query3_count\":"+ "\"" + query3info[0]+ "\"" + ","
                            + "\"query3_speed\":"+ "\""+ query3info[2] + "\""+ ","
                            + "\"query3_time\":"+ "\""+ query3info[1] + "\""
                            +"}");
        }

        if(request.getParameter("type").equals("queryf")){
            String filecount = request.getParameter("copynum");
            FileReader reader = null;
            int c=0;
            String copynum = filecount.split(":")[0];
            filecount = filecount.split(":")[1];
            reader = new FileReader(dbLogFilePath + "/" + copynum + "/" + filecount + "/"  + QueryFileName.QUERY_ABNORMAL + ".txt");
            BufferedReader br = new BufferedReader(reader);
            c = 0;
            String str = "";
            float[] query4info =new float[5];
            while((str = br.readLine()) != null) {
                query4info[c] = Float.parseFloat(str);
                c++;
            }

            response.getWriter().write(
                    "{\"query4_count\":"+ "\"" + query4info[0]+ "\"" + ","
                            +"\"query4_speed\":"+ "\"" + query4info[1]+ "\"" + ","
                            + "\"query4_time\":"+ "\""+ query4info[2] + "\""+ ","
                            + "\"query4_acc\":"+ "\""+ query4info[3] + "\""+ ","
                            + "\"query4_recall\":"+ "\"" + query4info[4]+ "\""
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
