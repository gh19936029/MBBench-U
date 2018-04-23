package cn.ruc.edu.basecore;

import java.io.IOException;
import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Comparator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MakeDir extends HttpServlet{

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String makeDirTpye = request.getParameter("dirtype");
        System.out.println(makeDirTpye);
        if(makeDirTpye.equals("setlogpath")){
            String logpath = (String) request.getParameter("logpath");
            System.out.println(logpath);
            String dbname = (String) request.getParameter("dbname");
            System.out.println(dbname);
            session.setAttribute("logpath", logpath);
            session.setAttribute("databasetype", dbname);
            response.getWriter().write("{\"result\":\"success\"}");
        }

        if(makeDirTpye.equals("transdir")){
            String zongLogPath = (String) session.getAttribute("logpath");
            if(zongLogPath.equals("null")){
                response.getWriter().write("{\"result\":\"false\"}");
            }
            else{
                int resultCopynum = 1;
                Calendar date = Calendar.getInstance();
                String dateString = date.get(Calendar.YEAR) + "-" + (date.get(Calendar.MONTH) + 1) + "-"
                        + date.get(Calendar.DATE);
                String transLogPath = zongLogPath + "/" + (String) session.getAttribute("databasetype");
                File transDir = new File(transLogPath);
                if(transDir.exists())
                {
                    File[] transFiles = new File(transLogPath).listFiles();
                    for(File file : transFiles){
                        if(!file.getName().substring(0, file.getName().lastIndexOf("-")).equals(dateString))
                            continue;
                        resultCopynum++;
                    }
                }

                transLogPath += "/" + dateString + "-" + resultCopynum;
                System.out.println(transLogPath);
                transDir = new File(transLogPath);
                session.setAttribute("translogpath", transLogPath);
                transDir.mkdirs();
                response.getWriter().write("{\"result\":\"success\"}");
            }
        }

        if(makeDirTpye.equals("querydir")){
            String zongLogPath = (String) session.getAttribute("logpath");
            System.out.println(zongLogPath);
            int resultCopynum = 1;
            String success = "true";
            String queryLogPath = zongLogPath + "/" + (String) session.getAttribute("databasetype");
            File testFile = new File(queryLogPath);
            if(!testFile.exists()){
                success = "false";
                System.out.println("这里出错了");
            }
            // This area is used to verify the database dir
            else{
                if(session.getAttribute("translogpath") != "" && session.getAttribute("translogpath") != null)
                    queryLogPath = (String) session.getAttribute("translogpath");
                else{
                    File[] transFiles = new File(queryLogPath).listFiles();
                    List<String> fileNameList = new ArrayList<String>();
                    for(File file : transFiles)
                        fileNameList.add(file.getName());
                    fileNameList.sort((String s1, String s2) -> s1.compareTo(s2));
                    queryLogPath += "/" + fileNameList.get(fileNameList.size() - 1);
                }
                System.out.println("The query file is in the \"" + queryLogPath + "\" path");
                //This area is used to create the query dir
                File[] queryFiles = new File(queryLogPath).listFiles();
                Calendar date = Calendar.getInstance();
                String dateString = date.get(Calendar.YEAR) + "-" + (date.get(Calendar.MONTH) + 1) + "-"
                        + date.get(Calendar.DATE);
                if(queryFiles.length != 0)
                {
                    for(File file : queryFiles){
                        if(!file.getName().substring(0, file.getName().lastIndexOf("-")).equals(dateString))
                            continue;
                        resultCopynum++;
                    }
                }

                queryLogPath += "/" + dateString + "-" + resultCopynum;
                File queryDir = new File(queryLogPath);
                queryDir.mkdirs();
                session.setAttribute("querylogpath", queryLogPath);
            }
            response.getWriter().write("{\"result\":\"" + success + "\"}");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
