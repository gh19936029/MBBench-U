package cn.ruc.edu.basecore;

import java.io.*;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class FileFunction {

    private String transLogPath = null;
    private String queryLogPath = null;


    public void SetLogDataPathforTrans(String path){
        if(this.transLogPath == null)
            this.transLogPath = path;
    }

    public String GetLogPathforTrans(){
        if(this.transLogPath == null)
            return null;
        else
            return this.transLogPath;
    }

    public void SetLogDataPathforQuery(String path){
        if(this.queryLogPath == null)
            this.queryLogPath = path;
    }

    public String GetLogPathforQuery(){
        if(this.queryLogPath == null)
            return null;
        else
            return this.queryLogPath;
    }

    public static int GetFilesNumByPath(String path)
    {
        int filecount = 0;
        File[] allfiles = new File(path).listFiles();
        for(File s : allfiles){
            if(s.isDirectory()){
                File[] inners = new File(s.getAbsolutePath() + "/file").listFiles();
                for(File sFile : inners){
                    filecount ++;
                }
            }
        }
        return filecount;
    }

    public static float GetFilesAllsizeByPath(String path)
    {
        File[] allfiles = new File(path).listFiles();
        long size = 0;
        float sizem = 0;

        for(File s : allfiles){
            if(s.isDirectory()){
                File[] inners = new File(s.getAbsolutePath() + "/file").listFiles();
                for(File sFile : inners){
                    size += sFile.length();
                }
                sizem += size / ( 1024 * 1024);
                size = 0;
            }
        }
        return sizem;
    }

    public static List<File> GetUpLoadFileList(String upLoadFilePath){
        List<File> allFileList = new ArrayList<File>();
        File rootFile = new File(upLoadFilePath);
        File[] rootFileList = rootFile.listFiles();
        if(rootFileList.length == 0)
            return null;
        long length = 0;
        for(File files : rootFileList) {
            if (!files.isDirectory())
                continue;
            File dataFile = new File(files.getAbsolutePath() + "/file");
            allFileList.addAll(Arrays.asList(dataFile.listFiles()));
        }
        return allFileList;
    }

    public static List<File> GetUpLoadMetaFileList(String upLoadMetaFilePath, String metaType){
        List<File> allFileList = new ArrayList<File>();
        File rootFile = new File(upLoadMetaFilePath);
        File[] rootFileList = rootFile.listFiles();
        if(rootFileList.length == 0)
            return null;
        long length = 0;
        for(File files : rootFileList) {
            if (!files.isDirectory())
                continue;
            File dataFile = new File(files.getAbsolutePath() + "/metadata/" + metaType);
            allFileList.addAll(Arrays.asList(dataFile.listFiles()));
        }
        return allFileList;
    }

    public static void jiange()
    {
        for(int i = 0; i < 25; i++)
            System.out.print("*");
        System.out.println();
    }
    public static void TimePrint(int seconds)
    {
        int hour = 0, minus = 0;
        if(seconds > 3600)
        {
            hour = seconds / 3600;
            seconds = seconds % 3600;
        }
        if(seconds > 60)
        {
            minus = seconds / 60;
            seconds = seconds % 60;
        }

        if(hour != 0)
            System.out.println("Time is " + hour + "H : " + minus +"M : " + seconds + "S");
        else if(minus != 0)
            System.out.println("Time is " +  minus +"M : " + seconds + "S");
        else
            System.out.println("Time is " +  seconds + "S");
    }

    public static String getTime(int seconds)
    {
        int hour = 0, minus = 0;
        if(seconds > 3600)
        {
            hour = seconds / 3600;
            seconds = seconds % 3600;
        }
        if(seconds > 60)
        {
            minus = seconds / 60;
            seconds = seconds % 60;
        }
        if(hour != 0)
            return hour + "H : " + minus +"M : " + seconds + "S";
        else if(minus != 0)
            return minus +"M : " + seconds + "S";
        else
            return seconds + "S";
    }

    public static String FormetFileSize(long fileS) {//
        DecimalFormat df = new DecimalFormat("#.00");
        String fileSizeString = "";
        if (fileS < 1024) {
            fileSizeString = df.format((double) fileS) + "B";
        } else if (fileS < 1048576) {
            fileSizeString = df.format((double) fileS / 1024) + "KB";
        } else if (fileS < 1073741824) {
            fileSizeString = df.format((double) fileS / 1048576) + "MB";
        } else {
            fileSizeString = df.format((double) fileS / 1073741824) + "GB";
        }
        return fileSizeString;
    }

    public void WriteLogforTrans(String content, String name)
    {
        File filesnum = new File(this.transLogPath);
        if(!filesnum.exists()){
            filesnum.mkdirs();
        }

        File logdir = new File(this.transLogPath);
        if(!logdir.exists())
        {
            logdir.mkdirs();
        }
        else
        {
            File logload = new File(logdir.getAbsolutePath() + "/" + name + ".txt");
            if(!logload.exists())
            {
                try {
                    logload.createNewFile();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
            BufferedReader reader = null;
            try
            {
                reader = new BufferedReader(new FileReader(logload));
                String check = reader.readLine();
                if(check == null)
                {
                    FileWriter fw = new FileWriter(logload.getAbsolutePath());
                    fw.write(content + "\n");
                    fw.flush();
                    fw.close();
                }
                else
                {
                    FileWriter fw = new FileWriter(logload.getAbsolutePath(), true);
                    fw.write(content + "\n");
                    fw.flush();
                    fw.close();
                }
            }
            catch(IOException e)
            {
                e.printStackTrace();
            }
        }
    }

    public void WriteLogforQuery(String content, String name)
    {
        File filesnum = new File(this.queryLogPath);
        if(!filesnum.exists()){
            filesnum.mkdirs();
        }

        File logdir = new File(this.queryLogPath);
        if(!logdir.exists())
        {
            logdir.mkdirs();
        }
        else
        {
            File logload = new File(logdir.getAbsolutePath() + "/" + name + ".txt");
            if(!logload.exists())
            {
                try {
                    logload.createNewFile();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
            BufferedReader reader = null;
            try
            {
                reader = new BufferedReader(new FileReader(logload));
                String check = reader.readLine();
                if(check == null)
                {
                    FileWriter fw = new FileWriter(logload.getAbsolutePath());
                    fw.write(content + "\n");
                    fw.flush();
                    fw.close();
                }
                else
                {
                    FileWriter fw = new FileWriter(logload.getAbsolutePath(), true);
                    fw.write(content + "\n");
                    fw.flush();
                    fw.close();
                }
            }
            catch(IOException e)
            {
                e.printStackTrace();
            }
        }
    }
}
