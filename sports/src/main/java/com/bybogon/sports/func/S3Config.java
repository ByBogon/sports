package com.bybogon.sports.func;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.elasticmapreduce.model.Application;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

@Configuration
@ComponentScan(basePackageClasses = Application.class,
	excludeFilters = @Filter({Controller.class, Configuration.class}))
public class S3Config {

   @Value("${aws_access_key_id}")
   private String awsId;
	
   @Value("${aws_secret_access_key}")
   private String awsKey;
   
   @Value("${aws_s3_region}")
   private String region;
	
   @Bean
   public static PropertyPlaceholderConfigurer propertyPlaceholderConfigurer() {
	PropertyPlaceholderConfigurer ppc = new PropertyPlaceholderConfigurer();
	ppc.setLocations(new Resource[] {
		new ClassPathResource("/amazon.properties")
        });
	return ppc;
   }
	
   @Bean
   public AmazonS3 s3client() {
	   final BasicAWSCredentials awsCreds = new BasicAWSCredentials(awsId, awsKey);
	   AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
			   					.withRegion(Regions.fromName(region))
			   					.withCredentials(new AWSCredentialsProvider() {
									@Override
									public void refresh() {
										// TODO Auto-generated method stub
									}
									@Override
									public AWSCredentials getCredentials() {
										// TODO Auto-generated method stub
										return awsCreds;
									}
								})
			   					.build();
	   return s3Client;
   }
}