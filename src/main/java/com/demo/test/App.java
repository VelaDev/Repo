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
   
    	 String daysAsTime = "";
         String datePrev = "2017:04:26 01:22:01";
        long day = 0, diff = 0;
        String outputPattern = "yyyy:MM:dd HH:mm:ss";
        SimpleDateFormat outputFormat = new SimpleDateFormat(outputPattern);
        Calendar c = Calendar.getInstance();
        String dateCurrent = outputFormat.format(c.getTime());
        try {
           Date  date1 = outputFormat.parse(datePrev);
            Date date2 = outputFormat.parse(dateCurrent);
            diff = date2.getTime() - date1.getTime();
            day = TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
           
              long hour = TimeUnit.HOURS.convert(diff, TimeUnit.MILLISECONDS);
              System.out.println("Hour" + hour);
             
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

}
		    

