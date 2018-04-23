package cn.ruc.edu.mbdatagen;

import java.io.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

public class FansDevice extends Thread{
    /*
     * 下面的参数是用来记录当前设备的环境条件数值和设备本身的基础数值
     */
    public int id; //设备的id值，在多设备时表示生成的序号
    public int tower_height; //风力发电的塔高，和风速相关
    public List<Integer> towerheightList = null;
    public int blade_length; //叶片的长度，与面积相关
    public List<Integer> bladelengthList = null;
    public int blade_width; //叶片的宽度，与面积相关
    public List<Integer> bladewidthList = null;
    public float air_density = (float) 1.2933; //空气密度，为定值
    public String area_name; //录入地区名称
    public List<String> areanameList = null;

    public boolean usedevicenum = false;
    public windspeed sp;
    public List<windspeed> sps;

    public int divtime; //录入每个时刻文件生成的数量
    public int changenum;

    public float uv;
    public List<Float> uvs;

    public int filepluspar;
    public int copynum = 0;

    //设置仿真起始时间
    String sdate = null;
    public int hourstart = 0;
    public int minstart = 0;
    public int secondstart = 0;
    Calendar dsDate = Calendar.getInstance();

    //设置仿真终止时间
    String edate = null;
    public int hourend = 0;
    public int minend = 0;
    public int secondend = 0;
    Calendar deDate = Calendar.getInstance();

    Calendar addDate = Calendar.getInstance();
    //设置时间间隔和文件数量
    public int splittime;
    public int filenum;

    public List<Float> sizes;
    public List<Float> presents;

    //设置文件存储路径
    public String filepath;
    public int pretentfilecount = 0;
    public float size = 0;

    public byte[] filecontent;
    public float maxsize;
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    //设置元数据生成类型
    public int[] metatype;

    //设置生成设备的分批
    public int splitdevice = 1;
    public int threadcount = 0;

    public float unnormal = 0;
    public float unnormalfactor = 5;

    public void SetSplitDevice(int num, int tc){
        this.splitdevice = num;
        this.threadcount = tc;
    }

    public void FileSetting(int id, String fpath, int fnum,
                            int dnum, int ch, int fipp)
    {
        this.id = id;
        this.filepath = fpath;
        this.filenum =fnum;
        this.divtime = dnum;
        this.changenum = ch;
        this.filepluspar = fipp;
    }

    public void SetDeviceParamter(String an, int th, int bl, int bw)
    {
        this.area_name = an;
        this.tower_height = th;
        this.blade_length = bl;
        this.blade_width = bw;
    }

    public void SetDeviceParamters(List<String> an, List<Integer>th, List<Integer> bl, List<Integer> bw)
    {
        this.areanameList = an;
        this.towerheightList = th;
        this.bladelengthList = bl;
        this.bladewidthList = bw;
    }

    public void SetWindParamter(windspeed w, float uv)
    {
        this.sp = w;
        this.uv = uv;
    }

    public void SetWindParamters(List<windspeed> w, float uv){
        this.sps = w;
        this.uv = uv;
    }

    public void SetCopyNum(int cn){
        this.copynum = cn;
    }

    public void SetStartTime(String sd, int h, int m, int s)
    {
        this.sdate = sd;
        this.hourstart = h;
        this.minstart = m;
        this.secondstart = s;
    }

    public void SetEndTime(String ed, int h, int m, int s)
    {
        this.edate = ed;
        this.hourend = h;
        this.minend = m;
        this.secondend = s;
    }

    public void SetByteContent(){
        byte[] content = new byte[(int)(1024 * 1024 * this.maxsize)];
        Random rnd = new Random();
        rnd.nextBytes(content);
        this.filecontent = content;
    }

    public void SetUnnormalPresent(float un){
        this.unnormal = un;
    }

    public long GetAllSeconds() throws ParseException
    {
        int[] t = new int[3];
        int i = 0;
        String[] s = this.sdate.split("-");
        for(String ss : s)
        {
            t[i] = Integer.parseInt(ss);
            i++;
        }
        this.dsDate.set(t[0], t[1] - 1, t[2], this.hourstart, this.minstart, this.secondstart);
        this.addDate.set(t[0], t[1] - 1, t[2], this.hourstart, this.minstart, this.secondstart);
        s = this.edate.split("-");
        i = 0;
        for(String ss : s)
        {
            t[i] = Integer.parseInt(ss);
            i++;
        }
        this.deDate.set(t[0], t[1] - 1, t[2], this.hourend, this.minend, this.secondend);

        long submillisec = this.deDate.getTime().getTime() - this.dsDate.getTime().getTime();
        long allsecond =  submillisec / 1000;
        return allsecond;
    }

    public void SetSplittime() throws ParseException
    {
        long allsecond = this.GetAllSeconds();
        this.splittime = (int) (allsecond / (this.filenum - 1));
    }

    public void SetUsedSplittime() throws ParseException
    {
        long allsecond = this.GetAllSeconds();
        this.splittime = (int) (allsecond / (this.filepluspar - 1));
    }

    public Calendar GetTimeBySplittime() throws ParseException
    {
        this.addDate.add(Calendar.SECOND, this.splittime);
        return this.addDate;
    }

    public Calendar GetTimeForUpdate(int i)
    {
        Calendar toDate = Calendar.getInstance();
        toDate.set(this.dsDate.get(Calendar.YEAR), this.dsDate.get(Calendar.MONTH),
                this.dsDate.get(Calendar.DATE), this.dsDate.get(Calendar.HOUR),
                this.dsDate.get(Calendar.MINUTE), this.dsDate.get(Calendar.SECOND));
        toDate.add(Calendar.SECOND, i * this.splittime);
        return toDate;
    }

    public void SetFilesizes(List<Float> s, List<Float> p, float max)
    {
        this.sizes = s;
        this.presents = p;
        this.maxsize = max;
    }

    public float GetPresentSize()
    {
        float sizes = this.size;
        this.size = 0;
        return sizes;
    }

    public void FileGener(String filepath, int num, String type, float size) throws IOException {
        File disable = new File(filepath + "/" + this.id + "_" +
                num + type + ".mbruc");
        disable.createNewFile();
        FileOutputStream fp = new FileOutputStream(disable);
        if(size == this.maxsize)
            fp.write(this.filecontent);
        else
            fp.write(this.filecontent, 0, (int) (1024 * 1024 * size));
        fp.flush();
        fp.close();
    }

    public void FileGener(String filepath, int deviceid, int num, String type, float size) throws IOException{
        File disable = new File(filepath + "/" + deviceid + "_" +
                num + type + ".mbruc");
        disable.createNewFile();
        FileOutputStream fp = new FileOutputStream(disable);
        if(size == this.maxsize)
            fp.write(this.filecontent);
        else
            fp.write(this.filecontent, 0, (int) (1024 * 1024 * size));
        fp.flush();
        fp.close();
    }

    public float[] MMAData(ArrayList<Float> list){
        float[] data = new float[3];
        float sum = 0;
        data[1] = data[0] = list.get(0);
        for(float s : list){
            if(data[0] < s)
                data[0] = s;
            if(data[1] > s)
                data[1] = s;
            sum += s;
        }
        data[2] = sum / list.size();
        return data;
    }

    public void SetMetaType(int[] meta){
        this.metatype = meta;
    }

    public void NewFileCount() throws IOException{
        File filescheck = new File(this.filepath  + "/" + this.id + ".txt");
        try {
            filescheck.createNewFile();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        FileWriter fw = new FileWriter(filescheck.getAbsolutePath());

        if(splitdevice == 1){
            for(int i = 1; i <= this.filenum; i++)
            {

                fw.write(this.id + "_" + i + ":" + 1 + "\n");
                fw.flush();
            }
            fw.close();
        }
        else{
            for(int i = 0; i < splitdevice; i++)
                for(int j = 1; j <= this.filenum; j++)
                {
                    fw.write((this.id + i * threadcount) + "_" + j + ":" + 1 + "\n");
                    fw.flush();
                }
        }
        fw.close();
    }

    public void UseFileCount(boolean[] file) throws IOException{
        RandomAccessFile raFile = new RandomAccessFile(this.filepath  + "/" + this.id + ".txt", "rw");
        String check = null;
        long oldmark = 0;
        for(int i = 0; i < file.length; i++){
            if(file[i]){
                boolean finish = false;
                while((check = raFile.readLine()) != null){
                    if(check.contains(this.id + "_" + (i+1)))
                    {
                        int count = Integer.parseInt(check.split(":")[1]);
                        System.out.println((this.id + "_" + (i + 1) + ":" + count));

                        raFile.seek(oldmark);
                        raFile.writeBytes(this.id + "_" + (i + 1) + ":" + (count+1) + "\n");
                        finish = true;
                    }
                    oldmark = raFile.getFilePointer();
                    if(finish)
                        break;
                }
            }
        }
        raFile.close();
    }

    public void UseFileCount(int deid, boolean[] file) throws IOException{
        RandomAccessFile raFile = new RandomAccessFile(this.filepath  + "/" + this.id + ".txt", "rw");
        String check = null;
        long oldmark = 0;
        for(int i = 0; i < file.length; i++){
            if(file[i]){
                boolean finish = false;
                while((check = raFile.readLine()) != null)
                {
                    if(check.split(":")[0].equals(deid + "_" + (i+1)))
                    {
                        int count = Integer.parseInt(check.split(":")[1]);
                        System.out.println((deid + "_" + (i + 1) + ":" + count));

                        raFile.seek(oldmark);
                        raFile.writeBytes(deid + "_" + (i + 1) + ":" + (count+1) + "\n");
                        finish = true;
                    }
                    oldmark = raFile.getFilePointer();
                    if(finish){
                        //raFile.seek(0);
                        break;
                    }
                }
            }
        }
        raFile.close();
    }



    public void run()
    {
        try{
            System.out.println("Device " + this.id + " Start!");
            //生成二进制数组
            this.SetByteContent();

            //表示当前线程只生成一个设备
            if(this.splitdevice == 1){
                int[] sizess = new int[this.filenum];
                for(int i = 1; i < this.sizes.size(); i++)
                {
                    int curentnum = (int) (this.filenum * this.presents.get(i));
                    for(int j = 1; j <= curentnum; j++)
                    {
                        int rs = new Random().nextInt(this.filenum);
                        if(sizess[rs] == i)
                        {
                            j--;
                            continue;
                        }
                        else
                        {
                            sizess[rs] = i;
                        }
                    }
                }

                //检测当前是否为按照已有文件生成
                if(this.changenum == 0 && this.filepluspar != 0)
                {
                    this.SetUsedSplittime();

                    boolean[] allfile = new boolean[this.filenum];
                    for(int i = 0; i < this.filenum; i++)
                        allfile[i] = false;

                    if(this.filenum == this.filepluspar)
                    {
                        for(int i = 0; i < this.filepluspar; i++)
                            allfile[i] = true;
                    }
                    else
                    {
                        for(int i = 0; i < this.filepluspar; i++)
                        {
                            int random = new Random().nextInt(this.filenum);
                            if(allfile[random])
                            {
                                i--;
                                continue;
                            }
                            else {
                                allfile[random] = true;
                            }
                        }
                    }

                    File sfile = new File(this.filepath + "/updata" + this.copynum + "/file");
                    sfile.mkdirs();
                    String loaddatapath = sfile.getAbsolutePath();
                    File mjfile = new File(this.filepath + "/updata" + this.copynum + "/metadata/json");
                    mjfile.mkdirs();
                    String jsondatapath = mjfile.getAbsolutePath();
                    File mxfile = new File(this.filepath + "/updata" + this.copynum + "/metadata/xml");
                    mxfile.mkdirs();
                    String xmldatapath = mxfile.getAbsolutePath();
                    File mtfile = new File(this.filepath + "/updata" + this.copynum + "/metadata/txt");
                    mtfile.mkdirs();
                    String txtdatapath = mtfile.getAbsolutePath();

                    this.UseFileCount(allfile);

                    for(int i = 1; i <= this.filenum;i++)
                    {
                        if(!allfile[i-1])
                            continue;

                        float size = this.sizes.get(sizess[i-1]);

                        ArrayList<Float> windlist = sp.GetWindBySecond(this.divtime);
                        ArrayList<Float> nlist = new ArrayList<Float>();
                        ArrayList<Float> cplist = new ArrayList<Float>();
                        ArrayList<Float> pwlist = new ArrayList<Float>();

                        ArrayList<Float> mtplist = new ArrayList<Float>();
                        ArrayList<Float> ewlist = new ArrayList<Float>();

                        ArrayList<Float> twlist = new ArrayList<Float>();
                        ArrayList<Float> twratelist = new ArrayList<Float>();

                        for(int j = 0; j < this.divtime; j++)
                        {
                            float n =  (float) (windlist.get(j) / (2 * Math.PI * this.blade_length));
                            nlist.add(n);
                            float cp = (float) (-0.3656 * (Math.pow(1 / windlist.get(j), 2)) + 0.6505 / windlist.get(j));
                            cplist.add(cp);
                            float pw = (float) (0.5 * 1.2933 * Math.PI * Math.pow(this.blade_length, 2)
                                    * Math.pow(windlist.get(j), 3) * cp);
                            pwlist.add(pw);

                            float mtprate = (float) (new Random().nextFloat() + 9) / 10;
                            mtplist.add(mtprate);
                            float ew = pw * mtprate;
                            ewlist.add(ew);

                            //15表示交联聚乙烯绝缘电缆100KM的电阻阻值
                            float ewtrue = ew - (ew / this.uv) * (ew / this.uv) * 15;
                            twlist.add(ewtrue);
                            twratelist.add(ewtrue / ew);
                        }

                        Calendar date = this.GetTimeForUpdate(i-1);

                        MetaFileGen.BladeMetaGen(this.id, i, this.filepath + "/updata" + this.copynum + "/metadata",
                                air_density, tower_height, blade_width, blade_length, area_name, date, windlist,nlist,
                                pwlist, cplist, metatype);

                        this.FileGener(loaddatapath, i, "$01", size);
                        this.pretentfilecount ++;
                        this.size += size;
                        size = size / 2;

                        MetaFileGen.Dynamo(this.id, i, this.filepath + "/updata" + this.copynum + "/metadata",
                                air_density, tower_height, blade_width, blade_length, area_name, date, mtplist,
                                ewlist, metatype);
                        this.FileGener(loaddatapath, i, "$02", size);

                        this.pretentfilecount ++;
                        this.size += size;

                        MetaFileGen.TransMetaGen(this.id, i, this.filepath + "/updata" + this.copynum + "/metadata",
                                air_density, tower_height, blade_width, blade_length, area_name, date, twlist,
                                twratelist, metatype);

                        this.FileGener(loaddatapath, i, "$03", size);

                        this.pretentfilecount ++;
                        this.size += size;
                    }
                }

                else
                {
                    this.SetSplittime();
                    File lsfile = new File(this.filepath + "/" + "loaddata/file");
                    lsfile.mkdirs();
                    String loaddatapath = lsfile.getAbsolutePath();
                    File ltfile = new File(this.filepath + "/" + "loaddata/metadata/txt");
                    ltfile.mkdirs();
                    String loadtxtpath = ltfile.getAbsolutePath();
                    File ljfile = new File(this.filepath + "/" + "loaddata/metadata/json");
                    ljfile.mkdirs();
                    String loadjsonpath = ljfile.getAbsolutePath();
                    File lxfile = new File(this.filepath + "/" + "loaddata/metadata/xml");
                    lxfile.mkdirs();
                    String loadxmlpath = lxfile.getAbsolutePath();


                    this.NewFileCount();
                    boolean first = true;

                    for(int i = 1; i <= this.filenum; i++)
                    {
                        if(first && i >= (this.filenum * (1- this.unnormal))){
                            first = false;
                            float normal = sp.GetShunWind();
                            sp.SetShunWind(normal * this.unnormalfactor);
                        }
                        float size = this.sizes.get(sizess[i-1]);
                        ArrayList<Float> windlist = sp.GetWindBySecond(this.divtime);
                        ArrayList<Float> nlist = new ArrayList<Float>();
                        ArrayList<Float> cplist = new ArrayList<Float>();
                        ArrayList<Float> pwlist = new ArrayList<Float>();

                        ArrayList<Float> mtplist = new ArrayList<Float>();
                        ArrayList<Float> ewlist = new ArrayList<Float>();

                        ArrayList<Float> twlist = new ArrayList<Float>();
                        ArrayList<Float> twratelist = new ArrayList<Float>();

                        for(int j = 0; j < this.divtime; j++)
                        {
                            float n =  (float) (windlist.get(j) / (2 * Math.PI * this.blade_length));
                            nlist.add(n);
                            float cp = (float) (-0.3656 * (Math.pow(1 / windlist.get(j), 2)) + 0.6505 / windlist.get(j));
                            cplist.add(cp);
                            float pw = (float) (0.5 * 1.2933 * Math.PI * Math.pow(this.blade_length, 2)
                                    * Math.pow(windlist.get(j), 3) * cp);
                            pwlist.add(pw);

                            float mtprate = (float) (new Random().nextFloat() + 9) / 10;
                            mtplist.add(mtprate);
                            float ew = pw * mtprate;
                            ewlist.add(ew);

                            //15表示交联聚乙烯绝缘电缆100KM的电阻阻值
                            float ewtrue = ew - (ew / this.uv) * (ew / this.uv) * 15;
                            twlist.add(ewtrue);
                            twratelist.add(ewtrue / ew);
                        }
                        Calendar date = null;
                        if(i == 1)
                            date = this.dsDate;
                        else
                            date = this.GetTimeBySplittime();

                        MetaFileGen.BladeMetaGen(this.id, i, this.filepath + "/" + "loaddata/metadata",
                                air_density, tower_height, blade_width, blade_length, area_name, date, windlist,nlist,
                                pwlist, cplist, metatype);

                        this.FileGener(loaddatapath, i, "$01", size);
                        this.pretentfilecount ++;
                        this.size += size;
                        size = size / 2;

                        MetaFileGen.Dynamo(this.id, i, this.filepath + "/" + "loaddata/metadata",
                                air_density, tower_height, blade_width, blade_length, area_name, date, mtplist,
                                ewlist, metatype);
                        this.FileGener(loaddatapath, i, "$02", size);

                        this.pretentfilecount ++;
                        this.size += size;

                        MetaFileGen.TransMetaGen(this.id, i, this.filepath + "/" + "loaddata/metadata",
                                air_density, tower_height, blade_width, blade_length, area_name, date, twlist,
                                twratelist, metatype);

                        this.FileGener(loaddatapath, i, "$03", size);

                        this.pretentfilecount ++;
                        this.size += size;
                    }

                    sp.SetShunWind(sp.GetShunWind() / this.unnormalfactor);

                    if(this.changenum == 0)
                    {
                    }
                    else
                    {
                        File usfile = new File(this.filepath + "/" + "updata1/file");
                        usfile.mkdirs();
                        String updatapath = usfile.getAbsolutePath();
                        File utfile = new File(this.filepath + "/" + "updata1/metadata/txt");
                        utfile.mkdirs();
                        String uptxtpath = utfile.getAbsolutePath();
                        File ujfile = new File(this.filepath + "/" + "updata1/metadata/json");
                        ujfile.mkdirs();
                        String upjsonpath = ujfile.getAbsolutePath();
                        File uxfile = new File(this.filepath + "/" + "updata1/metadata/xml");
                        uxfile.mkdirs();
                        String upxmlpath = uxfile.getAbsolutePath();

                        boolean[] checkin = new boolean[this.filenum];

                        for(int i = 0; i < this.filenum; i++)
                            checkin[i] = false;
                        for(int i = 1; i <= this.changenum; i++)
                        {
                            int choosetype = new Random().nextInt(this.filenum);
                            if(checkin[choosetype])
                            {
                                i--;
                                continue;
                            }
                            else
                            {
                                float size = this.sizes.get(sizess[choosetype]);
                                checkin[choosetype] = true;

                                ArrayList<Float> windlist = sp.GetWindBySecond(this.divtime);
                                ArrayList<Float> nlist = new ArrayList<Float>();
                                ArrayList<Float> cplist = new ArrayList<Float>();
                                ArrayList<Float> pwlist = new ArrayList<Float>();

                                ArrayList<Float> mtplist = new ArrayList<Float>();
                                ArrayList<Float> ewlist = new ArrayList<Float>();

                                ArrayList<Float> twlist = new ArrayList<Float>();
                                ArrayList<Float> twratelist = new ArrayList<Float>();

                                for(int j = 0; j < this.divtime; j++)
                                {
                                    float n =  (float) (windlist.get(j) / (2 * Math.PI * this.blade_length));
                                    nlist.add(n);
                                    float cp = (float) (-0.3656 * (Math.pow(1 / windlist.get(j), 2)) + 0.6505 / windlist.get(j));
                                    cplist.add(cp);
                                    float pw = (float) (0.5 * 1.2933 * Math.PI * Math.pow(this.blade_length, 2)
                                            * Math.pow(windlist.get(j), 3) * cp);
                                    pwlist.add(pw);

                                    float mtprate = (float) (new Random().nextFloat() + 9) / 10;
                                    mtplist.add(mtprate);
                                    float ew = pw * mtprate;
                                    ewlist.add(ew);

                                    //15表示交联聚乙烯绝缘电缆100KM的电阻阻值
                                    float ewtrue = ew - (ew / this.uv) * (ew / this.uv) * 15;
                                    twlist.add(ewtrue);
                                    twratelist.add(ewtrue / ew);

                                }
                                Calendar date = this.GetTimeForUpdate(choosetype);

                                MetaFileGen.BladeMetaGen(this.id, (choosetype+1), this.filepath + "/" + "updata1/metadata",
                                        air_density, tower_height, blade_width, blade_length, area_name, date, windlist,nlist,
                                        pwlist, cplist, metatype);

                                this.FileGener(updatapath, (choosetype+1), "$01", size);
                                this.pretentfilecount ++;
                                this.size += size;
                                size = size / 2;

                                MetaFileGen.Dynamo(this.id, (choosetype+1), this.filepath + "/" + "updata1/metadata",
                                        air_density, tower_height, blade_width, blade_length, area_name, date, mtplist,
                                        ewlist, metatype);
                                this.FileGener(updatapath, (choosetype+1), "$02", size);

                                this.pretentfilecount ++;
                                this.size += size;

                                MetaFileGen.TransMetaGen(this.id, (choosetype+1), this.filepath + "/" + "updata1/metadata",
                                        air_density, tower_height, blade_width, blade_length, area_name, date, twlist,
                                        twratelist, metatype);

                                this.FileGener(updatapath, (choosetype+1), "$03", size);

                                this.pretentfilecount ++;
                                this.size += size;
                            }
                        }

                        this.UseFileCount(checkin);
                    }
                }
            }
            //表示该线程需要生成多个设备
            else{
                if(!(this.changenum == 0) && !(this.filepluspar != 0)){
                    this.NewFileCount();
                }

                for(int sd = 0; sd < this.splitdevice; sd++){
                    windspeed sp = this.sps.get(sd);
                    String area_name = this.areanameList.get(sd);
                    int tower_height = this.towerheightList.get(sd);
                    int blade_length = this.bladelengthList.get(sd);
                    int blade_width = this.bladewidthList.get(sd);
                    int[] sizess = new int[this.filenum];
                    int deviceid = this.id + sd * this.threadcount;
                    for(int i = 1; i < this.sizes.size(); i++)
                    {
                        int curentnum = (int) (this.filenum * this.presents.get(i));
                        for(int j = 1; j <= curentnum; j++)
                        {
                            int rs = new Random().nextInt(this.filenum);
                            if(sizess[rs] == i)
                            {
                                j--;
                                continue;
                            }
                            else
                            {
                                sizess[rs] = i;
                            }
                        }
                    }

                    //检测当前是否为按照已有文件生成
                    if(this.changenum == 0 && this.filepluspar != 0)
                    {
                        this.SetUsedSplittime();

                        boolean[] allfile = new boolean[this.filenum];

                        if(this.filenum == this.filepluspar)
                        {
                            for(int i = 0; i < this.filenum; i++)
                                allfile[i] = true;
                        }
                        else
                        {
                            for(int i = 0; i < this.filenum; i++)
                                allfile[i] = false;
                            for(int i = 0; i < this.filepluspar; i++)
                            {
                                int random = new Random().nextInt(this.filenum);
                                if(allfile[random])
                                {
                                    i--;
                                    continue;
                                }
                                else {
                                    allfile[random] = true;
                                }
                            }
                        }

                        File sfile = new File(this.filepath + "/updata" + this.copynum + "/file");
                        sfile.mkdirs();
                        String loaddatapath = sfile.getAbsolutePath();
                        File mjfile = new File(this.filepath + "/updata" + this.copynum + "/metadata/json");
                        mjfile.mkdirs();
                        String jsondatapath = mjfile.getAbsolutePath();
                        File mxfile = new File(this.filepath + "/updata" + this.copynum + "/metadata/xml");
                        mxfile.mkdirs();
                        String xmldatapath = mxfile.getAbsolutePath();
                        File mtfile = new File(this.filepath + "/updata" + this.copynum + "/metadata/txt");
                        mtfile.mkdirs();
                        String txtdatapath = mtfile.getAbsolutePath();

                        this.UseFileCount(deviceid, allfile);

                        for(int i = 1; i <= this.filenum;i++)
                        {
                            if(!allfile[i-1])
                                continue;

                            float size = this.sizes.get(sizess[i-1]);

                            ArrayList<Float> windlist = sp.GetWindBySecond(this.divtime);
                            ArrayList<Float> nlist = new ArrayList<Float>();
                            ArrayList<Float> cplist = new ArrayList<Float>();
                            ArrayList<Float> pwlist = new ArrayList<Float>();

                            ArrayList<Float> mtplist = new ArrayList<Float>();
                            ArrayList<Float> ewlist = new ArrayList<Float>();

                            ArrayList<Float> twlist = new ArrayList<Float>();
                            ArrayList<Float> twratelist = new ArrayList<Float>();

                            for(int j = 0; j < this.divtime; j++)
                            {
                                float n =  (float) (windlist.get(j) / (2 * Math.PI * blade_length));
                                nlist.add(n);
                                float cp = (float) (-0.3656 * (Math.pow(1 / windlist.get(j), 2)) + 0.6505 / windlist.get(j));
                                cplist.add(cp);
                                float pw = (float) (0.5 * 1.2933 * Math.PI * Math.pow(blade_length, 2)
                                        * Math.pow(windlist.get(j), 3) * cp);
                                pwlist.add(pw);

                                float mtprate = (float) (new Random().nextFloat() + 9) / 10;
                                mtplist.add(mtprate);
                                float ew = pw * mtprate;
                                ewlist.add(ew);

                                //15表示交联聚乙烯绝缘电缆100KM的电阻阻值
                                float ewtrue = ew - (ew / this.uv) * (ew / this.uv) * 15;
                                twlist.add(ewtrue);
                                twratelist.add(ewtrue / ew);
                            }

                            Calendar date = this.GetTimeForUpdate(i-1);

                            MetaFileGen.BladeMetaGen(deviceid, i, this.filepath + "/updata" + this.copynum + "/metadata",
                                    air_density, tower_height, blade_width, blade_length, area_name, date, windlist,nlist,
                                    pwlist, cplist, metatype);

                            this.FileGener(loaddatapath, deviceid, i, "$01", size);
                            this.pretentfilecount ++;
                            this.size += size;
                            size = size / 2;

                            MetaFileGen.Dynamo(deviceid, i, this.filepath + "/updata" + this.copynum + "/metadata",
                                    air_density, tower_height, blade_width, blade_length, area_name, date, mtplist,
                                    ewlist, metatype);
                            this.FileGener(loaddatapath, deviceid, i, "$02", size);

                            this.pretentfilecount ++;
                            this.size += size;

                            MetaFileGen.TransMetaGen(deviceid, i, this.filepath + "/updata" + this.copynum + "/metadata",
                                    air_density, tower_height, blade_width, blade_length, area_name, date, twlist,
                                    twratelist, metatype);

                            this.FileGener(loaddatapath, deviceid, i, "$03", size);

                            this.pretentfilecount ++;
                            this.size += size;
                        }
                    }

                    else
                    {
                        MetaTxtGen txtGen = new MetaTxtGen();
                        MetaJsonGen jsonGen = new MetaJsonGen();
                        MetaXmlGen xmlGen = new MetaXmlGen();

                        this.SetSplittime();
                        File lsfile = new File(this.filepath + "/" + "loaddata/file");
                        lsfile.mkdirs();
                        String loaddatapath = lsfile.getAbsolutePath();
                        File ltfile = new File(this.filepath + "/" + "loaddata/metadata/txt");
                        ltfile.mkdirs();
                        String loadtxtpath = ltfile.getAbsolutePath();
                        File ljfile = new File(this.filepath + "/" + "loaddata/metadata/json");
                        ljfile.mkdirs();
                        String loadjsonpath = ljfile.getAbsolutePath();
                        File lxfile = new File(this.filepath + "/" + "loaddata/metadata/xml");
                        lxfile.mkdirs();
                        String loadxmlpath = lxfile.getAbsolutePath();

                        boolean first = true;
                        for(int i = 1; i <= this.filenum; i++)
                        {
                            if(first && i >= this.filenum * (1- this.unnormal)){
                                first = false;
                                float normal = sp.GetShunWind();
                                sp.SetShunWind(normal * this.unnormalfactor);
                            }
                            float size = this.sizes.get(sizess[i-1]);

                            ArrayList<Float> windlist = sp.GetWindBySecond(this.divtime);
                            ArrayList<Float> nlist = new ArrayList<Float>();
                            ArrayList<Float> cplist = new ArrayList<Float>();
                            ArrayList<Float> pwlist = new ArrayList<Float>();

                            ArrayList<Float> mtplist = new ArrayList<Float>();
                            ArrayList<Float> ewlist = new ArrayList<Float>();

                            ArrayList<Float> twlist = new ArrayList<Float>();
                            ArrayList<Float> twratelist = new ArrayList<Float>();

                            for(int j = 0; j < this.divtime; j++)
                            {
                                float n =  (float) (windlist.get(j) / (2 * Math.PI * blade_length));
                                nlist.add(n);
                                float cp = (float) (-0.3656 * (Math.pow(1 / windlist.get(j), 2)) + 0.6505 / windlist.get(j));
                                cplist.add(cp);
                                float pw = (float) (0.5 * 1.2933 * Math.PI * Math.pow(blade_length, 2)
                                        * Math.pow(windlist.get(j), 3) * cp);
                                pwlist.add(pw);

                                float mtprate = (float) (new Random().nextFloat() + 9) / 10;
                                mtplist.add(mtprate);
                                float ew = pw * mtprate;
                                ewlist.add(ew);

                                //15表示交联聚乙烯绝缘电缆100KM的电阻阻值
                                float ewtrue = ew - (ew / this.uv) * (ew / this.uv) * 15;
                                twlist.add(ewtrue);
                                twratelist.add(ewtrue / ew);
                            }
                            Calendar date = null;
                            if(i == 1)
                                date = this.dsDate;
                            else
                                date = this.GetTimeBySplittime();

                            MetaFileGen.BladeMetaGen(deviceid, i, this.filepath + "/" + "loaddata/metadata",
                                    air_density, tower_height, blade_width, blade_length, area_name, date, windlist,nlist,
                                    pwlist, cplist, metatype);

                            this.FileGener(loaddatapath, deviceid, i, "$01", size);
                            this.pretentfilecount ++;
                            this.size += size;
                            size = size / 2;

                            MetaFileGen.Dynamo(deviceid, i, this.filepath + "/" + "loaddata/metadata",
                                    air_density, tower_height, blade_width, blade_length, area_name, date, mtplist,
                                    ewlist, metatype);
                            this.FileGener(loaddatapath, deviceid, i, "$02", size);

                            this.pretentfilecount ++;
                            this.size += size;

                            MetaFileGen.TransMetaGen(deviceid, i, this.filepath + "/" + "loaddata/metadata",
                                    air_density, tower_height, blade_width, blade_length, area_name, date, twlist,
                                    twratelist, metatype);

                            this.FileGener(loaddatapath, deviceid, i, "$03", size);

                            this.pretentfilecount ++;
                            this.size += size;
                        }

                        sp.SetShunWind(sp.GetShunWind() / this.unnormalfactor);

                        if(this.changenum == 0)
                        {
                        }
                        else
                        {
                            File usfile = new File(this.filepath + "/" + "updata1/file");
                            usfile.mkdirs();
                            String updatapath = usfile.getAbsolutePath();
                            File utfile = new File(this.filepath + "/" + "updata1/metadata/txt");
                            utfile.mkdirs();
                            String uptxtpath = utfile.getAbsolutePath();
                            File ujfile = new File(this.filepath + "/" + "updata1/metadata/json");
                            ujfile.mkdirs();
                            String upjsonpath = ujfile.getAbsolutePath();
                            File uxfile = new File(this.filepath + "/" + "updata1/metadata/xml");
                            uxfile.mkdirs();
                            String upxmlpath = uxfile.getAbsolutePath();

                            boolean checkin[] = new boolean[this.filenum];
                            for(int i = 0; i < this.filenum; i++)
                                checkin[i] = false;
                            for(int i = 1; i <= this.changenum; i++)
                            {
                                int choosetype = new Random().nextInt(this.filenum);
                                if(checkin[choosetype])
                                    i--;
                                else
                                    checkin[choosetype] = true;
                            }

                            this.UseFileCount(deviceid, checkin);

                            for(int i = 0; i < this.filenum; i++){
                                if(checkin[i]){
                                    int choosetype = i;
                                    float size = this.sizes.get(sizess[choosetype]);
                                    checkin[choosetype] = true;

                                    ArrayList<Float> windlist = sp.GetWindBySecond(this.divtime);
                                    ArrayList<Float> nlist = new ArrayList<Float>();
                                    ArrayList<Float> cplist = new ArrayList<Float>();
                                    ArrayList<Float> pwlist = new ArrayList<Float>();

                                    ArrayList<Float> mtplist = new ArrayList<Float>();
                                    ArrayList<Float> ewlist = new ArrayList<Float>();

                                    ArrayList<Float> twlist = new ArrayList<Float>();
                                    ArrayList<Float> twratelist = new ArrayList<Float>();

                                    for(int j = 0; j < this.divtime; j++)
                                    {
                                        float n =  (float) (windlist.get(j) / (2 * Math.PI * blade_length));
                                        nlist.add(n);
                                        float cp = (float) (-0.3656 * (Math.pow(1 / windlist.get(j), 2)) + 0.6505 / windlist.get(j));
                                        cplist.add(cp);
                                        float pw = (float) (0.5 * 1.2933 * Math.PI * Math.pow(blade_length, 2)
                                                * Math.pow(windlist.get(j), 3) * cp);
                                        pwlist.add(pw);

                                        float mtprate = (float) (new Random().nextFloat() + 9) / 10;
                                        mtplist.add(mtprate);
                                        float ew = pw * mtprate;
                                        ewlist.add(ew);

                                        //15表示交联聚乙烯绝缘电缆100KM的电阻阻值
                                        float ewtrue = ew - (ew / this.uv) * (ew / this.uv) * 15;
                                        twlist.add(ewtrue);
                                        twratelist.add(ewtrue / ew);
                                    }
                                    Calendar date = this.GetTimeForUpdate(choosetype);

                                    MetaFileGen.BladeMetaGen(deviceid, (choosetype+1), this.filepath + "/" + "updata1/metadata",
                                            air_density, tower_height, blade_width, blade_length, area_name, date, windlist,nlist,
                                            pwlist, cplist, metatype);

                                    this.FileGener(updatapath, deviceid, (choosetype+1), "$01", size);
                                    this.pretentfilecount ++;
                                    this.size += size;
                                    size = size / 2;

                                    MetaFileGen.Dynamo(deviceid, (choosetype+1), this.filepath + "/" + "updata1/metadata",
                                            air_density, tower_height, blade_width, blade_length, area_name, date, mtplist,
                                            ewlist, metatype);
                                    this.FileGener(updatapath, deviceid, (choosetype+1), "$02", size);

                                    this.pretentfilecount ++;
                                    this.size += size;

                                    MetaFileGen.TransMetaGen(deviceid, (choosetype+1), this.filepath + "/" + "updata1/metadata",
                                            air_density, tower_height, blade_width, blade_length, area_name, date, twlist,
                                            twratelist, metatype);

                                    this.FileGener(updatapath, deviceid, (choosetype+1), "$03", size);

                                    this.pretentfilecount ++;
                                    this.size += size;
                                }
                            }
                        }
                    }
                }
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        super.run();
        System.out.println("The " + this.id + " Device is Finshed");
    }
}
