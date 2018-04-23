package cn.ruc.edu.basecore;

import cn.ruc.edu.mbdatagen.Testpath;

import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.*;

public abstract class UnStrDBBase<DBBase> {
    //Database Info
    public String ip;
    public int port;
    public String dbName;
    public String collectionName; //if the database has
    public DBBase dbBase; //you need to set this database type

    //These are for show progress and count the file count
    public int filesloadall = 0; //This is be read from the disk
    public int filesloadcount = 0;
    public int filesdowncount = 0;
    public int metasloadcount = 0;
    public int metasdowncount = 0;

    public int tempfilemetaloadcount = 0;
    public int tempfilemetadowncount = 0;
    public long tempfilesloadspread = 0;
    public long tempfilesdownspread = 0;

    List<Integer> fileMetaloadList = new ArrayList<>();
    List<Integer> fileMetadownList = new ArrayList<>();
    List<Float> filesLoadList = new ArrayList<>();
    List<Float> filesDownList = new ArrayList<>();

    //This session is for check if the database is linked or not
    public HttpSession session;

    //These varables are used for query function
    public int towerheigh_min;
    public int towerheigh_max;
    public int sylenth_min;
    public int sylenth_max;
    public int sywidth_min;
    public int sywidth_max;

    //Finish is used to check if the query is finished
    public boolean finish = false;

    public int activecount = 0;

    public FileFunction fileFunction = new FileFunction();
    DecimalFormat fnum  =  new  DecimalFormat("##0.00");

    public void SetDbIp(String ip){ this.ip = ip; }
    public void SetDbPort(int port){ this.port = port; }
    public void SetDbName(String dbName){ this.dbName = dbName; }
    public void SetCollectionName(String collectionName){ this.collectionName = collectionName; }
    public void SetHttpSession(HttpSession session){ this.session = session;}
    //<--In this area, function is used to link and dislink database-->
    /*
    When it is succeed, remind to session.setAttribute("dbport", this.port);
     */
    public abstract boolean LinkDb();

    /*
    Remind to session.removeAttribute("dbport");
     */
    public abstract boolean DislinkDb();

    //<--In this area, functions are used to get database information-->
    /*
    This is for get file count from database.
    As an example, the MongoDB is for this:
    public long GetDbFilesCount()
	{
		if(mydb.getCollection("fs.files").getCount() == 0)
			return 0;
		return mydb.getCollection("fs.files").getCount();
	}
     */
    public abstract long GetDbFilesCount();

    public String GetDBName() { return dbName; }

    /*
    This is for getting database size, it is used to measure the
    database storage rate.
    As an example, the MongoDB is for this:
    public double GetDataSize()
    {
        if(mydb.getStats().get("dataSize") == null)
            return 0;
        return (double) mydb.getStats().get("dataSize");
    }
    */
    public abstract double GetDataSize();

    /*
   This is for getting storage size, it is used to measure the
   database storage rate.
   As an example, the MongoDB is for this:
   public double GetStorageSize()
    {
        return (double) mydb.getStats().get("storageSize");
    }
   */
   public abstract double GetStorageSize();

    //<--In this area, functions are used to get translation information in doing-->
    public int GetFileLoadCount() { return this.filesloadcount; }
    public int GetFileDownCount() { return this.filesdowncount; }
    public int GetMetaLoadCount() { return this.metasloadcount; }
    public int GetMetaDownCount() { return this.metasdowncount; }

    public long GetTempFileLoadSpread()
    {
        long back = this.tempfilesloadspread;
        this.tempfilesloadspread = 0;
        if(back == 0)
        {
            return 0;
        }
        fileFunction.WriteLogforTrans(fnum.format((float)back / (1024*1024)), "loadfile");
        this.filesLoadList.add((float)back / (1024 * 1024));
        return back;
    }

    public long GetTempFileDownSpread()
    {
        long back = this.tempfilesdownspread;
        this.tempfilesdownspread = 0;
        if(back == 0)
        {
            return 0;
        }
        fileFunction.WriteLogforTrans(fnum.format((float)back / (1024*1024)), "downfile");
        this.filesDownList.add((float)back / (1024 * 1024));
        return back;
    }

    public int GetTempMetaLoadSpread()
    {
        int back = this.tempfilemetaloadcount;
        this.tempfilemetaloadcount = 0;
        if(back == 0)
        {
            return 0;
        }
        fileFunction.WriteLogforTrans(back + "", "loadmeta");
        this.fileMetaloadList.add(back);
        return back;
    }

    public int GetTempMetaDownSpread()
    {
        int back = this.tempfilemetadowncount;
        this.tempfilemetadowncount = 0;
        if(back == 0)
        {
            return 0;
        }
        fileFunction.WriteLogforTrans(back + "", "downmeta");
        this.fileMetadownList.add(back);
        return back;
    }

    public String GetTimeFileLoadSpeed(){
        int startindex = 0;
        if(this.filesLoadList.size() > 50)
            startindex = this.filesLoadList.size() - 50; //
        List<Float> fileload100 = this.filesLoadList.subList(startindex, this.filesLoadList.size() - 1);
        if(fileload100.size() <= 0){
            return "[" + "{\"speed\":" + 0 + "}]" ;
        }
        String string = "[";
        for(float s : fileload100)
            string += "{\"speed\":" + fnum.format(s) + "},";
        string = string.substring(0, string.length() - 1) + "]";
        return string;
    }

    public String GetTimeFileDownSpeed(){
        int startindex = 0;
        if(this.filesDownList.size() > 50)
            startindex = this.filesDownList.size() - 50; //
        List<Float> filedown100 = this.filesDownList.subList(startindex, this.filesDownList.size() - 1);
        if(filedown100.size() <= 0){
            return "[" + "{\"speed\":" + 0 + "}]" ;
        }
        String string = "[";
        for(float s : filedown100)
            string += "{\"speed\":" + fnum.format(s) + "},";
        string = string.substring(0, string.length() - 1) + "]";
        return string;
    }

    public String GetTimeMetaLoadCount(){
        int startindex = 0;
        if(this.fileMetaloadList.size() > 50)
            startindex = this.fileMetaloadList.size() - 50; //
        List<Integer> metaload100 = this.fileMetaloadList.subList(startindex, this.fileMetaloadList.size() - 1);
        if(metaload100.size() <= 0){
            return "[" + "{\"speed\":" + 0 + "}]" ;
        }
        String string = "[";
        for(int s : metaload100)
            string += "{\"speed\":" + fnum.format(s) + "},";
        string = string.substring(0, string.length() - 1) + "]";
        return string;
    }

    public String GetTimeMetaDownCount(){
        int startindex = 0;
        if(this.fileMetadownList.size() > 50)
            startindex = this.fileMetadownList.size() - 50; //
        List<Integer> metadown100 = this.fileMetadownList.subList(startindex, this.fileMetadownList.size() - 1);
        if(metadown100.size() <= 0){
            return "[" + "{\"speed\":" + 0 + "}]" ;
        }
        String string = "[";
        for(int s : metadown100)
            string += "{\"speed\":" + fnum.format(s) + "},";
        string = string.substring(0, string.length() - 1) + "]";
        return string;
    }

    //<--In this area, functions are used to do translation like loadfile, loadmeta and so on-->
    public abstract boolean UpLoadFile(String filepath);
    public abstract boolean UpLoadMetafile(String metapath) throws IOException;
    public abstract boolean DownLoadFile(String downpath);
    public abstract boolean DownLoadMetaFile(String downpath);


    public boolean GetFinish(){
        return this.finish;
    }

    public void SetTransLogPath(){
        fileFunction.SetLogDataPathforTrans((String) session.getAttribute("translogpath"));
    }

    public void SetQueryLogPath(){
        fileFunction.SetLogDataPathforQuery((String) session.getAttribute("querylogpath"));
    }

    public String getHistorySetting() {
        //遍历historysettings文档，选择最新版本(文档名最大)
        //这里需要设置正确的读文件地方
        String path = Testpath.class.getClassLoader().getResource("HistorySettings").getPath();
        File historyfile = new File(path);
        File[] arrayfile = historyfile.listFiles();
        long imax = Long.valueOf(arrayfile[0].getName().substring(0, arrayfile[0].getName().length()-4));
        for(int i=0;i<arrayfile.length;i++){
            if(Long.valueOf(arrayfile[i].getName().substring(0, arrayfile[i].getName().length()-4))>imax) {
                imax =Long.valueOf(arrayfile[i].getName().substring(0, arrayfile[i].getName().length()-4));
            }
        }
        String string = String.valueOf(imax)+".txt";
        return string;
    }

    public void getValue() throws IOException {
        String filename = this.getHistorySetting();
        BufferedReader reader = null;
        try {
            //这里需要设置正确的读文件地方
            String path = Testpath.class.getClassLoader().getResource("HistorySettings").getPath();
            reader = new BufferedReader(new FileReader(path + "/" + filename));
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        String sline="";
        String[] sarea = null;
        int count = 0;
        sline = reader.readLine();
        count = Integer.valueOf(sline.split("\t")[1]);

        String[] whole = new String[count];
        String[] stowerheigh = new String[count];
        String[] ssylenth = new String[count];
        String[] ssywidth = new String[count];
        ArrayList list = new ArrayList();
        try {
            while((sline = reader.readLine())!=null) {
                if(sline.split("\t").length>9)
                    list.add(sline);
            }
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        System.out.println(list.size());
        whole = (String[]) list.toArray(new String[list.size()]);
        for(int i=0;i<whole.length;i++) {
            stowerheigh[i] = whole[i].split("\t")[2];
            //System.out.println(stowerheigh[i]);
            ssylenth[i] = whole[i].split("\t")[3];
            ssywidth[i] = whole[i].split("\t")[4];
        }

        this.towerheigh_min=this.zuiZhi(stowerheigh)[0];
        this.towerheigh_max=this.zuiZhi(stowerheigh)[1];
        this.sylenth_min=this.zuiZhi(ssylenth)[0];
        this.sylenth_max=this.zuiZhi(ssylenth)[1];
        this.sywidth_min=this.zuiZhi(ssywidth)[0];
        this.sywidth_max=this.zuiZhi(ssywidth)[1];
    }

    //求最大值最小值
    public int[] zuiZhi(String[] str) {
        int[] c = new int[2];
        c[0] = Integer.valueOf(str[0]);//min
        c[1] = Integer.valueOf(str[0]);//max
        for(int i=0;i<str.length;i++) {
            if(c[0]>Integer.valueOf(str[i]))c[0]=Integer.valueOf(str[i]);
            if(c[1]<Integer.valueOf(str[i]))c[1]=Integer.valueOf(str[i]);
        }
        return c;
    }

    public long GetSeconds(String date,int hour,int minute,int second) throws ParseException {
        Calendar dsDate = Calendar.getInstance();
        int[] t = new int[3];
        int i = 0;
        String[] s = date.split("-");
        for(String ss : s)
        {
            t[i] = Integer.parseInt(ss);
            i++;
        }
        dsDate.set(t[0], t[1] - 1, t[2], hour, minute, second);
        long submillisec = dsDate.getTime().getTime();
        long allsecond =  submillisec / 1000;
        return allsecond;
    }

    //抽取出某一个属性名称对应的属性值
    public String attributeChouQu(String string,String substring) {
        String s = null;
        int c = string.indexOf(substring)+substring.length()+5;
        for(int i = c;i<string.length() - substring.length();i++) {
            if(string.charAt(i)=='"') {
                s=string.substring(c, i);
                break;
            }
        }
        //System.out.println(s);
        return s;
    }

    //下列用于对文件名称按照递增排序
    @SuppressWarnings("unchecked")
    public static File[] OrderFileName(File[] s){
        List<File> fileList = Arrays.asList(s);
        java.util.Collections.sort(fileList, new Comparator<File>() {
            public int compare(File f1, File f2){
                if(f1.isDirectory() && f2.isFile())
                    return -1;
                if(f1.isFile() && f2.isDirectory())
                    return 1;
                return f1.getName().compareTo(f2.getName());
            }
        });
        return s;
    }


    //下列用于检测版本测试结果，需要传入文件生成总路径
    @SuppressWarnings("resource")
    public int[] CopyCheck(String datapath, HashMap resulthm) throws NumberFormatException, IOException{
        int allcount = 0;
        int correctcount = 0;
        int errorcount = 0;
        File checkfilepath = new File(datapath);
        File[] checkfileList = checkfilepath.listFiles();
        checkfileList = this.OrderFileName(checkfileList);
        int txtcount = 0;
        for(int i = 0; i < checkfileList.length; i++){
            System.out.println(checkfileList[i].getName());
            if(checkfileList[i].isDirectory())
                continue;
            else
                txtcount ++;

        }
        Set checkSet = resulthm.entrySet();
        Iterator check = checkSet.iterator();
        while(check.hasNext()){
            allcount ++;
            Map.Entry fileEntry = (Map.Entry ) check.next();
            String s = (String) fileEntry.getKey();
            String ss = s.split("\\$")[0];
            int fileid = Integer.parseInt(ss.split("_")[0]);
            int checkfilename = fileid - (int)(fileid / txtcount) * txtcount;
            if(checkfilename == 0)
                checkfilename = txtcount;

            BufferedReader reader = new BufferedReader(new FileReader(datapath + "/" + checkfilename + ".txt"));
            String filecontent = null;
            while((filecontent = reader.readLine()) != null){
                if(filecontent.contains(ss))
                {
                    int copynum = Integer.parseInt((String)fileEntry.getValue()) ;
                    int checkcopynum = Integer.parseInt(filecontent.split(":")[1]);
                    if(copynum == checkcopynum)
                        correctcount++;
                    else
                        errorcount++;
                }
                else
                    continue;
            }
        }
        int[] result = new int[3];
        result[0] = allcount;
        result[1] = correctcount;
        result[2] = errorcount;
        return result;
    }

    public float getVariance(Float[] inputData) {
        float ave = 0;
        for (int i = 0; i < inputData.length; i++)
            ave += inputData[i];
        ave /= inputData.length;

        float sum = 0;
        for(int i = 0;i<inputData.length;i++)
            sum += (inputData[i] - ave)  * (inputData[i] - ave) ;
        sum /= inputData.length;
        return sum;
    }

    //根据查询内容下载仿真文件
    public abstract void DownloadFileByList(List<Object> obj , String downfilename, String filedownpath);

    //<--In this area, functions are used to work single varables queries-->
    public void SingleAttQuerry(
            String sdate, int shour, int smins, int sses,
            String edate, int ehour, int emins, int eses,
            String filedownpath
    ) throws IOException {
        this.SetQueryLogPath();
        this.finish = false;
        List<Object> object1 = QueryOne();
        this.DownloadFileByList(object1,"down_" + QueryFileName.QUERY_ONE, filedownpath);
        List<Object> object2 = QueryTwo();
        this.DownloadFileByList(object2, "down_" + QueryFileName.QUERY_TWO, filedownpath);
        List<Object> object3 = QueryThree(sdate, shour, smins, sses, edate, ehour, emins, eses);
        this.DownloadFileByList(object3,"down_" + QueryFileName.QUERY_THREE, filedownpath);
        this.finish = true;
    }

    public void MultiAttQuery(String downfilepath) throws IOException {
        this.SetQueryLogPath();
        this.finish = false;
        List<Object> object4 = QueryFour();
        DownloadFileByList(object4, "down_" + QueryFileName.QUERY_FOUR, downfilepath);
        List<Object> object5 = QueryFive();
        DownloadFileByList(object5, "down_" + QueryFileName.QUERY_FIVE, downfilepath);
        List<Object> object6 = QuerySix();
        DownloadFileByList(object6, "down_" + QueryFileName.QUERY_SIX, downfilepath);
        List<Object> object7 = QuerySeven();
        DownloadFileByList(object7, "down_" + QueryFileName.QUERY_SEVEN, downfilepath);
        this.finish = true;
    }

    public abstract void VersionQuery(String datapath) throws IOException;

    public void SortQuery(){
        this.SetQueryLogPath();
        this.finish = false;
        QueryNine();
        QueryTen();
        QueryEleven();
        this.finish = true;
    }

    public void SatisticsQuery(){
        this.SetQueryLogPath();
        this.finish = false;
        QueryTwelve();
        QueryThirteen();
        QueryForteen();
        this.finish = true;
    }

    public abstract void AbnormalQuery();

    public abstract void HotFileQuery(int queryCount, int interval);

    public abstract List<Object>  QueryOne();
    public abstract List<Object>  QueryTwo() throws IOException;
    public abstract List<Object>  QueryThree(
            String sdate, int shour, int smins, int sses,
            String edate, int ehour, int emins, int eses
    );

    public abstract List<Object> QueryFour();
    public abstract List<Object> QueryFive();
    public abstract List<Object> QuerySix() throws IOException;
    public abstract List<Object> QuerySeven();

    public abstract void QueryNine();
    public abstract void QueryTen();
    public abstract void QueryEleven();

    public abstract void QueryTwelve();
    public abstract void QueryThirteen();
    public abstract void QueryForteen();

}
