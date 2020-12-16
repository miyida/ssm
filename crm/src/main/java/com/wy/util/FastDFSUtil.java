package com.wy.util;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.csource.common.MyException;
import org.csource.common.NameValuePair;
import org.csource.fastdfs.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

public class FastDFSUtil {

	private static Logger logger = LogManager.getLogger(FastDFSUtil.class);

	public static final String PROTOCOL = "http://192.168.5.100:8888/";
	public static final String SEPARATOR = "/";
	public static final String CLIENT_CONFIG_FILE = "conf/fdfs_client.properties";
	
	private static TrackerClient trackerClient;
	private static TrackerServer trackerServer;
	private static StorageServer storageServer;
	private static StorageClient storageClient;
    private static StorageClient1 storageClient1;

    static { // Initialize Fast DFS Client configurations
		try {
			String classPath =  FastDFSUtil.class.getResource("/").getPath();
			String fdfsClientConfigFilePath = classPath + CLIENT_CONFIG_FILE;
			logger.info("Fast DFS configuration file path:" + fdfsClientConfigFilePath);
			ClientGlobal.init(fdfsClientConfigFilePath);
			trackerClient = new TrackerClient();
			storageClient = new StorageClient(trackerServer, storageServer);
			storageClient1 = new StorageClient1(trackerServer, storageServer);
		} catch (Exception e) {
			logger.error(logger, e);
		}
	}
    
    /**
     * 上传文件或者图片
     * @param file
     * @return url  文件或者原图地址 
     * @throws Exception
     */
    public static String uploadOriginalFile(MultipartFile file) throws Exception{
    	String url = "";
    	//随机生成文件名
    	String filename = RandomStringUtils.random(16, true, true) + System.currentTimeMillis();
    	//文件类型
    	String fileType = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")+1); 
		// 设置元信息
        NameValuePair[] metaListOldPic = new NameValuePair[3];
        metaListOldPic[0] = new NameValuePair("fileName", filename);
        metaListOldPic[1] = new NameValuePair("fileExtName", fileType); // 后缀名
        metaListOldPic[2] = new NameValuePair("fileLength", String.valueOf(file.getBytes().length)); // 文件大小
		url = storageClient1.upload_file1(file.getBytes(),fileType, metaListOldPic);
    	return PROTOCOL+url;
    }
    
    public static void main(String[] args) throws IOException, MyException {
    	
    	File file = new File("C:\\Users\\JavaSM\\Desktop\\a.jpg");
    	// 读取File文件
    	FileInputStream fis = new FileInputStream(file);
    	String url = "";
    	//随机生成文件名
    	String filename = RandomStringUtils.random(16, true, true) + System.currentTimeMillis();
    	//文件类型
    	String fileType = "jpg"; 
		// 设置元信息
        NameValuePair[] metaListOldPic = new NameValuePair[3];
        metaListOldPic[0] = new NameValuePair("fileName", filename);
        metaListOldPic[1] = new NameValuePair("fileExtName", fileType); // 后缀名
        metaListOldPic[2] = new NameValuePair("fileLength", String.valueOf(file.length())); // 文件大小
        byte[] by = new byte[(int)file.length()];
        fis.read(by);
        url = storageClient1.upload_file1(by,fileType, metaListOldPic);
        System.out.println(url);
        System.out.println(PROTOCOL+url);
	}
   
	/**
	 * 删除文件
	 * @param groupName
	 * @param remoteFileName
	 * @throws Exception
	 */
	public static void deleteFile(String groupName, String remoteFileName)
			throws Exception {
		storageClient.delete_file(groupName, remoteFileName);
	}
	
}
