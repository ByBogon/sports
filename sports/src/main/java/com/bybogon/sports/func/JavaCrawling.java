package com.bybogon.sports.func;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class JavaCrawling {
	public static void main(String[] args) throws Exception{
		System.out.println("START");
		//for(int i = 1; i <= 19; i++) {
			//String URL = "http://koreasquash.or.kr/_guide-club.asp?sido=&page="+i;
			String URL = "http://map.squash.pe.kr/bbs/board.php?bo_table=KoreaSquashCourt";
	        Document doc = Jsoup.connect(URL).get();
	        Elements elem = doc.select("tbody");
	        String str = elem.text();
	        System.out.println(str);
		//}
		System.out.println("END");
        
    }
}
