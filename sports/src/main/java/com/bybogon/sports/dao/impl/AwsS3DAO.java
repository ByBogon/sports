package com.bybogon.sports.dao.impl;

import java.io.ByteArrayOutputStream;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public interface AwsS3DAO {
	public void deleteFile(String bucketName, String keyName);
	public void uploadFile(MultipartFile uploadFile, String keyName);
	public ByteArrayOutputStream downloadFile(String keyName);
	public List<String> listFiles();
}
