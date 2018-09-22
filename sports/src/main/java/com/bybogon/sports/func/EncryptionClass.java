package com.bybogon.sports.func;

import java.security.MessageDigest;

public class EncryptionClass {
	//asdf  => kjrekjre#$$#F$E%#53%#
		public static String convertMD5(String str) {
			try {
				MessageDigest md = MessageDigest.getInstance("MD5");
				md.update(str.getBytes());
				byte[] bd =  md.digest();
				StringBuffer sb = new StringBuffer();
				for(int i=0; i<bd.length; i++) {
					String tmp 
						= Integer.toString( (bd[i]&0xff) + 0x100, 16).substring(1);
					sb.append(tmp);
				}
				return sb.toString();
			}
			catch(Exception e) {
				System.out.println(e.getMessage());
				return null;
			}
		}
		
		public String convertSHA1(   ) {
		
			return null;
		}

}
