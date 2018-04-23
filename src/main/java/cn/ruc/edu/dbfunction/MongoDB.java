package cn.ruc.edu.dbfunction;

import cn.ruc.edu.basecore.FileFunction;
import cn.ruc.edu.basecore.QueryFileName;
import cn.ruc.edu.basecore.UnStrDBBase;
import cn.ruc.edu.mbdatagen.Testpath;
import com.mongodb.*;
import com.mongodb.gridfs.GridFS;
import com.mongodb.gridfs.GridFSDBFile;
import com.mongodb.gridfs.GridFSInputFile;
import org.bson.Document;

import javax.management.Query;
import java.io.*;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class MongoDB extends UnStrDBBase<Mongo> {

    public DB mydb;

    public boolean LinkDb() {
        if(this.ip == null || this.port == -1){
            return false;
        }
        else {
            this.dbBase = new Mongo(this.ip, this.port);
            this.mydb = this.dbBase.getDB(this.dbName);
            this.session.setAttribute("dbport", this.port);
            return true;
        }
    }

    public boolean DislinkDb() {
        if(this.dbBase == null)
            return true;
        this.dbBase.close();
        session.removeAttribute("dbport");
        return true;
    }

    public long GetDbFilesCount() { return mydb.getCollection("fs.files").getCount(); }

    public double GetDataSize() { return Double.parseDouble(String.valueOf(mydb.getStats().get("dataSize"))); }

    public double GetStorageSize() { return Double.parseDouble(String.valueOf(mydb.getStats().get("storageSize"))); }

    public boolean UpLoadFile(String filepath) {
        this.SetTransLogPath();
        GridFS myfs = new GridFS(mydb);
        List<File> allLoadFileList = FileFunction.GetUpLoadFileList(filepath);
        long length = 0;
        long starttime = new Date().getTime();
        if(allLoadFileList.size() == 0)
            return false;
        else{
            for(File file : allLoadFileList)
            {
                long ofilestime = System.nanoTime();
                length += file.length();
                try {
                    GridFSInputFile inputfile = myfs.createFile(file);
                    inputfile.save();
                } catch (IOException e) {
                        e.printStackTrace();
                }

                long ofileetime = System.nanoTime();
                this.filesloadcount++;
                this.tempfilesloadspread += file.length();
                double speed = ((double)file.length()/(1024*1024))/((float)(ofileetime - ofilestime)/1E9);
                fileFunction.WriteLogforTrans(speed + "" , QueryFileName.LOAD_FILE_PER);
            }
        }

        long endtime = new Date().getTime();
        int seconds = (int)((endtime - starttime) / 1000);
        FileFunction.TimePrint(seconds);
        System.out.println("The average of translation is " + ((double)length/(1024*1024))/((float)(endtime - starttime)/1000) + "Mb/s\n");
        fileFunction.WriteLogforTrans(FileFunction.getTime(seconds) + "," +
                ((double)length/(1024*1024))/(float)seconds + "Mb/s", "dbinfo");
        return true;
    }

    public boolean UpLoadMetafile(String metapath) throws IOException {
        this.SetTransLogPath();
        MongoClient mc = new MongoClient();
        List<File> allLoadMetaList = FileFunction.GetUpLoadMetaFileList(metapath, "json");
        long starttime = new Date().getTime();
        for(File file : allLoadMetaList){
            BufferedReader fjson = new BufferedReader(new FileReader(file.getAbsolutePath()));
            String all = "";
            String s = null;
            while((s = fjson.readLine()) != null)
                all += s;
            Document doc = Document.parse(all);
            this.metasloadcount++;
            this.tempfilemetaloadcount ++;
            mc.getDatabase(dbName).getCollection(collectionName).insertOne(doc);
        }
        long endtime = new Date().getTime();
        int seconds = (int)((endtime - starttime) / 1000);

        FileFunction.TimePrint(seconds);
        System.out.println("The average of document translation is " + (this.metasloadcount)/((float)(endtime - starttime)/1000) + "per/s\n");

        fileFunction.WriteLogforTrans(FileFunction.getTime(seconds) + "," +
                (this.metasloadcount)/(float)seconds + "per/s", "dbinfo");
        return true;
    }

    public boolean DownLoadFile(String downpath) {
        this.SetTransLogPath();
        File logdir = new File(downpath + "/files" );
        if( !logdir.exists())
        {
            logdir.mkdirs();
        }

        BasicDBObject query = new BasicDBObject(),fields = new BasicDBObject();
        GridFS myFS = new GridFS(mydb);

        String filename = null;
        long filesize = 0;

        List<GridFSDBFile> gridFSDBFile = myFS.find(query, fields);
        Iterator<GridFSDBFile> it = gridFSDBFile.iterator();
        long allsize = 0;
        long filestime = new Date().getTime();
        //The is for download document
        while(it.hasNext())
        {
            GridFSDBFile gfile = it.next();
            filename = gfile.getFilename();
            filesize = gfile.getLength();
            allsize += filesize;
            long ofilestime = System.nanoTime();
            try {
                gfile.writeTo(downpath + "/files/" + filename.split("\\.")[0] + "_"
                        +gfile.getUploadDate().getTime() +
                        ".mbruc");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            long ofileetime = System.nanoTime();
            this.filesdowncount++;
            this.tempfilesdownspread += filesize;
            double speed = ((double)filesize/(1024*1024))/((float)(ofileetime - ofilestime)/1E9);
        fileFunction.WriteLogforTrans(speed + "" , QueryFileName.DOWN_FILE_PER);
            System.out.println("The translation of the " + filesdowncount + "th file is" + speed + "Mb/s\n");
        }
        long fileetime = new Date().getTime();
        int seconds = (int)((fileetime - filestime) / 1000);

        FileFunction.TimePrint(seconds);
        System.out.println("The average of translation speed is " + ((double)allsize/(1024*1024))/((float)(fileetime - filestime)/1000) + "Mb/s\n");
        fileFunction.WriteLogforTrans(FileFunction.getTime(seconds) + "," +
                ((double)allsize/(1024*1024))/(float)seconds + "MB/s", "dbinfo");
        return true;
    }

    public boolean DownLoadMetaFile(String downpath) {
        this.SetTransLogPath();
        File logdir = new File(downpath + "/metadata");
        if( !logdir.exists())
        {
            logdir.mkdirs();
        }
        BasicDBObject query = new BasicDBObject(),fields = new BasicDBObject();
        GridFS myFS = new GridFS(mydb);
        String filename = null;
        long filesize = 0;
        DBCollection collection = mydb.getCollection(this.collectionName);
        DBCursor cursormeta = collection.find();
        List<GridFSDBFile> gridFSDBFile = myFS.find(query, fields);

        int i = 0;
        long filestime = new Date().getTime();
        while(cursormeta.hasNext())
        {

            try {
                filename = gridFSDBFile.get(i).getFilename();
                FileWriter fw = new FileWriter(downpath + "/metadata/" + filename.split("\\.")[0] + "_"
                        + gridFSDBFile.get(i).getUploadDate().getTime()
                        + ".json");
                fw.write(cursormeta.next().toString());
                fw.close();
            } catch (IOException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }
            i++;
            this.metasdowncount++;
            this.tempfilemetadowncount ++;
        }
        long fileetime = new Date().getTime();
        int seconds = (int)((fileetime - filestime) / 1000);
        FileFunction.TimePrint(seconds);
        System.out.println("The average of document translation speed is " +
                (this.metasdowncount)/((float)(fileetime - filestime)/1000) + "per/s\n");
        fileFunction.WriteLogforTrans(FileFunction.getTime(seconds) + "," +
                (this.metasdowncount)/(float)seconds + "per/s", "dbinfo");
        DecimalFormat decimalFormat = new DecimalFormat(".00");

        long filesnum = this.GetDbFilesCount();
        double datasize = (double)(this.GetDataSize() / (1024 * 1024));
        double storagesize = (double)(this.GetStorageSize() / (1024 * 1024));
        double rates = ( datasize / storagesize ) * 100;
        storagesize = storagesize / 1024;

        fileFunction.WriteLogforTrans(decimalFormat.format(rates), "dbinfo");
        System.out.println(decimalFormat.format(rates));
        fileFunction.WriteLogforTrans(filesnum + "", "dbinfo");
        System.out.println(filesnum + "");
        fileFunction.WriteLogforTrans(this.GetDBName() + "", "dbinfo");
        System.out.println(this.GetDBName() + "");
        fileFunction.WriteLogforTrans(decimalFormat.format(storagesize), "dbinfo");
        System.out.println(decimalFormat.format(storagesize));
        return true;
    }

    public void VersionQuery(String datapath) throws IOException {
        this.finish = false;
        DB db = this.dbBase.getDB(dbName);
        DBCollection dbCollection = db.getCollection(collectionName);
        //下面的代码用于统计文件同名的个数，并将每个文件的重名个数分组统计
        DBObject keys = new BasicDBObject("FILENAME",1);
        DBObject condition = null;
        DBObject initial = new BasicDBObject("count", 0);
        String reduce = "function(doc, out){out.count++;}";
        String finalize = "function(out){return out;}";
        long start = System.nanoTime();
        BasicDBList filelist = (BasicDBList ) dbCollection.group(keys, condition, initial, reduce, finalize);
        long end = System.nanoTime();
        int count = 0;
        HashMap<String, Integer> resulthm = new HashMap<String, Integer>(); // 用于结果记录

        if(filelist != null){
            for(int i = 0; i < filelist.size(); i++){
                DBObject obj = (DBObject ) filelist.get(i);
                String file = (String) obj.get("FILENAME");
                int counts = Integer.parseInt((String)obj.get("count")) ;
                resulthm.put(file, counts);
                count += counts;
            }
        }

        int[] result = this.CopyCheck(datapath, resulthm);

        fileFunction.WriteLogforQuery(String.valueOf(count), QueryFileName.QUERY_VERISON);
        fileFunction.WriteLogforQuery(String.valueOf((float)((end - start) / 1E6)), QueryFileName.QUERY_VERISON);
        fileFunction.WriteLogforQuery(String.valueOf((float)(count / (float)((end - start) / 1E6))), QueryFileName.QUERY_VERISON);
        fileFunction.WriteLogforQuery(String.valueOf((float) result[1] / result[0]), QueryFileName.QUERY_VERISON);
        System.out.println(count);
        System.out.println("ALL cost time is " + (float)((end - start) / 1E6) + "ms");
        System.out.println("The Avg Speed of Query is " + (float)(count / (float)((end - start) / 1E6)) + "per/ms");
        System.out.println("The correct rate is " + (float) (result[1] / result[0]) * 100 + "%");
        this.finish = true;
    }

    public void AbnormalQuery() {
        DB db = this.dbBase.getDB(dbName);
        DBCollection dbCollection = db.getCollection(collectionName);
        //从historysetting中获取文件总数和异常文件占比
        String filename = this.getHistorySetting();
        BufferedReader reader = null;
        try {
            String path = Testpath.class.getClassLoader().getResource("HistorySettings").getPath();
            reader = new BufferedReader(new FileReader(path + "/"+filename));
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        String sline="";
        int timeblock = 0;
        Float unnormal = null;
        String filepath = null;
        try {
            while((sline = reader.readLine())!=null) {
                if(sline.split("\t")[0].contains("Time Block")) {
                    timeblock = Integer.valueOf(sline.split("\t")[1]);
                }
                if(sline.split("\t")[0].contains("Unnormal Presents")) {
                    unnormal = Float.valueOf(sline.split("\t")[1]);
                }
                if(sline.split("\t")[0].contains("Data Storage Path")) {
                    filepath = sline.split("\t")[1];
                    break;
                }
            }
        } catch (NumberFormatException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        int unnormalfile = (int)(timeblock*unnormal/100) + 1;
        File file = new File(filepath+"/loaddata/metadata");
        //获取总的异常文件名
        String [] zongnames=null;
        String [] zunnormalnames=null;//总的异常文件名
        ArrayList list_unnor = new ArrayList();
        File[] zongfiles = file.listFiles();
        for(int i=0;i<zongfiles.length;i++) {
            if(zongfiles[i].isDirectory()) {
                zongnames = zongfiles[i].list();//zongnames是总的文件名
            }
            for(String name:zongnames) {
                for(int k=timeblock-unnormalfile+1;k<timeblock+1;k++) {
                    String s = "_" + String.valueOf(k) + "%01.";
                    if(name.contains(s)) {
                        list_unnor.add(name);
                    }
                }
            }
        }
        zunnormalnames = (String[])list_unnor.toArray(new String[list_unnor.size()]);
        //异常文件检测
        //遍历文件的WINDSPEED（正常+异常：只有DEVICETYPE为BLADE的文件）
        DBObject query = new BasicDBObject();
        query.put("DEVICETYPE", "BLADE");
        DBCursor dbCursor = dbCollection.find(query);
        int count = dbCursor.count();
        ArrayList list_blade = new ArrayList();
        try {
            while (dbCursor.hasNext()) {
                DBObject dbobject = dbCursor.next();
                String string = dbobject.get("FILENAME").toString() + " : " + dbobject.get("WINDSPEED").toString();
                list_blade.add(string);
            }
            String[] str_blade = (String[])list_blade.toArray(new String[list_blade.size()]);
            float f_max = 0;
            for(int i1=0;i1<str_blade.length;i1++)
                for(int i=1;i<(timeblock-unnormalfile)/2;i++) {
                    String s = "_" + String.valueOf(i) + "$01.";
                    if(str_blade[i1].contains(s)) {
                        //求正常文件风速的最大方差
                        Float[] f_fangcha = new Float[str_blade[i1].split(" , ").length-2];
                        for(int j=1;j<str_blade[i1].split(" , ").length-1;j++) {
                            f_fangcha[j-1] = Float.valueOf(str_blade[i1].split(" , ")[j]);
                        }
                        if(this.getVariance(f_fangcha)>f_max) {
                            f_max = this.getVariance(f_fangcha);
                        }
                    }
                }
            //以最大正常风速方差的2倍为基准求异常文件
            String [] bunnormalnames=null;//计算出的总的异常文件
            ArrayList list_bunnor = new ArrayList();
            long start = System.nanoTime();
            for(int i=0;i<str_blade.length;i++) {
                String s_windspeed = str_blade[i].split(" : ")[1];
                Float[] f_windspeed = new Float[s_windspeed.split(" , ").length-2];
                for(int j=1;j<s_windspeed.split(" , ").length-1;j++) {
                    f_windspeed[j-1] = Float.valueOf(s_windspeed.split(" , ")[j]);
                }
                if(this.getVariance(f_windspeed)>(f_max*2)) {
                    list_bunnor.add(str_blade[i].split(" : ")[0]);
                }
            }
            bunnormalnames = (String[])list_bunnor.toArray(new String[list_bunnor.size()]);
            long end = System.nanoTime();
            //计算准确率和召回率
            int true_unnormal = 0;
            for(String s1:zunnormalnames)
                for(String s2:bunnormalnames) {
                    if(s1.substring(0, s1.length()-8).equals(s2.substring(0, s2.length()-9))) {
                        true_unnormal++;
                    }
                }
            float acc = (float)true_unnormal/bunnormalnames.length;
            float recall = (float)true_unnormal/zunnormalnames.length;
            fileFunction.WriteLogforQuery(String.valueOf((int)(count)), QueryFileName.QUERY_ABNORMAL);//文件总数
            fileFunction.WriteLogforQuery(String.valueOf((float)((end - start) / 1E6)), QueryFileName.QUERY_ABNORMAL);//用时
            fileFunction.WriteLogforQuery(String.valueOf((float)(bunnormalnames.length / (float)((end - start) / 1E6))), QueryFileName.QUERY_ABNORMAL);//速度
            fileFunction.WriteLogforQuery(String.valueOf(acc), QueryFileName.QUERY_ABNORMAL);//准确率
            fileFunction.WriteLogforQuery(String.valueOf(recall), QueryFileName.QUERY_ABNORMAL);//召回率
            System.out.println("acc: "+acc+" , " + "recall: "+recall);

        } finally {

            dbCursor.close();
        }
    }

    public void HotFileQuery(int queryCount, int interval) {
        this.finish = false;
        DB db = this.dbBase.getDB(dbName);
        DBCollection dbCollection = db.getCollection(collectionName);

        for(int i = 0; i < queryCount; i++) {
            long start = System.nanoTime();
            DBObject query = new BasicDBObject();
            query.put("AREANAME", "HuaBei");
            DBCursor dbCursor = dbCollection.find(query);
            long end = System.nanoTime();
            fileFunction.WriteLogforQuery(String.valueOf((float)((end - start) / 1E6)), QueryFileName.QUERY_HOTFILE);//用时
            System.out.println((float)((end - start) / 1E6));
            try {
                Thread.sleep (interval) ;
            } catch (InterruptedException ie){
            }
        }
    }

    public List<Object> QueryOne() {
        List<Object> object = new ArrayList<Object>();
        DB db = this.dbBase.getDB(dbName);
        DBCollection dbCollection = db.getCollection(collectionName);
        DBObject query = new BasicDBObject();
        query.put("DEVICETYPE", "BLADE");
        DBCursor dbCursor = dbCollection.find(query);
        Iterator<DBObject> countCurosr = dbCursor.iterator();
        int count = 0;
        long start = System.nanoTime();
        while(dbCursor.hasNext()){
            dbCursor.next();
            count++;
        }
        long end = System.nanoTime();
        try {
            while (countCurosr.hasNext()) {
                String mdata = countCurosr.next().toString();
                object.add(this.attributeChouQu(mdata,"FILENAME"));
                count++;
            }
        } finally {
            dbCursor.close();
        }
        object = new ArrayList<Object>(new TreeSet<Object>(object));
        fileFunction.WriteLogforQuery(String.valueOf(count), QueryFileName.QUERY_ONE);
        fileFunction.WriteLogforQuery(String.valueOf((float)((end - start) / 1E6)), QueryFileName.QUERY_ONE);
        fileFunction.WriteLogforQuery(String.valueOf((float)(count / (float)((end - start) / 1E6))), QueryFileName.QUERY_ONE);
        System.out.println(count);
        System.out.println("ALL cost time is " + (float)((end - start) / 1E6) + "ms");
        System.out.println("The Avg Speed of Query is " + (float)(count / (float)((end - start) / 1E6)) + "per/ms");
        return object;
    }

    public List<Object> QueryTwo() throws IOException {
        DB db = this.dbBase.getDB(dbName);
        DBCollection dbCollection = db.getCollection(collectionName);
        List<Object> objects = new ArrayList<Object>();
        BasicDBObject AreaObj = new BasicDBObject();
        BasicDBList values = new BasicDBList();
        values.add("XiBei");
        values.add("XiNan");
        values.add("QingZangGaoYuan");
        AreaObj.put("AREANAME",new BasicDBObject("$in",values));
        long start = System.nanoTime();
        DBCursor dbCursor = dbCollection.find(AreaObj);
        long end = System.nanoTime();
        int count = 0;
        try {
            while (dbCursor.hasNext()) {
                String mdata = dbCursor.next().toString();
                objects.add(this.attributeChouQu(mdata,"FILENAME"));
                //System.out.println(mdata);
                count++;
            }

        } finally {
            dbCursor.close();
        }

        fileFunction.WriteLogforQuery(String.valueOf(count), QueryFileName.QUERY_TWO);
        fileFunction.WriteLogforQuery(String.valueOf((float)((end - start) / 1E6)), QueryFileName.QUERY_TWO);
        fileFunction.WriteLogforQuery(String.valueOf((float)(count / (float)((end - start) / 1E6))), QueryFileName.QUERY_TWO);
        System.out.println(count);
        System.out.println("ALL cost time is " + (float)((end - start) / 1E6) + "ms");
        System.out.println("The Avg Speed of Query is " + (float)(count / (float)((end - start) / 1E6)) + "per/ms");

        return objects;
    }

    public List<Object> QueryThree(String sdate, int shour, int smins, int ssecs,
                                   String edate, int ehour, int emins, int esecs) {
        List<Object> object = new ArrayList<Object>();
        DB db = this.dbBase.getDB(dbName);
        DBCollection dbCollection = db.getCollection(collectionName);
        //String类型的日期转换为date类型
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");//string类型日期格式 "2008-4-24 09:51:00"
        Date mdate = null;
        long lsdate = 0;
        try {
            lsdate = this.GetSeconds(sdate, shour, smins, ssecs);
        } catch (ParseException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        long ledate = 0;
        try {
            ledate = this.GetSeconds(edate, ehour, emins, esecs);
        } catch (ParseException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        DBObject query = new BasicDBObject();
        DBCursor dbCursor = dbCollection.find(query);
        int count = 0;
        long start = System.nanoTime();
        while (dbCursor.hasNext()) {
            String mdata = dbCursor.next().toString();
            String msdate = this.attributeChouQu(mdata,"SIMULATIONTIME");
            //String类型的日期转换为date类型
            try {
                mdate=sdf.parse(msdate);
            } catch (ParseException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            long lmdate = mdate.getTime()/1000;//秒
            //System.out.println(lmdate);
            //比较是否在规定时间范围内
            if((lmdate>=lsdate&&lmdate<=ledate)) {
                object.add(this.attributeChouQu(mdata,"FILENAME"));
                count++;
                //System.out.println(this.attributeChouQu(mdata,"FILENAME"));
            }
        }
        long end = System.nanoTime();
        object = new ArrayList<Object>(new TreeSet<Object>(object));

        fileFunction.WriteLogforQuery(sdate + " " + shour + ":" + smins + ":" + ssecs
                        + "--" + edate + " " + ehour + ":" + emins + ":" + esecs
                , "query_simulationtime");
        fileFunction.WriteLogforQuery(String.valueOf(count), QueryFileName.QUERY_THREE);
        fileFunction.WriteLogforQuery(String.valueOf((float)((end - start) / 1E6)), QueryFileName.QUERY_THREE);
        fileFunction.WriteLogforQuery(String.valueOf((float)(count / (float)((end - start) / 1E6))), QueryFileName.QUERY_THREE);
        System.out.println(count);
        System.out.println("ALL cost time is " + (float)((end - start) / 1E6) + "ms");
        System.out.println("The Avg Speed of Query is " + (float)(count / (float)((end - start) / 1E6)) + "per/ms");
        return object;
    }

    public List<Object> QueryFour() {
        List<Object> object = new ArrayList<Object>();
        DB db = this.dbBase.getDB(dbName);
        DBCollection dbCollection = db.getCollection(collectionName);
        DBObject query = new BasicDBObject();
        query.put("DEVICETYPE", "BLADE");
        query.put("AREANAME", "DongBei");
        long start = System.nanoTime();
        DBCursor dbCursor = dbCollection.find(query);
        DBCursor countCurosr = dbCursor;
        int count = 0;
        while(countCurosr.hasNext()){
            countCurosr.next();
            count++;
        }
        long end = System.nanoTime();

        try {
            while (dbCursor.hasNext()) {
                String mdata = dbCursor.next().toString();
                object.add(this.attributeChouQu(mdata,"FILENAME"));
                //System.out.println(mdata);
                count++;
            }

        } finally {
            dbCursor.close();
        }
        object = new ArrayList<Object>(new TreeSet<Object>(object));

        fileFunction.WriteLogforQuery(String.valueOf(count), QueryFileName.QUERY_FOUR);
        fileFunction.WriteLogforQuery(String.valueOf((float)((end - start) / 1E6)), QueryFileName.QUERY_FOUR);
        fileFunction.WriteLogforQuery(String.valueOf((float)(count / (float)((end - start) / 1E6))), QueryFileName.QUERY_FOUR);
        System.out.println(count);
        System.out.println("ALL cost time is " + (float)((end - start) / 1E6) + "ms");
        System.out.println("The Avg Speed of Query is " + (float)(count / (float)((end - start) / 1E6)) + "per/ms");
        return object;
    }

    public List<Object> QueryFive() {
        List<Object> object = new ArrayList<Object>();
        DB db = this.dbBase.getDB(dbName);
        DBCollection dbCollection = db.getCollection(collectionName);

        BasicDBObject AreaObj = new BasicDBObject();
        BasicDBList values = new BasicDBList();
        values.add("DongBei");
        values.add("HuaBei");
        AreaObj.put("AREANAME",new BasicDBObject("$in",values));
        BasicDBObject TypeObj = new BasicDBObject("DEVICETYPE", "BLADE");
        BasicDBObject FinalObj = new BasicDBObject("$and", Arrays.asList(AreaObj, TypeObj));
        long start = System.nanoTime();
        DBCursor dbCursor = dbCollection.find(FinalObj);

        DBCursor countCurosr = dbCursor;
        int count = 0;
        while(countCurosr.hasNext()){
            countCurosr.next();
            count++;
        }
        long end = System.nanoTime();
        try {
            while (dbCursor.hasNext()) {
                String mdata = dbCursor.next().toString();
                object.add(this.attributeChouQu(mdata,"FILENAME"));
                //System.out.println(mdata);
                count++;
            }

        } finally {
            dbCursor.close();
        }

        object = new ArrayList<Object>(new TreeSet<Object>(object));

        fileFunction.WriteLogforQuery(String.valueOf(count), QueryFileName.QUERY_FIVE);
        fileFunction.WriteLogforQuery(String.valueOf((float)((end - start) / 1E6)), QueryFileName.QUERY_FIVE);
        fileFunction.WriteLogforQuery(String.valueOf((float)(count / (float)((end - start) / 1E6))), QueryFileName.QUERY_FIVE);
        System.out.println(count);
        System.out.println("ALL cost time is " + (float)((end - start) / 1E6) + "ms");
        System.out.println("The Avg Speed of Query is " + (float)(count / (float)((end - start) / 1E6)) + "per/ms");
        return object;
    }

    public List<Object> QuerySix() throws IOException {
        List<Object> object = new ArrayList<Object>();
        DB db = this.dbBase.getDB(dbName);
        DBCollection dbCollection = db.getCollection(collectionName);

        this.getValue();
        BasicDBObject LenHeiObj = new BasicDBObject();
        int heightsub = this.towerheigh_max - this.towerheigh_min;
        int lengthsub = this.sylenth_max - this.sylenth_min;
        LenHeiObj.append("BLADELENGTH",new BasicDBObject("$gte",this.sylenth_min + (int)(lengthsub / 4)));
        LenHeiObj.append("BLADELENGTH",new BasicDBObject("$lte",this.sylenth_max - (int)(lengthsub / 4)));
        LenHeiObj.append("TOWERHEIGHT",new BasicDBObject("$gte",this.towerheigh_min + (int)(heightsub / 4)));
        LenHeiObj.append("TOWERHEIGHT",new BasicDBObject("$lte",this.towerheigh_max - (int)(heightsub / 4)));
        long start = System.nanoTime();
        DBCursor dbCursor = dbCollection.find(LenHeiObj);
        DBCursor countCurosr = dbCursor;
        int count = 0;
        while(countCurosr.hasNext()){
            countCurosr.next();
            count++;
        }
        long end = System.nanoTime();
        try {
            while (dbCursor.hasNext()) {
                String mdata = dbCursor.next().toString();
                object.add(this.attributeChouQu(mdata,"FILENAME"));
                //System.out.println(mdata);
                count++;
            }

        } finally {
            dbCursor.close();
        }
        object = new ArrayList<Object>(new TreeSet<Object>(object));

        fileFunction.WriteLogforQuery(String.valueOf(count), QueryFileName.QUERY_SIX);
        fileFunction.WriteLogforQuery(String.valueOf((float)((end - start) / 1E6)), QueryFileName.QUERY_SIX);
        fileFunction.WriteLogforQuery(String.valueOf((float)(count / (float)((end - start) / 1E6))), QueryFileName.QUERY_SIX);
        System.out.println(count);
        System.out.println("ALL cost time is " + (float)((end - start) / 1E6) + "ms");
        System.out.println("The Avg Speed of Query is " + (float)(count / (float)((end - start) / 1E6)) + "per/ms");
        return object;
    }

    public List<Object> QuerySeven() {
        List<Object> object = new ArrayList<Object>();
        DB db = this.dbBase.getDB(dbName);
        DBCollection dbCollection = db.getCollection(collectionName);

        BasicDBObject AreaObj = new BasicDBObject();
        BasicDBList values = new BasicDBList();
        values.add("Dongbei");
        values.add("HuaBei");
        AreaObj.put("AREANAME",new BasicDBObject("$in",values));
        BasicDBObject TypeObj = new BasicDBObject("DEVICETYPE", "BLADE");
        int heightsub = this.towerheigh_max - this.towerheigh_min;
        BasicDBObject TowHeiObj = new BasicDBObject();
        TowHeiObj.append("TOWERHEIGHT",new BasicDBObject("$gte",this.towerheigh_min + (int)(heightsub / 4)));
        TowHeiObj.append("TOWERHEIGHT",new BasicDBObject("$lte",this.towerheigh_max - (int)(heightsub / 4)));
        BasicDBObject FinalObj = new BasicDBObject("$and",Arrays.asList(AreaObj, TypeObj, TowHeiObj));
        long start = System.nanoTime();
        DBCursor dbCursor = dbCollection.find(FinalObj);

        DBCursor countCurosr = dbCursor;
        int count = 0;
        while(countCurosr.hasNext()){
            countCurosr.next();
            count++;
        }
        long end = System.nanoTime();
        try {
            while (dbCursor.hasNext()) {
                String mdata = dbCursor.next().toString();
                object.add(this.attributeChouQu(mdata,"FILENAME"));
                //System.out.println(mdata);
                count++;
            }

        } finally {
            dbCursor.close();
        }
        object = new ArrayList<Object>(new TreeSet<Object>(object));

        fileFunction.WriteLogforQuery(String.valueOf(count), QueryFileName.QUERY_SEVEN);
        fileFunction.WriteLogforQuery(String.valueOf((float)((end - start) / 1E6)), QueryFileName.QUERY_SEVEN);
        fileFunction.WriteLogforQuery(String.valueOf((float)(count / (float)((end - start) / 1E6))), QueryFileName.QUERY_SEVEN);
        System.out.println(count);
        System.out.println("ALL cost time is " + (float)((end - start) / 1E6) + "ms");
        System.out.println("The Avg Speed of Query is " + (float)(count / (float)((end - start) / 1E6)) + "per/ms");
        return object;
    }

    public void QueryNine() {
        DB db = this.dbBase.getDB(dbName);
        DBCollection dbCollection = db.getCollection(collectionName);
        DBObject query = new BasicDBObject();
        //选择DEVICETYPE类型为BLADE的
        query.put("DEVICETYPE","BLADE");

        long start = System.nanoTime();
        //mongodb中按TOWERHIGHT字段倒序排序（-1是倒序，1是正序）
        DBCursor dbCursor = dbCollection.find(query).sort(new BasicDBObject("BLADEWIDTH",-1));
        DBCursor countCurosr = dbCursor;
        int count = 0;
        while(countCurosr.hasNext()){
            countCurosr.next();
            count++;
        }
        long end = System.nanoTime();

        fileFunction.WriteLogforQuery(String.valueOf(count), QueryFileName.QUERY_NINE);//排序文件总数
        fileFunction.WriteLogforQuery(String.valueOf((float)((end - start) / 1E6)), QueryFileName.QUERY_NINE);//用时
        fileFunction.WriteLogforQuery(String.valueOf((float)(count / (float)((end - start) / 1E6))), QueryFileName.QUERY_NINE);//排序速度
        System.out.println("The number of files is " + count);
        System.out.println("ALL cost time is " + (float)((end - start) / 1E6) + "ms");
        System.out.println("The Avg Speed of Sort is " + (float)(count / (float)((end - start) / 1E6)) + "per/ms");
    }

    public void QueryTen() {
        DB db = this.dbBase.getDB(dbName);
        DBCollection dbCollection = db.getCollection(collectionName);
        DBObject query = new BasicDBObject();
        query.put("DEVICETYPE","BLADE");

        long start = System.nanoTime();
        //mongodb中按地区正序排序（-1是倒序，1是正序）
        DBCursor dbCursor = dbCollection.find(query).sort(new BasicDBObject("AREANAME",1));
        DBCursor countCurosr = dbCursor;
        int count = 0;
        while(countCurosr.hasNext()){
            countCurosr.next();
            count++;
        }
        long end = System.nanoTime();

        fileFunction.WriteLogforQuery(String.valueOf(count), QueryFileName.QUERY_TEN);//排序文件总数
        fileFunction.WriteLogforQuery(String.valueOf((float)((end - start) / 1E6)), QueryFileName.QUERY_TEN);//用时
        fileFunction.WriteLogforQuery(String.valueOf(count / (float)((end - start) / 1E6)), QueryFileName.QUERY_TEN);//排序速度
        System.out.println("The number of files is " + count);
        System.out.println("ALL cost time is " + (float)((end - start) / 1E6) + "ms");
        System.out.println("The Avg Speed of Sort is " + count / (float)((end - start) / 1E6) + "per/ms");
    }

    public void QueryEleven() {
        DB db = this.dbBase.getDB(dbName);
        DBCollection dbCollection = db.getCollection(collectionName);
        DBObject query = new BasicDBObject();
        query.put("DEVICETYPE","BLADE");

        //mongodb中按时间正序排序（-1是倒序，1是正序）
        long start = System.nanoTime();
        DBCursor dbCursor = dbCollection.find(query).sort(new BasicDBObject("SIMULATIONTIME",1));
        DBCursor countCurosr = dbCursor;
        int count = 0;
        while(countCurosr.hasNext()){
            countCurosr.next();
            count++;
        }
        long end = System.nanoTime();

        fileFunction.WriteLogforQuery(String.valueOf(count), QueryFileName.QUERY_ELEVEN);//排序文件总数
        fileFunction.WriteLogforQuery(String.valueOf((float)((end - start) / 1E6)), QueryFileName.QUERY_ELEVEN);//用时
        fileFunction.WriteLogforQuery(String.valueOf((float)(count / (float)((end - start) / 1E6))), QueryFileName.QUERY_ELEVEN);//排序速度
        System.out.println("The number of files is " + count);
        System.out.println("ALL cost time is " + (float)((end - start) / 1E6) + "ms");
        System.out.println("The Avg Speed of Sort is " + (float)(count / (float)((end - start) / 1E6)) + "per/ms");
    }

    public void QueryTwelve() {
        DB db = this.dbBase.getDB(dbName);
        DBCollection dbCollection = db.getCollection(collectionName);
        int count = 0;
        long start = System.nanoTime();
        //unwind操作拆分WINDSPEED数组
        DBObject unwind = new BasicDBObject("$unwind", "$WINDSPEED");
        //Group操作
        DBObject groupFields = new BasicDBObject("_id","$_id");//按_id分组，每个文件分为一组
        groupFields.put("AvgSpeed", new BasicDBObject("$avg", "$WINDSPEED"));
        DBObject group = new BasicDBObject("$group", groupFields);
        //查看Group结果
        AggregationOutput output = dbCollection.aggregate(unwind,group);// 执行 aggregation命令
        count = output.results().toString().split(",").length/2;
        long end = System.nanoTime();

        fileFunction.WriteLogforQuery(String.valueOf(count), QueryFileName.QUERY_TWELVE);//文件总数
        fileFunction.WriteLogforQuery(String.valueOf((float)((end - start) / 1E6)), QueryFileName.QUERY_TWELVE);//用时
        fileFunction.WriteLogforQuery(String.valueOf((float)(count / (float)((end - start) / 1E6))), QueryFileName.QUERY_TWELVE);//速度
        System.out.println("The number of files is " + count);
        System.out.println("ALL cost time is " + (float)((end - start) / 1E6) + "ms");
        System.out.println("The Avg Speed of Query is " + (float)(count / (float)((end - start) / 1E6)) + "per/ms");
    }

    public void QueryThirteen() {
        DB db = this.dbBase.getDB(dbName);
        DBCollection dbCollection = db.getCollection(collectionName);
        int count = 0;
        long start = System.nanoTime();
        //unwind操作拆分WINDSPEED数组
        DBObject unwind = new BasicDBObject("$unwind", "$WINDSPEED");
        //Group操作
        DBObject groupFields = new BasicDBObject("_id","$_id");//按_id分组，每个文件分为一组
        groupFields.put("MinSpeed", new BasicDBObject("$min", "$WINDSPEED"));
        DBObject group = new BasicDBObject("$group", groupFields);
        //查看Group结果
        AggregationOutput output = dbCollection.aggregate(unwind,group);// 执行 aggregation命令
        count = output.results().toString().split(",").length/2;
        long end = System.nanoTime();

        fileFunction.WriteLogforQuery(String.valueOf(count), QueryFileName.QUERY_THIRTEEN);//文件总数
        fileFunction.WriteLogforQuery(String.valueOf((float)((end - start) / 1E6)), QueryFileName.QUERY_THIRTEEN);//用时
        fileFunction.WriteLogforQuery(String.valueOf((float)(count / (float)((end - start) / 1E6))), QueryFileName.QUERY_THIRTEEN);//速度
        System.out.println("The number of files is " + count);
        System.out.println("ALL cost time is " + (float)((end - start) / 1E6) + "ms");
        System.out.println("The Avg Speed of Query is " + (float)(count / (float)((end - start) / 1E6)) + "per/ms");
    }

    public void QueryForteen() {
        DB db = this.dbBase.getDB(dbName);
        DBCollection dbCollection = db.getCollection(collectionName);
        int count = 0;
        long start = System.nanoTime();
        //unwind操作拆分WINDSPEED数组
        DBObject unwind = new BasicDBObject("$unwind", "$WINDSPEED");
        //Group操作
        DBObject groupFields = new BasicDBObject("_id","$_id");//按_id分组，每个文件分为一组
        groupFields.put("MaxSpeed", new BasicDBObject("$max", "$WINDSPEED"));
        DBObject group = new BasicDBObject("$group", groupFields);
        //查看Group结果
        AggregationOutput output = dbCollection.aggregate(unwind,group);// 执行 aggregation命令
        count = output.results().toString().split(",").length/2;
        long end = System.nanoTime();

        fileFunction.WriteLogforQuery(String.valueOf(count), QueryFileName.QUERY_FORTEEN);//文件总数
        fileFunction.WriteLogforQuery(String.valueOf((float)((end - start) / 1E6)), QueryFileName.QUERY_FORTEEN);//用时
        fileFunction.WriteLogforQuery(String.valueOf((float)(count / (float)((end - start) / 1E6))), QueryFileName.QUERY_FORTEEN);//速度
        System.out.println("The number of files is " + count);
        System.out.println("ALL cost time is " + (float)((end - start) / 1E6) + "ms");
        System.out.println("The Avg Speed of Query is " + (float)(count / (float)((end - start) / 1E6)) + "per/ms");
    }

    public void DownloadFileByList(List<Object> obj, String downfilename, String downfilepath) {
        File logdir = new File(downfilepath + "/" + downfilename + "/");
        if(!logdir.exists()){
            logdir.mkdirs();
        }

        DB db = this.dbBase.getDB(this.dbName);
        GridFS myFS = new GridFS(db);
        String filename = null;
        int filesdowncount = 0;
        long filesize = 0;
        long allsize = 0;
        long filestime = new Date().getTime();
        int count = 0;
        double minspeed = 1E6;double maxspeed = 0;
        for(int i=0;i<obj.size();i++) {
            String s = obj.get(i).toString();
            BasicDBObject query = new BasicDBObject();
            query.put("filename", s);
            List<GridFSDBFile> gridFSDBFile = myFS.find(query);
            Iterator<GridFSDBFile> it = gridFSDBFile.iterator();

            while(it.hasNext()){
                GridFSDBFile gfile = it.next();
                filename = gfile.getFilename();
                filesize = gfile.getLength();
                allsize += filesize;
                long ofilestime = System.nanoTime();
                try {
                    gfile.writeTo(downfilepath + "/" + downfilename + "/" + filename.split("\\.")[0] + "_"
                            +gfile.getUploadDate().getTime() +
                            ".mbruc"); //下载文件
                } catch (IOException e1) {
                    // TODO Auto-generated catch block
                    e1.printStackTrace();
                }
                long ofileetime = System.nanoTime();
                filesdowncount++;
                double speed = ((double)filesize/(1024*1024))/((float)(ofileetime - ofilestime)/1E9);
                if(speed<minspeed) {
                    minspeed = speed;
                }
                if(speed>maxspeed) {
                    maxspeed = speed;
                }
                fileFunction.WriteLogforQuery(String.valueOf(speed), downfilename);
                System.out.println("File name is " + filename + "The current down file count ：" + filesdowncount + "; " +
                        "The curent down file speed ：" + speed + "Mb/s\n");
                count++;
            }
        }
        long fileetime = new Date().getTime();
        System.out.println("All down files count : "+count);
        System.out.println("The max speed is ："+maxspeed + "Mb/s");
        System.out.println("The min speed is ："+minspeed + "Mb/s");
        System.out.println("The average speed is ：" + ((double)allsize/(1024*1024))/((float)(fileetime - filestime)/1000) + "Mb/s");
    }
}
