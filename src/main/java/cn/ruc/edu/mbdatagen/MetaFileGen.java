package cn.ruc.edu.mbdatagen;

import org.json.JSONException;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class MetaFileGen {

    public static float[] MMAData(List<Float> list){
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

    public static void BladeMetaGen(
            int id, int filenum, String path,
            float air, int height, int width,
            int length, String area, Calendar date,
            ArrayList<Float> windlist, ArrayList<Float> nlist,
            ArrayList<Float> pwlist, ArrayList<Float> cplist,
            int[] metatype) throws IOException, JSONException {
        if(metatype[0] == 1){
            MetaTxtGen txtGen = new MetaTxtGen();
            //生成Txt格式及文件的风扇仿真数据
            txtGen.SetFilenameInfo(id, "%01", "BLADE", filenum);
            txtGen.SetTxtFilepathAndMake(path + "/txt");
            txtGen.PutsDeviceInfo(air, height, length, width, area, date);
            float[] data = MMAData(windlist);
            txtGen.PutsListArray("WINDSPEED", windlist, data[0], data[1], data[2]);
            data = MMAData(nlist);
            txtGen.PutsListArray("BLADESPEED", nlist, data[0], data[1], data[2]);
            data = MMAData(pwlist);
            txtGen.PutsListArray("ELECTRONICPOWER", pwlist, data[0], data[1], data[2]);
            data = MMAData(cplist);
            txtGen.PutsListArray("CHANGERATE", cplist, data[0], data[1], data[2]);

            txtGen.PutsMetaFile();
        }

        if(metatype[1] == 1){
            MetaJsonGen jsonGen = new MetaJsonGen();
            //生成JSON格式
            jsonGen.SetFilenameInfo(id, "%01", "BLADE", filenum);
            jsonGen.SetJsonFilepathAndMake(path + "/json");
            jsonGen.PutsDeviceInfo(air, height, length, width, area, date);

            float[] data = MMAData(windlist);
            jsonGen.PutsListArray("WINDSPEED", windlist, data[0], data[1], data[2]);
            data = MMAData(nlist);
            jsonGen.PutsListArray("BLADESPEED", nlist, data[0], data[1], data[2]);
            data = MMAData(pwlist);
            jsonGen.PutsListArray("ELECTRONICPOWER", pwlist, data[0], data[1], data[2]);
            data = MMAData(cplist);
            jsonGen.PutsListArray("CHANGERATE", cplist, data[0], data[1], data[2]);

            jsonGen.PutsMetaFile();
        }

        if(metatype[2] == 1){
            MetaXmlGen xmlGen = new MetaXmlGen();
            //生成XML格式
            xmlGen.SetFilenameInfo(id, "%01", "BLADE", filenum);
            xmlGen.SetXmlFilepathAndMake(path+"/xml");
            xmlGen.PutsDeviceInfo(air, height, length, width, area, date);

            float[] data = MMAData(windlist);
            xmlGen.PutsListArray("WINDSPEED", windlist, data[0], data[1], data[2]);
            data = MMAData(nlist);
            xmlGen.PutsListArray("BLADESPEED", nlist, data[0], data[1], data[2]);
            data = MMAData(pwlist);
            xmlGen.PutsListArray("ELECTRONICPOWER", pwlist, data[0], data[1], data[2]);
            data = MMAData(cplist);
            xmlGen.PutsListArray("CHANGERATE", cplist, data[0], data[1], data[2]);

            xmlGen.PutsMetaFile();
            //XMLjar包的使用问题
            xmlGen.ClearMetaFile();
            xmlGen = new MetaXmlGen();
        }
    }

    public static void Dynamo(
            int id, int filenum, String path,
            float air, int height, int width,
            int length, String area, Calendar date,
            ArrayList<Float> mtplist, ArrayList<Float> ewlist,
            int[] metatype) throws IOException, JSONException {
        if(metatype[0] == 1){
            MetaTxtGen txtGen = new MetaTxtGen();
            //生成Txt格式及文件的风扇仿真数据
            txtGen.SetFilenameInfo(id, "%02", "DYNAMO", filenum);
            txtGen.SetTxtFilepathAndMake(path + "/txt");
            txtGen.PutsDeviceInfo(air, height, length, width, area, date);
            float[] data = MMAData(mtplist);
            txtGen.PutsListArray("TRANSRATE", mtplist, data[0], data[1], data[2]);
            data = MMAData(ewlist);
            txtGen.PutsListArray("ELECTRICITY", ewlist, data[0], data[1], data[2]);
            txtGen.PutsMetaFile();
        }

        if(metatype[1] == 1){
            MetaJsonGen jsonGen = new MetaJsonGen();
            //生成JSON格式
            jsonGen.SetFilenameInfo(id, "%02", "DYNAMO", filenum);
            jsonGen.SetJsonFilepathAndMake(path + "/json");
            jsonGen.PutsDeviceInfo(air, height, length, width, area, date);

            float[] data = MMAData(mtplist);
            jsonGen.PutsListArray("TRANSRATE", mtplist, data[0], data[1], data[2]);
            data = MMAData(ewlist);
            jsonGen.PutsListArray("ELECTRICITY", ewlist, data[0], data[1], data[2]);
            jsonGen.PutsMetaFile();
        }

        if(metatype[2] == 1){
            MetaXmlGen xmlGen = new MetaXmlGen();
            //生成XML格式
            xmlGen.SetFilenameInfo(id, "%02", "DYNAMO", filenum);
            xmlGen.SetXmlFilepathAndMake(path + "/xml");
            xmlGen.PutsDeviceInfo(air, height, length, width, area, date);

            float[] data = MMAData(mtplist);
            xmlGen.PutsListArray("TRANSRATE", mtplist, data[0], data[1], data[2]);
            data = MMAData(ewlist);
            xmlGen.PutsListArray("ELECTRICITY", ewlist, data[0], data[1], data[2]);
            xmlGen.PutsMetaFile();
            //XMLjar包的使用问题
            xmlGen.ClearMetaFile();
            xmlGen = new MetaXmlGen();
        }
    }

    public static void TransMetaGen(
            int id, int filenum, String path,
            float air, int height, int width,
            int length, String area, Calendar date,
            ArrayList<Float> twlist, ArrayList<Float> twratelist,
            int[] metatype) throws IOException, JSONException {

        if(metatype[0] == 1){
            MetaTxtGen txtGen = new MetaTxtGen();
            //生成Txt格式及文件的风扇仿真数据
            txtGen.SetFilenameInfo(id, "%03", "TRANSMISSION", filenum);
            txtGen.SetTxtFilepathAndMake(path + "/txt");
            txtGen.PutsDeviceInfo(air, height, length, width, area, date);

            float[] data = MMAData(twlist);
            txtGen.PutsListArray("TRANSRATE", twlist, data[0], data[1], data[2]);
            data = MMAData(twratelist);
            txtGen.PutsListArray("TRANSELECRATE", twratelist, data[0], data[1], data[2]);

            txtGen.PutsMetaFile();
        }

        if(metatype[1] == 1){
            MetaJsonGen jsonGen = new MetaJsonGen();
            //生成JSON格式
            jsonGen.SetFilenameInfo(id, "%03", "TRANSMISSION", filenum);
            jsonGen.SetJsonFilepathAndMake(path + "/json");
            jsonGen.PutsDeviceInfo(air, height, length, width, area, date);

            float[] data = MMAData(twlist);
            jsonGen.PutsListArray("TRANSRATE", twlist, data[0], data[1], data[2]);
            data = MMAData(twratelist);
            jsonGen.PutsListArray("TRANSELECRATE", twratelist, data[0], data[1], data[2]);

            jsonGen.PutsMetaFile();
        }

        if(metatype[2] == 1){
            MetaXmlGen xmlGen = new MetaXmlGen();
            //生成XML格式
            xmlGen.SetFilenameInfo(id, "%03", "TRANSMISSION", filenum);
            xmlGen.SetXmlFilepathAndMake(path + "/xml");
            xmlGen.PutsDeviceInfo(air, height, length, width, area, date);

            float[] data = MMAData(twlist);
            xmlGen.PutsListArray("TRANSRATE", twlist, data[0], data[1], data[2]);
            data = MMAData(twratelist);
            xmlGen.PutsListArray("TRANSELECRATE", twratelist, data[0], data[1], data[2]);
            xmlGen.PutsMetaFile();
            //XMLjar包的使用问题
            xmlGen.ClearMetaFile();
            xmlGen = new MetaXmlGen();
        }

    }

}
