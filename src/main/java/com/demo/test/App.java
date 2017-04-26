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
   
    	SimpleDateFormat dateFormat = null;
    	Calendar cal = Calendar.getInstance();
		dateFormat = new SimpleDateFormat("yyyyMMdd HHmmss");
		String currentDate =  dateFormat.format(cal.getTime());
		
		System.out.println(currentDate);
    }

}
		    

