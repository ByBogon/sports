package com.bybogon.sports.controller.ajax;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bybogon.sports.dao.impl.AwsS3DAOImpl;

@Controller
public class AjaxFileController {
	
	@Autowired
	private AwsS3DAOImpl s3DAO;
	
	@Value("${aws_namecard_bucket}")
	private String bucketName;
	
	@RequestMapping(value="/ajaxFileIntoS3.do", method = RequestMethod.POST)
	public @ResponseBody String fileUpload(
			@RequestParam("file") MultipartFile uploadFile,
			HttpSession session
			) throws IOException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		String date = sdf.format(new Date());
		System.out.println(date);
		String id = (String) session.getAttribute("SID");
		String originName = uploadFile.getOriginalFilename();
		String extension = originName.substring(originName.indexOf("."));
		String keyName = id+"/"+id+"_"+date+extension; 
		// S3 는 하위 디렉토리 개념이 아니라 /를 통한 key들을 읽음
		// 그래서 /를 붙이면 s3 console 에서 볼때 folder가 만들어짐
		// 폴더가 실제 트리구조의 하위 디렉토리가 아니라 key 값으로 읽음

		s3DAO.uploadFile(uploadFile, keyName);
		String S3ImgUrl = bucketName+"/"+keyName;
		System.out.println(S3ImgUrl);
		return S3ImgUrl;
	}
	
	@RequestMapping(value="/ajaxFileDownFromS3.do", method = RequestMethod.POST)
	public ResponseEntity<byte[]> downloadFile(
			@PathVariable String keyname) {
		ByteArrayOutputStream downloadInputStream = s3DAO.downloadFile(keyname);
	
		return ResponseEntity.ok()
					.contentType(contentType(keyname))
					.header(HttpHeaders.CONTENT_DISPOSITION,"attachment; filename=\"" + keyname + "\"")
					.body(downloadInputStream.toByteArray());	
	}
	
	private MediaType contentType(String keyname) {
		String[] arr = keyname.split("\\.");
		String type = arr[arr.length-1];
		if(type.equals("txt")) {
			return MediaType.TEXT_PLAIN;
		} else if(type.equals("png")) {
			return MediaType.IMAGE_PNG;
		} else if (type.equals("jpg")) {
			return MediaType.IMAGE_JPEG;
		} else {
			return MediaType.APPLICATION_OCTET_STREAM;
		}
	}

	/*
	 * List ALL Files
	 */
	/*
	 * @GetMapping("/api/file/all")
	public List<String> listAllFiles(){
		return s3Services.listFiles();
	}
	*/
}
