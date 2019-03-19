package com.dldata.drgs.utils;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpHost;
import org.apache.commons.httpclient.methods.GetMethod;

import java.io.*;
import java.net.URL;

/**
 * Created by 倪继文 on 2016/9/21.
 */
public class CreatePDF {

    public static void createPDFMethod(String url_jsp,String inputfile) throws HttpException, IOException {

        long time=System.currentTimeMillis();
        //"http://127.0.0.1:8082/TBZ3Mxzsxf/toPrint?brbh=2"
        URL url=new URL(url_jsp);
        HttpClient client=new HttpClient();
        HttpHost host=new HttpHost("localhost");
        client.getHostConfiguration().setHost(host);
        GetMethod method=new GetMethod(url.toString());
        try {
            client.executeMethod(method);
            //获取响应的html 文本
            String contents=method.getResponseBodyAsString();
            System.out.println(contents);
            contents=contents.replace("&nbsp;", "   ");
            contents=contents.replace("/DCC/", "");
            //int index=contents.lastIndexOf("<head>");
            //int index2=contents.lastIndexOf("<title>");

            writeHTML(contents,inputfile);
        } catch (Exception ex) {
            ex.getMessage();
        }

    }

    public static void createPDFMethodbody(String url_jsp,String inputfile,String body) throws HttpException, IOException {

        long time=System.currentTimeMillis();
        //"http://127.0.0.1:8082/TBZ3Mxzsxf/toPrint?brbh=2"
        URL url=new URL(url_jsp);
        HttpClient client=new HttpClient();
        HttpHost host=new HttpHost("localhost");
        client.getHostConfiguration().setHost(host);
        GetMethod method=new GetMethod(url.toString());
        try {
            client.executeMethod(method);
            //获取响应的html 文本
            String contents=method.getResponseBodyAsString();
            System.out.println(contents);
            //body=body.replaceAll("(\n)", "<br>");
            body=body.replace("<textarea","<textarea class='divborder' ");
            body=body.replace("textarea","div");
            body=body.replace("form-control"," form-control input-sm ");
            contents = contents.replace("<body></body>","<body>"+body+"</body>");
            contents=contents.replace("&nbsp;", "   ");
            contents=contents.replace("/DCC/", "");
            //int index=contents.lastIndexOf("<head>");
            //int index2=contents.lastIndexOf("<title>");

            writeHTML(contents,inputfile);
        } catch (Exception ex) {
            ex.getMessage();
        }

    }





    /**
     * 写文件
     * @param contents   文件字符串内容
     * @param path       写入的文件地址
     * @throws java.net.MalformedURLException
     */
    private static void writeHTML(String contents,String path) {
        try  {
            path=new File(path).toURI().toURL().toString();
            FileOutputStream fos  =   new  FileOutputStream(path.substring(path.indexOf("/")));
            OutputStreamWriter osw  =   new  OutputStreamWriter(fos,  "UTF-8" );
            osw.write(contents);
            osw.flush();
            osw.close();
            fos.close();
        }  catch  (Exception e) {
            e.printStackTrace();
        }
    }

    private static String readerHTML(String path){
        StringBuffer contents=new StringBuffer();
        try  {
            path=new File(path).toURI().toURL().toString();
            FileInputStream fis  =   new FileInputStream(path.substring(path.indexOf("/")));
            InputStreamReader isr  =   new InputStreamReader(fis,  "UTF-8" );
            BufferedReader br  =   new BufferedReader(isr);
            String line  =   null ;
            while  ((line  =  br.readLine())  !=   null ) {
                contents.append(line);
                contents.append("\r\n ");  //  补上换行符
            }
        }  catch  (Exception e) {
            e.printStackTrace();
        }
        return contents.toString();
    }


}
