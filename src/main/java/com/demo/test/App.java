package com.demo.test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.demo.model.Tickets;


/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args ) throws ParseException{
    	
    	StringBuffer b = new StringBuffer();
    	b.append("Mohapi");
    	b.append("Mokoena");
    	System.out.println(b);
    	/*StringBuilder b = new StringBuilder();
    	b.append("Mohapi");
    	b.append("Mokoena");
    	System.out.println(b);*/
   
    	/*String date1 = null;
    	String date2 = "2017-05-03";
    	SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
	    Date currentDate  = new Date();
	    Date secondDate = new Date();
	    Calendar cal = Calendar.getInstance();
	    date1 =  myFormat.format(cal.getTime());
	   
		try{
			
			currentDate = myFormat.parse(date1);
			secondDate = myFormat.parse(date2);
			if(currentDate.after(secondDate)){
				System.out.println("Second date cones before first date");
			}else if(currentDate.compareTo(secondDate)>=0) {
				System.out.println("Otherwise");
			}else{
				System.out.println("Otherwise got it");
			}
		}
		catch(Exception e){
			
		}*/
    }
}
