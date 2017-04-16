package com.demo.test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
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
   
    	  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
          Date date1 = sdf.parse("2009-12-31");
          Date date2 = sdf.parse("2010-01-31");
          Date date = new Date();

          System.out.println("date1 : " + sdf.format(date1));
          System.out.println("date2 : " + sdf.format(date2));

          if (date1.compareTo(date2) > 0) {
              System.out.println("Date1 is after Date2");
          }
          else if (date1.compareTo(date2) < 0) {
        	  
              System.out.println("Date1 is before Date2");
          } else if (date1.compareTo(date2) == 0) {
              System.out.println("Date1 is equal to Date2");
          } else {
              System.out.println("How to get here?");
          }
          Date currentDate  = new Date();
          System.out.println(sdf.format(currentDate));
    }

}
		    

